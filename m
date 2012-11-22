From: "Sundar J. Dev" <sundarjdev@gmail.com>
Subject: Re: [PATCH v3 0/5] mmc: Add access to RPMB partition
Date: Thu, 22 Nov 2012 10:02:30 +0530
Message-ID: <CAAexSFQLp=X9dyxNnK=dyMEQrnEBF0KF7Uo-tMaLsS28RH=t7Q@mail.gmail.com>
References: <1344265951-22437-1-git-send-email-loic.pallardy-ext@stericsson.com>
	<87mwyf7rjp.fsf@octavius.laptop.org>
	<1353348746.25586.1.camel@kkonda-linux.qualcomm.com>
	<50AB3E5F.3010906@st.com>
	<1353437680.18639.737.camel@kkonda-linux.qualcomm.com>
	<50ACA52B.4040201@st.com>
	<CAAexSFT-dwRzmH6SOroAPC7y1JZkG63V0yWW9L57L8w-=MjhOA@mail.gmail.com>
	<50AD103E.1070804@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:59044 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753908Ab2KVU3T (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Nov 2012 15:29:19 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so3342193eaa.19
        for <linux-mmc@vger.kernel.org>; Thu, 22 Nov 2012 12:29:18 -0800 (PST)
In-Reply-To: <50AD103E.1070804@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Loic PALLARDY <loic.pallardy@st.com>
Cc: Krishna Konda <kkonda@codeaurora.org>, Chris Ball <cjb@laptop.org>, Loic PALLARDY STE <loic.pallardy-ext@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>

Hi Loic,

On Wed, Nov 21, 2012 at 11:02 PM, Loic PALLARDY <loic.pallardy@st.com> wrote:
> Hi Sundar,
>
> On 11/21/2012 12:02 PM, Sundar J. Dev wrote:
>> Hi Loic,
>>
>> On Wed, Nov 21, 2012 at 3:25 PM, Loic PALLARDY<loic.pallardy@st.com>  wrote:
>>>
>>>>
>>>> I am guessing that you would expect the userspace application too call
>>>> into the ioctl twice to take care of the 4&   5
>>> Yes exactly, you have to first send your command and then to read the
>>> result, 2 IOCTLs are needed
>>>
>>>> and that might not be an
>>>> issue if there was no request processed for mmcqd i.e. no other
>>>> process/thread claims the host. But if that were to happen, then the
>>>> rpmb operation will fail - please let me know if this assumption or my
>>>> understanding of the spec is wrong.
>>> I tested this and I don't identify issue.
>>> I have Android running in parallel of my test and lot of other mmc
>>> accesses are performed in parallel, so my test suite doesn't guarantee
>>> that the 2 ioctls are contiguous.
>>> I had the same understanding of the RPMB specification, but after tests
>>> and discussion with our eMMC provider, it appears that RPMB state
>>> machine is independent of the rest.
>> I have seen the issue described by Krishna in one of the Micron eMMC
>> parts that I tested on. I captured the below CMD snapshot to explain
>> this better:
>>      ------->  ***** START RPMB TRANSACTION *****
>>          -->  RPMB CMD6 - Switch to RPMB partition
>>          -->  RPMB CMD23 - Set BLK_CNT
>>          -->  RPMB CMD25 - Issue a Mult Blk Write
>>          -->      RPMB CMD13 - Issue Status CMD and and check for Write completion
>>      ------->  ***** RPMB TRANSACTION ABORTED BY NON-RPMB ACCESS *****
>>          -->  NON-RPMB CMD6 - Switch to Userdata partition
>>          -->  NON-RPMB CMD23 - Set BLK_CNT
>>          -->  NON-RPMB CMD25 - Issue Mutl Blk Write
>>          -->  NON-RPMB CMD12 - Issue Status CMD and and check for completion
>>      ------->  ***** SWITCH BACK TO RPMB PARTITION *****
>>          -->  RPMB CMD6 - Switch back to RPMB partition
>>          -->  RPMB CMD23 - Set BLK_CNT
>>          -->  RPMB CMD18 - Issue a Mult Blk Read
>>      The RPMB device returns GENERAL FAILURE in the Read data Packet.
>>
> Humm yes log is clear. Micron eMMC doesn't seem to accept interruption
> during RPMB sequence.
> Is it working when transfer is not interrupted?
Yes, it was working when the rpmb transaction is not interrupted by
non-rpmb access.

> I tested on Toshiba and Sandisk without issue but it is not exhaustive
> enough.
> In your test, how many half sectors (256B) are you programming?
I was programming one half sector.

> I got some general failure when writing more than one half sector on
> some devices, but it has been explained by vendor.
>
>> Actually, the eMMC JEDEC spec is not very clear on what is the expected
>> behavior from eMMC chip if a rpmb sequence is interrupted by a non-rpmb
>> command sequence. It works fine on most Samsung and Toshiba
>> eMMC parts that I tested rpmb on. But this one Micron eMMC part showed
>> this problem.
> Yes unclear eMMC JEDEC spec about RPMB was reported by our eMMC provider.
>
>>>>
>>>> Similarly for rpmb write operation, these are the step involved
>>>> 1. Switch partition
>>>> 2. Set block count
>>>> 3. Write data frame - CMD25 to write the rpmb data frame with data
>>>> 4. Set block count
>>>> 5. Read the data - CMD25 to write rpmb data frame indicating that rpmb
>>>> result register is about to be read
>>>> 6. Set block count
>>>> 7. Read rpmb result - CMD18 to read the rpmb result register
>>>>
>>>> In the case of write, there are an additional two commands compared to
>>>> reads. Since all of these needs to be done in one shot, I believe the
>>>> current ioctl is not sufficient and this can be handled in the following
>>>> ways
>>>
>>> No needed to do it in one shot. You can send the write and check status
>>> later.
>>> I tested it, didn't detect any problem.
>>>>
>>>> 1. Extend the current ioctl to handle both cases
>>>> 2. Add a new ioctl cmd for rpmb requests
>>> It was my first implementation, but after internal STE review and eMMC
>>> check I merge it in existing ioctl.
>>>
>>> Please let me know if you detect any issue.
>>>
>>> Regards,
>>> Loic
>>>>
>>>> Personally I think adding another ioctl is a better way to do this since
>>>> the current ioctl will get cumbersome and technically the rpmb requests
>>>> are different kind of requests that need to be done atomically. I  am
>>>> coding this up as a separate ioctl but before I post the patch, I wanted
>>>> feedback on this approach.
>>>>
> Solution must be driven by the most constrained device.
> In that case, I agree with Krishna, in that case a new ioctl seems to be
> the better approach.

I second that. This must be the right way to do it. I can help test the patch
on this Micron eMMC if needed.

>
> Regards,
> Loic
>>>>
>>
>> Thanks,
>> --
>> Sundar Jayakumar Dev


Thanks,
-- 
Sundar Jayakumar Dev
