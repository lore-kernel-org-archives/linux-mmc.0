Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CEE26B948
	for <linux-mmc@vger.kernel.org>; Wed,  9 Apr 2025 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744204455; cv=none; b=bVCl0Wojid+PV07AmekSOEEx5xELiLGS+jq4/VqPSvpmbuAmKLB490WboQ4vLkWJF4Vu9QLtnxBz/VyO9nFXpBsydeW/LvSIv9Wtmipep9vqjS0H7njX17+uTwjaUsxkzhQuP+67/rFIs8nDGC/Fh7YXAFrBAXklQI0jZHznu40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744204455; c=relaxed/simple;
	bh=qpQ5QMdSS9xVFMmepfnJzb9oRmSWwnJeNbaj8UlqKuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b9n07xegFJkisGVotFktXH+/q9TorWdVnssvmvc7DUgv2EcbxF/Xt8dX2P+OZn+4SwfkslLoCBKwORpPKowHw2nhCKdqwd/5crTTkk+69LPE63vYN8bkKPCpglXkksfomQ7zLOEvyyopHINZGrXbW+hiVF9eQiCMhiEhbI2VOSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G4vKwe2R; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G4vKwe2R"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ff0c9d1761so62553147b3.1
        for <linux-mmc@vger.kernel.org>; Wed, 09 Apr 2025 06:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744204453; x=1744809253; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OPytIAR32acMc1Jy5NAX4zaoua0Um2xWn2RghqT1VbM=;
        b=G4vKwe2R9eMgdqrfbrwlHZqEjcTUJvODM3RyGUFxQbtFd1M/WuIbhPIN7oHuUx51fy
         ZPe5FY6uudFNBV5Wi3ViiKDMU8Y3uX1jGcgsTzpiQeYkc+oWs2Y2yZRINhQGkuh7wOGK
         GT8ti0Q71UafgsTo8lcD5OBL4R19HRnqGcM6Dj92flwS0bOiZXXGJAgzsjGQVIvUGa7f
         sf7zrgTJdfldAKmnY72TigUpwvM13qVYTR6TniIx3UNkVqPbQliUyDk8LQczZFRTuZbD
         pDj1Dxbgc/6267/Jjq09a+hsD9x+Uy4A7swa6XnwM1wLEIiAqunVik/FcuDtdSxcK+9/
         5jQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744204453; x=1744809253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPytIAR32acMc1Jy5NAX4zaoua0Um2xWn2RghqT1VbM=;
        b=LqgDL5HaK0CYMaUaaIInT/7A21imL75zKFKUYjEcDEVhHUOiRnsj0zbPfBMKdXjd9o
         XjQQUcEVBonhbIpRug3Uq+lG8k0T69otpVDz9lI+BW3fluk5nE0cXRnW+rc/f9nKXEA4
         Do/mXztiXadO9w/F2h4px6epmsmUzAY0NFP9MPTAJsSOQxtm3AfTeMijmP1drIZQQBHH
         16yMTqRO91S0s3xNGZRhG7zhbfxhRHuu6OkoPm6s1/R2rqkGi2LqSBfwo6Y5fWTrqFn8
         z747zNxvT8wp5qk7jWVu1JDvgY5m1IDMpS97HQsNSdlhFNBE6QGScwcClkbIRLJsCMkd
         eIwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYiTae4+W310gzzKUCi+aiW+j9/AMKz2EXQi+7k6TZsGhSbd+uUKL502cIjaeeTeXaJuF5akBiMYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWl80ejfY7+28BuZatHpbZb+JXh1GICRSEUeNUh8KqWHTBFAXz
	ZOmkgZ+vhEQ3j0HfLwSmQ5Hk5VM3mEuPIaZhc2p7Z2zKRo2rP4QbP4QNr4qt/n+i1bIsDbokbew
	TI2ht1BQo0hYVzeMlCsptGaGSSKXJO1cGD6GYnQ==
X-Gm-Gg: ASbGnctms5F5qGbHjUAPxm3BZZSBhbJWz/7yYpkFxjVSWlLOcUs75UFn7RSv0IrU+1p
	WI38xLwiWH+btLcMZfY4xihIb9KkPgn+FHKdylHLsEQW/qc6WDmXQz6tskmsNczoPYfO0rJrOr6
	KGEG57nFdNaEG/I6Tj8Ez3g34=
X-Google-Smtp-Source: AGHT+IHEapgN4KpAu2PH+cMh+2Gzlwfzy4KLVKnXkondFCagfktuVPm3ZUGmWpdWktkF6zuY6BhY5v5enEDZADi0x7Q=
X-Received: by 2002:a05:690c:4a04:b0:703:b606:738f with SMTP id
 00721157ae682-70538813013mr54886587b3.9.1744204452852; Wed, 09 Apr 2025
 06:14:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325110701.52623-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250325110701.52623-1-angelogioacchino.delregno@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Apr 2025 15:13:37 +0200
X-Gm-Features: ATxdqUHSGpiXGAwgK7msekj1T4YSrnCc2mkntlahkz6x0Wt2J4BgD7Yq4ISR4rI
Message-ID: <CAPDyKFrR7S23hCbEpwSj93f3ZczkbQAMgpJo1NNsK4bpMr-qnw@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: mtk-sd: Cleanups for register R/W
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chaotian.jing@mediatek.com, matthias.bgg@gmail.com, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	kernel@collabora.com, axe.yang@mediatek.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 12:07, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> This series adds missing register field definitions for the MSDC patch
> bit registers and aggregates various register writes into just one,
> greatly lowering the amount of register reads and writes especially
> during the controller initialization phase, other than the tuning
> phases and set_ios for mclk setting.
>
> While this will have a performance gain, that is completely ignorable,
> hence this series' only focus is a cleanup and an improvement in the
> readability of the register settings (as those now have actual names,
> some documenting, and no magic numbers around).
>
> This series brings no functional differences.
>
> AngeloGioacchino Del Regno (4):
>   mmc: mtk-sd: Clarify patch bit register initialization and layout
>   mmc: mtk-sd: Aggregate writes for MSDC_PATCH_BIT1/2 setup
>   mmc: mtk-sd: Do single write in function msdc_new_tx_setting
>   mmc: mtk-sd: Aggregate R/W for top_base iospace case where possible
>
>  drivers/mmc/host/mtk-sd.c | 207 ++++++++++++++++++++++++--------------
>  1 file changed, 132 insertions(+), 75 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
