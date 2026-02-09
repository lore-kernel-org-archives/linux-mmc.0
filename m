Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327D0366049
	for <linux-mmc@vger.kernel.org>; Mon,  9 Feb 2026 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770631069; cv=pass; b=ixb5czFBrKPohi3rQEkZybRzQoF4St3hGElfo+WuvysIoxZ52DQW79UBOb6+xK4d60ydt9G0fmXG+V9CLzjapcLSY3SaoKnHiN3iafBO5NM4uiHOB2QYxxxSEPfkpCQArAPY/0AcvRQU637QJ5V8aCfOe5hvNtwzAiPnzNwClcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770631069; c=relaxed/simple;
	bh=bC10K83OlDdfvr2htwpjLlKwvpR995Jtaa8b2VaNWRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjUke2LAvMPXZjEUzngqXNcMYZOlbM1hl/V7uP1czWy1fz5bKdO0ovQacjfUN9CEctxLAySjqDXhf2TzcKLqGrd8x1A+ias3v7mpwj4CU10oUbhvrqpfKOtqagRPr2TwwfAMmq9vGUiy2g3YFA0iDFp8EUIznuFQdfq6cORjSeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IHe4hmOl; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IHe4hmOl"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59deec3d8dcso3874600e87.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Feb 2026 01:57:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770631065; cv=none;
        d=google.com; s=arc-20240605;
        b=KSo5c7WvLhiQ/pp4CzMfaXi1Hk+6atqmvxxZxAq/OealF3Wrki97Jxh/cFgrKtAUO9
         HAEuMarHRSMWouaAPCmIKw7zwvEUtf40huiD2oTG03E0YQS6CW8IyW27JcZfqwXwekbV
         7jBD38X1sUGZhlC8TDxOFvOJTaKM9ceGjroU7ikbvieUmRBw4yUkT3vcSAnwOSlI0N64
         uhHC5gphvh+/bHLDCzbYglOuW3QCVnVokmsNafEA4Ll6EQIPWyEF8zqXz7iYrL3kzshz
         S/OnAIwKAfnhmauzlcdnlynW9//AldaBwyZIyzT2ZhggQFf4URYg5tHskWX2XPA1M2YD
         b8OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fzG/baFh/xjTaP0Ii0cvwWmrEVxPL+eR3yu7Xbk6kuo=;
        fh=qWNvhqkxSwySGiWY4jW0Vc3VbvegH7VL2ZPWLUsa9Wc=;
        b=SXvAfHQe05+17fpq8AVe5jZzWV/b7AvPiwmrgFSlHBzcuGaKxe4dgeVL0E459Zz1pF
         Zv3ORGm7e6JUCf4yvE2e5wKrF1BwiQ7OqnmMMCbJatF8Z5h5noklLDQC/OS85HtZW+Ke
         z0lzfAfsKgM6IJwg5ThLxDB4cJNR/Jhx9fOyyVAo6e+OJ6K6YmV/XLgXgDDgowFK2036
         Mo1IVPG5sNTG/fUI70QTnKKnEqYb9R0C/tY4H9jujJZ27WYh3VQUEPTq+clDG9pPk6uN
         ArsnpG0cQxf2TGwqDE8l7PXn61RWqA1kpFf5zTddTdZ/gId29F6WUYX6oYqz+eYvP6pi
         mrfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770631065; x=1771235865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fzG/baFh/xjTaP0Ii0cvwWmrEVxPL+eR3yu7Xbk6kuo=;
        b=IHe4hmOl9w7pUpUQyLkq/OgztYofxuV5/j5kZqVf8IuLW8jsfSkKju7oFLOuFmO+Ok
         OuFB7tI5XhFwXmudwca2G0nYRBQ7eEr59JH2p9nQqOTDdW7Y2gLLMsCnKuWV4LpK8sMg
         QEhJgWugZkGH8AlPG3KIjl+KmD0zJUnuheHF85f1h7T24sKIswi0tGubJyQrgfXVOHcH
         068szk1RA7QB0OCEWzd4kP3VEp4dtKPFLkidYA4mXBpOOysC+6s4HXG+8zne7P8+mUJC
         0JfCkcMfokYv8neInNUS7ZSf0KHQvK4NmCQEumO+4rTfN36qUquObsdAu9osKWCZSwzx
         gwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770631065; x=1771235865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzG/baFh/xjTaP0Ii0cvwWmrEVxPL+eR3yu7Xbk6kuo=;
        b=uKvB9pFrl7jnjN5XjVsYqVbAxsyiaftWgM88fcz3YuJIXB5SFWqyLA6/KSYm+J4459
         2vL7Hyg6pO50u4ClhnNB8juvI/KFzLyoS8+7DbatiCaJAW4bhDLbU1WZW9ce5cNz/oyL
         xiVzCSuwVqs9xHMRpZxbBpHBh4QX5ZtdxOlI5eU6CvLfVoSiZbuhucDVqB/p0G/TFfmj
         nxOQUwKM0OXK9jgW5/NbVRRqzPsljPa+P/ev1PmI7fnZSfY7xnKc2KBhA3tPBt9KTt+h
         8M8Xdk5hn5FBA4s1cqSDGRwtDlV+YOoOtgcTh994e8ZOzEZyVP4mheacI52NuVSl0nQB
         OwYA==
X-Forwarded-Encrypted: i=1; AJvYcCWSaNbTQZdnGFZQXV2NKgo4aqhP20f/Sr/5llHrEaCi639X/SG9MMe570EmcPAKICI2oClj2Ate+6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIS1SpMxRaT03zXMD5MAGClgMc45MnZ3qy3MdRuQ4uvGybwUl8
	gaR+vlWdOCtxh0xCiZ/rlOsp5SjkuTtOpXtSlSReS+qB9jg4xV0uMEfNVM0t08bifVYmK7lt9uN
	mt7m8D5NmyOrWhwzhO9QWlAItf06yO0jXD8W5/Trb6Q==
X-Gm-Gg: AZuq6aJ9l2efhPGJPDqI6IFNZt6bYne5uvWWoIN33FaWMlJeO8OT3KchSBJYbzz8EmE
	VE7A37WTzakBVzEO/7Xey+IR9hyNMAdRH1cxit+yC/B2qFSXu+tawdi2ofE9zdp1sOco0dTjObI
	3/Q7iE7OmshqAbmCgV6ZCc0Mx1+xneK3AYTkgQAHlsTtJVj4lM1bi0Sriz/OQJUtaZbt2Xdobde
	iX/C/HWecq9TnS6gGugFa10OzNG88GraTkmhw1TL7w1fpTsxdDBjUnFN4Y9PaPjjbTgmxV+
X-Received: by 2002:a05:6512:230e:b0:59e:25a7:e46e with SMTP id
 2adb3069b0e04-59e4517351bmr3165761e87.36.1770631065180; Mon, 09 Feb 2026
 01:57:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
In-Reply-To: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Feb 2026 10:57:09 +0100
X-Gm-Features: AZwV_QjtuvXehDumL81rfo3XecEhBGMIVZdeTW9qGb9n_Rk2fTCxSh0YYaQSYSY
Message-ID: <CAPDyKFpbpcg3ei51hEcG5FzJL7tK44PdBcMbxfOdON7ozxP2Xg@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Feb 2026 at 16:39, Josua Mayer <josua@solid-run.com> wrote:
>
> Some Renesas SoC based boards mux SD and eMMC on a single sdio
> controller, exposing user control by dip switch and software control by
> gpio.
>
> Purpose is to simplify development and provisioning by selecting boot
> media at power-on, and again before starting linux.
>
> Add binding and driver support for linking a (gpio) mux to renesas sdio
> controller.
>
> Introduce generic helper functions for getting managed and selected
> mux-state objects, and switch i2c-omap and phy-can-transceiver drivers.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
> Changes in v9:
> - compile-tested on x86 with MULTIPLEXER=m/y/unset.
> - fixed Kconfig changes so that CONFIG_MULTIPLEXER can be selected.
>   through menuconfig / .config as intended.
> - updated trailers
> - document null return value for mux_control_get_optional.
> - fix build error for CONFIG_MULTIPLEXER=m, found with x86_64
>   allmodconfig: replaced ifdef ... with if IS_ENABLED(...).
>   (Reported-by: Mark Brown <broonie@kernel.org>)
> - Link to v8: https://lore.kernel.org/r/20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com

[...]

I have already applied for v8 and it's going to be in my pull-request
for v7.0 in a few hours.

Please send incremental fixes on top instead of a new version of the
series, then I can pick them as fixes for v7.0.

Kind regards
Uffe
