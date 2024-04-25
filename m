Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED8714D2A2
	for <linux-mmc@vger.kernel.org>; Thu, 25 Apr 2024 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062144; cv=none; b=BNqZTNiBKi4YfVxEj13tldr1qJ3UW4BTDRFgSqGDnXvquGSh8tc+0sQotB3tzdlIXTOHqSk/hKAtu5U6/DQWgY2juzyQXfB6ZmCbpidjwr/Fh953HXW1i0au+LrGEN4XrY+aR9pbxMOI0FwVQVC2+ZngF7qpu8E6BM1yEf6hWbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062144; c=relaxed/simple;
	bh=+naKcIk5EvH6BPYm2Cjrzgy9Fbzr4w1ZLSAaG7qX8IU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RxffDQcFPn9nPyibFmkB2p2zsb7qsIqWDH37C6Zk90ErH7WARocabY720YhLSSYVngUI59q6MVdv0r5S4KMv2JMcHxPFwVFLqOnMviPCLlLNYkZDp3qDStE+JS3RHlZgGA5ZMhduJbHkTNvcw+C6pWkirennZrqsV5KnEadedR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bUqpvLz9; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bUqpvLz9"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-de45dba15feso1442883276.3
        for <linux-mmc@vger.kernel.org>; Thu, 25 Apr 2024 09:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714062142; x=1714666942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uLxrhcQ9oc44OMZc8b5Iq8eE4NFzuTcQxbVwCcXluvg=;
        b=bUqpvLz9bsxLTCDE07ke0cqh1yMoBKVFRmjI6B69KtshzMntZOfkCc8XGXKwoiwSYn
         KaS5VpDEcM+a9Nx3oBNiooP1EiDj6czchZnSLikZ1N8vmtLBGy9a4cv9H7f1JDeSt/dQ
         KdnrIbvtVfN67jSr4U/LfZHV/QJa6hCAzOAuWu7k4IQiFvEZvmtCs+dlJ8n2RG8G2uBn
         CQzBwUHniIk2ZThuM7MsVUJcRo961kU5acB133pZ3c6jaTsoBPkI+r4ZSZb/GxK8w+15
         wczQ3MnmasOx1mrwhtyz3KC+LS93hgK36dYdi+U8S03T50wzHb1X8clG0x8RIyjexmL7
         dc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714062142; x=1714666942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uLxrhcQ9oc44OMZc8b5Iq8eE4NFzuTcQxbVwCcXluvg=;
        b=MOVGWK4sHkdaXcUVxihEd8fsxoNsSwrPk8LZNMpU0zfhhVWHaJGHVFPVoQ95OTvZqw
         6JXyIqqZwiQRmD46wPtVved/XteU1rbRyd/rR6xcaWithWfOz79NaT7LtmnEQg64I9pj
         b94RWcume2Arh7OHmt8PHMMVhsdQGFkMmsLf4F+yzLGTk4Wnzq1AAH8iPbEulihQ6O6W
         9o6nXAa9DjkqO8o+0IQTQO/Nd5QOKvkDZX3V1/skOiFc1DPF7Vraq7JuQnlmIV/2sIA1
         mpRnjstWIgaw2ngD51k9xAGA+Rt2K7WShzVzzuZu4g9RySSqrG3lQbMNadkjF/PlbWqj
         ls2g==
X-Forwarded-Encrypted: i=1; AJvYcCX6Engcm3KCTNGfwocHFv+5v+CbooSzXYMcvlVI75wa5cLhbJXWHv8BpCj2eW4/TrMrBFMT3/wQwITLzQFKjFHofUu5mGUKf11i
X-Gm-Message-State: AOJu0YzjQo6mTcBbhrl9BqEaMbRUSZNmzXYBEGT9/52fXDtyqKYOiyEF
	X3Y+xT/NOp1xkon2C18ehv5OXe6mX/bMOFa8/X9rBRZ/DxwCwjbmrKOQRyY6B9U6xsrHjG5taOv
	vXRm+1iZ6hQPUdR//LYpfCaR9DaFicpv8lr5z15oBTdhsLvvO
X-Google-Smtp-Source: AGHT+IFtKn6b6GJpNn67zl9+P4j1OLHkcP6FUpJ4JOoi5sUsm1euCeUryXi8PiHOutOriprJEFlsIAFazJXA+fzp6kc=
X-Received: by 2002:a25:bfc8:0:b0:db9:9134:bb28 with SMTP id
 q8-20020a25bfc8000000b00db99134bb28mr137095ybm.4.1714062141958; Thu, 25 Apr
 2024 09:22:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240414-mmc-const-sdhci-ops-v2-0-262f81faadac@kernel.org>
In-Reply-To: <20240414-mmc-const-sdhci-ops-v2-0-262f81faadac@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 25 Apr 2024 18:21:46 +0200
Message-ID: <CAPDyKFoC1fSvWifKtFV9D=hNkGuOL7eVnDdw2ZGVedsYrombdA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mmc: Constify struct sdhci_ops
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Angelo Dureghello <adureghello@baylibre.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 14 Apr 2024 at 16:07, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Hi,
>
> Changes in v2:
> - Patch 5 - sdhci-s3c: add __maybe_unused, reported by kernel test
>   robot.
> - Link to v1: https://lore.kernel.org/r/20240414-mmc-const-sdhci-ops-v1-0-178539d68093@kernel.org
>
> The local struct sdhci_ops can be made const for code safety.
> No dependencies.
>
> Best regards,
> Krzysztof
>
> ---
> Krzysztof Kozlowski (5):
>       mmc: sdhci-esdhc-mcf: Constify struct sdhci_ops
>       mmc: sdhci-omap: Constify struct sdhci_ops
>       mmc: sdhci-sprd: Constify struct sdhci_ops
>       mmc: sdhci_am654: Constify struct sdhci_ops
>       mmc: sdhci-s3c: Choose sdhci_ops based on variant
>
>  drivers/mmc/host/sdhci-esdhc-mcf.c |  2 +-
>  drivers/mmc/host/sdhci-omap.c      |  2 +-
>  drivers/mmc/host/sdhci-s3c.c       | 31 +++++++++++++++++--------------
>  drivers/mmc/host/sdhci-sprd.c      |  2 +-
>  drivers/mmc/host/sdhci_am654.c     |  6 +++---
>  5 files changed, 23 insertions(+), 20 deletions(-)
> ---

Applied for next, thanks!

Kind regards
Uffe
