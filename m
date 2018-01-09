From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/9] mmc: sdhci-pci: Stop calling sdhci_enable_irq_wakeups()
Date: Tue, 9 Jan 2018 08:14:37 +0100
Message-ID: <CAPDyKFoTHVEWsK0fPG5HSKufCkj=Y0rkcOS=EbnJhhseikCbaA@mail.gmail.com>
References: <1513757933-11232-1-git-send-email-adrian.hunter@intel.com>
 <b9801ecc-eaf4-7efc-fff0-3cbd40f29c9a@intel.com> <CAPDyKFrZjTvYdT8BGKadTdTBsaAeoC3YOQBBPOvqpv1JpaOUoQ@mail.gmail.com>
 <1746209.FfylcBGxWs@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1746209.FfylcBGxWs@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, Haridhar Kalvala <haridhar.kalvala@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-mmc@vger.kernel.org

On 9 January 2018 at 01:46, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, December 21, 2017 4:33:59 PM CET Ulf Hansson wrote:
>> + linux-pm, Rafael, Geert
>>
>> On 21 December 2017 at 15:25, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> > On 21/12/17 16:15, Ulf Hansson wrote:
>> >> On 20 December 2017 at 09:18, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> >>> sdhci_enable_irq_wakeups() is already called by sdhci_suspend_host() so
>> >>> sdhci-pci should not need to call it. However sdhci_suspend_host() only
>> >>> calls it if wakeups are enabled, and sdhci-pci does not enable them until
>> >>> after calling sdhci_suspend_host(). So move the calls to
>> >>> sdhci_pci_init_wakeup() before calling sdhci_suspend_host(), and
>> >>> stop calling sdhci_enable_irq_wakeups(). That results in some
>> >>> simplification because sdhci_pci_suspend_host() and
>> >>> __sdhci_pci_suspend_host() no longer need to be separate functions.
>> >>>
>> >>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> >>> ---
>> >>>  drivers/mmc/host/sdhci-pci-core.c | 58 ++++++++++++++-------------------------
>> >>>  1 file changed, 21 insertions(+), 37 deletions(-)
>> >>>
>> >>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
>> >>> index 110c634cfb43..2ffc09f088ee 100644
>> >>> --- a/drivers/mmc/host/sdhci-pci-core.c
>> >>> +++ b/drivers/mmc/host/sdhci-pci-core.c
>> >>> @@ -39,10 +39,29 @@
>> >>>  static void sdhci_pci_hw_reset(struct sdhci_host *host);
>> >>>
>> >>>  #ifdef CONFIG_PM_SLEEP
>> >>> -static int __sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
>> >>> +static int sdhci_pci_init_wakeup(struct sdhci_pci_chip *chip)
>> >>> +{
>> >>> +       mmc_pm_flag_t pm_flags = 0;
>> >>> +       int i;
>> >>> +
>> >>> +       for (i = 0; i < chip->num_slots; i++) {
>> >>> +               struct sdhci_pci_slot *slot = chip->slots[i];
>> >>> +
>> >>> +               if (slot)
>> >>> +                       pm_flags |= slot->host->mmc->pm_flags;
>> >>> +       }
>> >>> +
>> >>> +       return device_init_wakeup(&chip->pdev->dev,
>> >>> +                                 (pm_flags & MMC_PM_KEEP_POWER) &&
>> >>> +                                 (pm_flags & MMC_PM_WAKE_SDIO_IRQ));
>> >>
>> >> A couple of comments here.
>> >>
>> >> Wakeup settings shouldn't be changed during system suspend. That means
>> >> we shouldn't call device_init_wakeup() (or device_set_wakeup_enable()
>> >> for that matter) here.
>> >>
>> >> Instead, device_init_wakeup() should be called during ->probe(), while
>> >> device_set_wakeup_enable() should normally *not* have to be called at
>> >> all by drivers. There are a exceptions for device_set_wakeup_enable(),
>> >> however it should not have to be called during system suspend, at
>> >> least.
>> >>
>> >> Of course, I realize that you are not changing the behavior in this
>> >> regards in this patch, so I am fine this anyway.
>> >>
>> >> My point is, that the end result while doing this improvements in this
>> >> series, should strive to that device_init_wakeup() and
>> >> device_set_wakeup_enable() becomes used correctly. I don't think that
>> >> is the case, or is it?
>> >
>> > Unfortunately we don't find out what the SDIO driver wants to do (i.e
>> > pm_flags & MMC_PM_WAKE_SDIO_IRQ) until suspend.
>>
>> That's true! Of course, we need to be able to act on this, somehow.
>
> That sounds like a design issue, however ...
>
>> >
>> > I considered enabling wakeups by default but wasn't sure that would not
>> > increase power consumption in devices not expecting it.
>>
>> I understand the problem, believe me. However, I would rather like to
>> try to find a generic solution to these problems, else we will keep
>> abusing existing wakeups APIs.
>>
>> For your information, I have been working on several issues on how to
>> handle the "wakeup path" correctly, which is linked to this problem.
>> See a few quite small series for this below [1], [2].
>>
>> I think the general problems can be described liked this:
>>
>> 1) The dev->power.wakeup_path flag doesn't get set for the device by
>> the PM core, in case device_set_wakeup_enable() is called from a
>> ->suspend() callback. That also means, that the parent device don't
>> get its >power.wakeup_path flag set in __device_suspend() by the PM
>> core, while this may be expected by upper layers (PM domains, middle
>> layers).
>>
>> 2) device_may_wakeup() doesn't tell us the hole story about the
>> wakeup. Only that is *may* be configured. :-)
>> So in cases when device_may_wakeup() returns true, we still have these
>> three conditions to consider, which we currently can't distinguish
>> between:
>>
>> *) The wakeup is configured and enabled, so the device should be
>> enabled in the wakeup path.
>
> That's when the in-band device interrupt is used for wakeup, right?

Yes.

>
>> **) The wakeup is configured and enabled, but as an out-band-wakeup
>> signal (like a GPIO IRQ). This means the device shouldn't be enabled
>> in the wakeup path.
>
> I wouldn't really call all of that out of band, but really there's more to it
> in general.
>
> There may be a standard way to configure wakeup signaling which is handled by
> a separate code layer, like ACPI or PCI.  In that case the driver basically
> doesn't care (but it still may need to configure the device for remote
> wakeup internally).  That standard way may do whatever the driver would do
> to the wakeup interrupt or it may use an out-of-band mechanism.

Even if this is a PCI-MMC/SD driver, we can also have wakeup GPIO
irqs, for example to handle card detect when inserting/removing an SD
card.

The point is, there are cases when the driver has this of information,
but upper layer doesn't.

>
> If there is no standard way, the driver may need to set up things by itself.
> In that case it needs to know what's available and how to use it, essentially
> at probe time.  I guess the information then would need to come from a DT or
> similar.

Right, on those SoC I mostly work on, this data comes from DT.
However, on some SoCs this data come from platform data as well.

>
> If it knows that it will use the sideband thing, it will not do *) obviously.

Right, however device_may_wakeup() may still return true for the device.

>
>> ***) The wakeup isn't configured, thus disabled, because there are no
>> consumers of the wakeup IRQ registered (as may be the case for SDIO
>> IRQ). This also means the device shouldn't be enabled in the wakeup
>> path.
>>
>> Potentially, one could consider **) and ***) being treated in the same
>> way, via using an opt-out method, avoiding the wakeup path to be
>> enabled.
>
> Which means exactly what?

>From the driver perspective, it decides to put the device into low
power state (clocks will be gated, etc), thus upper layers (PM domain)
should be informed that it can do that too.

>
>> Currently I have been thinking of adding an "OUT_BAND_WAKEUP"
>> driver PM flag, to deal with this, however there may be other
>> preferred options.
>
> Yeah.  Messy stuff.

Well, let's try to agree on how to best describe the problem first. It
seems like we are soon getting there. :-)

Kind regards
Uffe
