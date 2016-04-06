From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [bisect] Merge tag 'mmc-v4.6' of git://git.linaro.org/people/ulf.hansson/mmc
 (was [GIT PULL] MMC for v.4.6)
Date: Wed, 6 Apr 2016 10:26:25 +0200
Message-ID: <CAPDyKFrG_sdAUHmYnStWKnBD7jWQHiY7rAXSD5fn3HxQ51UARA@mail.gmail.com>
References: <CAPDyKFqM1ffAdj7jVJmcPW2Wxy88Mhx_UrAzyuXpKSJg1yUPdg@mail.gmail.com>
	<57008645.4070808@hurleysoftware.com>
	<CA+55aFwjQP25NYfjPMTicO-M8yjm5c0aKFx-1saWmrro0c0NVQ@mail.gmail.com>
	<CAPDyKFr6zCm4wBS97bUCwq4qhsM8u3mEpyBf4uicJ_UQ7L-q5w@mail.gmail.com>
	<CA+55aFwFVBg5joDd0QYjmSA6t8TM7tmZvmcArZu3Ar8u4vDecw@mail.gmail.com>
	<CAPDyKFqFoJybrr4dBt8xO7iHt9CAbET=i-v9ZLht7J6K091Phw@mail.gmail.com>
	<20160406154740.51715633@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160406154740.51715633@xhacker>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 6 April 2016 at 09:47, Jisheng Zhang <jszhang@marvell.com> wrote:
> Hi Ulf,
>
> On Tue, 5 Apr 2016 10:59:28 +0200 Ulf Hansson wrote:
>
>> On 4 April 2016 at 20:59, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> > On Mon, Apr 4, 2016 at 4:29 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> >>
>> >> The commit that's likely to cause the regression is:
>> >> 520bd7a8b415 ("mmc: core: Optimize boot time by detecting cards
>> >> simultaneously").
>> >
>> > Peter, mind testing if you can revert that and get the old behavior
>> > back? It seems to still revert cleanly, although I didn't check if the
>> > revert actually then builds..
>>
>> I have checked, the revert should be a safe option. There is nothing
>> added on top that relies on it.
>>
>> Moreover, I have no problem dealing with the revert, as it me
>> personally that screwed this up.
>>
>> >
>> >> This commit further enables asynchronous detection of (e)MMC/SD/SDIO
>> >> cards, by converting from an *ordered* work-queue to a *non-ordered*
>> >> work-queue for card detection.
>> >>
>> >> Although, one should know that there have *never* been any guarantees
>> >> to get a fixed mmcblk id for a card. I expect that's what has been
>> >> assumed here.
>> >
>> > So quite frankly, for the whole "no regressions" issue, "documented
>> > behavior" simply isn't an issue. It doesn't matter one whit or not if
>> > something has been documented: if it has worked and people have
>> > depended on it, it's what we in the industry call "reality".
>> >
>> > And reality trumps documentation. Every time.
>>
>> I totally agree.
>>
>> Although, what puzzles me around this particular issue, is how an SoC
>> configuration can rely on this fragile behaviour.
>> All you have to do to break the assumption of fixed mmcblk ids, is to
>> boot with an SD card inserted and then without. Perhaps these SoCs
>> just doesn't support this use case!?
>
> This use case is supported by carefully always letting emmc host be probed
> before the sd hosts. For example, this can be done by putting the emmc host
> DT node before the SD hosts' ;)

This is just a workaround and it's still *really* fragile.

The workaround you describe, relies on a certain behaviour of the DTS
parsing and the driver core, as you need the the first device in the
DTS to probe first. You are also relying on that the mmc driver
doesn't mess up the probe order by returning -EPROBE_DEFER for the
eMMC slot (because some resources wasn't ready yet).

Anyway, I get the point and thanks for you feedback!

>
> Thanks,
> Jisheng

Kind regards
Uffe
