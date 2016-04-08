From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] sdhci: wakeup from runtime PM
Date: Fri, 8 Apr 2016 10:35:00 +0200
Message-ID: <CAPDyKFqJ4Q9hdsv427GaT_2qFpvv=Nn3rZQUS+P8O7FF-gKgyw@mail.gmail.com>
References: <1458921903-11133-1-git-send-email-ludovic.desroches@atmel.com>
	<5703B241.6030007@intel.com>
	<CAPDyKFpvE2N+B3-S+tOKJ7+ViWddpxWxCWRGs2LBjWS9CmMxwA@mail.gmail.com>
	<20160407151208.GA13961@odux.rfo.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20160407151208.GA13961@odux.rfo.atmel.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

- linux-kernel list

On 7 April 2016 at 17:12, Ludovic Desroches <ludovic.desroches@atmel.com> wrote:
> On Thu, Apr 07, 2016 at 11:11:08AM +0200, Ulf Hansson wrote:
>> On 5 April 2016 at 14:40, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> > On 25/03/16 18:05, Ludovic Desroches wrote:
>> >> Hi,
>> >>
>> >> When not using the SDHCI controller, it is logical to save power by suspending
>> >> it. The issue is that SDHCI assumes that the controller is completely disabled.
>> >> It means the only way to wake up on a card event is to have a gpio for the card
>> >> detection (so two pins for the same signal). A possible workaround is to use
>> >> polling but the controller will be resumed/suspended between each attempts.
>> >>

>From power consumption point if view we already discussed this
particular case in an earlier thread, but let me elaborate what I
think one more time:

Now, this is relevant for removable cards lacking GPIO card detect, as
for other cases and non-removable cards I think we are in agreement
that their is no issue from power consumption point of view, right!?

1. The current solution:
- Use MMC_CAP_NEEDS_POLL which makes the mmc core to re-schedule a
work once every second to poll for a card (Why is it one second? Could
we perhaps have that configurable?).

In case of no card inserted, the polling consists of runtime resuming
the SDHCI controller and then reading a couple of registers to find
out if there is a new card. I assume this will be a fast operation. In
the below calculation I have neglected its impact which of course is a
simplification.

This solution allows the driver in runtime suspend to *gate all three
clocks* used by the SDHCI controller. In-between polling attempts it
will thus save power.

Currently the mmc core *always* respects runtime PM autosuspend when
putting the controller device back to runtime suspend. I suggest we
change this in cases when the polling operation doesn't detect any
changes.

For the sdhci-of-at91 driver case, the autosuspend timeout is set to
50 ms (which is a common value among mmc host drivers).

In the current code this means for a period over ~10 s, *all three
clocks* will be ungated for 50 ms x 10 times = ~500 ms.

If we adopt to what I propose above, this time will become significant
lesser as the autosuspend timer will not be respected.

2. What you propose (I think):
* Don't use MMC_CAP_NEEDS_POLL, but instead rely on the SDHCI
controller to pick up card detect IRQs in runtime suspended state.

In case of no card inserted, the controller would then stay runtime
suspended but with IRQs enabled to deal with card detect IRQs.
According to what you told me earlier, this means that the controller
requires one of the three clocks to be ungated in the runtime suspend
state. So, only two clocks can be managed by runtime PM.

Assuming that no cards get inserted over a period of ~10 s, *one clock
will be ungated* for ~10 s.


Can you show that option 2) is better in saving power than option 1) ?

[...]

>> >
>> > I don't mind allowing card detect interrupts while runtime suspended, but we
>> > need a flag so that:
>> > - runtime suspend leaves the insert/remove interrupts enabled
>> > - irq handler knows it can access registers
>>
>> To me, this seem like the wrong way of how to configure wake-ups for
>> these kind of devices.
>
> We are definitely not in agreement on this point. It means I have to
> rely on polling for card detection. I did it but I had in mind it would
> be a temporary workaround while waiting to find a better one.
>
>>
>> I don't think the regular IRQs shall be enabled and the driver
>> shouldn't assume the registers are accessible without first runtime
>> resuming the device.
>>
>> > - irq thread handler knows to runtime resume before doing anything else
>> >
>> > But it seems like you need to persuade Ulf first.
>>
>
> It will be a difficult task :)

Yes, but I have changed my mind earlier... :-)

[...]

>
> I am not arguing for SD card detection wake-up itself but for saving power
> when I don't use my SDHCI controller. I boot Linux without a SD card,
> the controller is runtime suspended, it seems obvious that the controller
> should be resumed when I insert a card. I really want to use runtime PM
> because the controller should be most of the time suspended excepting if the
> rootfs is on the SD card.

I am not sure I understand what you states here, but I assume my upper
elaboration on your proposal is correct!? If not, please try to be a
bit more specific.

Moreover, let's not involve "rootfs" to this discussion, but stay to
discussing removable cards as those are the interesting ones, right!?

[...]

Kind regards
Uffe
