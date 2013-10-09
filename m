From: John Tobias <john.tobias.ph@gmail.com>
Subject: eMMC 4.51
Date: Tue, 8 Oct 2013 19:00:58 -0700
Message-ID: <CACUGKYPDQJPvtXj3NBm8=eYCioWmq=pRVSORNYNZjD13N5ceeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:42674 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958Ab3JICBA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Oct 2013 22:01:00 -0400
Received: by mail-la0-f44.google.com with SMTP id eo20so121177lab.3
        for <linux-mmc@vger.kernel.org>; Tue, 08 Oct 2013 19:00:59 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, b29396@freescale.com

Hello,

I am using git://gitorious.org/thierryreding/linux-next.git to boot my
custom board based on iMX6 sololite. My board has SanDisk iNAND 4.51
I/F and wifi module (Marvel SD8797). The latest update of
sdhci-esdhc-imx.c supports DDR50/SDR50/SDR104 and I would like to use
it for my device.

In my .dts file, I have the following settings:

/* WIFI module */
&usdhc2 {
pinctrl-names = "default", "state_100mhz", "state_200mhz";
pinctrl-0 = <&pinctrl_usdhc2_2_default>;
pinctrl-1 = <&pinctrl_usdhc2_3_100mhz>;
pinctrl-2 = <&pinctrl_usdhc2_4_200mhz>;
bus-width = <4>;
status = "okay";
};

/* eMMC module  */
&usdhc4 {
pinctrl-names = "default", "state_100mhz", "state_200mhz";
pinctrl-0 = <&pinctrl_usdhc4_2_default>;
pinctrl-1 = <&pinctrl_usdhc4_3_100mhz>;
pinctrl-2 = <&pinctrl_usdhc4_4_200mhz>;
bus-width = <8>;
status = "okay";
compatible = "fsl,imx6sl-usdhc", "fsl,imx6q-usdhc";
reg = <0x0219c000 0x4000>;
};

Then, in my .dtsi file:

usdhc2 {
/*WIFI pinmux */
pinctrl_usdhc2_2_default: default {
fsl,pins = <
EVT1_PAD_SD2_CMD__SD2_CMD     0x17039
EVT1_PAD_SD2_CLK__SD2_CLK     0x17039
EVT1_PAD_SD2_DATA0__SD2_DATA0 0x17039
EVT1_PAD_SD2_DATA1__SD2_DATA1 0x17039
EVT1_PAD_SD2_DATA2__SD2_DATA2 0x17039
EVT1_PAD_SD2_DATA3__SD2_DATA3 0x17039
>;
};

pinctrl_usdhc2_3_100mhz: state_100mhz { /* 100Mhz */
fsl,pins = <
EVT1_PAD_SD2_CMD__SD2_CMD 0x170B9
EVT1_PAD_SD2_CLK__SD2_CLK 0x100B9
EVT1_PAD_SD2_DATA0__SD2_DATA0 0x170B9
EVT1_PAD_SD2_DATA1__SD2_DATA1 0x170B9
EVT1_PAD_SD2_DATA2__SD2_DATA2 0x170B9
EVT1_PAD_SD2_DATA3__SD2_DATA3 0x170B9
>;
};

pinctrl_usdhc2_4_200mhz: state_200mhz { /* 200Mhz */
fsl,pins = <
EVT1_PAD_SD2_CMD__SD2_CMD 0x170F9
EVT1_PAD_SD2_CLK__SD2_CLK 0x100F9
EVT1_PAD_SD2_DATA0__SD2_DATA0 0x170F9
EVT1_PAD_SD2_DATA1__SD2_DATA1 0x170F9
EVT1_PAD_SD2_DATA2__SD2_DATA2 0x170F9
EVT1_PAD_SD2_DATA3__SD2_DATA3 0x170F9
>;
};
};

usdhc4 {
/* eMMC pinmux */
pinctrl_usdhc4_2_default: default {
fsl,pins = <
EVT1_PAD_EPDC_BDR1__SD4_CMD       0x17039
EVT1_PAD_EPDC_BDR0__SD4_CLK       0x10039
EVT1_PAD_EPDC_PWR_COM__SD4_DATA0  0x17039
EVT1_PAD_EPDC_PWR_IRQ__SD4_DATA1  0x17039
EVT1_PAD_EPDC_PWR_STAT__SD4_DATA2 0x17039
EVT1_PAD_EPDC_PWR_WAKE__SD4_DATA3 0x17039
EVT1_PAD_FEC_MDC__SD4_DATA4 0x17039
EVT1_PAD_FEC_RX_DATA0__SD4_DATA5  0x17039
EVT1_PAD_FEC_TX_EN__SD4_DATA6     0x17039
EVT1_PAD_FEC_TX_DATA1__SD4_DATA7  0x17039
>;
};

pinctrl_usdhc4_3_100mhz: state_100mhz { /* 100Mhz */
fsl,pins = <
EVT1_PAD_EPDC_BDR1__SD4_CMD 0x170B9
EVT1_PAD_EPDC_BDR0__SD4_CLK   0x100B9
EVT1_PAD_EPDC_PWR_COM__SD4_DATA0 0x170B9
EVT1_PAD_EPDC_PWR_IRQ__SD4_DATA1 0x170B9
EVT1_PAD_EPDC_PWR_STAT__SD4_DATA2 0x170B9
EVT1_PAD_EPDC_PWR_WAKE__SD4_DATA3 0x170B9
EVT1_PAD_FEC_MDC__SD4_DATA4 0x170B9
EVT1_PAD_FEC_RX_DATA0__SD4_DATA5  0x170B9
EVT1_PAD_FEC_TX_EN__SD4_DATA6     0x170B9
EVT1_PAD_FEC_TX_DATA1__SD4_DATA7  0x170B9
>;
};

pinctrl_usdhc4_4_200mhz: state_200mhz { /* 200Mhz */
fsl,pins = <
EVT1_PAD_EPDC_BDR1__SD4_CMD 0x170F9
EVT1_PAD_EPDC_BDR0__SD4_CLK   0x100F9
EVT1_PAD_EPDC_PWR_COM__SD4_DATA0 0x170F9
EVT1_PAD_EPDC_PWR_IRQ__SD4_DATA1 0x170F9
EVT1_PAD_EPDC_PWR_STAT__SD4_DATA2 0x170F9
EVT1_PAD_EPDC_PWR_WAKE__SD4_DATA3 0x170F9
EVT1_PAD_FEC_MDC__SD4_DATA4 0x170F9
EVT1_PAD_FEC_RX_DATA0__SD4_DATA5  0x170F9
EVT1_PAD_FEC_TX_EN__SD4_DATA6     0x170F9
EVT1_PAD_FEC_TX_DATA1__SD4_DATA7  0x170F9
>;
};
};


1. After using the said pinmux settings, the sdhci-esdh-imx controller
wasn't able to configure it correctly due the the group name for the
two port were the same (default, state_100mhz, state_200mhz).

2. Then, I temporarily disabled usdhc4 to test if the driver able to
enable the SDR50 for my wifi. Then, I was getting the following
errors:

[    1.655024] mmc0: error -110 whilst initialising SDIO card
[    3.746340] mmc0: error -110 whilst initialising SDIO card
[    3.818624] mmc0: host doesn't support card's voltages
[    3.823783] mmc0: error -22 whilst initialising SDIO card
[    3.901670] mmc0: host doesn't support card's voltages
[    3.906862] mmc0: error -22 whilst initialising SDIO card
[   34.307777] mmc0: host doesn't support card's voltages
[   34.312980] mmc0: error -22 whilst initialising SDIO card

3. Then, I tried the eMMC to see if the driver able to enable the
DDR50. After booting it, the kernel detect the eMMC only in hight
speed mode.


I would like to know if anyone here can help me to figure out how to
enable the DDR50 for my eMMC and SDR50 for my wifi as well.

Regards,

john
