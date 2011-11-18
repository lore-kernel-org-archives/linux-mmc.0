From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: mmc: sdio: runtime PM and 8686 problems
Date: Fri, 18 Nov 2011 08:53:27 +0000
Message-ID: <WC20111118085327.010279@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.keele.netcentral.co.uk ([212.57.235.197]:58936 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752447Ab1KRIxn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2011 03:53:43 -0500
Received: from terrafix.co.uk (reverse.keele.netcentral.co.uk [212.57.249.250] (may be forged))
	by smtp3.keele.netcentral.co.uk (8.14.2/8.14.2) with ESMTP id pAI8rMMC021298
	for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2011 08:53:28 GMT
Received: from WorldClient by terrafix.co.uk (MDaemon PRO v12.5.0)
	with ESMTP id md50002111720.msg
	for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2011 08:53:31 +0000
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

(resending as my mailer seems to have decided that the first try was a reply to "RE: [PATCH 2/2] mmc: core: Support packed command for eMMC4.5 
device,"... apologies!)

I have a GUMSTIX Overo (OMAP35xx) with a Marvel 8686 WiFi attached via SDIO (ok, I think it's actually a Wi2Wi W2CBW003 module containing an 8686).

Up to the 3.1 mainline kernel WiFi worked just fine! I could boot the kernel and load the libertas module successfully:

(during boot)
[    3.193176] mmc1: new SDIO card at address 0001

(when loading module)
# modprobe libertas_sdio
[   30.817749] lib80211: common routines for IEEE802.11 drivers
[   31.143951] cfg80211: Calling CRDA to update world regulatory domain
[   31.375823] libertas_sdio: Libertas SDIO driver
[   31.380737] libertas_sdio: Copyright Pierre Ossman
[   32.035186] libertas_sdio mmc1:0001:1: (unregistered net_device): 00:19:88:3e:4f:f9, fw 9.70.3p36, cap 0x00000303
[   32.129943] libertas_sdio mmc1:0001:1: wlan0: Marvell WLAN 802.11 adapter


However it seems that runtime PM has now been turned on by default (by setting MMC_CAP_POWER_OFF_CARD in drivers/mmc/core/host.c), and the WiFi 
has stopped working!

So, if I run the 3.2-rc2 (or rc1 for that matter) I get the following:

(during boot)
[    3.486541] mmc1: new SDIO card at address 0001

(when loading module)
# modprobe libertas_sdio
[   34.015350] lib80211: common routines for IEEE802.11 drivers
[   34.345092] cfg80211: Calling CRDA to update world regulatory domain
[   34.574096] libertas_sdio: Libertas SDIO driver
[   34.578979] libertas_sdio: Copyright Pierre Ossman
[   34.637481] libertas_sdio: probe of mmc1:0001:1 failed with error -16


Looking at arch/arm/mach-omap2/overo.c you can see that GPIO16 (OVERO_GPIO_W2W_NRESET) is the nRESET line for the 8686. This is held low for 
10usecs during boot (see overo.c line 530 to 533).

I'm not 100% sure how power is connected to the SD8686 as GUMSTIX don't release schematics for their modules.

If I disable runtime PM (by commenting out the setting of MMC_CAP_POWER_OFF_CARD) everything works as before.

I can see plenty of threads relating to getting the SD8686 working for OLPC, and that some workarounds have made it in to the mainline kernel. From what 
I understand the problem is that runtime PM removes power from the 8686 after boot and before the loading of the libertas module.

Are these workarounds expected to be enough for runtime PM to just "work"?
Is there anything special I should be doing with the nRESET line other than that which is done by default in the board file (holding nRESET low for 10usecs)?

Cheers,
Joe



