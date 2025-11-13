Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A2A33120D
	for <linux-mmc@vger.kernel.org>; Thu, 13 Nov 2025 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763020899; cv=none; b=EHRAMKuklyf553L69D2Dg5mFi7haUoYKKfOjCQGZ7ycrpfp6OYQE8dITVcbUkb0DJLyIICwXdBEkChTpYemnl2Cq7OEUIDVx4s/MYHZDft58TAs6qGsrtvbR08e2SWoQcZD34h5FUQGfknkbWNxBe93Sg3TcRBtDl59QZMlbzD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763020899; c=relaxed/simple;
	bh=YFib5AM2YDHpEw3Y828tvstnd7oYrzk80+0Tk/DHGHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QY1/cNDZJoOB64Q4yDA3WV3bcqsA8EwIhXWcNys+w3wNmAk3bw00c677z8WRB435igcjqrY3l1ar9EAgliJy3KZGURY3O7qp60fgbACZAtPxIXNL0gcCbb0tJT1PFK9njKB1bMT++Pe4RUjoJviNe7bhEJBOgUfHFcrq3DutUTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=GnK9AE/y; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="GnK9AE/y"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so5708725e9.1
        for <linux-mmc@vger.kernel.org>; Thu, 13 Nov 2025 00:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763020894; x=1763625694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+TKXpPbxSNO2sVb7821pvM7dsyeC1CYdB5v9NlDTIXY=;
        b=GnK9AE/yOlq31IrwUr8Vrm9oQLaZbAhQ3HT+wHlUWAvsHikrzB4Sr8SfgndNeqcAKF
         PUo/f0SjdqIhYggqwFQ4uOn6hKR+CXkLZdmT0b9t7QqENiB14YkUBXIyMkXweYiZOjS2
         ryKnp5q5lbBYce+9ONtjjbV+zxsH+oQYBHX9JXG3dQFp6rBfxU74a/bRDmJeIf3Iyf3s
         nwu8WSXdudeEKYS6X1Si4hBEHXDiXlN0HQtfQcgZ73Rh2elvKyy1VdVKDaFWJWesccie
         YXPfvee9+i9IwyRHWjVvN5dSYgefN2qmyRQxGcR4fmuVEyh3MIz0hwNHVSfmRWOtYzXt
         8QgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763020894; x=1763625694;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+TKXpPbxSNO2sVb7821pvM7dsyeC1CYdB5v9NlDTIXY=;
        b=ekIHS33YAHCaJH6EuNhAnT6ikTWqKJ4ghdhnQEdyVlwsjmsnMwjziO6SOXOLia7K6G
         UpuNlrh4mil0C28FGK6p9qyvwuzHa9xdiZC/Y6hy+g+r5wbHy+TFD7NhMOpKi6bIeIwb
         5rCkKDIF1ssggROrErpwODLQ9iHUEn9Bvh4DBjVFQ8He3JkVPyAuow7N7A5he0XhMN3t
         wMv/cL4hjzbSxIkF6jbSOfSS2CN/ZMqCGUczu2niHMGGu0GKDtUVIl4amDrsRjVo1L1f
         k6WT3bltyPxPAyFzLd9TYHLqTlVQ8NKfJ6NOz9bTmHg8JsCJf/pl6OBPeBZY3wHRq7rm
         YMyA==
X-Forwarded-Encrypted: i=1; AJvYcCUGdh6jqzogxX4+vt6Y0yYVxSET2izfl22KR/autpWFotIodeOTWmmUoHzt3c0SPscmo8Dm9Es6e8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuA+vp+jti58CUvmqBrzQQwpMZ9iFeeO1kU4ZOt4MzK4/oT1hd
	xKqQ36HrLxt8pwfcig7VPDLg8uMvFp46/2L1VzukPlFauYqliauKg+Nc0xOBlHLN5Ic=
X-Gm-Gg: ASbGnct1TT5ScRDIRx+y+QrZ62jIUIza+uLkOn/0XrbOOwA5Lnie0+1sVSnF3LwcddJ
	tVfHfxPT09mFq6njXCQK7oYz5y/S7VT8COmvQV0FjfbAB0kXc/XkeHDhl+ZJUqyHdw4uSR6+rv/
	Bo3sEfotz8WJMm710OkpiAKjTt2jbTz0XQYg1DzZ+hQQCxKqUBQDv+caV25AigkSg0VriRRciAh
	bFSFtgPc/Azmm5ClT/gvGZxLpfwyBJesGZGbbBSyQKyxEa54l6B+6KCqGagm7VK8ZhdbXz14fvx
	I3Zpdl8aGoX/N6sHMOofUDY89aMp8Ru+wZy5+m58rePhCvQHDwo1WDxsQf0TmdiUqMDuG8zTeRs
	ZWT0l1epRCLSCTdld08alqFv6tzEvbHSeBQiAdXTn49mgDnw/OQyGIwQrYUT2zQ4w/s8ty8/UP7
	HbgRu3pk/w
X-Google-Smtp-Source: AGHT+IE8qQ+nj44APGWUeQOkc3VUh3xrQcYOiNRiBBkMDO6sDGxE8imI7u/StM+te/EnuRU4DeBwhQ==
X-Received: by 2002:a05:600c:3b11:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-477871c472dmr55301215e9.30.1763020893741;
        Thu, 13 Nov 2025 00:01:33 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47789ffea1esm53136525e9.13.2025.11.13.00.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 00:01:32 -0800 (PST)
Message-ID: <5ead50cd-2855-4e46-8e9a-f0d7a16cc0ef@tuxon.dev>
Date: Thu, 13 Nov 2025 10:01:31 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mmc: renesas_sdhi: Switch to
 SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and pm_ptr()
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: wsa+renesas@sang-engineering.com, p.zabel@pengutronix.de,
 linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20251008042526.3312597-1-claudiu.beznea.uj@bp.renesas.com>
 <20251008042526.3312597-3-claudiu.beznea.uj@bp.renesas.com>
 <CAPDyKFpFYeD9tLA+w4NARKq-Wj-7O2Caa3y8i2Z9NX6J4XLahA@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAPDyKFpFYeD9tLA+w4NARKq-Wj-7O2Caa3y8i2Z9NX6J4XLahA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Uffe,

On 11/11/25 18:22, Ulf Hansson wrote:
> On Wed, 8 Oct 2025 at 06:25, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> SET_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS() are deprecated now
>> and require __maybe_unused protection against unused function warnings.
> 
> I don't see them marked deprecated, is that really the case?

You're right, I got confused myself by some comments on pm.h. I'll update
it in the next version.

Thank you,
Claudiu

> 
>> The usage of pm_ptr() and SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() allows
>> the compiler to see the functions, thus suppressing the warning. Thus
>> drop the __maybe_unused markings.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Other than the above, this looks fine to me!
> 
> Kind regards
> Uffe
> 
>> ---
>>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 11 +++++------
>>  drivers/mmc/host/tmio_mmc.h                   |  2 --
>>  drivers/mmc/host/tmio_mmc_core.c              |  2 --
>>  3 files changed, 5 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
>> index 9e3ed0bcddd6..7ceb7b977a0b 100644
>> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
>> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
>> @@ -599,18 +599,17 @@ static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
>>  }
>>
>>  static const struct dev_pm_ops renesas_sdhi_internal_dmac_dev_pm_ops = {
>> -       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>> -                               pm_runtime_force_resume)
>> -       SET_RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
>> -                          tmio_mmc_host_runtime_resume,
>> -                          NULL)
>> +       SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
>> +       RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
>> +                      tmio_mmc_host_runtime_resume,
>> +                      NULL)
>>  };
>>
>>  static struct platform_driver renesas_internal_dmac_sdhi_driver = {
>>         .driver         = {
>>                 .name   = "renesas_sdhi_internal_dmac",
>>                 .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>> -               .pm     = &renesas_sdhi_internal_dmac_dev_pm_ops,
>> +               .pm     = pm_ptr(&renesas_sdhi_internal_dmac_dev_pm_ops),
>>                 .of_match_table = renesas_sdhi_internal_dmac_of_match,
>>         },
>>         .probe          = renesas_sdhi_internal_dmac_probe,
>> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
>> index c8cdb1c0722e..b9de03325c58 100644
>> --- a/drivers/mmc/host/tmio_mmc.h
>> +++ b/drivers/mmc/host/tmio_mmc.h
>> @@ -209,10 +209,8 @@ void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
>>  void tmio_mmc_disable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
>>  irqreturn_t tmio_mmc_irq(int irq, void *devid);
>>
>> -#ifdef CONFIG_PM
>>  int tmio_mmc_host_runtime_suspend(struct device *dev);
>>  int tmio_mmc_host_runtime_resume(struct device *dev);
>> -#endif
>>
>>  static inline u16 sd_ctrl_read16(struct tmio_mmc_host *host, int addr)
>>  {
>> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
>> index 775e0d9353d5..8be642f737c7 100644
>> --- a/drivers/mmc/host/tmio_mmc_core.c
>> +++ b/drivers/mmc/host/tmio_mmc_core.c
>> @@ -1286,7 +1286,6 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
>>  }
>>  EXPORT_SYMBOL_GPL(tmio_mmc_host_remove);
>>
>> -#ifdef CONFIG_PM
>>  static int tmio_mmc_clk_enable(struct tmio_mmc_host *host)
>>  {
>>         if (!host->clk_enable)
>> @@ -1331,7 +1330,6 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
>>         return 0;
>>  }
>>  EXPORT_SYMBOL_GPL(tmio_mmc_host_runtime_resume);
>> -#endif
>>
>>  MODULE_DESCRIPTION("TMIO MMC core driver");
>>  MODULE_LICENSE("GPL v2");
>> --
>> 2.43.0
>>

