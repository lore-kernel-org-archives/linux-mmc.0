From: Knut Wohlrab <knut.wohlrab@de.bosch.com>
Subject: Re: Devicetree: Initialization order of mmc block devices?
Date: Wed, 18 Jul 2012 16:11:25 +0200
Message-ID: <5006C40D.300@de.bosch.com>
References: <5006571A.7060103@de.bosch.com> <CAJe_ZhcY78ah81zsfwXxE=bMG4o6v9RwZV_DQyUj7g=d-1hR_w@mail.gmail.com> <50068696.8070408@de.bosch.com> <CAJe_Zhfmn4dUHk6xtudwCEurigvX64xce3VAozdjDdpSWSbRkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp2-v.fe.bosch.de ([139.15.237.6]:51257 "EHLO
	smtp2-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867Ab2GROOe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jul 2012 10:14:34 -0400
In-Reply-To: <CAJe_Zhfmn4dUHk6xtudwCEurigvX64xce3VAozdjDdpSWSbRkA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Behme Dirk (CM-AI/PJ-CF32)" <Dirk.Behme@de.bosch.com>

On 07/18/2012 03:47 PM, Jassi Brar wrote:
> On 18 July 2012 15:19, Knut Wohlrab <knut.wohlrab@de.bosch.com> wrote:
>
>> If a SD card is inserted at boot time, its "mmcblk0", the embedded
>> MMC (eMMC) device "mmcblk1".  This makes it difficult to give the kernel the
>> correct device for the eMMC root file system ("root=/dev/mmcblk?p1 ...").
>>
> How about  root=UUID=<eMMC-partition>  ?
Because we are talking about an embedded device, it is very difficult to 
get a UUID of a eMMC partition into kernel command line with U-Boot. 
Handling of UUID is also a big effort at board manufacturing.

Startup speed is very important for us. Searching for UUID on several 
MMC/SD devices will significant slow down the boot process.

This problem can occur on many devices with embedded MMC and removable 
SD, e.g. smart phones. So I think we should find an solution to define 
MMC scan order or device number/name in a device tree.

Thanks and regards

Knut


