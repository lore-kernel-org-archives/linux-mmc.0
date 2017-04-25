From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC 2/4] mmc: sdio: Add capability to skip SDIO reset at scan
Date: Tue, 25 Apr 2017 12:46:01 +0200
Message-ID: <CAPDyKFqorfJTVeS+r-qWYTFcAuJ67kmpk1WWQpkeMeQKsVfEcg@mail.gmail.com>
References: <1492769288-7474-1-git-send-email-adrian.hunter@intel.com>
 <1492769288-7474-3-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFq7qWGgyXStJU3XZnGRcqMXZs_z21nJ2vUnCe0Pn-q19Q@mail.gmail.com>
 <ff496ea4-ba9b-387b-2d3b-3bf59b878973@intel.com> <CAPDyKFpDjx9EWLFCR5yejJg5bu3x--ksuOAE33+a_L0FNUW9dw@mail.gmail.com>
 <9ed30be6-9a42-9cd1-f260-9b57da369b05@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <9ed30be6-9a42-9cd1-f260-9b57da369b05@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-mmc@vger.kernel.org

On 25 April 2017 at 09:57, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 25/04/17 10:52, Ulf Hansson wrote:
>> +Grygorii Strashko
>>
>> On 25 April 2017 at 08:21, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 24/04/17 23:33, Ulf Hansson wrote:
>>>> On 21 April 2017 at 12:08, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>> The SDIO card state might be being preserved during hibernation, for
>>>>> example a SDIO wifi card supporting WOWLAN. That state will be lost if an
>>>>> SDIO reset is done. One way to avoid that would be to build mmc core as a
>>>>> module and simply not load it until after attempting to restore the
>>>>> hibernation image. However that won't work if the hibernation image is
>>>>> stored on eMMC which, of course, requires mmc core.
>>>>
>>>> I don't follow here. Are you saying the SDIO card is kept powered in
>>>> hibernation, as to be able to support WOWLAN, right?
>>>
>>> Yes
>>
>> Okay, makes sense!
>>
>>>
>>>>
>>>> Then, it feels plain wrong the mmc_rescan() tries to re-initialize it.
>>>> That should never happen, unless something is broken of course.
>>>
>>> The thing to note about hibernation is that there is a regular boot in
>>> between saving the hibernation image and restoring it again.  At boot time,
>>> the kernel knows almost nothing about whether there is a hibernation image
>>> and whether or not it will be restored.  Consequently it becomes difficult
>>> to avoid mmc_rescan().  As mentioned above, we need mmc_rescan() to
>>> initialize the eMMC so that the hibernation image can be read.
>>
>> What's wrong with using the hibernation callbacks in the struct
>> dev_pm_ops? We already do this.
>
> Here is the scenario.  The kernel has just booted.  User space wants to try
> to restore a hibernation image, if there is one.  So user space loads the
> mmc core because the hibernation image is on eMMC.  Mmc core does an SDIO
> reset on the SDIO card and the state is lost.  It has little to do with pm
> callbacks AFAICS.

Ah, now I see what you mean. I thought the problem was during the
actual restoring of the hibernation image.

Alright, when a boot is triggered by WOWLAN , you want to avoid
sending the reset command for the SDIO card before the
re-initialization of the SDIO card starts.

The problem with this approach is that you can't differentiate between
a cold boot and a boot triggered by WOWLAN, right!? In other words, in
some cases the reset command may be needed while in other it won't.

Maybe you can elaborate more on what exactly what the problem is with
sending the reset command when the boot is triggered from WOWLAN? Yes,
the SDIO card loses its context, but how is that a problem?

[...]

Kind regards
Uffe
