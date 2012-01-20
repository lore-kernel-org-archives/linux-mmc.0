From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v6] mmc: support BKOPS feature for eMMC
Date: Fri, 20 Jan 2012 09:31:09 +0200
Message-ID: <4F19183D.6080105@intel.com>
References: <4F17AA38.3000901@samsung.com> <4F17EEBF.2060401@intel.com> <4F17FF7D.9090909@samsung.com> <4F180202.1030206@intel.com> <CANfBPZ-CUz4nNJFu-L9wSLPFMPCrNAEHdb3NRXCAhgQgJYPeDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15721 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743Ab2ATHbJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 20 Jan 2012 02:31:09 -0500
In-Reply-To: <CANfBPZ-CUz4nNJFu-L9wSLPFMPCrNAEHdb3NRXCAhgQgJYPeDg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, Konstantin Dorfman <kdorfman@codeaurora.org>

On 19/01/12 17:32, S, Venkatraman wrote:
> On Thu, Jan 19, 2012 at 5:14 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 19/01/12 13:33, Jaehoon Chung wrote:
>>> Hi Adrian.
>>>
>>> On 01/19/2012 07:21 PM, Adrian Hunter wrote:
>>>
>>>> On 19/01/12 07:29, Jaehoon Chung wrote:
>>>>> Enable eMMC background operations (BKOPS) feature.
>>>>>
>>>>> If URGENT_BKOPS is set after a response, note that BKOPS
>>>>> are required. After all I/O requests are finished, run
>>>>> BKOPS if required. Should read/write operations be requested
>>>>> during BKOPS, first issue HPI to interrupt the ongoing BKOPS
>>>>> and then service the request.
>>>>
>>>> This still does not seem to address my earlier comment which was:
>>>>
>>>> The main problem with bkops is:
>>>>
>>>>      If the status is at level 3 ("critical"), some operations
>>>>      may extend beyond their original timeouts due to maintenance
>>>>      operations which cannot be delayed anymore.
>>>>
>>>> This means:
>>>>
>>>>      1. at level 3 either bkops are run or the timeout of the next
>>>>      (data?) operation is extended
>>>>
>>>>      2. at level 3 either the bkops must not be interrupted or the
>>>>      level must be rechecked after interruption and bkops run again
>>>>      if the level is still 3, or the timeout of the next (data?)
>>>>      operation is extended
>>>>
>>>
>>> This patch didn't issue the HPI when bkops-status is level2-3
>>> (URGENT_BKOPS case).
>>> I didn't understand that must be recheck?? it's case of using HPI..?
>>> If HPI didn't issue,though must be recheck bkops status?
>>> And level-1 control should be considered for future-work.
>>> I will also modify the patch comment..it's confused something.
>>
>> 1. Say there are 2 write requests queued and after the first write request
>> the bkops level is 3.  That means the 2nd write request may timeout because
>> the normal timeout rules do not apply.
>>
>> Thus:
>>        1. at level 3 either bkops are run or the timeout of the next
>>        (data?) operation is extended
>>
>> 2. Say you are running bkops because the level was 3 and a write request
>> arrives.  You use HPI to interrupt the bkops, but the bkops level may still
>> be 3, so the write request may timeout.  Hence:
>>
>>        2. at level 3 either the bkops must not be interrupted or the
>>        level must be rechecked after interruption and bkops run again
>>        if the level is still 3, or the timeout of the next (data?)
>>        operation is extended
>>
> 
> A naive question perhaps, but don't the current timeout values include
> sufficient
> buffer to do implicit garbage collection anyways ?

Maybe, but the problem is the JEDEC specification says otherwise.  This bit
is a quote:

	If the status is at level 3 ("critical"), some operations
	may extend beyond their original timeouts due to maintenance
	operations which cannot be delayed anymore.

I think level 3 is a very rare case so I would just run bkops and wait for
it to finish without interruption.
