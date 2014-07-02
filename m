From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: avoid double-delay while transitioning to 1.8V
Date: Wed, 2 Jul 2014 11:06:58 +0200
Message-ID: <CAPDyKFor33wzw1+QjHTT4-zikMvXBtkEZrCF-YRnDMYQ8D+WTg@mail.gmail.com>
References: <E1X0Azw-0003rY-4v@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:42242 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbaGBJG7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Jul 2014 05:06:59 -0400
Received: by mail-qc0-f179.google.com with SMTP id x3so9432251qcv.24
        for <linux-mmc@vger.kernel.org>; Wed, 02 Jul 2014 02:06:58 -0700 (PDT)
In-Reply-To: <E1X0Azw-0003rY-4v@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 26 June 2014 16:50, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> The MMC core in mmc_set_signal_voltage() already provides for the delay
> required to switch to 1.8V, so there is no need for drivers to perform
> this wait themselves.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks! Applied for next.

Kind regards
Uffe

> ---
> This patch was missed from the previous set because v2 was never sent.
>
>  drivers/mmc/host/sdhci.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index d558f70756b0..3c8b91d3a793 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1762,9 +1762,6 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
>                 ctrl |= SDHCI_CTRL_VDD_180;
>                 sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>
> -               /* Wait for 5ms */
> -               usleep_range(5000, 5500);
> -
>                 /* 1.8V regulator output should be stable within 5 ms */
>                 ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>                 if (ctrl & SDHCI_CTRL_VDD_180)
> --
> 1.8.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
