Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106322E645
	for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979145; cv=none; b=Zy0NwkHSmiyQIC6os2LnhVQlWR5fjwA6iMnmuQZ4/AKBmISJOR/OtHfvCL6xdLQykej/CeAMCNTgYsRFvUVzCRiT8gG5WXxJijkDtNx4/IZDM6jg0Wn1aWYKh4IYbg61aVFyqEHJfv+gXJUkOl8MXLBYTTwzIt4tI0u4VImAfsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979145; c=relaxed/simple;
	bh=E/jpL1DRrEW9RoX3hG4RM+GKnF1yRPhoYZV6ZjnhOPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxtcnpjslxsolT1f8fleqBNni6nMKFzSWo5IqxpjbnFv4Y6lInpZWeUBgwC8GS2oLXHitEw+leLXHyw5cy5YUQIxjAbzq9rk089PyCm22xc2hE/HRryRJxnVFzGSqjpbDot0q5/hEcYMtcPIISkLnI+QD8lJ3UwlF9BUbpUSnYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dm7/a+sS; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dm7/a+sS"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37b495ce059so40146241fa.0
        for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 05:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765979142; x=1766583942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YX9hq/q+S88vl8NSlR5vYKmBnwZwrK11+QdG/Llslo=;
        b=dm7/a+sS5TBXasruBtwa6ui6/FPvjManoUfaay/s2V+9VtgWtxiE19w9jJz21sdElF
         d3fidaFvguUokALwISZhIByKSpDnhsJObT/q6YWR/HX3uiY39OB1l3NtD4NYscI4iDrx
         wFePgbTPdQPDLR9S3roER+mjLRM3Cas9CIzC0RhorMaAEM2u516K/WsiDXGmmNkTbHKY
         G+44Te3MzoAlF2ZmSdEudtEnqhKw5b7VVuaakAEqO3eypkqggHiu9ILcp2CLLNzzhjJw
         9s3LJZR2hKtLS4ft527MfHzBul51h+UPYmtvnCPZGJJ5kvrEf41c23XRso1Z0Gdmklgu
         JENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979142; x=1766583942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/YX9hq/q+S88vl8NSlR5vYKmBnwZwrK11+QdG/Llslo=;
        b=E4YNUHAJQcnQ1p8plr5x71jRhLck85MLaba+HnaxpPVvCHt8nbVYBAUY6oCCD0tsBV
         ELvoLvyBP67tRBi4ZtJ7bGUETzVrTN22JL8t7kMVxsVWeuECP59fKZgYqtxAy4B7s9OY
         BPolHVOYNn9H4op4MfjPRXtrNYgwezL8aXS8UIp2TS08sJ3flkI6WgRRwJ0ccm1Z0qk2
         CZfyUk8/XNDT/nfwOC1TEOD9LQ0M13Os6I2uRQ5i1PcbflpqWJPniXYfIhQnIR7p8C1v
         v+qrrnG3zasrL3TRbngCSaVISemzohSWyAA3sBlvqJxSnPLx0U3Zb76mFoxwDLriVX8o
         jZnQ==
X-Gm-Message-State: AOJu0Yy4dbXQ3lw1UFJ6ZxcgzorI1xRwZs+O4U+Dg+GyRxJtT9RNzypR
	NCNv2/qzlUatHyysC7hnvrJxILuoNFUHt0+5bmH9RF60HZgNqErPLZNMCRkpCnwMjv8+58NVJ+d
	gvhMubxvzako3vLcopNDILmMhr7SvnGrd11EjDNcZ7A==
X-Gm-Gg: AY/fxX61bt3pLdF/Ds8GTBuwnjo/U45UkN8TBWvK58Pdw+WpNYaFqptoAwUKb7bNe0X
	ElIKwjYK9yx+AW4fY100QF2abFyXbzL1s7GBRYRRubdjqo+Tkpsj6SeK9q5axUIQNEkFIbi4B+t
	4vjw0DzM2kN7fAKecvdfjn4W0h2Oehcq8rfrbX58P9v3pS00feOlK75yVSsjGr3jkOxuudae2E6
	RC1EzdlPSatpzqyF7p3UOoiM3v/TJA8BUByVzZnHrGay232v75+e7TPYAi8ZuQUS11abkY=
X-Google-Smtp-Source: AGHT+IF7+PqmZBwdeEUmQ16viez4DThSUD/S97hYolMoh3ezNOd3je4cKzCme4ciEiK+wBNp6vRjl+xVZ+lrw4TL5NA=
X-Received: by 2002:a05:651c:50d:b0:37b:9237:270a with SMTP id
 38308e7fff4ca-37fd08e09e2mr52625551fa.45.1765979142175; Wed, 17 Dec 2025
 05:45:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1765885807-186577-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1765885807-186577-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 17 Dec 2025 14:45:06 +0100
X-Gm-Features: AQt7F2qT3E64s30_1BqyKSFkwYhBgkY843Q5v4wpxerxSjVWFrVsOnv2eyEzui8
Message-ID: <CAPDyKFqo6bdTSpZmF_pTtcN_86V+gfhP0hMs34YASEWhOiPFEQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/12] dwmmc cleanup
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Dec 2025 at 12:50, Shawn Lin <shawn.lin@rock-chips.com> wrote:
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
> This series have been tested on the RK3588S/RK3399/RK3576 EVB platform.
>
>
> Changes in v3:
> - Separate a patch for mmc_regulator_set_ocr changes
> - Elaborate more on reset changes

Applied for next, thanks!

Kind regards
Uffe


>
> Changes in v2:
> - Use helpers from regulator.c and remove check for mmc_regulator_set_ocr=
.
> - add commit message
> - make commit message clear that we remove two things
> - remove a unused code
> - Fix dma_set_mask_and_coherent mistake by code rebase
> - fix compile warning
>
> Shawn Lin (12):
>   mmc: dw_mmc: Remove vqmmc_enabled from struct dw_mci and user helpers
>     from core
>   mmc: dw_mmc: Remove check before calling mmc_regulator_set_ocr()
>   mmc: dw_mmc: Remove unused header files and keep alphabetical order
>   mmc: dw_mmc: Move struct mmc_host from struct dw_mci_slot to struct
>     dw_mci
>   mmc: dw_mmc: Let glue drivers to use struct dw_mci as possible
>   mmc: dw_mmc: Move flags from struct dw_mci_slot to struct dw_mci
>   mmc: dw_mmc: Remove id and ctype from dw_mci_slot
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
>  drivers/mmc/host/dw_mmc.c             | 464 +++++++++++++++-------------=
------
>  drivers/mmc/host/dw_mmc.h             |  80 ++----
>  9 files changed, 251 insertions(+), 362 deletions(-)
>
> --
> 2.7.4
>
