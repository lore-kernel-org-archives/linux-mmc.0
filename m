Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948D51A4F15
	for <linux-mmc@vger.kernel.org>; Thu,  3 Oct 2024 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970293; cv=none; b=MkYybqzy9hhjJ2rkEUQbWyed/bccBm2PHbLkF5WHlLzkbyd+6YrCHdhO5OxyQS7tbLx9c2NdIBlBDTy8OEzMG8vOi4WhsLcdo+G28HNbSJOwSrHFZvCmZn2yURDBtHPDVhsQLOSe3AqtfwzHa0Nc06E9c3d0yOjrgto/l3AdLeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970293; c=relaxed/simple;
	bh=x1qSTyrPZClQgGo0stX6KMxK3vQg0cnm3JKC2yuwRak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YCbwzYNOau9y6SHWX5vQNNMG9adBh22qxNpKBu7LEpDwvgkMeZ3CWBeQ28H77M97vxf+nWS/zDkQ62oSjvrzSLcCDdoDuwHIJlDDF6ui4vxtEe6GeudCPXvS/sGeMiy36YmGr5OUdbV1WfszYrGVD35Ws6B7jQnUsyLY7fTIgiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VPJZ2J/X; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VPJZ2J/X"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e252d1c5b25so919226276.3
        for <linux-mmc@vger.kernel.org>; Thu, 03 Oct 2024 08:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727970290; x=1728575090; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wQXObGBfjxcG6JwiFIMy6FPMO5Q0XNBCAVT+PBSICII=;
        b=VPJZ2J/XFigWY9xjak6wjox9BpL/WiviVTX0YSO+QOSHC3Q4Sri8vMKwMB6Cnu0na0
         g0X3JRPOYINyyr/7RJUOEygRp9KW+/mTg0fZb8kyYhVqYIAkxuET+pUqn+ok1k2tsT8U
         OMMUOyD8XwwOckTT9GPy2lDxRoJRoHX3sA6cnb2h3IowzZNxVWH7LrP14MMvXZ/1umK3
         IPLJqVgCBPdM0YTknq6hK0Q24cPbK7Mk5sENMQjOWEIkicyzpcI0L774ba98AgPEv7wu
         dbumQhR7QhXlSaSdCOpyhSaw2FR9/OWjt1vaWzKvHyeGwwqybZFKfu93XEAxGmIkj99k
         1xSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727970290; x=1728575090;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQXObGBfjxcG6JwiFIMy6FPMO5Q0XNBCAVT+PBSICII=;
        b=PSJETPDnD9qzwYAm7kOFE9zlrfJ93d+qMqDq8TzDYb8NA2WS0uQxg0Np0TyiMEMFYY
         ARDTDo4ZqxT4yKIsIufIvF7GWiQeS5L9JPlg8UXFMqbgZjNDAvFqG9S+XLRzoWkjWdAe
         l3ZZsCfT5w5CX7pWza7CAzrW7FN+0KHeWDxENafXxnfk11kH6WRqZYJMKIy9alxCvNrd
         J1UdxXdilx/7NOHYOnGA+u54s91xaynHA7L8xfO++xgNhewi0M4XtonyOCps4Sm5XU0i
         FFUsYUOaD7iLUUAbfmpTV1JEo6j71AIuSsGfUDOXwY9takA+8nrA4JNNs6a1wmcevyth
         /jBw==
X-Gm-Message-State: AOJu0YxJgEGsr6Exx42tu8UH1r6aHy5PP0Paja+OQduoguWRY/bTixQ6
	BS7zaVH1GgGZ8fTq1MRKNkT3jbpyBFIQXUgS7wjdVdry4TNYzvmvFVoSnsS9O1f+ZFYlRzgrWnR
	bpevERMvF+thrNOVoI7ro4zrJDvgKxWj4gNuBEw==
X-Google-Smtp-Source: AGHT+IFWwnadUgoDh4meOqlFz7S6fMAx2jM3+ZG7cSsev+I0Efn+pXeuIsSApzcUEqwhZR/CImaDTb7gAPuSNqq+Fr0=
X-Received: by 2002:a05:6902:2601:b0:e20:2de3:b3df with SMTP id
 3f1490d57ef6-e26383bc96fmr5956874276.20.1727970290505; Thu, 03 Oct 2024
 08:44:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908102018.3711527-1-avri.altman@wdc.com> <20240908102018.3711527-4-avri.altman@wdc.com>
In-Reply-To: <20240908102018.3711527-4-avri.altman@wdc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Oct 2024 17:44:14 +0200
Message-ID: <CAPDyKFo0UfP5_tKykRq7fwqDdQxnKETDia-21h-=0nY-0mkPrA@mail.gmail.com>
Subject: Re: [PATCH v7 03/10] mmc: core: Don't use close-ended rw for SDUC
To: Avri Altman <avri.altman@wdc.com>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Christian Loehle <christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Sept 2024 at 12:22, Avri Altman <avri.altman@wdc.com> wrote:
>
> The SDUC spec expects CMD22 to get squeezed between CMD23 and the
> read/write command, e.g. CMD23->CMD22->CMD18 and CMD23->CMD22->CMD25.
> At this early stage of adoption, we want to avoid an amid stream of
> fixes & quirks of bogus hw, that tends to apply extra logic specifically
> around auto-cmd12 & auto-cmd23.
>
> Let's leave close-ended out for now, and re-consider this should those
> cards become ubiquitous, if any.

This makes sense to me. However, for clarity I would also state in the
commit message that it also means that BLK_FEAT_FUA will not be used
for I/O, but instead we will rely on BLK_FEAT_WRITE_CACHE.

>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index f58bea534004..05a7745c2a68 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2547,7 +2547,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>         if (mmc_host_cmd23(card->host)) {
>                 if ((mmc_card_mmc(card) &&
>                      card->csd.mmca_vsn >= CSD_SPEC_VER_3) ||
> -                   (mmc_card_sd(card) &&
> +                   (mmc_card_sd(card) && !mmc_card_ult_capacity(card) &&
>                      card->scr.cmds & SD_SCR_CMD23_SUPPORT))
>                         md->flags |= MMC_BLK_CMD23;
>         }
> --
> 2.25.1
>
