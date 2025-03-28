Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291EB1D7E21
	for <linux-mmc@vger.kernel.org>; Fri, 28 Mar 2025 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743157341; cv=none; b=Ot3PinlPPjsd1DYXt9cRmh01014omG3mQsG6i+CsQm3ZHHAhaeKGJqYff8HOVV08wND0G7QjE/xzzwPfH5gik4D5l84SnlLPkRTbuEJxVE2OrXDGviBYKAdvLgWrSdqhC86bWY4kVL9HLo/IUwU9UL0o8QGWlNFuQio6mARaqKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743157341; c=relaxed/simple;
	bh=1EvdB14G9dZ9V0d+gy+JSmSb+iAYQGCNgOKmRsIyMfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QA1pVsBBkYC9I2hahvgKc1fQJbR1YYlei5cHD62ALlYFFc9IjbPYumkr6iSePAE10eCSf7DZWK1xOrWUMIX0vEhhEPnGl0klJl64Wr5F4GakMzMcmEZC7B5zFy/dcLq4bCvZHCs1QRpNb9V465BGumqC3ybAlZ/qOOdiQYyEk9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VIXIVEL3; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VIXIVEL3"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6feaa0319d8so15249407b3.2
        for <linux-mmc@vger.kernel.org>; Fri, 28 Mar 2025 03:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743157339; x=1743762139; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QWcdknvSCYeb4zRihPe/MxApMaJfE7/coMmdm58k8mE=;
        b=VIXIVEL3iR1pses4SVICAvRQoYKm3GrKW/gGsNf7jjGVM7GkO2q1XQb53KBo/m4Obz
         r8n5PEm5q9hJ83FrOpNfKyY+W1hwzleT79Dpdl+03WqmAQOrNoUzECTDjRTWhNafhPZ8
         N30bZ1g04ofeeTnP2keMVD6gndXLWONS1PUE1mYvzOzHDQ5QZhx0kCeJxOfYrv+5Rl3g
         2q+lXnf+6VsEvLUd1enBmPba+C0VZrxYcxWKm459zsjJeVnmAwko8a1oMPV/dK7aiMWn
         pazuDogB6I0SkpeuVmXImAI8SNzvjBm8QtiyOEnOnDQ4LxsX1hjYkQKURJi7IeYH4ECr
         hY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743157339; x=1743762139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWcdknvSCYeb4zRihPe/MxApMaJfE7/coMmdm58k8mE=;
        b=Z0UGmSKLlURC2/QihAb1PRg2d/OgLjR4Z8cWqbXhe/qLb+8sgIlh+Y98pKA/nkZYGU
         6PMeVCocMJ9SnHFD0wKK5tswiZ9phcKJOUqaQre8pjk+fbNEuF+3MvF+dmepJ1nFZrPv
         VZ4OS48xOlLrrttjOgf9UATKJ8aO7QmJ5qJs0EacIt3dXljxENHMZ05FQOoy/xnLJuS2
         mDt+Ld7K9cWfNq5f0qeVIa7dISov4d1LqpQO1EwiwTeHxe9EVLGG8WdhdONwtay/cDIc
         i60ZmYX5L5JfKKDxAobKMKm+UpvrBF71gECecnN+mF6aoNykRU8NRdVBITVdflmdodxL
         pD9Q==
X-Gm-Message-State: AOJu0YyUj4sb5eDxEHAqNbZ/xuD15TIcgJKZkaM3Eg58pvd7v4dV4HCQ
	eZZJApoZhoJQB9DwGYZuqk8XP6GqOCmsSqimw5JPJ38LLJv78x3801yZ0c1zzmggcxC9OztfZ9I
	2jEEryTPQ0VwlVWR8DxTK3QydEDSj1HCpW1s5Tg==
X-Gm-Gg: ASbGncu4XeOs9gZQ7QYpKW5hgE59xEsInznFYrbNBTERDuoIK7W9tDWB++/4az0F96d
	yBfEtiZGdTmlyTLn1ffzLmkTm+vEBaFadH37n87c5BQJQg2vOscIXmb1GKvqqyNWGUC5cTR4LYO
	/wPpVS49OWDG5YnQyUlWpKuNL17XA=
X-Google-Smtp-Source: AGHT+IF+THyscD1I70Q1OyNT7wZ9pN5Y8ZMr40r0UC0Ra/TZGyedSTAVl7xxm7Ivr+fxGPflDlGfnf1oayC1W3EzhlY=
X-Received: by 2002:a05:690c:9b08:b0:6fe:bf9d:8cca with SMTP id
 00721157ae682-70224c5ae42mr93037477b3.0.1743157338910; Fri, 28 Mar 2025
 03:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320140040.162416-1-ulf.hansson@linaro.org>
 <20250320140040.162416-5-ulf.hansson@linaro.org> <PH7PR16MB61960D396B3E5B61571F7F82E5A02@PH7PR16MB6196.namprd16.prod.outlook.com>
In-Reply-To: <PH7PR16MB61960D396B3E5B61571F7F82E5A02@PH7PR16MB6196.namprd16.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 28 Mar 2025 11:21:42 +0100
X-Gm-Features: AQ5f1Job6rz184fUICiPRY1Ma-qfbAVYw2uwJkaEoJZeRzZpT85dOgBmc4R44BA
Message-ID: <CAPDyKFreJu8jZXoBJ2J1Mgj+OOAJX5rjzX0D4ZfbTj_uVrPKPw@mail.gmail.com>
Subject: Re: [PATCH 4/5] mmc: core: Add support for graceful host removal for eMMC
To: Avri Altman <Avri.Altman@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Mar 2025 at 09:13, Avri Altman <Avri.Altman@sandisk.com> wrote:
>
> > +/*
> > + * Host is being removed. Free up the current card and do a graceful power-
> > off.
> > + */
> > +static void mmc_remove(struct mmc_host *host) {
> > +     get_device(&host->card->dev);
> > +     mmc_remove_card(host->card);
> > +
> > +     _mmc_suspend(host, MMC_POWEROFF_UNBIND);
> Couldn't find how _mmc_suspend handles this new power off flag?

Right. You need to look closer at mmc_may_poweroff_notify() as it
should return false if MMC_POWEROFF_UNBIND, unless
MMC_CAP2_FULL_PWR_CYCLE.

[...]

Kind regards
Uffe
