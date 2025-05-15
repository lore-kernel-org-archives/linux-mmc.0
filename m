Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B545928C2AC
	for <linux-mmc@vger.kernel.org>; Thu, 15 May 2025 09:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747300325; cv=none; b=M7alfLUj4uZrSNvHH9isiwkITC3esVe/GXjfz7zV3owZf5zBucD3fs+DQ5tWBGo0pdg2IdoPc1G++Zp/i+or4UKPfR6KM4aFTK9bn/cTO3cHHrMTqzFYjJlD+i7XLZLN6WNbpWv21wmb/7mmpOW4ZPOYm9fNcgRJnsJWSNaXToM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747300325; c=relaxed/simple;
	bh=Y8fh0ydbwDFuT4JP0Uktyo5VIuBqssqojenovaU59/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RO7y30XUVZDXudll4mBXuldNRn08cIjUxeWXVSdP1eTARvT3i3EojEMZ7294BYw2vHb6pWiJrHSNRW1Z57YaSk7cNOBz3/xHQYggsqBSBB75k1CeDm+iO0VuZHVzdZ3DHQpy+8m2mrug5FZJprbFayAILQte2e1nYEU+NmWxkPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jJv3vwR0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jJv3vwR0"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-442ea95f738so4914865e9.3
        for <linux-mmc@vger.kernel.org>; Thu, 15 May 2025 02:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747300322; x=1747905122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CAE9bz2isgxzUGbrKGqqEdeq1PEN+8OwnZGGftLgteU=;
        b=jJv3vwR0aSTmk0oZeJL61m/SKSS731rgOU+85WuPrAwyCrQspNh4lPIk3tIJKmWaYD
         u3zp9d2VeDqo/yRrfPqotiW+R5Jzvu+J386ew48fRkQOEiFKEXrwP05CHUgDflCFgS1S
         bAlh2Cvx1MXcvEE1v4ENNQGy0adlfxzQDXMJ4Ucug9W3v1FXX3STo9cpedj1XwgUII/f
         B4yO/3D0sP4PVAiDBL0iNqWf2eVVGdkauG/LMQkow1Ny/vU6jysg7uK17qJ+6ZyngIIo
         n59n+6/2j13DMfRym3MC6S/QwAmi+XuJb+TKLAxSZ8URqSJvFgdE7WTH4YGU9Z/VqDmz
         RO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747300322; x=1747905122;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CAE9bz2isgxzUGbrKGqqEdeq1PEN+8OwnZGGftLgteU=;
        b=rYKcd/oVHBspGNFhXwR2VSU1x7ICwc/OhUjsVHKYxzu0EuugHIZfAqapqOdTX/MxgQ
         4Lf/UeeJ2ocTdeT+09miI3nzgTyUVLZRQ51lhWcoQ5pEQ6YMeecpOvUaL1gcAoXZ5meY
         ko3+v+cva5P96cvUDKspfltP5iXOu0h8klGVMv/CVmD74EzafVzzAvA7vexrFwkBJn9O
         rrrNg89zqstlRYKmEUt3tl0BS7b8PV3peorOSgdSesP+UAMIKtKIDc2f5vWbQtDRvGYH
         tbTNJ1ShlanScBIOA50I0WJKRg2i/m/K5KcHRGUXQFSGkoBVWYQ+YdzoNgATdwUwMVrD
         EG/A==
X-Forwarded-Encrypted: i=1; AJvYcCW0Dr5qNU83GrCKpY2HI0YAmXb8W2UqtF/DvFwY35lx63zfp4EuLz45kut+IeK/oaFjCXPdCieej4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO0VSL3cOW4JvSmlJ+3IIn9mduO6OJc9KOckx/ewtKT5mjiA83
	I5QpFzbxWOzPTcDOIoc56ned+lQr+fyN5xF86BUWRVebahr15ZpsPs5JM5YDKus=
X-Gm-Gg: ASbGncvhQI80WfHjsDFCRrG+ifVisq+qN2jFLtFBMFuE9abqUbeDSVprAH8UgOT/+rb
	NW8+2rpwdrQm/+EAzHIbRZcNXOINCt0P0Z0lgS2+JKhsiClnXNvvdApyjeSmx8YwvJexM+PJ7ZC
	ZWaDN+CEa3+Yj54/NCr6v83hOd8cmtbXtzi41RT46kHpkDXtXTVgjZUlQ4FLjzdjpvH1BhtWd1q
	JKEJfUG/r06CqAcroZ9qqErUH45Sgb5cW+Rl8Zf2tQ01FSSgSwVfsEZ37ffanfOREwyziQz406s
	oBV0erWe8fB+ULMDbrxLE3R66m63+CGtaptwscRL1ziMXZJK4cZRsFOaueOcnYiIowHQlsk2laV
	ggQPVixTloKQF
X-Google-Smtp-Source: AGHT+IEiWqZK+wIF0dIQPPNEPiVIMFChIw3pA6T9sTYgeSc0xYst5cv/piO7TsYycRsa/pH81nx0gg==
X-Received: by 2002:a05:600c:b91:b0:43c:f597:d589 with SMTP id 5b1f17b1804b1-442f2177567mr56412345e9.27.1747300321871;
        Thu, 15 May 2025 02:12:01 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a1f57de100sm21837759f8f.2.2025.05.15.02.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 02:12:01 -0700 (PDT)
Message-ID: <726e96bd-d4c9-450b-9161-241f05d3d82f@linaro.org>
Date: Thu, 15 May 2025 11:11:56 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] dt-bindings: timer: Add Sophgo SG2044 ACLINT timer
To: Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto
 <inochiama@gmail.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, ghost
 <2990955050@qq.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 Jisheng Zhang <jszhang@kernel.org>, Chao Wei <chao.wei@sophgo.com>,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-mmc@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
 Longbin Li <looong.bin@gmail.com>
References: <20250407010616.749833-1-inochiama@gmail.com>
 <20250407010616.749833-2-inochiama@gmail.com>
 <aCSmNRTVXQ51xj0m@mai.linaro.org>
 <MA0P287MB2262A447A98778BF4BC3DB2BFE90A@MA0P287MB2262.INDP287.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <MA0P287MB2262A447A98778BF4BC3DB2BFE90A@MA0P287MB2262.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/15/25 02:03, Chen Wang wrote:
> Hi, Daniel,
> 
> Just a kindly reminder. There is a v2 of this patcheset [1], and I see 
> [1/9] of v2 has been picked by Andi [2].
> 
> Please double check if anything wrong or conflicted.

Thanks for the heads up

I think it is ok, I have the right version in my tree.

If you want to double check, it is here:

https://git.linaro.org/plugins/gitiles/people/daniel.lezcano/linux/+/refs/heads/timers/drivers/next


> Link: https://lore.kernel.org/linux-riscv/20250413223507.46480-1- 
> inochiama@gmail.com/ [1]
> 
> Link: https://lore.kernel.org/linux-riscv/ 
> egkwz23tyr3psl3eaqhzdhmvxlufem5vqdlwvl4y6henyeazuz@ch3oflv4ekw7/ [2]
> 
> 
> On 2025/5/14 22:18, Daniel Lezcano wrote:
>> On Mon, Apr 07, 2025 at 09:06:06AM +0800, Inochi Amaoto wrote:
>>> Like SG2042, SG2044 implements an enhanced ACLINT, so add necessary
>>> compatible string for SG2044 SoC.
>>>
>>> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
>>> ---
>> Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
