From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: Setting MMC_CAP_POWER_OFF_CARD on mmc2 leads to filesystem
 problems on mmc1
Date: Sat, 22 Jan 2011 12:36:05 +0200
Message-ID: <AANLkTi=H2rJkbZnuuS7jfrXE6WunzhTYKGk+ZFPjOivp@mail.gmail.com>
References: <E6C3A477-63F7-4BA0-8E6B-A35A53B3AEA1@dominion.thruhere.net> <1295621342.1925.139.camel@pimenta>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34399 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625Ab1AVKg0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Jan 2011 05:36:26 -0500
In-Reply-To: <1295621342.1925.139.camel@pimenta>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: l-o List <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "cjb@laptop.org" <cjb@laptop.org>, Luciano Coelho <coelho@ti.com>

Hi Koen,

On Fri, Jan 21, 2011 at 4:49 PM, Luciano Coelho <coelho@ti.com> wrote:
>> My patch basically does:
>>
>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>> @@ -270,7 +270,7 @@ static struct omap2_hsmmc_info mmc[] =3D {
>> =A0 =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "wl1271=
",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.mmc =A0 =A0 =A0 =A0 =A0 =A0=3D 2,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .caps =A0 =A0 =A0 =A0 =A0 =3D MMC_CAP_=
4_BIT_DATA,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .caps =A0 =A0 =A0 =A0 =A0 =3D MMC_CAP_=
4_BIT_DATA | MMC_CAP_POWER_OFF_CARD,
>>
>> And does NOT touch mmc1. But after adding MMC_CAP_POWER_OFF_CARD I g=
et tons of:


Hmm. The snippet above looks different in your patch.

It seems that you're adding a new mmcbbt array, along with the
existing mmc one, but still using unchanged board-omap3beagle code,
and I suspect you have some unhealthy  mmc/mmcbbt references.

Particularly, look at this:

@@ -384,7 +445,14 @@ static int beagle_twl_gpio_setup(struct device *de=
v,
 	}
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd =3D gpio + 0;
+#if defined(CONFIG_WL1271) || defined(CONFIG_WL1271_MODULE)
+	if(!strcmp(expansionboard_name, "fixme-beagletoy"))
+		omap2_hsmmc_init(mmcbbt);
+	else
+		omap2_hsmmc_init(mmc);
+#else
 	omap2_hsmmc_init(mmc);
+#endif

 	/* link regulators to MMC adapters */
 	beagle_vmmc1_supply.dev =3D mmc[0].dev;

When WL1271 is configured, and you have your "fixme-beagletoy"
expansionboard around, you're only initializing mmcbbt, but still
using mmc for regulators references.

Care to check if fixing that makes your issues go away ?

Thanks,
Ohad.
