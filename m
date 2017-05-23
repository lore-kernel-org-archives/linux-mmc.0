From: Angus Ainslie <angus@akkea.ca>
Subject: Re: MMC SDIO problem with CHIPPro on 4.12. rc2
Date: Mon, 22 May 2017 21:06:39 -0600
Message-ID: <db6a286ffb72ee4f8b7739d0d9a718ca@www.akkea.ca>
References: <59ba9f45d76285d13716d915917ef8e0@www.akkea.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from node.akkea.ca ([192.155.83.177]:45704 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933924AbdEWDGk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 22 May 2017 23:06:40 -0400
In-Reply-To: <59ba9f45d76285d13716d915917ef8e0@www.akkea.ca>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Icenowy Zheng <icenowy@aosc.xyz>, Heiner Kallweit <hkallweit1@gmail.com>, linux-mmc@vger.kernel.org

On 2017-05-22 18:02, Angus Ainslie wrote:
> Hi All,
> 
> I have a problem with the SDIO support for the CHIPPRo in 4.12 rc2.
> The SDHC controller gets found but the WiFi chip does not get
> detected.
> 
> [    5.310000] Bluetooth: Generic Bluetooth SDIO driver ver 0.1
> [    5.310000] pwrseq_simple: probe of mmc0_pwrseq failed with error 
> -22
> [    5.320000] sdhci: Secure Digital Host Controller Interface driver
> [    5.330000] sdhci: Copyright(c) Pierre Ossman
> [    5.330000] sdhci-pltfm: SDHCI platform and OF driver helper
> 
> I'm assuming it's because of the pwrseq_simple probe failing.
> 
> If I use the dts file ntc-gr8-crumb.dts for the ntc 4.4.30 kernel the
> SDIO WiFi does get detected.
> 

Sorry this is a side effect of reverting the sunxi clock changes to get 
the NAND working. Without the clock changes the SDIO card gets found.

[    5.300000] sdhci: Secure Digital Host Controller Interface driver
[    5.310000] sdhci: Copyright(c) Pierre Ossman
[    5.320000] sunxi-mmc 1c0f000.mmc: allocated mmc-pwrseq
[    5.380000] sunxi-mmc 1c0f000.mmc: base:0xd01da000 irq:20
[    5.380000] sdhci-pltfm: SDHCI platform and OF driver helper
[    5.390000] usbcore: registered new interface driver usbhid
[    5.400000] usbhid: USB HID core driver
[    5.410000] sun4i-codec 1c22c00.codec: Codec <-> 1c22c00.codec 
mapping ok
[    5.420000] sunxi-mmc 1c0f000.mmc: card claims to support voltages 
below defined range
[    5.440000] NET: Registered protocol family 17
[    5.440000] can: controller area network core (rev 20170425 abi 9)
[    5.450000] NET: Registered protocol family 29
[    5.460000] can: raw protocol (rev 20170425)
[    5.460000] can: broadcast manager protocol (rev 20170425 t)
[    5.470000] can: netlink gateway (rev 20170425) max_hops=1
[    5.480000] Key type dns_resolver registered
[    5.490000] Registering SWP/SWPB emulation handler
[    5.510000] mmc0: new high speed SDIO card at address 0001


