From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V1 2/2] mmc: tegra: SDMMC pads auto-calibration
Date: Wed, 19 Dec 2018 12:39:14 +0100
Message-ID: <CAPDyKFoVq4HwdrJ_X3jv41ahXHnp6MbU8fmC83HJ6bhN5MYMhw@mail.gmail.com>
References: <1545160787-3157-1-git-send-email-skomatineni@nvidia.com> <1545160787-3157-2-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545160787-3157-2-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mikko Perttunen <mperttunen@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, DTML <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

[...]

>         if (tegra_host->pad_calib_required)
> @@ -805,8 +854,15 @@ static int tegra_sdhci_init_pinctrl_info(struct device *dev,
>                 return -1;
>         }
>
> -       tegra_host->pinctrl_state_3v3 =
> -               pinctrl_lookup_state(tegra_host->pinctrl_sdmmc, "sdmmc-3v3");
> +       tegra_host->pinctrl_state_1v8_drv = pinctrl_lookup_state(
> +                               tegra_host->pinctrl_sdmmc, "sdmmc-1v8-drv");

This requires and updated DT doc for tegra sdhci. Please make that a
separate patch and put it first in the series. Also don't forget to
include the DT maintainers in the to field for that patch.

> +
> +       tegra_host->pinctrl_state_3v3_drv = pinctrl_lookup_state(
> +                               tegra_host->pinctrl_sdmmc, "sdmmc-3v3-drv");

Ditto.

> +
> +       tegra_host->pinctrl_state_3v3 = pinctrl_lookup_state(
> +                               tegra_host->pinctrl_sdmmc, "sdmmc-3v3");
> +

The above looks like an unnecessary line change. Please just stick to
the existing format and avoid changing code that doesn't need to be
changed.

>         if (IS_ERR(tegra_host->pinctrl_state_3v3)) {
>                 dev_warn(dev, "Missing 3.3V pad state, err: %ld\n",
>                          PTR_ERR(tegra_host->pinctrl_state_3v3));
> --
> 2.7.4
>

Kind regards
Uffe
