From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Add SDHCI_QUIRK2_BROKEN_64_BIT_DMA
Date: Fri, 26 Aug 2016 15:29:53 +0200
Message-ID: <201608261529.53854.arnd@arndb.de>
References: <20160808015803.2528-1-jaedon.shin@gmail.com> <de010fff-1f22-96bb-f41f-99169fb6bb19@gmail.com> <CAPDyKFo6-GZ_myX43orouUvWGA8aAhUD9Jrcpaz+LzApuQJFZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:63213 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbcHZNaQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Aug 2016 09:30:16 -0400
In-Reply-To: <CAPDyKFo6-GZ_myX43orouUvWGA8aAhUD9Jrcpaz+LzApuQJFZA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Alan Cooper <alcooperx@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, bcm-kernel-feedback-list@broadcom.com, linux-mmc <linux-mmc@vger.kernel.org>

On Friday 26 August 2016, Ulf Hansson wrote:
> On 25 August 2016 at 18:41, Florian Fainelli <f.fainelli@gmail.com> wrote:
> > On 08/19/2016 07:05 AM, Jaedon Shin wrote:
> >> Hi Ulf,
> >>
> >>> On Aug 19, 2016, at 10:44 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >>>
> >>> On 19 August 2016 at 04:25, Jaedon Shin <jaedon.shin@gmail.com> wrote:
> >>>> Hi Alan,
> >>>>
> >>>> On Aug 18, 2016, at 11:27 PM, Alan Cooper <alcooperx@gmail.com> wrote:
> >>>>>
> >>>>> It would be better to make this a MIPS only setting because this issue
> >>>>> only exists for MIPS chips and some newer ARM chips will support 64
> >>>>> bit DMA.
> >>>>> Also, since there's been a general effort to reduce the use QUIRKs,
> >>>>> you could clear the SDHCI_CAN_64BIT in CAPS1 instead of using the
> >>>>> QUIRK.
> >>>>>
> >>>>> @@ -101,6 +101,9 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
> >>>>>       host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
> >>>>>       host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
> >>>>>                       SDHCI_SUPPORT_DDR50);
> >>>>> +#if defined(CONFIG_MIPS)
> >>>>> +       host->caps1 &= ~SDHCI_CAN_64BIT;
> >>>>> +#endif
> >>>>>       host->quirks |= SDHCI_QUIRK_MISSING_CAPS |
> >>>>>               SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> >>>>
> >>>> It's better to me, but we should use host->cap instead of host->cap1. I will update
> >>>> patch with your comment.
> >>>
> >>> Please, then also send this to the public linux-mmc list.
> >>>
> >>> Kind regards
> >>> Uffe
> >>>
> >>
> >> I'm sorry I could not add the public linux-mmc list this mail thread, but
> >> I have already sent the updated patch with linux-mmc.
> >>
> >> https://patchwork.kernel.org/patch/9289189/
> >
> > Humm, is not this one of these cases where we would expect the
> > compatible string to dictacte whether enabling 64_BIT_DMA makes sense or
> > not?
> 
> Yes!
> 
> Jaedon, can you please send an updated patch. Please also bump the
> version number of the patch!
> 

Sorry for jumping in late in the thread, but if I understand it right that the
problem is an SDHCI controller claiming to support 64-bit DMA that is connected
to a bus that only supports 32-bit addressing, this should be handled by
interpreting the dma-ranges property of the parent bus instead.

	Arnd
