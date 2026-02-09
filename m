Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F164239E7D
	for <linux-mmc@vger.kernel.org>; Mon,  9 Feb 2026 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770655835; cv=pass; b=iKqVy0KGw9YrcIIW95lnlN8omlP4NAvP1XidEc45gj8piLSCZH00S/vRQPybtgJ1kVWFqA84DpXy4uxksSdqVvEg72DAfl89vxuSWDFVfC/nE+LjjFzxnfsN44qOAIdWE1h4O4kvQmVMfH1X1AXVdVAVgODJPcKCuRT1qhG90MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770655835; c=relaxed/simple;
	bh=MKH/BMQo6ZEQSBfwPQJ1yEwPkvmRFNFDphLlhHfoCFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhYbtv3Rr+Mk1qiP7lF8ZgeEoLLZGUDDra6TP4yziBU/2ZguxSPhtqnjaeb88PRPmK3DEqnGbra4bOWP3fU8M9X4xCYUF2gBeicIm0hB0S/4ZLae4Wgc16PKQlMEhugUGpfX+HLqHhj//Wi/ZqpUQFnDQD5xe1GlBTO+8oaYpeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bd0YslLZ; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bd0YslLZ"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59dd22b9895so6241222e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 09 Feb 2026 08:50:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770655834; cv=none;
        d=google.com; s=arc-20240605;
        b=abPDYItmCCS1ML+GuaC3wptfkBboY5Svq0geyPh1ML1rapIHr7Rwnz1x3pu3yZaz6k
         lsLv/+taG5J8quZ3Iia9sCOC2HELXObI4eVZ7w6x/gIFqijVLDPWto09+L3RRNa8J0hG
         giIdNoLj1ubkSfd4APprg4Q7Dl3lxRGKqTmcrGe+wkw/9k+tb9YJMvoqCWlAbZwtoOOj
         qAxL1rbsX8J3611GM20HdCybDlGV5XkvHbiG5NC+dDGqFppXwggq+Dqk4hF6jpD6T6ex
         R8Em5Mp/f//rV/lQGrmqxB72FQUZV+yfC9VGShxG6exi2Vd2pavVZtM0OimtHvWqED7B
         lKgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MKH/BMQo6ZEQSBfwPQJ1yEwPkvmRFNFDphLlhHfoCFo=;
        fh=llxC6DqOqblWSNZZta5UTJtzYCPUx4Qmnuejlym1D18=;
        b=BUSopU/ebD+XMGRXf2cLQpGA59JSUYZNCXCmwUJ8i5qJ7+Xq30CnfgCghVK/58Lmte
         1DTQ36nZbsB4wakQKgPt7UxvVgYx4cXhfue2+/FmoFwo9J/M5TBAFf4qWGt3tCLX/qVa
         HOtVbNMvspuowI/mwyHAWo9meIJiffqNO9KUiGgaGQ2pgnud0X3B6ZOsXSTOv9bCWBfC
         FjLjji2WRNPT4jKcJa3isWwJexPsbnuE1BrFOYQfWUo3S91M8sIQQuzUy9QfCRJPXbIZ
         6boIeg46c/MVKF9C2i/iWkbgX3qZpEj/WyL0r1Tr8Z6KV/EFRsKXGyMUo8AzwsZdIbgy
         UgbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770655834; x=1771260634; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MKH/BMQo6ZEQSBfwPQJ1yEwPkvmRFNFDphLlhHfoCFo=;
        b=bd0YslLZKFA0AqfhMWqkF0xpNqGgg2NKEmE7dE2cye2xsPGqBNkqik4BwkSEsPb9eA
         nmauDKs8yxZKLTWYzQ3zMRZBypPs/rkVsf0jrVwUTDQ7o3nBTbDlTi/sTYLKlWXUfvXf
         azMBwgthmeVHZFNXpD13gofK/nfZ2jxeTCpMnE4XgZerDqBXRZBwiU40lsgxicdtvkQ3
         pL7QVnig1G58pueOmntY9CtGPK2RFFeC2PWIm76NoizJ6N1Kr0rp10P6MtpAhECKIamt
         YEl+Yl0dURQc8xGoLQPKJqm/CzJffy+0McPyxe84oZdODzuESF4mnq01EM3yiIUzoIIm
         hHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770655834; x=1771260634;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKH/BMQo6ZEQSBfwPQJ1yEwPkvmRFNFDphLlhHfoCFo=;
        b=dsk0HRuycx/I8nh5wQogwl6PJ0ItR6o8oEW0DfQGUW5kqahGYugbldCpzGeM80Dta7
         WVbadMegPG2oo4sjuaxqzTk1ue9xPFXw99zLu8jOy6s+/g1Dr18UGn4CcKPNVghijRba
         KcoiSmQoPkB4RTwBXbVEX7DdLfhLWu7Y+pb4ULIGK2A/ksZolD+wp4Ov5hIHx3hyZNtk
         1sZO1Trv82n2Xd57B0Rm/K15H0ov8or908bEKNfGBwGQU6tFLwzg9+0Z/UKY7MtXbPbj
         NrJ/dELoMr4dVOSRJzhoXutBR7RGE7e4kt/i2W787pjqvY6CSFSuKWBbt1d0GbXlYS7T
         Ntyg==
X-Forwarded-Encrypted: i=1; AJvYcCVPq9CzkDPHZEiM5w4MC2i3jlXHLuehEu/r/tXP6lCiR2kVKtsoy5bOBqyfDjtiMFAWBNRggFKwDtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPqzmkPt0JtVKpwe+/M39h0cWyu4R38lHKwGQ9VhKSHH3lRnMr
	J1lPLjHBEmK1AGKf3gUPrYq/nKZRJYrimMnTgxVJyL1KPwfMoah3YY4IWnyZbVNKDkUGdACjs/s
	JbJkc8itPCKmYRlCtYfmxrT21tLgwGWf6WpO0WM04hQ==
X-Gm-Gg: AZuq6aIyf7saxUExd28e7qKt0cSxjbkjWM1Smf339Jr1yG/XBm449MDCqb6JrpEFS4P
	odyDwCqbFAFbk3VKVlklDkqXFk+wymY5sSqRJ+VLLFt9n0+4fa2lv1ObEYt20YH8tjGM2FvjXxQ
	H+2ov7jjtL2CXk1PcY0VqfEG0Y7Xq3T968NKYheB4iQerNDygX1mG6sJ2Ljr2pmHtVZy4TuiQox
	G3BIbjIge0XtGU7qw953L9UvTkx/BmmJGEDQ6V0ZzWGa3akgCEvKM1WQL68LgC9T2IJEGFiRCkv
	NM4rb8IJ86d1f/5XLJKl7I7C06Eb
X-Received: by 2002:a05:6512:118c:b0:59e:4d85:d82d with SMTP id
 2adb3069b0e04-59e5437754cmr14477e87.13.1770655833649; Mon, 09 Feb 2026
 08:50:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <CAPDyKFpbpcg3ei51hEcG5FzJL7tK44PdBcMbxfOdON7ozxP2Xg@mail.gmail.com>
 <9f49bf4d-48ab-cb8e-db39-3f573d20bcff@axentia.se> <CAPDyKFo2Zm2LKP6=m=fJEbo1a2ZpBn10EGaucFS7zGfGJV_6tg@mail.gmail.com>
 <793644d5-4d4f-8ee5-7fcc-369536801683@axentia.se> <CAPDyKFqCveBs-_VcWCm8OCegbpwnW3=0iGa2e5KUNmSy3TMA+A@mail.gmail.com>
In-Reply-To: <CAPDyKFqCveBs-_VcWCm8OCegbpwnW3=0iGa2e5KUNmSy3TMA+A@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Feb 2026 17:49:57 +0100
X-Gm-Features: AZwV_Qh1nXgInou2tkuYLPeqnXQDy8RDhZJ2fx9TuiqfqWwczkYvBAKEQ3MJW4c
Message-ID: <CAPDyKFrDLEzKrFY0GeevptDdRe7JAUzXgqM7fVtQ_PnYDi+N_A@mail.gmail.com>
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

On Mon, 9 Feb 2026 at 17:48, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 9 Feb 2026 at 14:50, Peter Rosin <peda@axentia.se> wrote:
> >
> > Hi!
> >
> > 2026-02-09 at 14:39, Ulf Hansson wrote:
> > > On Mon, 9 Feb 2026 at 14:16, Peter Rosin <peda@axentia.se> wrote:
> > >>
> > >> 2026-02-09 at 10:57, Ulf Hansson wrote:
> > >>> I have already applied for v8 and it's going to be in my pull-request
> > >>> for v7.0 in a few hours.
> > >>>
> > >>> Please send incremental fixes on top instead of a new version of the
> > >>> series, then I can pick them as fixes for v7.0.
> > >>
> > >> Hi!
> > >>
> > >> Sorry for being late with this, but as the mux maintainer I'm not
> > >> fond of
> > >>
> > >> 028ec00381f5 ("mux: add help text for MULTIPLEXER config option"
> > >>
> > >> and would not like to see it in rc1. Can you prevent that some way?
> > >
> > > Sorry, but my pull-request and branch was already prepared.
> > >
> > > Please send an incremental patch on top then I can pick it up as a fix
> > > for 7.0-rc1. Unless you want to manage this yourself via your tree.
> >
> > That unfortunate. The patch series has not yet made it to the next
> > tree since it has not seen any updates the last few days. What testing
> > has these patches received?
>
> The patches didn't make it to next, for some reason. I queued them up
> last week on the 4th Feb, definitely a bit of a stretch to pick them,
> I admit that, but I trust Josua to help with any kind of problem to
> show up.
>
> In regards to additional tests and reviews, lots of people have been
> helping out with this and we have also received patchbot reports that
> Josua fixed too, along the road. Moreover, the first version of the
> series was posted already in November last year.
>
> As I said, let's fix any of the problems on top, it should be that hard, right?

/s/should/should not
