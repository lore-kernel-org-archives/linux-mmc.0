From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: Firefly wifi mainline patches
Date: Wed, 22 Jul 2015 08:58:35 +0200
Message-ID: <20150722065835.GA12069@panicking>
References: <20150721125133.GA4102@panicking>
 <CAOf5uw=cvu9ST+QexgMQP06xQVAz6th_EepfxQOAXNDrWopf6Q@mail.gmail.com>
 <CABgxDoJ03fPobnz+0DBn0EH91y0A0F6Z95sa9aWx3vWXuXqngQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:36406 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755681AbbGVG61 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jul 2015 02:58:27 -0400
Received: by wicgb10 with SMTP id gb10so83879657wic.1
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jul 2015 23:58:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CABgxDoJ03fPobnz+0DBn0EH91y0A0F6Z95sa9aWx3vWXuXqngQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Romain Perier <romain.perier@gmail.com>, Seungwon Jeon <tgih.jun@samsung.com>
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org

Hi

On Wed, Jul 22, 2015 at 08:45:37AM +0200, Romain Perier wrote:
> Hi Michael,
> 
> You can ask and discuss about wifi here, but could you re-send you
> patches as described in [1] please ?
> 
> Short version:
> 1. git format-patch HEAD~2  # extract your two commits
> 2. scripts/get_maintainer.pl -f  <changed_files> # list maintainers
> 3. git send-email --to --cc  <emails  listed by get_maintainer.pl>   *.patch
> 

I know how it works. Right now they are not patches but I will include them
inline with some description in it to understand what problem I still have.

The first one is an hack. Problem is this:

card answer to me that support from 2.0V but regulator is connected
to 1.8V. So capability report are wrong, for now this is just an hack

>From 661979de16b3d0d010659a2e601209aa894d55f4 Mon Sep 17 00:00:00 2001
From: Michael Trimarchi <michael@amarulasolutions.com>
Date: Tue, 21 Jul 2015 16:14:13 +0200
Subject: [PATCH] dw_mmc: hack voltage response from wifi

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/mmc/host/dw_mmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 923152a..5d2f38a 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2355,8 +2355,9 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	if (ret == -EPROBE_DEFER)
 		goto err_host_allocated;
 
-	if (!mmc->ocr_avail)
-		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
+	if (!mmc->ocr_avail || !strcmp("mmc0", mmc_hostname(mmc)))
+		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34 |
+				 MMC_VDD_165_195 | MMC_VDD_20_21;
 
 	if (host->pdata->caps)
 		mmc->caps = host->pdata->caps;
-- 
1.9.1


Here I have some limitation of the frequency. If I choose more the 5Mhz
I can start to have -110 e/o timeout on firmware. Firmware is the
ap6535 firmware. Wifi is stable and working on this frequency

static int dw_mci_execute_tuning(struct mmc_host *mmc, u32 opcode)
{
	struct dw_mci_slot *slot = mmc_priv(mmc);
	struct dw_mci *host = slot->host;
	const struct dw_mci_drv_data *drv_data = host->drv_data;
	int err = 0;

	if (drv_data && drv_data->execute_tuning)
		err = drv_data->execute_tuning(slot);
	return err;
}

I have changed this to report 0 in case excute tuning is not implemented

>From 4d68f996e28aa135a331e67ccd95874632276606 Mon Sep 17 00:00:00 2001
From: Michael Trimarchi <michael@amarulasolutions.com>
Date: Tue, 21 Jul 2015 15:21:48 +0200
Subject: [PATCH] firefly: add a minimal wifi settings

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 arch/arm/boot/dts/rk3288-firefly.dtsi | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index 149b9ed..effce71 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -116,6 +116,19 @@
 		vin-supply = <&vcc_io>;
 	};
 
+	vcc_wifi: wifi-regulator {
+		compatible = "regulator-fixed";
+		gpio = <&gpio4 28 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdio0_pwr>;
+		regulator-name = "vcc_wifi";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		startup-delay-us = <100000>;
+		vin-supply = <&vcc_io>;
+	};
+
+
 	vcc_flash: flash-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_flash";
@@ -460,13 +473,31 @@
 &sdio0 {
 	broken-cd;
 	bus-width = <4>;
+	clock-freq-min-max = <400000 5000000>;
 	disable-wp;
 	non-removable;
+	cap-sd--highspeed;
 	num-slots = <1>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>;
+	pinctrl-0 = <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>, <&sdio0_int>;
+
+	sd-uhs-sdr104;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	cap-sdio-irq;
+
 	vmmc-supply = <&vcc_18>;
+/*	mmc-supply = <&vcc_wifi>; */
 	status = "okay";
+
+	brcmf: bcrmf@1 {
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&gpio4>;
+		reg = <0>;
+		interrupts = <30 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-names = "host-wake";
+		status = "okay";
+	};
 };
 
 &sdmmc {
-- 
1.9.1


> Thanks in advance,
> Have a nice day,
> Romain
> 
> 1. https://www.kernel.org/doc/Documentation/SubmittingPatches
> 
> 
> 2015-07-22 7:58 GMT+02:00 Michael Trimarchi <michael@amarulasolutions.com>:
> > Hi
> >
> >
> > On Tue, Jul 21, 2015 at 2:51 PM, Michael Trimarchi
> > <michael@amarulasolutions.com> wrote:
> >> Hi
> >>
> >> I have managed to let my wifi working using mainline but I have
> >> problem on clocking. Right now I can not rise the clock more the 5Mhz
> >> even it's suppose to work up to 50Mhz. Anyone is working on it right
> >> now?
> >>
> >
> > I put in attach two patches that I need on my version. Another problem
> > is that execute_tuning is not defined in the dw_mmc-rockchip so
> > ENOSYS is returned. I think that we have two way:
> >
> > 1) put a stub
> > 2) define 0 as default error
> >
> > Michael
> >
> >> Michael
> >
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
> >

-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
