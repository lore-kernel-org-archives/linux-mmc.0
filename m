Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72A923F384
	for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 11:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778695; cv=none; b=BJvIA41laL03FQSIj5DFINIEMr1qN1Wcd9nkRHj1LJ6FXTPa0rXQ6m6ug6yryP5o654kJiU4LqykbzvnionU5mNXxZniPo7/j9+Oa4Ukg17C3RchxicYSTaS3FZCrCuzPBhiKmV2WrEMwDjX5BGa9hAHZDEVKqTun2wnx3bL1vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778695; c=relaxed/simple;
	bh=UcXaR+GDawWoQaNRuFtyapQxtDjf/bEMrcOSC2FkQ1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMElBVcOZg1o53hMg0cAGHaqkoasNJVz8KsUpTE9Tzaxgt0F1h2NItK+6A+NfSfezGspf8ggxZZ1FGY4XBD+Wc8rIzHEOZEW2keoG6K2KxlDQBZuy/v/BVFK8yiYce+GbsPmOhmEnzRFH+nKxuUVFtc6aWU7LDOarjTKwLZcnAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EV6GD8r8; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EV6GD8r8"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6feab7c5f96so54045497b3.3
        for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 04:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741778693; x=1742383493; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7OnDqzR6YtSLwONQoTdDT31SC3+7fyj7xPsRU2pi+G4=;
        b=EV6GD8r8zWgHufoxYZ+QpSkBrjjETQbjKZbtbg1/XRRs/CQxraYa/5QiZA6ALJ32ap
         d76NiAu1xvHZlhEoRvliWzkoNx8WutESFw00br4RUBbNCCvEThVl7XgYMU6Wij1baTnC
         Cbi222c/12b5zE0kgwsbcwxI325PfDKUpQCKkGCzv9IkGUZ34QmpI/Kn2dtZ8fry1tEA
         ODWYjs8OzpE8ND+BOz0OpKjUc0GgxRINTtuMB8Bc9Z+Lj9Akgo2maSNMbFdaxfvS3eyb
         FbCk+x9EN7cCEqgsi8FV3cg8smFobPUJiLfjj80wNNckyjiVCPddiR8lnvZ/9qyXX0VC
         jFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741778693; x=1742383493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OnDqzR6YtSLwONQoTdDT31SC3+7fyj7xPsRU2pi+G4=;
        b=IAg6YmortGg3lsuFBgL27ytdVkLC5+ydddB9QclXPFCbI3nPGk+JD778ywtUofAPfQ
         pFEIGDpAfZtVCG9N6cSh4KS+xDwQnX3t/+hCN/nLRECCI9VKss9UQcmsCMfq+QsTLOu9
         QtH+A0xB5LjHPx+OVUv62uVWfADNDNxzFU99xuQ8mwkdc4YCQLaf3kDn21sb8KV9uouQ
         NtlqH+VibmzVj6hFuSI6lGtrNII+DYTPdirytSTyYBGxXj52PUMs9AkzlmOuGHrKri2a
         YxHmdlpaey0rFVorqA869/TO0HpOSkKSsDKTDF177H7dAWOIIjVwsSRacKd3lRX62878
         EPaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7poRYEEwIvUIl964Tb8HcBikCX4fxKjmpFF4B/2SRtpLOp+JJJUPJSnUixvBl1oMC0lo4cf+V8lY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbWABnYb1q354eBT8aE2W9cjXUbUMiyQ8wkHO403oQthbyu2Ea
	7QWUMGAsugtARXFjvMX7Q2C13tRffOMfMOcRA/ECX+M+07nGu3RhgJHRKDUvTVTdA9xe+NED5Nt
	c8E5VqkPKz+eJ1KguV1D56OBqyBJKKek+XVAvow==
X-Gm-Gg: ASbGnctiNqhB4gRNeuhXxdGhknw85Qc+otrXTWlUMWebjYcoxIoKaNZFsTIufPmU8pZ
	SBk+daSWQNN98vPC8QLmowxZL7r6IFZqBzg3cuXN2F7mghUyXLk4YP21qxlO/5em62WlA+32NBJ
	cund9mT8M7Nv5OHzTieUWqrpTroac=
X-Google-Smtp-Source: AGHT+IHIrYfmo2j3yVIIaYFZE5oDvK+hQZ8/RGWocwnTto9a3k4qtBGozDsAeCNABMZLWFLC8+SYFjOJXfUQHYTuZMU=
X-Received: by 2002:a05:690c:3612:b0:6ee:8363:96d3 with SMTP id
 00721157ae682-6febf3ade28mr290798997b3.27.1741778692704; Wed, 12 Mar 2025
 04:24:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219-exynos7870-mmc-v2-0-b4255a3e39ed@disroot.org>
In-Reply-To: <20250219-exynos7870-mmc-v2-0-b4255a3e39ed@disroot.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 12:24:16 +0100
X-Gm-Features: AQ5f1JruelnoNSp1FLqFV_ATP8uAM2_7A2P1q-OWLObav93kN6mUQJG3IRna_fc
Message-ID: <CAPDyKFrmn21xksS6Co9AjLQbtq_EWC8WF=r3RSAc6nfWTT9-zA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Introduce DW MMC support for Exynos7870
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Jaehoon Chung <jh80.chung@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Feb 2025 at 19:48, Kaustabh Chakraborty
<kauschluss@disroot.org> wrote:
>
> This series adds support for SMU and non-SMU variants of Exynos7870 DW
> MMC controllers.
>
> Some DW MMC controllers require two 32-bit r/w from a 64-bit FIFO,
> the series implements that feature as well.
>
> This patch series is a part of Exynos7870 upstreaming.
>
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

The series applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v2:
> - Take over ownership of patches by the co-author, upon their request.
> - Link to v1: https://lore.kernel.org/r/20250204-exynos7870-mmc-v1-0-c87cfc72be4a@disroot.org
>
> ---
> Kaustabh Chakraborty (3):
>       dt-bindings: mmc: samsung,exynos-dw-mshc: add exynos7870 support
>       mmc: dw_mmc: add a quirk for accessing 64-bit FIFOs in two halves
>       mmc: dw_mmc: add exynos7870 DW MMC support
>
>  .../bindings/mmc/samsung,exynos-dw-mshc.yaml       |  2 +
>  drivers/mmc/host/dw_mmc-exynos.c                   | 41 +++++++++-
>  drivers/mmc/host/dw_mmc.c                          | 94 +++++++++++++++++++++-
>  drivers/mmc/host/dw_mmc.h                          | 27 +++++++
>  4 files changed, 161 insertions(+), 3 deletions(-)
> ---
> base-commit: e5d3fd687aac5eceb1721fa92b9f49afcf4c3717
> change-id: 20250203-exynos7870-mmc-75bac583c864
>
> Best regards,
> --
> Kaustabh Chakraborty <kauschluss@disroot.org>
>
