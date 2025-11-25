Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA5D31D726
	for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764074034; cv=none; b=RtGG8o9eRKeNGqTYN9iMLi5lQpU39ep9EnABPML6pO4ud+XKhcDj3OtwbcbytlOlmdVYZAd/jPYlVOPeZKroTd9XSiczQfYGLMXKjqQAvbkv+ckZztNDOHn1sQs4gRITooOShgtxjWFlWgX/AcucuRv6oNKZcHIfj03/J5KtS3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764074034; c=relaxed/simple;
	bh=thpC3q1hv7PUiqwmDmoSRt8Fre2nOFVs2Oc8hREt7PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYrJ+t6KjHPUeolH0H1bBsBoaMDuzVn9q8rMiiW8PI9bLReKKm2GURbWXe7EwsriE5CTHDEDk7vsqfjI5T3wQR+Y7up+GNfmF0ptiszeKz4eovSq+yVQdNRPkHD568YSL/1+vwvZb5ycCWG/l0QfSAntDp09b9/A88KEEkAbSvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ow0PyVfD; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ow0PyVfD"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-78a76afeff5so51986057b3.0
        for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 04:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764074026; x=1764678826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Y929ZB3hOQ0huOASE4rm5wG5Ne9+DpeH/x0/TVWvO4=;
        b=ow0PyVfDA/gmzKIc+tXK9ZTT0xNx7y12ZjO8CmCe6jAjKHpFZIzyDySRGPiBhL/DSa
         O+Js4UIzgWUWHxQBUO8NwDp1aUE6kAsCflf+fdGbJWZ8oam5eM+vKppud2/dla9Mvptq
         z0I9jDr3O7fGGcUoUlKoUCvog8rIDPztB1JloOt9gyM8WE1N4N4hI3Ri1eKvRGjXM7PC
         jh7ERGMUMNdSH0soY99cqf//mLtBETTXDvuUXTKjSnKz8Vq4V3K+cGygjaEgR/mxEmwg
         uitdlk3lL/Sl/zrJtP6fXNRVaAKIUwJkmmuVKus+qIDyJ8YqCXSzYWPo7hrV1RsMdfFQ
         6CoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764074026; x=1764678826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Y929ZB3hOQ0huOASE4rm5wG5Ne9+DpeH/x0/TVWvO4=;
        b=buCpdoMxiQ1FSQCtjrFO2kqSoh3IE0+DjhkARcqTutpkniS1zkBa2pGYkMaT7vTNUC
         mX9XAh5UiDj8H76/BXuQDAl6Xx9jiCB/713ZWWLuUBpZ0yDpKeQa09fXlq2/w9LtdKc6
         t+M34dBVsUl4XcCehfDzbRqOYzqQDKxaAJAKrx92LICENDQcXdXHQcji8/pokdvBz/Jo
         csJ7+wG0BgJbutvrwDNYqTnCqSx4H/9b4OmpIBnyKkHP5XmQrkCFjq087sBTEaNSzP6P
         VaiFDnB38kMFe3hz0Jp8dAvBdH7ko4wZuqDhhCzO9v7nsumNvgLSrXN4RQcDdD1BoV92
         TCCw==
X-Gm-Message-State: AOJu0YxA6MtG7mWIOb+zJSktpcqSadXXIn0q028r/qGw+B54Ji4zwLKb
	ZRPf9Q4XonWl5zfeTQt6XHFxPJkrAZ0HJGJc5wJZwx+CemwkKSC5bJRxtSTqeI533XbmhWHGhOB
	unx+AN/sUeLVxgmoj2nK2eyWeuF0z20eF3QlGxhftZrAQcardCRyA
X-Gm-Gg: ASbGncsvg8xIlH22JwUHXpR49P/u3SR0coHcwwffNcRKZYwNSIiVP+1oaZbepXnUnxF
	ZuAuF586E4m9Vo7qXECLn29AUBY6AEcsa0jsu2vRsJ0TxaMBDmTr8VTCbgyXquoEJYYg4azIh3t
	ce2i4W8UHs/KT7cD18EkPUfqksntADgi1bj7AmJPxAMhaYfKYamohPJDy3I+uBzY8s+BL+FPN2w
	nPgJP/b6oNZ96LElWwqtW1wFjvqmX9wH62lPyLhINaPzLGwxw+dNd+agKluX1QJAA0rlitz
X-Google-Smtp-Source: AGHT+IEwLmUO90JusfGU99LkhdunCPNBh25OIaSeaqw7QBYPZxvX4V5bCa/q5MSaZ04IpIPRnNVJOrz1R1keY2/9Avc=
X-Received: by 2002:a05:690c:e1e:b0:787:d188:528d with SMTP id
 00721157ae682-78ab6f1ab43mr24659997b3.33.1764074026408; Tue, 25 Nov 2025
 04:33:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1763634565-183891-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1763634565-183891-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 25 Nov 2025 13:33:10 +0100
X-Gm-Features: AWmQ_bnzHXgXf2DIj-jrV9_xEGjmlVYmbnyBRmxlGhwiWxvVt6695g9_YfTHzV0
Message-ID: <CAPDyKFp4B-=LDoc8xcLBaE-wX_H3t4BUDd99coyjxQZfbB0+GA@mail.gmail.com>
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

I have walked through the series and overall this looks good to me,
besides the comments on patch 3 and the obvious reported build
problems.

Moreover, I would appreciate it if you could work a bit on the commit
messages. No empty commit messages please - and try to describe a bit
more on why/what each patch does.

Kind regards
Uffe
