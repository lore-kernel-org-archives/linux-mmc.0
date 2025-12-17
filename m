Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641E930AAD8
	for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979279; cv=none; b=VvjQEowAFtzPBb7+xkLyB+XW4GLOSnMVx5bbnbWDfQOY7E6laSpyQTCbUUBjJ+Hh8lq66kfCTS9ZnoN8cnz8vwbbr0nSAe8ciZOfpzqMUZxilWbwkkFayPDVN22yFT+PgLy1zHYmvA3eu0WOdXOJyfj0b5Zoaj+8ooQadi/yO20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979279; c=relaxed/simple;
	bh=arf6CZpok9qURFWUY+IVoXGLVMMIvAuPB2AyMT/tQ54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUCUS9xpe6Q7HtbRlxzlCjCiRASmUVZnY1Kv5mTC3EcsO/qE8Us7H79yNamMMTsWcGADId1BBDi0Y1Dwq1H0Qq4WLppef5fDkGeL6C5BeBW7ojfWu7+zCghTkx/e9oqUE5m/H7IT9gyd/uLxuK8k8WggtanrhJbDXOZ3j6Ed5P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=unknown smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R9rvNvDq; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R9rvNvDq"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37fcec29834so40368391fa.0
        for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 05:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765979149; x=1766583949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dt0E/6+ejHTgo150Lc89xpPGXdsq1GIskbS+HNFqx4k=;
        b=R9rvNvDqWh/pXFiPIkgZUVWiGx2r4gJKO3oWpc76HzHHMW3QJ6glTdHEy85yVUoAa8
         CPa/zzNHv2M1+CPlKjk51DeRbM9zIIK76MouBm8lu1bQtpF3F9b3CnRqMiBefm4Uv0Ae
         2F5Sqc39ESBv0OeliviSd3CF0S5PvlqgT7hJtKMbSDnpw5GaQQnN1/JqllleKjyBoJfD
         /y0c0Q9uBHS2iVXfkQvwKlHqmiz1ApB0zA0Emc1Dvl+9Du++fzWdqtFbYU2ztd3AHECx
         Fe4+X6Zppj9PaEMUtS+e/Ot0YwF9Ml2J+4YiDQ6Kz28+MmA3YbV60NEsMS0+DPwOESck
         RpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979149; x=1766583949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dt0E/6+ejHTgo150Lc89xpPGXdsq1GIskbS+HNFqx4k=;
        b=NuTzusYEE8uNYKnLfqNcRTXMs71uw6t2J4B5oM4AYITI0SplqhWLNlDTuzFqS22IDj
         CCmUqqxNnUqrozxkoQvsQjhWu0Xqb9zXTJ0Lw5AeZzEQbXd8She3juX8HCv0OxsOW9AF
         /ziJK/bP4megjEKpCfPPkq1rUofQM63TuJrXG2Q8yA43N7q+PNnWqdHDA/qT/saG76R0
         of3w2M6+zuhPmVodFd3zkMFgAOkD9BzMixpHyP29TvybXZrddUW6ml/Dsuvy8m72yQk4
         3QaEgGizj2BQyIzPL/nw+lgmYzTcxVNsVCTr3+beUK5RBoFj1QlmGX3yxivL+INrsSeq
         l5Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWsG36AP1SkYitq5hhksbepIcfhGjm/HtFmBkLJrYWSDZ72LeblOgPrBQmyuvPBWpeiz9rA15TYzhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuN/59d+UA/xjpvz0i2RIgsY/EyaJZNCwdP+QV4SGaDV4PwsbW
	KCW/1S2kWZWZ7ghD24ABZC0E+vCSx9J3z1odXy+yPfPVYp7ZzH6fb9P3w2WwDBrXSaHYRpL9VCw
	YkEWI4gG01ggB9esf5poeWKFgOeVP8jEoc+noRZJWZw==
X-Gm-Gg: AY/fxX4hrKM1TjM9H6eKBjjmwYJ84c8oJkV72bSzxtELqREk5WcCa8IOzFQh7NsKVda
	SBNuirt/J3hAS+m6DzHbiUDDcxuwO/GuDOHr11TPUlcf9CQ2KJ9S2NPspkaSVMGK/iF9ZWCcp8s
	ucFN1xAgkW5oJSU9sGVRMdSO+1ss43hOLUTGWAoxftFohwP1UqJihRlWf/ugdPak96evzsRsJ5v
	hCJu4lx/caZqnRmry48OHusCaelciWxnLNEnI6y+lcGpjfMWw/L3MEzl4XLGmY9EuUGDVeNrE/h
	uvi1tg==
X-Google-Smtp-Source: AGHT+IExF/Q8NXh7TlarsyYw/vHK3VsdDnOYQrrieIlb5+1W8/+jeDq8koqzdO4UxR+bIVmBM4kl/UassN9xjO2VbIQ=
X-Received: by 2002:a05:651c:544:b0:37f:cb34:2141 with SMTP id
 38308e7fff4ca-37fd08be88fmr52413341fa.31.1765979148511; Wed, 17 Dec 2025
 05:45:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212063509.2002910-1-sai.krishna.potthuri@amd.com>
In-Reply-To: <20251212063509.2002910-1-sai.krishna.potthuri@amd.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 17 Dec 2025 14:45:11 +0100
X-Gm-Features: AQt7F2pjYRm4v2emCNW0rzboNC08S4ZEgHkWublRSmLtXYtHl_cyJpaa9pQrJJA
Message-ID: <CAPDyKFrA7TiqX26BrSKaKeNyq8TRSoMpxvChuE1AhdVShvspGg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Increase CD stable timeout to 2 seconds
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@amd.com>, 
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, git@amd.com, saikrishna12468@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Dec 2025 at 07:36, Sai Krishna Potthuri
<sai.krishna.potthuri@amd.com> wrote:
>
> On Xilinx/AMD platforms, the CD stable bit take slightly longer than
> one second(about an additional 100ms) to assert after a host
> controller reset. Although no functional failure observed with the
> existing one second delay but to ensure reliable initialization, increase
> the CD stable timeout to 2 seconds.
>
> Fixes: e251709aaddb ("mmc: sdhci-of-arasan: Ensure CD logic stabilization before power-up")
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>

Applied for fixes and by adding a stable-tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index b97d042897ad..ab7f0ffe7b4f 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -99,7 +99,7 @@
>  #define HIWORD_UPDATE(val, mask, shift) \
>                 ((val) << (shift) | (mask) << ((shift) + 16))
>
> -#define CD_STABLE_TIMEOUT_US           1000000
> +#define CD_STABLE_TIMEOUT_US           2000000
>  #define CD_STABLE_MAX_SLEEP_US         10
>
>  /**
> --
> 2.25.1
>
