From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/8] mmc: core: add the property for hs200
Date: Fri, 14 Feb 2014 12:31:07 +0100
Message-ID: <CAPDyKFrPGRbqgCb7p_gkSo8fqaXdKkT+zjwrKQpoqyc+O7KFMw@mail.gmail.com>
References: <52EF7A57.1020801@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:33884 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbaBNLbI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Feb 2014 06:31:08 -0500
Received: by mail-qc0-f180.google.com with SMTP id i17so19578086qcy.25
        for <linux-mmc@vger.kernel.org>; Fri, 14 Feb 2014 03:31:07 -0800 (PST)
In-Reply-To: <52EF7A57.1020801@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Olof Johansson <olof@lixom.net>

On 3 February 2014 12:15, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> mmc-hs200-1.8v and mmc-hs200-1.2v can be used to the general capability.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
> Changelog V3:
>         - Use the "len" instead of "NULL"
> Changelog V2:
>         - Rename the mmc-hs200-1_8v/1_2v instead of "_caps2_"
>         - Add the properties into Documentation/devicetree/bindings/mmc/mmc.txt
>
>  Documentation/devicetree/bindings/mmc/mmc.txt |    2 ++
>  drivers/mmc/core/host.c                       |    4 ++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index 458b57f..4bb3894 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -29,6 +29,8 @@ Optional properties:
>  - cap-power-off-card: powering off the card is safe
>  - cap-sdio-irq: enable SDIO IRQ signalling on this interface
>  - full-pwr-cycle: full power cycle of the card is supported
> +- mmc-hs200-1_8v: HS200 mode(1.8V I/O) is supported
> +- mmc-hs200-1_2v: HS200 mode(1.2V I/O) is supported
>
>  *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
>  polarity properties, we have to fix the meaning of the "normal" and "inverted"
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 49bc403..4b81c93 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -429,6 +429,10 @@ int mmc_of_parse(struct mmc_host *host)
>                 host->pm_caps |= MMC_PM_KEEP_POWER;
>         if (of_find_property(np, "enable-sdio-wakeup", &len))
>                 host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
> +       if (of_find_property(np, "mmc-hs200-1_8v", &len))
> +               host->caps2 |= MMC_CAP2_HS200_1_8V_SDR;
> +       if (of_find_property(np, "mmc-hs200-1_2v", &len))
> +               host->caps2 |= MMC_CAP2_HS200_1_2V_SDR;
>
>         return 0;
>
> --
> 1.7.9.5
