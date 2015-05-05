From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: sdhci: DT: Allow to specify that no write
 protect signal is present
Date: Tue, 5 May 2015 10:36:02 +0200
Message-ID: <CAPDyKFpC9uc0n8HLiC1gWgdJOM-0DGVaNazkF3Q847r-sfXNtg@mail.gmail.com>
References: <1430214020-16816-1-git-send-email-lars@metafoo.de>
	<1430214020-16816-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:34680 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965617AbbEEIgD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2015 04:36:03 -0400
Received: by qgfi89 with SMTP id i89so77699748qgf.1
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2015 01:36:02 -0700 (PDT)
In-Reply-To: <1430214020-16816-2-git-send-email-lars@metafoo.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mike Looijmans <mike.looijmans@topic.nl>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

On 28 April 2015 at 11:40, Lars-Peter Clausen <lars@metafoo.de> wrote:
> Allow to specify in the device-tree that no physical write-protect signal
> is connected to a particular instance of a SDHCI controller. This allows a
> driver to ignore potential bogus values of the SDHCI_WRITE_PROTECT bit in
> the SDHCI_PRESENT_STATE register if it is aware that no write-protect
> signal is connected.
>
> The name for the new property is 'disable-wp' and was chosen based on the
> property with the same function from the Synopsys designware mobile storage
> host controller DT bindings specification.

Re-using the "disable-wp" name is okay. Though, I would like this to
be treated as a common MMC DT binding and not something specific for
sdhci/dw_mmc.

Therefore, I suggest to add a corresponding MMC_CAP* bit, which should
be assigned from mmc_of_parse().

>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt | 1 +
>  drivers/mmc/host/sdhci-pltfm.c                | 3 +++
>  2 files changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index 438899e..b068549 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -21,6 +21,7 @@ Optional properties:
>    below for the case, when a GPIO is used for the CD line
>  - wp-inverted: when present, polarity on the WP line is inverted. See the note
>    below for the case, when a GPIO is used for the WP line
> +- disable-wp: When set no physical WP line is present

This requires some additional explanation, I believe. I assume this
property is only relevant for those controllers that have internal
logic to handle WP!?

For those that uses GPIO, this can't ever be a correct configuration. Right?

>  - max-frequency: maximum operating clock frequency
>  - no-1-8-v: when present, denotes that 1.8v card voltage is not supported on
>    this system, even if the controller claims it is.
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index a207f5a..aa4d343 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -86,6 +86,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
>         if (sdhci_of_wp_inverted(np))
>                 host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
>
> +       if (of_property_read_bool(np, "disable-wp"))
> +               host->quirks2 |= SDHCI_QUIRK2_DISABLE_WRITE_PROTECT;
> +
>         if (of_get_property(np, "broken-cd", NULL))
>                 host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>
> --
> 1.8.0
>

Kind regards
Uffe
