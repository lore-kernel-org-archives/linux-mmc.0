Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3732DF6EA
	for <linux-mmc@vger.kernel.org>; Mon,  9 Feb 2026 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770632755; cv=none; b=tKJHItUKaIiVtvdv1UFwAMjGjVzwz0wLRebG9iZgXBtaCHuYHSsDkVLB8wWYXB+Y/FzKPgQtjeP0dCWI+CDRn0LswC2xNBMITapfCsCP9zy3uttf12vxo9oiOZNpxvSLTKIIcj5Z/NZkPpuMra/Q1ZGhOS/0RUe6xVk+UzWReYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770632755; c=relaxed/simple;
	bh=J73vKAZhiN3K6G/5fpGigw+8duj0Td3xLp2ybYYDes8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFUGFDQn6TEeyNW27LSeNWjbx3iTK46nsT8IR6ddPP7/p7s7g4m2sMcfk6/HJDgg0uyujCv4Ke6ygLaEaa5lhQ7dmcMfGcMkxcH7eCl81AJ0cKTNN8dXPJdfBnrcdBUlYlsFDiX1qRYmUqUqhqBRK86vCJYRVCDZ0ozWjSbW/Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c6aaf3cd62so427287385a.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Feb 2026 02:25:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770632754; x=1771237554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=55b+49cOY521wvVXvsz0WcOQjNDu8cxcjrZIHfMxzy4=;
        b=Mg2hh/emeiBXPCOPwHIphRUwzFCnuQm4InzDx1j78tCZn9WWuJXbQSqh8h2MnXodqy
         lvxxblgcgzfDJBlgiEHRYDHsL4fRnTfL3jOquizt7HPADqNDAdqrMZpZL85Xs6/ig60K
         /Rc19Li6U6Jcy0+S2tP9XN64c/YeJ/zig5RpF06pIH05dUMVEd0aO5v8dUNLznFYb5V5
         KHPzaj1IcSv4leOGcyyDVU2ou3yVEwlP/TzJ/5U5D4Dj31TTU7bo+fJ+olEEqVcGF1tA
         RcZjPK2BrcZLlufl5cNnDWck2Pzf27Mzt+lTQJgPTg3TFwBYpiVjA/KRzUFrM3/DJ0Lg
         hoLw==
X-Forwarded-Encrypted: i=1; AJvYcCUwCw6mVcps8E0ddG82phqZybsd9XX4rQg7C8qPVHS4n/q01e1QNnn1DvxrX4zhhqcx1aIx/5G8ZwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR1gH5TRhvDrwFuI57RKbQYdZKxftRsElmpVxcWnT5V+EnKlyC
	p0Ci/qym8sjhUY3efAukWWrj4AgTQCkMGBe02quFO6+8Rb/DTxqGzRmX3UI4JVv+
X-Gm-Gg: AZuq6aJ3olanLtYBAcwYGUzhf7KhDajpuSdF8VySXHiqgPEleSjRuTWiyS6jTW9zlrk
	LMZWnrP1cyyVhc6eCAtfC61HMSjIKm2jI4J0X+V4/4QjyEXsMjHL6M3/kRmgUxYOQ7z1XQhdjNx
	P8i/lX9obf0Khuk8DsuWbRbCLCEbk6JKLhJ8jAtmXZCDsmwVKL9uurRNfqveAo2tjDVMyBnt2u7
	V94m4OdmtB7xoVstmp8Ac7NYTPqyGT8XGnQlgW8BNl2x9jseRqwpz/rf6M/UKCgAz1uhYu7TbhI
	4xDmp+n/DMi5snrgUWmB/OdZwzdaxESwi7sM/SNnWdicEWTgLC2BgrO0neQQc8D9I6ar1QR+3Y+
	kAM7eI59LNldVPZNC0bW+oCl5E6O3X61CdwdxVPOnSEsPK8d6mdqx/sVgh5GJJJPtPVIIGT5qDA
	3tDdthd4Niom3ItF9Kr0Kw+mq8rClB9O3caizB0XO936wRDmBFFT44
X-Received: by 2002:a05:620a:1902:b0:8b2:eea5:32f8 with SMTP id af79cd13be357-8caf058629bmr1339160185a.34.1770632754223;
        Mon, 09 Feb 2026 02:25:54 -0800 (PST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9ee8662sm836508285a.37.2026.02.09.02.25.53
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 02:25:53 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c70ce93afaso451203685a.0
        for <linux-mmc@vger.kernel.org>; Mon, 09 Feb 2026 02:25:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwvEcUYq4Kywfer/to7IxIRt5ztjQkIz+VG6yUHwc2egF7zsuQ/rzR6JIVxrWhfynOoTlGH++PJg8=@vger.kernel.org
X-Received: by 2002:a05:6122:3c54:b0:566:3d03:8e1d with SMTP id
 71dfb90a1353d-56705febb0fmr2935090e0c.17.1770632257982; Mon, 09 Feb 2026
 02:17:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com>
 <20260203-rz-sdio-mux-v8-3-024ea405863e@solid-run.com> <b7dcb374-b79c-4e9f-ac30-2f507127cfb3@solid-run.com>
 <CAMuHMdU01vwif4H6H-cYUfW0Y56fN6Anp9F4Ru7q3fveNqqoXA@mail.gmail.com> <39f3891c-c05a-4e10-9ad4-ab3cbc6fa70e@solid-run.com>
In-Reply-To: <39f3891c-c05a-4e10-9ad4-ab3cbc6fa70e@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Feb 2026 11:17:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVbi=2puhk84k+FCDXqkQ9jFsy0rsseQiFCF8i=KsR1OQ@mail.gmail.com>
X-Gm-Features: AZwV_QizeLChl5bqEs0QtuubG3nlVKZbEpUJtWLc1m5RmCDOEU_VrUSeQPEZi-k
Message-ID: <CAMuHMdVbi=2puhk84k+FCDXqkQ9jFsy0rsseQiFCF8i=KsR1OQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] mux: add help text for MULTIPLEXER config option
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Josua,

On Mon, 9 Feb 2026 at 11:12, Josua Mayer <josua@solid-run.com> wrote:
> On 09/02/2026 10:06, Geert Uytterhoeven wrote:
> > On Sun, 8 Feb 2026 at 16:16, Josua Mayer <josua@solid-run.com> wrote:
> >> On 03/02/2026 15:01, Josua Mayer wrote:
> >>> Add prompt and help text for CONFIG_MULTIPLEXER to allow enabling thi=
s
> >>> option thorugh the kernel configuration without explicit "select" dri=
ver
> >>> dependencies.
> >>>
> >>> Select it by default when COMPILE_TEST is set for better coverage.
> >>>
> >>> Signed-off-by: Josua Mayer <josua@solid-run.com>
> >>> ---
> >>>    drivers/mux/Kconfig | 8 +++++++-
> >>>    1 file changed, 7 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> >>> index c68132e38138..e31c46820bdf 100644
> >>> --- a/drivers/mux/Kconfig
> >>> +++ b/drivers/mux/Kconfig
> >>> @@ -4,7 +4,13 @@
> >>>    #
> >>>
> >>>    config MULTIPLEXER
> >>> -     tristate
> >>> +     tristate "Generic Multiplexer Support" if COMPILE_TEST
> >> This didn't do what I thought it would.
> >> It was my intention to allow enabling this through menuconfig / .confi=
g.
> >>
> >> With the syntax above menuconfig shows:
> >>
> >> =E2=94=82 Symbol: MULTIPLEXER [=3Dn]
> >> =E2=94=82 Type  : tristate
> >> =E2=94=82 Defined at drivers/mux/Kconfig:6
> >> =E2=94=82   Prompt: Generic Multiplexer Support
> >> =E2=94=82   Visible if: COMPILE_TEST [=3Dn]
> >>
> >> This means it cannot be selected.
> > Looks like you haven't enabled COMPILE_TEST first?
> Correct.
> But CONFIG_MULTIPLEXER should be visible always,
> not just when COMPILE_TEST is set.

Why should it always be visible? All users select it?

> >> Instead I (think I) should use
> >> default m if COMPILE_TEST
> > No, merely enabling COMPILE_TEST must not enable additional
> > functionality.
> >
> >> Since my patch-set broke x86_64 allmodconfig and failed merge into
> >> linux-next,
> >> this presents an opportunity to change the above as well with v9.
> > Ulf has already applied this series to mmc/next.
> What would be the process to fix the build error for x86_64 allmodconfig
> now?

Incremental patches, cfr. Ulf's response to [PATCH v9 0/7].

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
