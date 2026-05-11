Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0B532E137
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514027; cv=pass; b=l1/AsXh04oREBflTMbVmmh6qe0ctmMaVOx39fFvrJctsKPW58bDABWJIT8ZYfDQIbni3XdS3yiJhIaLZWJxNRnlESujiZwHdP8i3USXGWPUww0yynOzp/Av7bf1WzPCFJCH6H/Z9pvLc1E11B1YvRwuPqzzQDJkyXCZISSz7WdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514027; c=relaxed/simple;
	bh=f3BrIm74DQVGuO3zphgLn5vVBmkdeemGJ9kbeQQE9Ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NpxAmY4JXq6EakrG7T0lipIUqmc28v3hXx+s6hZo1MU30tOFt+u6D9VyQtekv+Ex60qkP7UJPZRdwy2ilCJZ5Rol+VCg6lWc+wXvqB49t/FCsqB6W/3oLjcRIbPYVgdjBdppUVovvP/sPRc9DUAoZV+u8UcVSHeevJLs65iHN7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mRUG5q5t; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mRUG5q5t"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a884ebba7dso4614395e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 08:40:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778514023; cv=none;
        d=google.com; s=arc-20240605;
        b=EdiR01W4V876sxKYO1rbmaf+NrWyDuD+qrVGjnMRFwHsduWtNjp3XKijU+Gs/QNsKx
         1Fd3C6ClzSO6yIyB+nwQ1yYHMVhOSuYFQhezBt7fteMQCXxWSINmodAsKr1Z8dPzkH8m
         rcvABjZRSUvTm7ehooZPtwsurvEeamVPE/xR8J2SzazuUefQZbbHuJIeGW/g2aL88MLO
         Moh8NeZRbXAdDSrXXYNVEk0fBO3UIVPpV2fA4VdNGX22ZACgouK+Iw4DqLlXrBoUYyV1
         +XefrP7hBjT2glRAbuAfZ6BkQLapfa2ZF/QxfflYS8uFhBMgZRHUhJKUNwdrmG3JXSW4
         +w3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PAa827a6Or7i38QsE/PyyngNqVpUBROEfK8gwXTbCIU=;
        fh=FyUCg7f2OmgkF3POsmwvEcD6NZ9J5R2PN/ZRdjGkX7I=;
        b=ibrnGkIGr0pmxrWAiBuIFK1nBTesVaWVYjvvaeo/EZY7VH9bb7wW0rdeJaN+A9kGOg
         fdB12xdrJuJ7PunMk06H1BEt2abww+R45Gkt8CZJoF4zmZliAmo8k1XdAEnlehZxJxK6
         s1FRuHJAI/NCIymUy9YLyqGUByV/M86Zu+ri9r0HpfSCArQTW8fjWNK7kXljAM7QE0gK
         cepKtCzHg4G5814qvlL0qx9EeXdQnZrz6R97yKVqYRL0tVpeHthp8wxKKMC1Oj+02X2c
         ZfHY7CULPAf5yxSLqDFVo+OuQa+jJpGD0eYtuhknA0QIPqLTFexKMuYNQO7nxecHYxDE
         fqLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778514023; x=1779118823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PAa827a6Or7i38QsE/PyyngNqVpUBROEfK8gwXTbCIU=;
        b=mRUG5q5txhUbj0WsNzy93v2yOqJx77hwNhgOBoBkJREuYYkPAo4IUkMXAUk1Ns0xRN
         07FuTbItsN4JEI0CGRFDb0h0tbEJTQkBqvNy22vppC/Ypqf6Mg3fmYzcA/JfJxSry9Vx
         Kw4a8AvksVy0KXajEPgkMs70/+sGhO1GmggVneTOgv7CSDiidwSdUEDu5rDO4Xpm4qPq
         nnGkIuw8k3c5Ipy+3km8H2h5bYPNlfblEq+u2P6zeUY/W0eWvTdbiT+oB2iJ1aBPoxCP
         X1tW+E9ufVPSWPYocqESuPqurr9C0VCsHcrXEA8RPPkHRU9YlhxKnBMV9BnThuW2t+KZ
         /JOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778514023; x=1779118823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAa827a6Or7i38QsE/PyyngNqVpUBROEfK8gwXTbCIU=;
        b=lJdqenuINFv22BBNRfzhPOqZYcuA+BtuWpyStRiX2+B8pdFbUk+gICq/K/BE7lVWK+
         hUTXQDSNJrzAF+Nxn38vcqc4G5GlvJD0i0ME9E9pbXl4s7lFsD8Dhd91rsiG8mZXyj5d
         cBWByudeddU2SO2ElIynxk8TWSwD3czA6Nf/r+HqiD/mz5OpcRoC3YVo+TLOat6jNCG1
         JI3B6TnqIPTR0udBoGBzGM/MwK+qXP+yODXEaatzjylbA5baZ2yJlw/7mD072X/8PubW
         JtqvjovtHj9NugBiVxD3ohg+IOnr85kr7Q9F247spTUXS75H7PvA5aB8Lh44DghaD0OE
         JIjg==
X-Forwarded-Encrypted: i=1; AFNElJ/6ksUBvGsrSRAYP1QDkZ6HFlw06AUTQDFWgC25uzTJSroaZW2EHKKFKQMoHDQSsBmZXfVPYPjRde0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfst7kzIGPcn38+Ei2YwQ+XmTEVpXeTDdSCyl70XhWs8yL5Cmq
	HwOioi4n+1RQaZMhjziH6nEwkv/zMXs0g4MLHII+5TqgBx7x6jpOdN8BpMr2GMgW9JFW9r1+yft
	ClD/EMxdZ64DCEUl04d1BaoplSmqPzU/Dgqf7xUSjPQ==
X-Gm-Gg: Acq92OHlN0xk3P5ItrHNn+FdMyWAHcI+VZTD0S+ZYpWCALd6lS7vmdhalsDY2BYRTLB
	1iDiLC0X18X8UIGddPuXq3Jo21mFE8LYwhx7gUMIu1rgqXZ2XJZjTytAvC3wmymMcmdUfN58Rde
	p9499OoBLYg6DcxQH/DyTaQ6sS94KchUcD7yIyqW2qalZf7DxdV/0OGQNd35LKqt2OFx72YXbKD
	kw3R1oZrrP/lPts4R8Qe26Juzu0a1ZG+/PVeLOD0E2YeGyMu2rHzgFVyU4qbh3ncuKbxFvfdUyk
	rtyTD+To
X-Received: by 2002:a05:6512:128d:b0:5a8:6b81:6694 with SMTP id
 2adb3069b0e04-5a887ce5e99mr7616406e87.30.1778514023164; Mon, 11 May 2026
 08:40:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415-dwmmc-dma-thr-v3-0-31014d36b6ee@disroot.org>
In-Reply-To: <20260415-dwmmc-dma-thr-v3-0-31014d36b6ee@disroot.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 May 2026 17:39:43 +0200
X-Gm-Features: AVHnY4LuNFcZPtz7Q0DEjkMyUey5MSZn1HyvgA05S9j4k4K79dMxvsAAv2GCHYk
Message-ID: <CAPDyKFrKd9PouecmpLBy3NEas8dpzyVAk9qD6=pFvwbHNyg2NQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Configuring DMA threshold value for DW-MMC controllers
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Apr 2026 at 17:03, Kaustabh Chakraborty
<kauschluss@disroot.org> wrote:
>
> In Samsung Exynos 7870 devices with Broadcom Wi-Fi, it has been observed
> that small sized DMA transfers are unreliable and are not written
> properly, which renders the cache incoherent.
>
> Experimental observations say that DMA transfer sizes of somewhere
> around 64 to 512 are intolerable. We must thus implement a mechanism to
> fall back to PIO transfer in this case. One such approach, which this
> series implements is allowing the DMA transfer threshold, which is
> already defined in the driver, to be configurable.
>
> Note that this patch is likely to be labelled as a workaround. These
> smaller transfers seem to be successful from downstream kernels,
> however efforts to figure out how so went in vain. It is also very
> possible that the downstream Broadcom Wi-Fi SDIO driver uses PIO
> transfers as well.
>
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
> Changes in v3:
> - Move host->dma_threshold default to dw_mci_alloc_host() (Shawn Lin)
> - Move comment to document struct dw_mci::dma_threshold (Shawn Lin)
> - Link to v2: https://lore.kernel.org/r/20260414-dwmmc-dma-thr-v2-0-4058078f5361@disroot.org

The v3 series applied for next, thanks!

Kind regards
Uffe


>
> Changes in v2:
> - Remove dt-binding to set DMA threshold (Krzysztof Kozlowski)
> - Add comment to describe struct dw_mci::dma_threshold (Shawn Lin)
> - Set DMA threshold in Exynos 7870 DW-MMC driver (Krzysztof Kozlowski)
> - Link to v1: https://lore.kernel.org/r/20260412-dwmmc-dma-thr-v1-0-75a2f658eee3@disroot.org
>
> ---
> Kaustabh Chakraborty (2):
>       mmc: dw_mmc: implement option for configuring DMA threshold
>       mmc: dw_mmc: exynos: increase DMA threshold value for exynos7870
>
>  drivers/mmc/host/dw_mmc-exynos.c | 1 +
>  drivers/mmc/host/dw_mmc.c        | 4 ++--
>  drivers/mmc/host/dw_mmc.h        | 2 ++
>  3 files changed, 5 insertions(+), 2 deletions(-)
> ---
> base-commit: 1c7cc4904160c6fc6377564140062d68a3dc93a0
> change-id: 20260412-dwmmc-dma-thr-1090d8285ea7
>
> Best regards,
> --
> Kaustabh Chakraborty <kauschluss@disroot.org>
>
