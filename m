From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: sdhci: add SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS33
 quirk support
Date: Thu, 4 Jun 2015 13:20:23 +0200
Message-ID: <CAPDyKFq42d5TeAK9PmzFfWbuKUSN0-KPmPp89zeH8Lk+CNFvCA@mail.gmail.com>
References: <1433228980-5676-1-git-send-email-yangbo.lu@freescale.com>
	<CAPDyKFqb3y9xV8ouZyK0bapMs0P+gA+KLux10yHz3K8mbitLHw@mail.gmail.com>
	<BY1PR0301MB119204EF6D256D7D7C82925CF2B30@BY1PR0301MB1192.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33878 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbbFDLUY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Jun 2015 07:20:24 -0400
Received: by qkoo18 with SMTP id o18so21923110qko.1
        for <linux-mmc@vger.kernel.org>; Thu, 04 Jun 2015 04:20:23 -0700 (PDT)
In-Reply-To: <BY1PR0301MB119204EF6D256D7D7C82925CF2B30@BY1PR0301MB1192.namprd03.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Lu Y.B." <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chrisball@gmail.com>

On 4 June 2015 at 11:45, Lu Y.B. <yangbo.lu@freescale.com> wrote:
> Thanks Uffe, and see my comments below.
>
>> -----Original Message-----
>> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>> Sent: Thursday, June 04, 2015 3:48 PM
>> To: Lu Yangbo-B47093
>> Cc: linux-mmc; Chris Ball
>> Subject: Re: [PATCH 1/2] mmc: sdhci: add
>> SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS33 quirk support
>>
>> On 2 June 2015 at 09:09, Yangbo Lu <yangbo.lu@freescale.com> wrote:
>> > This quirk is used for controllers that can only support 1.8V voltage
>> > but the peripheral hardware circuit has capability to support 3.3V
>> > voltage.
>>
>> Which voltage are you referring to? The I/O voltage or the power to the
>> card? VCC or VCCQ?
>>
>> Kind regards
>> Uffe
>
> The voltage here means I/O voltage.
> Although the controller only supports 1.8v, the hardware circuit has a level translator for supporting 3.3v.

Thanks for clarifying.

>
>>
>> >
>> > Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
>> > ---
>> >  drivers/mmc/host/sdhci.c | 3 +++
>> >  drivers/mmc/host/sdhci.h | 4 ++++
>> >  2 files changed, 7 insertions(+)
>> >
>> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
>> > c80287a..40de0d3 100644
>> > --- a/drivers/mmc/host/sdhci.c
>> > +++ b/drivers/mmc/host/sdhci.c
>> > @@ -2959,6 +2959,9 @@ int sdhci_add_host(struct sdhci_host *host)
>> >                         host->caps1 :
>> >                         sdhci_readl(host, SDHCI_CAPABILITIES_1);
>> >
>> > +       if (host->quirks2 & SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS33)
>> > +               caps[0] = caps[0] | SDHCI_CAN_VDD_330;

Isn't SDHCI_CAN_VDD_330 used to indicate what ocr_avail mask that
shall be used? Thus it has nothing to do with the IO voltage.

>> > +
>> >         if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
>> >                 host->flags |= SDHCI_USE_SDMA;
>> >         else if (!(caps[0] & SDHCI_CAN_DO_SDMA)) diff --git
>> > a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h index
>> > e639b7f..2704daf1 100644
>> > --- a/drivers/mmc/host/sdhci.h
>> > +++ b/drivers/mmc/host/sdhci.h
>> > @@ -409,6 +409,10 @@ struct sdhci_host {
>> >  #define SDHCI_QUIRK2_SUPPORT_SINGLE                    (1<<13)
>> >  /* Controller broken with using ACMD23 */
>> >  #define SDHCI_QUIRK2_ACMD23_BROKEN                     (1<<14)
>> > +/* Controller only supports 1.8V, but the peripheral hardware
>> > + * circuit has capability to support 3.3V  */
>> > +#define SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS33              (1<<15)
>> >
>> >         int irq;                /* Device IRQ */
>> >         void __iomem *ioaddr;   /* Mapped address */
>> > --
>> > 2.1.0.27.g96db324
>> >

Kind regards
Uffe
