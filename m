From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v6] mmc: support BKOPS feature for eMMC
Date: Thu, 19 Jan 2012 21:02:05 +0530
Message-ID: <CANfBPZ-CUz4nNJFu-L9wSLPFMPCrNAEHdb3NRXCAhgQgJYPeDg@mail.gmail.com>
References: <4F17AA38.3000901@samsung.com> <4F17EEBF.2060401@intel.com>
 <4F17FF7D.9090909@samsung.com> <4F180202.1030206@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:38636 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932296Ab2ASPcb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 19 Jan 2012 10:32:31 -0500
Received: by bkbzv15 with SMTP id zv15so42304bkb.10
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jan 2012 07:32:26 -0800 (PST)
In-Reply-To: <4F180202.1030206@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, Konstantin Dorfman <kdorfman@codeaurora.org>

On Thu, Jan 19, 2012 at 5:14 PM, Adrian Hunter <adrian.hunter@intel.com=
> wrote:
> On 19/01/12 13:33, Jaehoon Chung wrote:
>> Hi Adrian.
>>
>> On 01/19/2012 07:21 PM, Adrian Hunter wrote:
>>
>>> On 19/01/12 07:29, Jaehoon Chung wrote:
>>>> Enable eMMC background operations (BKOPS) feature.
>>>>
>>>> If URGENT_BKOPS is set after a response, note that BKOPS
>>>> are required. After all I/O requests are finished, run
>>>> BKOPS if required. Should read/write operations be requested
>>>> during BKOPS, first issue HPI to interrupt the ongoing BKOPS
>>>> and then service the request.
>>>
>>> This still does not seem to address my earlier comment which was:
>>>
>>> The main problem with bkops is:
>>>
>>> =A0 =A0 =A0If the status is at level 3 ("critical"), some operation=
s
>>> =A0 =A0 =A0may extend beyond their original timeouts due to mainten=
ance
>>> =A0 =A0 =A0operations which cannot be delayed anymore.
>>>
>>> This means:
>>>
>>> =A0 =A0 =A01. at level 3 either bkops are run or the timeout of the=
 next
>>> =A0 =A0 =A0(data?) operation is extended
>>>
>>> =A0 =A0 =A02. at level 3 either the bkops must not be interrupted o=
r the
>>> =A0 =A0 =A0level must be rechecked after interruption and bkops run=
 again
>>> =A0 =A0 =A0if the level is still 3, or the timeout of the next (dat=
a?)
>>> =A0 =A0 =A0operation is extended
>>>
>>
>> This patch didn't issue the HPI when bkops-status is level2-3
>> (URGENT_BKOPS case).
>> I didn't understand that must be recheck?? it's case of using HPI..?
>> If HPI didn't issue,though must be recheck bkops status?
>> And level-1 control should be considered for future-work.
>> I will also modify the patch comment..it's confused something.
>
> 1. Say there are 2 write requests queued and after the first write re=
quest
> the bkops level is 3. =A0That means the 2nd write request may timeout=
 because
> the normal timeout rules do not apply.
>
> Thus:
> =A0 =A0 =A0 =A01. at level 3 either bkops are run or the timeout of t=
he next
> =A0 =A0 =A0 =A0(data?) operation is extended
>
> 2. Say you are running bkops because the level was 3 and a write requ=
est
> arrives. =A0You use HPI to interrupt the bkops, but the bkops level m=
ay still
> be 3, so the write request may timeout. =A0Hence:
>
> =A0 =A0 =A0 =A02. at level 3 either the bkops must not be interrupted=
 or the
> =A0 =A0 =A0 =A0level must be rechecked after interruption and bkops r=
un again
> =A0 =A0 =A0 =A0if the level is still 3, or the timeout of the next (d=
ata?)
> =A0 =A0 =A0 =A0operation is extended
>

A naive question perhaps, but don't the current timeout values include
sufficient
buffer to do implicit garbage collection anyways ?
