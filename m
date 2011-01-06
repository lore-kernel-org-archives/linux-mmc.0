From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH] Support Mobile Storage controller Interface
Date: Thu, 6 Jan 2011 16:40:32 +0900
Message-ID: <AANLkTikdzjESvq_pd94dd7dky7mV879aT3e9Zuy7wgNK@mail.gmail.com>
References: <00c401cbad49$fca5c010$f5f14030$%kim@samsung.com>
	<00da01cbad60$96c10950$c4431bf0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50431 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105Ab1AFHke convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Jan 2011 02:40:34 -0500
Received: by wyb28 with SMTP id 28so16146841wyb.19
        for <linux-mmc@vger.kernel.org>; Wed, 05 Jan 2011 23:40:33 -0800 (PST)
In-Reply-To: <00da01cbad60$96c10950$c4431bf0$%kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, prakity@marvell.com, afleming@gmail.com, akpm@linux-foundation.org, hyuk1.lee@samsung.com, jh0801.jung@samsung.com, chaos.youn@samsung.com, Sangbeom Kim <sbkim73@samsung.com>

On Thu, Jan 6, 2011 at 2:14 PM, Kukjin Kim <kgene.kim@samsung.com> wrot=
e:
> Jaehoon Chung wrote:
>>
>> I tried to use mobile storage with sdhci-controller, but bit control=
ling
> is
>> too many different
>> So need Mobile Storage controller.
>>
>> I tested only 8-bit buswidth. It's working well...i think performanc=
e
>> didn't ensure yet.
>> It should be add DDR feature.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> =A0drivers/mmc/host/Kconfig =A0| =A0 12 +
>> =A0drivers/mmc/host/Makefile | =A0 =A01 +
>> =A0drivers/mmc/host/mshci.c =A0| 1499
>> +++++++++++++++++++++++++++++++++++++++++++++
>> =A0drivers/mmc/host/mshci.h =A0| =A0364 +++++++++++
>> =A04 files changed, 1876 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/mmc/host/mshci.c
>> =A0create mode 100644 drivers/mmc/host/mshci.h
>>
> (Cc'ed regarding engineer in my team)
>
> Wow, almost same driver is in my team's git tree except
> author(MODULE_AUTHOR) and small fix.
> (git://git.kernel.org/pub/scm/linux/kernel/git/kki_ap/linux-2.6-samsu=
ng.git)
>
> Both have same comments...and in addition, same typo!!! :-(
>
> Actually, we had a plan to submit it, this driver is under test on bo=
ard and
> we still fixing this now.

Wow, almost same answer, "we had a plan". To address this one, you or
your team send the patch early to remove duplicated works at our side.
As it doesn't appeared at mainline kernel, we implement the codes from
scratch.

The previous time, I sent the this topic, but there's no response and
no one interested
[RFC] Mobile Storage Host support,
http://www.spinics.net/lists/linux-mmc/msg03595.html

I think we wait for long time doesn't it?

I also welcome other MMC developers opinions.

Thank you,
Kyungmin Park

>
> I would welcome MMC maintainer, Chris' response(or any other response=
) about
> this.
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
