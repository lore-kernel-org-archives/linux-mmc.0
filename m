Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C793BBEE
	for <linux-mmc@vger.kernel.org>; Wed, 28 Feb 2024 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125460; cv=none; b=YYoQwsAgkj4Q0ITHv75TrhIT5/v0vSdlC8vsRvWigxNZLdxsXl9MN7dtrXzvpCeV4dAka3F65zEIUC41amIUFv08Jli6lA7JKWjKajEern28t5HR82CfBFd/og2wLoRawq+Y4wUZIL/hwwBTRa6hpoBNABNGjjjWZx+QPAi8Gnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125460; c=relaxed/simple;
	bh=0SqYsYVQPb9uw3NVrcXdlLIRrvDYtJuFX0UhHmfC2PY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHYxyurx+YMGL74PFnSqI2Lp6bLXb7rMcJGIBHbCKoXcWQwkgX8yVsemMH1TLUHQZWk0JNoS3bXS9RAogKbzE0m3EP3njyuNLHtd1+X+744XcD3scy5B9NBtjiWY4OIAp3f/cDqbSvlJ5cfPIDqcLlmV6dZ9O5wt3wgwOxbQIy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CbC3EMT+; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CbC3EMT+"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6093e067220so5002307b3.0
        for <linux-mmc@vger.kernel.org>; Wed, 28 Feb 2024 05:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709125458; x=1709730258; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yoQ079epGHc1bPnZ0mLI8o/HetrqatRYBSGMnOJuavY=;
        b=CbC3EMT+O/N5682PXo6VaLFjvWFv+e1KU2yEJfna5zdftD6WIeVdgZwVM1poQR86jN
         b7bz4p5Bo93ZMSg6YP9dSoJB4bOLAp7Cpk0cEANsKGElhEjH4TGMD8UBsGOQDzhn+Xd6
         GAF7YjqH50yEqvlR6TYMTR3AbQOXWz0apcab3gM44ab8yczt1iBpzAghBxB3PYZfX0lG
         MGzuRkKoCKhJZ9HaP7ARlYnTONXYQolLX2gqtg2yFjV8sIC/FgrIRQZ64sQmEUUqSetW
         /Skeh6sAzK9WjvY5d5FFlkrjgYQB2RUxMCe9XwUDTuxNH62jLIMc2PZ8Jokk9WghetWD
         mlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125458; x=1709730258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yoQ079epGHc1bPnZ0mLI8o/HetrqatRYBSGMnOJuavY=;
        b=RNtuJRnHS3vMVnn1ppgkTREfrQi2+3UZ5RLHLC2plkZR6F0EnPZTF3E2EK9jfOZf/i
         xUcEewAmy6W5B4rPdlsPVf0tq6d4k0UoOIa/gazyKbYSYKmCV1Vag33h2i5sWcYc9eUm
         slzlXhAQqFTL/n9JzgBHLa4wlcVkbPqzWNA2NhTZ/Buq2MlN3QYc1MTr85JZLN8Q4G2w
         k0vpvRVA4T7LcP3/f/uhWcJlH3YnWqsSXdBxtTGVIoyrZh+B084BXvzlR+u17dBIuadJ
         2NHVaTYJeP3Wk38/byQ+120ifGOAqzXYHDMV/Y56NtvEatIm0VZ0vSFAI64I3vSodX4S
         bExA==
X-Forwarded-Encrypted: i=1; AJvYcCWesKC7VNVKArtm9p63VKVowwCD4k8dfN12+lRPqMM2bKVTJjo/mHae1fc3JxbS8qZPmFlbha7CFr5swqNDut+W3r3pICcDNX7S
X-Gm-Message-State: AOJu0Yw8C4iZk/l0pddjQoXrNVHFHudD6FW84U5LQRM9HGEL9Jebj3XT
	QMyVT5asBHSjDjyahXeE4hp0BDBp7blH82zapnfPe2uN/yHdxmTL7d1S4fHcw0PO1hkoVNl2PDx
	Fl8OcyJRDVcqguafMG+fvu1aQ0LAfZXFIgpnUiQ==
X-Google-Smtp-Source: AGHT+IHndZaxFwGyGWZqByZ6YJxq+XwvpUrOG39hYhauffsjZ4EcavmFJLttSfzT8e1fNjczOmvM+tTdA+D6FewXUWI=
X-Received: by 2002:a05:6902:2749:b0:dcd:13ba:cdd6 with SMTP id
 ea9-20020a056902274900b00dcd13bacdd6mr2635706ybb.47.1709125457635; Wed, 28
 Feb 2024 05:04:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228-fix-sdhci-esdhc-mcf-2-v2-1-4ebb3fd691ea@linaro.org>
In-Reply-To: <20240228-fix-sdhci-esdhc-mcf-2-v2-1-4ebb3fd691ea@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Feb 2024 14:03:41 +0100
Message-ID: <CAPDyKFpgywFP-9gy=_A=GTLMk-BtrT=B0zt8JEBEmwd+LE6mtA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-mcf: Flag the sg_miter as atomic
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	Angelo Dureghello <angelo.dureghello@timesys.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 10:07, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> The sg_miter used to loop over the returned sglist from a
> transfer in the esdhc subdriver for SDHCI can be called
> from atomic context so the miter needs to be atomic.
>
> sdhci_request_done() is always called from process context,
> either as a work or as part of the threaded interrupt handler,
> but the one case when we are actually calling .request_done()
> from an atomic context is in sdhci_irq().
>
> Fix this by flaggig the miter atomic so we always use
> kmap_atomic().
>
> Fixes: e8a167b84886 ("mmc: sdhci-esdhc-mcf: Use sg_miter for swapping")
> Reported-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied for next and by fixing the spelling mistake in the commit
message, that was pointed out by Adrian, thanks!

Kind regards
Uffe


> ---
> Changes in v2:
> - Do the simpler fix and just use an atomic iterator, it
>   will work fine since esdhc_mcf_buffer_swap32() doesn't sleep.
> - Link to v1: https://lore.kernel.org/r/20240222-fix-sdhci-esdhc-mcf-v1-1-fb87e04ca575@linaro.org
> ---
>  drivers/mmc/host/sdhci-esdhc-mcf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
> index 1909a11fd065..c97363e2d86c 100644
> --- a/drivers/mmc/host/sdhci-esdhc-mcf.c
> +++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
> @@ -313,7 +313,7 @@ static void esdhc_mcf_request_done(struct sdhci_host *host,
>          * transfer endiannes. A swap after the transfer is needed.
>          */
>         sg_miter_start(&sgm, mrq->data->sg, mrq->data->sg_len,
> -                      SG_MITER_TO_SG | SG_MITER_FROM_SG);
> +                      SG_MITER_ATOMIC | SG_MITER_TO_SG | SG_MITER_FROM_SG);
>         while (sg_miter_next(&sgm)) {
>                 buffer = sgm.addr;
>                 esdhc_mcf_buffer_swap32(buffer, sgm.length);
>
> ---
> base-commit: 20af1ca418d2c0b11bc2a1fe8c0c88f67bcc2a7e
> change-id: 20240228-fix-sdhci-esdhc-mcf-2-539cf338c3a3
>
> Best regards,
> --
> Linus Walleij <linus.walleij@linaro.org>
>
