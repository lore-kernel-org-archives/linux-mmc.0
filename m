Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C40F3264C4
	for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774337711; cv=none; b=dXwD1O20LqxROvj1yjQv0OQEZ7pbYpmdydHuYD6YUji7UK/OntuveBGPbe+zepbr1XaCEPjwvRYDVN5lW8cYTSbua8kg7Evy4lE6gu1F6/YOGHf0JDkTVqB/hg1ZS8txEJfZmdU97bOOpx92FzcBSS/nvo1APymZRwa3pAUR+hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774337711; c=relaxed/simple;
	bh=Lx8PTphFnyuRDVNZL7PZnXwqiuIYb52FURNvsSlQjTM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bTs8kiAfMJ8VOiqLhvBQFL0SulFbn9L4ucuCWKnvBxEKSQyQqNqlSDuR0SWfiIpby9OfPTU8envBbWC0BaSyD2LWwCeIAaOVUk8pgHWsnkz+YS4gy4cqYFuNKq6/g0TXzcziFmJEPbmEn0Kjf1Fm8M0myM3sEj9ESKbDBF+Yk3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M2tdtdAz; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M2tdtdAz"
Message-ID: <00279878-153d-61c7-b5c3-6ffcdd0f0b06@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774337690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ZBpHjUmbLaPNkcz1Yx4YWfnsCvn3NAduIrRpQRcdpk=;
	b=M2tdtdAzAFabbnbqcdXpTuz5uxUdeisgBEcLLKtYc81qMQC1/9tOf80MhZcNJKL0tWU7Q2
	7a46HAfJu8ZtUjxsf1uoyS78VFBV5Ufck7XGJTzQW9Jtmps1J9rNCEZFcb/GeFArvtf3Hp
	dytc3rtPGTI/6r0vnaqtBMRLeVoty30=
Date: Tue, 24 Mar 2026 15:34:37 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: shawn.lin@linux.dev, ulf.hansson@linaro.org, axboe@kernel.dk,
 linux-block@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: block: use single block write in retry
To: Bin Liu <b-liu@ti.com>
References: <20260310160408.3976760-1-b-liu@ti.com>
 <301ff663-7f18-ae12-f0f8-88c4e4375114@linux.dev>
 <20260317132454.b6i7wp763yj36d3v@iaqt7>
 <1806373b-d402-5655-94d4-5cf7142e1382@linux.dev>
 <20260318151735.ffjhbzz4x32n5i7h@iaqt7>
 <20260323130533.y7byr3atch32stn5@iaqt7>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shawn Lin <shawn.lin@linux.dev>
In-Reply-To: <20260323130533.y7byr3atch32stn5@iaqt7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Bin

On 2026/03/23 Monday 21:05, Bin Liu wrote:
> Hi,
> 
> On Wed, Mar 18, 2026 at 10:17:35AM -0500, Bin Liu wrote:
>> Hi Shawn,
>>
>> On Wed, Mar 18, 2026 at 09:43:10AM +0800, Shawn Lin wrote:
>>> 在 2026/03/17 星期二 21:24, Bin Liu 写道:
>>>> Hi Shawn,
>>>>
>>>> On Tue, Mar 17, 2026 at 08:46:40PM +0800, Shawn Lin wrote:
>>>>> 在 2026/03/11 星期三 0:04, Bin Liu 写道:
>>>>>> Due to errata i2493[0], multi-block write would still fail in retries.
>>>>>>
>>>>>> This patch reuses recovery_mode flag, and switches to single-block
>>>>>> write in retry when multi-block write fails. It covers both CQE and
>>>>>> non-CQE cases.
>>>>>
>>>>> MMC core natively retries single for multi block read. So I assume
>>>>> what you are trying to do is make it the same for write path. We didn't
>>>>
>>>> Yes I am trying something similar for writ path, but
>>>>
>>>>> resort to upper block layer for help for read case in the past, so  I
>>>>> think you could still achieve that within the scope of MMC core.
>>>>
>>>> unlike the read path solution, I didn't solve the issue within the scope
>>>> of MMC core, becaure it would intruduce more code than this patch does,
>>>> especially the CQE and non-CQE cases have different failure path. (I
>>>> didn't try to figure out how the single block read retry covers both
>>>> failure cases...)
>>>>
>>>> I feel the solution in this patch is more clever with less code
>>>> introduced.
>>>>
>>>>>
>>>>> More importantly, what is the failure rate of this issue? If it occurs
>>>>
>>>> Very rare. For example, on the EVM, the issue can only be triggered by
>>>> writing 3 or more blocks of data pattern 0xFF00.
>>>
>>> I manually modified cqhci and sdhci to inject errors for multi-block
>>> writes under both CQE and non-CQE modes. The following patch appears to
>>> work by testing. Could you please test it?
>>>
>>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>>> index 05ee76cb0a08..ca60991a3305 100644
>>> --- a/drivers/mmc/core/block.c
>>> +++ b/drivers/mmc/core/block.c
>>> @@ -1642,13 +1642,13 @@ static int mmc_blk_cqe_issue_flush(struct mmc_queue
>>> *mq, struct request *req)
>>>   	return mmc_blk_cqe_start_req(mq->card->host, mrq);
>>>   }
>>>
>>> -static int mmc_blk_hsq_issue_rw_rq(struct mmc_queue *mq, struct request
>>> *req)
>>> +static int mmc_blk_hsq_issue_rw_rq(struct mmc_queue *mq, struct request
>>> *req, int recovery_mode)
>>>   {
>>>   	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>>>   	struct mmc_host *host = mq->card->host;
>>>   	int err;
>>>
>>> -	mmc_blk_rw_rq_prep(mqrq, mq->card, 0, mq);
>>> +	mmc_blk_rw_rq_prep(mqrq, mq->card, recovery_mode, mq);
>>>   	mqrq->brq.mrq.done = mmc_blk_hsq_req_done;
>>>   	mmc_pre_req(host, &mqrq->brq.mrq);
>>>
>>> @@ -1663,13 +1663,23 @@ static int mmc_blk_cqe_issue_rw_rq(struct mmc_queue
>>> *mq, struct request *req)
>>>   {
>>>   	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>>>   	struct mmc_host *host = mq->card->host;
>>> +	int err;
>>>
>>> -	if (host->hsq_enabled)
>>> -		return mmc_blk_hsq_issue_rw_rq(mq, req);
>>> +	if (host->hsq_enabled) {
>>> +		err = mmc_blk_hsq_issue_rw_rq(mq, req, 0);
>>> +		if (err)
>>> +			return mmc_blk_hsq_issue_rw_rq(mq, req, 1);
>>> +	}
>>>
>>>   	mmc_blk_data_prep(mq, mqrq, 0, NULL, NULL);
>>>
>>> -	return mmc_blk_cqe_start_req(mq->card->host, &mqrq->brq.mrq);
>>> +	err = mmc_blk_cqe_start_req(mq->card->host, &mqrq->brq.mrq);
>>> +	if (err) {
>>
>> In the CQE case, when the problem happens due to the errata, this
>> function won't return error. The MMC write error is reported in
>> mmc_blk_cqe_complete_rq() if you see my original patch.
> 
> Which route should we go forward, continue to refine this patch or any
> more comments to my original patch?
> 

Sorry for late reply. I haven't had time to investigate it deeply but I
think it would not block your original patch for folks to review it.

> Thanks,
> -Bin.
> 
>>
>> -Bin.
>>
>>> +		mmc_blk_data_prep(mq, mqrq, 1, NULL, NULL);
>>> +		return mmc_blk_cqe_start_req(mq->card->host, &mqrq->brq.mrq);
>>> +	}
>>> +
>>> +	return 0;
>>>   }
>>>
>>>   static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>>> @@ -1776,24 +1786,26 @@ static int mmc_blk_fix_state(struct mmc_card *card,
>>> struct request *req)
>>>   	return err;
>>>   }
>>>
>>> -#define MMC_READ_SINGLE_RETRIES	2
>>> +#define MMC_RW_SINGLE_RETRIES	2
>>>
>>> -/* Single (native) sector read during recovery */
>>> -static void mmc_blk_read_single(struct mmc_queue *mq, struct request *req)
>>> +/* Single (native) sector read or write during recovery */
>>> +static void mmc_blk_rw_single(struct mmc_queue *mq, struct request *req)
>>>   {
>>>   	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>>>   	struct mmc_request *mrq = &mqrq->brq.mrq;
>>>   	struct mmc_card *card = mq->card;
>>>   	struct mmc_host *host = card->host;
>>>   	blk_status_t error = BLK_STS_OK;
>>> -	size_t bytes_per_read = queue_physical_block_size(mq->queue);
>>> +	size_t bytes_per_rw = queue_physical_block_size(mq->queue);
>>> +
>>>
>>>   	do {
>>>   		u32 status;
>>>   		int err;
>>>   		int retries = 0;
>>>
>>> -		while (retries++ <= MMC_READ_SINGLE_RETRIES) {
>>> +		while (retries++ <= MMC_RW_SINGLE_RETRIES) {
>>>   			mmc_blk_rw_rq_prep(mqrq, card, 1, mq);
>>>
>>>   			mmc_wait_for_req(host, mrq);
>>> @@ -1821,13 +1833,13 @@ static void mmc_blk_read_single(struct mmc_queue
>>> *mq, struct request *req)
>>>   		else
>>>   			error = BLK_STS_OK;
>>>
>>> -	} while (blk_update_request(req, error, bytes_per_read));
>>> +	} while (blk_update_request(req, error, bytes_per_rw));
>>>
>>>   	return;
>>>
>>>   error_exit:
>>>   	mrq->data->bytes_xfered = 0;
>>> -	blk_update_request(req, BLK_STS_IOERR, bytes_per_read);
>>> +	blk_update_request(req, BLK_STS_IOERR, bytes_per_rw);
>>>   	/* Let it try the remaining request again */
>>>   	if (mqrq->retries > MMC_MAX_RETRIES - 1)
>>>   		mqrq->retries = MMC_MAX_RETRIES - 1;
>>> @@ -1969,12 +1981,9 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue
>>> *mq, struct request *req)
>>>   		return;
>>>   	}
>>>
>>> -	if (rq_data_dir(req) == READ && brq->data.blocks >
>>> -			queue_physical_block_size(mq->queue) >> 9) {
>>> -		/* Read one (native) sector at a time */
>>> -		mmc_blk_read_single(mq, req);
>>> -		return;
>>> -	}
>>> +	/* Perform one (native) sector at a time */
>>> +	if (brq->data.blocks > queue_physical_block_size(mq->queue) >> 9)
>>> +		mmc_blk_rw_single(mq, req);
>>>   }
>>>
>>>   static inline bool mmc_blk_rq_error(struct mmc_blk_request *brq)
>>>
