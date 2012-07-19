From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: Devicetree: Initialization order of mmc block devices?
Date: Fri, 20 Jul 2012 02:15:10 +0530
Message-ID: <CAJe_Zhcyug17ZnKtmKnVhHT=Mm1PKdE68f21WWkUVtfCwNxSwg@mail.gmail.com>
References: <5006571A.7060103@de.bosch.com>
	<CAJe_ZhcY78ah81zsfwXxE=bMG4o6v9RwZV_DQyUj7g=d-1hR_w@mail.gmail.com>
	<50068696.8070408@de.bosch.com>
	<CAJe_Zhfmn4dUHk6xtudwCEurigvX64xce3VAozdjDdpSWSbRkA@mail.gmail.com>
	<5006C40D.300@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:57699 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab2GSUpL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jul 2012 16:45:11 -0400
Received: by vcbfk26 with SMTP id fk26so2375961vcb.19
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jul 2012 13:45:10 -0700 (PDT)
In-Reply-To: <5006C40D.300@de.bosch.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Knut Wohlrab <knut.wohlrab@de.bosch.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Behme Dirk (CM-AI/PJ-CF32)" <Dirk.Behme@de.bosch.com>

On 18 July 2012 19:41, Knut Wohlrab <knut.wohlrab@de.bosch.com> wrote:
> On 07/18/2012 03:47 PM, Jassi Brar wrote:
>>
>> On 18 July 2012 15:19, Knut Wohlrab <knut.wohlrab@de.bosch.com> wrote:
>>
>>> If a SD card is inserted at boot time, its "mmcblk0", the embedded
>>> MMC (eMMC) device "mmcblk1".  This makes it difficult to give the kernel
>>> the
>>> correct device for the eMMC root file system ("root=/dev/mmcblk?p1 ...").
>>>
>> How about  root=UUID=<eMMC-partition>  ?
>
> Because we are talking about an embedded device, it is very difficult to get
> a UUID of a eMMC partition into kernel command line with U-Boot. Handling of
> UUID is also a big effort at board manufacturing.
>
I don't realize how bad is it if a common UUID is used on each cloned
eMMC(non-removable) of every instance of a device. But of course only
you know what's best for your product.

>
> This problem can occur on many devices with embedded MMC and removable SD,
> e.g. smart phones. So I think we should find an solution to define MMC scan
> order or device number/name in a device tree.
>
I assume your issue is that due to async nature of mmc scanning, the
eMMC is detected later than external card, despite being the probe for
eMMC's slot initiated first ?
If so, we can do by simply associating 'N' of 'mmcblkN' with the slot
index i.e, mmc_host.index (instead of mmc_blk_data.name_idx). Which is
always in the order of probe calling. And we don't need to modify, or
expect more of, DT for that. Though I suspect there must be some
serious reason why it's not already done that way.
