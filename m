From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-of-esdhc: add workaround for clock glitch issue
Date: Thu, 28 May 2015 10:44:32 +0200
Message-ID: <CAPDyKFoPms8d1ie7pk0iPhaz8HjWynfeNozKurFBkDTUu9ErEA@mail.gmail.com>
References: <1432014029-21152-1-git-send-email-yangbo.lu@freescale.com>
	<CAPDyKFrqgZR-nZwscYNR9QXYq5s+2=eL6aLJ+MekDv4ApPBkYA@mail.gmail.com>
	<BN3PR0301MB1188A4E63014C251A39F6096F2C30@BN3PR0301MB1188.namprd03.prod.outlook.com>
	<CAPDyKFozk9dYF2QhW9w3byrthR0TOCJVvtVayOkNCXEUH4wbSQ@mail.gmail.com>
	<BY1PR0301MB1192BD58244C41ABF6239192F2CC0@BY1PR0301MB1192.namprd03.prod.outlook.com>
	<CAPDyKFpF2w1_ZznXFGPMoqTuyJabY=vyFyBiCcP6ri4MeU06Wg@mail.gmail.com>
	<BY1PR0301MB11924814B1D597D6BE6950B0F2CA0@BY1PR0301MB1192.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:33234 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbbE1Iod (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 May 2015 04:44:33 -0400
Received: by qgfa63 with SMTP id a63so13112492qgf.0
        for <linux-mmc@vger.kernel.org>; Thu, 28 May 2015 01:44:32 -0700 (PDT)
In-Reply-To: <BY1PR0301MB11924814B1D597D6BE6950B0F2CA0@BY1PR0301MB1192.namprd03.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Lu Y.B." <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chrisball@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>

>> >> If you have the possibility to enumerate the device ID (reading
>> >> device information directly from the HW), you should do that when
>> >> adding the device to its subsystem level bus, not while probing.
>> >> That's because you need to be able to match for a compatible driver.
>> > Thanks. Could you provide a reference in present code if you know? I'd
>> like to try.
>>
>> I guess the are several subsystem to look into, but maybe AMBA is one
>> that you could have a look at.
>>
>> drivers/amba/bus.c
>>
> Thank you, Uffe.
> I have seen the code of drivers/amba/ and drivers/of/.
> Do you suggest to get device information from HW when adding device in drivers/of ?
> I am afraid it still faces the same machine specific problem and is complicated.

No matter what you need to move things out of the machine specific
directory, if you want other drivers/buses to be able to make use of
it.

Complicated? Maybe, but I don't find that as good argument for not doing it. :-)

>
> I think it is not so unreasonable to get QorIQ silicon rev in sdhci-of-esdhc.c, because this file is only used for freescale QorIQ platform.

Sorry, I will not accept patches that include machine specific
headers. We can do better than that.

Kind regards
Uffe
