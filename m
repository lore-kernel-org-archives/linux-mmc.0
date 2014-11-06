From: Johan Rudholm <johan.rudholm@axis.com>
Subject: Re: [PATCH v2 2/4] mmc: core: group default initial state
Date: Thu, 6 Nov 2014 11:43:40 +0100
Message-ID: <CA+20K0CSbNY_NbhutBZt4JSn_CAU6k=kt=58g=5427oLDK73Sg@mail.gmail.com>
References: <1415113626-30187-1-git-send-email-johanru@axis.com>
	<1415113626-30187-3-git-send-email-johanru@axis.com>
	<CAPDyKFq+gvFpernvsskKEocSEx6Fb1va-CqMAPGyaLdOJ2oKFg@mail.gmail.com>
	<CA+20K0AhPL7p3EUJFkJTwKqKG-qLD_6Gvm6kO228n1THY71SbQ@mail.gmail.com>
	<CAPDyKFoHVFCG9m-vmPNNy-nJpdzx0st1E2qOZH6hKs42D1p3LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:56341 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234AbaKFKnt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 6 Nov 2014 05:43:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 9C9132E36A
	for <linux-mmc@vger.kernel.org>; Thu,  6 Nov 2014 11:43:47 +0100 (CET)
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id jhs0i4pVPs2w for <linux-mmc@vger.kernel.org>;
	Thu,  6 Nov 2014 11:43:42 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id 253BD2E34C
	for <linux-mmc@vger.kernel.org>; Thu,  6 Nov 2014 11:43:42 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 0F4A2E52
	for <linux-mmc@vger.kernel.org>; Thu,  6 Nov 2014 11:43:42 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id F2657E2B
	for <linux-mmc@vger.kernel.org>; Thu,  6 Nov 2014 11:43:41 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id EC42D3E0D4
	for <linux-mmc@vger.kernel.org>; Thu,  6 Nov 2014 11:43:41 +0100 (CET)
Received: by mail-qa0-f41.google.com with SMTP id s7so533387qap.0        for
 <linux-mmc@vger.kernel.org>; Thu, 06 Nov 2014 02:43:40 -0800 (PST)
In-Reply-To: <CAPDyKFoHVFCG9m-vmPNNy-nJpdzx0st1E2qOZH6hKs42D1p3LA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Johan Rudholm <johanru@axis.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>

Hi Ulf,

2014-11-06 10:38 GMT+01:00 Ulf Hansson <ulf.hansson@linaro.org>:
> [...]
>
>>>
>>> Earlier we used always used MMC_BUSMODE_PUSHPULL, now it will depend on "spi".
>>
>> The JEDEC spec says that in device identification mode the bus should
>> be open-drain and not push-pull. So this way should be compliant to
>> the spec, right? Unfortunately, I will require help in testing this on
>> a proper eMMC.
>
> For MMC yes, but you will break SD/SDIO in this patch.
>
> The default bus mode at initialization needs to be
> MMC_BUSMODE_PUSHPULL, since that's required by the SD/SDIO spec.
>
> The MMC cards are being initialized after SD and SDIO, which means a
> switch to MMC_BUSMODE_OPENDRAIN is done in mmc_attach_mmc().
> Additionally, to handle resume of MMC cards, mmc_init_card() also do a
> switch to MMC_BUSMODE_OPENDRAIN.
>
>>
>> I can't find anything in the JEDEC or the SD spec about bus mode in
>> SPI mode though. However, this behavior is not changed by this patch,
>> so we should be safe.
>
> SPI mode has been removed from the eMMC spec.
>
> The SD spec doesn't have open drain mode but do support SPI mode. That
> tells me that we should keep using MMC_BUSMODE_PUSHPULL for SPI mode.

Thank you for explaining this. So I think we should be OK by always
choosing MMC_BUSMODE_PUSHPULL, because for MMC cards mmc_init_card is
called from mmc_power_restore which is called after the hw_reset. Will
post a v3 of this patch.

//Johan
