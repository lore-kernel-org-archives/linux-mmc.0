From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v4, 5/6] mmc: kconfig: select FSL_GUTS for MMC_SDHCI_OF_ESDHC
Date: Tue, 15 Dec 2015 10:46:07 +0100
Message-ID: <CAPDyKFrKSMC0uo8re3CxjNCUsVnEMau=GTKq=v_3ooNnQxw2Eg@mail.gmail.com>
References: <1450067067-44869-1-git-send-email-yangbo.lu@freescale.com>
	<1450067067-44869-6-git-send-email-yangbo.lu@freescale.com>
	<CAPDyKFo1g5_4bpYnTO96tGfVGStysN0FnmbSx-Se4tOa7f3rZQ@mail.gmail.com>
	<1450116253.15946.353.camel@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35430 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933171AbbLOJqJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Dec 2015 04:46:09 -0500
Received: by mail-qk0-f169.google.com with SMTP id b125so4227808qkf.2
        for <linux-mmc@vger.kernel.org>; Tue, 15 Dec 2015 01:46:08 -0800 (PST)
In-Reply-To: <1450116253.15946.353.camel@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
Cc: Yangbo Lu <yangbo.lu@freescale.com>, linux-mmc <linux-mmc@vger.kernel.org>, X.Xie@freescale.com, Li Leo <LeoLi@freescale.com>

[...]
>> > --- a/drivers/mmc/host/Kconfig
>> > +++ b/drivers/mmc/host/Kconfig
>> > @@ -142,6 +142,8 @@ config MMC_SDHCI_OF_ESDHC
>> >         depends on MMC_SDHCI_PLTFM
>> >         depends on PPC || ARCH_MXC || ARCH_LAYERSCAPE
>> >         select MMC_SDHCI_IO_ACCESSORS
>> > +       select SOC_FSL
>> > +       select FSL_GUTS
>>
>> This is weird.
>>
>> First, perhaps it would make sense to have stub functions for those
>> the FSL_GUTS driver provides via its API, thus the above wouldn't be
>> required at all. Of course this makes only sense if you think there
>> are/could be configurations for a cross SOC driver which don't need
>> the GUTS driver.
>>
>> Second, even if you think the stubs above is a bad idea, I would from
>> the top-level Kconfig for your platform, add the needed "selects" as I
>> think it's where it belongs and then change this to "depends on"
>> instead.
>
> Why is it weird for a driver to select another driver that it makes calls to?
>  Much easier to do it here than in all the platforms that use this driver.

Because using "select" will not consider the dependencies for the new
selected Kconfig option. I can imagine that it might become a problem,
sooner or later.

So, "select" shall be used by care and in this case I think we can
cope fine with using "depends on".

>
> And I think stubs for reading SVR is quite a bad idea.  It'll make the driver
> build but it will silently not be able to apply SVR-based workarounds.

It doesn't have to be "silent", the driver can return an error (and
print error messages) from its ->probe() method, if the calls to the
GUTS driver fails.

Anyway, I mentioned this idea only to understand the need for
*optional* GUTS supports. Perhaps there is a cross SOC drivers that
for some platforms depends on GUTS but on others it doesn't.

Maybe that isn't case then!?

Kind regards
Uffe
