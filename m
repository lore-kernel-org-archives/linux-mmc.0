Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7B23D412B
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068838; cv=pass; b=b1cO/KPH4ZhBU2T54r6gKLXrhwLyyjqcxdUgNoKfOJUzKA/5TsclZ2j0eLdxxoRhIwn1U8x/BuceS+Y/Ap9WxgYRwvVFl8zlN4d4NRTUqhf0THXxfsphw/Ljr9JSVR2SubV44YLbacReKfkC586peRPPwrCPVfoAnfT5/0V5s4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068838; c=relaxed/simple;
	bh=E8fOhczjcDEc6pDKMEHpZEmzHvRPAmqH5sHxz4F2AZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrq7NQUFts/XjDMiBGVudGl51/jsWhX0S405OvsXziqhl13CgT1d5emP9KB7oj9Y/ampiBIns1An3pK6219GCVsRp8dqC/US01Td37Dg1JbvYBVnhNTdFixatZW4h8or9ZTqklzh0gdqWPoGdxT603sbzKDCSwTh9L84adZPOLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zv0STtJz; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zv0STtJz"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a12c310e8aso4766835e87.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 08:07:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773068835; cv=none;
        d=google.com; s=arc-20240605;
        b=WG1zwvOgVF8uvkBBJDx77u4LrJXQk6A7rH5wS7Ha40GyhWZNfkN5xHq/I0NMlxpuoR
         ym7QUzJB1RbOzVWyawZZlzPOILwN1I06Fh69ntqti5swh6ikHEyzqpx3lbdjgqOWXWjm
         gMwMjhCx1xt3vKqE0kPOX+dfa5+e0Ft5aFWvga2i/BeUZAPQRjb4JoHlZBUUUoXUbxiz
         m9KA8cY1EBBwooLBGqlKqJm7x0CsZX9cddI2j1TRQQZmAd+5fp9RgvLLni81SZ0eeWGj
         KHxrwWjncBhhJTpLDSthH/VYnpulpX0lBp1Tjz8F2TEcCKqCq96vOXsr7wLuEwZTKoYt
         iUaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ocw4AeDQ/grbadC3KhV6pClV5YbZ8X7UNOCrRS9r2UA=;
        fh=nTasNSw2WVu4ik6FdcKcAOQmhecFUgaDUB6oE6iLIlE=;
        b=fGsaxkXquRKCeyk3zg+eyVdaQce59/uyQAoTQkkkfQMhct10j8VE77zIINtFZXEOYe
         jvzpbG8u4Zvh3gl9plYjyQXWNKYA8JAnuRQr0eu/dSp8sR6ny6ohStOJ3W2jvn2UoWuv
         hZW3lADOmYzV0Ankd6tM2qvQIrr5YGS7lHFS/EdCvL5Xdh9pIP5G29MfCVYse0FiIsO8
         3L5k0gmi5N+NPcCxOJZFRzruCP7lhN39czvszIGNxMWG6RefASH5wWsgC0rU8FTUwF+r
         ZpL3E1nakejhk3qIiSRX3C9hufYMhyubdaLmPE4kY0OCYidXCHAI3ZsJWkz/mqiFhGXF
         5Ztw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773068835; x=1773673635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ocw4AeDQ/grbadC3KhV6pClV5YbZ8X7UNOCrRS9r2UA=;
        b=zv0STtJzbqk2PjSCvnwUoQbWfkOdHF3d0KYyOriqOf8TxJEHWnsLvXz7nWYTn0TBQx
         oFyrykQuDC5Xx2S1kszGS7nEX6MZtJfzFNA6J93gSijq2UUgBM3BVuNp3xBRUxvh5Y7D
         zOyLug+AJYJKkdOZQmrl2B46hBxas2mCBQkgSuoNj74GPCZRCMa4bKscCLS4a1lQKxiY
         ODU4f/DOEjJXXK9VREH4rfMfQvXDg69Urb3WyzZAVAsVKiQfdBXyvSaVlSLEdIy4Yr30
         yShUSBh/r/IIwV92IpMrvcPTgGdWWgkY0VSJvAkun+Uw//ACeuI2yusT2vtNBDsoYARF
         Cr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773068835; x=1773673635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ocw4AeDQ/grbadC3KhV6pClV5YbZ8X7UNOCrRS9r2UA=;
        b=UyV1Bz70RI+OX3Wl3AZCXwdtOgLClHESj+38FUrZoq0Q+GoRzsusSswZAfg75bKYqN
         4IKRnKky1AJk1+IjbG5Z0YqY3WPdoN665PZlas9NxdfPha3dXm9j5ZqcYu/5sNy9V6Ig
         fHKCdfwg3ISVO8F2zJlY0aL2UpYF37q8bAt/q9qE1ODr50Y6+++Khvy/NEStT3MHWy3b
         hczLrriUGZkw91bi2dYGWOAeqd1Aj2vSrIz7W2sONukWbZPaClENyFG4VVtA0PAiXRCP
         zSb1yghZcDn/GH0MKBNGbQuvDU65lslTBWA0KppAU6EE9+ooPHcdHLBdSA79r5hvD3nj
         0ZVQ==
X-Gm-Message-State: AOJu0YzcuCSDt4+FbJvwx1nXsnRf1FbLTdn+YttZ4fHuMy3Qp8YmqUa2
	v0wfYQAYZIV3WHdQ5l4EryMUl1KziFz/tSrbrik8d7OV7Fo5c5MOtKNFR/OmzTEZhrDFwqyZYHt
	wUr4KXYL5pPCjtdvvZ/zaviUtx+tLesyLxBH8inNFENk4USeN4RpIJHg=
X-Gm-Gg: ATEYQzya2DGvP37gS01vTg/ayWcV0YGy0IwedjeY2RJNfSv9vIxTTWDYuipuTcpwRjD
	zlk4EYajWtq2X3pMAn7fOkEczE+ympK4yY7ZZldjkUXpPQXO3OpqUHuV7ZbIZ0P25GRsY/+qRKD
	EAcudM383Lloa758dd+nAAdYWJ+lurDM0tykSmKHieqCxyY7LQWDikBCRhmHESek4M6ul7pbfw1
	0LxONTnZgKC68Rk0Srl1M11lPvPuomzaZL5QGf13PEn9YD6qfavEZwQ0q3TNMfezos9AHp6Hs9b
	VxMHqjPt
X-Received: by 2002:ac2:4bc1:0:b0:5a1:2c41:d28d with SMTP id
 2adb3069b0e04-5a13cac1afbmr3993245e87.19.1773068835177; Mon, 09 Mar 2026
 08:07:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305122553.249058-1-thorsten.blum@linux.dev>
In-Reply-To: <20260305122553.249058-1-thorsten.blum@linux.dev>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Mar 2026 16:06:38 +0100
X-Gm-Features: AaiRm530CZGyyZZ74foNNjArYIu-IAISVY3eiCqDKsW3d9GEgoFzoGNxiQDCFrc
Message-ID: <CAPDyKFqQuO-GRhqtVJ+V1GuQ3XHkvjp9wnDXPhThG2fMjqpt=Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdio: Use min3() to simplify sdio_set_block_size()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Mar 2026 at 13:26, Thorsten Blum <thorsten.blum@linux.dev> wrote:
>
> Use min3() to simplify sdio_set_block_size().
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/sdio_io.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
> index b774bf51981d..12716ec0e35d 100644
> --- a/drivers/mmc/core/sdio_io.c
> +++ b/drivers/mmc/core/sdio_io.c
> @@ -163,10 +163,8 @@ int sdio_set_block_size(struct sdio_func *func, unsigned blksz)
>         if (blksz > func->card->host->max_blk_size)
>                 return -EINVAL;
>
> -       if (blksz == 0) {
> -               blksz = min(func->max_blksize, func->card->host->max_blk_size);
> -               blksz = min(blksz, 512u);
> -       }
> +       if (blksz == 0)
> +               blksz = min3(func->max_blksize, func->card->host->max_blk_size, 512u);
>
>         ret = mmc_io_rw_direct(func->card, 1, 0,
>                 SDIO_FBR_BASE(func->num) + SDIO_FBR_BLKSIZE,
> --
> Thorsten Blum <thorsten.blum@linux.dev>
> GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4
>
