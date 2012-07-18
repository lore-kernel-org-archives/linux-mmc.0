From: Knut Wohlrab <knut.wohlrab@de.bosch.com>
Subject: Re: Devicetree: Initialization order of mmc block devices?
Date: Wed, 18 Jul 2012 11:49:10 +0200
Message-ID: <50068696.8070408@de.bosch.com>
References: <5006571A.7060103@de.bosch.com> <CAJe_ZhcY78ah81zsfwXxE=bMG4o6v9RwZV_DQyUj7g=d-1hR_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from imta22.fe.bosch.de ([139.15.243.26]:43180 "EHLO
	imta22.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736Ab2GRJw6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jul 2012 05:52:58 -0400
Received: from smtp2-v.fe.bosch.de (imta24.fe.bosch.de [139.15.243.27])
	by imta22.fe.bosch.de (Postfix) with ESMTP id 738AE1E405F5
	for <linux-mmc@vger.kernel.org>; Wed, 18 Jul 2012 11:52:57 +0200 (CEST)
In-Reply-To: <CAJe_ZhcY78ah81zsfwXxE=bMG4o6v9RwZV_DQyUj7g=d-1hR_w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "Behme Dirk (CM-AI/PJ-CF32)" <Dirk.Behme@de.bosch.com>

On 07/18/2012 09:23 AM, Jassi Brar wrote:
> On 18 July 2012 11:56, Dirk Behme <dirk.behme@de.bosch.com> wrote:
>> Similar to [1] we have a device which has two mmc block devices connected:
>> One external removable and a second internal hard wired one. Depending on
>> the availability of the external removable mmc card at boot time, the
>> internal hard wired device becomes mmcblk1 (external mmc card available ==
>> mmcblk0) or mmcblk0 if the external one is not there. This order is given by
>> the hardware.
>>
>> With older, non-DT kernels, we used the hack from [2] to control the
>> initialization order and force the internal hard wired device to mmcblk0.
>>
>> Now, we are switching to a newer, DT based kernel. With a DT based kernel
>> this hack doesn't seem to work an more.
>>
>> Any idea how we could influence the initialization order of the mmc block
>> devices using a DT based kernel? Ensuring that the internal, hard wired mmc
>> card is always mapped to mmcblk0?
>>
> Doesn't it work by simply by moving the "internal" element before
> "external" in the array 'struct twl4030_hsmmc_info mmc[]' ?

Thanks a lot for quick response. Yes, the order of MMC devices in the 
hardware definition of a board file is a possible solution. But we are 
using a device tree file (*.dts) with this definitions:
...
usdhc@02198000 { /* uSDHC3, eMMC */
     fsl,card-wired;
     status = "okay";
};

usdhc@02190000 { /* uSDHC1, SD card */
     cd-gpios = <&gpio1 4 0>;
     wp-gpios = <&gpio1 2 0>;
     status = "okay";
};
....
The order of the entries doesn't matter. The SDHC controller 1 is probed 
first. If a SD card is inserted at boot time, its "mmcblk0", the 
embedded MMC (eMMC) device "mmcblk1".  This makes it difficult to give 
the kernel the correct device for the eMMC root file system 
("root=/dev/mmcblk?p1 ...").

Is there any solution to define a scan order or a MMC device number/name 
with a device tree?

Thanks a lot and best regards

Knut


