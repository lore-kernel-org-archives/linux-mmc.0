Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A625402B8A
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514052; cv=pass; b=mX0QlalmTrd8UgOiKFCtD4WfmOSXwHO2+IH4vM3j27aL9A8FBfz7IoPp/aihWvhuvGM7Gx9x4ue+/5RJJyHP6fBk1zv0zGaQg3z5CNldsQeR9xjdMPUWD2lMawGAh8jQUjvTsc5wMOp4AyfA83f0tanZ9e/gaszcBwxU19+GZuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514052; c=relaxed/simple;
	bh=4zL74Mu1DSWvtJkyidekENbTyarHu7MElWrim93EAk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvVr8CwHkx3brq9I75bzqu4hF+xkZ+M0EDe1w/FRdmTImfSishi+kNtwzt64zR5YhSJCiMDvmNfSgNZn33fRPNWo6Royc5mdkK6xKgy8lNQCFblkiRQc8RrjBsQ8L7PxGxwpCVteY+5hDYQvEOBLPCOrGtVd/q0qDugN6CP7+UU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CXMODD+U; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CXMODD+U"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a742b8b72eso4440616e87.1
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 08:40:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778514048; cv=none;
        d=google.com; s=arc-20240605;
        b=Rr57XYeXxBAJqP7r0ledJZegbs7+4KQO7Iasq/HsBAZEHtmCGMXPGOPv0suZYQpUTf
         /N4ixbDMolUpC4XS01AXYMsHi3WqTvKyyrYyZrnnsBxaLnRY/i3F1SurzOFNpGqoNJt2
         oLkXMSHr4Ndt266qZFTTx4XUUTMJY7OcLcJoTjFPGyXG2RlPGOkcXEIFvwy2T00lz5WR
         bqcPpNTSQ7x0YWPb6k8ZTWQK++yuOQK1Xj4pzuFlfqENf+G8HmBIpNivHpfFSZlclrZk
         XTCH2fV8fjHzAIJ9Qh6SXOCYyzwkGyMRT6cqkKMyFWhSOu6Crravh3OyW9bXmXqPF7H7
         VnJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Tom8nz8ocEAiLLuwhK7zC7zt0ns8+eNg2JGA2KFWKaM=;
        fh=OHToKDgsypxWjIJIJcZl+3LIA96Grzf2UaE823j6jaw=;
        b=ZL66WAvzjvZLJI3Sb1MxBz34xyqbUI8RHnoavr7ZGlTB1gLYLiGZAj1Ur6YOHGmFai
         SaDKflHXUq+VbPuh+6/LozMGoiZFMDHh3A7RY82+5VEEgddlq4CS1AHLvzp3AtdQ6Udb
         ThKEfwr8y7B4pcMhMbiaOXAj4Uu6JfnkBmjaMMhIuEjk+I2QSri5ty99FF9J/gn/Wi0C
         c07sW2aKUIYY12dTaEfFVFg2+QA+DdAjPrQ3g8F/ks+y5ZL+4RHR70v5+Z9FWm68iFg7
         W/KuXGtGTuK6v+gMO1yVv/4c9VEQLVEoQQ/0CIG4Lg8mvxJhAmWsUGv3h/AKbzD/bZ3h
         KuCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778514048; x=1779118848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tom8nz8ocEAiLLuwhK7zC7zt0ns8+eNg2JGA2KFWKaM=;
        b=CXMODD+UvdU7fiopXnxCGNaMpaq+ogHClTFOYjVND8wvyw4dVipbwjq3sbfmhXNriq
         A2X0PMK0KUpJq4jcIoB6h9Ep25kIdmDLq683V7F+/KD2g1LYuAiDL84m0rhOsVRhu3N/
         KbywFSrBX5wsHjas2pmoHf1e6VfES/VHeULJix6tgA9Kw0GSbQ6uKS36NzQ11e8wE1v4
         0wdh1Cpvz4BfiCsImfc4Q4GYCK5AQIOe2lPAw47jy6M5eIJaKiuOqu4MKhH1V3nVv4/4
         dw+d+FQhb0UUHooA/vob9AOhoq99RaNSPaVdWZabaXJHS9m1CQQZJGddiqwQMGk/Hvpl
         W4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778514048; x=1779118848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tom8nz8ocEAiLLuwhK7zC7zt0ns8+eNg2JGA2KFWKaM=;
        b=SOOkyahNDyon4lPIj1MULM11SXJl4Z36OSjZZULNyA7D4pV3GKGMFjW2wUJaI3/NBU
         mA+iMJnKQtNu06+oHqbRrRk1KppmDkXoSy1gxcE4iu4uAOeDUdDCCbKAiYg9wI1yGC1U
         SG2mRZ3JxQk99mw8QlkXu0X81dnDCMgM3W0cM9wQerrIJSwR6wkd5WU3R8nnVGItohSQ
         q2oRMYBanUViaw5njyl7sfbaluqbsPJrjS/4tlTWDEpy4AP9E/GtPCJ5U2nph3axd6iL
         Gdt1jk4f10UQuBIUH72nK4BWDRty4chp8NAtn12w2OKo1dFZDXaVsijWPmmhEobuxp7a
         nz6A==
X-Forwarded-Encrypted: i=1; AFNElJ95MqVOGyTouAlgI3XM7vbbWWI4mdFvyNd5EVBpwBbiAjThCfpuOA5oFMVDWxJFzRPujlduT+Gr/ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL1xo7OgmGHtbK4B5848iciltX2nvnwMVt7HyTzGtoWxH6o3Qk
	TozJIuPMUNvtJMhNan+ZbnPR/C3B693swzl4T53mytmP5rvaVZsXH+KP89tzwC9CHzJIZoYl9z0
	DaXgRaYsWtNzMeXQxdBozKQy4016YEWWKi7J2W/GEQg==
X-Gm-Gg: Acq92OGz6pe523PCu2CIRIiEQLnbbmj5l3DzxgaZJgG8ZMFN0aYMpJEeM3EApUYIdFF
	3UWqnT8cwErGAPqRBA3MeQvsLPcUvP/TWhY9npI2u369TYcW5031P6ju1RXMnUdffufPAIl7/uO
	156HOZ8nvI8yNPKTd05PUYKgL//9UekxlqmFqs0ZKMft5yWELHG+PxAdvz318bvXDpZ6/s7MJAa
	rNhQSWjrjFlYniAyMFrAWTJpjEPBa/8yEBW/37Rn+oKb/7eMn/S0CUTEPJmNHjZBBxZsrxgQDZT
	Ti1OTG/k
X-Received: by 2002:a05:6512:10c6:b0:5a3:feed:31cc with SMTP id
 2adb3069b0e04-5a8b70927bcmr3877271e87.24.1778514048384; Mon, 11 May 2026
 08:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505103927.234104-2-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260505103927.234104-2-krzysztof.kozlowski@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 May 2026 17:39:59 +0200
X-Gm-Features: AVHnY4I7F9zG2HxLHEwXxKy4fvbCa7okrfNfjEIok5BDiadgnXlivcvoPO9tXPo
Message-ID: <CAPDyKFo6VpFkuM-AJEgzPBFL5V3rSyruvEtjsTpwKAhH8MoOZg@mail.gmail.com>
Subject: Re: [PATCH] memstick: Constify the driver id_table
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Alex Dubov <oakad@yahoo.com>, Maxim Levitsky <maximlevitsky@gmail.com>, 
	Ulf Hansson <ulfh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 May 2026 at 12:39, Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:
>
> Just like all other driver structures, the id_table should never be
> modified by core subsystem parts.  Constify this member and actual data
> structures for increased code safety.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
>
> This should probably go via memstick tree with mmc ack. Or other way
> around.
> ---
>  drivers/memstick/host/tifm_ms.c | 2 +-
>  drivers/misc/tifm_core.c        | 4 ++--
>  drivers/mmc/host/tifm_sd.c      | 2 +-
>  include/linux/tifm.h            | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/memstick/host/tifm_ms.c b/drivers/memstick/host/tifm_ms.c
> index 0b6a90661eee..0a54586aa54e 100644
> --- a/drivers/memstick/host/tifm_ms.c
> +++ b/drivers/memstick/host/tifm_ms.c
> @@ -647,7 +647,7 @@ static int tifm_ms_resume(struct tifm_dev *sock)
>
>  #endif /* CONFIG_PM */
>
> -static struct tifm_device_id tifm_ms_id_tbl[] = {
> +static const struct tifm_device_id tifm_ms_id_tbl[] = {
>         { TIFM_TYPE_MS }, { 0 }
>  };
>
> diff --git a/drivers/misc/tifm_core.c b/drivers/misc/tifm_core.c
> index da0827724a61..aac8f0933e43 100644
> --- a/drivers/misc/tifm_core.c
> +++ b/drivers/misc/tifm_core.c
> @@ -31,7 +31,7 @@ static const char *tifm_media_type_name(unsigned char type, unsigned char nt)
>         return card_type_name[nt][type - 1];
>  }
>
> -static int tifm_dev_match(struct tifm_dev *sock, struct tifm_device_id *id)
> +static int tifm_dev_match(struct tifm_dev *sock, const struct tifm_device_id *id)
>  {
>         if (sock->type == id->type)
>                 return 1;
> @@ -43,7 +43,7 @@ static int tifm_bus_match(struct device *dev, const struct device_driver *drv)
>         struct tifm_dev *sock = container_of(dev, struct tifm_dev, dev);
>         const struct tifm_driver *fm_drv = container_of_const(drv, struct tifm_driver,
>                                                               driver);
> -       struct tifm_device_id *ids = fm_drv->id_table;
> +       const struct tifm_device_id *ids = fm_drv->id_table;
>
>         if (ids) {
>                 while (ids->type) {
> diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
> index aebffd3ebf60..28ab2526dab1 100644
> --- a/drivers/mmc/host/tifm_sd.c
> +++ b/drivers/mmc/host/tifm_sd.c
> @@ -1041,7 +1041,7 @@ static int tifm_sd_resume(struct tifm_dev *sock)
>
>  #endif /* CONFIG_PM */
>
> -static struct tifm_device_id tifm_sd_id_tbl[] = {
> +static const struct tifm_device_id tifm_sd_id_tbl[] = {
>         { TIFM_TYPE_SD }, { }
>  };
>  MODULE_DEVICE_TABLE(tifm, tifm_sd_id_tbl);
> diff --git a/include/linux/tifm.h b/include/linux/tifm.h
> index 44073d06710f..752fcfae27fe 100644
> --- a/include/linux/tifm.h
> +++ b/include/linux/tifm.h
> @@ -97,7 +97,7 @@ struct tifm_dev {
>  };
>
>  struct tifm_driver {
> -       struct tifm_device_id *id_table;
> +       const struct tifm_device_id *id_table;
>         int                   (*probe)(struct tifm_dev *dev);
>         void                  (*remove)(struct tifm_dev *dev);
>         int                   (*suspend)(struct tifm_dev *dev,
> --
> 2.51.0
>
