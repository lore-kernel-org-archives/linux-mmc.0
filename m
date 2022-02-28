Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23E1C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Feb 2022 16:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiB1QRk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Feb 2022 11:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237551AbiB1QRj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Feb 2022 11:17:39 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038F085677
        for <linux-mmc@vger.kernel.org>; Mon, 28 Feb 2022 08:16:59 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m14so22249100lfu.4
        for <linux-mmc@vger.kernel.org>; Mon, 28 Feb 2022 08:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IRc/v5RBhjywblCaCu+qbO7MMR+S4MDqe0h9NB7l5U4=;
        b=qlvqPJLnwrw7v4sX5xzvIhieHQlASu2+KK8v/TE0ycWHA4g0hKZzF8AQIhmfPdWZ/X
         Jzr3qYL9R8XGmXmWplbuJrwDXWVI39bTF4/Ce2BAMfG22MYlXnGFR/PrcgwIwPvcrN4k
         nJ+HtLG6CeWccZEuOFd6WJ+ivGt0OKv4OUwjF2YB6CP2JpHE3nsVaJw9E01q3G39bD11
         r3P0oixp2Bf7o+l6g7li6dfpheKa9NQMGZiiA3u1DC6S3V01K6hFVAgYO5YM7TXu8jnj
         2Z/jwMgHEenqSLB5EzjYBm0EiVJrKCU4OgTSGnmmwqmPdNAOHT6Rk8ivhmSmkytAsIte
         AsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IRc/v5RBhjywblCaCu+qbO7MMR+S4MDqe0h9NB7l5U4=;
        b=PcNai5xOTzA+47awHZhY+FhMZU/4Dh2doIYbamhUrAjfcN8EHneMLan6kvSolaQRL6
         G8pwoQOBEB51IJJ8OzPSUy5m+QK+Se+dZM0bf6xwcNVODI/1K08KDXbbk7XNAC8syW6x
         sYQCzBR+N0qLMwNIW+f5DZSqC7w+3XfyrtotSUaIUPGZml3HCKCNTo7NAV0ydSCPGPdg
         Z0rJt8vawkyO4jxyxb+f3Kd7+QKWo6W8bwa33giN9h4i5nVKv/NtUpJGfS/N9wyrQzBS
         KOOo7744AFzSNsgogih+9BQAWcdLSrsObCfOJG71HqOilXNqvCvQ9T4dzIdrWs5LP/Mx
         fe5g==
X-Gm-Message-State: AOAM531ELnAWCMcGdSmPXH6+5KOU+0Zec+g+Lw97IBRYzYnAltjfJY2k
        0F5xZpmw+FgYpnsBEWYEHmo6tQJL8StTQC0X1D5zMw==
X-Google-Smtp-Source: ABdhPJxSQGBBJL92fuhW6DLKJM3Nt6JMGwDv/3OLpLHw0RkJjKg+R2Fli+O5NmMNwoO2Z7eoGqDHcs7xf0MY7TG70Vc=
X-Received: by 2002:ac2:5de4:0:b0:443:5b80:d4c4 with SMTP id
 z4-20020ac25de4000000b004435b80d4c4mr13014007lfq.373.1646065016130; Mon, 28
 Feb 2022 08:16:56 -0800 (PST)
MIME-Version: 1.0
References: <20220224095517.30872-1-jslaby@suse.cz> <20220224095558.30929-1-jslaby@suse.cz>
 <20220224095558.30929-4-jslaby@suse.cz>
In-Reply-To: <20220224095558.30929-4-jslaby@suse.cz>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Feb 2022 17:16:20 +0100
Message-ID: <CAPDyKFqHLQ8YTc3wzaFOdAA7Ay9RBEfdQC5uN574=oMavi6iCQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] sdio_uart: make use of UART_LCR_WLEN() + tty_get_char_size()
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 24 Feb 2022 at 10:56, Jiri Slaby <jslaby@suse.cz> wrote:
>
> Having a generic UART_LCR_WLEN() macro and the tty_get_char_size()
> helper, we can remove all those repeated switch-cases in drivers.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/mmc/core/sdio_uart.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
> index 04c0823e0359..e6eb5bd6e440 100644
> --- a/drivers/mmc/core/sdio_uart.c
> +++ b/drivers/mmc/core/sdio_uart.c
> @@ -250,21 +250,7 @@ static void sdio_uart_change_speed(struct sdio_uart_port *port,
>         unsigned char cval, fcr = 0;
>         unsigned int baud, quot;
>
> -       switch (termios->c_cflag & CSIZE) {
> -       case CS5:
> -               cval = UART_LCR_WLEN5;
> -               break;
> -       case CS6:
> -               cval = UART_LCR_WLEN6;
> -               break;
> -       case CS7:
> -               cval = UART_LCR_WLEN7;
> -               break;
> -       default:
> -       case CS8:
> -               cval = UART_LCR_WLEN8;
> -               break;
> -       }
> +       cval = UART_LCR_WLEN(tty_get_char_size(termios->c_cflag));
>
>         if (termios->c_cflag & CSTOPB)
>                 cval |= UART_LCR_STOP;
> --
> 2.35.1
>
