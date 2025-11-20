Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F35C2D2497
	for <linux-mmc@vger.kernel.org>; Thu, 20 Nov 2025 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637085; cv=none; b=vFM1K7v7VHDjUvfo9TO7ci2C0FHlF/2+dTAdPvm2l5Ov/+XxwJfg3VkfvFpJtNf8as9qmta0DtRYDDPFOXGdAaQP5lnY/XP2RIxlelmNvXVuRefExJsdw/6X3MLM5xVWRqMVzKUB/NHnIA4SIpLV9sFONnqawe8v8BquPECAbyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637085; c=relaxed/simple;
	bh=y7ol56IftSllEBNY/Md6pZ6uhuYLxu5beFBFHi7Gfjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWCPoSbM7LCQ4MhEcQAcV67lbOd2j/z/PrsFfV/Gtbb14Zba53lL8DCphTSTzHwh9KaTciI1u44t+dsF0gvPhl00CPzEEFBAt5zvD5lARgg9gie+sUrYM33A9XK10aGOr6ukd9nKvWwqASQMxg9WnW2F072uPe5LCxKQsPzP6WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hXHUY6pf; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hXHUY6pf"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso497740a12.1
        for <linux-mmc@vger.kernel.org>; Thu, 20 Nov 2025 03:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763637081; x=1764241881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u31/0QH+VYzLRhjH+wiRCZt0lwxRpJmNMmNhYCyX2L0=;
        b=hXHUY6pfaUiOu+ULam8wS/2qH6W3CPh4plk5GIotUq3KQeCV4GcJ6AvS0SOoE5HdnE
         K5d4C7tsb3cUyyv/NSnZYAjPLKpZ8mzJAgoOIGlNdk+ZAD2udwSASGUaGaXau3LZDH+r
         doRxB8VC4Jp14HJ9SiMIQeRIGxhw/9iPH2eQIKHj3lx7U2IpTOVcG9TPVa7Jp/tXMkQH
         9j9ndA7BSaZRdOPZz7KNJiMf1gHKaYxvy1xPjcdG0cht3P05VSdbQIGEX+m8ZrmxtCcm
         NYwMe/RqVR3i+bXfxgNZ1bXmNcWMIyhUHPpUVFsvUGObcNnT/hjgVG9SfP99OLss/JfF
         kKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763637081; x=1764241881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u31/0QH+VYzLRhjH+wiRCZt0lwxRpJmNMmNhYCyX2L0=;
        b=S5Pdz4t5V9/lNpb5//T2RTdwlqPLuizrjLTF8mnpJclPka8ZT2gw0Zz890xRADfthY
         3627pUUh3xi78/hG338tpbJ1U9OOmMQqarJwyKxi8m82q/WnQ3x94ttdaFl/3P5aO1lK
         w92Mw3plWI4RIz8/CzsL8eegmVJsN8zeteCy85XnRnVUuaPDjvufeh9K75P68ahyoYzP
         4ODHHlKOxS23iojUDpa9phPjjFN/Z2rtBafE9vPasFXqJB3CoBWQ7kh5nhrjJzLJZpjk
         l/Mbk0tiIV32pe+Nblb/BqD2yHqbeB6SQEA7mNVYR4dBINNnnW2pfqNSMCkJFXnFQHe4
         cvEg==
X-Gm-Message-State: AOJu0Yyajc+sFTGxckzdtyXVADg+AqgbB7YG5pweFd9GznNLRrfRnC6W
	zKmlhMLeI+MsvWewzFNEOphz7UjpkQBbu/sjIGOoYb/Ef6QKeF59R3GtV1ItyRSsi46L3qH6x5Y
	VPzi7Zbh7cOHBa8twm7w7YRRnNtsQq5Fy6f9vYnyGR9JFvDYDGM7x
X-Gm-Gg: ASbGncsS4F6pekhF4r2evOyHxUYaHWmNEUzDFkE2LGgaS4DzUwBkqDSFdZCjbfDXKjT
	UN69uXiNxijLTpdIESe3xw+jVilpDoihKNSaqjqb6M7AhyDpreb4EOhLK7FxlIJmbHs0WnR3LPI
	lOvOfxK5Af5FCaq/j5h9JOEQDQrQWNBx1mPx9YRvzaAVbYqG/LVMit1OX0sW4msUj3Fph0GSC74
	qTcJdOBbFnbkfm2ao02eVTWcSSab3Nd8UTgtvkmflbqIZeU3BbV/aKzEHo5n/T+drrGCP+XB22d
	oPeqkbM=
X-Google-Smtp-Source: AGHT+IFNIVg5tXhend5EclvNIfaxuOJLC+/7TaI1UI1dNiBUO7fFsuG070828+V9hoMjzE6W4fgSyy6gsoNuXvYs1/Y=
X-Received: by 2002:a05:6402:440a:b0:640:b07c:5704 with SMTP id
 4fb4d7f45d1cf-64539696801mr1852341a12.15.1763637081370; Thu, 20 Nov 2025
 03:11:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1763634565-183891-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1763634565-183891-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 20 Nov 2025 12:10:44 +0100
X-Gm-Features: AWmQ_blfx9RIjoT9QAfd7V0qR9cc-Z5kbolm-xnqR2pdcycfzRdqsZ0O_LPpB6I
Message-ID: <CAPDyKFqHM8VvpTVT-iAbPUvo2Q2EHhyZD2xpgWYTt-4oXrucUQ@mail.gmail.com>
Subject: Re: [PATCH 0/13] dw_mmc cleanup
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Nov 2025 at 11:29, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> Hi Ulf & Jaehoon
>
> As you can see, dw_mmc is likely one of the most complex and difficult-to=
-read
> host driver at present. It maintains various states and bottom-half sched=
uling,
> containing a significant amount of redundant code=E2=80=94including a mul=
ti-slot mechanism
> that has been unsupported for over a decade.
>
> Jaehoon attempted to remove cur_slot more than ten years ago, but the dri=
ver still
> retains the slot structure and the associated queue mechanism designed to=
 support
> multiple slots. This has made the already complex code even harder to rea=
d and maintain.
>
> The first four patches aim to eliminate some of the redundant code, while=
 the remaining
> patches are intended to ultimately remove the dw_mci_slot variable. To fa=
cilitate review
> and minimize the risk of regression, each patch is designed to accomplish=
 a single,
> clear objective.
>
> This series have been tested on the RK3588S EVB1 platform.

Thanks for working on this! I had something similar on my todo list
for dw_mmc for years, but never reached to actually work on it.
Anyway, I will review the code shortly.

That said, would it be possible for you to step in and help Jaehoon
with the maintenance going forward?

Kind regards
Uffe

>
>
>
> Shawn Lin (13):
>   mmc: dw_mmc: Remove unused struct dma_pdata
>   mmc: dw_mmc: add dw_mci_prepare_desc() for both of 32bit and 64bit DMA
>   mmc: dw_mmc: Remove vqmmc_enabled from struct dw_mci
>   mmc: dw_mmc: Remove unused header files and keep alphabetical order
>   mmc: dw_mmc: Move struct mmc_host from struct dw_mci_slot to struct
>     dw_mci
>   mmc: dw_mmc: Let glue drivers to use struct dw_mci as possible
>   mmc: dw_mmc: Move flags from struct dw_mci_slot to struct dw_mci
>   mmc: dw_mmc: Remove id from dw_mci_slot
>   mmc: dw_mmc: Remove sdio_id from struct dw_mci_slot
>   mmc: dw_mmc: Move clock rate stuff from struct dw_mci_slot to struct
>     dw_mci
>   mmc: dw_mmc: Remove mrq from struct dw_mci_slot
>   mmc: dw_mmc: Remove queue from dw_mci
>   mmc: dw_mmc: Remove struct dw_mci_slot
>
>  drivers/mmc/host/dw_mmc-exynos.c      |   9 +-
>  drivers/mmc/host/dw_mmc-hi3798cv200.c |   6 +-
>  drivers/mmc/host/dw_mmc-hi3798mv200.c |  17 +-
>  drivers/mmc/host/dw_mmc-k3.c          |  21 +-
>  drivers/mmc/host/dw_mmc-pltfm.c       |   2 +-
>  drivers/mmc/host/dw_mmc-rockchip.c    |   9 +-
>  drivers/mmc/host/dw_mmc-starfive.c    |   5 +-
>  drivers/mmc/host/dw_mmc.c             | 606 ++++++++++++++--------------=
------
>  drivers/mmc/host/dw_mmc.h             |  83 ++---
>  9 files changed, 297 insertions(+), 461 deletions(-)
>
> --
> 2.7.4
>
