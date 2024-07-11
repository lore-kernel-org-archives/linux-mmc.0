Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7B216B392
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jul 2024 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713875; cv=none; b=GExxEY5wnHW5P+yMcf8MRzitUBpI8rbsIiIxK25QiO7lPGB/lI9Vnqao9NVaw+5drbmNPLfeN6QpBYFAjUOjF4NsmDWyOjuwS5HwzvKWgKhwKuani0zVc0/gOhIZXiIGoyVRG/aEoHkV5uUh4LI22rgGjomAmaUbTAUZaSY+naM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713875; c=relaxed/simple;
	bh=JN0trlP766WEZdls3ZfrLFEbLpeb1fJVilnmCRw2Q2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QKIcnTSQNGPqZnRpvuehVxQ7xdqeIIL1+N9lLWl6xLaN+UxM1aarhf+9INWUsE2xqKY7WEKOge4xdWf/KYmSnHwqXQ+tUpwrOcUnUu58sUebg2/DRHoY3vDWz+G5G5KMmXP8WSZQsDCbWccuccKjGSBSF8n+yNJHvZrI2gbiyo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u35+ZoL+; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u35+ZoL+"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e02c4983bfaso1108239276.2
        for <linux-mmc@vger.kernel.org>; Thu, 11 Jul 2024 09:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720713872; x=1721318672; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+mks0bJDjvIL34Wgw7hHRxQob5sxOUhql0chG47gLhs=;
        b=u35+ZoL+qcJvyztNrECIrrib1BJ63zmBUbhKYxsdhdIwU6/SI2dHJM7LQzf/MOQqPO
         uaJU05BCbAO0WMJOUJl+pZqev9kHrY6/Opo6Ms09M1Ttlh5ovmnO/UAQDmXaOj0OYBRZ
         eJ1EKRfPtfeEgV/eRGXXGk+htueRah+cw6lzJAJyHm1BKThnfT2QusN1eCJ/JLFG81rW
         kNmixmwa3kySTNb58gYbs70bedBSXxIMD16+91Ds8aRmFdQn97wdWPgO64Oaq9JGVG0k
         X1FALoCE8sglGk4Qmfcvbj6vqY3wkO8rJ241Gc3f4JeMGlVrX2v2kdGJDUxY1CseNcly
         ctpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720713872; x=1721318672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+mks0bJDjvIL34Wgw7hHRxQob5sxOUhql0chG47gLhs=;
        b=Awu5aetudzHDdM4u1gckotfPUYgjOdFBPwjwmyJGksC1TMIMCOALwi4C5U+jHpe5c7
         7MBNBdYlZD2PiWhi0tsEwVTXNGk0GFhplp+skiFRpmzI/RtVGM6eZqNMWEKR2tXt+mrz
         vgwkO9yDXGrZEQzgPFvXOyM2UKZ6iBoKwlGOC9hZOYKkUCY1EQTtILYUL0eqXsWfvXYX
         A1umgm0R/QPXcpxOa2zwkVeE9VqA1LyGn9xfkGiit01Ae8Op82sY4Zc0weKbnM4dYgly
         z2PipQ8h+VhJacxsmskIVrp1yhqIaSO2X+/zy1QSjFxgJzFR5y9OWpwfSSlRtg/JYWgn
         M0iQ==
X-Forwarded-Encrypted: i=1; AJvYcCU37ytCGxqe7DUdOIT7p6YJAcBqm2InoPWHiwgl0OlKH31Nkpo7lsAENp60nHFluYHxKg5sZM3Ayg13Z0MkLuYSVkNRSy3SbXza
X-Gm-Message-State: AOJu0YwRYs6pGCGgYMolPSQTfy32sCDlYyJJTv1rV7SEdf6gIPgS1d+h
	sawbNIPiSy0Z6qE+cKJL9WVZQEsBnxvNegr8HA70oF0kMzgKS9p1ue3A+h6g4VFJ1pFXXyIShzs
	z9M7RuKK9QlRjUn7N00eQoHNzf4rFFILYXGOlmA==
X-Google-Smtp-Source: AGHT+IFqfr9pGDx97Qhb9UZYCfCPZgj6q/n3b0f4iTguJUMJdoEYSvcQaQUQPH9HZJ+bT5dORqmDD/njlPQebLu3wJo=
X-Received: by 2002:a25:b2a1:0:b0:e02:8ab0:c940 with SMTP id
 3f1490d57ef6-e041b1e9795mr9744263276.47.1720713872069; Thu, 11 Jul 2024
 09:04:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710180737.142504-1-adrian.hunter@intel.com>
In-Reply-To: <20240710180737.142504-1-adrian.hunter@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Jul 2024 18:03:56 +0200
Message-ID: <CAPDyKFouDL9AQ+mpp-f4OPJ=jXJnXuRwLUHbtN67h0_xcHxWWA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Fix max_seg_size for 64KiB PAGE_SIZE
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jul 2024 at 20:09, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> blk_queue_max_segment_size() ensured:
>
>         if (max_size < PAGE_SIZE)
>                 max_size = PAGE_SIZE;
>
> whereas:
>
> blk_validate_limits() makes it an error:
>
>         if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
>                 return -EINVAL;
>
> The change from one to the other, exposed sdhci which was setting maximum
> segment size too low in some circumstances.
>
> Fix the maximum segment size when it is too low.
>
> Fixes: 616f87661792 ("mmc: pass queue_limits to blk_mq_alloc_disk")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for fixes, thanks!

If we want to log a message due to the wrong max_seg_size, let's do
that from a patch on top.

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a20df9383b20..4b91c9e96635 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -4708,6 +4708,21 @@ int sdhci_setup_host(struct sdhci_host *host)
>                 if (host->quirks & SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC) {
>                         host->max_adma = 65532; /* 32-bit alignment */
>                         mmc->max_seg_size = 65535;
> +                       /*
> +                        * sdhci_adma_table_pre() expects to define 1 DMA
> +                        * descriptor per segment, so the maximum segment size
> +                        * is set accordingly. SDHCI allows up to 64KiB per DMA
> +                        * descriptor (16-bit field), but some controllers do
> +                        * not support "zero means 65536" reducing the maximum
> +                        * for them to 65535. That is a problem if PAGE_SIZE is
> +                        * 64KiB because the block layer does not support
> +                        * max_seg_size < PAGE_SIZE, however
> +                        * sdhci_adma_table_pre() has a workaround to handle
> +                        * that case, and split the descriptor. Refer also
> +                        * comment in sdhci_adma_table_pre().
> +                        */
> +                       if (mmc->max_seg_size < PAGE_SIZE)
> +                               mmc->max_seg_size = PAGE_SIZE;
>                 } else {
>                         mmc->max_seg_size = 65536;
>                 }
> --
> 2.34.1
>
