Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFC03806B3
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464096; cv=none; b=ORjVSKg6dY/CAM8XSeCLjv8FZVVjMhsaC1zzSiQHtWxw8m6eTkJWf0mfvqoKggZICJ18ve9D9XAucagmoBwgdgGjHf0sMKRvTHsEp9xNCD6N51MPWfbnXal2/MEHQ2deBowSyRYjE6yqmrmQERRXpfp3jSqC0dMMCNyisMhaWM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464096; c=relaxed/simple;
	bh=RcKm+MJQR01WbzgcsBzYoy8Uo599kOW4Z1qyK0a9O74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESgsnwkHeDhoAfcZEmYDhrgHIXANwnziIaJKGWlZSZFadogjKJggRlkHi/XAAQBvDDQa0LItmwDuxYXDFeotHNvOzF9l/dR6s1JfxCnOoZYS90kgapXYUxKLq4ZLPujVq1763qs7GSMbAzuJ/yrkRFPQSoehHe4riw29lC+pq2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-6314cc192a4so2289498137.0
        for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 08:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779464094; x=1780068894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FixydBMStjIkh+xhknFyVmJmnf/BoQ9WGZ0+yOe1GDc=;
        b=sKJko2kIKXYfuzCeTRFxfIBO9O3FBd7YihwVSsp/U31r/bFiL29DmAW9N9orgvP7dK
         zEsMad9hXTweMcmAjEbBelJrjuGTipeF6CZwZ6q55EvRQbwiIF9wVGNduyb9KFHTaSsi
         k4hb4TMaTLSYUFM9rbtjeLIEFJNhjY3+t0cBeDGxHnZU9fCiwia9CA/R5tKGPSp/6Kwn
         ceiqnIxFlVwdgcQYC0jCSZF58YNnCqPfInHyunVEylC5btVrE3VnALLKXe1xnr+tyjx7
         28f7A7bhYFlpKaL+qK9NUvKV4cSeE934L2Yo6DiqE02QqE/24Vjei4JjxJTyWbjagLPW
         up+w==
X-Forwarded-Encrypted: i=1; AFNElJ/GNeWxHXWQdiwhIh+eGTsfqb3+GdYw8aRTNx4DOnU0q1hduUa4eXJUJxeH98iBH7jk45Ek+RlnaDE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf2tMaaJT4npG2yCf+gbxB+TcIPprvJN59zEvtYJR2O77ZsLPy
	IsWEQzkXiObB/Af68IH66UoLwTs4FzRJxMqElrrRAqnN2kfvjOInviuwpZWeKJS+IbQ=
X-Gm-Gg: Acq92OFt9xzqgzPWRGuOv4F0PVp++G7lGYCdZb/qu5qOaaxWvKcz586kot0ECjY2cux
	49r6dN2Kk9kylgfMfBnmXUSRF3VQNZX/IBZ+XGuRXw6TqvfBnD/+KHhi0UmnhYwMKmuq7yZOBSi
	u40u3D69ccM7qeCM+dRQCt71Ka4RmYOFDew3nSTTVDqpYUR1a8IF2rEgbDyQPtb4U2BBNnspwxr
	HgOcwvZ6idBB+fVNPQaSyT5dGnME1fW73BI5xn6jD86Q4qyllBOT42MqnSwzBidTkGFMH7Bkow8
	TS9cvWTI6TYJDRD2giUouO5shG6kJU08IEovogFRolGAcj2ICD1pRz6r0PZBEJTbLFcyQ648BSV
	fdUbaXQg3ZtciWbU1UeDzDlw1o34dPZIpxVkfwRwPByV+fBvRVJ5TXJB5jLFtwH5XkFlA0EP5EO
	/ee38uN2LEFjlO/N5cEEVHVURWRlb7ziQRT05d7preDXqrAikCPoWfi1ILXYvtoWMC
X-Received: by 2002:a05:6102:8009:b0:634:d42d:15e2 with SMTP id ada2fe7eead31-67c80b74af7mr2099315137.26.1779464093756;
        Fri, 22 May 2026 08:34:53 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-67fd8851f5bsm1747345137.3.2026.05.22.08.34.52
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 08:34:52 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56a857578a8so2979623e0c.3
        for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 08:34:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8byo9ETdz9OrPyQLfKUQInue6Z8uEC5iIxEikMeAqcZ1prZtqMfJrxUIg6JibRZfxnrEqSq09Fous=@vger.kernel.org
X-Received: by 2002:a05:6122:4d0d:b0:575:3b9e:db3e with SMTP id
 71dfb90a1353d-5865d70cb8amr2549460e0c.1.1779464091785; Fri, 22 May 2026
 08:34:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504144534.43745-1-marek.vasut+renesas@mailbox.org> <20260504144534.43745-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260504144534.43745-7-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 22 May 2026 17:34:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWGsdn-8R7BeOfXOtrhHNW=FKW+rdG8cH1r=+GDnAE+Qw@mail.gmail.com>
X-Gm-Features: AVHnY4Jf1Pww2GHfOAXrLj07kMcY44kD7u6kHAIZKMSWedE81wNkTdVC9LQ0_SE
Message-ID: <CAMuHMdWGsdn-8R7BeOfXOtrhHNW=FKW+rdG8cH1r=+GDnAE+Qw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] arm64: dts: renesas: r8a779md: Add Renesas R-Car
 R8A779MD M3Le DTs
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, 
	Nguyen Tran <nguyen.tran.pz@bp.renesas.com>, Brian Masney <bmasney@redhat.com>, 
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
> From: Nguyen Tran <nguyen.tran.pz@bp.renesas.com>
>
> Add support for the Renesas R-Car M3Le (R8A779MD) SoC, a variant of the
> R-Car M3-N (R8A77965) SoC. The Renesas M3Le SoC is a register-compatible
> variant of the R8A77965 (M3-N) with reduced set of peripherals.
>
> Signed-off-by: Nguyen Tran <nguyen.tran.pz@bp.renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

> V2: - Drop DU until it can be tested
>     - Reinstate sdhi3, switch SDHI to dedicated M3Le compatible strings
>     - Add no-mmc DT property to SDHI3/MMC1, because MMC1 is not supported
>     - Disable ohci1, ehci1, usb2_phy1

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v7.2.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
