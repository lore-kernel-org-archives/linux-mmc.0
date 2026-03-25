Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFCD3A2569
	for <linux-mmc@vger.kernel.org>; Wed, 25 Mar 2026 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774447963; cv=none; b=OsZi0L5YGR4CZqn9zCG93XLRhpk8fgbGvI/YVzymfu7VD07pvNofQ9BsG8ZK1VbRcIWHtbezO9leeJxw8XyJ/goS4taz7TAkRAhIKpXUTnd3YsFqocxpXvg0PjPfAU1dM3ablFsTfogJFuWGrLpnQbVdfK2A2Q+GA8OuE0d5lhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774447963; c=relaxed/simple;
	bh=j428JPEuNQ0DbBAT8nnbgg+VpQNQcs45j9c+Wu9g6qM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kyjUEfuqV+DysBxL0ijtdAACqv5rgZOf3ufO+CAKoWJZVcA+wMOoGPx+jOJMa6d55AmxUrB9hviLnqg4QKM1qzoVoQcFDhyCb5hvxV4G1IYTrNKMoHvzlPKsfZUC1YxX4U8S/FXdyRMz9wjGEXdO2VjsIN48fN9jBPuxqW3nt8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iIDbxY1K; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iIDbxY1K"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-408778a8ec4so1477800fac.0
        for <linux-mmc@vger.kernel.org>; Wed, 25 Mar 2026 07:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774447958; x=1775052758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LVMuoXvhb06TrpVrdMSJEIDZ7aotmkyvpEU/LhNBFyE=;
        b=iIDbxY1Kl7IA6oN/ExH6AnIoPjOMutKvP586nwM+MT5ZRFx1JqmObSBrM1Fk1kGCJF
         Wlo2J70JQapzxipUotSuEnYd/TBRwQ8dSsP0zGgeVCvBqbw2cxJK03JjKc+T8iL46uBD
         UlWOWgJNSI3vf3DiCf3/xUHymwnvsIU7CxXZVg/KgVcy1z/xXgdHHivSjs+wQae3J/Ww
         KpxzdRoIVeJk7Qtaipx/epveOpy02LdukeGhzlbCmKz06ur8wCMIs7DxOUyaTU503YXk
         RMUrZ37JgBSmAgGXhKn0vH+Zu5Dk/vr6JjJP9GEabe6/fcYm3lB61XzLWt/PWyMvzgNS
         OLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774447958; x=1775052758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVMuoXvhb06TrpVrdMSJEIDZ7aotmkyvpEU/LhNBFyE=;
        b=KL4Vobfu3o/505qFby7j9ygR+e0XmQ03f+BcI/QFu9RpQhI6AgdU8+gw2QY8XTqQ8v
         BAJ0BMfebnmPlDwlI0l84qV6vzCoYtVeAn9p+LL12lY5WYahdrnBKP4+znwSd9c3yNWI
         6TN8N0f9nONuhSS8rP/AAwxz+UU5i1zkrs0vIqJYXiAFVM7G7FqSYDhvgm6/GCykHcyv
         FGpEQ9k0zmB1V6XMX6zUGWcMSMw5GntIh5kBRzLFuCGDcLKNgbgxYGlERpW9BSJDGPEE
         /oeePYVaY2vbdJxSXyz3dT3B7j/Qv+gCMBw1thuxoEfIvQqJANO0WbfpWm3R8v6Tw2kM
         kUVA==
X-Forwarded-Encrypted: i=1; AJvYcCUulDjKnUR8bMBh/W9tIZbMWpK5bCtu9chezHV7J5Wq+aKXdXi6GitajP+oHAtSJsKFPPIO/HDVNSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwST+ECPLYI+Z/ocM/2X0PUYJNhx8jW6Flae5nOzUXJXLe3Msoj
	LQ5kqHwHx5fO8GzfOAGn1adcxeN//huk9/VGfKqf4KIfrD7ktKbrpWyaImEqembDwog=
X-Gm-Gg: ATEYQzzk2OGUeb/fknLewATMWc6Ky092p6u5ipX9ebOKtjjYIDmknohOVyzMZFHORom
	WOfRQLA9QaOLoPgV5J21yOU5y39u0bY4PXt9dOttjGaFgdWagLVc9gQg9GC3Lh/XwRpk0C4gXq/
	eDjj7o35rc94sr9AO3GQXII8iNk16qWfcUg7vFlDS2AWHxmtOoKCYEbO7pTJGQJagaV1AwEAETS
	Qd6h0RkoDjO5SctYevUAXbdVuuZdOVCfKyOLUmFxnHEJ5ALHVgngA5JQeLUujt+nX8YwVW9YATy
	+lss3O9F+xjs4M2gn8sUqY8fuDfu+7xOyUw2npQQiMMw3OYuo16kIapqqG+KFaFT/tRMutkKCD7
	KLKgBKGBu0lgr36IFNpc7R4YTfUC4Rmx/F46uDE8e13jFa52ZWkQDv/6fF9Tu73iCQr6LHnGTFA
	xqQefIX/7IbUhCRyAYxfyqAJODejtS9EBMjRh+bU1k/+LAQjjPd+JORWVJA0TYk8TgTnEQG7j7c
	Wy75ALgQA==
X-Received: by 2002:a05:6871:73aa:b0:409:4a88:aa53 with SMTP id 586e51a60fabf-41ca6db3bc8mr1970151fac.13.1774447958480;
        Wed, 25 Mar 2026 07:12:38 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c4833257esm10473296fac.4.2026.03.25.07.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 07:12:37 -0700 (PDT)
Message-ID: <b4c84630-ff69-4d1c-8b82-815679d3fa72@kernel.dk>
Date: Wed, 25 Mar 2026 08:12:36 -0600
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: block: use single block write in retry
To: Bin Liu <b-liu@ti.com>, linux-block@vger.kernel.org,
 linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@linux.dev
References: <20260324143448.2631888-1-b-liu@ti.com>
 <20260325134947.2799552-1-b-liu@ti.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260325134947.2799552-1-b-liu@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/26 7:49 AM, Bin Liu wrote:
> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
> index 1498840a4ea0..c254e6580afd 100644
> --- a/drivers/mmc/core/queue.h
> +++ b/drivers/mmc/core/queue.h
> @@ -61,6 +61,8 @@ enum mmc_drv_op {
>  	MMC_DRV_OP_GET_EXT_CSD,
>  };
>  
> +#define	MQRQ_XFER_SINGLE_BLOCK		BIT(0)
> +
>  struct mmc_queue_req {
>  	struct mmc_blk_request	brq;
>  	struct scatterlist	*sg;
> @@ -69,6 +71,7 @@ struct mmc_queue_req {
>  	void			*drv_op_data;
>  	unsigned int		ioc_count;
>  	int			retries;
> +	u32			flags;
>  };
>  
>  struct mmc_queue {

I'm assuming retries is a pretty small number (didn't check), so if you
care about layout/space in mmc_queue_req, you could make this:

	u16 retries;
	u16 flags;

and not grow the size of it by 8 bytes with that addition.

Not a huge deal, obviously, but always good to consider things like that
to avoid wasting memory for nothing.

-- 
Jens Axboe
