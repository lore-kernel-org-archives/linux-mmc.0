Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F1E15AAAA
	for <linux-mmc@vger.kernel.org>; Thu,  1 Feb 2024 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706778296; cv=none; b=WkXga5zp6qoen6U7OmzRMdrOtZXAOYAL0BOw2HbAJbIURmqW6Y546aYNgwFiua9BM/j4MXwsc7MyC/L4C7JozFDgC3T0iQ3N1eyLpDlKPL/gdQmtdAa23qJKAp77eJfSIBL1h0pAmJiuoMDVgHTopcegyNy6UCjQg/UZn8KabB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706778296; c=relaxed/simple;
	bh=y7prfCi3sw9Ij3JxGUa5abjnCVWmeBg0AHk6G1Z7mtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IflErJv/BWdAPuG6iwPJvQiZe1HMsVwesiee8mOA+OiOZjXNBuDOYRwrA4XjzzBRRMbrbJJtDpxQv/l9tINQhpuGqOe5oilSmHbqxauHjOOml2rD1U5tCijFqLYB4a8yMzY6XzEbl1UAKtMSxQYWZXq0KqHfyTpq6J+MH+Bw+Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=NL+eIPWm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="NL+eIPWm"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40efcb37373so6224465e9.2
        for <linux-mmc@vger.kernel.org>; Thu, 01 Feb 2024 01:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1706778291; x=1707383091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+H1OIrpl3M08ciasbj2GNCN1CROjBuQ13DmIa9Baa8k=;
        b=NL+eIPWmTLdN3TleBJB4GYlK3u3NbGBBanPRMPdlOjcjtFaEuoJl1mvYmacO2SHIwQ
         rfoT2bV+h6bzDs+GCrKUYJnjTyETwLBvA2zw5csC5vKjSXjhOt/q4A8MOB/pTRTqbv2c
         hC+vFCCIUW6sYUaLjL6nO3kuhdD3+j4qXaPbz5uOnOJjd+IEPrnSnKYzV+6RL5djogGR
         POhoZOtjwX5/jA5B6+29nbd4lOGJacHhGyxpNsqSmuolocoqSuvp0gW81Lx6L4V4zQwb
         hBHyC8xB5w8W8+tURF7uEqJfoPR+J4IAg4Hbx5a2Lck/+S+lqAIti+JkWRvRcYXAskyI
         ElUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706778291; x=1707383091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+H1OIrpl3M08ciasbj2GNCN1CROjBuQ13DmIa9Baa8k=;
        b=PCInnErWVgf3cBOKqyDVkVTQIDLtyL3lq5GYvZil5Be0hjt6sZiPDcO0jQjKF3qdZM
         Q/I65zJv/9dCxCm08wDGIME9BiZVzRO/tbs3Tc6vLX/YmuD+ZwSoq9qT6Gwe38hi3+lW
         FNRxY1IAciUnahZ24nf96JMOVrZpaYHTHg3adr9V5XqLypPYNHC/40hOQd8ZIS4VB4JF
         PX9fn53Jt1TFXMSnc0dfTw42Eaf4y37i10OWHzZFy8AB+BhLdppP0gQ7aC9NAeoOBIW1
         dJo8ivUCyxS2Mh5xrn7dbKKEuVmBy13UB4cox2VqnExG0qJ07EkZ/E1YWvQxrKSJPSGV
         M9nw==
X-Gm-Message-State: AOJu0YzRfbWa2c/qqzPktX9/a38t0wHPpRAd5UnbQ2j9WyafRO++1IRp
	J2GSkCYuV89xiUWnNS32bPe9DLpUS1WA0WZRaw3oWljfC86AptAWJ+ek4ROm1rk=
X-Google-Smtp-Source: AGHT+IENVY53e3vd71M5iWs8FnSI1/2+FdngNAmk8ariuiYoWjfXzjK6vsOipyZfrnMxkbVSXhXHDw==
X-Received: by 2002:a05:600c:46c7:b0:40e:fbdd:23a4 with SMTP id q7-20020a05600c46c700b0040efbdd23a4mr3261482wmo.26.1706778291512;
        Thu, 01 Feb 2024 01:04:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWwsyZy/51wTXfJa9lJHnQGWdZ4LrYmMg2McivUJsapr2gu2LGFBjTNwMtPFC40kuqXl8ZOE/Ucbv3GLDa/PrXPeg712t6MIr2yG6fdvAm5aQtAyhj+AwPfqFnRA1t1pgL2SnV1Vcu+qnUEswkAGu24Dv/TBlJebJyVMeOADtjsTPsSwckx
Received: from ?IPV6:2a01:cb05:945b:7e00:9bdc:6887:23a2:4f31? (2a01cb05945b7e009bdc688723a24f31.ipv6.abo.wanadoo.fr. [2a01:cb05:945b:7e00:9bdc:6887:23a2:4f31])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c025200b0040d4e1393dcsm3791761wmj.20.2024.02.01.01.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 01:04:51 -0800 (PST)
Message-ID: <519f7e2e-4df2-4b3c-90e2-2383b6b34562@smile.fr>
Date: Thu, 1 Feb 2024 10:04:50 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: sdhci-omap: issues with PM features since 5.16
Content-Language: fr, en-US
To: Tony Lindgren <tony@atomide.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
 linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Adrian Hunter <adrian.hunter@intel.com>
References: <2e5f1997-564c-44e4-b357-6343e0dae7ab@smile.fr>
 <20240127044851.GW5185@atomide.com>
 <d09925b3-83e6-4c52-878f-4c1db7670543@smile.fr>
 <20240129111733.GX5185@atomide.com>
 <f80b5390-8bfa-43d8-80ce-70b069aef947@smile.fr>
 <7d72f3ee-bcfe-4197-b492-857dc49b2788@smile.fr>
 <20240131103050.GZ5185@atomide.com>
From: Romain Naour <romain.naour@smile.fr>
In-Reply-To: <20240131103050.GZ5185@atomide.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

Le 31/01/2024 à 11:30, Tony Lindgren a écrit :
> Hi,
> 
> Adding the linux-mmc folks to Cc too.
> 
> * Romain Naour <romain.naour@smile.fr> [240130 11:20]:
>> Le 29/01/2024 à 18:42, Romain Naour a écrit :
>>> Le 29/01/2024 à 12:17, Tony Lindgren a écrit :
>>>> So I'm still guessing your issue is with emmc not getting reinitialized
>>>> properly as there's no mmc-pwrseq-emmc configured. Can you give it a
>>>> try? See am5729-beagleboneai.dts for an example.
>>
>> I can't add such mmc-pwrseq-emmc on the custom board, there is no gpio available
>> to reset the emmc device.
>>
>> To resume:
>> - the emmc doesn't work with mmc-hs200-1_8v mode with PM runtime enabled
>> - the emmc works with mmc-hs200-1_8v mode without PM runtime (patch series reverted)
>> - the emmc works with mmc-ddr-1_8v mode with PM runtime enabled
>>
>> AFAIU the hs200 mode requires some pin iodelay tuning (SDHCI_OMAP_REQUIRE_IODELAY)
>> is sdhci_omap_runtime_{suspend,resume} needs to take care of that?
>>
>> The mmc2 clock seems idle when mmc-hs200-1_8v and PM runtime are used.
>>
>> omapconf dump prcm l3init
>>
>> (mmc2 clock idle)
>> | CM_L3INIT_MMC2_CLKCTRL           | 0x4A009330   | 0x01070000 |
>>
>> (mmc2 clock running)
>> | CM_L3INIT_MMC2_CLKCTRL           | 0x4A009330   | 0x01040002 |
>>
>> Thoughts?
> 
> OK so if the emmc reset gpio is not available, seems we should do something
> like the following patch to not set MMC_CAP_POWER_OFF_CARD unless the
> cap-power-off-card devicetree property is set.
> 
> Care to give it a try and see if it helps?

Same problem without MMC_CAP_POWER_OFF_CARD flag (even by removing
MMC_CAP_AGGRESSIVE_PM too).

I did some test with mmc capabilities mask but no progress so far.

Best regards,
Romain


> 
> Regards,
> 
> Tony
> 
> 8< ----------------
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -1339,8 +1339,11 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>  	/* R1B responses is required to properly manage HW busy detection. */
>  	mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
>  
> -	/* Allow card power off and runtime PM for eMMC/SD card devices */
> -	mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_AGGRESSIVE_PM;
> +	/*
> +	 * Allow runtime PM for eMMC/SD card devices. Note that to power off
> +	 * the card, the devicetree property cap-power-off-card must be set.
> +	 */
> +	mmc->caps |= MMC_CAP_AGGRESSIVE_PM;
>  
>  	ret = sdhci_setup_host(host);
>  	if (ret)

