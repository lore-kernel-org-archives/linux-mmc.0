Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B34D51D
	for <linux-mmc@vger.kernel.org>; Sun, 14 Jul 2024 03:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720927498; cv=none; b=P5sUte27tNUkHdkbG7Dmdkk0YKGIZXvVtgAI8JcacxUZfdv3X6BzJXjOnjiFnn5SyMzPsyFreOom7NsBf6p6vcmRQExbLRGCNG+wc5fMq6YDln1DwPaCdRMyKwrNcwK/XgRWxUQtlft8GifHqWDDZum15UcTQ1VdzKTSeq5U+qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720927498; c=relaxed/simple;
	bh=AD6oqeELZdeY3+jdzejHnBgVmSm3ewswy4oYsmMpti0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKGU3Mk7qro+Uwr0v6GWSEr/w9qOBXKUqLCrABPkRV13FZWs5ouKU4DvE/5PwWS16WbKysLQ07VdWszqi3oOO8+zA9I4AnlKGrpAW+DpcUZhV+Gnlovk3C0Yjy3sGU+mAGkWVVHABL+2gYqtcXqP89sEalGfzt+R6FpNKESVJUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com; spf=pass smtp.mailfrom=schmorgal.com; dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b=QTk2Y7K8; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b="QTk2Y7K8"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fafc154465so1953375ad.2
        for <linux-mmc@vger.kernel.org>; Sat, 13 Jul 2024 20:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google; t=1720927496; x=1721532296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gji+onlNnUE70R+3MpcEBOab5Ab8n9DwdCQyQY8un0g=;
        b=QTk2Y7K8h0OUcfDpLsOlPf3cTRj17evRE0yot/v0749PY82ZhLiWXEq2JjfeNJH+Vl
         EjqBLY3yfCvMsAfZVQz65NEUOoNtdhEAuRvfglpS9eVu6Lkp8/MPVmcsx+EPGYENs7/6
         birxyeSY08vdr+0+5eEQSvP14mHpsfxmHKM0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720927496; x=1721532296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gji+onlNnUE70R+3MpcEBOab5Ab8n9DwdCQyQY8un0g=;
        b=VyvHiOxMcZB6FBSgZWaOevP319KN5akVtLODEgiyqKNJl1qyVhqvDqFE5ZXaZH2hsj
         +YOUjpRSr4poAvqY6bhqinBBM9PywqBr7YZuV3l0J5lopc8xgS2S6U1qztZkPWO3MPvp
         ozOY/sMDHNpls53hy+o+okBA+QPuMFMMhVjIFH+YGY6UuLHIfhsa3cT/EaURAcJjyW1+
         LWvc4UELYoJ5S0fBXLqp2oVm84wfdNt/0Za9ie7mDdvxjyJpLuiaH4bNwMhY2CPM6d2E
         s8Wz1zFhoSmRb9+BGBkixOI9n8X4SQ1PeKUj3fLEYnDtwVsTVBpbwi3zL/6AC61tbrCa
         N7ng==
X-Gm-Message-State: AOJu0YzRNo4gj86jv2FMi8EVTP4Woail2RirYroUS3sm5aroJIGHndJu
	jje65GpsKj5iS4M7o3zg7JW/MJG7nkR9E2HNwiod6sjco3O3e3JGXUBQSL9IoyjxNvVhTmeZJiQ
	oyCs=
X-Google-Smtp-Source: AGHT+IEtlns9WLVMEscRF6VWRkg8tdoEN25PuM1+AYLg+5x0NJz59i9bDW9mj1TFk1dOQY7235MS8g==
X-Received: by 2002:a05:6a21:9997:b0:1c3:c1d0:226 with SMTP id adf61e73a8af0-1c3c1d004dbmr5728840637.7.1720927495618;
        Sat, 13 Jul 2024 20:24:55 -0700 (PDT)
Received: from [192.168.1.33] ([50.120.71.169])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2cacd6dabe5sm3843745a91.44.2024.07.13.20.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jul 2024 20:24:55 -0700 (PDT)
Message-ID: <2bbe1818-3cfd-4acf-a04d-d2c8b9977574@schmorgal.com>
Date: Sat, 13 Jul 2024 20:24:54 -0700
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] mmc: sdhci-pxav2: add SDIO card IRQ workaround for
 PXA168 V1 controller
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-mmc@vger.kernel.org
References: <9ddaef2a-05bb-4fe7-98c5-da40a0813027@stanley.mountain>
Content-Language: en-US
From: Doug Brown <doug@schmorgal.com>
In-Reply-To: <9ddaef2a-05bb-4fe7-98c5-da40a0813027@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dan,

On 7/13/2024 5:53 PM, Dan Carpenter wrote:

>      129         if (mrq->cmd && !mrq->cmd->error &&
>                      ^^^^^^^^
> If mrq->cmd is NULL
> 
> --> 154         mmc_request_done(host->mmc, mrq);
>                                              ^^^
> Then we are toasted because it will crash here
> 
>      155 }

Ah, you're right. I was trying to be safe about never accessing null
pointers when I wrote the code, but since mmc_request_done also assumes
mrq->cmd is not null, it's pointless to check that here. I guess we must
already be guaranteed that it's never null at that point. Otherwise, all
sdhci drivers would crash.

Thanks for the heads up. I will submit a patch that removes the check
against mrq->cmd on line 129.

Doug
