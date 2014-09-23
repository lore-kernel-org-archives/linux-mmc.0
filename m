From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 4/8] mmc: sdhci: do not enable card detect interrupt
 for gpio cd type
Date: Tue, 23 Sep 2014 10:17:12 +0200
Message-ID: <CAPDyKFrYDz43h=M+PDRWVxitpW-+pv+14+gqmGprNZNaKfo5Nw@mail.gmail.com>
References: <1411377131-19741-1-git-send-email-b29396@freescale.com>
	<1411377131-19741-5-git-send-email-b29396@freescale.com>
	<CAPDyKFoD6G7w5gZEBGeqrmxDWyGHMy0_daikSmUfLCnZzZ-K_w@mail.gmail.com>
	<20140923071027.GA12146@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:56331 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755073AbaIWIRN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Sep 2014 04:17:13 -0400
Received: by mail-qc0-f175.google.com with SMTP id o8so1360754qcw.6
        for <linux-mmc@vger.kernel.org>; Tue, 23 Sep 2014 01:17:12 -0700 (PDT)
In-Reply-To: <20140923071027.GA12146@shlinux1.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 23 September 2014 09:10, Dong Aisheng <b29396@freescale.com> wrote:
> On Tue, Sep 23, 2014 at 09:27:49AM +0200, Ulf Hansson wrote:
>> On 22 September 2014 11:12, Dong Aisheng <b29396@freescale.com> wrote:
>> > Except SDHCI_QUIRK_BROKEN_CARD_DETECTION and MMC_CAP_NONREMOVABLE,
>> > we also do not need to handle controller native card detect interrupt
>> > for gpio as card detect case.
>> > If we wrong enabled the card detect interrupt for gpio case,
>> > it will cause a lot of unexpected card detect interrupts during data transfer
>> > which should not happen.

I see. But shouldn't you then check for MMC_CAP_NEEDS_POLL instead of
reading the current state of the gpio_cd pin?

Kind regards
Uffe

>> >
>> > Signed-off-by: Dong Aisheng <b29396@freescale.com>
>> > ---
>> >  drivers/mmc/host/sdhci.c |    3 ++-
>> >  1 files changed, 2 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> > index 7481bd8..85cbf45 100644
>> > --- a/drivers/mmc/host/sdhci.c
>> > +++ b/drivers/mmc/host/sdhci.c
>> > @@ -136,9 +136,10 @@ static void sdhci_dumpregs(struct sdhci_host *host)
>> >  static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
>> >  {
>> >         u32 present;
>> > +       int gpio_cd = mmc_gpio_get_cd(host->mmc);
>> >
>> >         if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
>> > -           (host->mmc->caps & MMC_CAP_NONREMOVABLE))
>> > +           (host->mmc->caps & MMC_CAP_NONREMOVABLE) || !IS_ERR_VALUE(gpio_cd))
>>
>> If you have a properly working gpio_cd, then why does you also have
>> SDHCI_QUIRK_BROKEN_CARD_DETECTION set? Isn't that the actual problem?
>>
>
> SDHCI_QUIRK_BROKEN_CARD_DETECTION seems only for controller CD function.
> Thus even we're using gpio_cd, we still have this quirk set for controller
> to avoid enable controller cd interrupts.
> Does it make sense?
>
> Regards
> Dong Aisheng
>
>> Kind regards
>> Uffe
>>
>> >                 return;
>> >
>> >         if (enable) {
>> > --
>> > 1.7.8
>> >
