Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118F71AB532
	for <linux-mmc@vger.kernel.org>; Wed, 28 Aug 2024 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724857907; cv=none; b=YbPosgb8D6NODRBq4qJj7YpP1Khr0Hf+WPOHkZY1AlSvsTlcP28lkeXQjBiZFgEEZ1T5ZFJKNE0YuDS8q7ZwJbUGzi1aXcIknNXzhtPZEtXf47CcNZOX4UTD515DL8dlQ2hw0xzGz5und4hBefemhRP6u2o74lD9/X/DePu4onM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724857907; c=relaxed/simple;
	bh=QpYhBzV+yaoDBMQ/fcOQAAYHC+gX2LXKD1fp6vi2ZHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kh6UaMu5PzngoCDbLgjFnTcXcYVbMfk1ANb1EwT2Y/zc0OIIwvHsVXTzr9NRe6IoiX7kP8+q7sWZpX8UX4P9UPfTm5Ytou8Oedj3OUNW6L/72tDsSsJzHBc/TANo6icNCNvhRVrbtSboCPpvgypyppAw+ZcPcvFVjT2gShpAVmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=meTAqnNk; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="meTAqnNk"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e13e11b23faso6813702276.3
        for <linux-mmc@vger.kernel.org>; Wed, 28 Aug 2024 08:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724857905; x=1725462705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dpwE48l/IMh8SOpKCeyLL7/+QtmITVgAbzW4ivc7bD4=;
        b=meTAqnNkRGepbBwLFrXocK+AsCzDenOFcmh8Cdie03n5XkbyRiwvjbW++N2zEnE1xO
         UhnUvIBBC3uzzk6jqdAwFIg/QAYFLNe435SmdOSh9F56/NhUua4QgL/dYzlTpNQFH/TD
         b3PEpLytTLfSPVrAWkdsMKDmRWHzALrgef6Tyk0EI21QpConft3WRGczAdDd44S5G5UB
         aoSA7L81+Dzx5riHz3+ZRFmLRPk3bTlyW+LXyZtRghnYAr9z3r4CKNLEBVNLXswhjG9+
         WEhM+D1ULv2H5in7uXgcMDnk/nh/gJKbZvHGZ5TJBPZiXkb+truPZ06qwJanTFwsYanw
         Ofqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724857905; x=1725462705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpwE48l/IMh8SOpKCeyLL7/+QtmITVgAbzW4ivc7bD4=;
        b=qSB4OOLiwIuwcLtpxtmjMrOcIMxOMo4LnMlXPMNiov0ae0zWCGYRhqRa6aMlXJheNw
         fBMoiUHBhjS5LlFruHJTkb8Pa1XEgwpdlme3/2pm2QcIEAwox9eTLp1z/HDLUT+bYYbM
         IkC57R0TaOlohWYG1gWh+mWwDg4msl9Jq3/VWoecql/QZgR9Mctdy3EXOUB+TnH0aED8
         RVKI3nTem4lPh0PCkEfcPXubRkx1Ds3NZjc4mGhjfEw6FeHan2ifQY2ho4qZKGuRwE3D
         +IYDxpMyc2YWtpfXg3BUgk8QXBsMIjhJRoit2A33ewfdaejGZeudiGQgGE5Ts5PhHmb4
         5jfw==
X-Forwarded-Encrypted: i=1; AJvYcCWT64unKkr/YMNGxMDTFiZsYaeqXxLR+X1Di9B4bZN5bhbFN/tTk8rwQxZEXors+kyoBPKU0uhNOD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhlasZusupXf8k2/jLsf80xhTlwyoum8JVrfxpdRrluCNm49af
	/FUvadx5eFoDHXHzYzq6eBj0dFodwEf7d6R05t+Ql7Qh6BaOcZ3lCm6Td4R7n4rvx9O9kpex1oC
	pvAXx1mzQ47LtzNtCHX2/tKDHykh9Gc4FD/2tcw==
X-Google-Smtp-Source: AGHT+IE7CB9ls1GFKOjrUzbw5hOqUHyf+hifGdDexmkraaeqpfoek/di3j2sJAd4cp3CeBhWE+mU/vMmQSms6tlNdzU=
X-Received: by 2002:a05:6902:1683:b0:e0b:3c9d:12bb with SMTP id
 3f1490d57ef6-e17a83bcb51mr19054563276.12.1724857905103; Wed, 28 Aug 2024
 08:11:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827074857.2671808-1-xirui.zhang@vivo.com>
In-Reply-To: <20240827074857.2671808-1-xirui.zhang@vivo.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Aug 2024 17:11:08 +0200
Message-ID: <CAPDyKFrN9L+u_X7Ur+j--i-tewd31EXzwCojOP+Sxuyxpk4Phg@mail.gmail.com>
Subject: Re: [PATCH 0/9] mmc: convert to devm_clk_get_enabled() API
To: zhangxirui <xirui.zhang@vivo.com>
Cc: Robert Richter <rric@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Nicolas Pitre <nico@fluxnic.net>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Taichi Sugaya <sugaya.taichi@socionext.com>, Takao Orito <orito.takao@socionext.com>, 
	Michal Simek <michal.simek@amd.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Aug 2024 at 09:34, zhangxirui <xirui.zhang@vivo.com> wrote:
>
> This series use devm_clk_get_enabled() to simplify code
> and avoids the calls to clk_disable_unprepare()

I agree that it simplifies code - but it also changes the behaviour,
in which order clocks are getting unprepared/disabled during the
->remove() phase. In other words, this needs to be thoroughly tested
and not just considered as a trivial cleanup series.

For example, if there is a PM domain attached to the mmc host device,
is it really okay to allow powering-off the PM domain before the
clocks are being gated? This could potentially happen if we apply the
$subject series.

Kind regards
Uffe

>
> zhangxirui (9):
>   mmc: cavium-thunderx: Use devm_clk_get_enabled() helpers
>   mmc: davinci_mmc: Use devm_clk_get_enabled() helpers
>   mmc: dw_mmc-hi3798cv200: Use devm_clk_get_enabled() helpers
>   mmc: mvsdio: Use devm_clk_get_enabled() helpers
>   mmc: mxcmmc: Use devm_clk_get_enabled() helpers
>   mmc: mxs-mmc: Use devm_clk_get_enabled() helpers
>   mmc: sdhci: milbeaut: Use devm_clk_get_enabled() helpers
>   mmc: sdhci-of-arasan: Use devm_clk_get_enabled() helpers
>   mmc: sdhci_f_sdh30: Use devm_clk_get_enabled() helpers
>
>  drivers/mmc/host/cavium-thunderx.c    |  7 +-----
>  drivers/mmc/host/davinci_mmc.c        |  8 +-----
>  drivers/mmc/host/dw_mmc-hi3798cv200.c | 28 +++------------------
>  drivers/mmc/host/mvsdio.c             | 13 +++-------
>  drivers/mmc/host/mxcmmc.c             | 25 +++----------------
>  drivers/mmc/host/mxs-mmc.c            | 13 +++-------
>  drivers/mmc/host/sdhci-milbeaut.c     | 25 +++----------------
>  drivers/mmc/host/sdhci-of-arasan.c    | 31 ++++-------------------
>  drivers/mmc/host/sdhci_f_sdh30.c      | 36 ++++++++-------------------
>  9 files changed, 35 insertions(+), 151 deletions(-)
>
> --
> 2.25.1
>
