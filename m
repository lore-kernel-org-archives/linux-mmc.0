From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pxav3: dt: Support "broken-cd"/"wp-inverted" properties
Date: Tue, 11 Sep 2012 22:29:48 +0800
Message-ID: <CAN1soZzebpiQB_7HW80xnqEqqVJumiDxPQ3jqx_8ezBRMr6TZg@mail.gmail.com>
References: <87mx0zzyin.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:60252 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754828Ab2IKO3t (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Sep 2012 10:29:49 -0400
Received: by wibhi8 with SMTP id hi8so3872239wib.1
        for <linux-mmc@vger.kernel.org>; Tue, 11 Sep 2012 07:29:48 -0700 (PDT)
In-Reply-To: <87mx0zzyin.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>

On Sun, Sep 9, 2012 at 11:05 AM, Chris Ball <cjb@laptop.org> wrote:
> Signed-off-by: Chris Ball <cjb@laptop.org>
> ---
>  drivers/mmc/host/sdhci-pxav3.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index a553b18..8a9b367 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -198,6 +198,12 @@ static struct sdhci_pxa_platdata *pxav3_get_mmc_pdata(struct device *dev)
>         if (clk_delay_cycles > 0)
>                 pdata->clk_delay_cycles = clk_delay_cycles;
>
> +       if (of_find_property(np, "broken-cd", NULL))
> +               pdata->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> +
> +       if (of_find_property(np, "wp-inverted", NULL))
> +               pdata->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
> +
>         return pdata;
>  }
>  #else
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
