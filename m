Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5263DEFF3
	for <linux-mmc@vger.kernel.org>; Wed, 25 Mar 2026 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774448614; cv=none; b=KmaS3U+MxgzHrdyRCEp9eIyWjAElx7aYiwU+zwhiuJgHEwm6EPDX/dFXI//ALAepkEu3YFEsvmWJSuv0CnZ2TbHcG/1hFTtdID0Mb4SjxEVM15FCUga4XCoY7gqDNf31I02/mHICuptdH/8hqQjI4p/UZx1uumtLjMAcuMTmyMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774448614; c=relaxed/simple;
	bh=6k/3DRfSULXerh+4WzXd+PR/y1S6YeoK6HC9RW8MWJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YSV7227g4gSZJ1IlZPOx1BElO6ZF5ycaveif3iOIWqIBuXDbUVhhspUOrzyfUQp2tKXaeAkRl0wxIw6FOYIioFAetR1fajlqWphBaRniC5eLdrlfvPQS9nL+kzVLUcPt9/kziohBbeLjLsRhCDnvwHP5O4fIH7bC37Ma/UOnwDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gFulcITP; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gFulcITP"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-40429b1d8baso2172633fac.0
        for <linux-mmc@vger.kernel.org>; Wed, 25 Mar 2026 07:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774448611; x=1775053411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h4l8y9iNEk5A2ZRpO0P1tlpUCebqepZBhl1n1HuoxaE=;
        b=gFulcITPR6lRlf+TdVA/50cHNevE2SkpymVoDvPHSy7uwvN3z3XQPrV0xw74yGu/U+
         uFU/MXuYhjPNXS9MjRRACDSp29F0tX0+Qnhxzr7KFTfPx7CMnwHWxNQfTA+fVFb5Fi5L
         hu317HqwT5UW3YrDo2GBGuKQNbLLhJPmQwoJ8FEXZraryRYOmcWp0lSeCbWx7a7uL9eq
         ovyt1HRW1mUbZUOwwor9rISe8Gvq7FcQZsatZ8ohtBRr8OYhEnUk88uL24CO04EaTgqW
         az+HyRyq7Kgm1HC54q16zPCb5Wf5E4POG406q0Yt8IG69xOJTlgikIvoHpPlL1N91jF/
         i6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774448611; x=1775053411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h4l8y9iNEk5A2ZRpO0P1tlpUCebqepZBhl1n1HuoxaE=;
        b=qgtdW47pVLX1YhjhAgRlIvoogCz8fxaHJHe+fqLH5U99hUxeFuAITE5FWemO2uC2VL
         L6k5FZbF9/okqRsCrPVkDWlu8xgF+OLL9xKU7M5erHWxxnrFc36ETU3XsrAeUBmYHtcS
         TgBcUhamwpiqNYK8rNO4IaQPLGTJkNeJKVgMXSadhodX3iUfkRtRfBJdmThPooDFz+Ct
         v1M6vj5cuOvzP8t3dnkvNvrd0eLTNsmKnjOmGZO+eAB3d1GiMQfh+9kem77ajOm8pfBM
         CGIcztmaiSQuEGHaYHHb87UnZN3qEuF8uBhFwR5jJSwMpVJWVQrRUX0OWL3qrouWMhSn
         bXnw==
X-Forwarded-Encrypted: i=1; AJvYcCUJCOAe3UJ3hJ8IEtICATfx7W1n48bcjI5bgXIX7h7ps+9epGociadXTG4bWa81S2fKtqlZBCoz4vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLrbNFJdayW/RfclnGGrTCBhrIkcPK517MdhXQROG8LGr5opT1
	2aQ3kAyfIkPzTeA0WkttzldYZyjHpWFMOQu+0p6vm8XC7mqiqvvMBgE8FTwD0e7yKA4=
X-Gm-Gg: ATEYQzzN+tKe16/Cdgx1XWab2HAAohwF2K1tl4y3Jt4KyFl7uq472G/WE9LHInx2M68
	sQfujj6hHFU19xyhJNxRU5bywS5seCZY1ixEOIsVt3SZNaIY+ETVc0Pbq9l9eCn6a3DxSR0ElVK
	fPZTPpz8zUTPc/9bvA9tqkKiadlTb8Ly9Q+awL9MdPaBInJ2kddrzAngijMwfvranTJqDh6FEC7
	v0MyT8OKQOoJW46ykdJitP8Lr2PV9zhT5s4UpSnnCvj5NVpIHdeeWQ0k1A013QtLx5pP/HBDNo3
	6kSYhkEojHiIwDWsGvFfDjSg7DAEuZ1urGbdtxctFJUIAqX+7sqDNlWHVHCRpcG4CIZvrFtJNLk
	R/bDieIQdJAs7S9tKye4Rin8UdbV7mZ5Yztb1GoUqJfAU8EkZ24t+0RJ509fuv+wxHJ+7avn/q8
	4c9X4HIPJ1cy8DdoaZXSMONG2NhIXBTdBAvxK8ZU1pNuXYAc+HMdMDBt4ddDfM+AD8JXPy/n483
	nbNBrIOihV2ZnfggrWg
X-Received: by 2002:a05:6870:3261:b0:41c:305b:14e1 with SMTP id 586e51a60fabf-41ca6fe29f4mr2170091fac.28.1774448610748;
        Wed, 25 Mar 2026 07:23:30 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c14ddbca8sm16862796fac.15.2026.03.25.07.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 07:23:30 -0700 (PDT)
Message-ID: <91fffaac-587b-46bd-9ce9-f3c354d89b6d@kernel.dk>
Date: Wed, 25 Mar 2026 08:23:29 -0600
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: block: use single block write in retry
To: Bin Liu <b-liu@ti.com>
Cc: linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
 ulf.hansson@linaro.org, shawn.lin@linux.dev
References: <20260324143448.2631888-1-b-liu@ti.com>
 <20260325134947.2799552-1-b-liu@ti.com>
 <b4c84630-ff69-4d1c-8b82-815679d3fa72@kernel.dk>
 <20260325142106.j2uiurbkgac6xw52@iaqt7>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260325142106.j2uiurbkgac6xw52@iaqt7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/26 8:21 AM, Bin Liu wrote:
> On Wed, Mar 25, 2026 at 08:12:36AM -0600, Jens Axboe wrote:
>> On 3/25/26 7:49 AM, Bin Liu wrote:
>>> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
>>> index 1498840a4ea0..c254e6580afd 100644
>>> --- a/drivers/mmc/core/queue.h
>>> +++ b/drivers/mmc/core/queue.h
>>> @@ -61,6 +61,8 @@ enum mmc_drv_op {
>>>  	MMC_DRV_OP_GET_EXT_CSD,
>>>  };
>>>  
>>> +#define	MQRQ_XFER_SINGLE_BLOCK		BIT(0)
>>> +
>>>  struct mmc_queue_req {
>>>  	struct mmc_blk_request	brq;
>>>  	struct scatterlist	*sg;
>>> @@ -69,6 +71,7 @@ struct mmc_queue_req {
>>>  	void			*drv_op_data;
>>>  	unsigned int		ioc_count;
>>>  	int			retries;
>>> +	u32			flags;
>>>  };
>>>  
>>>  struct mmc_queue {
>>
>> I'm assuming retries is a pretty small number (didn't check), so if you
>> care about layout/space in mmc_queue_req, you could make this:
>>
>> 	u16 retries;
>> 	u16 flags;
> 
> I quickly went throught block.c, it appears retries would be only a
> single digit number. I will update the patch to use u16.

Note that this is just my suggestion, it's down to Ulf. But what I would
do is a prep patch that makes retries u16 and ensures that's sane, then
do your flags patch on top of that. I think that's better than making
that unrelated size change for retries in your patch that isn't related
to that at all. It just sets you up to not grow the struct after your
change.

-- 
Jens Axboe
