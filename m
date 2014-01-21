From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Tue, 21 Jan 2014 08:24:47 +0100
Message-ID: <20140121072447.GC19940@pengutronix.de>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <1390190215-22700-2-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55227 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbaAUHYx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jan 2014 02:24:53 -0500
Content-Disposition: inline
In-Reply-To: <1390190215-22700-2-git-send-email-olof@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-mmc@vger.kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, pawel.moll@arm.com, chris@printf.net, robh+dt@kernel.org, ijc+devicetree@hellion.org.ok, galak@codeaurora.org, linux-arm-kernel@lists.infradead.org

On Sun, Jan 19, 2014 at 07:56:53PM -0800, Olof Johansson wrote:
> This patch enables support for power-on sequencing of SDIO peripherals through DT.
> 
> In general, it's quite common that wifi modules and other similar
> peripherals have several signals in addition to the SDIO interface that
> needs wiggling before the module will power on. It's common to have a
> reference clock, one or several power rails and one or several lines
> for reset/enable type functions.
> 
> The binding as written today introduces a number of reset gpios,
> a regulator and a clock specifier. The code will handle up to 2 gpio
> reset lines, but it's trivial to increase to more than that if needed
> at some point.
> 
> Implementation-wise, the MMC core has been changed to handle this during
> host power up, before the host interface is powered on. I have not yet
> implemented the power-down side, I wanted people to have a chance for
> reporting back w.r.t. issues (or comments on the bindings) first.
> 
> I have not tested the regulator portion, since the system and module
> I'm working on doesn't need one (Samsung Chromebook with Marvell
> 8797-based wifi). Testing of those portions (and reporting back) would
> be appreciated.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt |   11 +++++++
>  drivers/mmc/core/core.c                       |   42 +++++++++++++++++++++++++
>  drivers/mmc/core/host.c                       |   30 +++++++++++++++++-
>  include/linux/mmc/host.h                      |    5 +++
>  4 files changed, 87 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index 458b57f..962e0ee 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -5,6 +5,8 @@ these definitions.
>  Interpreted by the OF core:
>  - reg: Registers location and length.
>  - interrupts: Interrupts used by the MMC controller.
> +- clocks: Clocks needed for the host controller, if any.
> +- clock-names: Goes with clocks above.
>  
>  Card detection:
>  If no property below is supplied, host native card detect is used.
> @@ -30,6 +32,15 @@ Optional properties:
>  - cap-sdio-irq: enable SDIO IRQ signalling on this interface
>  - full-pwr-cycle: full power cycle of the card is supported
>  
> +Card power and reset control:
> +The following properties can be specified for cases where the MMC
> +peripheral needs additional reset, regulator and clock lines. It is for
> +example common for WiFi/BT adapters to have these separate from the main
> +MMC bus:
> +  - card-reset-gpios: Specify GPIOs for card reset (reset active low)

We have GPIO_ACTIVE_LOW/HIGH. No need to hardcode this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
