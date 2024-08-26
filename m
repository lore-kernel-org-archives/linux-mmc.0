Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A654316F84A
	for <linux-mmc@vger.kernel.org>; Mon, 26 Aug 2024 11:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672365; cv=none; b=ndjFYcut7mtoVN00GjC4SPcenoYGAq6Xlw57QpPAWetI1si5XNEH45ZjshF0Q7w+YrG/ExL+wkyTcUFN64nAs6PgPJ0a9Q8fPh1d5YEaOd1xWBW/s9j3jEB1I13UPfXrXbTO/tw81ETbm9kCOTzx/MRy6HOl8ER6YevnuwFJaLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672365; c=relaxed/simple;
	bh=wbnW/xOQAvjNSl8IjbdASCZ6CTlenb0hgbaw1Wm+0ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bRgDggGN0mZsOE0m/u0INYLdp3/Rzk6G8z9n0w9jIKPJ9ewAh46sHwLUMcjMowXrQsuWQ/coXwnqKI3w1MvpaWk2hijObK1vH4XnDUk+rJFuel1jXkoin2oQboYxPxpouD8U4W8osyf+dZceSZUn0vL6OucLyeyOIW0PFK4BJcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HHpjpFGf; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HHpjpFGf"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e1659e9a982so4585964276.1
        for <linux-mmc@vger.kernel.org>; Mon, 26 Aug 2024 04:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724672363; x=1725277163; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yAEEYq6QuPWziF+MTaV7RKYiwHKZRlAPBPaklGhEI3U=;
        b=HHpjpFGfZJV/mkcdabohTw3TSA8ddU8otqtOCOvUIP7JSbjIQh99KaXEjuZ75dvB8E
         u/gtrFnf0A7/B98i5RvLZw79nn/mcQUzBIVHADW3BeQ/p1GBS8UqHjhDWi3jkp1AgyaL
         JLxPVELYagSun7xlskaw/SuPzMlBzZ+ox817WDSNtjdfjlA9HHHZsSoP9DbMdTl74xnR
         hwuJfo/O5nOmi1cUr/tzXP7o1kmaK9USFVk+t+0VPV3Nk5ORV4eD4suuOn9obQnlyslO
         ufLEy4L7attYsHXB9RgKG/psW236Sg7FttnVHeCGzZ5lGQ0zeIDqg4/TniFsBoktsx0v
         MtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724672363; x=1725277163;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yAEEYq6QuPWziF+MTaV7RKYiwHKZRlAPBPaklGhEI3U=;
        b=pfSbTPxmzTUlkpKhLrZNBdqpTL14Vh6kKBDv4hcgZnpHOl3ytEgNZDuJg5ax4NcTHv
         U1UryscZYziYuUnb36vtZ/2v5ULmEcKiPN3UVDzMdkFQ15CRjvFpjvRVRwEaOaOBrf3s
         aU3ZDg2TbYqi9zw4CejbsnzDlgDbi2bVmTZadU1AXHQlMCmUACGADQOf/QBpm3Poaofw
         KkR0yy0BvZXljG7ldDzRJufYvtVUeCszxdrusgQdnph5nK8Cilyv3X3UrrAR9uetAOud
         ay3JXqn2vPUE1PtSGwHyDvp0wGtbMUuqOpVov9+5/knDM5Xnz+hOs+7UHZFSIQN8xHWt
         5gkA==
X-Gm-Message-State: AOJu0YxUE08IOJ8uddRXXHkyUouux6XOPATpWUeZF4WdbzOqnl/S3eeQ
	810B3oKF8+cbFgA3LEnep2LtJwNfRVrINMLRfblMthsmtA40rA7N7WF6N00FEIprn6K0otze5SV
	sKJCZx0hrkH8hdeZsUV8C90JV7dg6odvcniwICg/rn/XQo+eK
X-Google-Smtp-Source: AGHT+IGOenqQYRk7F+kXpJd/pPy7WAd5Kwv/luVVWGXZc2L5bI719G7h7qg3xoUBl+Qbh0gAXZDvXiseHLY1s9FNCMs=
X-Received: by 2002:a05:6902:2192:b0:e0b:b2a7:d145 with SMTP id
 3f1490d57ef6-e17a8682cc2mr10270741276.55.1724672362708; Mon, 26 Aug 2024
 04:39:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823225917.2826156-1-vladimir.zapolskiy@linaro.org>
In-Reply-To: <20240823225917.2826156-1-vladimir.zapolskiy@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 26 Aug 2024 13:38:46 +0200
Message-ID: <CAPDyKFpGRDOc2fL9ndzH0BMQeoe+q0FbscgAa_MWe5s69MfixQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: remove left-over data structure declarations
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Aug 2024 at 00:59, Vladimir Zapolskiy
<vladimir.zapolskiy@linaro.org> wrote:
>
> The last users of 'enum mmc_blk_status' and 'struct mmc_async_req'
> were removed by commit 126b62700386 ("mmc: core: Remove code no longer
> needed after the switch to blk-mq") in 2017, remove these two left-over
> data structures.
>
> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Build-tested only.
>
>  include/linux/mmc/core.h | 12 ------------
>  include/linux/mmc/host.h | 10 ----------
>  2 files changed, 22 deletions(-)
>
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 2c7928a50907..f0ac2e469b32 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -11,18 +11,6 @@
>  struct mmc_data;
>  struct mmc_request;
>
> -enum mmc_blk_status {
> -       MMC_BLK_SUCCESS = 0,
> -       MMC_BLK_PARTIAL,
> -       MMC_BLK_CMD_ERR,
> -       MMC_BLK_RETRY,
> -       MMC_BLK_ABORT,
> -       MMC_BLK_DATA_ERR,
> -       MMC_BLK_ECC_ERR,
> -       MMC_BLK_NOMEDIUM,
> -       MMC_BLK_NEW_REQUEST,
> -};
> -
>  struct mmc_command {
>         u32                     opcode;
>         u32                     arg;
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 88c6a76042ee..21e5534ddbe6 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -264,16 +264,6 @@ struct mmc_cqe_ops {
>         void    (*cqe_recovery_finish)(struct mmc_host *host);
>  };
>
> -struct mmc_async_req {
> -       /* active mmc request */
> -       struct mmc_request      *mrq;
> -       /*
> -        * Check error status of completed mmc request.
> -        * Returns 0 if success otherwise non zero.
> -        */
> -       enum mmc_blk_status (*err_check)(struct mmc_card *, struct mmc_async_req *);
> -};
> -
>  /**
>   * struct mmc_slot - MMC slot functions
>   *
> --
> 2.45.2
>
