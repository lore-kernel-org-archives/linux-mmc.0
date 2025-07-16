Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202592673BE;
	Wed, 16 Jul 2025 01:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752630234; cv=none; b=MLe3JfVKphz6kuP+OZiGx9IEEvUwWWM8WmUnMIiSKBlDd8PdcR1VjaD1WYEkvgrw6h3QZDhBluVZnbGWH4v+QxGXNh2cnsOzE6EbLvDdnDNUarhL9a7EIOhanJz1Tgj/4BymBBQCvEDIE7GQHzvgryUGXEtFR4TxGHuf+ZzX/aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752630234; c=relaxed/simple;
	bh=rF0MHVbq+F3cHd/MVDh6va+zZCfHXwW8Po+mxi2i4qE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7qytHTYAAXRn6nFNXiH9sIn8MjBniRDs259bM0Y2qUVWQBq+NW1cimBU7I0wF/iCpbWW0SZKjwGRldBDeJEvK9dyVh+krokVegWsTtSxIKNZxuiWQO20cPcQiV/Bnret8qri027TYqWhYhR6MaKCcaXYqSFuxdhU/XdU2gRa68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.193])
	by gateway (Coremail) with SMTP id _____8DxzOLTA3doZs8qAQ--.22524S3;
	Wed, 16 Jul 2025 09:43:47 +0800 (CST)
Received: from [10.161.0.102] (unknown [223.64.68.193])
	by front1 (Coremail) with SMTP id qMiowJAxz8PSA3do4y0ZAA--.16523S2;
	Wed, 16 Jul 2025 09:43:47 +0800 (CST)
Message-ID: <26b89619-63f8-4534-9f1c-12acc65502b4@loongson.cn>
Date: Wed, 16 Jul 2025 09:43:46 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] mmc: loongson2: Fix error code in
 loongson2_mmc_resource_request()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Huacai Chen
 <chenhuacai@kernel.org>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <847bf395-6d62-49c9-a39d-8e82c5b17bf7@sabinyo.mountain>
From: Binbin Zhou <zhoubinbin@loongson.cn>
In-Reply-To: <847bf395-6d62-49c9-a39d-8e82c5b17bf7@sabinyo.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxz8PSA3do4y0ZAA--.16523S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKFWkWF1kXFy8Kw17AFy3KFX_yoWkGrb_ua
	yjqrn7ur18Gr1Y9FyFqFy8ArWSqFWDW3Wrurs8t3yfuas5t3Z5t34vvrWDGFy3Xr1rCF95
	uwn5A34xAw1rCosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb78YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1EksDUUUUU==

Hi Dan:

Ah, sorry  for my cheap fault, and thanks for your patch.

On 2025/7/16 07:00, Dan Carpenter wrote:
> There is a cut and paste bug so we accidentally return the wrong
> variable.  It should be "ret" instead of PTR_ERR(host->clk).
>
> Fixes: 2115772014bd ("mmc: loongson2: Add Loongson-2K SD/SDIO controller driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>


Reviewed-by: Binbin Zhou <zhoubinbin@loongson.cn>

> ---
>   drivers/mmc/host/loongson2-mmc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/loongson2-mmc.c b/drivers/mmc/host/loongson2-mmc.c
> index ba6bb8fd5535..63d01d2cd978 100644
> --- a/drivers/mmc/host/loongson2-mmc.c
> +++ b/drivers/mmc/host/loongson2-mmc.c
> @@ -887,7 +887,7 @@ static int loongson2_mmc_resource_request(struct platform_device *pdev,
>   	if (host->clk) {
>   		ret = devm_clk_rate_exclusive_get(dev, host->clk);
>   		if (ret)
> -			return PTR_ERR(host->clk);
> +			return ret;
>   
>   		host->current_clk = clk_get_rate(host->clk);
>   	} else {


Thanks.
Binbin

