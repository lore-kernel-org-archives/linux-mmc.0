From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC 0/6] mmc: Field Firmware Update
Date: Mon, 4 Apr 2016 13:50:29 +0200
Message-ID: <CAPDyKFoH3=czLW5_AKcJLRZa2ptTuumiMT24PZw6zKBW38WOwQ@mail.gmail.com>
References: <1447426572-11756-1-git-send-email-holgerschurig@gmail.com>
	<SN1PR02MB13891415516DE9FA4756140783070@SN1PR02MB1389.namprd02.prod.outlook.com>
	<CAOpc7mHbM8EYYNRKR+pKnzc0wf1DR1ojX-iFuDWDYyquC3EVZg@mail.gmail.com>
	<CAPDyKFp2WEVF4yi=Upzx+58SY15u=Fp4=tr3_hh7AS3T2yz4qQ@mail.gmail.com>
	<87r3ierjae.fsf@gmail.com>
	<BLUPR02MB2773299A3F882A172DF0E3694FB0@BLUPR02MB277.namprd02.prod.outlook.com>
	<CAPDyKFopp9gaaPu_DBR0Rpcsu6BCXu5DexXiVxYv9v5uX150jw@mail.gmail.com>
	<CAMHSBOUCT0mQfpN6+7NfeaR5wKMOizQeH__-j9fup1Y-H48Wcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:32857 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154AbcDDLuf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2016 07:50:35 -0400
Received: by mail-lb0-f178.google.com with SMTP id u8so157183984lbk.0
        for <linux-mmc@vger.kernel.org>; Mon, 04 Apr 2016 04:50:34 -0700 (PDT)
In-Reply-To: <CAMHSBOUCT0mQfpN6+7NfeaR5wKMOizQeH__-j9fup1Y-H48Wcg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>
Cc: Alex Lemberg <Alex.Lemberg@sandisk.com>, Holger Schurig <holgerschurig@gmail.com>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chris Ball <chris@printf.net>, Baolin Wang <baolin.wang@linaro.org>

On 2 April 2016 at 02:23, Gwendal Grignou <gwendal@chromium.org> wrote:
> On Thu, Jan 14, 2016 at 5:16 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 28 December 2015 at 15:12, Alex Lemberg <Alex.Lemberg@sandisk.com> wrote:
>>> Hi Ulf,
>>>
>>> We succeeded to run FFU via new mmc multi-command ioctl without any code modification,
>>> but only by using Single Sector commands (CMD24).
>>>
>>> From running the FFU and from code review, we see two minor issues in this way of running FFU:
>>> 1. There is no support for Multiple Block write commands (CMD25) in existing IOCTL implementation -
>>
>> That's right. But I guess we cope without the multiple block support!?
>>
>> Although, I wonder how hard it would be to add it...
>>
>>> seems like there is no polling for the card status on data transfer completion.
>>
>> We should fix that!
>>
>> In the rpmb case, we check the status so we can probably trigger that
>> code to run for CMD24/25 as well.
>>
>>> (The kernel FFU implementation supports FFU using Multiple Block Write commands).
>>> 2. As you probably remember, there are two ways to install the new FW in the end of FFU process -
>>> In case MODE_OPERATION_CODES field is not supported by the device, the host sets to NORMAL state
>>
>> Before starting the update, you can find out which mode that is
>> supported and take relevant actions, right?
>>
>>> and initiates a CMD0/HW_Reset/Power cycle to install the new firmware.
>>
>> Yes, but that's fragile - as discussed earlier.
>>
>> What we really need to do is to also remove the "card" device from the
>> system, as otherwise we may have invalid data in its member variables
>> and who knows what issues that can cause to upper levels.
>>
>>> This sequence cannot be done via multi-command ioctl, and requires manual reset of the device/platform.
>>
>> Yepp, it seems so at least for now. Perhaps we can think of a way to
>> improve this?
>>
>>> (The kernel FFU implementation supports both FW install methods).
>>>
>>> For running FFU via new mmc multi-command ioctl, we have modified mmc-utils and add new functionality for FFU.
>>> Please let us know if you want us to submit the patch for mmc-utils FFU functionality via multi-command ioctl.
>>
>> Yes please. Don't forget to send this to Chris as well!
> I am arriving after the battle, but I have finally rebased the eMMC
> FFU kernel ffu code to 4.x. It is based on what Avi and Alex have
> written.
> As stated earlier, the advantage over using MMC_MUTLI_CMD is we can
> force a reset and rescan of the card without asking the user to reboot
> their machine.

No matter what, I think the problem is how you would *safely* deal
with the reset. Especially in the case when the eMMC already has an
mounted file system on it.

Just doing something that *might* work, isn't good enough to me.

> Also, by only sending a firmware name over the ioctl, we can use Kees'
> work for firmware validation (https://lwn.net/Articles/605432/).

The request_firmware() interface would indeed be good to use. Although
unless we can figure out a way on how to safely deal with reset, we
will have to live without request_firmware().

> To prevent downloading firmware from unknown source, we would reject
> some commands (like SWITCH with FFU_MODE) in the kernel
> MMC_IOC/MULTI_CMD ioctl handler.

I don't follow, can you elaborate on this please.

Kind regards
Uffe
