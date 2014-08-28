From: Sonny Rao <sonnyrao@chromium.org>
Subject: Re: [PATCH V2 3/3] mmc: dw_mmc: Dont cut off vqmmc and vmmc
Date: Thu, 28 Aug 2014 10:50:28 -0700
Message-ID: <CAPz6YkXOxunSP9ZT_Ur+i3CicZ+rv-pvTE2M+rvODTqh8PHZrA@mail.gmail.com>
References: <1408715272-13833-1-git-send-email-yuvaraj.cd@samsung.com>
 <1408715272-13833-4-git-send-email-yuvaraj.cd@samsung.com>
 <CAPDyKFqz8sGj2td=ihZXN4zvAqmu9FHZjWdCn-ZRcdHugNHe2g@mail.gmail.com>
 <CAPz6YkXH1mMOTwcLkKdffdUHN+TaCAhpa8oG0h+rFn9i+GMoCw@mail.gmail.com>
 <CAPDyKFqp7oEt9ASmdxrgUwbQ8aTZzAuJ7uD1oGN50iuzPzBfVg@mail.gmail.com>
 <CAD=FV=VQWzhiSU+iULACj+Dp_tDf3SszQ8ELLEGqVEyJJRQy1Q@mail.gmail.com>
 <CAPDyKFo9-5=uPqD8RvLGsYtSCynBFnGGeSCpwLZuzDtW+652hA@mail.gmail.com>
 <CAD=FV=VveHTYmiBu42DJeFFGARV2+1bS6Y2CQM995YkX_O9SQA@mail.gmail.com>
 <CAPDyKFpUU643iXVbxuu9Vx1zY0K7x4z-ZxxVEWd+Lsuwp0iA+g@mail.gmail.com>
 <CAD=FV=Vqz=kA=D5KDyq_QuPi-6B05VixYManTsFe2PC-fzxRkw@mail.gmail.com>
 <CAPDyKFrcA183V-R-nbZcY8wXCRqONb1WUu3BS_0vNJe2+Ej2_w@mail.gmail.com> <CAD=FV=UykPjixODXJ-s6vrZVs3O3=rX2iUakm6WnqiqvJNkoqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=UykPjixODXJ-s6vrZVs3O3=rX2iUakm6WnqiqvJNkoqQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Doug Anderson <dianders@google.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Tomasz Figa <t.figa@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>, Prashanth G <prashanth.g@samsung.com>, ALIM AKHTAR <alim.akhtar@samsung.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, ABHILASH KESAVAN <a.kesavan@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 28, 2014 at 8:50 AM, Doug Anderson <dianders@google.com> wrote:
> Ulf,
>
> On Thu, Aug 28, 2014 at 12:25 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 27 August 2014 17:52, Doug Anderson <dianders@google.com> wrote:
>>> Ulf,
>>>
>>> On Wed, Aug 27, 2014 at 4:17 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>>> Now, we've got MMC_CAP_NEEDS_POLL, so dw_mmc will periodically be
>>>>> called to check the card detect line, but with vmmc and vqmmc off.  It
>>>>> will be unable to return a sensible value without actually turning on
>>>>> vmmc and vqmmc.
>>>>
>>>> Currently MMC_CAP_NEEDS_POLL mean the mmc rescan work will reschedule
>>>> itself with HZ interval. This to check for card insert/removal.
>>>>
>>>> Now, mmc_rescan() will, if present, invoke host's ->get_cd() callback
>>>> to check whether it's worth to continue initialization sequence or if
>>>> it should re-schedule itself again.
>>>>
>>>> If your host driver can distinguish whether a card is inserted, which
>>>> in this case are when vccq is turned off, your ->get_cd() callback need
>>>> to return 1. That will allow mmc_rescan() to continue it's
>>>> initialization sequence and do mmc_power_up().
>>>
>>> As per my other email, we can't tell whether a card is inserted when
>>> vqmmc is off.
>>
>> I understand.
>>
>> The solution I proposed above, is:
>>
>> 1) Enable MMC_CAP_NEEDS_POLL.
>> 2) Make ->get_cd() return 1, when you can't distinguish if the card is inserted.
>>
>> That will solve this issue and without messing up the mmc core.
>
> Ah, I see!  So every 1 second, we'll do the following:
>
> 1. Call get_cd(), which returns 1.
>
> 2. MMC core will power everything up (turn on all regulators) for MMC.
>
> 3. We'll start to initialize a card.
>
> 4. We'll notice that, oops, there's no card there.
>
> 5. MMC core will shut things down again.
>
>
> That seems awfully expensive to do every second when the card detect
> line actually does work (as long as you keep power lines).  Is the
> patch to separate out the concepts of "power off because no card is
> inserted" and "power off because we're power cycling the card" really
> bad enough to warrant forcing us to use the above?
>
> I'm not an EE, but cycling regulators on and off every second doesn't
> seem super ideal, but maybe they're designed for it?
>
>
> Personally, I'd be tempted to just leave the power on all the time and
> if a card somehow needs to be power cycled (because UHS negotiation
> failed?) then that card just isn't supported.  This could be done in
> the dts by saying that the regulator is "always on" and no need to
> pollute any source files.

Yeah, power cycling the regulators constantly doesn't seem like a
great idea, we can ask the EEs what they think.

This scheme of leaving them on all the time would prevent us from
being able to actually power cycle the card, which I think is required
by the spec in case UHS negotiation fails.


>
>
> -Doug
