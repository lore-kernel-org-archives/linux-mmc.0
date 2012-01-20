From: Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [PATCH v6] mmc: support BKOPS feature for eMMC
Date: Fri, 20 Jan 2012 22:37:55 +0900
Message-ID: <CAELcNGQZC5NaUx03OXzsDZUpruAQvU8NhDL6+MOPRG2vc70_NQ@mail.gmail.com>
References: <4F17AA38.3000901@samsung.com>
	<4F17EEBF.2060401@intel.com>
	<4F17FF7D.9090909@samsung.com>
	<4F180202.1030206@intel.com>
	<CANfBPZ-CUz4nNJFu-L9wSLPFMPCrNAEHdb3NRXCAhgQgJYPeDg@mail.gmail.com>
	<4F19183D.6080105@intel.com>
	<4F191CBF.4080005@samsung.com>
	<4F19503C.1070109@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56371 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625Ab2ATNh5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2012 08:37:57 -0500
Received: by bkas6 with SMTP id s6so440876bka.19
        for <linux-mmc@vger.kernel.org>; Fri, 20 Jan 2012 05:37:55 -0800 (PST)
In-Reply-To: <4F19503C.1070109@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "S, Venkatraman" <svenkatr@ti.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, Konstantin Dorfman <kdorfman@codeaurora.org>

2012/1/20 Adrian Hunter <adrian.hunter@intel.com>:
> On 20/01/12 09:50, Jaehoon Chung wrote:
>> On 01/20/2012 04:31 PM, Adrian Hunter wrote:
>>
>>> On 19/01/12 17:32, S, Venkatraman wrote:
>>>> On Thu, Jan 19, 2012 at 5:14 PM, Adrian Hunter <adrian.hunter@inte=
l.com> wrote:
>>>>> On 19/01/12 13:33, Jaehoon Chung wrote:
>>>>>> Hi Adrian.
>>>>>>
>>>>>> On 01/19/2012 07:21 PM, Adrian Hunter wrote:
>>>>>>
>>>>>>> On 19/01/12 07:29, Jaehoon Chung wrote:
>>>>>>>> Enable eMMC background operations (BKOPS) feature.
>>>>>>>>
>>>>>>>> If URGENT_BKOPS is set after a response, note that BKOPS
>>>>>>>> are required. After all I/O requests are finished, run
>>>>>>>> BKOPS if required. Should read/write operations be requested
>>>>>>>> during BKOPS, first issue HPI to interrupt the ongoing BKOPS
>>>>>>>> and then service the request.
>>>>>>>
>>>>>>> This still does not seem to address my earlier comment which wa=
s:
>>>>>>>
>>>>>>> The main problem with bkops is:
>>>>>>>
>>>>>>> =A0 =A0 =A0If the status is at level 3 ("critical"), some opera=
tions
>>>>>>> =A0 =A0 =A0may extend beyond their original timeouts due to mai=
ntenance
>>>>>>> =A0 =A0 =A0operations which cannot be delayed anymore.
>>>>>>>
>>>>>>> This means:
>>>>>>>
>>>>>>> =A0 =A0 =A01. at level 3 either bkops are run or the timeout of=
 the next
>>>>>>> =A0 =A0 =A0(data?) operation is extended
>>>>>>>
>>>>>>> =A0 =A0 =A02. at level 3 either the bkops must not be interrupt=
ed or the
>>>>>>> =A0 =A0 =A0level must be rechecked after interruption and bkops=
 run again
>>>>>>> =A0 =A0 =A0if the level is still 3, or the timeout of the next =
(data?)
>>>>>>> =A0 =A0 =A0operation is extended
>>>>>>>
>>>>>>
>>>>>> This patch didn't issue the HPI when bkops-status is level2-3
>>>>>> (URGENT_BKOPS case).
>>>>>> I didn't understand that must be recheck?? it's case of using HP=
I..?
>>>>>> If HPI didn't issue,though must be recheck bkops status?
>>>>>> And level-1 control should be considered for future-work.
>>>>>> I will also modify the patch comment..it's confused something.
>>>>>
>>>>> 1. Say there are 2 write requests queued and after the first writ=
e request
>>>>> the bkops level is 3. =A0That means the 2nd write request may tim=
eout because
>>>>> the normal timeout rules do not apply.
>>>>>
>>>>> Thus:
>>>>> =A0 =A0 =A0 =A01. at level 3 either bkops are run or the timeout =
of the next
>>>>> =A0 =A0 =A0 =A0(data?) operation is extended
>>>>>
>>>>> 2. Say you are running bkops because the level was 3 and a write =
request
>>>>> arrives. =A0You use HPI to interrupt the bkops, but the bkops lev=
el may still
>>>>> be 3, so the write request may timeout. =A0Hence:
>>>>>
>>>>> =A0 =A0 =A0 =A02. at level 3 either the bkops must not be interru=
pted or the
>>>>> =A0 =A0 =A0 =A0level must be rechecked after interruption and bko=
ps run again
>>>>> =A0 =A0 =A0 =A0if the level is still 3, or the timeout of the nex=
t (data?)
>>>>> =A0 =A0 =A0 =A0operation is extended
>>>>>
>>>>
>>>> A naive question perhaps, but don't the current timeout values inc=
lude
>>>> sufficient
>>>> buffer to do implicit garbage collection anyways ?
>>>
>>> Maybe, but the problem is the JEDEC specification says otherwise. =A0=
This bit
>>> is a quote:
>>>
>>> =A0 =A0 =A0If the status is at level 3 ("critical"), some operation=
s
>>> =A0 =A0 =A0may extend beyond their original timeouts due to mainten=
ance
>>> =A0 =A0 =A0operations which cannot be delayed anymore.
>>>
>>> I think level 3 is a very rare case so I would just run bkops and w=
ait for
>>> it to finish without interruption.
>>
>> Yes..JEDEC spec say those..but I think not bad that wait for bkops-d=
one..
>> actually i didn't know how long time run the bkops...
>> so i think the use the hpi command..then re-check the bkops-status u=
ntil clear status.
>> (i think the request's priority is higher than any bkops status)
>
> Not if the request is going to fail with a timeout error because bkop=
s is at
> level 3.
i didn't think that...before introduced the bkops, card didn't support =
bkops..
And we are using well without bkops....but bkops is one of feature for
efficiently maintenance.
So..because bkops is at level3, request will fail with timeout error.
Not make sense...
Then i think that if  the request require when running bkops, using
hpi command is not problem.
>
>>
>> it would be open to interpretation that sentence.
>>
>> Best Regards,
>> Jaehoon Chung
>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>>
>>
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
