From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: mmc: sdio: runtime PM and 8686 problems
Date: Thu, 26 Apr 2012 16:51:10 -0700
Message-ID: <CAGDS+n=bYK4_RZMd9TeKTGafi6k9JQmu1u2ELuUQecTKxJ_gfg@mail.gmail.com>
References: <WC20111118085327.010279@terrafix.co.uk>
	<CAK=WgbZvcTqmpT0jWT1b-GN1e5091AikAfL88Q8Z66dsOXx6Og@mail.gmail.com>
	<WC20111118100011.2902A2@terrafix.co.uk>
	<CAK=WgbaJ-q4TqgV5tdPQPm6CT9roceqn6QMxEJgA=Prd52jVEQ@mail.gmail.com>
	<WC20111129111750.470087@terrafix.co.uk>
	<CAK=Wgbb6s_BGfJYAoH3V77QvWoAXVAchg0ojBx4Mbmgq8bgvWw@mail.gmail.com>
	<CAMLZHHRF2ygqBRyNm21vv0WnCYKPtduGpW7ME25z55v7nTaRnA@mail.gmail.com>
	<CAK=WgbY22BD8WWk71nL3=D3NZfJY92LXUum8yhV3JyHypjOe-g@mail.gmail.com>
	<CAMLZHHRfitBnmXi=2ndvm5-jm1Mg4+NT83rjuwD9w236E12hQw@mail.gmail.com>
	<CAK=WgbYRvsOur6RmAYMEAf-01e-paGinPU4G_0VesacPGBD5GA@mail.gmail.com>
	<CAK=WgbaKFhknaDVEbPjmcWGL-F_DiYG0t1t-cB-sGWHPCOBErA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:33770 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692Ab2DZXvL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Apr 2012 19:51:11 -0400
Received: by qatm19 with SMTP id m19so39381qat.19
        for <linux-mmc@vger.kernel.org>; Thu, 26 Apr 2012 16:51:10 -0700 (PDT)
In-Reply-To: <CAK=WgbaKFhknaDVEbPjmcWGL-F_DiYG0t1t-cB-sGWHPCOBErA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Chris Ball <cjb@laptop.org>, Joe Woodward <jw@terrafix.co.uk>, linux-mmc@vger.kernel.org, Neil Brown <neilb@suse.de>, Bing Zhao <bzhao@marvell.com>, Daniel Drake <dsd@laptop.org>

On Mon, Dec 19, 2011 at 1:10 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:

> We're slowly progressing towards understanding the issues we have wit=
h
> the 8686 (it seems there are a few different hw revisions of it, some
> of which do require toggling the reset pin before sending another ini=
t
> sequence), but it might take some more time until a solution fully
> materializes.
>
> Since 3.2 is just around the corner, I suggest we should now proceed
> with the revert (see patch below), and later revisit this once we hav=
e
> a complete solution in hand.

Has any progress been made on this issue?

I too have been trying to power down/up the wifi module on the Overo.
I'm seeing the same issue described in this thread.

Some additional data:

I rebuilt my kernel (3.2) with a CD GPIO enabled for the mmc port the m=
odule
is connected to and in turn connected that GPIO to another one that I
can toggle from user space.

Toggling the CD GPIO after powering back up the module does indeed
work properly -- the module is detected, the driver loaded, and proper =
function
restored.

So basically the procedure I've used is:

- decide wifi can be powered down
- unload the libertas modules
- put the wifi hw in reset with gpio16
- wait till wifi is needed again
- take the chip out of reset
- toggle the CD gpio
- libertas modules are autoloaded, as is the firmware
- wifi is up and functioning

So the next step is to get rid of the silly two GPIO external hardware
hack.  Is it possible to trigger a card insertion/removal event via
some standard API?

Or does the above information provide a clue as to why normal code
paths don't work?

Any other ideas?

Steve


>> When SDIO runtime PM was originally introduced, we immediately faced
>> two regressions with two different chipsets, and in response decided
>> not to enable it by default.
>>
>> With your work on the 8686 we hoped we found all the gotchas, so
>> 08da834 did make sense (at least experimentally).
>>
>> Unfortunately we now see that some setups out there still refuse to
>> work when SDIO runtime PM is enabled by default, and obviously we
>> can't live with these kind of regressions.
>>
>> commit fd9fec7a00f58a16803e37a99a014ef82543ef6f
>> Author: Ohad Ben-Cohen <ohad@wizery.com>
>> Date: =A0 Wed Nov 30 16:22:13 2011 +0200
>>
>> =A0 =A0Revert "mmc: enable runtime PM by default"
>>
>> =A0 =A0When SDIO runtime PM was originally introduced, we immediatel=
y faced
>> =A0 =A0two regressions with two different chipsets, and in response =
decided
>> =A0 =A0not to enable it by default.
>>
>> =A0 =A0With the recent work on the 8686 we hoped we found all the go=
tchas,
>> =A0 =A0so 08da834 did make sense (at least experimentally).
>>
>> =A0 =A0Unfortunately we now see that some setups out there still ref=
use to work
>> =A0 =A0when SDIO runtime PM is enabled by default (see
>> =A0 =A0http://www.spinics.net/lists/linux-mmc/msg11161.html), and ob=
viously we
>> =A0 =A0can't live with these kind of regressions.
>>
>> =A0 =A0This reverts commit 08da834a24312157f512224691ad1fddd11c1073.
>>
>> =A0 =A0Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>> =A0 =A0Cc: Daniel Drake <dsd@laptop.org>
>>
>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>> index e8a5eb3..d31c78b 100644
>> --- a/drivers/mmc/core/host.c
>> +++ b/drivers/mmc/core/host.c
>> @@ -302,17 +302,6 @@ struct mmc_host *mmc_alloc_host(int extra, stru=
ct
>> device *dev)
>> =A0 =A0 =A0 =A0host->max_blk_size =3D 512;
>> =A0 =A0 =A0 =A0host->max_blk_count =3D PAGE_CACHE_SIZE / 512;
>>
>> - =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0* Enable runtime power management by default. This =
flag was added due
>> - =A0 =A0 =A0 =A0* to runtime power management causing disruption fo=
r some users, but
>> - =A0 =A0 =A0 =A0* the power on/off code has been improved since the=
n.
>> - =A0 =A0 =A0 =A0*
>> - =A0 =A0 =A0 =A0* We'll enable this flag by default as an experimen=
t, and if no
>> - =A0 =A0 =A0 =A0* problems are reported, we will follow up later an=
d remove the flag
>> - =A0 =A0 =A0 =A0* altogether.
>> - =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 host->caps =3D MMC_CAP_POWER_OFF_CARD;
>> -
>> =A0 =A0 =A0 =A0return host;
>>
>> =A0free:
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
