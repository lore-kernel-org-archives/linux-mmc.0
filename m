From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Re: [v4,1/6] mmc: dt: add DT binding for big endian controller
Date: Tue, 25 Aug 2015 14:02:19 +0200
Message-ID: <CAPDyKFpR=qbheQ8hJueAbHA_5f9kBDNb9_zqanGTna+1POhbdg@mail.gmail.com>
References: <DM2PR0301MB0734002AABE322D7106D3AF6BA620@DM2PR0301MB0734.namprd03.prod.outlook.com>
	<BY1PR0301MB1192D64A16D187E5485796DCF2610@BY1PR0301MB1192.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33915 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083AbbHYMCU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2015 08:02:20 -0400
Received: by igui7 with SMTP id i7so9339946igu.1
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2015 05:02:19 -0700 (PDT)
In-Reply-To: <BY1PR0301MB1192D64A16D187E5485796DCF2610@BY1PR0301MB1192.namprd03.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Lu Y.B." <yangbo.lu@freescale.com>
Cc: Li Leo <LeoLi@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 25 August 2015 at 12:27, Lu Y.B. <yangbo.lu@freescale.com> wrote:
> Please see my comments below.
>
>> -----Original Message-----
>> From: Li Yang-Leo-R58472
>> Sent: Tuesday, August 25, 2015 6:56 AM
>> To: Lu Yangbo-B47093
>> Cc: linux-mmc@vger.kernel.org; ulf.hansson@linaro.org;
>> devicetree@vger.kernel.org
>> Subject: Re: [v4,1/6] mmc: dt: add DT binding for big endian controller
>>
>> > Add specification of 'big-endian' property. if the controller is big
>> > endian mode, specify this property in device tree node.
>> > The default endian mode is little endian.
>>
>> You shouldn't make the default endian mode to be little endian because in
>> the original binding without this new property we are actually expecting
>> big-endian hardware.  Making little-endian the default is breaking the
>> compatibility with the original binding.
>>
>> Regards,
>> Leo
>
> Thanks a lot, Leo.
>
> Hi Uffe,
>
> Since it doesn't make sense to extend the common MMC DT parser, mmc_of_parse(), to fetch the endian mode,
> I'd like to move endian fetching code and all LE/BE accessors definition to eSDHC driver.

Please them parts of the sdhci generic code, as library functions.

>
> And the default endian would be set to big-endian again for eSDHC.

That's okay, just make sure it's properly documented in the DT binding
doc for esdhc.

>
> Use function pointers that are assigned in probe according endian mode to avoid checking endian every time.
> I'd also like to separate eMMC DDR mode patch from this patchset. Would send it with other UHS-1 speed mode patches together.

Makes perfect sense!

So in your sdhci host specific driver, you will find out the endian
type and make use of the corresponding library functions gets assigned
in the host ops which is provided to sdhci_pltfm_init.

Kind regards
Uffe
