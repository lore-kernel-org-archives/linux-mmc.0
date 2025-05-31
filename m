Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8836290F
	for <linux-mmc@vger.kernel.org>; Sat, 31 May 2025 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748712576; cv=none; b=aFKlfFjzTYCM122cYLI533mfuFmQuJS9fvVKvNyaU7rSX4j42aWXIocC6JIaqQz5W0aRcL8D7BB4gcAqvzmpe+qsdVJjQKVmknor9PxPdj8tRJ5QZcH3U03FMkeAbXcPKWEmFL568D0sU4dc9torNJoprSb+oWqsggyftUlPgiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748712576; c=relaxed/simple;
	bh=UUNtP6LwoCuz5HXfWYm9MBf+asOb5oWz3cepwFKSQsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8p1DVzpDJ0hRUZ/ACGMjs7/5zvJF/1Nlw+v8zX7XQqE0nuWxRcYIXS+FD1RLQxwQqhEx3fsPOje3EVboUTaGy2NQsAVdczLyOD0Z+xjvlN2Hi1AI73sOX3LC4VMJr945kH1tAs+Qu+AK6eHLsYzVuSVpIQCYpQoBPrDSDRR8Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDakbI1L; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDakbI1L"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4774ce422easo27855321cf.1
        for <linux-mmc@vger.kernel.org>; Sat, 31 May 2025 10:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748712573; x=1749317373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bh6Fqy3DEuz19EYVB+xYrjrScoXgfLliJq2xrL+RgTA=;
        b=cDakbI1LM0lm4i6RF7p5CVIPrB0wOfBwYpSTmu3srLPlaAhMyPVvwunv5Pv5PYqFoB
         ItHShDFvPRjltBcd4Czil5pLat/VOn+gs4tGpRUFkEzeXBx/jRH+4D6P2Be/dyeudebl
         ylQKAoCvq3BoSeKJFzWxj/w3PLo9+Cy5ewactRfDH2QwEzFeepYgqDxivanV8Tog9ttj
         XQTrr7JZ0Qd90UK0K7skpde9iiR62ykBizYK732HXczrKRNfBfP0m2ma8UhXSor14QCm
         NgqkwuKv91gKaa8QNFV+lS2z8MkGu0EEom/iRVR/1nzp4VYjngYKUwbnOzO8GJKiHTOG
         Q/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748712573; x=1749317373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bh6Fqy3DEuz19EYVB+xYrjrScoXgfLliJq2xrL+RgTA=;
        b=ufK/pBoyqkRmsLzbmXZdf5OSO0mi6EeTrJx3M2agJzlkHSPGgG3nBiZrPn/eLhHphv
         8C0Z8JmX7kQGgLxJCZAKA0xrY9oXPQjzoUsaqUvs9gwPJMJYCy314Kpm4VoSItcyLICO
         7KL3JLMItmSO/8brAApCtJCwJG6iQDhtbTGdWA1YZWeq16hdd7VToHPhliAg/ijA/j3Z
         GysNzXUJIioNyB+bWu58QaxNWT6i2H2BaGdWZHQmL68uVZhiTKmZauBDBgkELCvnU2nc
         G4oE8dp/2xn+y7YbK9+90od7G/wZyKLbLUtUfW+dmREcqXqfHl60GYvuV88HcAhrB03W
         w0IA==
X-Forwarded-Encrypted: i=1; AJvYcCUVZsL1Fn5TcWmNtOdgkaskF0MHbi3U0MvyG1jchbaOTI6h1WQ6KtyBJlJaInKHtGfVJbDFZ83UaO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwMwlCGTtihEZNAqV91QzQLllMDvz2FJgoTBW/0Hy/CxezxzUz
	jrL6gjH4Be+Fp7Oowl0e0m1LtFnMuumQQndAd1ohX4xJMvY4jFLYz5E2
X-Gm-Gg: ASbGncuYW9EAzhz9IkgzK5wKSeBshJvkrZPiBLNd0Q9NROLB+I0rln7zJT/vG8F56F6
	5UxEJPH3r9NuIaOYttiIDrXaSvFzJwuLGxuTYb58QX7qq4PhoUKY2FOrpTH1jc6ghALN/QKvygh
	0KIY2c9I8UpjX4czFSIiFFrPfE9Sb35sTuCMvL/SvzP7GSlDs7sTcdW+JFWQRjrRW3hwVh0b1Ov
	9GXWK9cObla3fbl7KTQ+n+HpzznCu6TQhjJ7J2fpqVERwffkLHnL9HeOZHGkEcWEcHkxKM1VYdk
	YHiT3ADGuVY0FMSyf9zarnSaY/rnMate3f93IBUKfmiLsaRtgTWBIw==
X-Google-Smtp-Source: AGHT+IEyWlL9WVdtR+EBo38GvlQBeO8ieOCYz8didkITWjpfxXr85y+q9pZLRtd3r1S76rTVBKm+bw==
X-Received: by 2002:a05:622a:5513:b0:4a4:3086:2ac6 with SMTP id d75a77b69052e-4a444040462mr105851901cf.52.1748712573449;
        Sat, 31 May 2025 10:29:33 -0700 (PDT)
Received: from errol.ini.cmu.edu ([71.182.183.26])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a435a371bcsm34677311cf.52.2025.05.31.10.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 10:29:32 -0700 (PDT)
Date: Sat, 31 May 2025 13:29:31 -0400
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>, linux-mmc@vger.kernel.org,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v2 10/36] mmc: litex_mmc: Use devm_mmc_alloc_host() helper
Message-ID: <aDs8ewbIR0YUepkV@errol.ini.cmu.edu>
References: <cover.1747877175.git.zhoubinbin@loongson.cn>
 <692dc1743391fc4b3c107db5211107b5041ff100.1747877176.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <692dc1743391fc4b3c107db5211107b5041ff100.1747877176.git.zhoubinbin@loongson.cn>
X-Clacks-Overhead: GNU Terry Pratchett

On Thu, May 22, 2025 at 02:59:51PM +0800, Binbin Zhou wrote:
> Use new function devm_mmc_alloc_host() to simplify the code.
> 
> Cc: Karol Gugala <kgugala@antmicro.com>
> Cc: Mateusz Holenko <mholenko@antmicro.com>
> Cc: Gabriel Somlo <gsomlo@gmail.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

Acked-by: Gabriel Somlo <gsomlo@gmail.com>

Thanks,
--Gabriel

> ---
>  drivers/mmc/host/litex_mmc.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
> index b338ccfa8f33..d2f19c2dc673 100644
> --- a/drivers/mmc/host/litex_mmc.c
> +++ b/drivers/mmc/host/litex_mmc.c
> @@ -506,11 +506,6 @@ static int litex_mmc_irq_init(struct platform_device *pdev,
>  	return 0;
>  }
>  
> -static void litex_mmc_free_host_wrapper(void *mmc)
> -{
> -	mmc_free_host(mmc);
> -}
> -
>  static int litex_mmc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -525,15 +520,10 @@ static int litex_mmc_probe(struct platform_device *pdev)
>  	 * If for some reason we need to modify max_blk_count, we must also
>  	 * re-calculate `max_[req,seg]_size = max_blk_size * max_blk_count;`
>  	 */
> -	mmc = mmc_alloc_host(sizeof(struct litex_mmc_host), dev);
> +	mmc = devm_mmc_alloc_host(dev, sizeof(*host));
>  	if (!mmc)
>  		return -ENOMEM;
>  
> -	ret = devm_add_action_or_reset(dev, litex_mmc_free_host_wrapper, mmc);
> -	if (ret)
> -		return dev_err_probe(dev, ret,
> -				     "Can't register mmc_free_host action\n");
> -
>  	host = mmc_priv(mmc);
>  	host->mmc = mmc;
>  
> -- 
> 2.47.1
> 
