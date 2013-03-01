From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH] mmc: sdhci: update card present check code
Date: Fri, 1 Mar 2013 17:44:35 +0800
Message-ID: <CADz5_gKTScDWqd2k1bH-chZBT82q0w-uEPdkWbXa1HrH=SmU2g@mail.gmail.com>
References: <1362044177-12735-1-git-send-email-kliu5@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:56029 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab3CAJog (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Mar 2013 04:44:36 -0500
Received: by mail-ob0-f172.google.com with SMTP id tb18so706344obb.3
        for <linux-mmc@vger.kernel.org>; Fri, 01 Mar 2013 01:44:35 -0800 (PST)
In-Reply-To: <1362044177-12735-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <kliu5@marvell.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>, Stephen Warren <swarren@wwwdotorg.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>

2013/2/28 Kevin Liu <kliu5@marvell.com>:
> 1. If quirk SDHCI_QUIRK_BROKEN_CARD_DETECTION is selected, there is no
> card detection available and polling must be used. Gpio detect must
> _not_ be supported under this case.
> Change the sequence to check SDHCI_QUIRK_BROKEN_CARD_DETECTION first,
> which make code more clear.
> 2. nonremovable card should be also assumed always present.
>
> Signed-off-by: Kevin Liu <kliu5@marvell.com>
> ---
>  drivers/mmc/host/sdhci.c |   27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c94fd6c..c0c48dd 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1337,19 +1337,20 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>
>         host->mrq = mrq;
>
> -       /*
> -        * Firstly check card presence from cd-gpio.  The return could
> -        * be one of the following possibilities:
> -        *     negative: cd-gpio is not available
> -        *     zero: cd-gpio is used, and card is removed
> -        *     one: cd-gpio is used, and card is present
> -        */
> -       present = mmc_gpio_get_cd(host->mmc);
> -       if (present < 0) {
> -               /* If polling, assume that the card is always present. */
> -               if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
> -                       present = 1;
> -               else
> +       /* If polling/nonremovable, assume that the card is always present. */
> +       if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
> +                       (host->mmc->caps & MMC_CAP_NONREMOVABLE)) {
> +               present = 1;
> +       } else {
> +               /*
> +                * Firstly check card presence from cd-gpio.  The return could
> +                * be one of the following possibilities:
> +                *     negative: cd-gpio is not available
> +                *     zero: cd-gpio is used, and card is removed
> +                *     one: cd-gpio is used, and card is present
> +                */
> +               present = mmc_gpio_get_cd(host->mmc);
> +               if (IS_ERR_VALUE(present))
>                         present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
>                                         SDHCI_CARD_PRESENT;
>         }

I submitted below patch to replace this one so please ignore this patch.
[PATCH v2] mmc: sdhci: update check code for cd-broken or nonremovable card
