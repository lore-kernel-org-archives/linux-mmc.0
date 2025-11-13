Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C5E21254B
	for <linux-mmc@vger.kernel.org>; Thu, 13 Nov 2025 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763021581; cv=none; b=h+N1LJW6JA+T1Z3CK1VegRYcFeh34brkSQEVAhyB+ZBvtYSveuyJAZT88NR1JuabRHEmd62Xf9N7wQ080nvJ8KACXdXXMLfh4kcqYBJ7K9hvknvOCA8ZV4X+8PTKfwL7ivQ6qxJW5RxgfpQnbFNyWpo65KabH5fiRqohCkrcFM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763021581; c=relaxed/simple;
	bh=nGH0At8qBu3ZNnQzaOXu/y9T18HN37RDrbr9MtEfacg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dj3XscaOunlI2KZLFWJzmHu3YivmFm5aR7gUYv0N/Bn40BageegDbnKkBgr1DJCaTB7eBdnN55b2+l4Io3GepcGGxl0X11zk71nKtaDII3F0VKPPHZTHLIxHiTKTZA9b7qy+JgfMi/zPPp3ML/8d/gBAQb2zk2fLO7Lb75X1xNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ToKW0Nt7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ToKW0Nt7"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477549b3082so4206875e9.0
        for <linux-mmc@vger.kernel.org>; Thu, 13 Nov 2025 00:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763021578; x=1763626378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F0hgBMveSb7cwa3tNC9/2B7T1+14tCA7kB4oFGdjB80=;
        b=ToKW0Nt7XN3T9j1BAEs5KLpLV/TLsRYtzzJrfXARrQtkPa4j1zxkL4uoZ1hxc384hl
         W8UJlGCttL6cjlDK0pH1w4Fiw0DFI+XIAN4RD8FphugSoonoKLZs/4TwyhIsjuKIagSx
         tzK/8mEw0MGeNodQACJFaZI978riOsMoQkip9jPgymLFOSZfqJW+3LU6hioxSOBCa+3n
         dS0WgEldtmtdM8fJuGzVIWPkr8iATUZfvIiCGhhlS2M70b/rF5vtPGWvxm7TRpJaM/GO
         8dyBR1nHBEZ8mzWemUy2Xam5icOcg7F9iFRGtQAs7xzvuOPtVEPh7O9dc131cOJZi7by
         Srgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763021578; x=1763626378;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F0hgBMveSb7cwa3tNC9/2B7T1+14tCA7kB4oFGdjB80=;
        b=E21KZNMbZBqc428Phggv6T6MZPeE0JMAjnDxWIGLFa3LaXWn0FdmOhGQchTNj0Z2Sc
         K1MWufZmIOEBbsHPEbBWfEFqD9+rhHD+EMAMda6hB3uN67ZxGhSr80fds0iUqJGOrKWU
         uwklIkB3BdRn60aUio6PAVVDX7/w38Pw0RtjG8S9CSRz7HDmhzB3yHrYvwR7ews5mE3b
         i6MH7DsAeQvmyDgS2ZwN4R4uaXWjI3Y7iHuLDJWFK6qCuDW+b0hNXFMCm21A+KcuC77D
         ebTGPXL18qkfr+RoKuzFwdwjKs7ZUe3+ml7NuBspCdVgjLiBdU5rB7nHLvuEIOQpwYfv
         IJhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEYKYGpuRTPGc9Xc6q/j1tiN6V9B0TnX/HfPSb0oiYi8Ndscq0iQl0mXAvSnYBAc4Ekjxa0c2O9ZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdUdnG5I9CW43kvrq++ZH0PaH/1pCpYHUvEcW96xTwQXC1d3WI
	Fviafi6N5UTJzegc2riew30hqYfeumDWsSm9EZFLnAy6vxK/gghYijcmryWKBs6DlAg=
X-Gm-Gg: ASbGncu9lEu8E4h7POVzJ5cQrn+j483w9OT66aMY9y7a8aw+y3EaB5qJ0cnBPqmL3Sp
	ARPMCAE8h8MgECGE9kxnrx8NDBDz4AcRVqFwYnMHflX1pXK8n32IVcql7YY4x1S4ZCPHtgvlEPh
	p2cfXLS48mo4D6SBTpU1WEXRD0Po6TsA1IadiLnhBZqZMEjZFLwD8PS58h5lmcYxqS/aEcNt0ps
	CmbVHFt/bA0qdxFfg0nAgfhlGN6Zh5d2BxCTitfGkfTRa954JkD3+M3G2WO8n1tbbDNjLYULzK3
	cUCAo++QrWOVM75nG0hbLLo4yuhmOMX+8j7sQ9ZFTOLW3Xmwgu5qkAq7hwT+6CX3bdI5yvEqvQJ
	htvrkpxUdpdtVQU0UpvZ9SR86o3BvtaR5epvp5GLs723f/6r1vMlXgOL0nR6+vgeg/ZFWpAYnen
	15/IVvDj5C
X-Google-Smtp-Source: AGHT+IEl052iGPh1sTMIdYe2mp1cm5U3r4OeUXO5rJooo4iRckSr2LlzUUnEDP8iWmIaVkMCxaoIbA==
X-Received: by 2002:a05:600c:8b38:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-477870b39e9mr54164035e9.31.1763021578138;
        Thu, 13 Nov 2025 00:12:58 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c8a9456sm20676475e9.15.2025.11.13.00.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 00:12:57 -0800 (PST)
Message-ID: <55e9c0c8-4360-4d08-9269-27a3ff5ba38c@tuxon.dev>
Date: Thu, 13 Nov 2025 10:12:56 +0200
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
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <aRTRLW4bCoZMtCaB@shikoro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Wolfram,

On 11/12/25 20:25, Wolfram Sang wrote:
> 
>> Gentle ping on this series.
> 
> I had a look already but want to test this series on R-Car SoCs. Which
> tests did you apply?
> 

On RZ/G3S the following were checked:
- run bonnie++ on all the SDHIs (with SD card and eMMC, where possible)
- unbind/bind on all the SDHIs and run bonnie++ (with SD card and eMMC,
  where possible) after re-bind
- 32 consecutive suspend/resume (s2idle and deep) and run bonnie++ (with SD
  card and eMMC where possible) after resume

bonnie++ tests were executed after boot on RZ/G2{H, M, N, L, UL}, RZ/V2L.

Thank you,
Claudiu


