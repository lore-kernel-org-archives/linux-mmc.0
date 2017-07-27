From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-xenon: ignore timing DDR52 in tuning
Date: Thu, 27 Jul 2017 16:49:10 +0200
Message-ID: <CAPDyKFqk25duQyEkWegA2BQ=zbj_QcazSEmLKgquLk=kV-q+uw@mail.gmail.com>
References: <1500661858-17610-1-git-send-email-zjwu@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:36708 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751855AbdG0OtL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Jul 2017 10:49:11 -0400
Received: by mail-qt0-f175.google.com with SMTP id v29so43683384qtv.3
        for <linux-mmc@vger.kernel.org>; Thu, 27 Jul 2017 07:49:11 -0700 (PDT)
In-Reply-To: <1500661858-17610-1-git-send-email-zjwu@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhoujie Wu <zjwu@marvell.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Wilson Ding <dingwei@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, hongd@marvell.com, Doug Jones <dougj@marvell.com>, Ryan Gao <ygao@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On 21 July 2017 at 20:30, Zhoujie Wu <zjwu@marvell.com> wrote:
> Emmc DDR52 mode uses fixed delay, return earlier if
> timing is MMC_TIMING_MMC_DDR52 in execute tuning function.
>
> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-xenon.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index 6ef33aa..edd4d915 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -311,7 +311,8 @@ static int xenon_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
>         struct sdhci_host *host = mmc_priv(mmc);
>
> -       if (host->timing == MMC_TIMING_UHS_DDR50)
> +       if (host->timing == MMC_TIMING_UHS_DDR50 ||
> +               host->timing == MMC_TIMING_MMC_DDR52)
>                 return 0;
>
>         /*
> --
> 1.9.1
>
