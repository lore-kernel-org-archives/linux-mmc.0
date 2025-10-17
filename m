Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C51224678C
	for <linux-mmc@vger.kernel.org>; Fri, 17 Oct 2025 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707846; cv=none; b=N0bSOuTAUVWsN5Wx9/bU3laOaebfuJvVrUHcp2Z9qFSv7OsrnvAmG3dFeHAMG7bwMVWk+Ei2gRKWep5lu2noujtpNFr3vPzLEZZl3ZXCjzEk5mbMBNQR1HXoxYjnP8lWEr8jzBZ/wOJU3/KWy0p4FhbCE8khfW6r1YnzvejfvXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707846; c=relaxed/simple;
	bh=nYXcmxhs4LvbdSKZB3R5vn/kUsIQ+1W27dRUL7Fu3Qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7Ir9eahISgG5h9YTjCRy2N/lnAeyWo5sYBL5JozJDh/lcPTZaZ4xHSrKpwIrTtBOA7ML+LHyS0eak1I5aPLaurs+pVJhS7hn6UXF1bkBEoa5MYf4MjlCJic8o9CKw+vOM1y4cf0U0jS6JzBZu+QA2nGHKVUjxGsTn3iVSLRGB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M8aLsrge; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M8aLsrge"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63b710f276fso2276333d50.1
        for <linux-mmc@vger.kernel.org>; Fri, 17 Oct 2025 06:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760707843; x=1761312643; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C85m34dncIksFtO82/4XFHj10cdFmW0fFcLEZxpMGJM=;
        b=M8aLsrgeFp8iNBKSQ2rukNjl2iLtQtrua9nEkTAX0yZgFs4DvIXKq8msPaB5wSVvXY
         qSyxHj50huc0hRVVE8C9BFB0FOE3hq3j7tfDf6ZJ0+QPqlmSCcQsbG0IAANtE3/wxno/
         qI2/uQTkgTZF90xvVTZx/sShZQE/F7U7Hg7kzP6Sxzi7F0p1/rH36q6L5JH2IhOR2WKM
         AUfeQFUY/tVRiVmDUzNVsV7PG8C0WrG03xj06Z77B91pSEyFC0JkxiMmpDTzJnlXVEoF
         HKyxh4uhnC1lTRgzn77ofTt6Ie2cZ1o+JE41bae1wVWx4GNRpYyxecc/wTRDW4bOHI0Q
         kglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760707843; x=1761312643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C85m34dncIksFtO82/4XFHj10cdFmW0fFcLEZxpMGJM=;
        b=pXPi68KcMHMXrADzKHKVUwsSoFcbytxZ2A+4BhCjvh6koNjEGrUG4D6CmRsQA7xWWo
         AOteQ11rkhabffGV1LYxkEVrMRt0IgVjCYq4StYKcpocV5nfLa+QBE9DZJ1HdELTZoFv
         2VSNNbXzit1ny2K7xQQ3Ckk6rF4wxKF23vNce8TQmTK8y2LxHLlcVP7Tacz9W5GFbqfh
         iqEA+f+0MhBaod7fuCuFtoKNYFuKd4H/ft0rZqdGxLcR7VUgpP/Q+SMsa4uy3zU9XWGP
         Ykn4G8OwuiQso8C93xDUGOVyeLjCx994tyjO/kTGDfBhfSrLdJZW5oaZC7w4omGAjKFw
         dpXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiPuu1EwalaW8USDomDXxz6llZEKUlqlpVXTUJGhjiJIJ2ogp2CwKeRHf4pHYsPSnuepShqQ6UD1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFQJNDp0teg4Vkq9rY2iXqPlkteAvu6O4yK3JBMJ/cl4orFHmJ
	a4S8moGQAbEg4wkgVDDs/LXRGv9zmUC+MhqL84qxONfl8cWOeg6uw//ibaOzYM6A2gWIVbhYbAS
	pP/rV258tnv9N162oEV68b3RhWOB0oi15XEyi1fk2YiT7beyQ3b6Z
X-Gm-Gg: ASbGnctA2phSMvKV/k8QNxx7AyMnezX34czH65cBdZ/tmnAs9zZeRR2GLyPrVLKMPNN
	G0nUq0p1LizSUfLIVOWincq5mpLNPARUOEtLOHMwV5yVutmlWlkZ+usmbLtRA8izqWPGzc8DZQ8
	Hl6/QBidLl4f3Tz9aWry1dGqdjWie++rG1sQbhgQYYqOKtqEwcUulZE4GUJxLoN++q9p9nLcnPM
	DmHN+LkKaGnfnpDGvqwWcpQll0seid9VnFfcr/eRNzh2xWmmpbaiK7d9mNUA4ul4SDfMvgY
X-Google-Smtp-Source: AGHT+IGM7ZF1WttbDnlAUdtc8KxQINumbhdRwA7kWaOfHk1anszSavtbuXRmZr0ylD863+1/S2QyYGz+9haV7JH6iuk=
X-Received: by 2002:a05:690e:1405:b0:63d:2ba0:df95 with SMTP id
 956f58d0204a3-63e16215712mr3221328d50.69.1760707843231; Fri, 17 Oct 2025
 06:30:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922121448.1377124-1-oneukum@suse.com>
In-Reply-To: <20250922121448.1377124-1-oneukum@suse.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 17 Oct 2025 15:30:07 +0200
X-Gm-Features: AS18NWCCOlK-2zNmRhTl3EQXfzNDfNbL7sr6bngHCY9Rgjx68nz06qHx1dcXcHM
Message-ID: <CAPDyKFpACKtC0uthevpiwfeWTOHjYdnR2psSN_MurgtXd0GY4g@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: remove uselss memalloc_noio_save
To: Oliver Neukum <oneukum@suse.com>
Cc: wsa+renesas@sang-engineering.com, avri.altman@wdc.com, 
	adrian.hunter@intel.com, viro@zeniv.linux.org.uk, ansuelsmth@gmail.com, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Sept 2025 at 14:14, Oliver Neukum <oneukum@suse.com> wrote:
>
> mmc_sd_num_wr_blocks() is in the block error path.
> It needs to use GFP_NOIO. There is no need to complicate
> anything here.
>
> Fixes: 869d37475788 ("mmc: core: Use GFP_NOIO in ACMD22")
> Signed-off-by: Oliver Neukum <oneukum@suse.com>

Applied for next and I also decided to drop the fixes tag, thanks!

Kind regards
Uffe



> ---
>  drivers/mmc/core/block.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 9cc47bf94804..766691d27a04 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -995,7 +995,6 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
>         u32 result;
>         __be32 *blocks;
>         u8 resp_sz = mmc_card_ult_capacity(card) ? 8 : 4;
> -       unsigned int noio_flag;
>
>         struct mmc_request mrq = {};
>         struct mmc_command cmd = {};
> @@ -1020,9 +1019,7 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
>         mrq.cmd = &cmd;
>         mrq.data = &data;
>
> -       noio_flag = memalloc_noio_save();
> -       blocks = kmalloc(resp_sz, GFP_KERNEL);
> -       memalloc_noio_restore(noio_flag);
> +       blocks = kmalloc(resp_sz, GFP_NOIO);
>         if (!blocks)
>                 return -ENOMEM;
>
> --
> 2.51.0
>
