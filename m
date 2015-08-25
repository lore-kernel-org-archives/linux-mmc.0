From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: host: use of_property_read_bool()
Date: Tue, 25 Aug 2015 14:05:25 +0200
Message-ID: <CAPDyKFrBoa6Jdg6qpYV2UXKgm11q-CQu33j0JCnFkXOsURhtYg@mail.gmail.com>
References: <3376063.1JTtbbjJ3D@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33509 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248AbbHYMF0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2015 08:05:26 -0400
Received: by igfj19 with SMTP id j19so9447961igf.0
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2015 05:05:25 -0700 (PDT)
In-Reply-To: <3376063.1JTtbbjJ3D@wasted.cogentembedded.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 7 August 2015 at 00:06, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Use more compact of_property_read_bool() calls instead of the of_find_property()
> calls.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks, applied for next!

Next, time please run checkpatch to remove errors/warnings.

Kind regards
Uffe

>
> ---
> The patch is against Ulf Hansson's 'mmc.git' repo's 'next' branch.
>
> Changes in version 2:
> - fixed the function name in the summary.
>
>  drivers/mmc/core/host.c |   42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
>
> Index: mmc/drivers/mmc/core/host.c
> ===================================================================
> --- mmc.orig/drivers/mmc/core/host.c
> +++ mmc/drivers/mmc/core/host.c
> @@ -398,7 +398,7 @@ int mmc_of_parse(struct mmc_host *host)
>  {
>         struct device_node *np;
>         u32 bus_width;
> -       int len, ret;
> +       int ret;
>         bool cd_cap_invert, cd_gpio_invert = false;
>         bool ro_cap_invert, ro_gpio_invert = false;
>
> @@ -445,12 +445,12 @@ int mmc_of_parse(struct mmc_host *host)
>          */
>
>         /* Parse Card Detection */
> -       if (of_find_property(np, "non-removable", &len)) {
> +       if (of_property_read_bool(np, "non-removable")) {
>                 host->caps |= MMC_CAP_NONREMOVABLE;
>         } else {
>                 cd_cap_invert = of_property_read_bool(np, "cd-inverted");
>
> -               if (of_find_property(np, "broken-cd", &len))
> +               if (of_property_read_bool(np, "broken-cd"))
>                         host->caps |= MMC_CAP_NEEDS_POLL;
>
>                 ret = mmc_gpiod_request_cd(host, "cd", 0, true,
> @@ -491,41 +491,41 @@ int mmc_of_parse(struct mmc_host *host)
>         if (ro_cap_invert ^ ro_gpio_invert)
>                 host->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
>
> -       if (of_find_property(np, "cap-sd-highspeed", &len))
> +       if (of_property_read_bool(np, "cap-sd-highspeed"))
>                 host->caps |= MMC_CAP_SD_HIGHSPEED;
> -       if (of_find_property(np, "cap-mmc-highspeed", &len))
> +       if (of_property_read_bool(np, "cap-mmc-highspeed"))
>                 host->caps |= MMC_CAP_MMC_HIGHSPEED;
> -       if (of_find_property(np, "sd-uhs-sdr12", &len))
> +       if (of_property_read_bool(np, "sd-uhs-sdr12"))
>                 host->caps |= MMC_CAP_UHS_SDR12;
> -       if (of_find_property(np, "sd-uhs-sdr25", &len))
> +       if (of_property_read_bool(np, "sd-uhs-sdr25"))
>                 host->caps |= MMC_CAP_UHS_SDR25;
> -       if (of_find_property(np, "sd-uhs-sdr50", &len))
> +       if (of_property_read_bool(np, "sd-uhs-sdr50"))
>                 host->caps |= MMC_CAP_UHS_SDR50;
> -       if (of_find_property(np, "sd-uhs-sdr104", &len))
> +       if (of_property_read_bool(np, "sd-uhs-sdr104"))
>                 host->caps |= MMC_CAP_UHS_SDR104;
> -       if (of_find_property(np, "sd-uhs-ddr50", &len))
> +       if (of_property_read_bool(np, "sd-uhs-ddr50"))
>                 host->caps |= MMC_CAP_UHS_DDR50;
> -       if (of_find_property(np, "cap-power-off-card", &len))
> +       if (of_property_read_bool(np, "cap-power-off-card"))
>                 host->caps |= MMC_CAP_POWER_OFF_CARD;
> -       if (of_find_property(np, "cap-sdio-irq", &len))
> +       if (of_property_read_bool(np, "cap-sdio-irq"))
>                 host->caps |= MMC_CAP_SDIO_IRQ;
> -       if (of_find_property(np, "full-pwr-cycle", &len))
> +       if (of_property_read_bool(np, "full-pwr-cycle"))
>                 host->caps2 |= MMC_CAP2_FULL_PWR_CYCLE;
> -       if (of_find_property(np, "keep-power-in-suspend", &len))
> +       if (of_property_read_bool(np, "keep-power-in-suspend"))
>                 host->pm_caps |= MMC_PM_KEEP_POWER;
> -       if (of_find_property(np, "enable-sdio-wakeup", &len))
> +       if (of_property_read_bool(np, "enable-sdio-wakeup"))
>                 host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
> -       if (of_find_property(np, "mmc-ddr-1_8v", &len))
> +       if (of_property_read_bool(np, "mmc-ddr-1_8v"))
>                 host->caps |= MMC_CAP_1_8V_DDR;
> -       if (of_find_property(np, "mmc-ddr-1_2v", &len))
> +       if (of_property_read_bool(np, "mmc-ddr-1_2v"))
>                 host->caps |= MMC_CAP_1_2V_DDR;
> -       if (of_find_property(np, "mmc-hs200-1_8v", &len))
> +       if (of_property_read_bool(np, "mmc-hs200-1_8v"))
>                 host->caps2 |= MMC_CAP2_HS200_1_8V_SDR;
> -       if (of_find_property(np, "mmc-hs200-1_2v", &len))
> +       if (of_property_read_bool(np, "mmc-hs200-1_2v"))
>                 host->caps2 |= MMC_CAP2_HS200_1_2V_SDR;
> -       if (of_find_property(np, "mmc-hs400-1_8v", &len))
> +       if (of_property_read_bool(np, "mmc-hs400-1_8v"))
>                 host->caps2 |= MMC_CAP2_HS400_1_8V | MMC_CAP2_HS200_1_8V_SDR;
> -       if (of_find_property(np, "mmc-hs400-1_2v", &len))
> +       if (of_property_read_bool(np, "mmc-hs400-1_2v"))
>                 host->caps2 |= MMC_CAP2_HS400_1_2V | MMC_CAP2_HS200_1_2V_SDR;
>
>         host->dsr_req = !of_property_read_u32(np, "dsr", &host->dsr);
