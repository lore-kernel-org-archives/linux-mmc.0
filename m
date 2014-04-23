From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v6 6/6] mmc: core: add DT bindings for eMMC HS400 1.8/1.2V
Date: Wed, 23 Apr 2014 10:30:45 +0200
Message-ID: <CAPDyKFqOgtob0Sg3z69NcmG=PtBTYQJYBnoZEqy8E5RQ=94rnw@mail.gmail.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
	<006701cf2a58$c628e050$527aa0f0$%jun@samsung.com>
	<001901cf5b0b$4be8ce70$e3ba6b50$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:52695 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbaDWIaq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Apr 2014 04:30:46 -0400
Received: by mail-qa0-f49.google.com with SMTP id j7so552495qaq.36
        for <linux-mmc@vger.kernel.org>; Wed, 23 Apr 2014 01:30:45 -0700 (PDT)
In-Reply-To: <001901cf5b0b$4be8ce70$e3ba6b50$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, Jackey Shen <jackey.shen@amd.com>, Alim Akhtar <alim.akhtar@samsung.com>

On 18 April 2014 15:37, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Provide the option to configure these speed modes per host,
> for those host driver's that can't distinguish this in runtime.
> Specially, if host can support HS400, it means that host can also
> support HS200.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt |    2 ++
>  drivers/mmc/core/host.c                       |    4 ++++
>  2 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index 9dce540..3c18001 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -38,6 +38,8 @@ Optional properties:
>  - mmc-highspeed-ddr-1_2v: eMMC high-speed DDR mode(1.2V I/O) is supported
>  - mmc-hs200-1_8v: eMMC HS200 mode(1.8V I/O) is supported
>  - mmc-hs200-1_2v: eMMC HS200 mode(1.2V I/O) is supported
> +- mmc-hs400-1_8v: eMMC HS400 mode(1.8V I/O) is supported
> +- mmc-hs400-1_2v: eMMC HS400 mode(1.2V I/O) is supported
>
>  *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
>  polarity properties, we have to fix the meaning of the "normal" and "inverted"
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index fdea825..95cceae 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -447,6 +447,10 @@ int mmc_of_parse(struct mmc_host *host)
>                 host->caps2 |= MMC_CAP2_HS200_1_8V_SDR;
>         if (of_find_property(np, "mmc-hs200-1_2v", &len))
>                 host->caps2 |= MMC_CAP2_HS200_1_2V_SDR;
> +       if (of_find_property(np, "mmc-hs400-1_8v", &len))
> +               host->caps2 |= MMC_CAP2_HS400_1_8V | MMC_CAP2_HS200_1_8V_SDR;
> +       if (of_find_property(np, "mmc-hs400-1_2v", &len))
> +               host->caps2 |= MMC_CAP2_HS400_1_2V | MMC_CAP2_HS200_1_2V_SDR;
>
>         return 0;
>
> --
> 1.7.0.4
>
>
