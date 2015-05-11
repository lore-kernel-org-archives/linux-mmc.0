From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/4] mmc: dt: Allow to specify that no write protect
 signal is present
Date: Mon, 11 May 2015 12:30:42 +0200
Message-ID: <CAPDyKFpOmhhmHLQJKG-HHGbVJOTR+5Lv=ccyZJtRhNwSY5B1CQ@mail.gmail.com>
References: <1430937082-27149-1-git-send-email-lars@metafoo.de>
	<1430937082-27149-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33785 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340AbbEKKan (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 May 2015 06:30:43 -0400
Received: by qkx62 with SMTP id 62so83424372qkx.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2015 03:30:42 -0700 (PDT)
In-Reply-To: <1430937082-27149-2-git-send-email-lars@metafoo.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Thomas Abraham <thomas.abraham@linaro.org>, Mike Looijmans <mike.looijmans@topic.nl>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

On 6 May 2015 at 20:31, Lars-Peter Clausen <lars@metafoo.de> wrote:
> Allow to specify in the device-tree that no physical write-protect signal
> is connected to a particular instance of a MMC controller. Setting the
> property will cause the core will assume that the SD card is always
> read-write.
>
> The name for the new property is 'disable-wp' and was chosen based on the
> property with the same function from the Synopsys designware mobile storage
> host controller DT bindings specification.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>

Thanks, applied!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt | 5 +++++
>  drivers/mmc/core/host.c                       | 3 +++
>  2 files changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index 438899e..0384fc3 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -21,6 +21,11 @@ Optional properties:
>    below for the case, when a GPIO is used for the CD line
>  - wp-inverted: when present, polarity on the WP line is inverted. See the note
>    below for the case, when a GPIO is used for the WP line
> +- disable-wp: When set no physical WP line is present. This property should
> +  only be specified when the controller has a dedicated write-protect
> +  detection logic. If a GPIO is always used for the write-protect detection
> +  logic it is sufficient to not specify wp-gpios property in the absence of a WP
> +  line.
>  - max-frequency: maximum operating clock frequency
>  - no-1-8-v: when present, denotes that 1.8v card voltage is not supported on
>    this system, even if the controller claims it is.
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 8be0df7..1eabdd0 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -400,6 +400,9 @@ int mmc_of_parse(struct mmc_host *host)
>         else if (ret != -ENOENT)
>                 return ret;
>
> +       if (of_property_read_bool(np, "disable-wp"))
> +               host->caps2 |= MMC_CAP2_NO_WRITE_PROTECT;
> +
>         /* See the comment on CD inversion above */
>         if (ro_cap_invert ^ ro_gpio_invert)
>                 host->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
> --
> 1.8.0
>
