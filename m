From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH 1/3] mmc: sdio: Add API to manage SDIO IRQs from a workqueue
Date: Wed, 19 Apr 2017 12:29:06 -0700
Message-ID: <CAD=FV=XX-LRdNQytWDQ5N5qEtNQyQH1kmU9KUaT1EnKWG1EvtA@mail.gmail.com>
References: <1492518724-30511-1-git-send-email-ulf.hansson@linaro.org>
 <1492518724-30511-2-git-send-email-ulf.hansson@linaro.org>
 <CAD=FV=XMk4+86WaCWjuf3NVwRoEubjcY+zQhH-hsb=H3sRpw0A@mail.gmail.com> <CAPDyKFqruAXXnp_=6u4i5DnXpjvO_YkCiv-PjooaSQXqjn9z-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:36259 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763523AbdDST3K (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Apr 2017 15:29:10 -0400
Received: by mail-wr0-f169.google.com with SMTP id c55so22068759wrc.3
        for <linux-mmc@vger.kernel.org>; Wed, 19 Apr 2017 12:29:09 -0700 (PDT)
In-Reply-To: <CAPDyKFqruAXXnp_=6u4i5DnXpjvO_YkCiv-PjooaSQXqjn9z-A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Brian Norris <briannorris@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>

Hi,

On Wed, Apr 19, 2017 at 3:48 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 18 April 2017 at 23:43, Doug Anderson <dianders@google.com> wrote:
>> Hi,
>>
>> On Tue, Apr 18, 2017 at 5:32 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> For hosts not supporting MMC_CAP2_SDIO_IRQ_NOTHREAD but MMC_CAP_SDIO_IRQ,
>>> the SDIO IRQs are processed from a dedicated kernel thread. For these
>>> cases, the host calls mmc_signal_sdio_irq() from its ISR to signal a new
>>> SDIO IRQ.
>>>
>>> Signaling an SDIO IRQ makes the host's ->enable_sdio_irq() callback to be
>>> invoked to temporary disable the IRQs, before the kernel thread is woken up
>>> to process it. When processing of the IRQs are completed, they are
>>> re-enabled by the kernel thread, again via invoking the host's
>>> ->enable_sdio_irq().
>>>
>>> The observation from this, is that the execution path is being unnecessary
>>> complex, as the host driver already knows that it needs to temporary
>>> disable the IRQs before signaling a new one. Moreover, replacing the kernel
>>> thread with a work/workqueue would greatly simplify the code.
>>>
>>> To address the above problems, let's continue to build upon the support for
>>> MMC_CAP2_SDIO_IRQ_NOTHREAD, as it already implements SDIO IRQs to be
>>> processed without using the clumsy kernel thread, but it also avoids the
>>> ping-ponging calls of the host's ->enable_sdio_irq() callback for each
>>> processed IRQ.
>>>
>>> Therefore, let's add new API sdio_signal_irq(), which enables hosts to
>>> signal/process SDIO IRQs by using a work/workqueue, rather than using the
>>> kernel thread.
>>>
>>> Add also a new host callback ->ack_sdio_irq(), which the work invokes when
>>> the SDIO IRQs are processed. This informs the host about when it can
>>> re-enable the SDIO IRQs. Potentially, we could re-use the existing
>>> ->enable_sdio_irq() callback for this matter, however it has turned out
>>> that it's more convenient for hosts to get this information via a separate
>>> callback.
>>>
>>> Hosts needs to enable MMC_CAP2_SDIO_IRQ_NOTHREAD to use this new feature,
>>> however the feature is optional for already existing hosts suppporting
>>> MMC_CAP2_SDIO_IRQ_NOTHREAD.
>>>
>>> It's likely that all host can convert to use MMC_CAP2_SDIO_IRQ_NOTHREAD and
>>> benefit from this feature. Further changes will have to tell. Until then
>>> the old path using the kernel thread remains possible.
>>
>> So one other subtle problem with the new approach is that you totally
>> lose all of the polling logic in sdio_irq_thread().
>
> The polling is still there, as I haven't removed the kthread in this series.

The code still exists, but it won't be called, right?

Oh!  Shoot, I see that you only enable the new code in dw_mmc when the
cap is set.  Hrm.


> I was also thinking of the next step, which could move the polling
> inside the work, simply by re-schedule itself.
>
>>
>> ...so if I take your series and then comment out "cap-sdio-irq;" in
>> the veyron "dtsi" then things stop working.  Right now dw_mmc only
>> enables SDIO Interrupts if that bit is set and relies on polling
>> otherwise.  Presumably there's not a _huge_ reason why you would need
>> to make dw_mmc work without actual SDIO IRQ signaling, but the way the
>> code is structured right now things will probably break for some users
>> out there.
>
> Did you actually test this or the conclusion was theoretical?

I did, but I had confirmation bias so upon the first sign of failure I
decided "I must be right--it doesn't work".  :(  Maybe something else
was causing problems.  Trying again now.

OK, let's see:

With "cap-sdio-irq" commented out but without your 3 patches:
=> Boot up, "ifconfig eth0 down; ping -c 20 8.8.8.8".  Seems OK.

With "cap-sdio-irq" commented out but _with_ your 3 patches:
=> Boot up, "ifconfig eth0 down; ping -c 20 8.8.8.8".  Seems OK.

So I guess the conclusion is that I missed the part about your patch
only enabling the new features if MMC_CAP_SDIO_IRQ.  Sorry.  :(
...and then I must have hit some other unrelated failure that I can't
reproduce now and assumed it was your patch's fault.

So basically I would say that I've lightly tested your code.  It's not
code I've stressed a ton, but it survived some basic tests anyway...
:)  The code also looks pretty sane to me.


> I *was* actually thinking of the polling case and I think it should be
> addressed, unless I am missing something of course.
>
> More precisely, in patch2, I make sure MMC_CAP2_SDIO_IRQ_NOTHREAD
> becomes set for dw_mmc, only *if* MMC_CAP_SDIO_IRQ is set. That means
> the polling with the kthread is done for cases when MMC_CAP_SDIO_IRQ
> is unset. Right!?

Yeah, looks right to me now that I have my glasses on.


>> One note is that I remember on exynos5250-snow that we needed to
>> enable a hybrid interrupt/polling mechanism.  The problem we ran into
>> was terribly rare and it was never root caused if there was just some
>> subtle bug or if certain versions of dw_mmc sometimes just dropped
>> interrupts (and the patch was never upstreamed), so possibly we don't
>> care.  ...but having the polling code there as a fallback seems like
>> it could have a benefit.
>
> I see. To be clear, removing the polling is not my intent and isn't
> what the series tries to do.

OK, makes sense.  Just figured I'd mention this in case you had future
plans around this code.  :)
