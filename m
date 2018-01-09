From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/9] mmc: sdhci-pci: Stop calling sdhci_enable_irq_wakeups()
Date: Tue, 09 Jan 2018 13:03:48 +0100
Message-ID: <2755089.VSx54pZnMZ@aspire.rjw.lan>
References: <1513757933-11232-1-git-send-email-adrian.hunter@intel.com> <25263929.MvjmvFKZ9L@aspire.rjw.lan> <91961c28-2e09-250d-de7a-55ef44c89ce7@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:57095 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754499AbeAIMFB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Jan 2018 07:05:01 -0500
In-Reply-To: <91961c28-2e09-250d-de7a-55ef44c89ce7@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Haridhar Kalvala <haridhar.kalvala@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On Tuesday, January 9, 2018 9:08:46 AM CET Adrian Hunter wrote:
> On 09/01/18 02:26, Rafael J. Wysocki wrote:
> > On Monday, January 8, 2018 3:49:26 PM CET Adrian Hunter wrote:
> >> On 21/12/17 17:33, Ulf Hansson wrote:
> >>> + linux-pm, Rafael, Geert
> >>>
> >>> On 21 December 2017 at 15:25, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>> On 21/12/17 16:15, Ulf Hansson wrote:
> >>>>> On 20 December 2017 at 09:18, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>>>> sdhci_enable_irq_wakeups() is already called by sdhci_suspend_host() so
> >>>>>> sdhci-pci should not need to call it. However sdhci_suspend_host() only
> >>>>>> calls it if wakeups are enabled, and sdhci-pci does not enable them until
> >>>>>> after calling sdhci_suspend_host(). So move the calls to
> >>>>>> sdhci_pci_init_wakeup() before calling sdhci_suspend_host(), and
> >>>>>> stop calling sdhci_enable_irq_wakeups(). That results in some
> >>>>>> simplification because sdhci_pci_suspend_host() and
> >>>>>> __sdhci_pci_suspend_host() no longer need to be separate functions.
> >>>>>>
> >>>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >>>>>> ---
> >>>>>>  drivers/mmc/host/sdhci-pci-core.c | 58 ++++++++++++++-------------------------
> >>>>>>  1 file changed, 21 insertions(+), 37 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> >>>>>> index 110c634cfb43..2ffc09f088ee 100644
> >>>>>> --- a/drivers/mmc/host/sdhci-pci-core.c
> >>>>>> +++ b/drivers/mmc/host/sdhci-pci-core.c
> >>>>>> @@ -39,10 +39,29 @@
> >>>>>>  static void sdhci_pci_hw_reset(struct sdhci_host *host);
> >>>>>>
> >>>>>>  #ifdef CONFIG_PM_SLEEP
> >>>>>> -static int __sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
> >>>>>> +static int sdhci_pci_init_wakeup(struct sdhci_pci_chip *chip)
> >>>>>> +{
> >>>>>> +       mmc_pm_flag_t pm_flags = 0;
> >>>>>> +       int i;
> >>>>>> +
> >>>>>> +       for (i = 0; i < chip->num_slots; i++) {
> >>>>>> +               struct sdhci_pci_slot *slot = chip->slots[i];
> >>>>>> +
> >>>>>> +               if (slot)
> >>>>>> +                       pm_flags |= slot->host->mmc->pm_flags;
> >>>>>> +       }
> >>>>>> +
> >>>>>> +       return device_init_wakeup(&chip->pdev->dev,
> >>>>>> +                                 (pm_flags & MMC_PM_KEEP_POWER) &&
> >>>>>> +                                 (pm_flags & MMC_PM_WAKE_SDIO_IRQ));
> >>>>>
> >>>>> A couple of comments here.
> >>>>>
> >>>>> Wakeup settings shouldn't be changed during system suspend. That means
> >>>>> we shouldn't call device_init_wakeup() (or device_set_wakeup_enable()
> >>>>> for that matter) here.
> >>>>>
> >>>>> Instead, device_init_wakeup() should be called during ->probe(), while
> >>>>> device_set_wakeup_enable() should normally *not* have to be called at
> >>>>> all by drivers. There are a exceptions for device_set_wakeup_enable(),
> >>>>> however it should not have to be called during system suspend, at
> >>>>> least.
> >>>>>
> >>>>> Of course, I realize that you are not changing the behavior in this
> >>>>> regards in this patch, so I am fine this anyway.
> >>>>>
> >>>>> My point is, that the end result while doing this improvements in this
> >>>>> series, should strive to that device_init_wakeup() and
> >>>>> device_set_wakeup_enable() becomes used correctly. I don't think that
> >>>>> is the case, or is it?
> >>>>
> >>>> Unfortunately we don't find out what the SDIO driver wants to do (i.e
> >>>> pm_flags & MMC_PM_WAKE_SDIO_IRQ) until suspend.
> >>>
> >>> That's true! Of course, we need to be able to act on this, somehow.
> >>>
> >>>>
> >>>> I considered enabling wakeups by default but wasn't sure that would not
> >>>> increase power consumption in devices not expecting it.
> >>>
> >>> I understand the problem, believe me. However, I would rather like to
> >>> try to find a generic solution to these problems, else we will keep
> >>> abusing existing wakeups APIs.
> >>>
> >>> For your information, I have been working on several issues on how to
> >>> handle the "wakeup path" correctly, which is linked to this problem.
> >>> See a few quite small series for this below [1], [2].
> >>>
> >>> I think the general problems can be described liked this:
> >>>
> >>> 1) The dev->power.wakeup_path flag doesn't get set for the device by
> >>> the PM core, in case device_set_wakeup_enable() is called from a
> >>> ->suspend() callback. That also means, that the parent device don't
> >>> get its >power.wakeup_path flag set in __device_suspend() by the PM
> >>> core, while this may be expected by upper layers (PM domains, middle
> >>> layers).
> >>>
> >>> 2) device_may_wakeup() doesn't tell us the hole story about the
> >>> wakeup. Only that is *may* be configured. :-)
> >>> So in cases when device_may_wakeup() returns true, we still have these
> >>> three conditions to consider, which we currently can't distinguish
> >>> between:
> >>>
> >>> *) The wakeup is configured and enabled, so the device should be
> >>> enabled in the wakeup path.
> >>>
> >>> **) The wakeup is configured and enabled, but as an out-band-wakeup
> >>> signal (like a GPIO IRQ). This means the device shouldn't be enabled
> >>> in the wakeup path.
> >>
> >> So what about just adding can_oob_wakeup and oob_wakeup i.e.
> > 
> > Why do you want to expose that to user space?  It is entirely internal IMO.
> 
> It was not exposed to user space.  The idea was to use the same power/wake
> attribute for both "normal" and oob wake.
> 
> The user doesn't care whether the wakeup is native to the device or
> performed by GPIO.  So it seems reasonable to use the power/wake attribute.

I agree.  The kernel has to figure out which wakeup mechanism(s) to use.

> > Besides, we have that already in ACPI, for example, so that would need to be
> > taken into account somehow.
> 
> What in ACPI are you referring to?

Well, the normal ACPI stuff.

On a full ACPI HW system if the device has an ACPI companion object and there is
a _PRW under it (and it is actually valid), then it points to the GPE that will
be used for signaling wakeup and from the device's perspective that is out of
band.  That is very much like having a sideband wakeup GPIO IRQ (except that
the IRQ is muxed into the SCI in the ACPI GPE case).

> > But this a PCI driver, right?
> 
> Yes.
> 
> > Anyway, please post the original series again with a CC to linux-pm.
> 
> Done.

Cool, thanks!

I'll have a look at that soon (hopefully), but it looks like everybody had
the idea to send me stuff at the same time. :-)

Thanks,
Rafael

