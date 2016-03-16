From: Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] mmc: card: don't use PF_MEMALLOC
Date: Wed, 16 Mar 2016 08:12:27 -0700
Message-ID: <56E977DB.90302@fb.com>
References: <1458128635-3539-1-git-send-email-martink@posteo.de>
 <56E9707D.5070004@fb.com> <56E976A9.40906@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:65226 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932331AbcCPPOv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Mar 2016 11:14:51 -0400
In-Reply-To: <56E976A9.40906@posteo.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>, ulf.hansson@linaro.org, chuanxiao.dong@intel.com, fabf@skynet.be
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/16/2016 08:07 AM, Martin Kepplinger wrote:
> Am 2016-03-16 um 15:41 schrieb Jens Axboe:
>> On 03/16/2016 04:43 AM, Martin Kepplinger wrote:
>>> PF_MEMALLOC is assigned to processes by mm. If drivers prevent memory
>>> reclaim and mm is not in control, strange hang-up or OOM Killer
>>> invocation
>>> could happen.
>>>
>>> Signed-off-by: Martin Kepplinger <martink@posteo.de>
>>> ---
>>> I use MMC cards with this change perfectly fine. As I understand it,
>>> even *if* PF_MEMALLOC has a real reason to be here, I think it should
>>> be very well documented.
>>
>> Did you try swap on mmcblk?
>>
>
> No I haven't even thought about that :) If you know it can be necessary
> in that case, it's obviously fine. A comment would still be good though.

That's why it is there! So yes, adding a comment to that effect would be 
a better path forward.

-- 
Jens Axboe

