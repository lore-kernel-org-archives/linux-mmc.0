From: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Subject: Re: [PATCH v5 7/8] OMAP: adapt hsmmc to hwmod framework
Date: Sat, 26 Feb 2011 16:59:02 +0530
Message-ID: <AANLkTikXX+jX_3bxkNjRnSfxgGC2gJrkzYP8QRfykzQn@mail.gmail.com>
References: <1298653783-26410-1-git-send-email-kishore.kadiyala@ti.com>
 <1298653783-26410-8-git-send-email-kishore.kadiyala@ti.com>
 <20110225204343.GD20560@atomide.com> <20110225205711.GE20560@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:34625 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751972Ab1BZL3Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 26 Feb 2011 06:29:24 -0500
In-Reply-To: <20110225205711.GE20560@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com

Hi Tony,

On Sat, Feb 26, 2011 at 2:27 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Tony Lindgren <tony@atomide.com> [110225 12:42]:
>> * Kishore Kadiyala <kishore.kadiyala@ti.com> [110225 09:00]:
>> > +static int omap_mmc_init(struct omap_hwmod *oh, void *hsmmcinfo)
>> ...
>>
>> > + =A0 static int mmc_num;
>> > +
>> > + =A0 c +=3D mmc_num;
>>
>> This does not look right..

omap2_hsmmc_info is filled in respective board files and will have a ca=
ll to
omap2_hsmmc_init [hsmm.c].
In omap2_hsmmc_init, it will call omap_hwmod_for_each_by_class which
takes 3 arguments out of which 2nd one is a callback and 3rd one is voi=
d
pointer to be passed to call back if necessary.
With this the callback "omap_mmc_init" will be called multiple times ba=
sed on
the class entry in hwmod data file for each controller.
Say you have 3 controllers as in OMAP3, then "omap_mmc_init" will be
called thrice.
Here the argument "hsmmcinfo" needs to be  incremented for each call, s=
o having
a static mmc_num and incrementing it on each call.

>
> So since mmc_num is static, it gets initialized to 0, then increased
> for each call.. What if you want to intialize controller 1 and 3 but
> not 2?

The current implementation for initialization of MMC controllers will w=
ork
with any of the below  order of devices:
1) MMC1, MMC2, MMC3
2) MMC1, MMC3
3) MMC2, MMC1
4) MMC3, MMC2, MMC1
5) MMC3
=2E...

>
> Also, why do you pass void *hsmmcinfo to the function and then cast
> it to struct omap2_hsmmc_inf *? Why not pass struct omap2_hsmmc_info =
*
> to start with?

Its because the 3rd argument in omap_hwmod_for_each_by_class is void * =
=2E

>
> Regards,
>
> Tony
>

Regards,
Kishore
