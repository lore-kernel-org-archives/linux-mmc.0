From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Setting MMC_CAP_POWER_OFF_CARD on mmc2 leads to filesystem problems on mmc1
Date: Fri, 21 Jan 2011 15:18:54 +0100
Message-ID: <E6C3A477-63F7-4BA0-8E6B-A35A53B3AEA1@dominion.thruhere.net>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: multipart/mixed; boundary=Apple-Mail-11--515245661
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43851 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575Ab1AUOS5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Jan 2011 09:18:57 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: l-o List <linux-omap@vger.kernel.org>, linux-mmc@vger.kernel.org
Cc: madhu.cr@ti.com, cjb@laptop.org, Luciano Coelho <coelho@ti.com>


--Apple-Mail-11--515245661
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi,

I'm trying to bring up a wl1271 sdio expansion board on beagle with =
2.6.37 and I'm running into a weird problem when enabling =
MMC_CAP_POWER_OFF_CARD.

My patch basically does:

--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -270,7 +270,7 @@ static struct omap2_hsmmc_info mmc[] =3D {
       {
               .name           =3D "wl1271",
               .mmc            =3D 2,
-               .caps           =3D MMC_CAP_4_BIT_DATA,
+               .caps           =3D MMC_CAP_4_BIT_DATA | =
MMC_CAP_POWER_OFF_CARD,

And does NOT touch mmc1. But after adding MMC_CAP_POWER_OFF_CARD I get =
tons of:

[   22.259490] mmcblk0: error -110 sending status comand
[   22.264617] mmcblk0: error -110 sending read/write command, response =
0x0, card status 0x0
[   22.273345] mmcblk0: error -110 transferring data, sector 2338228, nr =
3, card status 0x0
[   22.281799] end_request: I/O error, dev mmcblk0, sector 2338228
[   22.288055] mmcblk0: error -110 sending status comand
[   22.293151] mmcblk0: error -110 sending read/write command, response =
0x0, card status 0x0
[   22.301879] mmcblk0: error -110 transferring data, sector 2338229, nr =
2, card status 0x0
[   22.310363] end_request: I/O error, dev mmcblk0, sector 2338229

When using mmcblk0p2 as rootfs. Attached is the complete patch. It looks =
a bit weird because it's using the expansionboard infrastucture I hacked =
together.

I suspect that mmc2 is turning off the shared regulator, but I have =
various people claiming this code (minus the expansionboard detection) =
works with the same regulator setup, so I'm extremely puzzled.

The CC: list was partially generated with the get_maintainer.pl script, =
apologies if I screwed it up.

regards,

Koen


--Apple-Mail-11--515245661
Content-Disposition: attachment;
	filename=0001-omap3-beagleboard-add-WIP-support-for-beagleboardtoy.patch
Content-Type: application/octet-stream;
	name="0001-omap3-beagleboard-add-WIP-support-for-beagleboardtoy.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20b3e1e2b9793b9afa286a1a195b739587fbf85c8c=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Koen=20Kooi=20<koen@beagleboard.org>=0ADate:=20=
Mon,=2020=20Dec=202010=2011:57:56=20+0100=0ASubject:=20[PATCH]=20omap3:=20=
beagleboard:=20add=20WIP=20support=20for=20beagleboardtoys=20WL12xx=20=
board=0A=0ABased=20on=20a=20patch=20by=20Luciano=20Coelho=20=
<luciano.coelho@nokia.com>=0A=0ASigned-off-by:=20Koen=20Kooi=20=
<koen@beagleboard.org>=0A---=0A=20=
arch/arm/mach-omap2/board-omap3beagle.c=20|=20=20=2076=20=
+++++++++++++++++++++++++++++++=0A=201=20files=20changed,=2076=20=
insertions(+),=200=20deletions(-)=0A=0Adiff=20--git=20=
a/arch/arm/mach-omap2/board-omap3beagle.c=20=
b/arch/arm/mach-omap2/board-omap3beagle.c=0Aindex=2064a181e..9285ae7=20=
100644=0A---=20a/arch/arm/mach-omap2/board-omap3beagle.c=0A+++=20=
b/arch/arm/mach-omap2/board-omap3beagle.c=0A@@=20-146,6=20+146,67=20@@=20=
fail0:=0A=20=0A=20char=20expansionboard_name[16];=0A=20=0A+#if=20=
defined(CONFIG_WL1271)=20||=20defined(CONFIG_WL1271_MODULE)=0A+#include=20=
<linux/regulator/fixed.h>=0A+#include=20<linux/wl12xx.h>=0A+=0A+#define=20=
OMAP_BEAGLE_WLAN_EN_GPIO=20=20=20=20(139)=0A+#define=20=
OMAP_BEAGLE_WLAN_IRQ_GPIO=20=20=20(137)=0A+=0A+struct=20=
wl12xx_platform_data=20omap_beagle_wlan_data=20__initdata=20=3D=20{=0A+=09=
.irq=20=3D=20OMAP_GPIO_IRQ(OMAP_BEAGLE_WLAN_IRQ_GPIO),=0A+=09=
.board_ref_clock=20=3D=202,=20/*=2038.4=20MHz=20*/=0A+};=0A+=0A+=20=
static=20struct=20omap2_hsmmc_info=20mmcbbt[]=20=3D=20{=0A+=20=09{=0A+=20=
=09=09.mmc=09=09=3D=201,=0A+=20=09=09.caps=09=09=3D=20MMC_CAP_4_BIT_DATA=20=
|=20MMC_CAP_8_BIT_DATA,=0A+=20=09=09.gpio_wp=09=3D=2029,=0A+=20=09},=0A+=09=
{=0A+=09=09.name=09=09=3D=20"wl1271",=0A+=09=09.mmc=09=09=3D=202,=0A+=09=09=
.caps=09=09=3D=20MMC_CAP_4_BIT_DATA=20|=20MMC_CAP_POWER_OFF_CARD,=0A+=09=09=
.gpio_wp=09=3D=20-EINVAL,=0A+=09=09.gpio_cd=09=3D=20-EINVAL,=0A+=09=09=
.nonremovable=09=3D=20true,=0A+=09},=0A+=20=09{}=09/*=20Terminator=20*/=0A=
+=20};=0A+=0A+static=20struct=20regulator_consumer_supply=20=
beagle_vmmc2_supply=20=3D=20{=0A+=09.supply=20=20=20=20=20=20=20=20=20=3D=20=
"vmmc",=0A+=09.dev_name=20=20=20=20=20=20=20=3D=20"mmci-omap-hs.1",=0A=
+};=0A+=0A+static=20struct=20regulator_init_data=20beagle_vmmc2=20=3D=20=
{=0A+=09.constraints=20=3D=20{=0A+=09=09.valid_ops_mask=20=3D=20=
REGULATOR_CHANGE_STATUS,=0A+=09},=0A+=09.num_consumer_supplies=20=3D=20=
1,=0A+=09.consumer_supplies=20=3D=20&beagle_vmmc2_supply,=0A+};=0A+=0A=
+static=20struct=20fixed_voltage_config=20beagle_vwlan=20=3D=20{=0A+=09=
.supply_name=20=3D=20"vwl1271",=0A+=09.microvolts=20=3D=201800000,=20=20=
/*=201.8V=20*/=0A+=09.gpio=20=3D=20OMAP_BEAGLE_WLAN_EN_GPIO,=0A+=09=
.startup_delay=20=3D=2070000,=20/*=2070ms=20*/=0A+=09.enable_high=20=3D=20=
1,=0A+=09.enabled_at_boot=20=3D=200,=0A+=09.init_data=20=3D=20=
&beagle_vmmc2,=0A+};=0A+=0A+static=20struct=20platform_device=20=
omap_vwlan_device=20=3D=20{=0A+=09.name=20=20=20=20=20=20=20=20=20=20=20=
=3D=20"reg-fixed-voltage",=0A+=09.id=20=20=20=20=20=20=20=20=20=20=20=20=20=
=3D=201,=0A+=09.dev=20=3D=20{=0A+=09=09.platform_data=20=3D=20=
&beagle_vwlan,=0A+=09},=0A+};=0A+#endif=0A+=0A=20#if=20=
defined(CONFIG_ENC28J60)=20||=20defined(CONFIG_ENC28J60_MODULE)=0A=20=0A=20=
#include=20<plat/mcspi.h>=0A@@=20-384,7=20+445,14=20@@=20static=20int=20=
beagle_twl_gpio_setup(struct=20device=20*dev,=0A=20=09}=0A=20=09/*=20=
gpio=20+=200=20is=20"mmc0_cd"=20(input/IRQ)=20*/=0A=20=09mmc[0].gpio_cd=20=
=3D=20gpio=20+=200;=0A+#if=20defined(CONFIG_WL1271)=20||=20=
defined(CONFIG_WL1271_MODULE)=0A+=09if(!strcmp(expansionboard_name,=20=
"fixme-beagletoy"))=20=0A+=09=09omap2_hsmmc_init(mmcbbt);=0A+=09else=0A+=09=
=09omap2_hsmmc_init(mmc);=0A+#else=0A=20=09omap2_hsmmc_init(mmc);=0A=
+#endif=0A=20=0A=20=09/*=20link=20regulators=20to=20MMC=20adapters=20*/=0A=
=20=09beagle_vmmc1_supply.dev=20=3D=20mmc[0].dev;=0A@@=20-788,6=20=
+856,14=20@@=20static=20void=20__init=20omap3_beagle_init(void)=0A=20=09=09=
gpio_export(162,=201);=0A=20=09}=0A=20=0A+=09=
if(!strcmp(expansionboard_name,=20"fixme-beagletoy"))=0A+=09{=0A+=09=09=
if=20(wl12xx_set_platform_data(&omap_beagle_wlan_data))=0A+=09=09=09=
pr_err("error=20setting=20wl12xx=20data\n");=0A+=09=09printk(KERN_INFO=20=
"Beagle=20expansionboard:=20registering=20wl12xx=20platform=20=
device\n");=0A+=09=09platform_device_register(&omap_vwlan_device);=0A+=09=
}=0A+=0A=20=09usb_musb_init(&musb_board_data);=0A=20=09=
usb_ehci_init(&ehci_pdata);=0A=20=09omap3beagle_flash_init();=0A--=20=0A=
1.6.6.1=0A=0A=

--Apple-Mail-11--515245661--
