From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH V4] mmc: Set suspend/resume bus operations if
 CONFIG_PM_RUNTIME is used
Date: Sun, 29 Jan 2012 11:01:41 +0800
Message-ID: <CAGsJ_4wCAD+Wb2RhC6bdni99YBFd1gS10mV2bO4aTmqrdkaehA@mail.gmail.com>
References: <20120110181803.0200A3835E@ushik.mtv.corp.google.com>
 <CAGsJ_4wetB3SKDoBg7=qNxEYtOrT8UD59eVwYPKJ+gvb7d3gqQ@mail.gmail.com>
 <CAH7ZN-yi-q=bX2SpKH1X39mO8Usoe0uSJQmx+k_KjSeHsUPwAA@mail.gmail.com> <CAGsJ_4wJuRH2rmAxpnAMARB6u6+wd0auTzNZoVk7mW4Yg6ucbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:37953 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500Ab2A2DCE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 28 Jan 2012 22:02:04 -0500
Received: by bkas6 with SMTP id s6so2356898bka.19
        for <linux-mmc@vger.kernel.org>; Sat, 28 Jan 2012 19:02:02 -0800 (PST)
In-Reply-To: <CAGsJ_4wJuRH2rmAxpnAMARB6u6+wd0auTzNZoVk7mW4Yg6ucbw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dmitry Shmidt <dimitrysh@google.com>
Cc: linux-mmc@vger.kernel.org, Bin Shi <bin.shi@csr.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>

> 2012/1/12 Dmitry Shmidt <dimitrysh@google.com>
>>
>> On Tue, Jan 10, 2012 at 6:44 PM, Barry Song <21cnbao@gmail.com> wrot=
e:
>> > 2012/1/10 Dmitry Shmidt <dimitrysh@google.com>:
>> >> Signed-off-by: Dmitry Shmidt <dimitrysh@google.com>

Acked-by: Barry Song <Baohua.Song@csr.com>

>> >
>> > Hi Dmitry,
>> > after you move mmc_bus_suspend, mmc_bus_resume to dev_pm_ops, whil=
e
>> > doing hiberantion by swsusp, suspend/resume will not be called by =
the
>> > hibernation flow since it will move to call freeze/thaw/restore. i=
f we
>> > don't stop blk queue for SD while doing hibernation, SD card will =
hang
>> > in the processing of restoring system.
>> >
>> > pls note Bin's patch "mmc: core: move suspend/resume to dev_pm_ops=
 and
>> > add hibernation support"
>> > http://www.spinics.net/lists/linux-mmc/msg12007.html
>> > he has done some duplicated job with you except adding swsusp supp=
ort.
>> >
>> > -barry
>>
>> Hi Barry,
>>
>> Definitely I didn't cover hibernation support.
>> Bin's patch resolves the problem I tried to address, so I am ok with
>> his version.

sorry. as i checked again, yours actually covered hibernation support
since SET_SYSTEM_SLEEP_PM_OPS is defined as:

#ifdef CONFIG_PM_SLEEP
#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
        .suspend =3D suspend_fn, \
        .resume =3D resume_fn, \
        .freeze =3D suspend_fn, \
        .thaw =3D resume_fn, \
        .poweroff =3D suspend_fn, \
        .restore =3D resume_fn,
#else
#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
#endif

both s2ram and s2disk entries are set in SET_SYSTEM_SLEEP_PM_OPS.  so
i'd like to ack your patch directly.

>
> i think maybe merging yours and bin's is better. i'd like to send v4
> with your and bin's sob and think you as the author of the patch.
> at least, SET_SYSTEM_SLEEP_PM_OPS and SET_RUNTIME_PM_OPS are better u=
sed.
>
>>
>> Thanks,
>>
>> Dmitry
>>
>> >
>> >> ---
>> >> =C2=A0drivers/mmc/card/block.c | =C2=A0 =C2=A04 ++--
>> >> =C2=A0drivers/mmc/core/bus.c =C2=A0 | =C2=A0 25 ++++++++---------=
--------
>> >> =C2=A0include/linux/mmc/card.h | =C2=A0 =C2=A02 +-
>> >> =C2=A03 files changed, 11 insertions(+), 20 deletions(-)

-barry
