Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303EC259C92
	for <linux-mmc@vger.kernel.org>; Tue, 23 Sep 2025 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758639689; cv=none; b=Cn7DItY/y8LLZ36wUWS1xJXglqdy7G7UDCPjSV1dnlURDHedEQR5PNjw1mPWyFOmB0bxk2XBFa7ZYlsu97kcSkc/xbpbHaowwfXKcn1T8Bqd/81GgvV6JSufgYACSAnmCpF7gON6kIqizNk7dcHmRADGNldJz4gd94VD9CLWfgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758639689; c=relaxed/simple;
	bh=b/4Kj0JudrUWG17uT3whCPEX01JzXuMuA+ymb+XpRNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qv5DP6Uv8YqyGaM3zBmMsJN9hkNO2uOBKwzZxiobfNT5cmXCYvDqTWizBlqe+BZHkn6aCDAsH+ZfVYRlGXVAmuBSpUPPXmjjz/pdNvtjGgM2ZMjJ0Lv/BnzqUTQrEhB53j4BIiRhUue2J4rpsfAJDwhI6vShWDSi+Bs4UK7OC00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hQICTx00; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hQICTx00"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6353f2937f3so1425093d50.3
        for <linux-mmc@vger.kernel.org>; Tue, 23 Sep 2025 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758639687; x=1759244487; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SCvTZSbzHUifgB58QHR5wywQKEe9SsgsnOwfRwOmfM0=;
        b=hQICTx00LhbUA/aEuYRhPduqUUn6GlJAp0n3q5ZDaO5sg+57Mrt7dmprg2+yCreALo
         Ig76ib3Ic37Y4JsvWiuv0hKPrzhJfxqhh3NtBl/u46DQ9awMGlRYxTKk1o4o6E/8sl8o
         /dksyr3wk2ZIFg7KSEW24m6pBiV1YSQYcvk43yc8gBms8nEE2nXhksHpK8ibkAiVQ6mN
         E0C/8zSfuTxdIoyw+jRS5I7Qyh/dOcgmZefzVJqE+wxus49Vsy38qPQCVVEPJ9/Jfl4e
         wbd5j2NeHDtszpuHjWI5Sr++hEwQQGZkVu+DFB5N800RN8ccCEwfY34iB+HFkNnMT7Vv
         Lm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758639687; x=1759244487;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCvTZSbzHUifgB58QHR5wywQKEe9SsgsnOwfRwOmfM0=;
        b=XvjwhBItP4dA+MqwvwHMrJpb2Rq/Ik55b+0ML8nlwclhOIPZVe7hr+dqUa7997aM6B
         ehqgZaAScpyaL8eSowLcbhyKIbS9DOilrFPPvS5cGPply4yuelXK43F8zROIZU42+F33
         5zkiF6I0ycr17K/DuFY9azxtd9ZT7P5J1vZA/4ZQi/tdSzqtBmoUVIrBbSYd+DLPPF4m
         no87uvuz5hUlykQ3fN947PUKhDTfK6/5uuJv0sfcwKK96lmqYc4T5onuuVqPvEKv3Zmx
         Ce4e8BPqomb/LCsAG9ap3I7ZXharVTez+pcr6IbntK5FzW46l2Cwq0xJ8dTMweler3Q0
         /O3g==
X-Forwarded-Encrypted: i=1; AJvYcCWuzPfI1zz2+FalZXqr9zhpFbRO00JanfILFQdqg7G8FsHLibaIvw8pzhHvsOJlcVv6SZghTswcsXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8BrDW574IvvnqIbMjpywjW4xQGllOivE6/7wRySx/UJnTsuz0
	AyQ8wOoHhhO5qRSDggmERBQQn5lHpkhfyD6IcE1728XmKHdaN/IQbX43hfvNynny2bLy7HKKa1R
	lE9et8XDZG3R8FAKvTBfBg28qZY9TSWhspmnFNDWtzQ==
X-Gm-Gg: ASbGncvSQiXu2o9BhtiIeW64z0j3VRIszqG/6/NW5ZZMMr/gcD9VMMf4n3BgX5Lut4e
	VG7LnQvlB1wmoB16N3RsDflh8uo7Dy+ppLAGCZq3H0wd69fEHuG0I/0pUxujnp17/8m04esgkKu
	DNDpOPKtULq9m/aSz1JnNE/qjYVtU2oAVoHgeGMTAV9oywqEmb09cA5hrOS4JmNc6fpH/6eJI9g
	ti7NIuW
X-Google-Smtp-Source: AGHT+IE8UV7w14y+shjcyFbK1bBcZvU4rKKhaVHDXYOAkdUe10XSDuSjqUIpf3PDVT9dXBBx6HUGsiKyPXQIbYn4Cfc=
X-Received: by 2002:a05:690e:42d9:b0:632:f381:13a2 with SMTP id
 956f58d0204a3-6360463a53emr1808131d50.23.1758639686592; Tue, 23 Sep 2025
 08:01:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922121448.1377124-1-oneukum@suse.com>
In-Reply-To: <20250922121448.1377124-1-oneukum@suse.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 23 Sep 2025 17:00:50 +0200
X-Gm-Features: AS18NWBzCw0KAqMkh-hqn6uinN8WibZkDuzYJAdB5Qz0XJKR-TLezXj9-S8s_sQ
Message-ID: <CAPDyKFrQ+J6-q34X1OJHzO_Y57TE41RSRR8TNZLt5rHdVC1NEA@mail.gmail.com>
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

Is this really something that should be considered as a fix? Is there
something broken or we are just cleaning up the code?

> Signed-off-by: Oliver Neukum <oneukum@suse.com>
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

Kind regards
Uffe
