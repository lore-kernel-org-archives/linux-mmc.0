From: Angus Ainslie <angus@akkea.ca>
Subject: MMC SDIO problem with CHIPPro on 4.12. rc2
Date: Mon, 22 May 2017 18:02:07 -0600
Message-ID: <59ba9f45d76285d13716d915917ef8e0@www.akkea.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from node.akkea.ca ([192.155.83.177]:42414 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757649AbdEWAJC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 22 May 2017 20:09:02 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Icenowy Zheng <icenowy@aosc.xyz>, Heiner Kallweit <hkallweit1@gmail.com>Heiner Kallweit <hkallweit1@gmail.com>, linux-mmc@vger.kernel.org

Hi All,

I have a problem with the SDIO support for the CHIPPRo in 4.12 rc2. The 
SDHC controller gets found but the WiFi chip does not get detected.

[    5.310000] Bluetooth: Generic Bluetooth SDIO driver ver 0.1
[    5.310000] pwrseq_simple: probe of mmc0_pwrseq failed with error -22
[    5.320000] sdhci: Secure Digital Host Controller Interface driver
[    5.330000] sdhci: Copyright(c) Pierre Ossman
[    5.330000] sdhci-pltfm: SDHCI platform and OF driver helper

I'm assuming it's because of the pwrseq_simple probe failing.

If I use the dts file ntc-gr8-crumb.dts for the ntc 4.4.30 kernel the 
SDIO WiFi does get detected.

Angus
