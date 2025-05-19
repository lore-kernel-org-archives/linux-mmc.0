Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C641C5D59
	for <linux-mmc@vger.kernel.org>; Mon, 19 May 2025 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747652642; cv=none; b=uYmqkGtCmlVOCBHSYTHRcn87AIrMwa9dwC+QxRqtNZRU3oVm0nbQJH8YpBUVFgLMrvJmcLgy1UdrpiR0keWv86TU73JI9yf7mgGWAwXtQY0SLn0ReRtzPAX3zwvhfcz80IxmzichUrUgJmxPEECJdSmz+eYcdl5uH2BDWTqxWxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747652642; c=relaxed/simple;
	bh=1RBzsBUZFE4oAcdXsB1WfJqMcomnc+3kLNPimm2/Js0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8WlGyg2siZU1GMv4lT0hYbMDSnVgxH0JWTJ3rPyMJMRPJkAeT35yO0mUaShNn43M67A49wt1cqfIEkl8VPC8nacdUl8Bpi2hbwhsSHC0wZd9c+9mqz1ChkQnLb0b8T/VD8TvMfp6GmLjrDysKU/NTPLRKkBBwyYe6aN4XB0tF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rr8LjH/g; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rr8LjH/g"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-70b50e0566fso38390917b3.0
        for <linux-mmc@vger.kernel.org>; Mon, 19 May 2025 04:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747652638; x=1748257438; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m2xHnKKd+aDHtHX8yu3cDHfKWt8EXdtJaGR+RnU/oP8=;
        b=rr8LjH/gG4slvKuc0V76sG5OVPs0h3bjANayyI78wvCtvXieViWL/2vgvQSJDSNDlQ
         qmBO6+5FsWPwfCV6tX1LWzDY/EvW5mpCHC3348LCPbhPnKa3LfmGZ6QYBcFqQS8KMx2/
         pfszTrEE/qsvmpMAB3BNTtf77f5mT2sDhInafL/jczjbyrgaBViY5vRVN54kgvkIV0Gn
         m4P1SAkijwOt3ijVO5pWvVRHYYSqgmrjF4vVpd2+Lb9d5ayVuCbgrOcdI1SypE5Qwd5Q
         xCk4LTj4syBZG9AegaylZQgzG0oE1uz+lJksuG2Sh6OTdTIPpXVjvDMyXmrCpH1B8sqL
         U7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747652638; x=1748257438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m2xHnKKd+aDHtHX8yu3cDHfKWt8EXdtJaGR+RnU/oP8=;
        b=nzcpzI46UDY551fK5O13cVIpkUqckVl2KkSoOo2aJ+qlyxH4R6KQTy+PsIUCHmYLmo
         nP5Z5TYrkX5QjFeXcHayv9v1R5rSUByVxhsWR1GVZmqeA8OFm1imSTq820PJgar7c/lP
         RIlNUhGPm/tZkjNBUpYKMU3mNvLu13ojmeYHJgWqhI3aRAV4qSc/nYGqEevR98fL6Yi5
         +HdnUrlrd/UCEFOnRyytwiozOLGVQ2Zc/6i45YfSIh4PACS3al/XDLkRfcVKR4Qf1uTp
         fVP0fl/maxMuTVekZPkSQMmeT63OSYnRpNZ8fbe777VXyG300Fc8gcNoafngSbWMXnAa
         u/1w==
X-Forwarded-Encrypted: i=1; AJvYcCVKDyrt7RsWTDaRiVkzWETVDviBYx3sYo1dFuzwT055XiPt3L2ZIDqAqrem9WCzxuRdB1ScvnVFhqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy0phuUqHgb3k5enCTVPq6/ITBjCulebl0w6nzPCPk2MTB1JTR
	Wo/OLu3UxtzQE7vSFoarEIKpU1Vt78V+xHYRmNxOG3YWqjdTjgQ6LcHIX6Yz/eASyIVXMeystit
	0DyvLTO37wwarYeIZ/xE21GZPjP8j1MN063zRb+RGEQ==
X-Gm-Gg: ASbGnct6A8K2Jug+yYfGLBQCxOXaRmZaSUdkC6/H4X5pn18l8F+RSi/GpsLy/w/l1p5
	AJY5mBXBritBfiXVLlYuJuVipxCVTvurvNY+qoyE7CgM2MizIUBjoD5hUoObtaLMLpjRSpw9fMK
	aqS69lwurMzFR7DvlmAcK5wF/6RebyFyZ8GA==
X-Google-Smtp-Source: AGHT+IFBUb2/Xms/raeEGwi+8becFxoSstWr/BLkHMpPNO+AziHGedBdCZ+gSklzRXJEASSnQ0GOSObcwPcchKsfqNQ=
X-Received: by 2002:a05:6902:170a:b0:e7b:6893:d5ec with SMTP id
 3f1490d57ef6-e7b6d40269emr15160872276.20.1747652638618; Mon, 19 May 2025
 04:03:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1746581751.git.zhoubinbin@loongson.cn> <1308b6ca9ffc2674cc0f089cfd163da87e53a8cd.1746581751.git.zhoubinbin@loongson.cn>
In-Reply-To: <1308b6ca9ffc2674cc0f089cfd163da87e53a8cd.1746581751.git.zhoubinbin@loongson.cn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 19 May 2025 13:03:22 +0200
X-Gm-Features: AX0GCFtVcITX1kDzetWV6A9kXMJvvFjktirKyT439flna1xTvzKDXV6wLcfl6Dc
Message-ID: <CAPDyKFouNpdnQSXBxRmKhECyojrT_TkCpgg01GHbzQpuYFvEZg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mmc: loongson2: Add Loongson-2K SD/SDIO controller driver
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 May 2025 at 09:28, Binbin Zhou <zhoubinbin@loongson.cn> wrote:
>
> The MMC controllers on the Loongson-2K series CPUs are similar,
> except for the interface characteristics and the use of DMA controllers.
>
> This patch describes the MMC controllers on the Loongson-2K0500/2K1000,
> with the distinguishing feature being the use of an externally shared
> APBDMA engine.
>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>

[...]

> +
> +static void loongson2_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +       struct loongson2_mmc_host *host = mmc_priv(mmc);

As we now have support for regulators, we should use them here too.

Some something along the lines of this at MMC_POWER_OFF:
if (!IS_ERR(mmc->supply.vmmc))
      mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);

and at MMC_POWER_UP:
if (!IS_ERR(mmc->supply.vmmc))
      mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);

> +
> +       switch (ios->power_mode) {
> +       case MMC_POWER_ON:

Is the fallthrough really what we want here?

MMC_POWER_ON is used quite frequently when changing various ios
settings when the core calls mmc_set_ios(). MMC_POWER_UP is set only
once in mmc_power_up().

> +       case MMC_POWER_UP:
> +               regmap_write(host->regmap, LOONGSON2_MMC_REG_CTL, LOONGSON2_MMC_CTL_RESET);
> +               mdelay(10);
> +               regmap_write(host->regmap, LOONGSON2_MMC_REG_CTL, LOONGSON2_MMC_CTL_EXTCLK);
> +               regmap_write(host->regmap, LOONGSON2_MMC_REG_INT, LOONGSON2_MMC_IEN_ALL);
> +               regmap_write(host->regmap, LOONGSON2_MMC_REG_IEN, LOONGSON2_MMC_INT_CLEAR);
> +               break;
> +       case MMC_POWER_OFF:
> +               regmap_update_bits(host->regmap, LOONGSON2_MMC_REG_CTL,
> +                                  LOONGSON2_MMC_CTL_RESET, LOONGSON2_MMC_CTL_RESET);
> +               return;
> +       default:
> +               return;
> +       }
> +
> +       loongson2_mmc_set_clk(host, ios);
> +
> +       host->bus_width = ios->bus_width;
> +}
> +

[...]

> +
> +static void loongson2_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
> +{
> +       struct loongson2_mmc_host *host = mmc_priv(mmc);
> +
> +       regmap_update_bits(host->regmap, LOONGSON2_MMC_REG_IEN,
> +                          LOONGSON2_MMC_INT_SDIOIRQ, enable);
> +}
> +
> +static struct mmc_host_ops loongson2_mmc_ops = {
> +       .request        = loongson2_mmc_request,
> +       .set_ios        = loongson2_mmc_set_ios,
> +       .get_ro         = mmc_gpio_get_ro,
> +       .get_cd         = mmc_gpio_get_cd,
> +       .enable_sdio_irq = loongson2_mmc_enable_sdio_irq,

The ->ack_sdio_irq() callback needs to be implemented too.

Moreover we need to set MMC_CAP2_SDIO_IRQ_NOTHREAD.

[...]

Kind regards
Uffe
