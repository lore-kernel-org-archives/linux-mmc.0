Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDAD5F567
	for <linux-mmc@vger.kernel.org>; Sat, 10 Feb 2024 19:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707593921; cv=none; b=sTQJyeKA02J8w5xpxG3ZCij4mwPbxiBmAYHw8+1hZCDBimB/DmDY9MnQQ/ILlPtmr1frTQIcUT6V7GxdF7BKRipoHOfCd62ltc+u8bQSThHEPjZS7CjaeNPruRwiQEoLpmCCFIg+FH05pqRvxiaYqhzSnhCpvG5x8Qmk1ikqAU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707593921; c=relaxed/simple;
	bh=iQGav6Iaw9dZL+breAfuJsbdBBeXtSO2cp14+fT+agM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CoTOOQlvsVeFwA5MAB3gHNfrJaNxrHPqnUQYbFdHuH7bhPucNWJ34XXOAGLjBhAdMr5xUBVmDdVCheDA7IrAKwLL0qgU47e2bAUuJT2HsExhQcSqAOFiQqhsZQo0tOIZGyHuN/VQwYPhSAmnGDB3+P71/1/8gljJ3hxBtf//8RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TKuIi5Ll; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TKuIi5Ll"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-604819d544cso20632517b3.1
        for <linux-mmc@vger.kernel.org>; Sat, 10 Feb 2024 11:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707593919; x=1708198719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQGav6Iaw9dZL+breAfuJsbdBBeXtSO2cp14+fT+agM=;
        b=TKuIi5LlC1MTkdIWUg05KZubPATDs/vIrwxeNMeP6ZmsU6E+grHiePfUPr/Q1vnoR7
         924cBbF1u0BmcVoK4cYYTpc1FdGuV6imhQ6/tEPjICAu5dHEuQK8ql+wShf6fyxwWhO2
         AmJ/4astLEtK0Q6304WB2pXipx9p70HmxZxiKYubgsgYmx16nKq9fysDlSKDjgZQh4Jt
         CwUYTyA3LtS3TiC6q615GyV1Lw8VUGsLwo4n0kOnT+t3BEmIKpOhOBk7d3dfJoE5c7Xu
         8jB1GoLsnjJbO2I2CIM6kH+/haC4GaYwF+TEWVMC48Vuk1SmsZpnx2p0TCfKS5jkeaIw
         uFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707593919; x=1708198719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQGav6Iaw9dZL+breAfuJsbdBBeXtSO2cp14+fT+agM=;
        b=REQ1RHe6yAbv8fsyMWWlE7IE3HqHiy76bslcHculwS2Fe16oZDd6V79HCaJ9EA6i0p
         ckO7kM+sgwrE+9DLfkFYzRv2bPOH/Xv7KHCwvOGcKjhxlW2N7kr8KukOO9AxYfqrEgMO
         ihakCBDpkFjp4tp/ewHTOzC35+9sg6Wn1bP2ZpENhS4lCA0kI1z+ty+Bf3AJXBidaEL4
         9o1K2ISPi5XsPqsxxhPEsUmWTAp9N+xMnNf/zs15Q8bjuvUxHCsnpxWf8NFL8u+SnAYh
         3DSb0ICciB17n57qA80hawGyGZtFYgIg8oLKJcYjh0HEKKd0G3MHdsL7x1b/lz6L4BVk
         M0dQ==
X-Gm-Message-State: AOJu0YzkUBfpgX+Bx40avVp55rw3Cn/9EchwNCpcdnp9rToNWog82iwe
	D27Tj/8bYD73dm6clZYDuvjrV3/l9UGG2G9JGW/rXLIOdBv1Crv6zU8d+Q/WNEj5uYS0/hksq0v
	lcm8VkQgmZFwyVRXavFquXXFLY783lZimUZa9yQ==
X-Google-Smtp-Source: AGHT+IHQoqM+Ez0vwI0AVPIhNfj0ZyMahw8je8adZerNoLLmS48CzI3weQoop/efGwuIi89+sDPbS9ZYs4Lz4MndOBE=
X-Received: by 2002:a25:d653:0:b0:dc7:30e8:f232 with SMTP id
 n80-20020a25d653000000b00dc730e8f232mr2580780ybg.18.1707593919188; Sat, 10
 Feb 2024 11:38:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125-mmc-no-blk-bounce-high-v1-1-d0f92a30e085@linaro.org>
 <8ca6a46e-551a-4400-965f-f4ad60bff072@app.fastmail.com> <Zcaooa0bTKo3OdvV@qmqm.qmqm.pl>
 <CACRpkdb=aDd+CuJhckE9xZjA4MXRS_BD=qd3sc3Qjnm7CNbATA@mail.gmail.com> <87e339bf-6ca9-406a-9f15-d744f90c9c40@app.fastmail.com>
In-Reply-To: <87e339bf-6ca9-406a-9f15-d744f90c9c40@app.fastmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 10 Feb 2024 20:38:27 +0100
Message-ID: <CACRpkdYtUFAWweawpJquz2BUT81Ako0cZnKgZeyj8Jj93ru8fA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core Drop BLK_BOUNCE_HIGH
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>, 
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 12:58=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrot=
e:
> On Sat, Feb 10, 2024, at 00:41, Linus Walleij wrote:

> > The only difference is where the CPU have to read/write the
> > buffers really, before the change those were all guaranteed to
> > be in lowmem (bounced there by the block core), now they can
> > also be in highmem, but sg_miter will deal with it for sure.
>
> Yes, that was my point: The sg_miter() code is meant to
> handle exactly this case with highmem data, but as far
> as I can tell, that code path has never been tested on
> 32-bit systems with highmem but without BLK_BOUNCE_HIGH.

It's actually possible to enforce testing of highmem scatterlists
to an MMC card (one need to be careful as this is destructive
testing!)
drivers/mmc/core/mmc_test.c

...but the one relevant target I have is a Kirkwood and it only
has 128 MB of memory so highmem won't be exercised.

I'll put this into the cover letter on the other series (fixing a bunch
of drivers to use sg_miter) though.

Yours,
Linus Walleij
