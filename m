Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5721399A41
	for <linux-mmc@vger.kernel.org>; Thu, 22 Jan 2026 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102831; cv=pass; b=hvJNVEyeWq8PiDjngWv6UGU+w+KeRKV8A/VWR/yuoOdiKz69ls//wlNy8zS0tVIXmeEHmnMnlXTknlwEj2sopLx/8QnBeymXm2jtkXHOhl70RZFDnlFMezYe9KyHRU0WWVhvSk4u/fXL3Z892xxtngKxt3sasyfmU67h+jFfxwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102831; c=relaxed/simple;
	bh=BYyLZBP8y8y8dYg70IIuqbmfbBD25HnRi0CsXenU/+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKawjtmH+4y+LN7MDEhTunD7qdRaEjt/pZzPMec/DT0Uf8/Ruj4XyfYQQoGtz0hXkg+FbYWA17DtcxGrgUKsKasBupAx0Y1XBo4YUKLHdpxL2uDGLpvqbpQVGGy7PidxPVmV8tdU7g7oE/is0LHULHllNDdwpK8oQUf5CQVaVhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lVZmkcwn; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lVZmkcwn"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59b77f2e43aso3039403e87.1
        for <linux-mmc@vger.kernel.org>; Thu, 22 Jan 2026 09:26:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769102815; cv=none;
        d=google.com; s=arc-20240605;
        b=IalqPFJpvvXc1hPgi8z+xrHQ6hS4b15QuOj4bmdyf3rIffTWfhLPbRtLTVibYqlF7J
         sXN8IjGE9Xqi62/KfYA3Qoh+Ixi+knk8IhXnutk4Lm2K2vTHv0463xCaTDcfuZL8Jxj0
         1lrxqaH35jIaGo4c1EPMQx2/ixccdKhY/tPKQWMUInZ2lIVBxrytg7iJ7b/A8GnAoaPp
         NWkS4fdXRucq4NhjHahFoTyFlT5Xn9Wa1msfeGJG9TuSWJ79pWFxlpjIW/nnGujOsbsn
         JojKnl2dWqkiqv3z49g19nc+7Dhdzodr+0KGhToAD+q4C8W0a/YkCLsKOjlzflAor0lG
         b/fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=O0wwwgamx5qsFGEUilYG/RiRlT7XyKwhafQRv/ycuZ4=;
        fh=SvYE6LuC8kkkkv7AjGa/0vANvkDkPcD0KBwJKc2fcY4=;
        b=Kqa8KhFganFzbaO1nceDqo1fDM+wdl50nZb0jE8UQ/lTkGCgI80lJH6U5X/bPtxb0h
         1W/wu/1ft2C6e4QMkqOqrTq1MSvN/15DDNNHjBbx/9gDnQsDAdvXt7BUpCawftvLwYPB
         A/0JOxJEMdsDd5oKxr6Vp8cYags26ejtv1ObuH2uViQcqVJX+u/QnreRC18KWwuPN70Q
         jGkQMKT6JDJwngsdBsM2ooCWtQAl2m+PvAnaLHrCdzA1ltoQNRNIO29bFxd6P1LPe+jb
         WivE2mCXWxy4cbzo+uMJbcvmYhSzx465Hw5sjWeoiUsKZQkoIUawCVN3I8GynCdSbbpP
         oo5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769102815; x=1769707615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O0wwwgamx5qsFGEUilYG/RiRlT7XyKwhafQRv/ycuZ4=;
        b=lVZmkcwncUrKQsCr9iZZ2DDZYy48Aq5IhASQaJm71kNC1ujNZd1gErmimptQIJw4l8
         9kA4tlZftyYXDrUeST2dgeKkfkxV+CJjfXLhPtIcVtYjiT2CQ8zbT8VpIUqiKfFdcoKN
         SVjwx2/bn1TIqc2vSEeqPYxtfkKTRx2ChdkNMmOqtqDvmPXJouseINFPl439+JCfRvXc
         339iWo5naNAYe8rbV6Q5hoDXVNXxARVgrBIxMerU8azZ3rdHb5tP98tZb1bTjBI9J0n6
         J9dJTQzHv/s7EkpWF/iEfZc2xsbW0GaQwXVvXCKBFoECOUR5y3tP3mn/fiLPKVeZ7l8v
         +oSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769102815; x=1769707615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0wwwgamx5qsFGEUilYG/RiRlT7XyKwhafQRv/ycuZ4=;
        b=tvW7dN+UTv3zeyNb0BAb51xxiNmOUifw4xI3kABV0ja3SnFt0/MxMvTuZ7SgCnwCf1
         RqqCgKtdU1nljj4KHYh30D8w0KtID+TCHLdgQkKqVV7XJ2bpk94zvNZO53NJFKWHHP5R
         HL4r4fZM5MeSeP1PNmDjCZGWOsbZT5wXzSN1zuuwoQiwlBfOYuj2FHM7ZEwF736WWN38
         DkmGw/mbQ0Pj835cbfU1L4ppRr5lx3t29t9dNqpevWDoOhxHmra1rCh6ku39yH1fi1h7
         HWJvYEMXGDb6ZclBeYSTbj/6zbXv/f7juLm8+0geJkaTxj6p8drpHiRDuCyy6K7eEjl8
         1Rjw==
X-Forwarded-Encrypted: i=1; AJvYcCV+yDmLuQiNzd/OJ131Pv5tIZ/WpvkwSckg4Nz+7nHFl/Lc+lMo8Bz/ozEIv/63zO1Y8cJ9VhJO0Fk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3jQWYziPOje4M5VuZJPjKArVrbS0Br+oBVEkPwCA3cJrJFdtD
	w9r+mI/1/qzsbhiqfQY6XlgS62XFnVBxi5ytjJ2bqa2ZSNpJ2P7feZEmu6S4H35HG8wzcmBzy2S
	P3KRzW19YUwT5FnSWnYa/eYVEJtt2gSqn+HLROAEs7Q==
X-Gm-Gg: AZuq6aJqDiyBUNZxxf82KOZsmrU2NOBYlZ2a3sDfeBdbgbYg82T7f+gTABVe80joQNJ
	kMJ6fj9EdlB5sb3S4nivtMtmu6X9hdO29QV7UHAIvywZdYrPG9ZtM8XVLyhwLgMb6JJUgXuQ6ND
	AGyBmEIkGHOe4GvRFAjOgm82mYoaAFB4c8XpS0WIydqT/SPzisAmLNiZByMUaNHBXhx1H4Y8A9U
	oboBBAG3QrB65U29+pqwsEuIEqklx/ZNRzj3WsgFJh31+riVUZmFgEDeb2z9l/orKkM7NIP
X-Received: by 2002:ac2:4f0e:0:b0:59b:6ac6:115f with SMTP id
 2adb3069b0e04-59de45b3cc0mr47745e87.18.1769102815205; Thu, 22 Jan 2026
 09:26:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-mips-pic32-header-move-v2-0-927d516b1ff9@redhat.com> <20260112-mips-pic32-header-move-v2-9-927d516b1ff9@redhat.com>
In-Reply-To: <20260112-mips-pic32-header-move-v2-9-927d516b1ff9@redhat.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Jan 2026 18:26:18 +0100
X-Gm-Features: AZwV_QhnJ9ztXIYztk-bUWG2DWjCH9tOitqOdGADe2tFkQurOXElAaxhsGE8iIA
Message-ID: <CAPDyKFoS-HBNm7m7AyGvm8nr82hN09qeAo+O4GADr-jO_mX+iA@mail.gmail.com>
Subject: Re: [PATCH v2 09/16] mmc: sdhci-pic32: update include to use pic32.h
 from platform_data
To: Brian Masney <bmasney@redhat.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Jan 2026 at 23:49, Brian Masney <bmasney@redhat.com> wrote:
>
> Use the linux/platform_data/pic32.h include instead of
> asm/mach-pic32/pic32.h so that the asm variant can be dropped. This
> is in preparation for allowing some drivers to be compiled on other
> architectures with COMPILE_TEST enabled.
>
> Signed-off-by: Brian Masney <bmasney@redhat.com>

I noticed Adrian has acked this already, but if not too late, feel
free to add my ack too.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

>
> ---
> To: Adrian Hunter <adrian.hunter@intel.com>
> To: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/mmc/host/sdhci-pic32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pic32.c b/drivers/mmc/host/sdhci-pic32.c
> index 7ddac0befed87e6e46acfa7593203a5b540558bf..2cc632e91fe454bf29c1da22e45135d5d0267f54 100644
> --- a/drivers/mmc/host/sdhci-pic32.c
> +++ b/drivers/mmc/host/sdhci-pic32.c
> @@ -18,6 +18,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/of.h>
> +#include <linux/platform_data/sdhci-pic32.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/slab.h>
> @@ -25,7 +26,6 @@
>  #include <linux/io.h>
>  #include "sdhci.h"
>  #include "sdhci-pltfm.h"
> -#include <linux/platform_data/sdhci-pic32.h>
>
>  #define SDH_SHARED_BUS_CTRL            0x000000E0
>  #define SDH_SHARED_BUS_NR_CLK_PINS_MASK        0x7
>
> --
> 2.52.0
>
