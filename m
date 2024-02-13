Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A995FEFF
	for <linux-mmc@vger.kernel.org>; Tue, 13 Feb 2024 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842788; cv=none; b=YsPRuB0kLlNzX3abSPB+qd0+BikV/5VtZlLGexWOdM1oBJzQTnuXvZTqoXxQ6J3RXKIbmWzOlxxiCP9+qZ7JUQFO7ZJis3001HH34/uQCujHFOajcb20yLxHYTIrxP/6gjU2tquN6QO0pCDtwuqJC+H7mpKrNMX1AVONBgk2km8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842788; c=relaxed/simple;
	bh=1ovtsfaMg8Lcn7chYH1W7UjE4PB2d2NiSPtnhsNJewU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHX6ORmpMTQ/PvtD+5yQ09mNojFWSlCGst8xwgkFkxRrNjKgHeMYb70Ty8884ddD8CEO5FdSW/1pzusvZPP0uTvQL45W4OGbkbzeXdRDgQkCGS1O3fU1XrZNS162EvliSe06O9SDRsI8xklUnbRaw05Up+h1SnNVDmJal6slwlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O5gDcq2Z; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O5gDcq2Z"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so3274040276.1
        for <linux-mmc@vger.kernel.org>; Tue, 13 Feb 2024 08:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707842784; x=1708447584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lExK6BFCXT7K47g38M6fcV4HVfSvaGgAkfoyjDKEgwg=;
        b=O5gDcq2ZL3rytJ0daSoAd6Qr7gfxYl3ggPXUWr+C8q2xGwIGkAs37SdJ5SGoTD5XYy
         Cyddt/fLY6QDatCF5o8hR2NkvwIF9Fc5Qnu1uVJ5nYkWVHNLpaM4FqyFdo+9GBfHR/X5
         2GuGjcPUlBNeiTFlRAbUmrokhhe6laQ+1aMI2Rgim0ibfFqOCa7tOEztzncni/5dWp5s
         NW7hmizpsV3cPKuYGLEpWxZantux/04u38R9wWhtK1BO+RQqXqW+v2wp90/RZCiFdV3D
         sA4cQ/rdfjSDmQiMCpqdbXpAEIpxMZKbuKIHrGQP43c3MP0tZGZMAgFaQ67EXEtMHgKO
         3brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707842784; x=1708447584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lExK6BFCXT7K47g38M6fcV4HVfSvaGgAkfoyjDKEgwg=;
        b=iGcv/tpqMG/gLcYfv/67DYbsybXPoBekECWlWPcs2ymvnwO+agUIT95pNgOCsck1qo
         eYPcELq3naowIccGqJBPzJMzdqRre/uCp19RB2qMxwhIoQ50wtXzStJU1IVUP0vNbevo
         5TetAqY3iaS6Y2pHRroQVkl9yQFOoOIb8nfAzDtINZhKEvD8fPCyvN2BX1LnI7GdzufA
         OGP9zQX5kui+FrRBhT6qGrJshNYV17l0o7bbD8s0dlQbVb9rVMhet8Ki3coQbmwJLADV
         7IjPJGyBf91tnkh7Zre+0LST8vPyDLCCctVzU4yWuZqGes7obgWw/+N5YV+0+Oc6+rpi
         Urwg==
X-Forwarded-Encrypted: i=1; AJvYcCXFDQOi9gidugqrbqSisyWH/Lnk9AhOTI728DjZkRrPSS9M1mtv1LD/s6Tcx9WtkPZMk7K7nW7uBXYpMvTj/Oj2SZ66sM5pw9/O
X-Gm-Message-State: AOJu0YwQq/7MbYNry5Y4HW4GNtfd5U2TOcsCTaT420Fv8bIBHlUa/Du/
	wI1PjHb73C9qKFPc2TKdv4FSzl1CU3sbgDWHitqj54pVsuV8PsK77TFb3gNQCELx4D0giPVqMCN
	vPHJQWuJpD/RVhsKgwZUlcU1deOBD6QwehUw+Nw==
X-Google-Smtp-Source: AGHT+IHRRooe3gtkPr1s5cWmjVbznagamZWAqd7ZtWG+qKZWax9GEcI3/kCDob2wpJ1buhzfIBS4wIQwi8pfHnYQwK8=
X-Received: by 2002:a5b:701:0:b0:dc6:18d0:95b0 with SMTP id
 g1-20020a5b0701000000b00dc618d095b0mr7312298ybq.8.1707842784564; Tue, 13 Feb
 2024 08:46:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208202137.630281-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240208202137.630281-1-krzysztof.kozlowski@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 13 Feb 2024 17:45:48 +0100
Message-ID: <CAPDyKFqa8_j2-bxYa5VTzYTCqn9+Rm6X0KdS+F=NEwkqFu-5mw@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: use typedef for dma_filter_fn
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Feb 2024 at 21:21, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Use existing typedef for dma_filter_fn to avoid duplicating type
> definition.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/renesas_sdhi.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
> index c1fb9740eab0..586f94d4dbfd 100644
> --- a/drivers/mmc/host/renesas_sdhi.h
> +++ b/drivers/mmc/host/renesas_sdhi.h
> @@ -9,6 +9,7 @@
>  #ifndef RENESAS_SDHI_H
>  #define RENESAS_SDHI_H
>
> +#include <linux/dmaengine.h>
>  #include <linux/platform_device.h>
>  #include "tmio_mmc.h"
>
> @@ -63,7 +64,7 @@ struct renesas_sdhi_of_data_with_quirks {
>  struct renesas_sdhi_dma {
>         unsigned long end_flags;
>         enum dma_slave_buswidth dma_buswidth;
> -       bool (*filter)(struct dma_chan *chan, void *arg);
> +       dma_filter_fn filter;
>         void (*enable)(struct tmio_mmc_host *host, bool enable);
>         struct completion dma_dataend;
>         struct tasklet_struct dma_complete;
> --
> 2.34.1
>
