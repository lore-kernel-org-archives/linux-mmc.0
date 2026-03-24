Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CB92BE043
	for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379799; cv=none; b=sirPKnVx5ThykVLeoOWAyuwDZXvbvlPy4/1SXUObgR/lCRv28lUtG3Ehb52DeyM59ZC28duRoQ33QKaT/bMFVt1qq/4PJYFSjramboOHuxKmBgwcPQhLl4EiBHmGsuyLEdNRFPB5sEqmVWY5G4y6upuTtLI3nmapJTphTPVIxWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379799; c=relaxed/simple;
	bh=zhgElkjcxB5zpjl1gZsgfOowRG1l2aMmZleL2SelQ+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+7Debxyh13CIaTn2TDAx/518iRAXsCqm64DZXVqd0C0UjKT3YBASKzWw2Low2QD59U71H6Rx2ywWHwviP1dJINfwH6ZDrHhaHMFs4uiYYn0Sdt9a6cHsAEu6lZdxQRs0RPfhmBhIV5c3Za5bhlIOxpQOLPfTZ+ayfoA5d9X1Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=h1bMN+dW; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="h1bMN+dW"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d7ebe11bffso3899465a34.0
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 12:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774379797; x=1774984597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zaWWWaT7cKjlOatG8KKZZf30KN34367WduFSnjs+olA=;
        b=h1bMN+dWatqykg6dRWSsE8J6Dr76nEPglm/ME+0JVAMyCrS2ZgwvKPoCDq7ITM6nZT
         PrjNAGudEdQYWuiPUasOlPjdNHKcx5dxaqJQq+ZMOpwx0pwDWUGA48AoYD8VinBhHO68
         JoengoFp3zQ/R95At7Ggn04r8f/CxFS4zzJFE2cYLvG9LvEve7uOoR9mOq1gHPKZvKgp
         gn04LNMNvtORmdgi2o3J3kXCEVHyYoOefnNhDfFOLRECQSr506HkY1QKnzyh64C78xKf
         8CpCdMKpFjsMaldgp0T7LxrgpjTkbgO0XUu/BZuv2LVshWGsbxR+Qo5m1A4O47g7z08n
         jnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774379797; x=1774984597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zaWWWaT7cKjlOatG8KKZZf30KN34367WduFSnjs+olA=;
        b=Heh+VvQ181hNy1mSRcc6AqRM7bDCtHSKRBspwy2c/JOd0ne+OXlqC69XQLtXaOpktI
         yzyzIiFq344mmEvHTDDuPqDhiNnpfCqD3UseLXn8bQ1akYfFrQiDJOGtHoF98W7vuSxp
         LAIyNPv2dsz0uBBEI9eeGXAE6sC6SwpfryLL6tmuA5rxlw5XYPLUxEioS7HFDvQ+DhSE
         tw1Qx5+mr/xZQn3He+U2rudmDEn0OBELm+KvhqYdmNAdgLLUoijPs+3bF3HzYwV6zKVA
         zWh0bS7yLxo38k5ei3rbWrl+cfJINt4rXopTo5Z9KfF2UBPVEp+prH0/seLcKU94YDDd
         U92Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZGWEZU4nMfLKJlj62jrr6sSzhkI9AcK8lMljC/Lxj+U8zzk8Rf9p1hnpUpdDh3iDjVpDPo3YyjPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9+6RcvES7jXf1f5pE6FjMU4lNnIQWRh/OflutxtFYYDjqidj3
	I73qlBEDKVwraKpAExExUR+LsPWN7Atcni5sQ468e07WpoeBfJhnQq74+TpvLE/BY/w=
X-Gm-Gg: ATEYQzy/3KStAKLNBqzrJXGAXW1NtumqGI6nq6ZcfYrcd/m97uCyAGw6Q3eAHy8I+dK
	6jBIUOvwg+8RE5E0uysg/LUsnsqpcsyJocUOfkx+KrZFgYdbp96EuLGvBRRBE+5d6VUPUNwiena
	4aJf5KF2pEZJWGkWv4Yx5+mhn2ky8SDD2RjySVxAgmrCmXsrdyC899YVC6DnbQVLV7Y0mBCCzpe
	mOxXdTPxj/IkJOo6ln7NkeEejCTgLVFpKQJ6LsBnhrU4Q3geOgx3xV0Vd06m1uR3gVNoljcbZLg
	4ApVNEOxLGlIdHH33w6nYBZc1wwF3yU3H0eYeNmg0OVNaF4RWmMFoXFcDlLHbElNzZgdrr2OidQ
	hhe196uggJUqBeD5legTwpUrgxK+W+QHG+CfqZp+93vRzJCWqByGOwo6DI2YKokJPFW3M99peIz
	AiY/yotUdHnjWNE40Tm5NVFnLP2N7dP7oFT78y4S28be588gO0/h6cMKNqihESRT+KEyr5GTohD
	A9u
X-Received: by 2002:a05:6830:6739:b0:7d7:49bf:48cf with SMTP id 46e09a7af769-7d9d672cbb5mr340492a34.4.1774379796326;
        Tue, 24 Mar 2026 12:16:36 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d9c7656e82sm2778829a34.24.2026.03.24.12.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 12:16:35 -0700 (PDT)
Message-ID: <33177597-8df5-4494-830e-6e287bb8188a@kernel.dk>
Date: Tue, 24 Mar 2026 13:16:34 -0600
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] block: define new rqf_flags RQF_XFER_SINGLE_BLK
To: Bin Liu <b-liu@ti.com>
Cc: linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
 ulf.hansson@linaro.org, shawn.lin@linux.dev
References: <20260310160408.3976760-1-b-liu@ti.com>
 <20260324143448.2631888-1-b-liu@ti.com>
 <20260324143448.2631888-2-b-liu@ti.com>
 <5c12f6f8-5962-4d66-8414-8f5185438ecb@kernel.dk>
 <20260324191126.kfhwuw4njinh2vrw@iaqt7>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260324191126.kfhwuw4njinh2vrw@iaqt7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/26 1:11 PM, Bin Liu wrote:
> Hi Jens,
> 
> On Tue, Mar 24, 2026 at 12:48:11PM -0600, Jens Axboe wrote:
>> On 3/24/26 8:34 AM, Bin Liu wrote:
>>> This new flag will be used to handle multi-block transfer failure, in
>>> which case single-block transfer will be used.
>>
>> Maybe I missed this in previous discussions, but why can't this flag go
>> into struct mmc_queue_req?
> 
> You didn't miss anything. We didn't discuss about it until now.
> 
> I added the flag in struct request because it already has rq_flags to
> host all the flag bits. But I don't see struct mmc_queue_req has any
> member for this flag purpose. Do you mean we should add a new flag
> member into struct mmc_queue_req?

It's a bad idea to add driver specific flag to the core flags,
particularly when you already have per-rq data associated with the
driver. Then it should surely go there. The block layer doesn't care
about RQF_XFER_SINGLE_BLK, that's strictly a device property. Hence it
should go in the driver, NOT in the block layer.

So yes, add a bool or flags or whatever you need on the driver side.

-- 
Jens Axboe
