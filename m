Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCE630EF7C
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684092; cv=none; b=ZxWl7KUaMEXNoHvMSupDJEMPwhOovORbEKg+k1FbOh52tzcOXyC4d8FbdAvU+GAmZ4YRah6piglhsPj6hU1Jv9EUV572XpPMzHJXshe04PpvOu4d5Udxp/9PLcRML2jltNNcVvaXZeOrI7kv0ifr8PFhwvJ3o1MESk90YO6Ki0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684092; c=relaxed/simple;
	bh=utugK4HcYY18T5CEwLLLvgU2oRcmpLnYaZhUun8E3dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5ShlZ/uMNOLDYjagC4bgahUFM5azscQLHgRzZtkpXMW2wf/5rftPFfooWhYZsTUPJkflj+ZrwgqcdowvwTvKZ6nZHCn2mFOwIhpSyGhRve2wTLDHWkpgPxMLC76emViBIUUYxhiL5Z10oEpPx9/zPdWvruwVNm0XB86YBxQb3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U8e7Z/OA; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U8e7Z/OA"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e96c48e7101so1492435276.2
        for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 06:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757684090; x=1758288890; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NMoRsZDotQQreQCt//iZViK8n2fFjlTpFk9lhVbhMl8=;
        b=U8e7Z/OAo63BAc/rUXFgTYt/pAfB9UE1vutb55p7vqQlKIU39lrD1tFi4LETJRGIsz
         kUGZvzBTUiZVuSY0eJqRXDM3uSfI0rxNGQ6LHFpWPJwAZGdMLkS+NGo+gvSOXYPWmhnt
         jNY8lJZ79KcaB/lPfSb09T4z7eabgGo6/S/HG8l5pAnI/wSnZIQweGyJ0ksgOzYl6MAA
         u8DCnlhKa6HAcwzclzxNWHVLvMfA/fqhWtBYx0e7s9YcALvIS9UO3jsDzG0iN9a0T8qH
         MlF76j72+i0P+NKnjOhw4igvNZcz7CLqkvYYAVn/xM7v107VmHn82NzQ8kvLWVEo1w3X
         8ZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757684090; x=1758288890;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMoRsZDotQQreQCt//iZViK8n2fFjlTpFk9lhVbhMl8=;
        b=W2j8QxERh0CZ5S6zptZUXMFhh1yDtZqBMZ3kdTdgeeTSIYBf5q/gALOEuJB4THZtEJ
         HgrW1J3tk+EaQjCXPN7KrzZpDUFvZHbxMkl4QOHveg4cw9cnuHrQJAYCADT0Rx0i/19L
         aydvqndDGSPn3VoADEoinVnHIg2CuEPvOcs5Wvg6g/6p9EQdd6V55hjUc4Kwdys5OU87
         brlIUhcAg4+fywAul7gat1ZZcnAeRYOtSnNaKANd99t8Daqg23rb8MdSpv5b3mMh3cbv
         ohF25LG9664EqcA3yLRVCfYgg013WA/ZiK17aFbKlzqp6JNzCK4CiAjPc/mF0ecfo7ZI
         YmLg==
X-Forwarded-Encrypted: i=1; AJvYcCWhGiwnO9wIr1kzN7f/jpGyCpSqLO9CvzLtQ0LVwhdU1KfmoFLxEaZG7Jiq9x3S4jNmUEAAuDyYdB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoQPOJ+pcyE7J5dwdVN1lUx/cTAZjM69GDwd/cmBF9g7OPUS/k
	Kc1c/aKAjABU92eYjPngx8V+e3MRDWZioDXKPb6Y7akjx2j4V5FMUp/n5I7VMVsZCJDR14lXq+/
	e3z3RrwU2ljUOZRKBEUgR87cKKTFzkDR4Vb84ZUbIdw==
X-Gm-Gg: ASbGncuLJI9BZTLX8viWDQ0pwWj7wnMG4kpVh2/i4P9yW3co+BvUXDn0s2XRbq8iArI
	v5yX43bet2DiIFj2SlEBk2SjN85Qr3vMkIiwYIWaxoNX1ESt2tHpbcTw8m5Er1xIxQxYhV+gIdu
	gZ9CWDxLk+vCGmbwGJXy/B+1EK3G81YAyWuXBe6v1SybKVDODEvMf9vU3/7fSf01/ZumbiO8fy9
	cH+W+Cl6tBCBpE1YuE=
X-Google-Smtp-Source: AGHT+IFVbjGOXpmv9Rz9ElJzGIgUxQm7xkANKyEMh4qj/MGGZlpYVw7OzTsjt8Ypn7pFOkm0TZmE85K/yB72VFG+JCw=
X-Received: by 2002:a05:6902:1444:b0:e95:1a49:9735 with SMTP id
 3f1490d57ef6-ea3d9c74780mr2633370276.43.1757684089646; Fri, 12 Sep 2025
 06:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8b73e2071a1d87c8d09b8bb24fc35f371779c2f3.1757000061.git.geert+renesas@glider.be>
In-Reply-To: <8b73e2071a1d87c8d09b8bb24fc35f371779c2f3.1757000061.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 12 Sep 2025 15:34:13 +0200
X-Gm-Features: AS18NWC65p2KribxIbig11q4x3BqzMOY-lu0OzXE__g-0uWV0PjaqNrYbfkqnZg
Message-ID: <CAPDyKFpRbeWWjba_uVQzjEARPvQUBpoqPiAnSz7b96S_ET_zgQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sh_mmcif: Remove dummy PM resume callback
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Sept 2025 at 17:35, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Unassigned system sleep callbacks were always treated the same as dummy
> callbacks that just return zero.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sh_mmcif.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 413c34585c90d57b..bf899c8e38f517d3 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1579,12 +1579,7 @@ static int sh_mmcif_suspend(struct device *dev)
>         return 0;
>  }
>
> -static int sh_mmcif_resume(struct device *dev)
> -{
> -       return 0;
> -}
> -
> -static DEFINE_SIMPLE_DEV_PM_OPS(sh_mmcif_dev_pm_ops, sh_mmcif_suspend, sh_mmcif_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(sh_mmcif_dev_pm_ops, sh_mmcif_suspend, NULL);
>
>  static struct platform_driver sh_mmcif_driver = {
>         .probe          = sh_mmcif_probe,
> --
> 2.43.0
>
