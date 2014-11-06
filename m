From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/4] mmc: core: group default initial state
Date: Thu, 6 Nov 2014 10:38:15 +0100
Message-ID: <CAPDyKFoHVFCG9m-vmPNNy-nJpdzx0st1E2qOZH6hKs42D1p3LA@mail.gmail.com>
References: <1415113626-30187-1-git-send-email-johanru@axis.com>
	<1415113626-30187-3-git-send-email-johanru@axis.com>
	<CAPDyKFq+gvFpernvsskKEocSEx6Fb1va-CqMAPGyaLdOJ2oKFg@mail.gmail.com>
	<CA+20K0AhPL7p3EUJFkJTwKqKG-qLD_6Gvm6kO228n1THY71SbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:62782 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbaKFJiQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Nov 2014 04:38:16 -0500
Received: by mail-qa0-f45.google.com with SMTP id dc16so464926qab.4
        for <linux-mmc@vger.kernel.org>; Thu, 06 Nov 2014 01:38:15 -0800 (PST)
In-Reply-To: <CA+20K0AhPL7p3EUJFkJTwKqKG-qLD_6Gvm6kO228n1THY71SbQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <johan.rudholm@axis.com>
Cc: Johan Rudholm <johanru@axis.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>

[...]

>>
>> Earlier we used always used MMC_BUSMODE_PUSHPULL, now it will depend on "spi".
>
> The JEDEC spec says that in device identification mode the bus should
> be open-drain and not push-pull. So this way should be compliant to
> the spec, right? Unfortunately, I will require help in testing this on
> a proper eMMC.

For MMC yes, but you will break SD/SDIO in this patch.

The default bus mode at initialization needs to be
MMC_BUSMODE_PUSHPULL, since that's required by the SD/SDIO spec.

The MMC cards are being initialized after SD and SDIO, which means a
switch to MMC_BUSMODE_OPENDRAIN is done in mmc_attach_mmc().
Additionally, to handle resume of MMC cards, mmc_init_card() also do a
switch to MMC_BUSMODE_OPENDRAIN.

>
> I can't find anything in the JEDEC or the SD spec about bus mode in
> SPI mode though. However, this behavior is not changed by this patch,
> so we should be safe.

SPI mode has been removed from the eMMC spec.

The SD spec doesn't have open drain mode but do support SPI mode. That
tells me that we should keep using MMC_BUSMODE_PUSHPULL for SPI mode.

>
>>>         host->ios.power_mode = MMC_POWER_UP;
>>> -       host->ios.bus_width = MMC_BUS_WIDTH_1;
>>> -       host->ios.timing = MMC_TIMING_LEGACY;
>>> -       mmc_set_ios(host);
>>> +       /* Set initial state and call mmc_set_ios */
>>> +       mmc_set_initial_state(host);
>>>
>>>         /* Try to set signal voltage to 3.3V but fall back to 1.8v or 1.2v */
>>>         if (__mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330) == 0)
>>> @@ -1582,14 +1594,9 @@ void mmc_power_off(struct mmc_host *host)
>>>         host->ios.clock = 0;
>>>         host->ios.vdd = 0;
>>>
>>> -       if (!mmc_host_is_spi(host)) {
>>> -               host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
>>> -               host->ios.chip_select = MMC_CS_DONTCARE;
>>
>> So in here another change in behaviour, right!?
>
> Ok, so the behavior for SPI is changed in this case, now we explicitly
> set the bus+cs modes and before we left them as they were.
>
> Does this matter though, since we're powering off the device and the
> bus+cs modes will be set on the subsequent mmc_power_up?

That seems reasonable, it shouldn't be an issue.

Kind regards
Uffe
