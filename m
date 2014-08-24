From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH v14 1/6] mmc: omap_hsmmc: Enable SDIO interrupt
Date: Sun, 24 Aug 2014 10:26:29 +0200
Message-ID: <53F9A1B5.2080409@epfl.ch>
References: <1401352085-22781-1-git-send-email-afenkart@gmail.com> <1401352085-22781-2-git-send-email-afenkart@gmail.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080903000503010100090204"
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1401352085-22781-2-git-send-email-afenkart@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, Andreas Mueller <schnitzeltony@googlemail.com>, Sebastian Reichel <sre@kernel.org>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This is a multi-part message in MIME format.
--------------080903000503010100090204
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Andreas,

On 05/29/2014 10:28 AM, Andreas Fenkart wrote:
> There have been various patches floating around for enabling
> the SDIO IRQ for hsmmc, but none of them ever got merged.
> 

[...]

> For now, only support SDIO interrupt if we are booted with
> a separate wake-irq configued via device tree. This is
> because omaps need the wake-irq for idle states, and some
> omaps need special quirks. And we don't want to add new
> legacy mux platform init code callbacks any longer as we
> are moving to DT based booting anyways.
> 
> To use it, you need to specify the wake-irq using the
> interrupts-extended property.
> 

First, thanks a lot for your tenacity on this patchset, this was a long
needed feature. I enabled the SDIO interrupt, and got the throughput of
my 88W8686-based chip multiplied by 15. Nice! I just have an issue with
the wake-up path, and maybe you could help me.

According to the DM3730 TRM, the MMC2 has the SWAKEUP path. So first I
tried to give the same wake-irq as the MMC's one, but
omap_hsmmc_configure_wake_irq() fails to request it, as they are not
IRQF_SHARED.

So I used the DAT1 for the wake-irq (see patch below), and things are
working. But I get ~2000 wake-irq per seconds, even without any activity
on the WiFi. As a result, the driver is ping-ponging between
omap_hsmmc_runtime_suspend() and omap_hsmmc_runtime_resume(), causing
kworker to eat most of my CPU.

Am I missing something obvious?

Thanks!
Florian



--------------080903000503010100090204
Content-Type: text/x-patch;
 name="enable-sdio.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="enable-sdio.patch"

commit 9e1602f58aa4605a8e8392533783720d899debed
Author: Florian Vaussard <florian.vaussard@epfl.ch>
Date:   Sun Aug 24 09:58:04 2014 +0200

    WIP: Enable SDIO IRQ for Wifi on MMC2

diff --git a/arch/arm/boot/dts/omap3-overo-base.dtsi b/arch/arm/boot/dts/omap3-overo-base.dtsi
index 1887c41..66e0cd7 100644
--- a/arch/arm/boot/dts/omap3-overo-base.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-base.dtsi
@@ -119,7 +119,7 @@
 			OMAP3_CORE1_IOPAD(0x2158, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_clk.sdmmc2_clk */
 			OMAP3_CORE1_IOPAD(0x215a, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_cmd.sdmmc2_cmd */
 			OMAP3_CORE1_IOPAD(0x215c, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat0.sdmmc2_dat0 */
-			OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat1.sdmmc2_dat1 */
+			OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT_PULLUP | PIN_OFF_WAKEUPENABLE | MUX_MODE0)		/* sdmmc2_dat1.sdmmc2_dat1 */
 			OMAP3_CORE1_IOPAD(0x2160, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat2.sdmmc2_dat2 */
 			OMAP3_CORE1_IOPAD(0x2162, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat3.sdmmc2_dat3 */
 		>;
@@ -195,6 +195,9 @@
 	vmmc_aux-supply = <&w3cbw003c_wifi_nreset>;
 	bus-width = <4>;
 	cap-sdio-irq;
+	
+	interrupts-extended = <&intc 86>,
+			      <&gpio5 5 GPIO_ACTIVE_HIGH>; /* gpio_133 (mmc2.dat1) */
 	non-removable;
 };
 
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index b2891a9..1347bc9 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -417,7 +417,6 @@
 		mmc2: mmc@480b4000 {
 			compatible = "ti,omap3-hsmmc";
 			reg = <0x480b4000 0x200>;
-			interrupts = <86>;
 			ti,hwmods = "mmc2";
 			dmas = <&sdma 47>, <&sdma 48>;
 			dma-names = "tx", "rx";

--------------080903000503010100090204--
