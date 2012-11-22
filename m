From: Philip Rakity <prakity@nvidia.com>
Subject: Re: eMMC
Date: Thu, 22 Nov 2012 12:05:52 +0100
Message-ID: <7A2993F3-2CF3-47B5-A790-168FDF7766AE@nvidia.com>
References: <25B60CDC2F704E4E9D88FFD52780CB4C0618CE7E81@SC-VEXCH1.marvell.com>
 <CADz5_gLq3Hy1BBPT21AnvgSfWLWspifdhAivO0U+_O8tFh2kKg@mail.gmail.com>
 <8C4E6DDA-C1E6-44F2-A9F0-9ABB5D63A426@nvidia.com>
 <CADz5_gJFR3mFtCfPoMKTZ+S3frgCBaMHLngScHYdZOdkSqghxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:18949 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755341Ab2KVTEq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Nov 2012 14:04:46 -0500
In-Reply-To: <CADz5_gJFR3mFtCfPoMKTZ+S3frgCBaMHLngScHYdZOdkSqghxQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


On Nov 22, 2012, at 11:44 AM, Kevin Liu <keyuan.liu@gmail.com> wrote:

> 2012/11/22 Philip Rakity <prakity@nvidia.com>:
>> 
>> On Nov 22, 2012, at 11:26 AM, Kevin Liu <keyuan.liu@gmail.com> wrote:
>> 
>>>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Philip Rakity
>>>> Sent: Wednesday, November 21, 2012 8:42 PM
>>>> To: linux-mmc@vger.kernel.org
>>>> Subject: RFC: eMMC
>>>> 
>>>> Recently there have been a number of patches to sdhci.c and discussions on regulators for folks using eMMC.
>>>> 
>>>> I would appreciate any feedback.  The opinions below are my own.
>>>> 
>>>> eMMC is a hardware device.  It is NOT voltage configurable in any real sense other then turning on/off the voltage,
>>>> The board designer is supposed to read the data sheet and hook things up.  It is somewhat unclear to me how having a dummy regulator really helps.
>>>> 
>>> But if the system enabled dummy regulator, regulator_get will return a
>>> dummy regulator if vmmc/vmmcq not found.
>>> So we had better take dummy regulator into consideration.
>>> 
>>>> Given that -- voltage checking for vmmc or vmmcq is not meaningful. eMMC either works or does not.
>>>> The testing for vccq/vcc has no meaning since it cannot be changed.  In fact the samsung eMMC we used for DDR worked at 2.8v.
>>> 
>>> You set the vmmcq regulator to 2.8v while enable the 1.8v signaling
>>> enable bit in host control 2 register.
>>> It's mismatch in logic. But it's good to make DDR50 work under 2.8v(3v).
>>> The reason for this working is the 1.8v signaling enable bit does NOT
>>> control actual signal voltage at all.
>>> In your case, although the 1.8v bit is set, the signal voltage for
>>> both mmc host and emmc chip vmmcq is still 2.8v. Because the actual
>>> signal voltage is controlled by external regulator whose voltage is
>>> not changed.
>>> So DDR50 can keep working since DDR50 support both 1.8v and 3v.
>> 
>> There is no mismatch in logic. The samsung datas sheet says it will work.
>> No external regulators are used.  vmmc and vmmvq are not NULL.
> 
> The mismatch here I mean you set 1.8v as signal voltage but actually
> you use 2.8v. For the host controller, it's mismatch.
> 

This is why I added the callback in shdci.c to handle broken controllers.

> I don't understand "No external regulators are used.  vmmc and vmmvq
> are not NULL".
> vmmc and vmmcq regulator exist or not?
> 
>>> 
>>>> Given this -- we have a chicken and egg situation in sdhci.c
>>>> if we are in this code and the kernel was on eMMC obviously the system is working.
>>>> If we booted the kernel from say SPI then hopefully the boot code has set up the voltage rails correctly.
>>>> I would argue that for eMMC the regulator structure should not be exposed to sdhci.c and everything would just work.
>>>> 
>>> The easy way is just not register vmmc/vmmcq regulator for emmc, right?
>>> 
>>>> SD/UHS cards are a completely different matter and regulators make complete sense.
>> 

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
