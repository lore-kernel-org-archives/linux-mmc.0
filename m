From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: eMMC
Date: Thu, 22 Nov 2012 18:44:53 +0800
Message-ID: <CADz5_gJFR3mFtCfPoMKTZ+S3frgCBaMHLngScHYdZOdkSqghxQ@mail.gmail.com>
References: <25B60CDC2F704E4E9D88FFD52780CB4C0618CE7E81@SC-VEXCH1.marvell.com>
	<CADz5_gLq3Hy1BBPT21AnvgSfWLWspifdhAivO0U+_O8tFh2kKg@mail.gmail.com>
	<8C4E6DDA-C1E6-44F2-A9F0-9ABB5D63A426@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35546 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755340Ab2KVTaR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Nov 2012 14:30:17 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so3752854lbb.19
        for <linux-mmc@vger.kernel.org>; Thu, 22 Nov 2012 11:30:17 -0800 (PST)
In-Reply-To: <8C4E6DDA-C1E6-44F2-A9F0-9ABB5D63A426@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@nvidia.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

2012/11/22 Philip Rakity <prakity@nvidia.com>:
>
> On Nov 22, 2012, at 11:26 AM, Kevin Liu <keyuan.liu@gmail.com> wrote:
>
>>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Philip Rakity
>>> Sent: Wednesday, November 21, 2012 8:42 PM
>>> To: linux-mmc@vger.kernel.org
>>> Subject: RFC: eMMC
>>>
>>> Recently there have been a number of patches to sdhci.c and discussions on regulators for folks using eMMC.
>>>
>>> I would appreciate any feedback.  The opinions below are my own.
>>>
>>> eMMC is a hardware device.  It is NOT voltage configurable in any real sense other then turning on/off the voltage,
>>> The board designer is supposed to read the data sheet and hook things up.  It is somewhat unclear to me how having a dummy regulator really helps.
>>>
>> But if the system enabled dummy regulator, regulator_get will return a
>> dummy regulator if vmmc/vmmcq not found.
>> So we had better take dummy regulator into consideration.
>>
>>> Given that -- voltage checking for vmmc or vmmcq is not meaningful. eMMC either works or does not.
>>> The testing for vccq/vcc has no meaning since it cannot be changed.  In fact the samsung eMMC we used for DDR worked at 2.8v.
>>
>> You set the vmmcq regulator to 2.8v while enable the 1.8v signaling
>> enable bit in host control 2 register.
>> It's mismatch in logic. But it's good to make DDR50 work under 2.8v(3v).
>> The reason for this working is the 1.8v signaling enable bit does NOT
>> control actual signal voltage at all.
>> In your case, although the 1.8v bit is set, the signal voltage for
>> both mmc host and emmc chip vmmcq is still 2.8v. Because the actual
>> signal voltage is controlled by external regulator whose voltage is
>> not changed.
>> So DDR50 can keep working since DDR50 support both 1.8v and 3v.
>
> There is no mismatch in logic. The samsung datas sheet says it will work.
> No external regulators are used.  vmmc and vmmvq are not NULL.

The mismatch here I mean you set 1.8v as signal voltage but actually
you use 2.8v. For the host controller, it's mismatch.

I don't understand "No external regulators are used.  vmmc and vmmvq
are not NULL".
vmmc and vmmcq regulator exist or not?

>>
>>> Given this -- we have a chicken and egg situation in sdhci.c
>>> if we are in this code and the kernel was on eMMC obviously the system is working.
>>> If we booted the kernel from say SPI then hopefully the boot code has set up the voltage rails correctly.
>>> I would argue that for eMMC the regulator structure should not be exposed to sdhci.c and everything would just work.
>>>
>> The easy way is just not register vmmc/vmmcq regulator for emmc, right?
>>
>>> SD/UHS cards are a completely different matter and regulators make complete sense.
>
