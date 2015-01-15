From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH V2 2/4] mmc: pwrseq: Document DT bindings for the simple
 MMC power sequence
Date: Thu, 15 Jan 2015 16:58:26 +0000
Message-ID: <20150115165825.GL16217@leverpostej>
References: <1421240530-7971-1-git-send-email-ulf.hansson@linaro.org>
 <1421240530-7971-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:34970 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbbAOQ6s (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Jan 2015 11:58:48 -0500
Content-Disposition: inline
In-Reply-To: <1421240530-7971-3-git-send-email-ulf.hansson@linaro.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alexandre Courbot <gnurou@gmail.com>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, Hans de Goede <hdegoede@redhat.com>, Doug Anderson <dianders@chromium.org>, NeilBrown <neilb@suse.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>

Hi Ulf,

On Wed, Jan 14, 2015 at 01:02:08PM +0000, Ulf Hansson wrote:
> The simple MMC power sequence provider, intends to supports a set of
> common properties between SOC designs. It thus enables us to re-use the
> same provider for several SOCs.
> 
> In this initial step, let's add the top level description of the MMC
> power sequence and describe the compatible string for the simple MMC
> power sequence provider.
> 
> Following patches will step by step add support for new properties to
> the simple MMC power sequence provider.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v2:
> 	- None.
> 
> ---
>  .../devicetree/bindings/mmc/mmc,pwrseq-simple.txt      | 18 ++++++++++++++++++
>  Documentation/devicetree/bindings/mmc/mmc.txt          |  5 +++++
>  2 files changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
> new file mode 100644
> index 0000000..e1b7f9c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
> @@ -0,0 +1,18 @@
> +* The simple MMC power sequence provider
> +
> +System on chip designs may specify a specific MMC power sequence. To
> +successfully detect an (e)MMC/SD/SDIO card, that power sequence must be
> +maintained while initializing the card.
> +
> +The simple MMC power sequence provider, intends to supports a set of common
> +properties between SOC designs. It thus enables us to re-use the same provider
> +for several SOC designs.
> +
> +Required properties:
> +- compatible : contains "mmc,pwrseq-simple".

Nit: "mmc" is not a vendor prefix.

> +
> +Example:
> +
> +	sdhci0_pwrseq {
> +		compatible = "mmc,pwrseq-simple";
> +	}

I'm a little confused here. What specific sequence is described by this
node? We don't appear to have referred to any resources used as part of
that sequence, and the description above only mentions that there could
be a specific sequence, not what that sequence is.

So I don't think this makes sense on its own, and should probably be
folded with patches adding the initial support for the resources used as
part of the sequence (e.g. the GPIOs added in a later patch).

Thanks,
Mark.

> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index bac1311..b12de1e 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -64,6 +64,10 @@ Optional SDIO properties:
>  - keep-power-in-suspend: Preserves card power during a suspend/resume cycle
>  - enable-sdio-wakeup: Enables wake up of host system on SDIO IRQ assertion
>  
> +Optional MMC power sequence:
> +- mmc-pwrseq: phandle to the MMC power sequence node. See "mmc,pwrseq-*"
> +	for documentation of MMC power sequence bindings.
> +
>  
>  Use of Function subnodes
>  ------------------------
> @@ -101,6 +105,7 @@ sdhci@ab000000 {
>  	max-frequency = <50000000>;
>  	keep-power-in-suspend;
>  	enable-sdio-wakeup;
> +	mmc-pwrseq = <&sdhci0_pwrseq>
>  }
>  
>  Example with sdio function subnode:
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
