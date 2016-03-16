From: Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] mmc: card: don't use PF_MEMALLOC
Date: Wed, 16 Mar 2016 07:41:01 -0700
Message-ID: <56E9707D.5070004@fb.com>
References: <1458128635-3539-1-git-send-email-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45648 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966870AbcCPOl3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Mar 2016 10:41:29 -0400
In-Reply-To: <1458128635-3539-1-git-send-email-martink@posteo.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>, ulf.hansson@linaro.org, chuanxiao.dong@intel.com, fabf@skynet.be
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/16/2016 04:43 AM, Martin Kepplinger wrote:
> PF_MEMALLOC is assigned to processes by mm. If drivers prevent memory
> reclaim and mm is not in control, strange hang-up or OOM Killer invocation
> could happen.
>
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> ---
> I use MMC cards with this change perfectly fine. As I understand it,
> even *if* PF_MEMALLOC has a real reason to be here, I think it should
> be very well documented.

Did you try swap on mmcblk?

-- 
Jens Axboe

