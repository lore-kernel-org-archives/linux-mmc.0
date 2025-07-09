Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B28EEB3;
	Wed,  9 Jul 2025 01:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752024910; cv=none; b=DGadc9/R125+ZZDLnNUmKDlRZgzylTNb1VQEAwfx4nNCuIFaoCkbW/FQgKd/v91NIoyRLsIyrfvTlcBy8lXAV5c2JX0O4gU3QzBfNOYMQF7EV8j0p1Dm7IZrIUWyhrVSVK6o8PW2xy9GPEul7k5+WFAc+LLAxM1fyq26fLLc79I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752024910; c=relaxed/simple;
	bh=SUQPKP041fFVW1NH4UJbbu8194mgEAtr34OWloQLatk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bPREtCnGTRC4P9sVvJJM9dQh75nVqDEapxqb7pgkHXrRSkC9LPE0I1TSBu3FNt0RQr0GmPFh98BN22dannyBPh2sEUviMn4UbJbu1VA7zoK56l/P3+34yMRaydO2DfGn9Qk3CeAIX6C0rA6Hot1BZD08Lx1i6UX8gVLG+GWmM3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.193])
	by gateway (Coremail) with SMTP id _____8AxSWpAx21oMPIkAQ--.43939S3;
	Wed, 09 Jul 2025 09:34:56 +0800 (CST)
Received: from [10.161.0.102] (unknown [223.64.68.193])
	by front1 (Coremail) with SMTP id qMiowJAxleQ7x21oZkAPAA--.11520S2;
	Wed, 09 Jul 2025 09:34:51 +0800 (CST)
Message-ID: <104dd784-29bb-445e-8581-b5d1e1d22a8f@loongson.cn>
Date: Wed, 9 Jul 2025 09:34:50 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] mmc: loongson2: Fix comparison of unsigned integer
 with less than zero
To: Colin Ian King <colin.i.king@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Huacai Chen <chenhuacai@kernel.org>,
 linux-mmc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250708135348.1888817-1-colin.i.king@gmail.com>
From: Binbin Zhou <zhoubinbin@loongson.cn>
In-Reply-To: <20250708135348.1888817-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxleQ7x21oZkAPAA--.11520S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kw4UKw48WF43WF48AFyrAFc_yoW8Xr4rpF
	W3A3yjkr4DGr47X3WUWa4UWFyY9w1Iqr9rWFs7Ga18uFsYqw1Dury3Ca4Fqrs8ZrWq9FyS
	vF4kuF4DCF4DGabCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
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

Hi Colin:

Thanks for your patch.

Sergio has already submitted the relevant patch to fix this issue:

https://lore.kernel.org/all/20250707185545.46275-1-sperezglz@gmail.com/

Thank you for your attention to loongson2 mmc driver.

在 2025/7/8 21:53, Colin Ian King 写道:
> From: Colin Ian King <colin.i.king@intel.com>
>
> Currently the u32 variable ret is being assigned the return value from
> the call to regmap_read_poll_timeout and checking for a less than zero
> error return and this check is always false. Fix this by making ret a
> signed integer.
>
> Fixes: d0f8e961deae ("mmc: loongson2: Add Loongson-2K2000 SD/SDIO/eMMC controller driver")
> Signed-off-by: Colin Ian King <colin.i.king@intel.com>
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

