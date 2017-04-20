From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: increase the pad I/O drive
 strength for DDR50 card
Date: Thu, 20 Apr 2017 16:05:40 +0200
Message-ID: <CAPDyKFqPhtKHRrY6kG4Qw6m4R3kS5ThigkOZH+RZhp=xg3koeA@mail.gmail.com>
References: <1492570431-5532-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:36141 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S946247AbdDTOFr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Apr 2017 10:05:47 -0400
Received: by mail-ua0-f173.google.com with SMTP id a1so51810489uaf.3
        for <linux-mmc@vger.kernel.org>; Thu, 20 Apr 2017 07:05:47 -0700 (PDT)
In-Reply-To: <1492570431-5532-1-git-send-email-haibo.chen@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Aisheng Dong <aisheng.dong@nxp.com>, Tim Harvey <tharvey@gateworks.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "# 4.0+" <stable@vger.kernel.org>

On 19 April 2017 at 04:53, Haibo Chen <haibo.chen@nxp.com> wrote:
> Currently for DDR50 card, it need tuning in default. We meet tuning fail
> issue for DDR50 card and some data CRC error when DDR50 sd card works.
>
> This is because the default pad I/O drive strength can't make sure DDR50
> card work stable. So increase the pad I/O drive strength for DDR50 card,
> and use pins_100mhz.
>
> This fixes DDR50 card support for IMX since DDR50 tuning was enabled from
> commit 9faac7b95ea4 ("mmc: sdhci: enable tuning for DDR50")
>
> Tested-and-reported-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Cc: stable@vger.kernel.org # v4.4+
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index cf666a0..abad67a 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -830,6 +830,7 @@ static int esdhc_change_pinstate(struct sdhci_host *host,
>
>         switch (uhs) {
>         case MMC_TIMING_UHS_SDR50:
> +       case MMC_TIMING_UHS_DDR50:
>                 pinctrl = imx_data->pins_100mhz;
>                 break;
>         case MMC_TIMING_UHS_SDR104:
> --
> 1.9.1
>
