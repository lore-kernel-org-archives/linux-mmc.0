From: Holger Schurig <holgerschurig@gmail.com>
Subject: BUG 4.4rc-4: wrong eMMC signaling voltage reported
Date: Wed, 09 Dec 2015 15:53:06 +0100
Message-ID: <87fuzbvfl9.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36070 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbbLIOxK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Dec 2015 09:53:10 -0500
Received: by wmww144 with SMTP id w144so225770145wmw.1
        for <linux-mmc@vger.kernel.org>; Wed, 09 Dec 2015 06:53:09 -0800 (PST)
Received: from desktop (p57ACF477.dip0.t-ipconnect.de. [87.172.244.119])
        by smtp.gmail.com with ESMTPSA id yr7sm8050310wjc.9.2015.12.09.06.53.07
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2015 06:53:07 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

I have an i.MX6Q based system that cannot provide 1.8V voltage towards
the eMMC. But Linux 4.4-rc4 reports 1.8V for the eMMC, but this is
impossible. Neither my hardware allows this, nor does the DT say it.

root@imx6q:/sys/kernel/debug# cat mmc1/ios
clock:		52000000 Hz
actual clock:	49500000 Hz
vdd:		21 (3.3 ~ 3.4 V)
bus mode:	2 (push-pull)
chip select:	0 (don't care)
power mode:	2 (on)
bus width:	3 (8 bits)
timing spec:	8 (mmc DDR52)
signal voltage:	0 (1.80 V)
driver type:	0 (driver type B)

My device tree however tells that I don't have 1.8V:

/* this is the built in eMMC */
&usdhc4 {
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_usdhc4>;
	bus-width = <8>;
	non-removable;
	vmmc-supply = <&reg_3p3v>;
	max-frequency = <198000000>;
	no-1-8-v;
	status = "okay";
};




Fun fact: for the SDCARD things are correctly reported:

root@imx6q:/sys/kernel/debug# cat mmc1/ios
clock:		36000000 Hz
actual clock:	33000000 Hz
vdd:		21 (3.3 ~ 3.4 V)
bus mode:	2 (push-pull)
chip select:	0 (don't care)
power mode:	2 (on)
bus width:	2 (4 bits)
timing spec:	2 (sd high-speed)
signal voltage:	0 (3.30 V)
driver type:	0 (driver type B)

And here my device tree excerpt:

/* this is the SDCARD slot */
&usdhc2 {
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_usdhc2>;
	cd-gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
	wp-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
	vmmc-supply = <&reg_3p3v>;
	max-frequency = <36000000>;
	no-1-8-v;
	status = "okay";
};
