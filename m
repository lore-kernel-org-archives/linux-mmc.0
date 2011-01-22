From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: Setting MMC_CAP_POWER_OFF_CARD on mmc2 leads to filesystem problems on mmc1
Date: Sat, 22 Jan 2011 16:30:00 +0100
Message-ID: <EC9B76BF-F0F4-4F8C-9C6D-5CE311B2785C@dominion.thruhere.net>
References: <E6C3A477-63F7-4BA0-8E6B-A35A53B3AEA1@dominion.thruhere.net> <1295621342.1925.139.camel@pimenta> <AANLkTi=H2rJkbZnuuS7jfrXE6WunzhTYKGk+ZFPjOivp@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41847 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753331Ab1AVPaE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Jan 2011 10:30:04 -0500
In-Reply-To: <AANLkTi=H2rJkbZnuuS7jfrXE6WunzhTYKGk+ZFPjOivp@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: l-o List <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "cjb@laptop.org" <cjb@laptop.org>, Luciano Coelho <coelho@ti.com>


Op 22 jan 2011, om 11:36 heeft Ohad Ben-Cohen het volgende geschreven:

> Hi Koen,
> 
> On Fri, Jan 21, 2011 at 4:49 PM, Luciano Coelho <coelho@ti.com> wrote:
>>> My patch basically does:
>>> 
>>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>>> @@ -270,7 +270,7 @@ static struct omap2_hsmmc_info mmc[] = {
>>>        {
>>>                .name           = "wl1271",
>>>                .mmc            = 2,
>>> -               .caps           = MMC_CAP_4_BIT_DATA,
>>> +               .caps           = MMC_CAP_4_BIT_DATA | MMC_CAP_POWER_OFF_CARD,
>>> 
>>> And does NOT touch mmc1. But after adding MMC_CAP_POWER_OFF_CARD I get tons of:
> 
> 
> Hmm. The snippet above looks different in your patch.
> 
> It seems that you're adding a new mmcbbt array, along with the
> existing mmc one, but still using unchanged board-omap3beagle code,
> and I suspect you have some unhealthy  mmc/mmcbbt references.
> 
> Particularly, look at this:
> 
> @@ -384,7 +445,14 @@ static int beagle_twl_gpio_setup(struct device *dev,
> 	}
> 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
> 	mmc[0].gpio_cd = gpio + 0;
> +#if defined(CONFIG_WL1271) || defined(CONFIG_WL1271_MODULE)
> +	if(!strcmp(expansionboard_name, "fixme-beagletoy"))
> +		omap2_hsmmc_init(mmcbbt);
> +	else
> +		omap2_hsmmc_init(mmc);
> +#else
> 	omap2_hsmmc_init(mmc);
> +#endif
> 
> 	/* link regulators to MMC adapters */
> 	beagle_vmmc1_supply.dev = mmc[0].dev;
> 
> When WL1271 is configured, and you have your "fixme-beagletoy"
> expansionboard around, you're only initializing mmcbbt, but still
> using mmc for regulators references.
> 
> Care to check if fixing that makes your issues go away ?

That was indeed the problem, not I get:

[   35.417053] wl1271: firmware booted (Rev 6.1.0.0.343)

and

root@beagleboard-xm-next:~# ifconfig wlan0 hw eth 00:11:22:33:44:55
root@beagleboard-xm-next:~# iwlist wlan0 scanning | grep ESSID | wc -l
13

That get's me a lot further!

regards,

Koen

