Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA70B27A10D
	for <linux-mmc@vger.kernel.org>; Mon, 28 Apr 2025 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745857321; cv=none; b=ZMPaGUV1Nj7rdPjIHcL1H8RWalKDfEcBvU5UfZnv1ZCQ2Ie6K6ZGb8CDvJaWfD98QwzexqFZIXr4EMkE9Zr00/tYc1DnljYhL5tMLOrYlqpNs/zQam+B6JK7AklikieMJXgNPPUHE5qxuyBCdYS6gLnfyqMmVBbSbcnNUfWCYcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745857321; c=relaxed/simple;
	bh=KI3uLgLFW84fzWp03LD3SbB/OJ/xdc09KEqlRVDDi0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPNaZQYIGbUfSNqPUdpD5lkDwgUs40EmqB+NDHT3CWEJc1jdA4WFW4mUW78bI8vMFs16EfdYWNtt9CfpQk0XL9Bg56mBtjBovirUr/1QDBSO1GGd524rB6YTuU3zsqaQ9qLhOi6nMjvxMumLUDKFWX/6AVm1118ij9mdWK4qxAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zadHl9Qt; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zadHl9Qt"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ff4faf858cso35048327b3.2
        for <linux-mmc@vger.kernel.org>; Mon, 28 Apr 2025 09:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745857319; x=1746462119; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hJGeBPRLcR0oAYZ212tMSFi3+j040Yo0nz0+Wv6VWzQ=;
        b=zadHl9QtUW1RHbj3DJsw+OLcDrTqEL/kxvQ/enSEXyZ2jj9Uc3ZPaRHfQV6xQY+jEy
         qTH89M2PmA0owTDk9VrKBlg3DPDECcbG5jcw7WaURqGr4NaiyAfedPn1RyUqus+EGqPa
         sNWSmwDq//0EsIO9sqT2QvzDbrxBhQ5I9ktcuIw9K56tYfDgW1QfIB3ZZLUQ+6rEjog0
         pcnQ36WPuKm2n+9tgGTEOW0dYGZE2kotlfkUihSfzRT0tnKs2uuvHlsZFa0qU9QAjChn
         GaRtQ/EyPIloRUA0h/LISp08Kk1UjZUYmEtPLXoLYzxnROuSXvyeCAyNjXppAQVl9aXd
         LUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745857319; x=1746462119;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJGeBPRLcR0oAYZ212tMSFi3+j040Yo0nz0+Wv6VWzQ=;
        b=FkYxi8Og/O3Y0Apzs63AK1U6si6X10j/a4Hx3RlaiF5P+yew0E/SrUgcg0koReIG61
         746ti5XBqyosFoDN9PlTaVFBUxWl0i1eVT89r63XTjNOXh03+M0TmUm1Jo89PPIlmZgb
         l/ly7E2/5oGYZUlWv6uBPUD2cntUeYSPYhF7Ut4+D2OHaB2eoUst2k9W6yUcC3DBOxet
         LCk9TtcN8AtOaxtXLC5dEpM/8MmdAx8SQ2JbYfqkDM0ZOVyHXBP+BHlq+GjY7tMO7Ife
         Pt8wMT+99nleMrvSO5n8YOFtduDcCC3kTCXS8L5taGQGhnEiiyETKSYs7eOQvgNILoZS
         1yBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmYYfsbl0mXM9TjPN4Be97+EVb4vR4u20LW5abKW+ceUCf2KFNEFMVPoXR9mig6gKMlKwiLa1u2eM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVNpqJqFYQNh0azRlQoNN5OqFXTxYaMw+JLOPXPBlNfn7DRxSA
	4bQWJxShwAmejEsgMALHEzA+PwgDjtLPY8tp0VLafmDKZpVxc4uqXKe9JEhgg9zPSX/xsMgrDjr
	YNvzOp3Y/HGa6Vy8uVkK/9WVUZSjTYsZgrHENkQ==
X-Gm-Gg: ASbGnctb29QAOsX7vkxgwxI5nG4HDkmv32OYAzjH3675dvm2Vl9yiR8Lfy5kIqzhtUo
	Vzf4zwTsYU/s9ycJOgYLc00KlX59bSa+hTRCOZNEtadxrOc4TdNR+9X4kcn7P71PzlB3rEB/Mz+
	NOfQWNYmeKnNBIDZFn8uKearY=
X-Google-Smtp-Source: AGHT+IGrYKDES4LMpa+mIh07UTJ/v15OFEjt1tsB1hzJ8ctTDSYnqO23pd9t9YW+plDGT6Der9b8aB1xif3WroZEeyw=
X-Received: by 2002:a05:690c:7242:b0:703:b313:5399 with SMTP id
 00721157ae682-70899689193mr5627207b3.18.1745857318743; Mon, 28 Apr 2025
 09:21:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417092742.27887-2-phasta@kernel.org>
In-Reply-To: <20250417092742.27887-2-phasta@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 28 Apr 2025 18:21:22 +0200
X-Gm-Features: ATxdqUH6ctnF_T3pbMUAIl5-FXRkQ-V8HfKImBkR__1m7RCHSwSsQLKqxOF0BNM
Message-ID: <CAPDyKFqqV2VEqi17UHmFE0b9Y+h5q2YaNfHTux8U=7DgF+svEw@mail.gmail.com>
Subject: Re: [PATCH] mmc: cavium-thunderx: Use non-hybrid PCI devres API
To: Philipp Stanner <phasta@kernel.org>
Cc: Robert Richter <rric@kernel.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Apr 2025 at 11:28, Philipp Stanner <phasta@kernel.org> wrote:
>
> cavium-thunderx enables its PCI device with pcim_enable_device(). This,
> implicitly, switches the function pci_request_regions() into managed
> mode, where it becomes a devres function.
>
> The PCI subsystem wants to remove this hybrid nature from its
> interfaces. To do so, users of the aforementioned combination of
> functions must be ported to non-hybrid functions.
>
> Moreover, since both functions are already managed in this driver, the
> calls to pci_release_regions() are unnecessary.
>
> Remove the calls to pci_release_regions().
>
> Replace the call to sometimes-managed pci_request_regions() with one to
> the always-managed pcim_request_all_regions().
>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cavium-thunderx.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium-thunderx.c
> index 2e2ff984f0b3..1373deb3f531 100644
> --- a/drivers/mmc/host/cavium-thunderx.c
> +++ b/drivers/mmc/host/cavium-thunderx.c
> @@ -72,7 +72,7 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
>         if (ret)
>                 return ret;
>
> -       ret = pci_request_regions(pdev, KBUILD_MODNAME);
> +       ret = pcim_request_all_regions(pdev, KBUILD_MODNAME);
>         if (ret)
>                 return ret;
>
> @@ -164,7 +164,6 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
>                 }
>         }
>         clk_disable_unprepare(host->clk);
> -       pci_release_regions(pdev);
>         return ret;
>  }
>
> @@ -183,7 +182,6 @@ static void thunder_mmc_remove(struct pci_dev *pdev)
>         writeq(dma_cfg, host->dma_base + MIO_EMM_DMA_CFG(host));
>
>         clk_disable_unprepare(host->clk);
> -       pci_release_regions(pdev);
>  }
>
>  static const struct pci_device_id thunder_mmc_id_table[] = {
> --
> 2.48.1
>
