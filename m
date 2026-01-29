Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2777D156236;
	Thu, 29 Jan 2026 05:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769663059; cv=none; b=mj1wdzV9VSkDxdoNxSFErPmM+YmNglFmd8lsorMUEAFBYY/6SXq3jYbVqf5gsXztRDXoHYaYE6HOd12GAiNW/x71QNl6ZKxIl0ZqhllZPYMAvEEtcvGmbG0xZ388nfVQFgJPNhSN8pORPJ5qEfGPHOKCAraQt+kx4anoQt/xJ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769663059; c=relaxed/simple;
	bh=jiAgCkbw2s85krSR1k35CVKBgP2pxoYaQG1D9jITsuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E7K6OXz8I4sXekZvoDk7u6KSyQnApxNvIDsYEJ4XEvK7yPK/36lUZPCDJLFypc54UbIc5q0/devN1WSE9Wvgo26fDeLWvz+0f4TkqpE7hYtI+pAQTgR72Mz9L1f4Klo3hjdP4iTWgnOUgJG6QncXBddc//0R2ARc49WffMH9oiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.42])
	by gateway (Coremail) with SMTP id _____8BxcfBH6nppD80NAA--.45642S3;
	Thu, 29 Jan 2026 13:04:07 +0800 (CST)
Received: from [10.161.0.102] (unknown [223.64.69.42])
	by front1 (Coremail) with SMTP id qMiowJCxdcBG6npppts4AA--.9803S2;
	Thu, 29 Jan 2026 13:04:06 +0800 (CST)
Message-ID: <9fd0f4c4-83b8-47f2-8480-1770ff254b4c@loongson.cn>
Date: Thu, 29 Jan 2026 13:04:05 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: loongson2-mmc: drop redundant memset after
 dma_alloc_coherent()
To: Andre Korol <andre.korol.dev@gmail.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260129035917.48080-1-andre.korol.dev@gmail.com>
From: Binbin Zhou <zhoubinbin@loongson.cn>
In-Reply-To: <20260129035917.48080-1-andre.korol.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJCxdcBG6npppts4AA--.9803S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEBCGl4U7kTvwAFsb
X-Coremail-Antispam: 1Uk129KBj9xXoWrur13XryDKF18Wr18Gw1fZrc_yoW3ZFc_GF
	yIqr97Ww1Dtry3Zw10q3s5Zr4aqFyruFn5uFn5t3yfua4jqwn3X340vr95G3W3Wrn7AFW5
	Cw4rC3savr1UCosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU24SoDUUUU


On 2026/1/29 11:59, Andre Korol wrote:
> dma_alloc_coherent() returns zeroed memory, so the memset() immediately
> after allocation is redundant.
>
> Signed-off-by: Andre Korol <andre.korol.dev@gmail.com>
LGTM.
Reviewed-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>   drivers/mmc/host/loongson2-mmc.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/loongson2-mmc.c b/drivers/mmc/host/loongson2-mmc.c
> index da3daab5f3d6..026cbd80f114 100644
> --- a/drivers/mmc/host/loongson2-mmc.c
> +++ b/drivers/mmc/host/loongson2-mmc.c
> @@ -846,7 +846,6 @@ static int ls2k2000_mmc_set_internal_dma(struct loongson2_mmc_host *host,
>   	if (!host->sg_cpu)
>   		return -ENOMEM;
>   
> -	memset(host->sg_cpu, 0, PAGE_SIZE);
>   	return 0;
>   }
>   

