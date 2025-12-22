Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E794932ED59
	for <linux-mmc@vger.kernel.org>; Mon, 22 Dec 2025 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766414863; cv=none; b=i1C8/kD1lAwAAcJi5qK5CR2LkULt5PKhWQLOG2Kg5SN9FJJ0Tb5xUdeMHAlSaLMQLaZrc0Rn2IXzUDnbhYgTejIycptvpk7KqoDrjsszK6F75hZN5UhUhEbAaZFlmWTplitjlLzAXfRs0ymur4ign8kiAZIydF5+C08jqRY5Xa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766414863; c=relaxed/simple;
	bh=IwLjLCoIOYSxZJTADglHFhXYcy2He7W4GE2tlYf0bXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPxUu1iX5fmoI//DDD3f/9POuvg+o+1ycU6KTvOx2a4lk3wDLARK8oKUm7W/7yYKskFLVTwCihb+tsAeqhz5WfhjIXNT2UlT/vDIDWSX85BwuwJbaN4f7aJ5fnJazRBMTfrb0L0tSUv0fRjDljEGejy651TzDSTymlyR78zhpgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DAB/Amyf; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DAB/Amyf"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59a10ef758aso3299060e87.2
        for <linux-mmc@vger.kernel.org>; Mon, 22 Dec 2025 06:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766414860; x=1767019660; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lNpWj6TBvVji/fHBEAyDcOFnMWFot5zrE/hRwsxnXVY=;
        b=DAB/Amyf1kdMghWpvNsR5yNnMf+GdDvgb0bA4+59mA0CrIcjf0meQgWipWa4qgI0+u
         QzmXsaKh4CDGdPAVFemA6mB0PY7nYeYTfFKf08TKNBK7/79eZ+/5axG1Oj+c5gAmAFfg
         T6+CWEWvYf5iQFoFrZGr06kU0xwOi/gsXNB3kQcCCxDDaqnVlheA/H95h4OGQdIrQD1T
         DuSAeDBryQG0Va3VNcLhpD2f+qW6b93O1bCz7Ls5M2R8ZzuC60dez2dFPM0QaMrYu6X1
         4TJcc1dZY6C1qQanrLgSyh2HkvSgJUb+rXBU+gv3hnl/FjGW4kxTqLG3nbaKx9Smpezy
         zmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766414860; x=1767019660;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNpWj6TBvVji/fHBEAyDcOFnMWFot5zrE/hRwsxnXVY=;
        b=YJSJ+Q3rgQTa5vz9P28bSWx5lC7HsTii4ewizw3c6pbwXnxRU32FaukFE8K+I9mc8X
         fKYMXwkcggeP9YlgctgWxrkhZc+MSxzrv4+T3jFQ2ctlYrQ1ONXnr6VhN05VnZ+hNsQN
         fLHMhoTawxV5KXbBFOTKEXXu2CjYEJwkRTutpMfskZgFcdPS7pw5rZp7n7VgkXt4Ht4/
         OjPaBcn1YNi5FZ5lm5OkaeiAZlKP76e9DUA3pr55nzEOAJrdUXjalEkKM12WlZ8Ah4EF
         HH4FamllQsYz2OLBG1hdoL2iYqoGwWI7K/6TxjlMx0Ww43d2ZeDrfSh8TvMeeSvp+nck
         6JdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEOH+3QCFWvY2X4TyPvOA8qlC4/RQlkLvriGzeK/bumJ/gjGf6IwaHA4gGJh7P1VouJ6gy0S2katc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhVZKhgvNnLck6TL8VMtu/2miG1Bo/jf0yWiHndkFtSg4KmbfL
	ZVqmK9fl8TQ+AaOEmuJsw+jSy17xm+wPnwnkCL3Ok+F9Qf9Pf9uoO9IM8eTbAt8SBLeuK6m+EYz
	Yn23E+p/LzDZtvHQDLHeeJWgXtKNEdkec4CuP7WZh3w==
X-Gm-Gg: AY/fxX7hndtWpLc90fOF22my5WRG4BCuc71LXpQ3YK8h0iluTk06Bwe/CCxzEg4X3oS
	zznCr57bpP31+oLEytjPulWYk2stClhkEA2yVAhidW+RaE0cOJ1m5LXv1Nx5KZJ3CGfEOdpL78A
	y93vPou9hOg3l/iIXdwAi6tgnIdaE6xp9Dq1ejXbiOrBtM5A83G4RPhrKKuS+ttZm3e8eHS9Adq
	9h9i+PNSSInlls+pE02P8olxpFQVUlFWhnzO1SpfH78qhuKXAg3BJDi4Eoa9bH3DkkfRmHt
X-Google-Smtp-Source: AGHT+IEmZoekCpdFdxCX6++mG8wezcWmjXxPG5ogJ3p4YsZ2il+JIIqimrrt74JmCImmja/XHDzRdip0knGEk5MWYgo=
X-Received: by 2002:a05:6512:e9c:b0:598:faba:c8fa with SMTP id
 2adb3069b0e04-59a17d006e1mr4286628e87.10.1766414859977; Mon, 22 Dec 2025
 06:47:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210-rz-sdio-mux-v3-0-ca628db56d60@solid-run.com>
 <20251210-rz-sdio-mux-v3-2-ca628db56d60@solid-run.com> <CAPDyKFoYd3WKGrjD3DEzZH8EfgZPmRkrqL=rdoKNuAADrvz3Eg@mail.gmail.com>
 <20f2128c-c6cb-4b13-aa08-b93e540f5bd9@solid-run.com>
In-Reply-To: <20f2128c-c6cb-4b13-aa08-b93e540f5bd9@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 22 Dec 2025 15:47:03 +0100
X-Gm-Features: AQt7F2pGUIPrw4OqWueh78ppZDBGwQc_mhY3RygUrq6e1L74fXopGZ4K0V_QvZo
Message-ID: <CAPDyKFo2jsV02qSDBSZTewJjV09AMO8iETU5Uxqz+GBnd0JY6g@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] mux: Add helper functions for getting optional and
 selected mux-state
To: Josua Mayer <josua@solid-run.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Peter Rosin <peda@axentia.se>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, Yazan Shhady <yazan.shhady@solid-run.com>, 
	Jon Nettleton <jon@solid-run.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, 
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 21 Dec 2025 at 11:38, Josua Mayer <josua@solid-run.com> wrote:
>
> Hi Ulf,
>
> Am 17.12.25 um 14:38 schrieb Ulf Hansson:
> > On Wed, 10 Dec 2025 at 18:39, Josua Mayer <josua@solid-run.com> wrote:
>
> cut
>
> >>  /*
> >>   * Using subsys_initcall instead of module_init here to try to ensure - for
> >>   * the non-modular case - that the subsystem is initialized when mux consumers
> >> diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
> >> index 2e25c838f8312..a5da2e33a45c0 100644
> >> --- a/include/linux/mux/consumer.h
> >> +++ b/include/linux/mux/consumer.h
> >> @@ -60,5 +60,9 @@ struct mux_control *devm_mux_control_get(struct device *dev,
> >>                                          const char *mux_name);
> >>  struct mux_state *devm_mux_state_get(struct device *dev,
> >>                                      const char *mux_name);
> >> +struct mux_state *devm_mux_state_get_optional(struct device *dev,
> >> +                                             const char *mux_name);
> >> +struct mux_state *devm_mux_state_get_optional_selected(struct device *dev,
> >> +                                                      const char *mux_name);
> > Seems like we need stub-functions of these too. Otherwise
> > subsystems/drivers need to have a "depends on MULTIPLEXER" in their
> > Kconfigs.
>
> Currently the drivers that can use a mux select MULTIPLEXER in Kconfig.

Yes, but that's not generally how we do this. The driver may not need
MULTIPLEXER for all platforms that driver is being used on.

>
> There already exist a few mux helpers both for mux-state and for mux-control,
> and they might all need stubs.

Correct. I think we should add subs for all of them.

>
> I'd prefer the restructuring of kconfig dependencies being independent from
> adding mux-state functionality to renesas sdhi driver.

I understand your point, but adding the stubs isn't really a big thing
- unless someone has some good arguments not to!?

Moreover, since the series changes the mux-core anyways - and
subsequent changes depend on it, I don't see an issue to fold in yet
another patch to add the stubs.

Kind regards
Uffe
