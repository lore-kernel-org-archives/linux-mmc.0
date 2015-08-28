From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RESEND PATCH] mmc: core: fix race condition in
 mmc_wait_data_done
Date: Fri, 28 Aug 2015 21:51:28 +0800
Message-ID: <55E06760.8020308@rock-chips.com>
References: <1440731589-22241-1-git-send-email-shawn.lin@rock-chips.com>
 <55DFD4B7.3070601@rock-chips.com>
 <CAPDyKFqZXx11qsnPH_uTDptfkUFfDykNKPgVcH6AW5CbH6Fi8g@mail.gmail.com>
 <55E02F7C.1020204@rock-chips.com>
 <CAPDyKFqYDdwvTCw3oKhkxqu9zmTAC8osLgd6eC4zDY7JOMGGPQ@mail.gmail.com>
 <1243788837884e859a8959cf8265125c@SC-EXCH04.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1243788837884e859a8959cf8265125c@SC-EXCH04.marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jialing Fu <jlfu@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

=E5=9C=A8 2015/8/28 18:22, Jialing Fu =E5=86=99=E9=81=93:
>
> [...]
>
>>>> Hi, ulf
>>>>
>>>> We find this bug on Intel-C3230RK platform for very small probabil=
ity.
>>>>
>>>> Whereas I can easily reproduce this case if I add a mdelay(1) or
>>>> longer delay as Jialing did.
>>>>
>>>> This patch seems useful to me. Should we push it forward? :)
>>>
>>>
>>> It seems like a very good idea!
>>>
>>> Should we add a fixes tag to it?
>>
>>
>> That's cool, but how to add a fixes tag?
>>
>> [Fixes] mmc: core: fix race condition in mmc_wait_data_done ?   :)
>>
>
> A fixes tag points to an old commit which introduced the bug. If we c=
an't find one, we can add a Cc tag to "stable". Just search the git log=
 and you will find examples.
>
> Like add one line as below?
> Fixes: 2220eedfd7ae ("mmc: fix async request mechanism for sequential=
 read scenarios")
>

That's it, Jialing. From my git blame, seems this bug has been=20
introduced for a long time, but I feel strange that no one had captured=
=20
it before you did.

Anyway, I will add a fixes tag and send v2 ASAP. :)

>
> Kind regards
> Uffe
>


--=20
Best Regards
Shawn Lin
