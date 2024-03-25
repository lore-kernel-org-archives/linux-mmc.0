Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FCE199BC
	for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372724; cv=none; b=kNVyq80XAoh9YnNHYN/ZOf8oJfpXEvIrYLDEmgXUnJkDOrTWsQJfJnC5ktKjNh8+402icFIlsT6F1Wd3ZQCjaUCUS5pAqPcN+bgmA1IAiEte1mDTHTQwQZhvdc89bcdzDSLlW45kWGA/ytqZ3xX21lQcrjUYAFzBIc8/u7xU3zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372724; c=relaxed/simple;
	bh=jUHFT7GHBABnNWhUUsb9TaH8zDV3pnOGgOcdjdlYdbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1nw8Cdfumoa5ShvmwaZBXrmjYWVa7dzpOpi9iEKyUZh1xOVgOB1n4Cqw9xBJ1DA9Bg0vhUI9YZqLUAQKqTCUzb2g4Nt0lQYsW2uLVdCyRrF3aOGthRVD1VUszp81gYivuF08MXlr/MdX+aHz988pCjYU7oQJPZRVICYH+KiMDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ktSRhk1D; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ktSRhk1D"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso3794200276.1
        for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 06:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711372721; x=1711977521; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ceL10kuUzc1VTmaQNsfHwRb5WEw70QYvCvwFrHJHCrg=;
        b=ktSRhk1DyPESD79xLJ+UcPqL6I7+rnbBOSDUkhSa+NMBab4kt1sALOp+3BD+MB1YZJ
         yUbEudMW/Thf0F4e44sKdHj6aubuDJhK4LQKrTx4SMERFg1mHzm1UD3cwuejvn9pWmv0
         t220Y07NLgyYTRKS/NCe4iX9UQdry/SNhdpOLXe3f/hJemO9MM5ceOecBlUz333g+x1J
         qb+Scu+SSOech5A5AFGE70zjL59hTCnLBl2Ca9LSpqTsha49ugm7s7ljZgbN23zDBkPO
         hu00o/POG1PjJ3quMT2TK+BUpTsn1LXasKs8wEfhuI6R+eAq7cKfN//Ljl7j2zwbkUDx
         m9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372721; x=1711977521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ceL10kuUzc1VTmaQNsfHwRb5WEw70QYvCvwFrHJHCrg=;
        b=nDzHOeLqsM0BDg6JaYN+Ztkco/AiOSoxV1Er9dmGMd+2/VNR1pRXeG7uhRNwJXSCGZ
         LiLnpHheh+rh2f+iyyqmw5AobkvLICVcgPR9A1qgPWdNcU4RU9ulM/t8HFvUl0t+qq1U
         NhC9OwhfpssMJCRAfBL107yx5yDb/X2EXO/qaBfb2modYICuW+eM06rGAVoxvXGdIU4W
         i7YBaTjC3Vph1Pa4EBGJC73fj7L2G/sXkXWmYsp7Vf5PABR2A+DuQDj2LKkmGacGI2jG
         bC4psIX5kQQ3sF53cFZQnWpkwIgfri4tU7h8KEUjCB6NuUJXgZgyMRguJcCAcvJvsfaI
         3v0g==
X-Gm-Message-State: AOJu0YyDsORNSClUeTBkIPa+ZARA7TqUC71TlG2wNe6LSxj6dg43oMtY
	azP0DpvAVPW6HXfrYSwDhdHEeacrCZJfJ5S2UJZ5bckYv1SJ0HggmtVzCbN7N5svP+2Lz+9H1oH
	JCaamu7sMLV4cNDKarQkkGQ42+p9ZIGX8XKV66g==
X-Google-Smtp-Source: AGHT+IHBAtsETDpFdGmDQMqeFq/C1HWpnkyJwmkgZqhewbdaKt4PCmaqUyLetMdO7RYqpCQvGSwJSK7+UJmmFu9aNpM=
X-Received: by 2002:a25:aea0:0:b0:dda:c5ca:c21b with SMTP id
 b32-20020a25aea0000000b00ddac5cac21bmr3873894ybj.37.1711372721646; Mon, 25
 Mar 2024 06:18:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313133744.2405325-1-mikko.rapeli@linaro.org>
In-Reply-To: <20240313133744.2405325-1-mikko.rapeli@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Mar 2024 14:18:05 +0100
Message-ID: <CAPDyKFpkz=LeVR_8z0-jh9QGwdXp1GUZ+VFPdDwKChBNFHyEGg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc core block.c: initialize mmc_blk_ioc_data
To: mikko.rapeli@linaro.org
Cc: linux-mmc@vger.kernel.org, Avri Altman <avri.altman@wdc.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, stable@vger.kernel.org, 
	Francesco Dolcini <francesco@dolcini.it>
Content-Type: text/plain; charset="UTF-8"

+ Francesco Dolcini

On Wed, 13 Mar 2024 at 14:57, <mikko.rapeli@linaro.org> wrote:
>
> From: Mikko Rapeli <mikko.rapeli@linaro.org>
>
> Commit "mmc: core: Use mrq.sbc in close-ended ffu" adds flags uint to
> struct mmc_blk_ioc_data but it does not get initialized for RPMB ioctls
> which now fail.
>
> Fix this by always initializing the struct and flags to zero.
>
> Fixes access to RPMB storage.
>
> Fixes: 4d0c8d0aef63 ("mmc: core: Use mrq.sbc in close-ended ffu")
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218587
>
> Link: https://lore.kernel.org/all/20231129092535.3278-1-avri.altman@wdc.com/
>
> Cc: Avri Altman <avri.altman@wdc.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>

Both patch1 and patch2 applied fixes, thanks!

I took the liberty of updating the commit messages a bit and dropped
some of the unessarry newlines.

Kind regards
Uffe



> ---
>  drivers/mmc/core/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 32d49100dff5..0df627de9cee 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -413,7 +413,7 @@ static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
>         struct mmc_blk_ioc_data *idata;
>         int err;
>
> -       idata = kmalloc(sizeof(*idata), GFP_KERNEL);
> +       idata = kzalloc(sizeof(*idata), GFP_KERNEL);
>         if (!idata) {
>                 err = -ENOMEM;
>                 goto out;
> --
> 2.34.1
>
