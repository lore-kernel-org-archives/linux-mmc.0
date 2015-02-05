From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] mmc: core: add runtime-resume caps to support resume at
 runtime_resume
Date: Thu, 5 Feb 2015 11:27:01 +0000
Message-ID: <20150205112701.GD11344@leverpostej>
References: <1423134419-23109-1-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:41954 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbbBEL1c (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Feb 2015 06:27:32 -0500
Content-Disposition: inline
In-Reply-To: <1423134419-23109-1-git-send-email-addy.ke@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Addy Ke <addy.ke@rock-chips.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "chris@printf.net" <chris@printf.net>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "dinguyen@altera.com" <dinguyen@altera.com>, "heiko@sntech.de" <heiko@sntech.de>, "olof@lixom.net" <olof@lixom.net>, "dianders@chromium.org" <dianders@chromium.org>, "sonnyrao@chromium.org" <sonnyrao@chromium.org>, "amstan@chromium.org" <amstan@chromium.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc@vge

On Thu, Feb 05, 2015 at 11:06:59AM +0000, Addy Ke wrote:
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt | 11 +++++++++++
>  drivers/mmc/core/host.c                       |  2 ++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index 438899e..303b448 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -40,9 +40,20 @@ Optional properties:
>  - mmc-hs200-1_2v: eMMC HS200 mode(1.2V I/O) is supported
>  - mmc-hs400-1_8v: eMMC HS400 mode(1.8V I/O) is supported
>  - mmc-hs400-1_2v: eMMC HS400 mode(1.2V I/O) is supported
> +- runtime-resume: resume at runtime_resume is supported

This reads like description of Linux internals (runtime_resume), which
shouldn't be in the DT.

What does this mean at the HW level? I'm sure we can find a better name
for this, or another way of describing this.

>  - dsr: Value the card's (optional) Driver Stage Register (DSR) should be
>    programmed with. Valid range: [0 .. 0xffff].
>  
> +Card power and reset control:
> +The following properties can be specified for cases where the MMC
> +peripheral needs additional reset, regulator and clock lines. It is for
> +example common for WiFi/BT adapters to have these separate from the main
> +MMC bus:
> +  - card-reset-gpios: Specify GPIOs for card reset (reset active low)
> +  - card-external-vcc-supply: Regulator to drive (independent) card VCC
> +  - clock with name "card_ext_clock": External clock provided to the card

Are these proeprties placed on the MMC controller node, or a sub-node
representing the card/slot?

Thanks,
Mark.
