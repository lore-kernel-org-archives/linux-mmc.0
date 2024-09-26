Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DD9156C40;
	Thu, 26 Sep 2024 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727366187; cv=none; b=aPZ8pBkkfbP1DvcRrGQDrMD7SbV1qpwcs+DoIvTOaTpw6rdcqrPlRolYBHMCeIr1Tj8MF2aiXFk2OwFli8UahKHcBGk2fiKz1WqOsomMc3WfLSsVgvjnX+00aj91wDCv4FYRx3gbaNf46md5q8k2pL+OrPmT9XuGNigKNRfBErk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727366187; c=relaxed/simple;
	bh=WBnnx5zlorm4kEs0yeAw44dctNIiEVNABaauurFcP0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UNHRQYEUJ6d8/BfiRwFsFzydWNfnqe3Kt/DH8VvfNOAOqUkuODJTULJ4lUHZcwTUiHl+Z5Gf0cIHm+6a7nQ13hxwp4dsLbaPUENWc6SFTJXg61qZ0P90YfRj+7EuIpA2jaspGQW/MB0tZIuh77foVgawOwCHlC9AWHW3PhOUYN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7924D14BF;
	Thu, 26 Sep 2024 08:56:47 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE13E3F587;
	Thu, 26 Sep 2024 08:56:16 -0700 (PDT)
Message-ID: <c9100637-663a-4307-9d59-deebcf9ad34c@arm.com>
Date: Thu, 26 Sep 2024 16:56:15 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: core: Only set maximum DMA segment size if DMA is
 supported
To: Guenter Roeck <linux@roeck-us.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
References: <20240924210123.2288529-1-linux@roeck-us.net>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240924210123.2288529-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/09/2024 10:01 pm, Guenter Roeck wrote:
> Since upstream commit 334304ac2bac ("dma-mapping: don't return errors
> from dma_set_max_seg_size") calling dma_set_max_seg_size() on a device
> not supporting DMA results in a warning traceback. This is seen when
> booting the sifive_u machine from SD. The underlying SPI controller
> (sifive,spi0 compatible) explicitly sets dma_mask to NULL.

Hmm, that driver probably shouldn't be doing that, but either way it's 
not actually relevant to this check - what's significant is that when 
the MMC host device is an "mmc-spi-slot" instance, its mmc_dev() ends up 
being the SPI *device* itself, not the grandparent SPI controller.

Thus the patch itself is appropriate on the basis that MMC hosts may 
exist on non-DMA-capable buses, so the subsystem needs to consider that.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Avoid the backtrace by only calling dma_set_max_seg_size() if DMA is
> supported.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   drivers/mmc/core/queue.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index d0b3ca8a11f0..4d6844261912 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -388,7 +388,8 @@ static struct gendisk *mmc_alloc_disk(struct mmc_queue *mq,
>   
>   	blk_queue_rq_timeout(mq->queue, 60 * HZ);
>   
> -	dma_set_max_seg_size(mmc_dev(host), queue_max_segment_size(mq->queue));
> +	if (mmc_dev(host)->dma_parms)
> +		dma_set_max_seg_size(mmc_dev(host), queue_max_segment_size(mq->queue));
>   
>   	INIT_WORK(&mq->recovery_work, mmc_mq_recovery_handler);
>   	INIT_WORK(&mq->complete_work, mmc_blk_mq_complete_work);
