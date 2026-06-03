Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7803838B12B
	for <linux-mmc@vger.kernel.org>; Wed,  3 Jun 2026 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780478942; cv=none; b=j9v2/c/i8eOfn2PJit052pM5Cpu3x71SHvYyprUq0rwiY6wIrLuW4txHlecQjmSSqfpinUXqnyDT0idiO1Kz2XrxCBORE0/1pTJXfiSygIQfMJHo1zORul8XCjwVojBEzWDCslVx2VRHXkpmDWEPK2IOytUToR2CKtNSZnMDt4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780478942; c=relaxed/simple;
	bh=mtl7LuIV1y9jjt+ThrQG/sDJi9ob2tqcu7N4ugk1B50=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Oz8mdGen/uOhFTjmUll79kXIKb/H10aOJbd0ElYX0omII/fAVXzd49WupKOvlfaXMdzjvSr/RjTMEFLpu7sKzFP+YanFUhRIEODcyrz4eLSyLjaqZ+d77Stu8+Os3lTxf3UFluUt0BD+XwD4OZt4panx9232XryVNGBetMLa+TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gx7bJBjv; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gx7bJBjv"
Message-ID: <9557e06a-bb8e-4c3d-bfab-413af965bd9a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780478929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OxWdzky0wZGC6HPsjMCrYsJjPzuhOnDRT4rr7GQrs84=;
	b=Gx7bJBjvtVMggv87gNmCUxbshSc/QdjxVmT05hmJAtU/b16+C2HKivhzA/dL1cL6UpfKS3
	5rPDjhLlQUbo/j+MLDbf6Im8EsYDAJziBbdAouW8/E0yB8S9QPCU61JV0ybElWulZ0JLId
	/ohtXWdhtyQ7wSo+UKQ/X68SeRXULCI=
Date: Wed, 3 Jun 2026 17:28:27 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: shawn.lin@linux.dev, Ulf Hansson <ulfh@kernel.org>,
 "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..."
 <linux-mmc@vger.kernel.org>, Avri Altman <avri.altman@sandisk.com>,
 Sarthak Garg <quic_sartgarg@quicinc.com>,
 open list <linux-kernel@vger.kernel.org>, Linus Walleij <linusw@kernel.org>,
 Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: Re: [PATCH] mmc: core: sd: Remove unused buffer allocation in
 sd_enable_cache()
To: Chanwoo Lee <cw9316.lee@samsung.com>
References: <CGME20260602094117epcas1p398765b6fb4a8ee28836cfde89744430f@epcas1p3.samsung.com>
 <20260602094058.358267-1-cw9316.lee@samsung.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shawn Lin <shawn.lin@linux.dev>
In-Reply-To: <20260602094058.358267-1-cw9316.lee@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/06/02 星期二 17:40, Chanwoo Lee 写道:
> sd_enable_cache() allocates a 512-byte buffer that is never used.
> sd_write_ext_reg() allocates its own internal buffer, and no read-back
> verification is done in this function. Remove the unnecessary allocation.
> 
> Fixes: 130206a615a9 ("mmc: core: Add support for cache ctrl for SD cards")

This cleanup doesn't deserve a fixes tag, otherwise

Reviewed-by: Shawn Lin <shawn.lin@linux.dev>

> Signed-off-by: Chanwoo Lee <cw9316.lee@samsung.com>
> ---
>   drivers/mmc/core/sd.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 948948ca9b4a..c763efb10f64 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1379,15 +1379,10 @@ static int sd_flush_cache(struct mmc_host *host)
>   
>   static int sd_enable_cache(struct mmc_card *card)
>   {
> -	u8 *reg_buf;
>   	int err;
>   
>   	card->ext_perf.feature_enabled &= ~SD_EXT_PERF_CACHE;
>   
> -	reg_buf = kzalloc(512, GFP_KERNEL);
> -	if (!reg_buf)
> -		return -ENOMEM;
> -
>   	/*
>   	 * Set Cache Enable at bit 0 in the performance enhancement register at
>   	 * 260 bytes offset.
> @@ -1397,7 +1392,7 @@ static int sd_enable_cache(struct mmc_card *card)
>   	if (err) {
>   		pr_warn("%s: error %d writing Cache Enable bit\n",
>   			mmc_hostname(card->host), err);
> -		goto out;
> +		return err;
>   	}
>   
>   	err = mmc_poll_for_busy(card, SD_WRITE_EXTR_SINGLE_TIMEOUT_MS, false,
> @@ -1405,8 +1400,6 @@ static int sd_enable_cache(struct mmc_card *card)
>   	if (!err)
>   		card->ext_perf.feature_enabled |= SD_EXT_PERF_CACHE;
>   
> -out:
> -	kfree(reg_buf);
>   	return err;
>   }
>   

