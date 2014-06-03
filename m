From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: autosleep suspend too frquent problem
Date: Tue, 3 Jun 2014 23:53:23 +0200
Message-ID: <CAPDyKFqnC1u_Nhe7sJrAzBc8YktDUJC4KAKTPtYVK-Qk6mmk0A@mail.gmail.com>
References: <35FD53F367049845BC99AC72306C23D1029A27656A2D@CNBJMBX05.corpusers.net>
	<20140603120128.GA5080@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20140603120128.GA5080@amd.pavel.ucw.cz>
Sender: linux-pm-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Wang, Yalin" <Yalin.Wang@sonymobile.com>, "len.brown@intel.com" <len.brown@intel.com>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 3 June 2014 14:01, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>
>> I found sd card sometimes are damaged/ destroyed
>> On our devices .
>> And seems it is caused by kernel's frequently suspend/resume,
>> Because during suspend/resume, the driver will suspend/resume sdcard
>> Very frequently, this will damaged the sdcard sometimes, and the dam=
age
>> is not recoverable ..
>>
>> Sometimes kernel will enter suspend and exit suspend very frequently=
,
>> Especially when the system is in idle, but some driver is not idle,
>> And it will  wake up the system by irq frequently.
>> By our power test result, if system enter suspend /resume very frequ=
ently,
>> Will consume more power , because it will enable /disable many devic=
es
>> During a short time .
>>
>> I make a patch to prevent the system to enter suspend/resume state
>> More than one time during 2 seconds=EF=BC=9A
>
> It is good you managed to diagnose the problem, but this si not the
> right solution.
>
> Either:
>
> 1) don't power down SD card during system suspend

NAK. The amount of power a card (even if there are good behaving cards
as well) may utilize, in powered but idle state could be significant.
I have seen cases of constant power consumption of several mA here.

>
> or maybe even better
>
> 2) don't power _up_ SD card during system resume. Let it be powered
> down until the first access.

Good news! This is "almost" supported already by the mmc subsystem.

If your mmc host has set the capability flag MMC_CAP_RUNTIME_RESUME,
that means the card won't be powered up (and initialized) until the
next request.

However, for removable cards (!MMC_CAP_NONREMOVABLE), during system
resume phase, the mmc core will trigger a "rescan" of the card, to
verify it has not been removed. Thus, unfortunate for this use case,
the first request (for removable cards) will be triggered during the
system resume phase.

I suppose we should add some extra conditions/flags which makes the
mmc core to handle the above scenario. Actually I have been thinking
of putting together a patch for this, but it never pops up on the top
of my TODO list. :-)

Additionally, I wonder if this bouncing up and down from suspend to
resume, could have other negative impact for other subsystems? Is it
just a mmc subsystem problem? I am not so sure.

Kind regards
Ulf Hansson

>
> Thanks,
>                                                                      =
   Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/hors=
es/blog.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
