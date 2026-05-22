Received: from mail-vs1-f68.google.com (mail-vs1-f68.google.com [209.85.217.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B734014BB
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779463730; cv=none; b=K5ScQYFJp1+e6piyGLenoHw7YhAqFbQ/DKCXewEYlhjgMzU8B7lQVHBIYx/eLRz8jo2JtsqnY6GCaLTHYy6P+u9r1Zm0R0DQH8iUUgoJBeN7zCNvs+gZbfxJ9ih/Vg73oJkzyN9Cumwfgfl5nh+A4Yzu5bf95w36NYapDKxYNOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779463730; c=relaxed/simple;
	bh=kN/9y9XwGUDJ1nAC1IWWtL6XoKcE5qMK3/fWnrEnzQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RyRLGDiFC42/CvD93CO8KojfQ06IlPdVoZZZnfCwdGFQZcm5aNHj2IvI16UE1zGWUv+FUjgD5wG6B3P18L677k2qQJyBfT7kR0McMVw25IG+l10/G0gktA8q1Z6oIMQ/5gdAFj35eCOWktR0pfYIP3BQr0TkpEvTgj6nxBAg5NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f68.google.com with SMTP id ada2fe7eead31-6312af106e3so5851681137.0
        for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 08:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779463728; x=1780068528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szBb9VN5OI/LxN852+H6x+3LXcGPvGU0m4BLzBAkL+k=;
        b=a77YIxe1h/9jCeXqNV8CIOWKTisKswblFBInNsm2wJGdqkbV1YDzSbLfSKDZS1LejC
         mmOhGnYbTHg90y9ZhCQ/C3HqTrVwxFXR86DdjdpNbTQtMbLbymjQeRO1nNSHHIVymacZ
         z32MIAj7VYnXNITqSWs4rl2g2zsEYBU+ThGxlaxzkiHNUm2G7ZoYV4tJuUj9fiXDrvkB
         7FreK1YR/F2dhUq+Qjvdb1p49TUGvSfvKNMIyys/zTVZvY5H70WPk4jjlDyFNQg185Iq
         IGYGFc9ch2rBe3XRL+6mBFfxy2wm0+KCBxdFQ4uxVAbk3AUq3R3Y01eLp33AyAJJGZCa
         d/sA==
X-Forwarded-Encrypted: i=1; AFNElJ/U/qEQJdrg3L/hR1KXCKFVauN784bNbVZUiUcZBmRUf5zmlOJDg4QqGdKxOHIDeTtJMhGbf4v9JBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6UxX1e82pogfUO8dMr2fBpy9Ib9nEGkLVrIsLIbLb4/ueK+5d
	2EdIZXTxp8nhhS7kUkIsiLAKd8C77fUpP37ZI9TzNcprRMwZaDhFnE537eOsV0WyTJeIzA==
X-Gm-Gg: Acq92OGWlRDJBqc1z4gZgP2RrdumH4qVnaN7/PQuCX3dh4UJmxfH5uQmBeLIrzZatsi
	48a9oTDOoFKhW7bmU9qcfeKf9GtFce7ovhHTgeGY8cR0sf98jSRkNBnyUDIsWapk5jHUqCdFd/D
	SolvKcofYiDhX5wPZCWcPtuT/WvD6NExgnxK1v6pGw2G3W+i30hPbOkzgsEQTzqiToJaLmEgcQW
	GgCm1vWInAosKURs0gZb/FfKAlF5+GOZSxKzJQUhKRcfXen4hGSCrHoIBbnGreIBr9iqWlB8FJu
	3q8PiTOXHDeztifGlDs1vEMED6edOQiJihSoFqo6Ix+Huy3KFuMoGIGlJevwPhJRKPB1qglpPfl
	oQJqNJHfYEjKZhDDus+bYLoGztjAS4F4y2kLd2LW7lTh+NUKGc1pNdmAflTyAGVKL+e7BOSYPHt
	L/cvla+WBLJ/DsdOuFyn2MUp7x9EGoNWE01wYA3T77/ZSXUDQhQR+k2Ny6N1WT
X-Received: by 2002:a05:6102:c07:b0:631:23b4:8dce with SMTP id ada2fe7eead31-67c75680787mr2590172137.13.1779463727790;
        Fri, 22 May 2026 08:28:47 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96177c1a9e4sm1578082241.0.2026.05.22.08.28.47
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 08:28:47 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-6312af106e3so5851671137.0
        for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 08:28:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9/8kiyVOGrNAU+33yu7s7f+4DtOkd3zC61jZrmORhB6U2RQ5jhrNKfWqp/Po8yj6fYeAztwJlxDHc=@vger.kernel.org
X-Received: by 2002:a05:6102:f8e:b0:604:f29d:84be with SMTP id
 ada2fe7eead31-67c70e5f66cmr2706370137.3.1779463726809; Fri, 22 May 2026
 08:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504144534.43745-1-marek.vasut+renesas@mailbox.org> <20260504144534.43745-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260504144534.43745-5-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 22 May 2026 17:28:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUTsoEH60DBWCNnXzaZmfOcDfZ7vEaUgJetqqU-qwBxXA@mail.gmail.com>
X-Gm-Features: AVHnY4K2cO6mOrwYyMVCwX6fOKSnvdh0vCSY19G3lWwxUQ8j7rXhdTpY2ZF4U8M
Message-ID: <CAMuHMdUTsoEH60DBWCNnXzaZmfOcDfZ7vEaUgJetqqU-qwBxXA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] dt-bindings: soc: renesas: Document Renesas R-Car
 R8A779MD Geist
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, 
	Conor Dooley <conor.dooley@microchip.com>, Brian Masney <bmasney@redhat.com>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 May 2026 at 16:46, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Document the compatible value for the Renesas R-Car M3Le (R8A779MD)
> SoC and the Renesas Geist development board. The Renesas M3Le SoC is
> a register-compatible variant of the R8A77965 (M3-N) with reduced set
> of peripherals. The Geist board is derived from Renesas Salvator-X/XS
> boards, with adjustment for the R8A779MD SoC.
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

> V2: - Add AB from Conor
>     - Fill in Geist (RTP8A779MDASKB0F10S)
>     - Add RB from Geert

Thanks, will queue in renesas-devel for v7.2.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
