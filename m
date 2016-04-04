From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [bisect] Merge tag 'mmc-v4.6' of
 git://git.linaro.org/people/ulf.hansson/mmc (was [GIT PULL] MMC for v.4.6)
Date: Mon, 4 Apr 2016 09:56:39 -0700
Message-ID: <57029CC7.6080503@hurleysoftware.com>
References: <CAPDyKFqM1ffAdj7jVJmcPW2Wxy88Mhx_UrAzyuXpKSJg1yUPdg@mail.gmail.com>
 <57008645.4070808@hurleysoftware.com>
 <CA+55aFwjQP25NYfjPMTicO-M8yjm5c0aKFx-1saWmrro0c0NVQ@mail.gmail.com>
 <CAPDyKFr6zCm4wBS97bUCwq4qhsM8u3mEpyBf4uicJ_UQ7L-q5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFr6zCm4wBS97bUCwq4qhsM8u3mEpyBf4uicJ_UQ7L-q5w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 04/04/2016 04:29 AM, Ulf Hansson wrote:
> On 3 April 2016 at 13:54, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> On Sat, Apr 2, 2016 at 9:56 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>>
>>> Note how mmc1 => mmcblk0 and mmc0 => mmcblk1.
>>>
>>> This produces a failure to boot as the wrong partition is mounted as
>>> root (/dev/mmcblk0p2 is now on the wrong mmc).
>>
>> It *looks* very much like somebody is doing asynchronous probing of
>> the bus, meaning that the devices get probed in random order.
> 
> Correct.
> 
>>
>> And that "random order" is admittedly probably usually fairly static
>> on any particular hardware platform, but then something happens to
>> change timing, and...
>>
>> This is why you should never probe the actual *bus* asynchronously,
>> just do the end-point setup async. For example, you'd enumerate ports
>> (and assign devices to the ports) synchronously, but then after device
>> assignment the actual device probing can be async.
> 
> So to do this, we need to tie the mmc/sd/sdio controller to a
> dedicated mmcblk id.
> 
> There have been some ideas to fix this by using "aliases" in a DT
> based configuration.
> 
>>
>>> The bisect tried all the mmc tree patches which were all good.
>>> I double-checked by cloning the mmc tree and building both mmc-v4.6
>>> and v4.5-rc6, and both tested good.
>>>
>>> I interpret that to mean some change in mmc + some new behavior elsewhere
>>> for v4.6 is causing this. Any ideas?
>>
>> Hmm. If it really is just timing, it could have been around forever,
>> and just hidden by the fact that normally mmc0 gets probed before
>> mmc1, but then some other probing thing slowed down or the exact
>> details of the async workqueue  scheduling changed, and now mmc1 just
>> *happens* to get probed first..
>>
>> The thing that changed scheduling order could easily have come from
>> some non-mmc change.
>>
>> NOTE! I have nothing to back this up except that (a) we've had
>> problems like this before and (b) it does look from your dmesg that
>> mmcX is simply probed in the "wrong" order. I didn't look at exactly
>> what mmc does or who does the probing.
>>
>> Maybe Ulf can explain what it is that is _supposed_ to keep the mmc
>> probe order stable. Ulf?
>>
>>              Linus
> 
> The commit that's likely to cause the regression is:
> 520bd7a8b415 ("mmc: core: Optimize boot time by detecting cards
> simultaneously").
> 
> This commit further enables asynchronous detection of (e)MMC/SD/SDIO
> cards, by converting from an *ordered* work-queue to a *non-ordered*
> work-queue for card detection.
> 
> Although, one should know that there have *never* been any guarantees
> to get a fixed mmcblk id for a card. I expect that's what has been
> assumed here.

Tell me about it. I'm in the middle of reverting non-blocking read()
behavior since 3.12 because _one_ userspace app relies on *blocking*
non-blocking read() behavior that existed before 3.12.


> Let me elaborate a bit on the card detection procedure. When the mmc
> controller has been successfully probed, its driver schedules a work
> to start enumeration of cards. Only cards that gets detected
> successfully becomes registered and those gets an mmcblk id assigned
> to it. The picked id, is the first available starting from zero. Now,
> as cards can be removable and because drivers for mmc controllers may
> sometimes returns -EPROBE_DEFER (for whatever reason), there's never
> been support for fixed mmcblk ids.
> 
> To deal with this, one should use the so called UUID/PARTUUID. Is
> there any reasons to why that can't be done in this case?

Well, I can.
But I'm not volunteering to update the other 250,000+ bootloader scripts
that do "root=/dev/mmcblk0p2"

Regards,
Peter Hurley
