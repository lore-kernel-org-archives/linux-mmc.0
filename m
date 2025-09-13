Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D064E19258E
	for <linux-mmc@vger.kernel.org>; Sat, 13 Sep 2025 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757776210; cv=none; b=ESLLlouDBtvedhPhAuclOf9ThRfacowgwJResrZrqLB0L48ltom/0nD5Eqv9TkYV9C+SE6XBxdKWzz60XNN8jZI//nIfVvt+cacxIo7yEGsQLDe/DnLEfSwN0/rBwnhxACwEeAnY8Zg5OviXqvvOd7p21Z/qLVpk+krHb6g4cp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757776210; c=relaxed/simple;
	bh=MJf+OC3maX2ZmdUOw7mY7bTSxAiXKJBHLm8Y1+eYoXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZIgAo6w4AamJ0vyIiNh1+UaloHWk9btXJINdP4AGittxPchsHv4CJgnfzY8GBLMin1IXfqmgrlcurIDgOtWdLIr7u8KJYYGKGrI2BfWEOThABCe+jMEtCFGBYIkRF4mLBUagk6KbbCpS1yTM1hCe5m+2YPUmyg2hvIgtItNYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkowNWwM; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkowNWwM"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32e1c40ecb0so154951a91.3
        for <linux-mmc@vger.kernel.org>; Sat, 13 Sep 2025 08:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757776208; x=1758381008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XzdPa1s2Ytoialc1u1fhJTSVdVzF4hVkQANScdjlGlw=;
        b=GkowNWwM2UO5IGbP9o7MyYDkosSehC5DC28O7ahrgker2plf4x5tUJ1yzHTBTZDqEF
         Nb15GfEvJGsN+nLWtx6cz/uHFmWLYI+SZt2v62RSK5HSQkTki0CFRQFKEIlnYiG4SRax
         UOUCRYH6x+7tw0pv5xGhFGgS1dBVCKuEelKvclzqbYr6bPz1tKfGw8FljajcLvYqM6Gu
         JcQLtCGpbc758pTtkju8sweD6VQC9vxGvu5lMrR50w4TQpc35YPUKFuq+8MdgpJrAzbu
         pZCYB1I8GJf2/29i1uap9+DUJgLd0OvZ8eA4FarrOu5uCPF0OPTb/+sxrIRYGJfMYc5D
         Sxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757776208; x=1758381008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XzdPa1s2Ytoialc1u1fhJTSVdVzF4hVkQANScdjlGlw=;
        b=BNOOW9Vjn2Oa2QLy/zJgkrdg8HsiOi33RitkYRU0ouP6MbaMp+4cgosWMUTlYLiOCu
         ZSBR5xOr2eSxyI3KxMZvGTJsRVpwGmTCgkNqsTv0tO+W7JbRpPcTwy8iObdohtzbEWLx
         ztGwetlvtBpGfy9wt7+MUtGceeQGBCETm88ZH4oc/O8SeIA0AKe/pJ+MBTEu2cx2fo63
         HxTvjrpQnkz5vlovhB4zVAgLIkDf9hcE6Y+PP5Ejh3fTpOlWLgdpK54j11Eh/iF54X6Q
         UDTEElVbfCHGpSO0B2P8eOrKT4M8+bpZqUVy9M+C6uRL8lkyYw8+PXU5rT4nzGRh95Bx
         pb2g==
X-Forwarded-Encrypted: i=1; AJvYcCUtb9gy7oNhVPWS0j7P3ta/lLZ4VUCKtv95Seq4JGaVUdDQTD26XvXm2eA2SbtfTfh3k1AyUcdFfB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+aX0DbEi7DjxAOkZVJceKNP3qgQRBh3PBaOGmNY/8bTcOt0Zs
	5pMhu4/rwrA4riUli+O9WKYIM7YCqe9SulFeggGMdr7GvNd3HsMVRDB1
X-Gm-Gg: ASbGncuaOQLzQm+lgdb0paEX6Zd2n3VBN7eTHiYmrjQbVRUlT2awwkoNAkaFWFjSyez
	hbxTRJ3z4e5WZSH/wJu0hdisDRNredVMOYIbF40Ir+jo23e678cx5SypdZWMgebR8jxmX/bxePN
	ajfaggQ++6KPAc6RbY0hDM/GDYC+BOCYtQdSWjgMYyO13Rd5YF5A1GEAKF9EZZAftEPqB2lpviZ
	IrNCwbwg55tH1677Qn3ivGKI+DhNYpSOsE24L2bvkyvKBYS0y5n2ghjvuEZZAslh1L/RBFVPt2W
	d20ywXYmS1dF9oeYe39EgzsMzn7R5Mq5JvTqVf2tC/MnH96LjJm1+5L2oyf6X36Cxe3LubHbtRw
	u5WLCwxovmmiavAlvHQFdGHWWoWfL2p8excfZtPXmI2cWp5hdBMpe7pW1NA==
X-Google-Smtp-Source: AGHT+IFQLwKW78Eyf3cNt54Zk3w44x+XzWX4t92z77pE9LBL04QN3MjfIphxRI6bKsbhdofevXIVfA==
X-Received: by 2002:a17:90b:5750:b0:32b:cba3:6361 with SMTP id 98e67ed59e1d1-32de4f982bdmr7023218a91.26.1757776208005;
        Sat, 13 Sep 2025 08:10:08 -0700 (PDT)
Received: from [192.168.1.6] ([223.181.119.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a4781dsm8798357b3a.33.2025.09.13.08.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 08:10:07 -0700 (PDT)
Message-ID: <3081647a-a4dd-486c-8a3f-c196580a9ee5@gmail.com>
Date: Sat, 13 Sep 2025 20:40:01 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm: dts: ti: omap: Drop unnecessary or unused
 properties
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Barker <paul.barker@sancloud.com>,
 Marc Murphy <marc.murphy@sancloud.com>, Tony Lindgren <tony@atomide.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
References: <20250908-ti-sdhci-omap-v2-0-72927890482f@gmail.com>
 <20250908-ti-sdhci-omap-v2-1-72927890482f@gmail.com>
 <20250909-uptight-fluorescent-markhor-4639db@kuoka>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <20250909-uptight-fluorescent-markhor-4639db@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 09-09-2025 12:50, Krzysztof Kozlowski wrote:
> On Mon, Sep 08, 2025 at 04:17:12PM +0000, Charan Pedumuru wrote:
>> Remove unnecessary properties like ti,needs-special-reset,
>> ti,needs-special-hs-handling and cap-mmc-dual-data-rate from the DTS
>> files as there is no user of them.
> 
> No user? That's not true:
> 
> git grep ti,needs-special-reset

Yes, my bad, I removed them from the whole node. I will revert these changes for the next revision.

> 
> Best regards,
> Krzysztof
> 

-- 
Best Regards,
Charan.

