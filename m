Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B061411E0
	for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867939; cv=none; b=d7vq3l6/BpRa0t8Qlw5/qUoLJg7DZPY0q9XDDJ0/LwE6c16lYa2IEl5pS3LgeVv0fsVD4yQ/F6eRClnxiICIyhtUirZ6ni/wDHV9ScwM4kCT9LNt2O3IT2i476VQTJ+LnlZm2ySVQI5ePJvScOxf8xafWD9/bPPCe6nFI2uELaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867939; c=relaxed/simple;
	bh=5IckEMkS1v2w7MlR9TIpxfK3GkEl6figDrhQ9A8m/fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0YCbe63iSjtFQydb0XsMf+TgE6E9HULBU8Q/zjejxhlFf6LIwGUz+skvGnHaAxfESVulkHdqj4CU516BlJwhGoEBmX6lzwlEMm4WLxWdVUaou1NqnxfuZUlEqFggY+6Emc2AyRgQ2uTumJsrvQZngBxJAF17SGySIY/GIeXOsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jxPRzMDg; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jxPRzMDg"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fc968b3545so22163381fa.2
        for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 07:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729867934; x=1730472734; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f6xxM29JGW9/m5jgRsXar/Ma8MndkZnSYP4n/2yVQCs=;
        b=jxPRzMDgG0z2wgeZAJC9lbdX6sZ/q3tU/ENdouq1yk10peHc4d3c4YQX/0wbn17W8P
         LThicsXB7c4J+lt5HxFgL1yE1qGIUMSFLzQcLT1umEgPh5BjstoL/xdzHHe0moMaF+mt
         aKSCa7b1GVgq9HuZtyDCcoD2o8GmE0tjfZ/GF3s3jV885Ex6P4kY6dF0AlW9Hu3O4Y1Y
         8KiY7onYqDahAL1UkA4i9d8ojNggND7NtDGe4SZ+Ob1LpWzP94c5lEsAKvcIxNTMplQZ
         1aJl4LQFltxH0gMTcLzUO6+56TkXJ2lyEvix7m6TMsRsAGY4DTtSh9xYZo0VOEQTVu3d
         fk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729867934; x=1730472734;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6xxM29JGW9/m5jgRsXar/Ma8MndkZnSYP4n/2yVQCs=;
        b=qNcIlRno3wCh8UUJoOTGf6aYmM9siBM9IYSioquNoZReGAu9T4KsJECWGKZU79ACys
         ovgzp1vP2v4ielpVOtEPY/X1jk0AvlV9YzsxntRRFMMdjw362qYSVx09LMwxoIPaf8VM
         DQILEXipnXWH45ACWqPnTBgz8RqAAu6K44z/ZwT6IU86nVwHitTfUuShhxvmSQPKdNg8
         3rUYVc/YdrNlG95u1P8fpKgz+x/SH4ENkQCtSYl7i3m9V6a25f5GKV5bhMo7R2j6ECOE
         cQD3+qR4o9OAXLPBL7gJMAhxE2SvhTtZM6oMLS6TUt7GrJwB0OjmvdfV3o666RrZH2t+
         XIPg==
X-Gm-Message-State: AOJu0YwuKxJeTa6wMOgehS94daJyZB4Dkay7RO90kiuFWvHGldzAgpwx
	Uoog6ElUeaHgNLLaBSw7KheMnmdUw0VWMtYtcSvVfpzngNKsEmqnphdAWX8QzyVpoTilWB9AT+u
	oiImWC2/B4YEkmJkDzuwUZI0oqcXEcN4A7ii+IkDsQGlmplP1
X-Google-Smtp-Source: AGHT+IHQkI55s2R4KWCezWYix7qWa1t/64NsxwgDAYWhmOO6jr0QoGtNrSBZQrP9LyXay6avpMCJf2b26b8MEVlloPs=
X-Received: by 2002:a05:651c:501:b0:2fb:2e27:5334 with SMTP id
 38308e7fff4ca-2fc9d309a05mr57096061fa.15.1729867932645; Fri, 25 Oct 2024
 07:52:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021153227.493970-1-avri.altman@wdc.com>
In-Reply-To: <20241021153227.493970-1-avri.altman@wdc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 25 Oct 2024 16:51:25 +0200
Message-ID: <CAPDyKFrhda1k=zQXzYK3uzYX9AXo7XAa+cQiUZg_E-gGbECnsQ@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: core: Use GFP_NOIO in ACMD22
To: Avri Altman <avri.altman@wdc.com>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 17:34, Avri Altman <avri.altman@wdc.com> wrote:
>
> While reviewing the SDUC series, Adrian made a comment concerning the
> memory allocation code in mmc_sd_num_wr_blocks() - see [1].
> Prevent memory allocations from triggering I/O operations while ACMD22
> is in progress.
>
> [1] https://lore.kernel.org/linux-mmc/3016fd71-885b-4ef9-97ed-46b4b0cb0e35@intel.com/
>
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> Fixes: 051913dada04 ("mmc_block: do not DMA to stack")
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> Cc: stable@vger.kernel.org

Applied for next (as it doesn't apply on fixes), thanks!

Kind regards
Uffe



>
> ---
> Changes since v2:
>  - Fix checkpatch warnings (Adrian)
>
> Changes since v1:
>  - Move memalloc_noio_restore around (Adrian)
> ---
>  drivers/mmc/core/block.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 04f3165cf9ae..a813fd7f39cc 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -995,6 +995,8 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
>         u32 result;
>         __be32 *blocks;
>         u8 resp_sz = mmc_card_ult_capacity(card) ? 8 : 4;
> +       unsigned int noio_flag;
> +
>         struct mmc_request mrq = {};
>         struct mmc_command cmd = {};
>         struct mmc_data data = {};
> @@ -1018,7 +1020,9 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
>         mrq.cmd = &cmd;
>         mrq.data = &data;
>
> +       noio_flag = memalloc_noio_save();
>         blocks = kmalloc(resp_sz, GFP_KERNEL);
> +       memalloc_noio_restore(noio_flag);
>         if (!blocks)
>                 return -ENOMEM;
>
> --
> 2.25.1
>
