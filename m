From: Ian Molton <ian@mnementh.co.uk>
Subject: vmmc-supply
Date: Wed, 12 Jul 2017 16:28:19 +0100
Message-ID: <d8b762f1-efb1-21df-0760-505eb9ff2a03@mnementh.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [217.148.43.144] ([217.148.43.144]:34752 "EHLO mnementh.co.uk"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1753702AbdGLQLA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 12 Jul 2017 12:11:00 -0400
Received: from 12.3.208.46.dyn.plus.net ([46.208.3.12] helo=[192.168.1.130])
        by mnementh.co.uk with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <ian@mnementh.co.uk>)
        id 1dVJYq-0000IW-B7
        for linux-mmc@vger.kernel.org; Wed, 12 Jul 2017 15:28:20 +0000
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi folks,

I'm working on a SDIO wifi card and I'm attempting to figure out how on
earth voltage regulation works for MMC slots.

The mmc host is an imx6ul

In its DT, it has the following:

&usdhc1 {
        #address-cells = <1>;
        #size-cells = <0>;
        pinctrl-names = "default", "state_100mhz", "state_200mhz";
        pinctrl-0 = <&pinctrl_usdhc1>;
        pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
        pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
        no-1-8-v;
        keep-power-in-suspend;
        enable-sdio-wakeup;
        vmmc-supply = <&reg_sd1_vmmc>;
        non-removable;
        status = "okay";
}

Its working, however I cannot seem to get it to turn off power to the
slot. I would expect that if the card is probed and no driver wants to
attach, the slot can be turned off.

cat /sys/class/regulator/regulator.5/state tells me the regulator is
enabled, and num_users is 1

whats really puzzling me is that nowhere in the code does git grep show
*any* attempt to look up a regulator called vmmc-supply, or a dt
property with the same name. Unless I'm being blind...

I assume the of regulator code is looking up the parent device and
enabling the regulator for me, but then I cannot see how the MMC core /
host driver might control the regulator.

Is this all as it is expected to be?

What I'd like is for an attempt to load the wifi module to cause the MMC
host to turn on the power and let the card try to re-enumerate/probe,
and for driver unloading to cause the card to get turned off again.

I cant see a good way to toggle slot power from userspace either -
although I may just be missing this?

TIA for comments,

-Ian
