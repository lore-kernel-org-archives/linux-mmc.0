Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CB42A1A4
	for <linux-mmc@vger.kernel.org>; Mon,  3 Feb 2025 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738590596; cv=none; b=m1NRUwhRKse/Q7Uw/NsCye4/CN4vloTBWYysY8IjsG46qcdXnKSkNdizHT/dMwrgllFL9B8RKoI1bjJDKLWQlZ3wPqpZWIbVrkxkJG4Sx0zZEm4IXWE2LJucyAPidnsMbx/2h/6+kyXXd/Ji9mdKwK6BFjCHuNj/HT45ost8j1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738590596; c=relaxed/simple;
	bh=OMneIbJtN3JepqshIapxhdqlKUSdQ4wLnI8CFiRi39k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpEgJDAANKau7vY7myYI6IXnmLnCMOzg172ejvtnxFjpnmEUF+yLlOaOiKX/2uPd/KQvmZMPKUCBV+OVGIRVNSzR2fAGWzCF8RBPM5FIHvfQOXeaG7wIxi0IDb9+8Qx0UYW6A1wxrQG5JFSupQ7q8uHz/X+XTvnWrZ32WBvrmvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yUlTJo1j; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yUlTJo1j"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e5ad75ca787so3129571276.0
        for <linux-mmc@vger.kernel.org>; Mon, 03 Feb 2025 05:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738590593; x=1739195393; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xwSJmHx6P+rMD6RxP3/JhseAAuf/cHx7WPYGkJ10+9E=;
        b=yUlTJo1jm1BavXhZ0OEhzL/d0R/oZxXNhL9ctglo/m1hJouQ6DrWQY9ywGi/bwKPo4
         nGeKiU8A9/AE84Nq6lh1R+GAXKoEt+sMyU0K1TJEJtFgk6DYucUvxowQsZMt40IlShHv
         Xa1DcSYCt0RTvhPMNnvNpTlMtjnNKBctcf+ly+u7TBMpRkpGpJtUGoPbD1dVmSMiJdUA
         U8MOSVqfFMZa/nh0IbC5AP31P8JAsIGkw2vx+oC1e+yAADqat4J1djPVfdyeTJ1a9mik
         liuhShSD8fbUcOGIH0c7Gi7g89OA2dLomZyFuQAf0yZK0J+Xgp4I/F+pG7Cob8jldFGV
         KkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738590593; x=1739195393;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwSJmHx6P+rMD6RxP3/JhseAAuf/cHx7WPYGkJ10+9E=;
        b=YwsDGKzYtX4NjcVJAMuo38XznVaNlGeTGpIQNU3tD+Mxcj3sCtIDEQABnM++BOBpwc
         SgDJiYjOmAgUOHpGK8A92YSThwjdvkVyhm08ssKCaZ67/mFtUxRa3dva5UMYjEO6EtZ4
         E6F744Fx2XeDzyArOYnl6F1+0yuVqQM164lunyc8pTgvi9Sg5FC5VCpaycnAhZp6mpCZ
         6oEXo/2li0lAHP1WAP25w+9wgyZWE/8yLuDyij5CNpGLN0G6k2mCTTgujbz/Vvn3FHt6
         4cG03K4n3RwWAtHRwZUHGAUAheeNvvi0yxOAm8h6jqOTFLIS0d255ZY+j0lbRhyGdId1
         csMg==
X-Forwarded-Encrypted: i=1; AJvYcCWv1Ki1beBmZaloH6IiXhDUPIoyV5+0b0dVAQYccZO9S04jW+y2Rd1sPBUz7EwceUXAhlFLxbhBidM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1oYkDIWVq/ukD0L7TOKEM/9zmPq4Vg0Vl9Fu85pylBuClrme/
	7e2QwfBP8Li21u7vo5PqiEJfMJab+Sbv2cu7C27ayYivXC4Xb0RuqVOtm7e0pAhbGrc0m9HHt7b
	7sVpEylbuH9sT6RK0Vl6BcBRe5+jmmKQN+NmSmBfkttpwMzUr
X-Gm-Gg: ASbGncs+QgCnzIq3LSHir9TS8dnTVQ24jAbTLE4en5p6g7dPvZA002ytME/OJDWr38T
	GbGpm7FZrNtkRd4tmPGWSHHOHHI/bXGLTZ3nM/9jgGe2vkVgnDB1sPeq6eLTVMkl/hWJjqHxqiQ
	==
X-Google-Smtp-Source: AGHT+IGRrUGdfzC94muI+2V/wVBT3fz/YRByVEQs+BTutk4DS3YGIjwshGg4biCOkTb8kfbTM8xIsmSQAUYgpgDWQUk=
X-Received: by 2002:a05:6902:27c7:b0:e54:d63a:911c with SMTP id
 3f1490d57ef6-e5ac88e5a09mr14876073276.10.1738590592938; Mon, 03 Feb 2025
 05:49:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127223654.290904-1-erick.shepherd@ni.com> <20250127223654.290904-2-erick.shepherd@ni.com>
In-Reply-To: <20250127223654.290904-2-erick.shepherd@ni.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 3 Feb 2025 14:49:17 +0100
X-Gm-Features: AWEUYZmGYi0SLIcXBc-UKrgCIvbWzfijse9lXC6ZFq2emMgPsHTojtfuZg3kCKM
Message-ID: <CAPDyKForwTcjEaP4n56zw_VsvmZ=cZZ5BgauL1v_-MnP4En=TQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mmc: Allow tuning to be skipped during card init
To: Erick Shepherd <erick.shepherd@ni.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, york.yang@csr.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Jan 2025 at 23:41, Erick Shepherd <erick.shepherd@ni.com> wrote:
>
> Add a new field to the mmc_host struct to track when the card should
> skip the initial tuning and use it to conditionally stop tuning in the
> mmc_sd_init_uhs_card function. Currently the new field only gets set
> when a DDR50 card fails to tune, which indicates the card does not
> support tuning.
>
> Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>
> ---
>  drivers/mmc/core/sd.c    | 4 +++-
>  include/linux/mmc/host.h | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index cc757b850e79..353715fd8f53 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -663,7 +663,8 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
>         if (!mmc_host_is_spi(card->host) &&
>                 (card->host->ios.timing == MMC_TIMING_UHS_SDR50 ||
>                  card->host->ios.timing == MMC_TIMING_UHS_DDR50 ||
> -                card->host->ios.timing == MMC_TIMING_UHS_SDR104)) {
> +                card->host->ios.timing == MMC_TIMING_UHS_SDR104) &&
> +               !card->host->skip_init_tune) {
>                 err = mmc_execute_tuning(card);
>
>                 /*
> @@ -676,6 +677,7 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
>                 if (err && card->host->ios.timing == MMC_TIMING_UHS_DDR50) {
>                         pr_warn("%s: ddr50 tuning failed\n",
>                                 mmc_hostname(card->host));
> +                       card->host->skip_init_tune = 1;

Rather than adding a host specific flag to let the core signal to the
host driver that it should skip tuning, I think it would be better if
we can avoid the core to request a tuning instead.

So we need to get the information from the host, during the first
tuning attempt if it fails and then the tuning should be disabled for
the *card*, forever.

>                         err = 0;
>                 }
>         }
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 68f09a955a90..91c4db6837c9 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -486,6 +486,7 @@ struct mmc_host {
>         unsigned int            use_spi_crc:1;
>         unsigned int            claimed:1;      /* host exclusively claimed */
>         unsigned int            doing_init_tune:1; /* initial tuning in progress */
> +       unsigned int            skip_init_tune:1;       /* skip the initial tuning */
>         unsigned int            can_retune:1;   /* re-tuning can be used */
>         unsigned int            doing_retune:1; /* re-tuning in progress */
>         unsigned int            retune_now:1;   /* do re-tuning at next req */
> --
> 2.43.0
>

Again, please re-submit and loop in Adrian to get his opinion on this.

Kind regards
Uffe
