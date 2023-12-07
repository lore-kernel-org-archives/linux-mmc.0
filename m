Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pmBbeQeQ"
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741D610E4
	for <linux-mmc@vger.kernel.org>; Thu,  7 Dec 2023 06:10:36 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5d400779f16so5667967b3.0
        for <linux-mmc@vger.kernel.org>; Thu, 07 Dec 2023 06:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701958235; x=1702563035; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C9Zr1lxn7M1SInBXMGZc1ouIdlCKnl4G9VpDrWHLnf4=;
        b=pmBbeQeQ/holZZ3uciYzg+5xT5aUO+5iKadc2PuzBPNJmvzAZrD8Wde1yvqaXNQWvw
         UXfdgGGF9fm1oaKF2V+s5yrZBuT8h84ogTq1fOZr1UyvEY8hD0B0wXjE28Dfqtw9To9R
         /PqLJ1yzEMCO9xb+tJ/SYdx90/ZoSiCD5unOck0LWGihz3r4ROckVbq31hyTN8nK/UcW
         VIQB9EJVSGatGZxg7gHy6LjEvUMNfYI2YY4LSp4oG+FkNN4ViH1Qd/VABzlK1swb0n/d
         K+ZfeLlfMDZw5KsZq7wfJjQcpkI9+QLF+h0f8xqYOWRB+v1ZWCbM0HiVts0IeDTe45WP
         ZtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701958235; x=1702563035;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9Zr1lxn7M1SInBXMGZc1ouIdlCKnl4G9VpDrWHLnf4=;
        b=BeV88fyrWG/9s7caLdKXQYGlhX+qUZk5a2RhGSjZv/JEZWTySCWWlGEd70TXGDAit0
         aOpCuNdI6Tq5haKSdbLSG0Fmb6AgB5EDWs9J7W6qVHDh3Qj3NUMbd+gIBP6dJSmvlRGz
         5FTrbXba3aqVADlvoc0UgSAZYXCzZuNh/GpCxBZh47MY97uBJYhbeci3vmZ/8/NHImNl
         YOSRTaY7gWoHgylaDmmtcKOKje0/i20bmqoaCIoo66HCfpcZpnF22ggVtyu4sruBhPKw
         Lnbso3k4bqbZYZ38Z1PZOrVnjNeJDqdV1fLhr3Oh5SlAWLP5M76Wm5nSqdtGRRfRoDj5
         wvgg==
X-Gm-Message-State: AOJu0YzgovdvLfQDxyYm3cHMjtc06kh5AoFSBsdaOXegSxIumfEl3Kqv
	GQWpO55EuvsJ407Orj1vEy3eEHYO4StzGNbGwWdeG6f0yx+f/8ah+Ds=
X-Google-Smtp-Source: AGHT+IHf1W1Az/Iq0LuQz1PXThIlN6eoFhR0ENEkEWnNeuVQAv+JdCV0rCG740B/wfLWiFNoQypG1DorADf5xJrdSHI=
X-Received: by 2002:a81:8385:0:b0:5d8:212:8483 with SMTP id
 t127-20020a818385000000b005d802128483mr2006878ywf.20.1701958235525; Thu, 07
 Dec 2023 06:10:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206073712.17776-1-jirislaby@kernel.org> <20231206073712.17776-3-jirislaby@kernel.org>
In-Reply-To: <20231206073712.17776-3-jirislaby@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 7 Dec 2023 15:09:59 +0100
Message-ID: <CAPDyKFqV+TqW9eWkgGsLUp68DdTFrAhgp1H0Mwc6vuV4Bw0Mnw@mail.gmail.com>
Subject: Re: [PATCH 02/27] tty: mmc: sdio_uart: switch sdio_in() to return u8
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Dec 2023 at 08:37, Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
>
> sdio_in() returns a value returned from sdio_readb(). The latter returns
> u8. So should the former. Therefore, switch sdio_in() return type to u8
> and all its callers too.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/mmc/core/sdio_uart.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
> index ef38dcd3a887..a05322f15771 100644
> --- a/drivers/mmc/core/sdio_uart.c
> +++ b/drivers/mmc/core/sdio_uart.c
> @@ -178,11 +178,9 @@ static inline void sdio_uart_release_func(struct sdio_uart_port *port)
>                 sdio_release_host(port->func);
>  }
>
> -static inline unsigned int sdio_in(struct sdio_uart_port *port, int offset)
> +static inline u8 sdio_in(struct sdio_uart_port *port, int offset)
>  {
> -       unsigned char c;
> -       c = sdio_readb(port->func, port->regs_offset + offset, NULL);
> -       return c;
> +       return sdio_readb(port->func, port->regs_offset + offset, NULL);
>  }
>
>  static inline void sdio_out(struct sdio_uart_port *port, int offset, int value)
> @@ -192,8 +190,8 @@ static inline void sdio_out(struct sdio_uart_port *port, int offset, int value)
>
>  static unsigned int sdio_uart_get_mctrl(struct sdio_uart_port *port)
>  {
> -       unsigned char status;
>         unsigned int ret;
> +       u8 status;
>
>         /* FIXME: What stops this losing the delta bits and breaking
>            sdio_uart_check_modem_status ? */
> @@ -354,14 +352,13 @@ static void sdio_uart_stop_rx(struct sdio_uart_port *port)
>         sdio_out(port, UART_IER, port->ier);
>  }
>
> -static void sdio_uart_receive_chars(struct sdio_uart_port *port,
> -                                   unsigned int *status)
> +static void sdio_uart_receive_chars(struct sdio_uart_port *port, u8 *status)
>  {
> -       unsigned int ch, flag;
> +       unsigned int flag;
>         int max_count = 256;
>
>         do {
> -               ch = sdio_in(port, UART_RX);
> +               u8 ch = sdio_in(port, UART_RX);
>                 flag = TTY_NORMAL;
>                 port->icount.rx++;
>
> @@ -449,8 +446,8 @@ static void sdio_uart_transmit_chars(struct sdio_uart_port *port)
>
>  static void sdio_uart_check_modem_status(struct sdio_uart_port *port)
>  {
> -       int status;
>         struct tty_struct *tty;
> +       u8 status;
>
>         status = sdio_in(port, UART_MSR);
>
> @@ -499,7 +496,7 @@ static void sdio_uart_check_modem_status(struct sdio_uart_port *port)
>  static void sdio_uart_irq(struct sdio_func *func)
>  {
>         struct sdio_uart_port *port = sdio_get_drvdata(func);
> -       unsigned int iir, lsr;
> +       u8 iir, lsr;
>
>         /*
>          * In a few places sdio_uart_irq() is called directly instead of
> --
> 2.43.0
>
