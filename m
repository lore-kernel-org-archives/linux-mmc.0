Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5DE204F8D
	for <linux-mmc@vger.kernel.org>; Mon,  2 Dec 2024 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153039; cv=none; b=FZ15Yk5UsD7p98HheYfHE9Scix44oI0p75AInV0LsmKm+5V/8wWmZu04t8y3yMs6mMAetxBOd3mJORRFIZy+JdSR0c2OHgO8tbkc+foAJZZQ6mk0TmWy/F6SaXTybGK1RJXSs8HjrD10ng1B2+n2ZJPp6o15hOjXJh4Fsq0pkuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153039; c=relaxed/simple;
	bh=6CC15jbxUDlJ9BurmHxAUR/muMmumb2p41Z0I6IvNpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZ7ZGbXYUjsxKoXHDjJcKv2Hp21Yh8LyeQI41wt29JYbdJ4o9pWYw1ITqBpYcikNE54hqBu4qENPTrsUOftnJ/+pSCG6S+BPNqh8BLzvqO3BHt4NhUjno9BPL47sJp1wY0Ul8jWosm9+qaQfblhyO+dKj8Dn/OLSfen7ZUaZ7Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ARa3G55m; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ARa3G55m"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e399f8bb391so1470651276.2
        for <linux-mmc@vger.kernel.org>; Mon, 02 Dec 2024 07:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733153037; x=1733757837; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oG32m3QcvgKOONQzZS2q59D3/5WzjOGf+ILtQyx9xHM=;
        b=ARa3G55mkgUG2shyKe2o2t3hqlgzSpLy5zPhGofEcbMgx2TVgZHHI7TlCnxTYrtyo+
         b8mZqJJepjlla+PETl2X65kYRCgV8l2BTBp0U61LSC4d+F9+zN5Qjn35i2LTKcRn3e/h
         4LpdTpiwHarvWTgFlKVBe+yCB1Y1yLitOrqb9d5iUmpVxkreu81CB8i/YMOq25HbDPLk
         JEQsKln2NINOIKoFEn+uBn51qeidiTmnSznqljrKFVEQJKEAbNt8PMtrzIlY7XzyCzwn
         E0DLCT48rLfKCWeLM04DckrgnxKaDsfOh/t7cxp+0Zm2CPSwDc1NO0br21zjYS0eWrZY
         e0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733153037; x=1733757837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oG32m3QcvgKOONQzZS2q59D3/5WzjOGf+ILtQyx9xHM=;
        b=OcvKfX5rwRaCvYcMN2ZU4AMgN+s4gkV291hc9+E486x+15xjEOQh6wHrLptj7M6qL3
         bZlVBVOQVgVCjWF78HNsmFRSyI/l+ewEjSx8j0mySpYlbtr8dEOOb63jNcn2RB4Hkpw+
         E2OiZT35+5CjkbiKzk/YefLw4Pn3kUJwUZ+X4j1dkfFJXq5HHvovNEpHueK9uh1goTPp
         5/hXAnq4fJKC+8m7u1BlritZLb48CbAmnYQ70DpJzu17upanTJ6ZFPW9ZRPJq2xgB2R3
         EHjotwV2jXuHxnm/ACdqwVCni+Yz9dqXYf6yIni6xwXTgwNBvc0qveAM7fJiO1BxPXls
         aVLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqnLxM9w/mGTKTIB/A893cnvJjH7RHN7OmlGgY3+0NxI3KUL+Yma3nh6y0/oOmwmHn02o/wsc0hV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpk3+V/9uLfIcgreFzyigINuNgCcYVVDOINQc4LKXvp5dszA3y
	C6apCykPqOlmuRszlRpTi2Su0C3am69U4TGRlmTB4wKEY+UPWvkhqoP67vJO6Axr28P4b3C47bs
	HZa02n0A4x4Xa14El/n+VLe0hQcB0kZCKjKy2gQyjGhFGIYSr
X-Gm-Gg: ASbGncszvRNPC9flmgwGU+GLct9PjgjT4r4vkL1pM1do5qNEUHyxIe0n+MTjH49xt+y
	EYi3+7G6x7QWflTBET+M6tK/RHD1fdgWh
X-Google-Smtp-Source: AGHT+IFQBDwWAOqdm0DGv13abYWV94NvjZx0NJ/YgMvqSE6QXGn8i8KFJNAFWT/Bxo1k6U4xwUpR7PjVN/gwuOd9+/Q=
X-Received: by 2002:a05:6902:2e0d:b0:e39:453c:b081 with SMTP id
 3f1490d57ef6-e395b9360e8mr19394616276.41.1733153036741; Mon, 02 Dec 2024
 07:23:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1732268242-72799-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1732268242-72799-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Dec 2024 16:23:21 +0100
Message-ID: <CAPDyKFpyxxpCaNcJuTJ9MnnHU1VXDz3hsCoP4=5nkzdVVFCqsg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: sdio: Respect quirk_max_rate for non-UHS mode
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: YiFeng Zhao <zyf@rock-chips.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Nov 2024 at 10:37, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> The same limitation was done in UHS mode, so fix it in
> non-UHS mode.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied for next, thanks!

I took the liberty of clarifying the commit message a bit, please let
me know if my change doesn't make sense to you!

Kind regards
Uffe


> ---
>
>  drivers/mmc/core/sdio.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 4fb247f..b31ca2b 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -458,6 +458,8 @@ static unsigned mmc_sdio_get_max_clock(struct mmc_card *card)
>         if (mmc_card_sd_combo(card))
>                 max_dtr = min(max_dtr, mmc_sd_get_max_clock(card));
>
> +       max_dtr = min_not_zero(max_dtr, card->quirk_max_rate);
> +
>         return max_dtr;
>  }
>
> --
> 2.7.4
>
