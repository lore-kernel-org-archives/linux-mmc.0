Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C19C2E2845
	for <linux-mmc@vger.kernel.org>; Tue,  7 Oct 2025 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855240; cv=none; b=IDlKLN+0HK0UXN8SJXapbSk+zvZItxZ4ypIVTvy3NI6qzu1Csjlb21MVFRBbb28MIZ1Eo5D7yQcrnDXEqCnLR/CIO8hRDmv4Z6nveWDTCuX7/2kyKGM0KAWbgTHu5r7O1cPT16Ecvu2pq8b6FAfjSmQdGa1G+qcb0JFSb0I+XLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855240; c=relaxed/simple;
	bh=hFXYR4fcmLBIVGVw+InBgwA3ZnSYHsqcnzS4vlOpQQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4x8KVZlTcq59KUq3/NhEK730PmlSpFIJWkAaXZR6OcZ4lmwgIPaVCLdSLlJwlNHw1yIL8wO5bhHG4/Gq3KosdY17gynWnoNLSnmXzWuYw+r5tpgRDYRljFud9U5lkpQJzekdptKPv0nUPBUhbbdx0ExZywra+uzo7oClO2itEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jcdm3lF9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jcdm3lF9"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e34052bb7so70944055e9.2
        for <linux-mmc@vger.kernel.org>; Tue, 07 Oct 2025 09:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759855237; x=1760460037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4T6AAskuAQMA+z0rbuJKIDBvXK6M4cVmAuCtckIwoTw=;
        b=Jcdm3lF9cp8hdxyA1TwTCKeOt1k7pIzDXoX0hqrHYLxKeb3AfnRRFLXutukwxM1zlI
         Jey0VeGuBo/ok6OKMEKzifL9VZlC2ARHb44yKW3yQp9Fbr/MZh6SimXBWy+CVKB5WMav
         EgGxVK27zpI61WY6MvWJoaiExBXw6QS8BUNn+hZIlPy/rpEo0B9KfHEMx9WKcrsJ4RGN
         DIdErZODu4/EUrOXxHui2sqQYEMwsc8qRA2xtEHPT8G4yFIMtrGKgtqQxOlnhJq2O9UN
         7sHDYTB3i2Os+S3Kb2meK1s0wDMgtZ0QyFRGAOTGTwg/BBkaGs1uwNaat8588vxOxiCk
         moBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759855237; x=1760460037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4T6AAskuAQMA+z0rbuJKIDBvXK6M4cVmAuCtckIwoTw=;
        b=nyF26LRPEFBoLTIzi1laXIV5b9HHIMyn949RQmjfDJ7/lGAbeZDhT2Rr4HqMOV2Q6+
         RRXKgNNM6bViFsiDZBYuEJo5Fzt8MZtWN0XTvBzgxHRFrCgqQBq6BwcAggAs6TTRL6Ol
         7OGeQnV2bEChqrMjc8g4lk6MA7UVnhSyG4dMRWsMnvpNU3yFw8Dx+C54DLWV7UChu2TC
         X4G/00YPt3w4c+b0N0Zm/spwKMT1mvC+t56Hrxf8p2Bek69xJnEVxio1kXaJNceh/Fcw
         0nRK5c0eZFb2xkLUto/DafS3dM6/USggtzG9nQ1ndwn59jGVtl9/VHhbCUQWj/4nUrCw
         PIUA==
X-Forwarded-Encrypted: i=1; AJvYcCUppVVcM/1zgjZ8I4uGWDdCRz6s1tYybSih0zU0FLTbyMU8jqkENXA/WTMSQJJCxEYzGzgDJR6ZoS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfZaxEZzhngS2TswaKYX4LtcMQ8oLSW/K+B5szRtBVptHGOlYf
	14D4fCit/Yr7U0+YPUUZKhyvOS+t8q8z//AQ32f0mn1loXffDKfDhfFHDrI7HuKyyMU=
X-Gm-Gg: ASbGncvyRVIE/dwgPsq96tIVP+/ncs6YQtRzy85vLz99zUih1QgbJMgKo2QXb9JhxFz
	krgfAkMHMohoUuom6UQo2SYgXNxWej6Av/f2J/PKoolB5hR7RQF7kpaFWTQQ9fd0QTnu2EkoA2j
	gqMnU/RcY4H0qsdcT3gnFTQJtjo9Y2j8UF8Ru6SBKsKuryDfjGZsnY1YnOM0DDbMdqSSE8X/Zwz
	62NBPbOeEo5Ew/nDGtwnt4sqNb5SNx/e4pVGhZFrvjZeE7U4wrivNH7UtpiFLphSSMusHNT5aSl
	UetrXAmAWZw6510d389ytJQ6CkQoCknTue0V7gN/1VTpY6du5M+7XZgI3gCFnLC2ZngGjXqh3Td
	w7Fxq1NSl1FemacaQPY4eDZZeHNubal06tFz7/PEhJd3wOcD2ahutNyC5
X-Google-Smtp-Source: AGHT+IGlCEBhLy99r0MwbwBabTf5K5u09aQHi1qXsVdU6U8kDvKm7mhQZ0t1bgVq0uYvoequQknBLg==
X-Received: by 2002:a05:600c:528b:b0:46e:5cb5:8ca5 with SMTP id 5b1f17b1804b1-46fa9b164edmr2084845e9.35.1759855237338;
        Tue, 07 Oct 2025 09:40:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4255d8f0170sm26956211f8f.49.2025.10.07.09.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:40:37 -0700 (PDT)
Date: Tue, 7 Oct 2025 19:40:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: ulf.hansson@linaro.org, zhoubinbin@loongson.cn,
	u.kleine-koenig@baylibre.com, chenhuacai@kernel.org,
	david.hunter.linux@gmail.com, skhan@linuxfoundation.org,
	khalid@kernel.org, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mmc: pxamci: Fix passing NULL to PTR_ERR() in
 pxamci_probe()
Message-ID: <aOVCgXnHDnErCLnu@stanley.mountain>
References: <20251007161948.12442-1-rakuram.e96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007161948.12442-1-rakuram.e96@gmail.com>

On Tue, Oct 07, 2025 at 09:47:44PM +0530, Rakuram Eswaran wrote:
> Smatch reported:
> drivers/mmc/host/pxamci.c:709 pxamci_probe() warn: passing zero to 'PTR_ERR'
> 
> Case 1:
> When dma_request_chan() fails, host->dma_chan_rx is an ERR_PTR(),
> but it is reset to NULL before using PTR_ERR(), resulting in PTR_ERR(0).
> This mistakenly returns 0 instead of the real error code.
> 
> Case 2:
> When devm_clk_get() fails, host->clk is an ERR_PTR() resulting in the similar
> issue like case 1. 
> 
> Store the error code before nullifying the pointers in both the cases.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202510041841.pRlunIfl-lkp@intel.com/
> Fixes: 58c40f3faf742c ("mmc: pxamci: Use devm_mmc_alloc_host() helper")
> Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
> ---

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

