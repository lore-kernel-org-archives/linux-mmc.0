From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH 1/2] mmc: block: mmcblkN: use slot index instead of dynamic
 name index
Date: Wed, 8 Aug 2012 08:12:22 +0200
Message-ID: <50220346.4030606@de.bosch.com>
References: <1344237900-14815-1-git-send-email-dirk.behme@de.bosch.com> <8739402g1m.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp2-v.fe.bosch.de ([139.15.237.6]:37522 "EHLO
	smtp2-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756532Ab2HHGPI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Aug 2012 02:15:08 -0400
In-Reply-To: <8739402g1m.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>, Jassi Brar <jaswinder.singh@linaro.org>

Hi Chris,

On 06.08.2012 17:31, Chris Ball wrote:
> Hi,
> 
> On Mon, Aug 06 2012, Dirk Behme wrote:
>> On embedded devices, often there is a combination of removable mmc
>> devices (e.g. MMC/SD cards) and hard wired ones (e.g. eMMC).
>> Depending on the hardware configuration, the 'mmcblkN' node might
>> change if the removable device is available or not at boot time.
>>
>> E.g. if the removable device is attached at boot time, it might
>> become mmxblk0. And the hard wired one mmcblk1. But if the removable
>> device isn't there at boot time, the hard wired one will become
>> mmcblk0. This makes it somehow difficult to hard code the root device
>> to the non-removable device and boot fast.
>>
>> This change does simply associate 'N' of 'mmcblkN' with the slot index
>> instead of the dynamic name index. The slot index is always the same,
>> ensuring that the non-removable mmc device is associated always
>> with the same mmcblkN. Independent of the availability of the removable
>> one.
> 
> I like this change in principle,

Thanks :)

> but doesn't it break boot for everyone
> currently using e.g. root=/dev/mmcblk0p1 on slot index 2?  That doesn't
> sound like an acceptable regression.

I'm not really an expert of the code in block.c. Could you imagine a 
change which has the same result we'd like to get with the proposed 
patch but doesn't have the regression you mention?

Many thanks and best regards

Dirk
