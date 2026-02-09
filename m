Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4C738552A
	for <linux-mmc@vger.kernel.org>; Mon,  9 Feb 2026 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770655747; cv=pass; b=OJUr6zEkYAcNS2uNvKOUudcRF+cn++nrCNpVLPzAq91grqVJ8c+YgmE5zmY5yVX2klxOW261hhFchg+smSVSkXvgoUMQwWpIBSMxqXdsR1W+J0DkJNo7ZBL2zpdi4nhynxr0VeYdKDszZf278cIsjPtyRkg1YRHW0v+pj57UkyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770655747; c=relaxed/simple;
	bh=e972ACE1KBb81KyEkGcx+64PEjeQZgX4SBpIgZiZ/gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SC9jicYuA3cjaJPjraW+Q6S1beFPiji8CKVYNzofEjTznsprxQav27NxR5s4lulyo+thUIX+0j1lkJveM0+knDIuXRcXcfuNDU1ZqQEVrqXCPxLnsz63dVuOAac/Qv14hzkAYQcCvDRAtPa0/2SU2SwSnxaNASCdikRv5ngaJTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fp6d+grA; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fp6d+grA"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59de6abf324so3848936e87.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Feb 2026 08:49:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770655746; cv=none;
        d=google.com; s=arc-20240605;
        b=QkZSSF3/Hmc6s+m7ryxDO0Vgc78aMUup2QIiorLYBVXEH3YBt/m5bLgvTxKfPd5LMO
         su9hQhmfTbvB9O6RSeOQjTfHSxaJiAC04kn58gft7jSdXEA4Skz13hHuX2icwxCUSj5Y
         pzv+4Grwo5Zu4T+gc/vYlANlNi3zCATzUEVCSNtsnv8sPMUbvVwoKyijv8GeN8SO86dJ
         FOIYjkbCTXl9Y8XA8pFpu7Pd/BxDVN14QvWq5c/2Dac+WbsLNo3TsurBEDrxvV2PwB3C
         2aBWwII1UfCWxb/L6za6AlIYzTMOlssuKdpLLrjiuciYrcgHxL8IYwbgrx/+/cDVWe8l
         I05A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=e972ACE1KBb81KyEkGcx+64PEjeQZgX4SBpIgZiZ/gI=;
        fh=yKkgOg9e88txeMHlEDjOIVArBQrHYqVR/GKOQZOReBE=;
        b=aOj6VpE3WasjgdyBRlwI5WDjkh8uJtpIDH4o2dtyhk8K8j1hQ9+3QMefVgh63w3abf
         iIxiGfvcZQnNb0+sx/xRkbIhfiJZfTQ4jNMC46zYXJuRFx4gxUGOT/1xscca6d5ezUjH
         tKYZ/tuP/JTgZUvC0im02pXDy5v/PH4MzfmIXLUphEZK22mUoOs2uQUqYfdKUduPz1CE
         YWNgTHLC+uP+udyU79QS045n3DHBvHD05GI4nnJCfKxQTnZ0IFjEYc3FZAadV98BbrrY
         XJpeAn6vjYYQA/ZRI8JpiCnxN7Hv/ynRJe3ZUdhKArCs3y36KXR2OtdHxVCzLOUO0iN/
         JPSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770655746; x=1771260546; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e972ACE1KBb81KyEkGcx+64PEjeQZgX4SBpIgZiZ/gI=;
        b=fp6d+grAQEAUXI+9d4iDRz+MxzAqT7bV0sjxYFmSEfcykDarYrVxvozFsS6xn3NPla
         D13NVlYbrEpOUt6Fgfw2Hhg3EAQ3P5LztjmtSeVMKZrgLHpSEnBh+X4vcA0FiEvHsT4b
         GIt0L89iAoauEaCRY72qO76frNlCS72jtKXqSvbAwhd9hb6M+l/INDa9QADMeJCi6DSE
         jF1LrxcY7EBHBSDAkxKjszvskMnKrUpJEnuIV5xRQFSWPDNxQrrEP584vq2KsYwO+0jd
         3VDN+ewqwdYGbI6WqCFwWWsiHiH+9P2+ynsnm6YSFrvoYtKKWSJ0RwMSdbwVhRzTqyVA
         2MfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770655746; x=1771260546;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e972ACE1KBb81KyEkGcx+64PEjeQZgX4SBpIgZiZ/gI=;
        b=pp0Rv6HUsonWg8a11D8SdiUtooe4LORTthdJW3gBk4GZQ9qhi4VYr0Iecy9k9j5STm
         D46Arc1AEJGj+iw9C6TLzy++IHSVMTXxv3zS3VajIndLw9+Pg9TZu8T5pKUmqFCxFW2T
         oZfF0tCmHTvkwfsorw+zyzWSHctMT1w3nuHPUblmuvygFjtmKjddIFCkRsXtanEHyoUF
         sRVS/C412rC85sISI4RiENuhhnV9osFCgDCHN0RcyvIL4rLU3G0rjBguJmjUrc+jKIpT
         dJ4+UMP3GRFrZFbHX0BR6cCBMgyI2trKRCQ6zdljV1b8qLGQ4rC8bASLLVNasKDqFK8/
         UNHw==
X-Forwarded-Encrypted: i=1; AJvYcCWvq7KvW2GuurcRL7whMrxQG6Z3ITWnyppozRuXEoOgQOWtmmG+Rnw/QI6tbg6ecfAaSo2La8Sh+VI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpmVX/iWv8vuGB1wTruv75nMN2pGCAxXUdetldFCNMwZzzZEMv
	DxuFojffzzXOntU9YE2XNfaQ+vm5zxZOUS9zkA4EgTZCMxTcA2jlCzm4tfxnPHZVXG/FzqEsOHZ
	6ZIhIu4iJ6cz5yL+pZ6Pynfr9HnyyTro1qCNPjzCJcA==
X-Gm-Gg: AZuq6aKmwNAFEDiD+tsFek6/9TifO3wFCgt34SFiP+S368aYQ29mYJk1j4wJubEqWcl
	xFerWDdN65OQfPrfj+9DktvA6fUhVrJfuPrD6HfUI9fqUrNPv4vB3V5psx1TTW9fmTTxmetd5zn
	ajPESmrQOKtGDjX9RaFcJEniq4DgZFkpTIVt77sl74An52BFf6zERWdcn8ekTUPvuDLXi/g37Vf
	2ToYxi5mlMBgySksqrgY9CZY0Ctue9YCMjF3BNPvj8Y4qWplkpSjHRBa6WGJw6cSmfmK1Uzy0x4
	bnry5tTsHoHGL0MUFQfP0G8VzbG3
X-Received: by 2002:a05:6512:3c86:b0:59d:e589:c977 with SMTP id
 2adb3069b0e04-59e4515c13cmr3221840e87.26.1770655745469; Mon, 09 Feb 2026
 08:49:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <CAPDyKFpbpcg3ei51hEcG5FzJL7tK44PdBcMbxfOdON7ozxP2Xg@mail.gmail.com>
 <9f49bf4d-48ab-cb8e-db39-3f573d20bcff@axentia.se> <CAPDyKFo2Zm2LKP6=m=fJEbo1a2ZpBn10EGaucFS7zGfGJV_6tg@mail.gmail.com>
 <793644d5-4d4f-8ee5-7fcc-369536801683@axentia.se>
In-Reply-To: <793644d5-4d4f-8ee5-7fcc-369536801683@axentia.se>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Feb 2026 17:48:29 +0100
X-Gm-Features: AZwV_QiQvQ7mrYQqbOHRiTV98ZgKaltKf6NrojsLO3GMYCFwqcEgvdtufeaSCsk
Message-ID: <CAPDyKFqCveBs-_VcWCm8OCegbpwnW3=0iGa2e5KUNmSy3TMA+A@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
To: Peter Rosin <peda@axentia.se>
Cc: Josua Mayer <josua@solid-run.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Feb 2026 at 14:50, Peter Rosin <peda@axentia.se> wrote:
>
> Hi!
>
> 2026-02-09 at 14:39, Ulf Hansson wrote:
> > On Mon, 9 Feb 2026 at 14:16, Peter Rosin <peda@axentia.se> wrote:
> >>
> >> 2026-02-09 at 10:57, Ulf Hansson wrote:
> >>> I have already applied for v8 and it's going to be in my pull-request
> >>> for v7.0 in a few hours.
> >>>
> >>> Please send incremental fixes on top instead of a new version of the
> >>> series, then I can pick them as fixes for v7.0.
> >>
> >> Hi!
> >>
> >> Sorry for being late with this, but as the mux maintainer I'm not
> >> fond of
> >>
> >> 028ec00381f5 ("mux: add help text for MULTIPLEXER config option"
> >>
> >> and would not like to see it in rc1. Can you prevent that some way?
> >
> > Sorry, but my pull-request and branch was already prepared.
> >
> > Please send an incremental patch on top then I can pick it up as a fix
> > for 7.0-rc1. Unless you want to manage this yourself via your tree.
>
> That unfortunate. The patch series has not yet made it to the next
> tree since it has not seen any updates the last few days. What testing
> has these patches received?

The patches didn't make it to next, for some reason. I queued them up
last week on the 4th Feb, definitely a bit of a stretch to pick them,
I admit that, but I trust Josua to help with any kind of problem to
show up.

In regards to additional tests and reviews, lots of people have been
helping out with this and we have also received patchbot reports that
Josua fixed too, along the road. Moreover, the first version of the
series was posted already in November last year.

As I said, let's fix any of the problems on top, it should be that hard, right?

Kind regards
Uffe
