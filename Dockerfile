# Stage 1: Build stage
FROM odoo:17 AS builder

# Set the user to root to install dependencies
USER root

# Easier for debugging
RUN apt update

# Install necessary system packages
RUN apt install -y git \
      telnet \
      wget \
      unzip \
      xfonts-utils \
      xfonts-75dpi \
      fonts-noto-cjk \
      fonts-noto-cjk-extra \
      locales

# Install Fonts and configure locales
RUN fc-cache -f -v && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

# Stage 2: Final stage
FROM odoo:17

# Set the user to root to install dependencies
USER root

# Copy files from the builder stage
COPY --from=builder /usr/local/lib/python3* /usr/local/lib/
COPY --from=builder /usr/share/fonts /usr/share/fonts
COPY --from=builder /usr/lib/locale /usr/lib/locale
COPY --from=builder /usr/lib/x86_64-linux-gnu /usr/lib/x86_64-linux-gnu

# Switch back to the default odoo user
USER odoo

EXPOSE 8069 8071 8072
