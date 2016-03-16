From: Martin Kepplinger <martink@posteo.de>
Subject: Re: [PATCH] mmc: card: don't use PF_MEMALLOC
Date: Wed, 16 Mar 2016 16:07:21 +0100
Message-ID: <56E976A9.40906@posteo.de>
References: <1458128635-3539-1-git-send-email-martink@posteo.de>
 <56E9707D.5070004@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:43027 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932331AbcCPPJG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Mar 2016 11:09:06 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 8890B20B86
	for <linux-mmc@vger.kernel.org>; Wed, 16 Mar 2016 16:08:58 +0100 (CET)
In-Reply-To: <56E9707D.5070004@fb.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jens Axboe <axboe@fb.com>, ulf.hansson@linaro.org, chuanxiao.dong@intel.com, fabf@skynet.be
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Am 2016-03-16 um 15:41 schrieb Jens Axboe:
> On 03/16/2016 04:43 AM, Martin Kepplinger wrote:
>> PF_MEMALLOC is assigned to processes by mm. If drivers prevent memory
>> reclaim and mm is not in control, strange hang-up or OOM Killer
>> invocation
>> could happen.
>>
>> Signed-off-by: Martin Kepplinger <martink@posteo.de>
>> ---
>> I use MMC cards with this change perfectly fine. As I understand it,
>> even *if* PF_MEMALLOC has a real reason to be here, I think it should
>> be very well documented.
> 
> Did you try swap on mmcblk?
> 

No I haven't even thought about that :) If you know it can be necessary
in that case, it's obviously fine. A comment would still be good though.
