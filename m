From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH v2] mmc: dw_mmc: Don't start commands while busy
Date: Mon, 23 Feb 2015 17:33:28 +0100
Message-ID: <54EB5658.6080004@collabora.co.uk>
References: <1424464316-4397-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:46924 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495AbbBWQdi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Feb 2015 11:33:38 -0500
In-Reply-To: <1424464316-4397-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, chris@printf.net, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Doug,

On 02/20/2015 09:31 PM, Doug Anderson wrote:
> We've seen problems on some WiFi modules where we seem to send a CMD53
> (which requires the data lines) while the module is asserting busy.
> We shouldn't do that.
> 
> The Designware Databook says that before issuing a new data transfer
> command we should check for busy, so that's what we'll do.
> 

I tried $subject along with patches:

* mmc: dw_mmc: Make sure we only adjust the clock when power is on
  https://patchwork.kernel.org/patch/5858261/

* mmc: dw_mmc: Give a good reset after we give power
  https://patchwork.kernel.org/patch/5858281/

but unfortunately these don't solve the "Timeout sending command" error
that I got when trying to enable the WiFi module on the Peach Pit and Pi:

[    5.332103] dwmmc_exynos 12210000.mmc: Busy; trying anyway
[    5.336110] mmc_host mmc2: Timeout sending command (cmd 0x202000 arg 0x0 status 0x0)

> We'll leverage the existing dw_mmc knowledge about whether it should
> wait for the previous command to finish to know whether we should
> check for busy before sending the command.  This means we won't end up
> incorrectly waiting for things like CMD52 (SDIO) or CMD13 (SD) which
> don't use the data line.
> 
> Note that this also has the advantage of making sure that we don't
> change the clock while the card is busy, too.
>

The timeout happens in this case:

mmc_rescan()
	mmc_attach_sdio()
		mmc_sdio_init_card()
			dw_mci_init_card()
				mci_send_cmd(slot, SDMMC_CMD_UPD_CLK |
				     		   SDMMC_CMD_PRV_DAT_WAIT, 0);

which should be covered by your patch since the SDMMC_CMD_PRV_DAT_WAIT flag
is set but SDMMC_STATUS_BUSY bit is not cleared and mci_send_cmd() timeouts
when sending the command to the controller.
 
>  
> +static void dw_mci_wait_while_busy(struct dw_mci *host, u32 cmd_flags)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(500);
> +
> +	/*
> +	 * Databook says that before issuing a new data transfer command
> +	 * we need to check to see if the card is busy.  Data transfer commands
> +	 * all have SDMMC_CMD_PRV_DAT_WAIT set, so we'll key off that.
> +	 *
> +	 * ...also allow sending for SDMMC_CMD_VOLT_SWITCH where busy is
> +	 * expected.
> +	 */
> +	if ((cmd_flags & SDMMC_CMD_PRV_DAT_WAIT) &&
> +	    !(cmd_flags & SDMMC_CMD_VOLT_SWITCH)) {
> +		while (mci_readl(host, STATUS) & SDMMC_STATUS_BUSY) {
> +			if (time_after(jiffies, timeout)) {
> +				/* Command will fail; we'll pass error then */
> +				dev_err(host->dev, "Busy; trying anyway\n");

Addy's "mmc: dw_mmc: fix bug that cause 'Timeout sending command" [0] patch
reset the controller if it was busy for more than 500ms while your patch
doesn't. I don't mean that your patch is not correct, I'm just mentioning
because calling dw_mci_ctrl_reset() does makes the command to succeed the
next time and I can see the SDIO devices enumerated in /sys/bus/sdio/devices:

[    5.892124] dwmmc_exynos 12210000.mmc: Busy; trying anyway
[    5.892135] mmc_host mmc2: Timeout sending command (cmd 0x202000 arg 0x0 status 0x0)
[    5.913885] mmc2: new high speed SDIO card at address 0001
[    6.582133] dwmmc_exynos 12210000.mmc: Busy; trying anyway

but that reset may not be right since the WiFi chip does not work because
the firmware later fails to load:

[  240.273352] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  240.281159] kworker/2:1     D c04b3340     0  1260      2 0x00000000
[  240.287487] Workqueue: events request_firmware_work_func
[  240.292763] [<c04b3340>] (__schedule) from [<c04b36f0>] (schedule+0x34/0x98)
[  240.299815] [<c04b36f0>] (schedule) from [<c04b7198>] (schedule_timeout+0x120/0x16c)
[  240.307537] [<c04b7198>] (schedule_timeout) from [<c04b41b4>] (wait_for_common+0xb0/0x154)
[  240.315783] [<c04b41b4>] (wait_for_common) from [<c037abb8>] (mmc_wait_for_req+0xa0/0x140)
[  240.324020] [<c037abb8>] (mmc_wait_for_req) from [<c0384b04>] (mmc_io_rw_extended+0x304/0x34c)
[  240.332607] [<c0384b04>] (mmc_io_rw_extended) from [<c0385a90>] (sdio_io_rw_ext_helper+0x138/0x1a4)
[  240.341630] [<c0385a90>] (sdio_io_rw_ext_helper) from [<c0385b1c>] (sdio_writesb+0x20/0x28)
[  240.349962] [<c0385b1c>] (sdio_writesb) from [<c02e60d4>] (mwifiex_write_data_sync+0x4c/0x80)
[  240.358460] [<c02e60d4>] (mwifiex_write_data_sync) from [<c02e68e4>] (mwifiex_prog_fw_w_helper+0x1b0/0x2c4)
[  240.368176] [<c02e68e4>] (mwifiex_prog_fw_w_helper) from [<c02c7d6c>] (mwifiex_dnld_fw+0x58/0x10c)
[  240.377127] [<c02c7d6c>] (mwifiex_dnld_fw) from [<c02c5f10>] (mwifiex_fw_dpc+0x264/0x408)
[  240.385263] [<c02c5f10>] (mwifiex_fw_dpc) from [<c0291b28>] (request_firmware_work_func+0x30/0x50)
[  240.394200] [<c0291b28>] (request_firmware_work_func) from [<c0032ae8>] (process_one_work+0x120/0x324)
[  240.403482] [<c0032ae8>] (process_one_work) from [<c0032e58>] (worker_thread+0x138/0x464)
[  240.411635] [<c0032e58>] (worker_thread) from [<c0037470>] (kthread+0xd8/0xf4)
[  240.418837] [<c0037470>] (kthread) from [<c000e680>] (ret_from_fork+0x14/0x34)

The DTS changes on top of linux-next to add WiFi support is [1] in case you can
find something that is wrong with my patch.

I also checked that the external reference clock for the WiFi module is enabled
correctly according to /sys/kernel/debug/clk/clk_summary and also by looking
at the value in the max77802 i2c register address that enables that clock.

Any hints will be highly appreciated.

Thanks a lot and best regards,
Javier

[0]: https://lkml.org/lkml/2015/2/5/222
[1]:
>From ced0974472d109019e1ee551a6dd08f16ae5cfc2 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Date: Mon, 23 Feb 2014 15:42:15 +0100
Subject: [PATCH] ARM: dts: Add Peach Pit board WiFi support

Peach boards have an SDIO WiFi module that is always powered but it
needs a power sequence involving the reset and enable pins and also
a 32kHz reference clock.

Add a dev node for the SDIO slot and the MMC power sequence provider.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 59 ++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index ec86d9523935..26df041e46e7 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -125,6 +125,14 @@
 			};
 		};
 	};
+
+	mmc1_pwrseq: mmc1_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpx0 1 GPIO_ACTIVE_LOW>, /* WIFI_RSTn */
+			      <&gpx0 0 GPIO_ACTIVE_LOW>; /* WIFI_EN */
+		clocks = <&max77802 MAX77802_CLK_32K_CP>;
+		clock-names = "ext_clock";
+	};
 };
 
 &adc {
@@ -691,6 +699,24 @@
 	bus-width = <8>;
 };
 
+&mmc_1 {
+	status = "okay";
+	num-slots = <1>;
+	broken-cd;
+	cap-sdio-irq;
+	card-detect-delay = <200>;
+	clock-frequency = <400000000>;
+	samsung,dw-mshc-ciu-div = <1>;
+	samsung,dw-mshc-sdr-timing = <0 1>;
+	samsung,dw-mshc-ddr-timing = <0 2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd1_clk>, <&sd1_cmd>, <&sd1_int>, <&sd1_bus4>,
+		    <&sd1_bus8>, <&wifi_en>, <&wifi_rst>;
+	bus-width = <4>;
+	cap-sd-highspeed;
+	mmc-pwrseq = <&mmc1_pwrseq>;
+};
+
 &mmc_2 {
 	status = "okay";
 	num-slots = <1>;
@@ -710,6 +736,20 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mask_tpm_reset>;
 
+	wifi_en: wifi-en {
+		samsung,pins = "gpx0-0";
+		samsung,pin-function = <1>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
+	wifi_rst: wifi-rst {
+		samsung,pins = "gpx0-1";
+		samsung,pin-function = <1>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+
 	max98090_irq: max98090-irq {
 		samsung,pins = "gpx0-2";
 		samsung,pin-function = <0>;
@@ -797,6 +837,25 @@
 	};
 };
 
+&pinctrl_1 {
+	/* Adjust WiFi drive strengths lower for EMI */
+	sd1_clk: sd1-clk {
+		samsung,pin-drv = <2>;
+	};
+
+	sd1_cmd: sd1-cmd {
+		samsung,pin-drv = <2>;
+	};
+
+	sd1_bus4: sd1-bus-width4 {
+		samsung,pin-drv = <2>;
+	};
+
+	sd1_bus8: sd1-bus-width8 {
+		samsung,pin-drv = <2>;
+	};
+};
+
 &pinctrl_2 {
 	pmic_dvs_2: pmic-dvs-2 {
 		samsung,pins = "gpj4-2";
-- 
2.1.3
