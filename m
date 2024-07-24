Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C215A13AD23
	for <linux-mmc@vger.kernel.org>; Wed, 24 Jul 2024 21:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721855379; cv=none; b=HppCwk4csU6pTdAmRLJFmN9UXTEWCMAdtQzOk9lxTzrPOMOZGp23fR4wvFvCXJWbhX+6633t1pkDkqvHmgd/4BsRbmVkQ9vKayl5qEWWDhEQ7r9H8qCgN0NvReis8ttG0LzNg9wJkFtHOMU9bM/qT9PebS7usWiR6SeoLYyzbuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721855379; c=relaxed/simple;
	bh=uxLT9f9IqbyPnZuQ+zIPpBsbmcvHuBGoUjbzjkQd7MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfPXEzDjJxlJ+MTmIDI0aGkzQ6k+xqWH2Du4gE9WO220+DF3AyfZun4uyscoF+rcJC0v92u4l2sQt+iYiSavNdwUGQVSM3pB4P+1X+0f6lx3WNtY14zoLkPlE45j7zFLjIYLaoL2QpnOPeGYXejNf8DXcvKfnZDyD+F1oeLZ+hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=uci4zWRU; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="uci4zWRU"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7a103ac7be3so164927a12.3
        for <linux-mmc@vger.kernel.org>; Wed, 24 Jul 2024 14:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1721855377; x=1722460177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JW5RrNNJxqjwuGLo9kHT95SO/33HKB3UwhgKtE5uUyM=;
        b=uci4zWRUJHPci5CRF9ySjTerFEOcxDfVw9V/YWr9KvfI9wngJRe5S03o3FlFagZJg8
         tvjsDjhEeOVY2uQhBHi4cDJUJjQQFH8Zlkpj3jBn72E77Z4ZfgSmE/JYgXiTZIvkIPKp
         Wb0+bkm7zWjeba8hm5xE2KDFy04r8TXTSgjs2x9c6dy+T0PzUIs6KbO/iFAyTBGkZSCG
         l5q1mZi7ND4MQ/S1D9pLx9iLXMXKnCkoMkVyCQxdoywZP90F2xBUgGXFFsSrb4ApnF2f
         cEDJAt0RKfUTE8o3/sCZOPkqycUpsayALvBvb1c5g8aTt9LE4nJQAq2I4Dj1apGDd29s
         C7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721855377; x=1722460177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JW5RrNNJxqjwuGLo9kHT95SO/33HKB3UwhgKtE5uUyM=;
        b=gdA3JN1S8KtZohBcSFtut0EzrSFOcnnXJrViTeNRFToOGmq4Itod6UbeNsNt4SnDNO
         VbZgh4jKFWzR/QxkrDBgBG4lCra9IFmVqLiEvM4RWO/6WhUdNLR85aQCZTSx/+1y1kI1
         FMS5QNGLeLvHp3lEsvVQOD+SsCUUuCRhEAsYdxMTzKDT2KRMUIO8DhSkPtdjbzT5gEbi
         jxXJVAW86LqvFX8OeZ8eDx+eioLgGUVBUGm2jdEnmtZyrTt7Np7gucl1q0ALAmnrh7HX
         atojXgYQlzAjguN2vFgOKnLtsJn1xnPIGGJGKDSKSle1JSlRDKehNJwlZLYnobi2DoLu
         6mgw==
X-Forwarded-Encrypted: i=1; AJvYcCVVbSBCjr2FmqFXQ4euyOowFWyjRp/sdmTI9rQS+lY1bAnghBnZ79SEeiOeRE7/lv9QSLCBloI4Cy0onmbwETz6Ff4warBhGGK/
X-Gm-Message-State: AOJu0YyPP4c9c7ZrEDUttW9u+kBXA3uhcNaG6/IrxFw5bEWV5dHtYsNP
	H/aIgsmaRIctSKHpT8GDVSVi+zeBD2ItP3Vofc4BopvuI6g09d6iFSmqbi20L/vk0IfykFtlaGj
	8Jpw=
X-Google-Smtp-Source: AGHT+IGELhs314KqDpmVaOF4YhHiDvPSIICIdBh1kBNNnVk36MClFKGOKcaWxOApghMkCWpIwy05HA==
X-Received: by 2002:a05:6a21:3396:b0:1c3:b267:4261 with SMTP id adf61e73a8af0-1c472830996mr1583265637.12.1721855376943;
        Wed, 24 Jul 2024 14:09:36 -0700 (PDT)
Received: from x1 ([2601:1c2:1802:170:8821:4dd1:578:cc09])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb738bb33sm2164778a91.4.2024.07.24.14.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 14:09:36 -0700 (PDT)
Date: Wed, 24 Jul 2024 14:09:34 -0700
From: Drew Fustini <drew@pdp7.com>
To: Chen Wang <unicornxw@gmail.com>
Cc: adrian.hunter@intel.com, aou@eecs.berkeley.edu, conor+dt@kernel.org,
	guoren@kernel.org, inochiama@outlook.com, jszhang@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
	paul.walmsley@sifive.com, robh@kernel.org, ulf.hansson@linaro.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com, haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com, tingzhu.wang@sophgo.com,
	Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH v5 0/8] mmc: sdhci-of-dwcmshc: Add Sophgo SG2042 support
Message-ID: <ZqFtjpxXv7pRpZHV@x1>
References: <cover.1721377374.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721377374.git.unicorn_wang@outlook.com>

On Fri, Jul 19, 2024 at 04:44:38PM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> This patchset is composed of two parts:
> - one is the improvement of the sdhci-of-dwcmshc framework,
> - the other is the support for sg2042 based on the improvement of the
>   framework.
> The reason for merging the two parts into one patchset is mainly to
> facilitate review, especially to facilitate viewing why we need to
> improve the framework and what benefits it will bring to us.
> 
> When I tried to add a new soc(SG2042) to sdhci-of-dwcmshc, I found
> that the existing driver code could be optimized to facilitate expansion
> for the new soc. Patch 1 ~ Patch 5 is for this.
> 
> Patch 6 ~ 7 are adding support for the mmc controller for Sophgo SG2042.
> Adding corresponding new compatible strings, and implement
> custom callbacks for SG2042 based on new framework.
> 
> Patch 8 is the change for DTS.
> 
> By the way, although I believe this patch only optimizes the framework
> of the code and does not change the specific logic, simple verification
> is certainly better. Since I don't have rk35xx/th1520 related hardware,
> it would be greatly appreciated if someone could help verify it.
> Note, the DTS change has dependency on clock changes for SG2042, which
> has not been merged in master/upstream, so if you want to test this
> new sdhci-of-dwcmshc driver for other hardware except SG2042, don't
> pick patch 8.

I have tested this on the LicheePi 4a and found no issues.

Tested-by: Drew Fustini <drew@pdp7.com> # TH1520

-Drew
