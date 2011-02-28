From: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Subject: Re: [PATCH v5 7/8] OMAP: adapt hsmmc to hwmod framework
Date: Mon, 28 Feb 2011 14:39:29 +0530
Message-ID: <AANLkTi=ca9QM3wCTten3iMZ8V+KDCL=y7tfDywcqTJeq@mail.gmail.com>
References: <1298653783-26410-1-git-send-email-kishore.kadiyala@ti.com>
 <1298653783-26410-8-git-send-email-kishore.kadiyala@ti.com>
 <20110225204343.GD20560@atomide.com> <20110225205711.GE20560@atomide.com> <AANLkTikXX+jX_3bxkNjRnSfxgGC2gJrkzYP8QRfykzQn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:50056 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752655Ab1B1JhI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Feb 2011 04:37:08 -0500
In-Reply-To: <AANLkTikXX+jX_3bxkNjRnSfxgGC2gJrkzYP8QRfykzQn@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com

Hi Tony,

On Sat, Feb 26, 2011 at 4:59 PM, Kadiyala, Kishore
<kishore.kadiyala@ti.com> wrote:
> Hi Tony,
>
> On Sat, Feb 26, 2011 at 2:27 AM, Tony Lindgren <tony@atomide.com> wro=
te:
>> * Tony Lindgren <tony@atomide.com> [110225 12:42]:
>>> * Kishore Kadiyala <kishore.kadiyala@ti.com> [110225 09:00]:
>>> > +static int omap_mmc_init(struct omap_hwmod *oh, void *hsmmcinfo)
>>> ...
>>>
>>> > + =A0 static int mmc_num;
>>> > +
>>> > + =A0 c +=3D mmc_num;
>>>
>>> This does not look right..
>
> omap2_hsmmc_info is filled in respective board files and will have a =
call to
> omap2_hsmmc_init [hsmm.c].
> In omap2_hsmmc_init, it will call omap_hwmod_for_each_by_class which
> takes 3 arguments out of which 2nd one is a callback and 3rd one is v=
oid
> pointer to be passed to call back if necessary.
> With this the callback "omap_mmc_init" will be called multiple times =
based on
> the class entry in hwmod data file for each controller.
> Say you have 3 controllers as in OMAP3, then "omap_mmc_init" will be
> called thrice.
> Here the argument "hsmmcinfo" needs to be =A0incremented for each cal=
l, so having
> a static mmc_num and incrementing it on each call.
>
>>
>> So since mmc_num is static, it gets initialized to 0, then increased
>> for each call.. What if you want to intialize controller 1 and 3 but
>> not 2?
>
> The current implementation for initialization of MMC controllers will=
 work
> with any of the below =A0order of devices:
> 1) MMC1, MMC2, MMC3
> 2) MMC1, MMC3
> 3) MMC2, MMC1
> 4) MMC3, MMC2, MMC1
> 5) MMC3
> ....

Sorry , you are correct the current implementation will not work for
above mentioned scenarios.
I will fix this and post updated series


Regards,
Kishore
