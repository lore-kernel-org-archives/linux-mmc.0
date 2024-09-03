Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C3E1D86FB
	for <linux-mmc@vger.kernel.org>; Tue,  3 Sep 2024 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367080; cv=none; b=FUHQABapgjGwcU94mI0eqy3VnK+0GC2xms5ZsJXJfiWUjrFwrLzKp4+9boSAO8aeDJGte0dvc9Kw+r008I4OP9syAjGg9w/V6vmOiYdEmQsufQd6tuyGi6Uzk5WvUSAz7x5AeqhzLUW6EBDf4Y4hQ2WzmuX7gEay/na9VHgl+9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367080; c=relaxed/simple;
	bh=uu6Yoeqi+RNoig3ATUPsT67nAJWUqDSiEcB/mI869tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2PdpvkCBiTuDfel8BGfbJKtZSQ68n4AHxT0tbCeA9x87oeRnSiQHD5dGP0Tf/ql4P8fpfIofFLL0n6sxT+PUer0x4EddKhyiq/VZMn3s0qo/Wbj+ECjGxkazI4197yJl+Lpiv3YPAgdiiO9queTdBVkZ/GGwZ2pYmC5fMYDTE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VS3kc797; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VS3kc797"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e17c1881a52so4423742276.0
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2024 05:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725367078; x=1725971878; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/ttVzkkd4yGmrGeqOJ869ESzGGtHpDRb7/D4IC8eBd4=;
        b=VS3kc797SAsXs7KxZFv1Ynhn/mC3GBHrU5vSBcwkET2YsMClY5NZDIftw1/GF76o5R
         5c53yBYiw9M3Ak/M/JTbIcPYaGNmXX63DjRSCW/dsnwXaBtYu5nt5Z7kUQiiBwH0/k5I
         lJITqAur9HDLJvD+nSzPtbR/2gTCRZ95sgfr4iyjgKoPFX0WtjfQ7PTFZOO2G0StoFRe
         bddtq1K94RtRKPghvfpXW9Tvsblyr9O8eT/R3cE7Y/3jLffrUg8I3KOIpkRHMfWR+1xs
         c/2utaYQzxw+Oc3ZK+8iJuyBaBkzqb8TkxsT04ZVkL0fp0+AZl+uMKOko85J24SiW7ei
         MGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725367078; x=1725971878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ttVzkkd4yGmrGeqOJ869ESzGGtHpDRb7/D4IC8eBd4=;
        b=eWn3GzCR25Y/Lt3d572G1eK36bpu4JmqpDfYvDwDOyIWMU2LfELaqChMD3RhffO2vB
         vy6CB4hOl9YTNdgNKP6B9234ynAehaA8H/v+rH47FyEFfgihrvbjeH1L+5FvI+aKyPlS
         +4iMHg4Eh5QZyzPzPS9IZbLG/5RrGZfSQNe0TbhuhPLQpRq+oTdwuz8Q4sY2ORjw86NL
         9ZAg5Ozt0ev7T29dIXCmin9PzRoU5wIW3SVBK1/kmoev+/eeWXSuymEiKWGcas5QX6cP
         in3OIcjXXhKwal9sZIEm9OrgRU9n2VB+uTDY9XM0kbCiVUslrUnnzd2h2N0chm/y3WgA
         XHgg==
X-Gm-Message-State: AOJu0YznTYcRdnjr1mhlQqsqTORXZ9yiOzpIvcX6/oco4LBxGJOrZ/Hy
	of0xKxoN8PM7qmVDVSWpFhcCQN5LaVawJLJhRb3ee7O0nwbevnL22p72k5CsyF47rUro5YfCyWl
	G/wkCtrEcWzSxXkKVFEptfXcGkehLVbBjcmFaPQ==
X-Google-Smtp-Source: AGHT+IHHBkaojbuJ6rcO32k08NkULZE8JcrC5eAZHxo6A82M/tYG2W17RLlunsSJO2ZGGq1x90VJ7lCRhqfhEMPtblE=
X-Received: by 2002:a25:8312:0:b0:e16:5174:fdaf with SMTP id
 3f1490d57ef6-e1a5c613ad4mr15597080276.1.1725367077643; Tue, 03 Sep 2024
 05:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901173309.7124-1-riyandhiman14@gmail.com>
In-Reply-To: <20240901173309.7124-1-riyandhiman14@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Sep 2024 14:37:22 +0200
Message-ID: <CAPDyKFoFZEKwhAgC4UT7NP1ZaVBj1BjLk79LcUmTg-wSDs7Y+Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Calculate size from pointer
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Sept 2024 at 19:33, Riyan Dhiman <riyandhiman14@gmail.com> wrote:
>
> Calculate the size from pointer instead of
> struct to adhere to linux kernel coding style.
>
> Issue reported by checkpatch.
>
> This commit has no functional changes.
>
> Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 2c9963248fcb..dfd495e86985 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2484,7 +2484,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>                 return ERR_PTR(devidx);
>         }
>
> -       md = kzalloc(sizeof(struct mmc_blk_data), GFP_KERNEL);
> +       md = kzalloc(sizeof(*md), GFP_KERNEL);
>         if (!md) {
>                 ret = -ENOMEM;
>                 goto out;
> --
> 2.46.0
>
