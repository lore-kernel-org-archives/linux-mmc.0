Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CE4BE6C;
	Tue,  8 Jul 2025 01:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937350; cv=none; b=gDXYTKCwS8+3zAcJeH7EOj7AOQUbjgoLTh9TmzZ3AeZQ7YbFHeLxGdqKeK352o4WTdOUaooRLzA99ZeVLzA4/jGOS4p2IqS6dBbLTweYp0AaKsAVa5M2qctOZ33HuxAhfSKFJ2Go4rBWOEyYL0BmYo7CJotZO6bLScU0ERiAGk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937350; c=relaxed/simple;
	bh=XFc9VGY/pzjFV6Dzys3432VYQ+MxqJl1bQbN0BpIJwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TfWCDHj8EHFA1U+Av+CXO0BpBqymheA1uK8fH5RlYi5HeH9oc8M6i4/eW0Pc8Mgjt8UPH6Z/pHdnLNnShffM2yogW1w8YiL5pZaKd57r9L3uIosjzPEuZGQVX1Ry4V1qo9EXPnrBCA6EonTt1Asw4d1Ovs5/aeAS0MrKv3S1bQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.51])
	by gateway (Coremail) with SMTP id _____8AxSWo9cWxoXwgkAQ--.42337S3;
	Tue, 08 Jul 2025 09:15:41 +0800 (CST)
Received: from [10.161.0.102] (unknown [223.64.69.51])
	by front1 (Coremail) with SMTP id qMiowJDxL8I6cWxodr0NAA--.1989S2;
	Tue, 08 Jul 2025 09:15:39 +0800 (CST)
Message-ID: <9c425d8c-65d4-4430-a45c-d185806b826d@loongson.cn>
Date: Tue, 8 Jul 2025 09:15:38 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: loongson2: prevent integer overflow in ret variable
To: Sergio Perez Gonzalez <sperezglz@gmail.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250707185545.46275-1-sperezglz@gmail.com>
From: Binbin Zhou <zhoubinbin@loongson.cn>
In-Reply-To: <20250707185545.46275-1-sperezglz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxL8I6cWxodr0NAA--.1989S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Gr1UGw18tr4UJr4Uuw1ruFX_yoW8JF4UpF
	W3C3yjkrWDGr45ZFy2g34UuF1UW3yagr9FqFWxGw18WF97Xw1j9r15CayFqrsxZrZ0kFyS
	vFWkCFs8u3WDGabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25EfUUUUU

Hi Sergio:

Thanks for your patch.

在 2025/7/8 02:55, Sergio Perez Gonzalez 写道:
> In loongson2_mmc_dll_mode_init(), `ret` variable is declared
> as u32 but it is expected to hold an int value.
>
> Fixes: d0f8e961deae ("mc: loongson2: Add Loongson-2K2000 SD/SDIO/eMMC controller driver")
> Reported-by: https://scan7.scan.coverity.com/#/project-view/53936/11354?selectedIssue=1644958
>
> Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>

Reviewed-by: Binbin Zhou <zhoubinbin@loongson.cn>

> ---
>   drivers/mmc/host/loongson2-mmc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/loongson2-mmc.c b/drivers/mmc/host/loongson2-mmc.c
> index 515ccf834f0a..ba6bb8fd5535 100644
> --- a/drivers/mmc/host/loongson2-mmc.c
> +++ b/drivers/mmc/host/loongson2-mmc.c
> @@ -485,7 +485,8 @@ static irqreturn_t loongson2_mmc_irq(int irq, void *devid)
>   
>   static void loongson2_mmc_dll_mode_init(struct loongson2_mmc_host *host)
>   {
> -	u32 val, pad_delay, delay, ret;
> +	u32 val, pad_delay, delay;
> +	int ret;
>   
>   	regmap_update_bits(host->regmap, LOONGSON2_MMC_REG_SEL,
>   			   LOONGSON2_MMC_SEL_DATA, LOONGSON2_MMC_SEL_DATA);
Thanks.
Binbin

