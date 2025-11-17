Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F5432826E
	for <linux-mmc@vger.kernel.org>; Mon, 17 Nov 2025 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763370676; cv=none; b=ruXP0ElO3hYVhQUM62u/7kztML/AgIQimTeYtk12y1NO1Yxinb9J90JjgmkvzX3tnKrVeaH0Y+VLCbKQpof+erLOeWq4bpiXcM/CZcNSjPOBR6QpstRX6n8frRyK7jR8GwGsA93JXHHY1mfGqOi7J4E8KW14oNenlAGukEw2VL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763370676; c=relaxed/simple;
	bh=GaZPBm6gUsQPfq9f2nOwKLI6bceBZ1vRdSsXombDMSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gk71oSteWbbafLRvGw6WV2Scobp5CSFWROvDN+T1RlPR8YHgOssnt0Y2Yn9r4IAMe/VomxilU1r7cdcw7jbkdckzVYH/TaMzj4bKme65kFTLspUquUd4Mfyyo8wsLdwzyuQyFemcSSoyX02GuXhAbCrMixi75XstMPoTqCekJKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=FxZifYXW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="FxZifYXW"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477563e28a3so27082255e9.1
        for <linux-mmc@vger.kernel.org>; Mon, 17 Nov 2025 01:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763370673; x=1763975473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0kZPylB3j+lccR/0iWbMtZHa/Te1u7EA4yah7WekK5s=;
        b=FxZifYXWGyVlo5hkQ102z+Zhgx4gfJiPLLS0zzVVo3kLiDzWPnnKUHvK/Q4uEQ+tdq
         YLEy0w7In+JY67jETFrgrl1gA8p8psoOzXLEHSuwOvKES5ysFIMucv+e7PhR9dbXxxpq
         wHGqCKBQ+wmD6UlWmM6LpSr/HoJK0QpcLPeLUD6agAtGKClq6couk5bW0fJOtxdLq3NQ
         45QgSCSA5WIAhD5+hRkv2L4wFkEZPmun/wuPWQ8LvIJDaGcPy5bJgtcoKXaLplnl4mJh
         uMylctkD37rvm2cG21da2Lz0cp8kJLCtdMPE5OhRagWKshtujznaZ6oSmbSMbCnEQZBx
         nnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763370673; x=1763975473;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kZPylB3j+lccR/0iWbMtZHa/Te1u7EA4yah7WekK5s=;
        b=tG9TskHDKW3dALIQwhvJJY3OecTejOLFuHYsDikO7uY1yjZOqiZ59ByIW/J/PEVI46
         UL6RD5bml6kQRwVylhQ68LH39MUEqANM8nUVg1JjzgYHRrGNsXUaxyhzZT1oX0SnhExS
         C13QxS52GYOvjIPrEVGQgn/PKxq93Rn5QLa+xoKPZgtrIjko4FR+p3pGziTVrFIN0mgo
         pBhM0BFzt6We0rtg7YmEt4cA1bhlbnLQwbY0jGgWi1OVimtwI6Rr4dmwGbZsnrs8Zikx
         BHKcBY2gsMmdJHxd9WaBNFcS3PvLGnLQOc1kM7F7Og//wfwqQfeYeurIXvj5CMbjwhN6
         X9lw==
X-Forwarded-Encrypted: i=1; AJvYcCW/sO47kFUcQqvs5jaFCvgx2RrbY+q06yzafpBMAlnTefHX4BP64/85hf2TzB65n9NOtNEf5yqdhZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4p6dLusUCCDCcSqSoAQZEFVgaeVFS+2NbRHoKMzj8DJQ1gOYf
	5FYr5vKVRh/kl45NIBVD7v9S3TepnqG5x5jqNDovhfzbeChv9solU9Vhnvv4I2MwuLQ=
X-Gm-Gg: ASbGncsQerU/BbrD6+8UUSXkb4XzKZytJGjInVJrLDV9SJpsD82VfvA0Kjx1OY2DXXM
	MIK9e2uw4d/1SKl9rMnEl61NRJdLntFe3WmDDIQ0lCqr3NVVNkYMHPEwP4VjuXtcBYwImVwwSWf
	k2O9k4zu1FCZdAgpKZQb9ktLU32EIKwhDLNLKmA3qIPiiaQJ8Mz6b4AtE4Kdc/ThQ4fz6GYA4Qp
	j5AUKzDaUPsAw2dxT7sfEuwj+cffVVeXyt1r9gjy6uuU/atK9HIuV/UFlZ3h7aC1hLQc74xgTiL
	9HlBrkSA3bJsdysp1A9cPAhplzdkLqmnnBx/KwXa5sf+PfrZKgD07nD6w596ctG1xXq673HlECt
	hpIHWGKr1THh0qfOBLFjn3qmoDxG7Or0cvfCirlweYyiyb7hMaqdqIR3YzlXp/5Qv5bzdARLF4p
	FfAKhBKLGl
X-Google-Smtp-Source: AGHT+IEavaUnuxhrBwMIbZSqo7O99TmZuV7viJpnLLbAK5u+IVUMs5jpdhnUXP6mIc/HnTIfEm2Beg==
X-Received: by 2002:a05:600c:1547:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-4778fd89eafmr115944655e9.8.1763370672881;
        Mon, 17 Nov 2025 01:11:12 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779fb67e73sm72125925e9.0.2025.11.17.01.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 01:11:12 -0800 (PST)
Message-ID: <9ee458bf-34c4-4f98-b577-ffb3b23c89ce@tuxon.dev>
Date: Mon, 17 Nov 2025 11:11:11 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] mmc: renesas_sdhi: Handle resets
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: ulf.hansson@linaro.org, p.zabel@pengutronix.de,
 linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20251008042526.3312597-1-claudiu.beznea.uj@bp.renesas.com>
 <8c654a1f-2513-4afb-b33b-fabbafbbe845@tuxon.dev> <aRTRLW4bCoZMtCaB@shikoro>
 <55e9c0c8-4360-4d08-9269-27a3ff5ba38c@tuxon.dev> <aRZKDp2ZI81sSHzG@ninjato>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <aRZKDp2ZI81sSHzG@ninjato>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Wolfram,

On 11/13/25 23:13, Wolfram Sang wrote:
> 
>> On RZ/G3S the following were checked:
>> - run bonnie++ on all the SDHIs (with SD card and eMMC, where possible)
>> - unbind/bind on all the SDHIs and run bonnie++ (with SD card and eMMC,
>>   where possible) after re-bind
>> - 32 consecutive suspend/resume (s2idle and deep) and run bonnie++ (with SD
>>   card and eMMC where possible) after resume
>>
>> bonnie++ tests were executed after boot on RZ/G2{H, M, N, L, UL}, RZ/V2L.
> 
> Thanks, I did some lighter testing on R-Car D3 with bind/unbind and
> suspend-to-ram. Focussing on areas you modified. No regressions, all
> worked fine.

Thank you for checking it!

> 
> Can I get the I3C pinctrl patch for G3S now as a reward? :)
> 
I'll do my best :)

Thank you,
Claudiu

