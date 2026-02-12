Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0712EDD63
	for <linux-mmc@vger.kernel.org>; Thu, 12 Feb 2026 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770892814; cv=pass; b=N76bXe8wq1GGTfg20ZKMpEEnl4cuKyiwe/HTHGMcIV7w3loIrgR2Q0WUjWQl8ongQ6DotmYzxVe68SIL9tdzg4fF1DbjNraDVOFX6jps4XaSViUS7vJXAIbajizmjb4oYB/ENU1mFtmeZWqkBX2y3KnOonQR5qXOSX0leGLfWIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770892814; c=relaxed/simple;
	bh=lj0/gjhdUqOPwKmAM6VN//Fw8Q95Z7mUIRimgBZXmW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ct5C+VSV+puL5zJ+vcRJYwi/+sQH2rpOzc8iSjhanWVe0lOR79U9whGHAhJq4+SOMACCkzG9WC+PKFS4SR9sx4B5yoddhUnAqQaFAMVkBEsotmY/8Gs4FlaKtEqSdxiWp0EhRUyuRkol3jscdId5EGfL2I/BKEGuBX9NfabgMG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lc4+cgQR; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lc4+cgQR"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59e60925251so1824798e87.3
        for <linux-mmc@vger.kernel.org>; Thu, 12 Feb 2026 02:40:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770892810; cv=none;
        d=google.com; s=arc-20240605;
        b=I4rHhXditA7tyDu7EXBUKwr1znnvMvNVeJu9pCX8brR4oDDexV0D3SkNfHSp/Qp5zz
         sKbUlIR4MXACvQqy+r1wV4p0GuWLbA7Tt0hydQf1S1mfTd5CrvjpPNVIL2bmQJ3inODC
         O6Ja8ruF2F3aN6Aeubs4qLbzVCzKbseRrWDQB3qyt2ryeJ8C/V8qAEe5CMNaserDVRIa
         hrhhTwOG+j6zC9Bv0Ik+ztWyqv2Q2ljVOD0ev940hSyCIhTOy0aOhmxjrUwx0A0o06Q3
         iyjw8VBxPQJDGNJCNeM4Jqv+7zsMlt9e8vjp8kbbIE1pJ63ylCpr2WqV1hWVOkIs/QvG
         RPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2QFiFFZSy2peF3P/wq5YLTidjl6EH3wfnbLnCbW9XTY=;
        fh=Gc7skgEoObCg95HsqM8jFWSge52fYMppZ4vdaVuT33g=;
        b=DK3jNeBVvfN1oCt5r+UY/qHKftVH0tNE0K/2/Ar/0ltWtnnjL0KiJM2PHeKvMY40//
         5odiWfiNkRO2RjE9WEF+DlB/CP16qKXhaaRDkMtElXy83RrfA43rcGiC1Om7jq1hy1Up
         Ss5ejmA3D/fmRNErAeq1AVBxxtTY8Jjc3Rq/mUovXAgHj7jj9IgMXmxrmKdFzEbBzXdw
         6ROO1hC2r/ezXHXky0l6pVBc2cM2lUC2v5KownA/u549wbbnavjGAp7/C890sIic44Nd
         uwC1HFgj1mTM7gcq+CjDHTiP+6jklsb58y7oOIscilcO/rJMmGLmxX1huLFrslJiixVy
         fG8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770892810; x=1771497610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QFiFFZSy2peF3P/wq5YLTidjl6EH3wfnbLnCbW9XTY=;
        b=lc4+cgQRHNqrVdvpkYaggFLjowju1ehJ4RRU0gmMdioYhkrtHaX4rhIEyo8MUiP/qo
         NWlGkTpHyihGZWLuBLPfYx0RrR11cRax7k/OZWqK1rUS80FQpO8EMmPWn+NUEysFqbHl
         l07BFreVRNIkEWPwpkaTxomdWHI6eZmKln3DJWH0DolNMB9zLx/f6zQAcZSxT1QWHObe
         CU3dNN7yEv/YwjrHqr8gxIxvqQatOHGdDbfhtdo2VfPpmiIZdWwawG1pLflp89J/RCqh
         CtnuvCCA7eHW5vsg3hFTCxK4WyswjKIhFoxw0Nr1XjF7B6vwpFYMgifFXGDhIuCmk9nM
         Z4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770892810; x=1771497610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2QFiFFZSy2peF3P/wq5YLTidjl6EH3wfnbLnCbW9XTY=;
        b=ghYqHTsZZZE+YpqoDHSr7AwlXRqwsarPcLKA2KzpDX94KPn4/A3Ci7Fm2YWslj3g1D
         MeygqQPpqwz+fQu3r2cvl7bH0gAhfofXsWkRK2PbbteJQVDeffYOFLCRxavwqbg2Zrhv
         /KlIFPZLXQ2J4b4o/Ul6iWpKyNskopDrS+SDeqq2s1V1+qS0y7LWNbRGYBw+LdUJ6nhp
         PjLKdFEFP5b/1SgjuB+4RnrZVRl1LrtgDzakrAsycj4sa7/DLdu9D9tETqwjSi9mYN0V
         zZQ39cv4SrjQFcRwTiHRD4weeNsEFq6g3Egic9Ap6/lZMP3OCgBokNGBrXORe/SautwG
         3gcw==
X-Forwarded-Encrypted: i=1; AJvYcCUddj2UfjOBQoIhiF4z2+2vtQmUAoCkXXCkXIlqtbg3ieIKXFMuyNSOV8/i88GFOQAVhlCWlS++r3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAvdEM3KfySGnBlTMDyXgzBQ0czSWxliDdVMNEdNmuVdE0083u
	4dYFmk2cGKjdbH1foxsVkluCTnA6qSXKURosJw+4L+4Stxl+r1Y4CnuGufvl/kq6JnVaXX7xAb1
	YMEagBhznq2SOQwDvxk5BecwJ/Z32rOk6Z7mZTCnMOQ==
X-Gm-Gg: AZuq6aLMFvAphU5Cg7adnLz70XsipPTXrlqnCOdIrNo8hi1IjiT6bdYve9QVu7fNx9o
	oYbI/BK25uZqX4ddgeGGNgHRlScrBgxBsEn+o2Cc1x/qQ6CW0jFzl9CJpdpipqyZyvogyaCPXPF
	HlQQzpWuW6s1lLXc1QM+/siCLTa7O3O64N6e+NNSyH4gPFysTwr7/qn6SsV38E0nyro042rsGs/
	YwpGDnyjHY07GSyE4yanko36cblFMJLRACA/bakPEShCFLa709bPh3pNxifTM230NbG3YGcY5Uu
	Xw1FB5Re
X-Received: by 2002:a05:6512:3d1b:b0:59d:f69e:16c2 with SMTP id
 2adb3069b0e04-59e640214bfmr777362e87.12.1770892809915; Thu, 12 Feb 2026
 02:40:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67c8c4f9bf9f09fd0c13daedef27b82ff389ddfb.1770720452.git.geert+renesas@glider.be>
 <CAPDyKFpY2X8hephSfHq7rj_DaKX76ZSkWSCYXrGTEBUFHkvOzg@mail.gmail.com> <aYyrsPTH1923jV7y@vaman>
In-Reply-To: <aYyrsPTH1923jV7y@vaman>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 12 Feb 2026 11:39:31 +0100
X-Gm-Features: AZwV_QgmPkOET-FDUx-HmcWBF5gAKY3tXEOlKsTxUDKVx9vpnPTXKu6513pj8u4
Message-ID: <CAPDyKFo92pOimvtGdN4yvFtFkc3vB+ex2OH10WmoKXcVSS+iAA@mail.gmail.com>
Subject: Re: [PATCH next] phy: renesas: rcar-gen3-usb2: Drop local devm_mux_state_get_optional()
To: Vinod Koul <vkoul@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Vladimir Oltean <olteanv@gmail.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Josua Mayer <josua@solid-run.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, linux-phy@lists.infradead.org, 
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Feb 2026 at 17:17, Vinod Koul <vkoul@kernel.org> wrote:
>
> On 10-02-26, 14:34, Ulf Hansson wrote:
> > On Tue, 10 Feb 2026 at 11:53, Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> > >
> > > Now the mux core provides devm_mux_state_get_optional():
> > >
> > >     drivers/phy/renesas/phy-rcar-gen3-usb2.c:944:1: error: static dec=
laration of =E2=80=98devm_mux_state_get_optional=E2=80=99 follows non-stati=
c
> > >      declaration
> > >       944 | devm_mux_state_get_optional(struct device *dev, const cha=
r *mux_name)
> > >           | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >     In file included from drivers/phy/renesas/phy-rcar-gen3-usb2.c:20=
:
> > >     include/linux/mux/consumer.h:64:19: note: previous declaration of=
 =E2=80=98devm_mux_state_get_optional=E2=80=99 with type =E2=80=98struct mu=
x_state *(struct device *, const char *)=E2=80=99
> > >        64 | struct mux_state *devm_mux_state_get_optional(struct devi=
ce *dev, const char *mux_name);
> > >           |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > Fix this by dropping the temporary local wrapper.
> > >
> > > Fixes: ad314348ceb4fe1f ("mux: Add helper functions for getting optio=
nal and selected mux-state")
> > > Fixes: 8bb92fd7a0407792 ("phy: renesas: rcar-gen3-usb2: Use mux-state=
 for phyrst management")
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Thanks Geert for helping out!
> >
> > > ---
> > >   - ad314348ceb4fe1f is in mmc/next, and a PR has already been sent
> > >     https://lore.kernel.org/20260209133441.556464-1-ulf.hansson@linar=
o.org
> > >   - 8bb92fd7a0407792 is in phy/next
> >
> > Vinod, do you want to pick up the $subject patch as a fix for 7.0-rc1
> > or do you prefer me to handle it?
>
> Should I drop the 8bb92fd7a0407792 and it makes things easier for
> everyone and then we can pick fixed commit for 7.1 cycle..

Well, my pull request for MMC was broken (the mux patches didn't get
properly tested in linux-next, until it was too late), so Linus will
not take it.

At this point I would say that 8bb92fd7a0407792 is still a bit
problematic as it uses the same name of the helper that the mux core
intends to use. It would be better with a phy specific name for it, so
it becomes easier to convert to the common mux helper, later on.
Although, at this point it's still okay as is, as we will need to
defer the mux core changes to v7.1 anyway.

So up to you!

Kind regards
Uffe
