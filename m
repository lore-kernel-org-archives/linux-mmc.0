From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2, 2/2] mmc: sdhci-pltfm: enable interrupt mode to detect card
Date: Fri, 22 May 2015 15:28:56 +0200
Message-ID: <CAPDyKFpWmqS75je0N_+mOb_c91sqmvydVqjwv5zhbWmk2nK95Q@mail.gmail.com>
References: <1431657984-42484-1-git-send-email-yangbo.lu@freescale.com>
	<CAPDyKFrgr5-xL3xG83AdFd8sAf20TUetCN=7etCg9rsKoZ317g@mail.gmail.com>
	<BY1PR0301MB11920E68DD9C4B17F1B1373FF2C40@BY1PR0301MB1192.namprd03.prod.outlook.com>
	<CAPDyKFpB2a=9J1T2+EwKUCx-6f27CbJyJSfXVMkK5sL0DsJL2Q@mail.gmail.com>
	<BY1PR0301MB1192B676B858B31C3B1893C1F2C40@BY1PR0301MB1192.namprd03.prod.outlook.com>
	<1431981783.27761.5.camel@freescale.com>
	<CAPDyKFpw9Uk14Ovfwc7_Gfu78pZZMO4qeD_BiBOmojP5WSNm8Q@mail.gmail.com>
	<1432177143.27761.193.camel@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:32996 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161009AbbEVN25 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 May 2015 09:28:57 -0400
Received: by qgfa63 with SMTP id a63so8002314qgf.0
        for <linux-mmc@vger.kernel.org>; Fri, 22 May 2015 06:28:56 -0700 (PDT)
In-Reply-To: <1432177143.27761.193.camel@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
Cc: Lu Yangbo-B47093 <yangbo.lu@freescale.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chrisball@gmail.com>

On 21 May 2015 at 04:59, Scott Wood <scottwood@freescale.com> wrote:
> On Tue, 2015-05-19 at 09:46 +0200, Ulf Hansson wrote:
>> [...]
>>
>> >> > Those platforms could still update their DT files and add "broken-cd",
>> >> > since that would be the proper description of the HW. Once that's done,
>> >> > it would enable you to remove the SDHCI_QUIRK_BROKEN_CARD_DETECTION as
>> >> > default, right?
>> >> >
>> >> Yes, and if remove SDHCI_QUIRK_BROKEN_CARD_DETECTION as default, 'borken-cd' would be needed to be added for most platforms using esdhc.
>> >
>> > I was OK with changing the device tree if it just meant that things that
>> > previously didn't work now work.  I'm not OK with requiring the device
>> > trees to change in order for things that already work to stay working.
>>
>> I get your point, but.. considering maintaince from mmc code point of
>> view, I don't like the suggested approach in $subject patch.
>>
>> As this patch anyway requires updating DTBs,
>
> Not in a way that causes things that used to work to stop working if
> someone uses a new kernel with an old device tree.
>
>> I would like to know the involved platforms and at what level of
>> deployment the DTBs are in. In principle what I am asking is, how hard
>> is it to update the DTBs?
>
> The change you asked for would affect all platforms with esdhc that are
> not on the list being excluded by this patch.  I counted 29 files in
> arch/powerpc/boot/dts with "esdhc".  The oldest patch I see introducing
> esdhc to a device tree is 5761bc5dae6 from 2008.  This is not new
> stuff.
>
> The patch adding the quirk to the esdhc files is 3bb2a9f6a7c08 from
> 2011, so the driver behavior is also not new.
>
>> BTW, is it only sdhci-of-esdhc.c we are discussing here?
>
> It's only sdhci-of-esdhc.c that would be affected by this patch (though
> sdhci-esdhc-imx also sets SDHCI_QUIRK_BROKEN_CARD_DETECTION by default).
> If the tests are moved into that file, would you be OK with it?

Considering your reasoning, yes!

Kind regards
Uffe
