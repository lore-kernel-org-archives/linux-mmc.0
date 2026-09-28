Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF1D2D8DC4
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612534; cv=none; b=aUA/wOv+Y9BRmJws3QbIbDePh1pbo8QtubEQPqYqCI7+VMpP/Kol4bTG2+pDYxvI5AhaPvK2nnhh/Y8UScKv5aJ3O/Sq95PgV/eAeM41cstJEFhagrx/ReUDuBj+s4WQ05dfMUn650vqsnqC3CV1g9RlzFkfd/r1cjJlL7rFrEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612534; c=relaxed/simple;
	bh=WBUMNLsirzlSTr+A8TJzMQ3GDuiW6bCNowDjytQerEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=merUIS1qiQ0c2i3QdQcLdGUOq/po01P1FgA2tZWR9G/7rve3YB3nnNEqKdQpmlOuDD0JnVW82sJFTW4IO3Ik1kOhDRH0hbF/cEXWKInWPD2386+8vM1MuFlo6mfmqYY8KuchIsrylMM8mb78WCi7sclgoB93pswulpiQqA2hKX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brivo.com; spf=pass smtp.mailfrom=brivo.com; dkim=pass (2048-bit key) header.d=brivo.com header.i=@brivo.com header.b=Jnkv73Lx; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brivo.com header.i=@brivo.com header.b="Jnkv73Lx"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-52fb766bfd3so28902181cf.0
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 09:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brivo.com; s=google; t=1790612532; x=1791217332; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I9iZ745V3O9TQK90r+cmJTPJh5uGbsz3PptJMxIgYsU=;
        b=Jnkv73LxNJNzjx3EXUAL6KNN1W+3BJ7cdjqY3jqMgrTtmtK4K/jYk2DU1xxvuUlu5y
         zKCAu2A3nyUvHDg/z2LU6GyEhqD3hAajw4egLCoz/3w0nxY9CZMv9QLYvLd10FCkY+zl
         T3vGGn+b5Td5JTAc+ga3tmWP3VvX2nCpjIpDZ57I/NeDM9TL5XfqgZk7zH4a1kjJAxWj
         hJAme6lNT7RXlYX0opuZEgT0CgZQz7lM+VTOQTLLFRm3Do7EmTywGu3HSkNZyNHjNTuH
         ojETuwKMZA3uOsWoGh0tBz9YEsprRy/7G73SfZIZHg9N0dcoTPiOVQbaH3pNyVxjWd2x
         14ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612532; x=1791217332;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I9iZ745V3O9TQK90r+cmJTPJh5uGbsz3PptJMxIgYsU=;
        b=YCNJzfTu0t5fvgW0k/5fgtgW3iX8G0LTsoZzxijvDTSDuesd1xR+rLc6zftUQDgNnT
         0wxe3V4IX7MVGE7SUHomRDpMxqA2T/gpYYgrhSEmMUR0Ft9K+7uib+qaNWEcfG8HgMBJ
         tGcTCHlG7KxML+drqOZUt3LhYAxAfkn7ZkRKSPpiYgKR6tgPT7yD6XiIPn4XHKuor6+1
         aujahOQkmr77yWXiE3jGu9V9KQ1rFt8ZqMccCOr3labILxMBOvwRskZ5Vy/AGTQLleEa
         zzIlJ0riLMlcBSV+7Km3Rk54a5kR3f/vbBwd69KGpvFM0V/6ulZi5rXYAMEnM1/EEXk1
         s44w==
X-Forwarded-Encrypted: i=1; AKwUvBypsWaktNfGj8uBPy40I3UJb20p27P/BM/Vq5VpclPepIG0AQ4uTR9Kb0Hs2dhPtQeKApI6pKczp3o=@vger.kernel.org
X-Gm-Message-State: AFuF++mYhcDnYnFCgR+lnZG77mFfF9sqOwBGHk2+CFgonrm/1gKe9Bic
	oJmkkXLlmCLfaySINfsRkrDRwupbxfHLs7kIQlw/k21HKlGoILRb8XqrPH0ygW1zNSxmBHK/X7P
	oygXGV6JxothkDdDMU2tskpkfglTZsRlitqgPClcem+HL2+32T4Rrw/8=
X-Gm-Gg: AYBFou0Z4huloxtotGdtS4ever4ZqcnTMkjnoH9cgYxw684GZXyhAplkUp8IVrN4jjt
	b0dZ2xlOtaxNobAQCleAZxxcM9tVCWCp4gajwF5HP9zV8uW3Unz0H1wSn7rXVVLiSA40wuxTfi/
	tcKd49YBuSPXZFpxnftbt5OO9b2yZk5fNB7yM2Y+s86lulGPw6M9SLlv+u6YlDIBl1Qnx6W9LVb
	u1rvcvMI2ItVht5zj/lm952Hy5ctVcezukS1UoHs1WnLYFyKDpceqTyPdMnI9D79y0/8PBPnwCy
	qbLFuHiYV3tazjruDzrEInqnmtFhExewTZev/YeSvZH2VisVEJmVgqjHTxeVFmUua0J0NG0KW8w
	lf0gNTie3CTaniM9sLF9y/LVZz+S8DQ4OIDm2chdNZbEg5A7+y5X6hSSrjqQpSY2bQ/Szs7aXx6
	xIc7BV7meOL2FqDc8H1g+F0wufOc0rVJw/IWCydw21sX412ndPa+5LRso+17yTsob03NjxXwfYT
	/U=
X-Received: by 2002:ac8:5c8d:0:b0:533:33c6:e63c with SMTP id d75a77b69052e-53333c6fec4mr122429221cf.16.1790612531895;
        Mon, 28 Sep 2026 09:22:11 -0700 (PDT)
Received: from [10.200.233.210] ([66.193.28.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-533223cad4esm65860381cf.24.2026.09.28.09.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 09:22:11 -0700 (PDT)
Message-ID: <e5a5dccc-46c4-497c-ab8b-b3f7fe5e316d@brivo.com>
Date: Mon, 28 Sep 2026 12:22:11 -0400
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: meson-gx: Convert host->lock to raw spinlock
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
References: <20260921191326.2146363-1-sanderson@brivo.com>
 <CAPx+jO8g-y+uc4YXUeZ3yOH6s44WFpytNu3-f6iLSjtHAVPd+A@mail.gmail.com>
Content-Language: en-US
From: Sean Anderson <sanderson@brivo.com>
In-Reply-To: <CAPx+jO8g-y+uc4YXUeZ3yOH6s44WFpytNu3-f6iLSjtHAVPd+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/28/26 12:17 PM, Ulf Hansson wrote:
> On Mon, Sep 21, 2026 at 9:14 PM Sean Anderson <sanderson@brivo.com> wrote:
>>
>> The primary handler for IRQF_ONESHOT interrupts is always run without
>> threading, even on PREEMPT_RT. Therefore, we must use a raw spinlock,
>> which will never sleep (even on PREEMPT_RT).
> 
> Sorry, but I don't quite understand the above. Are you saying that
> IRQF_ONESHOT only works with raw spinlocks?

The primary handler of an IRQF_ONESHOT handler must use raw spinlocks.

https://www.kernel.org/doc/html/latest/core-api/real-time/differences.html#interrupt-handling

> 
>>
>> Fixes: 066ecde6d826 ("mmc: meson-gx: add SDIO interrupt support")
>> Signed-off-by: Sean Anderson <sanderson@brivo.com>
>> ---
>>
>>   drivers/mmc/host/meson-gx-mmc.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> index 694bb443d5f3f..d5365c0404cb9 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -176,7 +176,7 @@ struct meson_host {
>>
>>          bool needs_pre_post_req;
>>
>> -       spinlock_t lock;
>> +       raw_spinlock_t lock;
>>   };
>>
>>   #define CMD_CFG_LENGTH_MASK GENMASK(8, 0)
>> @@ -953,10 +953,10 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>>          cmd = host->cmd;
>>
>>          if (status & IRQ_SDIO) {
>> -               spin_lock(&host->lock);
>> +               raw_spin_lock(&host->lock);
>>                  __meson_mmc_enable_sdio_irq(host->mmc, 0);
>>                  sdio_signal_irq(host->mmc);
>> -               spin_unlock(&host->lock);
>> +               raw_spin_unlock(&host->lock);
>>                  status &= ~IRQ_SDIO;
>>                  if (!status)
>>                          return IRQ_HANDLED;
>> @@ -1112,9 +1112,9 @@ static void meson_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
>>          struct meson_host *host = mmc_priv(mmc);
>>          unsigned long flags;
>>
>> -       spin_lock_irqsave(&host->lock, flags);
>> +       raw_spin_lock_irqsave(&host->lock, flags);
>>          __meson_mmc_enable_sdio_irq(mmc, enable);
>> -       spin_unlock_irqrestore(&host->lock, flags);
>> +       raw_spin_unlock_irqrestore(&host->lock, flags);
>>   }
>>
>>   static void meson_mmc_ack_sdio_irq(struct mmc_host *mmc)
>> @@ -1225,7 +1225,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
>>          if (ret)
>>                  goto err_init_clk;
>>
>> -       spin_lock_init(&host->lock);
>> +       raw_spin_lock_init(&host->lock);
>>
>>          if (host->dram_access_quirk) {
>>                  /* Limit segments to 1 due to low available sram memory */
>> ---
>> base-commit: 587858367581b9c55c3690f4e63382ad622719d4
>> branch: meson_mmc_raw
>>
>> --
>> 2.53.0
>>

