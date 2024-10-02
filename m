Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E587A19F464
	for <linux-mmc@vger.kernel.org>; Wed,  2 Oct 2024 23:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912215; cv=none; b=LY6TjDzPhLPJdDsel683V3hAJrn123btWQVjhKyd3M+d8cDCPc21pFeA4UNKh/6kmiqnVhzWb3/aPK3VG3hcBdY6HNzfmQk/HDgbPNpgnZraOSc7G4DGvozKmhC/7/c/kJYxxuNXKIYQpn20P8Bhy4AgWPInl4p+IHD0N71UlHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912215; c=relaxed/simple;
	bh=S0EHAmn7sJ7Y8qtHbi0S1W/nuxkxgSWXJhHOgzuX/os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ad+Z9pfv0Sjim3v1k2qgcnvAblK/+XqYFHwv5OUgwPU7uXwMQGkp00qD04VX+/pslJEeOo+qg/b3v3vOkXncN6ZB85GPeTGLRN2JEQU5NHEytkJH86Meh6CbllrhNU3Pe2DPMkoHvI9dOADtr5ygOriJ/VXf3uA/WMPE+N81rwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L1fj+9z1; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1fj+9z1"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e26290a13d5so331451276.1
        for <linux-mmc@vger.kernel.org>; Wed, 02 Oct 2024 16:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727912213; x=1728517013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nY/F4CTExAOuUkjf0nz7rLS5b9eUxUi19ZbRKHEJLRc=;
        b=L1fj+9z1yiNOu7feHKiRnXLd6ZnJwjVYAzyj9D7PFmY8rjcOe2l6+JokcdBmx6Np9u
         HUiw6kBedH5wpZ6cjNI2d2VR+N4hUs/kNJ3sg6NkBcg07FLn+bTxUUonQu5xk6cY+vxT
         hrCN9dGf154JUpw1/cl3G0NeDFbnyaOSpwZEP0AaFc90XI94+0SodTS5/fU5OG/G0eos
         VAEB6W4LOfxRJ5Pk7813oeI+4D2LtDVJINtMpzmMA/0feBXSiNwPD9tFEGPp40K502Z7
         0RAAFvJlqwl6gr/mX1rDCPYwXLVgj9yB/bilvwFOv7HinpCv0r5DbbgR/IHjom9EMdOn
         KF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727912213; x=1728517013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nY/F4CTExAOuUkjf0nz7rLS5b9eUxUi19ZbRKHEJLRc=;
        b=pRD6VdcbgDN5T3b4BlHrZmothg+jYvwVHMrcSBYJgJ0k1YSHRvKbKgamluyKYwYioi
         7sKJHyT7UoF7akbA4NLt2ZhiFBYCWyAKxzKe3J3j3wmsR+wzKSrUJE0e0u2XgzVld3QE
         jWoX+ZHvai5igCY5hXosp5PHBc5MoA8KgZJKcgDXE3edDy0S4YMSee2MO8vLM8I1wJpq
         CMASMQkiGtcn/tZW2qzBtgr9dJbrWo+BLHil3m8wQLCRmSFYYk91G9sAR41gsoSvaVv2
         1Mj7PH/H/z7cFS2jMg8jaQ+mWEar7UIJRxPiAMzkVuGD+4q8Uhu2OZ5P1v9h5Z4LzGdN
         4+0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLScfi5iMSrRmuycNdam4h7s2MYdf+B+OQdoIbZZodYdMNYPOIyhEp+5Fx/dJDmWpFkuWCIx6O3ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0YG6H6zWx/nXNxsHjw6CclgbDCOfIvozV/i03BNXlgV0XucKM
	cu6E9SHQAP0MtRHztTodvo7SZR8Ys9k7QDVzuxG5bSvRtoa1pDAzpaZ4cxInAnn3ttYdtn7T/L5
	Smdonuo1P0KzZ5TU/hccIf0A4eXKKxTTQLXZrmw==
X-Google-Smtp-Source: AGHT+IEqtBvDPMiSYGEm5TXVX8Sxz6COAlI/JwMlP602/bf3/owumvcuy4u17DBfBna1bb1pV8OpNWPenXFZIJKVLxg=
X-Received: by 2002:a05:6902:91f:b0:e26:365a:6488 with SMTP id
 3f1490d57ef6-e2638385296mr4616693276.12.1727912212845; Wed, 02 Oct 2024
 16:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924210123.2288529-1-linux@roeck-us.net>
In-Reply-To: <20240924210123.2288529-1-linux@roeck-us.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Oct 2024 01:36:17 +0200
Message-ID: <CAPDyKFqPPF7RAzmS2Lb69rb-T6T2WgNrwx8vcRLJ5WUZF2UOHA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Only set maximum DMA segment size if DMA is supported
To: Guenter Roeck <linux@roeck-us.net>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>, 
	Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Sept 2024 at 23:01, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Since upstream commit 334304ac2bac ("dma-mapping: don't return errors
> from dma_set_max_seg_size") calling dma_set_max_seg_size() on a device
> not supporting DMA results in a warning traceback. This is seen when
> booting the sifive_u machine from SD. The underlying SPI controller
> (sifive,spi0 compatible) explicitly sets dma_mask to NULL.
>
> Avoid the backtrace by only calling dma_set_max_seg_size() if DMA is
> supported.
>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/queue.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index d0b3ca8a11f0..4d6844261912 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -388,7 +388,8 @@ static struct gendisk *mmc_alloc_disk(struct mmc_queue *mq,
>
>         blk_queue_rq_timeout(mq->queue, 60 * HZ);
>
> -       dma_set_max_seg_size(mmc_dev(host), queue_max_segment_size(mq->queue));
> +       if (mmc_dev(host)->dma_parms)
> +               dma_set_max_seg_size(mmc_dev(host), queue_max_segment_size(mq->queue));
>
>         INIT_WORK(&mq->recovery_work, mmc_mq_recovery_handler);
>         INIT_WORK(&mq->complete_work, mmc_blk_mq_complete_work);
> --
> 2.45.2
>
