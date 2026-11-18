Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795024093;
	b=fTVAX1SvskBYD7K29QkT+R36jvZoq9B1hnX4zurVWLGgQJpA4V+k8mu9FXTakGZccNiJ
	 ZL6OzQsLNw7vUOgLWaE2Jnit1SpAq5xRFAC4jZCrTaP/7zV3cVPQv935Vh0+KJDFqvcER
	 itHFw8qsMoQXFOhikiKVZFVpFTrRFzlo6XfkuS6QvJkA20P9QXZvMYJgvFiOZVVcPAOZM
	 nm0oZF6L5ZJmEh3jL06sy70K3zpxWvw4VNS+gTAEw3Za1SzM2g/9BFXLY/xFzwKTvfusI
	 7LtXlyNlkJPQIWM3eK3OHCuIFqkd9Qco/gJ/4ic/YfEjKjRxJVPZ4HeRaNHMmSmrTXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024093;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=66NJ1jW/AhT9CM4XoK4Ic0dDVfwzyueai+pMZOAeK9c=;
	b=kjBKkOpceQ0g+ZpYW9Wklht9Z3rxNUhysdqGZdpEl5we0pFHFk8vZHWWQ4zVn4TIgYLl
	 MnEQS/rZJdtIwWGgvIDAA4hHUQDQE7Y6c2qx9n6zPgvJSi4JHthS+Yl0JOIQSN0uKeran
	 W72uOqHW8WDnxaJYg3B/fNIvuwKhAdf5+PaDpt4CFR2uHJhqqsUrpdqjwzFvAnpzvwnrp
	 1qsuXvB+15uF4/Duyof9fBc2G/zvSPSRFCkZ5ageDO0+hMYamg6xO8PHSrnFvCA3Ey3oG
	 hOV4oXDyqH4nB9kfx/hmnmQTFCDlTk9DRmF6z14yjKQuxQZlKsvmmj5MFT0pzqbwN8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bvpsbg3G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4E4606A320
	for <linux-mmc@vger.kernel.org>; Wed, 18 Nov 2026 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bvpsbg3G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C401F000CC
	for <linux-mmc@vger.kernel.org>; Wed, 18 Nov 2026 17:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795024087;
	bh=66NJ1jW/AhT9CM4XoK4Ic0dDVfwzyueai+pMZOAeK9c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bvpsbg3GiW1pL8DyyHaOkGWHI2MsTtXml1taM+wyqMPv2bBL1taFK32mp9IvdHpQA
	 rUhY9zZIbyCMDTsXV7LZ25mVtzsUMGXWCQREnlzGN+VcR2BhjVZTCfs2QHmxZlLUqc
	 US04f7XiPqKXNUevOCbJjTcCsCE59IEMkLnkihW7t2oD+EV8StcdTNZec5qtcuRE1D
	 3hBR52OUEm+TW1DePcflZ54oBk0mh2g+mpGVcjRBefOm4bc/3reh21Gk8E6LqLiZQX
	 w2BMAl6b9BEyC1cHGtMt7vMUqUPTdwWyz7kt3x8c4Ggz+27RTZGTOsif0mVio4zgXX
	 gLk3giaHtlMOQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5c14f7768acso950216e87.3
        for <linux-mmc@vger.kernel.org>; Wed, 18 Nov 2026 09:48:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErH8PRO/Fcfu3A1Fv9Bgr2WiltCXOsdVtnlFzbIvemeukexB3DR545FhUCZv71v6C8cZc/vCr5PSOSg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WElr9MhuAMplPjfu9k1ps9cygsWXc0Ut6EGAtQhbv4k5xlZ8k
	NKB4Vy3F6qkK4ilczSMvbeN3RR1DimVAFOLaKRYiRk1lMJoOfVx48qeuwGcoEAbt5Y4Z86YGSCz
	Q1YkgbSLFP/iD7HUEQEAQDRz2HHE75qk=
X-Received: by 2002:a05:6512:400e:b0:5c1:4a64:ca14 with SMTP id
 2adb3069b0e04-5c1a9c09cfdmr1191859e87.13.1795024086348; Wed, 18 Nov 2026
 09:48:06 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118134445.2909283-1-arnd@kernel.org>
In-Reply-To: <20261118134445.2909283-1-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 18 Nov 2026 18:47:53 +0100
X-Gmail-Original-Message-ID: <CAD++jLnMxxtrtDMm6rYxB1_5jn-FpnrO3Jrb0=SmBmFWFkCTdA@mail.gmail.com>
X-Gm-Features: Aa3M54pa9MgsIMovWMIksxVnRuIk4Bq2FMKGcXAedLzc5oUdkJpdhUzMnswjYZ8
Message-ID: <CAD++jLnMxxtrtDMm6rYxB1_5jn-FpnrO3Jrb0=SmBmFWFkCTdA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sh_mmcif: rework sg_miter handling
To: Arnd Bergmann <arnd@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Arnd Bergmann <arnd@arndb.de>, 
	Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Wed, Nov 18, 2026 at 2:45=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> This driver is the only one that uses sg_miter_next() to get a persistent
> mapping across interrupts, which prevents us from converting the internal
> kmap() to a local mapping using SG_MITER_LOCAL flag.
>
> Linus previously attempted to use atomic mappings here, which failed
> for the same reason. I gave it another try, with a mapping that is only
> active during a single sh_mmcif_mread_block()/sh_mmcif_mwrite_block() cal=
l.
>
> This is mainly a revert of the patch that fixed the command 18 timeout,
> but tries to solve the problem by updating and checking data->bytes_xfere=
d
> to keep track of when the transfer is finished.
>
> Instead of calling sg_miter_stop() on error or completion, this now
> always stops the iterator after the data transfer and restarts it during
> the following interrupt.
>
> Cc: Linus Walleij <linusw@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Fixes: 4d4a2c71b862 ("mmc: sh_mmcif: Advance sg_miter before reading bloc=
ks")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

FWIW:
Acked-by: Linus Walleij <linusw@kernel.org>

> Hi Wolfram and Linus,
>
> Could you have a look at this? I'm not familiar with this driver,
> so there is a chance I got this completely wrong. If the change
> does make sense, maybe you can try testing it on one of the
> highmem-enabled boards.

I don't have this hardware, but Geert does (he helped me with the
previous patches to this driver), so it'd be great if he
could give it a spin!

Yours,
Linus Walleij
