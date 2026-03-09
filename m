Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2E42472A5
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068841; cv=pass; b=J/qJ1/Naxmv1aSWgAUMUlAI/d9tUQgw+0/e/frDvEfawRcSuCWs+QwEX+woV0tp/BQX9J8lUITXHnOF17sslsSoAQQhUNEnITTEHEs65kDpvPFlnJkKuOxNyZ3JW6Y0qqwWaXMjUvlveYXx0goKjbG/y1HoYUR1cpS2nWeNhkIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068841; c=relaxed/simple;
	bh=Cxs2ERZHjQZ+6p6FMjxOsQss6Dg8cHnefP+oNerE8mY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2e7CgbdeSkXv6+XlCwJI12KqYrAcs/J72NyRfSwAB5D6alk8ExrIpUJvS+Rhb+S9lc2dd7ymdMVKmuNtGh7U1cKzx6UXMhhNIAajY6VBnJEO6FlalAsG46EvgmGBN2p/9t5aiy1yvQ1Kkwert0JOUGzGNNA1RYhDJnGBRAQvIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TI41UZQI; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TI41UZQI"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59e4989dacdso6180036e87.1
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 08:07:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773068839; cv=none;
        d=google.com; s=arc-20240605;
        b=LHwRW1YSNZnvzdrWXzUgh9MzRM4G1pNqs90LebcBuRTU69RsQhq9RAoKO0006H5K4F
         Mjrgy8A8tRtEv0Rv4+fZvSTub5y3Tp+VPKAmtB4jvsSV+PJmD4owkLZo6yr6ozg6fKMJ
         wuNgKU9/zSkOw/us/U4MzuT5UnaFBzYW/ZTfDCpMIxs4uGnIv/VtCD0Vno4x20fhR7sI
         WoJ4XsGcXGgcG95bpAZqN5+tnI0viOrDpOYIlQAAQdaFdNLXfw/qiavliWG4FvNYk8e1
         ylE1mFmKHD/DlUQhSI55uWlADECfXVjrtZak/Um2d6murBngjnC9vpKqA6t7UoSuFypU
         RTeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ae+1/K9vPqwJidE+KQQvfxmzOSzLAYF6suEiPjDrjR0=;
        fh=HjGsyp5BsslZt7rI031Jn4VcyyCwswDWQhaZ9KIDixY=;
        b=RYsGIxTZSGwHkHEfS6RO42dH9PKlHPGj0q7eYsqHFxhb+c+IIUDxU0+ZTf+n/zkoIB
         1TS8OKJgWFaCtxtZaQxpT8sjdY+fztadZDkfYem5kp2QuDeqW419gx+Peb8qa6fh6/Hy
         8IilkgnMZHI74qbp66JHDtyKhBL1fiCF9W3VHh//7M3NVSGmDncfHaLLBgN6BI3XvCl1
         t4ha/qIVhXOvQCCrWZFb6r1+uhNPmXu1Qr/KVhZvrhrBmEcU4NDRO6RlvhKA9t0gttGC
         mNTv3+yEYVf4vtwmQMavR1aXWyFGLQ3EL1T7HAhgd+Z7ewMslIkjihMlt6QfZ3xSJcaq
         K6vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773068839; x=1773673639; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ae+1/K9vPqwJidE+KQQvfxmzOSzLAYF6suEiPjDrjR0=;
        b=TI41UZQI88u3o8BCLWWsikwxjFQuTTPEhUd2lCQ+rDwAqXVL6yO1PdkAKCcKOaOu5G
         gQjfnpO9yfwwFlfs7389NquK4gqieXQLQDJuKTwMURQlQ9zPDOZxnVD9T0cSCJOqpspc
         ahvx8ywFY+v+AjtwHvT9dYoTUfR4o5kMzmznxKg9+zUmIrkg5RfoNUIhyj9PlwSA6Zq7
         igktHG7IBrdtwB+tQr0rfgLVjdMQVuT7YW469l2nZUtP2E6/L8crwWJCM2hpIPz0ZBB9
         PniX6+G+CkDsWdHmHsKUm431x5uo+juHg/+fzcAO1MvUfNOsmP6rDGe2EbFZw04vG2Q6
         NA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773068839; x=1773673639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ae+1/K9vPqwJidE+KQQvfxmzOSzLAYF6suEiPjDrjR0=;
        b=EF4uIzE9CHGfoVYc573m32+lNTm3fhvF/tz+9nL1muvQ11QXrVEBzE0uJczsE1lIX5
         Ky+qBiGbK2GRpswKNBGN2ZpH2QJIUzkjSdRZNfph7/IUEo9+4b/PO4UIeKGVw0u8d7j4
         0wG8OcPDBADgdbJog5aLZjdX2FM/WJZQWe557eKuHkLhXHf0tTGR5eQjkdK8oI8K90gF
         ked7kGt1GD+weGj4XI1KRH8IHx5h3wkGUaL/JvYDNvMTo9YHuB4Vwldmgxcng1joYhlr
         /+FoRiacl5pw1arW6YusfP+4Mw7PStP2Hu6M9NOK92/buiURL5CfYSFL3rNYV2LlSb+c
         PG8g==
X-Forwarded-Encrypted: i=1; AJvYcCVC2Cr0CdkFi3Vfgqf3H5hpbo926ernFDoVSsrATGRdEE4fn98u30bi0UAE04rXOuBKSbjHdwLC46I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjwGeVWSfB2t8dvvhwqy6ubCXGMKcuz5Ovu92UElLC1xSXh78m
	hviQVFgTEzUe0UCdcqWB+FOUvTCPk3EVxJXaGVfX6P6zJg7Ra/U2g/D6ga56dAMKsGRZzArHyJq
	QSXcdK3CuPVQUslOlvUCs/b0LN7yC85HnJL5KpUtRYafRKNP8yA6Y/B0=
X-Gm-Gg: ATEYQzybRhN/KzdqFAPfZDvQd4tS6HXHOKoMoZBT6hhiryhgbEATo/BO3gQSVG4uTzS
	Es7+++emso2aWVd8eE5KrMyvl0pdSLjXarwjj4kfqXd8uY72BkCqsFA0lqjSYL963+YyXlel9TQ
	iAMuq4iAWZdT6zb4vrygFEiYTTTnwcNQBD3QDofC4ptTi+MNEmpj3ze0npokfRsIvZUMylx4C1E
	2GFhmvcWYn14/NL2oLNcGNnGRi6oCbYXA0YWWYVZcdcqdCB4dTqRMA7Asui0VeuFbkNrrRQIb3/
	JFIMSUq4
X-Received: by 2002:a05:6512:64ab:b0:5a1:29e5:3069 with SMTP id
 2adb3069b0e04-5a13cceb995mr4081032e87.27.1773068838558; Mon, 09 Mar 2026
 08:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305122553.249058-1-thorsten.blum@linux.dev> <20260305122553.249058-2-thorsten.blum@linux.dev>
In-Reply-To: <20260305122553.249058-2-thorsten.blum@linux.dev>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Mar 2026 16:06:42 +0100
X-Gm-Features: AaiRm51wk1QVoAZ9aC_vK1bUUhZ3HHVXUsipfP7h35hPIBfHdk4ai9oFGyXOZ1A
Message-ID: <CAPDyKFpeH_=gLKkr0UFuGtR8BLBw8yRv3avrys4075yS29WoEA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: tifm_sd: Use min3() to simplify tifm_sd_transfer_data()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alex Dubov <oakad@yahoo.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Mar 2026 at 13:26, Thorsten Blum <thorsten.blum@linux.dev> wrote:
>
> Use min3() to simplify tifm_sd_transfer_data().
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/tifm_sd.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
> index 2cd69c9e9571..c1f7d5b37911 100644
> --- a/drivers/mmc/host/tifm_sd.c
> +++ b/drivers/mmc/host/tifm_sd.c
> @@ -193,9 +193,7 @@ static void tifm_sd_transfer_data(struct tifm_sd *host)
>
>                 pg = sg_page(&sg[host->sg_pos]) + (off >> PAGE_SHIFT);
>                 p_off = offset_in_page(off);
> -               p_cnt = PAGE_SIZE - p_off;
> -               p_cnt = min(p_cnt, cnt);
> -               p_cnt = min(p_cnt, t_size);
> +               p_cnt = min3(PAGE_SIZE - p_off, cnt, t_size);
>
>                 if (r_data->flags & MMC_DATA_READ)
>                         tifm_sd_read_fifo(host, pg, p_off, p_cnt);
> --
> Thorsten Blum <thorsten.blum@linux.dev>
> GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4
>
