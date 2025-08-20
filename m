Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F30E32C32A
	for <linux-mmc@vger.kernel.org>; Wed, 20 Aug 2025 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755708231; cv=none; b=CNHzKykR3njaNvIC4DbEplfw31cQc7CEOcWVZ2z3djSgygP0fA6VgTTEruJTbfQ8deBKDWIA5ykK7PFN+iFXe319PHkvT7zlDNZo3Pm+PdsUfSoKXKNsD4NRtWl7PRfgLVDcUHxRMf5rsbIDpHJUN8JKVItv6AQuo8F/Dw7pd6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755708231; c=relaxed/simple;
	bh=WzdI1oYR8phntwLqYeaeesclKsoSMLbv6invCVoupTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLhugCj9zQMnCXB2kcYOnqRCpRTjCo39zlVoO5Yd8BpSstzY6rRrGP27LTQuJ4jmr5UgKmiJF5NsicaV/cRiF8Gx2NslYq/x9792KNXV+b7Che9P6HmGUMXnsdhvwZzw4JGLG5bbhj7f4eyc5Mjy4RsfgK7vEp7kYIL6fj/GroU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d8Oq1XSA; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d8Oq1XSA"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71e816e7f09so149427b3.1
        for <linux-mmc@vger.kernel.org>; Wed, 20 Aug 2025 09:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755708228; x=1756313028; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iQkujuB9vAN8hQhansFuXhh+VaQyrPhFjEbmZzXzSUg=;
        b=d8Oq1XSADB9peoTNPzST92bNBvOHz4O/SNw91zXmMQI52huCoUHHpYB6nhdh+NzsEi
         9VNTQtkJ3nc0fMifYFgdiWeqtPNGsmgaIHp/h4hxiPSrMCVx5k//MfwlszunXMicRhJ3
         8Ekt4wJRsDfrxlTlWk1Th2dkpc6Bp1vmogfgB7McT+3ZIdj0iABEb6AYyWno8AV3IjL+
         Uw/aACyYvDJ6l/I2NM1draQrPbKE89GS4VEIg33trLGq8HhxucePG5J6fYaZirI4ftC4
         zt1VPIUwbDjbOBOZD91/Sn5qwSoCOo4EHUYzXT3zNW+z/0KZl07khfbfyWTiciGczeHH
         JdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755708228; x=1756313028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQkujuB9vAN8hQhansFuXhh+VaQyrPhFjEbmZzXzSUg=;
        b=SXtkmSrNqpIXsGdEe7Uz1/yPTnrg5JKmyEkwFfGy3Lv3eO8+nDo+X9UJVYunqoCiYW
         2JQADW2nQpjCWpfyKlLrjtYgO9tdZ/Hxau03wN4jw/RmCUn4J42p7n67wCnbRT7Jw00r
         3gbyZ8rP8isQ+nbKu8psHT73vjnALUSZM2DUdZXsjg+etHOVRwTAa4N3OTwsKZb4VAMh
         RdBC536hRkzDVp5j/O8DnoCAFN0+VZCsbX8mMh7r0VabzaL6DnlEEtiS+3KEQL2guCEL
         IP9TmzXdUlYKCOKaa/WzrW+76lRNVzJn9cx4rgQ2f5YfmdsgiHmckuvsjKpkyoL5/80U
         4+yA==
X-Forwarded-Encrypted: i=1; AJvYcCWGxDBRQc4fihXH2mOlYvkMon2E9qHBtKenj+EByKBC+Sib3pp+ZFSfGo5p9DUdRjcp1ZyAh+QWKHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNOCyjFnnkU5wPLETGlEUx2U0fS1hBxZjrH90Ys0UE4e5SAaeU
	PxjzpV44f1nNl+vyi/iXzDJ5R4ETrgNW8LYn+FN0hgqdk1sSQeM9ttuX51Ft+dr+g4RdP43dhTI
	EzAUDEH4HSMKlTPwF+vERhQCPbO0qO7ziV69Ef5iKIjAVDx8CTe2p
X-Gm-Gg: ASbGncvDyIgk9TPvZPEu+9U7A/RN32UF/U/y3LqX5pj1gS8xvr6kj0rUXrJVyu8yXPk
	O7GdW/peNIX81mOTRDvX29/urFTOnyBSidCd8nZeVKWMA4e21PYJvVqiGXAW3UdXKXwOdq0AX2J
	pGQl6SU9Ex+AHBv8FA0VxxV0ogb6IRfnrcZjmDGxBvMb/8brvhuy2AdSxaKrNOkreWJOhW2XkWr
	cBl5+A1iPiypq+Pmow=
X-Google-Smtp-Source: AGHT+IE+Wt0j9bfvOyDxK4S5Sk+LF+v0ZkAtLY2D0aSLiBwAJ5C8bcVtX4TZmLbwWs4GZF94qJmrCp4P6UaXDpFQvm8=
X-Received: by 2002:a05:690c:f89:b0:71f:9c53:bac6 with SMTP id
 00721157ae682-71fb322b56fmr47409967b3.36.1755708228116; Wed, 20 Aug 2025
 09:43:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820104808.94562-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250820104808.94562-1-biju.das.jz@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 20 Aug 2025 18:43:11 +0200
X-Gm-Features: Ac12FXzu7BIyKdX6LwKtLISsnZF2ODfTKPqrr4vIhUqGLfAqz8wea0u8ZAdXy40
Message-ID: <CAPDyKFqvbWVxGU4mvffSJq_QgY33TXi=ezXxbvKyXe5eUFbqqQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: renesas_sdhi: Replace magic number '0xff' in renesas_sdhi_set_clock()
To: Biju <biju.das.au@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Aug 2025 at 12:48, Biju <biju.das.au@gmail.com> wrote:
>
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Replace the magic number '0xff' with CLK_CTL_DIV_MASK macro for finding
> actual clock in renesas_sdhi_set_clock().
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/renesas_sdhi_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index a41291a28e9b..f56fa2cd208d 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -223,7 +223,7 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
>         }
>
>         clock = clk & CLK_CTL_DIV_MASK;
> -       if (clock != 0xff)
> +       if (clock != CLK_CTL_DIV_MASK)
>                 host->mmc->actual_clock /= (1 << (ffs(clock) + 1));
>
>         sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clock);
> --
> 2.43.0
>
