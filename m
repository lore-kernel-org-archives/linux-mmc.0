From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2, 2/2] mmc: sdhci-pltfm: enable interrupt mode to detect card
Date: Tue, 19 May 2015 09:46:25 +0200
Message-ID: <CAPDyKFpw9Uk14Ovfwc7_Gfu78pZZMO4qeD_BiBOmojP5WSNm8Q@mail.gmail.com>
References: <1431657984-42484-1-git-send-email-yangbo.lu@freescale.com>
	<CAPDyKFrgr5-xL3xG83AdFd8sAf20TUetCN=7etCg9rsKoZ317g@mail.gmail.com>
	<BY1PR0301MB11920E68DD9C4B17F1B1373FF2C40@BY1PR0301MB1192.namprd03.prod.outlook.com>
	<CAPDyKFpB2a=9J1T2+EwKUCx-6f27CbJyJSfXVMkK5sL0DsJL2Q@mail.gmail.com>
	<BY1PR0301MB1192B676B858B31C3B1893C1F2C40@BY1PR0301MB1192.namprd03.prod.outlook.com>
	<1431981783.27761.5.camel@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:33208 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbbESHq0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 May 2015 03:46:26 -0400
Received: by qcblr10 with SMTP id lr10so2464469qcb.0
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2015 00:46:25 -0700 (PDT)
In-Reply-To: <1431981783.27761.5.camel@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
Cc: Lu Yangbo-B47093 <yangbo.lu@freescale.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chrisball@gmail.com>

[...]

>> > Those platforms could still update their DT files and add "broken-cd",
>> > since that would be the proper description of the HW. Once that's done,
>> > it would enable you to remove the SDHCI_QUIRK_BROKEN_CARD_DETECTION as
>> > default, right?
>> >
>> Yes, and if remove SDHCI_QUIRK_BROKEN_CARD_DETECTION as default, 'borken-cd' would be needed to be added for most platforms using esdhc.
>
> I was OK with changing the device tree if it just meant that things that
> previously didn't work now work.  I'm not OK with requiring the device
> trees to change in order for things that already work to stay working.

I get your point, but.. considering maintaince from mmc code point of
view, I don't like the suggested approach in $subject patch.

As this patch anyway requires updating DTBs, I would like to know the
involved platforms and at what level of deployment the DTBs are in. In
principle what I am asking is, how hard is it to update the DTBs?

BTW, is it only sdhci-of-esdhc.c we are discussing here?

>
> In general it is not reasonable to expect device trees to enumerate
> hardware bugs since the bugs (or the need to work aronud them) are often
> discovered after the device tree has been created.
>
> Yangbo, when I asked why you couldn't use SVR you said that it was a
> common SDHC file.  But, the file that sets
> SDHCI_QUIRK_BROKEN_CARD_DETECTION in the first place is sdhci-of-esdhc.c
> which is Freescale-specific.  Why not just test SVR in there to
> determine whether the quirk should be set?
>
> -Scott
>
>

Kind regards
Uffe
