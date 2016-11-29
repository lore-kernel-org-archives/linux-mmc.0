From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 6/8] mmc: sdio_uart: remove meaningless BUG_ON
Date: Tue, 29 Nov 2016 13:41:26 +0100
Message-ID: <CAPDyKFqaQ+jAC22+r8zUXRdNOWGxn28PS2jesKvmyFv8wEb+1A@mail.gmail.com>
References: <1478071440-12689-1-git-send-email-shawn.lin@rock-chips.com> <1478071585-12898-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36481 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755684AbcK2Ml2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2016 07:41:28 -0500
Received: by mail-wm0-f44.google.com with SMTP id g23so236408666wme.1
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2016 04:41:28 -0800 (PST)
In-Reply-To: <1478071585-12898-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 2 November 2016 at 08:26, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> The code seems quite simple to maintain the sdio_uart_table,
> and the insert/remove port from the table are symmetric. If
> the BUG_ON occurs, which means serial_core modify the index
> or mess up the port sequence anyway.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next!

Kind regards
Uffe


> ---
>
>  drivers/mmc/card/sdio_uart.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/card/sdio_uart.c b/drivers/mmc/card/sdio_uart.c
> index 5af6fb9..491c187 100644
> --- a/drivers/mmc/card/sdio_uart.c
> +++ b/drivers/mmc/card/sdio_uart.c
> @@ -135,8 +135,6 @@ static void sdio_uart_port_remove(struct sdio_uart_port *port)
>  {
>         struct sdio_func *func;
>
> -       BUG_ON(sdio_uart_table[port->index] != port);
> -
>         spin_lock(&sdio_uart_table_lock);
>         sdio_uart_table[port->index] = NULL;
>         spin_unlock(&sdio_uart_table_lock);
> --
> 2.3.7
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
