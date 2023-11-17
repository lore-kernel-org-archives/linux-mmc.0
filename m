Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tz3UWd6E"
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C02D52
	for <linux-mmc@vger.kernel.org>; Fri, 17 Nov 2023 00:49:35 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso1791929276.3
        for <linux-mmc@vger.kernel.org>; Fri, 17 Nov 2023 00:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700210975; x=1700815775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fg3YPX5Dy+CQX12ys+Q6QMbQjdpnTP0C/HigltSDFY=;
        b=Tz3UWd6EkA+MEpNFaYoudS/WKE+j/ZaFOD6egZQAR2qnkVg6M1AVuYEic578SmtuNK
         g5QBXr3Gh4Xz2OnaeYJkCKHdaSIAFatAqfvtJAbnsa3qFkSMdV7VsaJDm8OiyoFish6F
         cJF7oY2W+gmkBa+NlKJUNGsG37XJTOAkazxJjqZvwaGqDTLsngAgScFWKIY8z7dIo37D
         E3X0YAazMijX7YnZXd4u0Yqs9Gg2ak6QRLBHvPx+pSVp/J27CUZS3ucxcCsaynWWU5Hl
         8zmNB+ac91rY/SHtXecsJNSqor5ErZnktpTkEZC2lCE27eOESFqIfrDJMzZbyGYhZWr1
         fobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700210975; x=1700815775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fg3YPX5Dy+CQX12ys+Q6QMbQjdpnTP0C/HigltSDFY=;
        b=aK3dJrqapPUoJ8muR3dgDY4jMi3vCyrSbhC1wURZEruN2whuUtaClP578TR6B6LJxQ
         bLAnWHM+co/ustTJrWPN2lCsOc2lMGNSPraxEerSpsppNjDF8NgOXoNuTiImer84ban+
         HGDryFeL2enZTeQhOYyow4G42UF4jug/XOHynCxLm5UFxER2be1p5vIo5Rfem2+eUuxd
         U2w0ksGPBUHlBcDvmT03SVYJ23i1jl1QpKPkOMzhTzKyaO21HMz48VOqINQB7hvzpeDB
         vf3b+cwWsCQsW16YWV151ln/dARbgam1mg21ImOVn/GHIhjnSThyAIWMK/HUrVDEJvOh
         l2KA==
X-Gm-Message-State: AOJu0YzE7tngXJcJd5CFm5Gf200qMm4+p6rUUFgMuNDCqM4GXYbexqXc
	gkWLtSpeSWCm6ea/A3qTtrompY2d0HcJ+DjechASKA==
X-Google-Smtp-Source: AGHT+IFYhDoHCjgQK3p6R3RwwqaeYz2G8wdxXKbFS2D8YfO3O8hqxeedYpiMAEMMfvXeYoSosyPEdusuHlhtcdD01WQ=
X-Received: by 2002:a25:74c9:0:b0:da0:447a:e9d8 with SMTP id
 p192-20020a2574c9000000b00da0447ae9d8mr19574769ybc.10.1700210974960; Fri, 17
 Nov 2023 00:49:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231105102944.1974512-1-avri.altman@wdc.com>
In-Reply-To: <20231105102944.1974512-1-avri.altman@wdc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 17 Nov 2023 09:49:22 +0100
Message-ID: <CACRpkdZB_auHQan5Jq5FbO0wqnC6ns5Y_SzqPN7t2gGkhq9jHg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Remove obsolete quirk for Sandisk cards
To: Avri Altman <avri.altman@wdc.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, 
	Dominique Martinet <asmadeus@codewreck.org>, phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 5, 2023 at 11:30=E2=80=AFAM Avri Altman <avri.altman@wdc.com> w=
rote:

> This quirk applies to an old set of Sandisk cards that are no longer
> being sold for many years now, and it is vanishingly unlikely that will
> ever meet a V6.7 kernel.
>
> I came across those old cards when I tried to decide what to do with
> Sandisk cards that their quirk is designated by OEM id. For many years
> we read wrong oemid, reading 16 bits instead of 8. Fixing it however,
> turned out to be impractical, and it's better that each eMMC vendor will
> handle its own devices.
>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

NAK why are you assuming these are not in use with v6.7?

One of these eMMC cards is in use on Nokia n900 which has an
active user community:
https://wiki.postmarketos.org/wiki/Nokia_N900_(nokia-n900)

I am using several of them on different ST-Ericsson U8500-based
systems, including the HREF reference design that even Ulf is
using now and then.

Yours,
Linus Walleij
