Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4E9335BAA
	for <linux-mmc@vger.kernel.org>; Mon, 15 Dec 2025 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765813116; cv=none; b=iTMlCV8T6NpT2Giuoa/UiMswQSzZSGgn73NPw53a89RVSz3K32YGnj3YrbOuFVSqmbTjjZgioAT1epnD0zxZZHPbQiORZnYK+lWbw6a3B+X0m6ZWkULoDOt+kxAZXvpAQW6FRVJgQ46p70h6WbK5omGSNl8o2W/LXHNgL/7YQlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765813116; c=relaxed/simple;
	bh=JTYMLvI4lDVZi60pNDdfZc568ZhAd5KMAoHJpV53U7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6YAPWLahJAmPhepudnatporNTdfqHMpzVvnRd19qjX57Px39dW3Jkh9h4HB3/ffUz7/odeloWXIGJpszjgQetuzIsOxc4gAkufKLR92iwhN4OhguIGJ5ZYDpSoaqKQViL2NnAzdzwo3uJ00nNZXECkxYSdyShM5QXJz0872jeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=muNPlqz+; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="muNPlqz+"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-597d57d8bb3so3198709e87.3
        for <linux-mmc@vger.kernel.org>; Mon, 15 Dec 2025 07:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765813110; x=1766417910; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eSwy3gowjltzcyphb4214OlyhjdppYeuXISkRTiuQCs=;
        b=muNPlqz+Zp6dGCpRumonskdMv6nGg7IOd5+jxyihCErumlanwnQ+l183ihvkmaIhLl
         HxckshAp7OhvXYRIJk2TqvA0rddp4qPgh4Bisobub491KrsxaZdlAfxjK2hkUpWrbhX0
         zTg4+eNsggnarpvTsM81IAHFG19z9qjVHzrw6uDQoJY0q6K9ldRPGvObp6eQ8p3uweJR
         R8y0mittmXrEWcy/SH+0tCKmf/uFeNxMR2fkpfFD/hmy/bifKI51yUI3/OQ2JmV0lz0C
         JGRaKpPgAc/S0P9GTCyUZCjPKdkNrD1Vq4Zk9eiNA09DlX6kDddx7MbZurI9vwA1sw7J
         7diQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765813110; x=1766417910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSwy3gowjltzcyphb4214OlyhjdppYeuXISkRTiuQCs=;
        b=tzBPbV8zCeEH5yuGukuXE+btB4ce/mzjsKbCxecdzj/H9X03Pbe3VpsP0YFColqB69
         omRFvusGTEDp9qCbtSM9/IJRhHoZ4/uGmxm1ko2JbWTlBb95w7VDEFMxF+P172hac61c
         UluPK5l+cKVOMnpc+AQhV7vqsM51XV2+tjKG9ey+UR0DonVDTsf1jW+EDSfbPm0xbGj9
         3idv4TRF/sVOqQCHJMfZsAhCi05orTHPJoB+t4gWfj9lo6o6xJfPPakGU2GtUKG4FxOe
         RWvlt1lR5mH8JEHbdTEhz9vPSS2V4Fd5JcqKmgXq4R5Uhj1mFfqkIsOB766ke6pz+OR9
         2Bhw==
X-Forwarded-Encrypted: i=1; AJvYcCVdkvm/nHqikkSw8eqIjgqx9JSKKtGh48lj7gtVS8nbnX9RSIAl5kicf2lxCVkT8FhRdZ85Bt+W11I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqIZL0aklHDXLcKoJvYy1a4u0bSJJ4PiQdhT/n0fbqsXVxSwwW
	jkOXvD8/9/W9ujHL/tHydtkDphC3cCBGV4KvTFDkOD9yi1tRDzW8y10NKsRwem2hbLasaw1F6yI
	ElTeFAlii9nM1fC9nUymuMVGzjqxru8RGYyeblYNZqg==
X-Gm-Gg: AY/fxX7dVQR82NyEunST98aDEob6uLeUuKTjWAtBvMizy+vA212b1xE2oxqzoP/J33v
	ku/P7AIAXE5JMPBwIh+ItW+1agAPakiXfkFGAKdlnn91FEWIVXjAEFriw/qfbORdHZ5HPlEs32M
	+dB+X+M37SsL+OeHQHixmCfN1NUu+qVijQ2sOR1YH+2EkBL/EEsJ759ZdWkJRt6YL6wru08Uq4K
	y6w8bvNDVKcPug/DnLY5Ox2D4l+FpAhiADpmD40f/Rq+7o41PGZ6pr9aAd0ywND0HUbPH24
X-Google-Smtp-Source: AGHT+IFKTvH2UfCK5w9sAwfCQuEQbWmLk1A+0vBn+uZZJXSHxR0e15Tqwz9KJoHJBnQOLz6m42UioL9EMQ8sboz7KhA=
X-Received: by 2002:a05:651c:1a08:b0:37f:c5ca:749a with SMTP id
 38308e7fff4ca-37fd071a3c5mr37413191fa.1.1765813110403; Mon, 15 Dec 2025
 07:38:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215102010.608421-1-ziniu.wang_1@nxp.com>
In-Reply-To: <20251215102010.608421-1-ziniu.wang_1@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 15 Dec 2025 16:37:54 +0100
X-Gm-Features: AQt7F2qN24rvjd1F8j2ygBPZqZUhdStl6C5Dtd7mmY8Ik9glfcE5mBkVsUP7kyE
Message-ID: <CAPDyKFoLmo=qDru67rj63gQwMjLqVKS+wEQecukuC+3Pz_CjDA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Optimize secure erase performance for certain
 Kingston eMMC devices
To: ziniu.wang_1@nxp.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Dec 2025 at 11:18, <ziniu.wang_1@nxp.com> wrote:
>
> From: Luke Wang <ziniu.wang_1@nxp.com>
>
> This patch series optimize secure erase performance for certain Kingston
> eMMC devices (IY2964 and IB2932) that take a fixed ~2 seconds per secure
> erase operation regardless of size.

Well, that sounds to me like the eMMC isn't really erasing the blocks.
I wonder how "secure" this is in practice.

>
> Currently, a 1GB secure erase requires ~300 operations (limited by max
> discard size), taking ~10 minutes. With these changes, the same secure
> erase completes in a single operation, reducing time to just 2 seconds.

Hmm, is the problem really the size or is it the timeout? Why does 300
operations to erase 1GB take ~10 minutes?

Can you please elaborate what happens on the mmc host driver level for
each operation. What mmc host driver/controller is being used? Does it
support MMC_CAP_WAIT_WHILE_BUSY or do we end up polling for
busy-completion in-between each command?

Kind regards
Uffe

>
> ---
> Changes in v2:
> - Rebased on v6.19-rc1 as requested
> - Cover letter: terminology fix (command -> operation)
> ---
>
> Luke Wang (2):
>   block: decouple secure erase size limit from discard size limit
>   mmc: add quirk to optimize certain Kingston eMMC secure erase/trim
>     performance
>
>  block/blk-merge.c         | 9 +++++++--
>  block/blk.h               | 6 +++++-
>  drivers/mmc/core/card.h   | 5 +++++
>  drivers/mmc/core/queue.c  | 9 +++++++--
>  drivers/mmc/core/quirks.h | 9 +++++++++
>  include/linux/mmc/card.h  | 1 +
>  6 files changed, 34 insertions(+), 5 deletions(-)
>
> --
> 2.34.1
>
