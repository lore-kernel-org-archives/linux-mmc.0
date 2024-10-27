Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1DF3BB24
	for <linux-mmc@vger.kernel.org>; Sun, 27 Oct 2024 12:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730031394; cv=none; b=mqu1/fWZTPhe5Hn3FBQX1F1NjhYXf5vh+1wdvOcdtSmRXCPLo8vhgCzRj+Dd8e/EIuI3Vndjq5CQkvMBWy0d6h83iQBeVcVed52PpRnNnsUqz9Eis8NFopBnAGJytmLr+jWcbLAADamturlFACzdoQwZna0WAKumYi4VwegYGn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730031394; c=relaxed/simple;
	bh=nxuvBBl/Ikz1GUSyAopGwNtoj+wTTYNKUidSHI4Zw3c=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXqoTI2M+/Aabnv6bN/Gotxns/E4UT9ayv4Qc9qcwWhzt/vzGhVcTRnOjmtJ53SJWma4P5ULMrJSOpudgjoKhnoPg3WjQRiio7wHhsBJWhQKPobDrmFEJ1FWcVD5S4tuENSbKONYcL920CaSCY2JNUIylGNUCpRRO3ukAUBpWTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=cOLKETCh; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cOLKETCh"
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EB21F3F2AD
	for <linux-mmc@vger.kernel.org>; Sun, 27 Oct 2024 12:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1730031383;
	bh=nxuvBBl/Ikz1GUSyAopGwNtoj+wTTYNKUidSHI4Zw3c=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=cOLKETChPWegF2Gj202JyGVIBA9x2m5mL0IIQ4F7z6tIlPdKlGGIZ582GF91zbQzQ
	 AvY3uyNm7E2i1Y+U8acTQ6vuP1P3kn0D3uBwsjQcEdD66Ws+I/K5Afx5PFZjuwW5al
	 w06UzVSxpMI1qGaLu3ewpSGqtqV6zHzSNQg7MU1C01Se8O7cR90BH0eSrBmZ88GfpM
	 PzsiijipY8pD4p2OdTLI8xjEqc0vq02hpT8proFNfzIX+4x/jxrQLpyXfJY7k9Uk5D
	 zwD4DQiYSXauEYALxMgU0NYcBoq5C/abZUaTTTgb46YhoevxoDlziEHl5xIupTAUn0
	 mnWlByFrw2oNg==
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3e60970ed1dso3354044b6e.0
        for <linux-mmc@vger.kernel.org>; Sun, 27 Oct 2024 05:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730031381; x=1730636181;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nxuvBBl/Ikz1GUSyAopGwNtoj+wTTYNKUidSHI4Zw3c=;
        b=xU02EEefdnEDE5ec8ps3wg8bhGfOMUt2LL223QQw/u4h8xyGxdZyweT6sogGD5La+i
         +XNvDqNrXcMyE1dU5I2Qr+El2v3r46EdNmq7F9r6ZmHEvygD4eXpO2GpPWbeKEBCM7je
         /JUDKSNCtG+VB5u7VimGBASRlsMXPn8k95sDr5m0XPZ9DjoGwxBKhr4SCPMWEoyn8LQU
         RitKO43RLAFWZQRkgFy2ONak6/iEBBHhYCPV0odcUpujXFqgqb866bHn+8IhNTBq/BXg
         mBS9tQKJXO5egP5LBpg8ckaX6ktiAdeuAVAJ/GzvDnlles32fM7WdYkg/VM2+Zpk7zaS
         69Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWi5rumQYegXXRrJtLZIpwPvs2TEJRg+J6ZnuO8zM1Xa0qoIZJQvlXV94KEmE79zhhbse/fuWkehWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkqp0QjMxjNde010W+rK1fZBqnw2XZT8C9fwh479h6DcrS0SLt
	XMmYjBZruoBIwUZZjgiIOVynwEmnqRrrmivKaXqyOd9Vgy0XupBJONybceAEuq3wA4S504xTVZT
	RACEBkED8PCrORJwGUwvGhLXpsLbrcmo93SMFZ0qRK8Ugqy7S7dCUsbKcZUEgQPTsM1wM5HmarG
	l/dm3p5Bu55KQf++0iaZAPu1ji/1l5kQC8x4qZMdLWlr9UCa9J
X-Received: by 2002:a05:6808:6492:b0:3e6:3ab2:3949 with SMTP id 5614622812f47-3e63ab23f2fmr1443466b6e.44.1730031381743;
        Sun, 27 Oct 2024 05:16:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3/p9UcQsOIF9XDrRaePo4CLioUPmMFOdhHm0S4hnuRvPrmJfiLwq408uv86dDavZhe/zgtp+drnC/1fSJ30k=
X-Received: by 2002:a05:6808:6492:b0:3e6:3ab2:3949 with SMTP id
 5614622812f47-3e63ab23f2fmr1443454b6e.44.1730031381414; Sun, 27 Oct 2024
 05:16:21 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 27 Oct 2024 08:16:20 -0400
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <CAPDyKFoQsf89NeX28ms7FtM0QWNqYQ5xtt2=+G1JNCVi2z9=dg@mail.gmail.com>
References: <20241020142931.138277-1-aurelien@aurel32.net> <CAPDyKFoQsf89NeX28ms7FtM0QWNqYQ5xtt2=+G1JNCVi2z9=dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sun, 27 Oct 2024 08:16:20 -0400
Message-ID: <CAJM55Z_CU5rwMBm7n10jhGk57_T_HWLKYrYaGoc7qvK9irT5yQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: take SWIOTLB memory size limitation into account
To: Ulf Hansson <ulf.hansson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>
Cc: William Qiu <william.qiu@starfivetech.com>, 
	"open list:RISC-V MISC SOC SUPPORT" <linux-riscv@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Sam Protsenko <semen.protsenko@linaro.org>, 
	"open list:SYNOPSYS DESIGNWARE MMC/SD/SDIO DRIVER" <linux-mmc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Ron Economos <re@w6rz.net>, Jing Luo <jing@jing.rocks>, stable@vger.kernel.org, 
	Adam Green <greena88@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, sydarn@proton.me, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

Ulf Hansson wrote:
> + Adam, Arnd, Shawn-Lin, sydarn
>
>
> On Sun, 20 Oct 2024 at 16:30, Aurelien Jarno <aurelien@aurel32.net> wrote:
> >
> > The Synopsys DesignWare mmc controller on the JH7110 SoC
> > (dw_mmc-starfive.c driver) is using a 32-bit IDMAC address bus width,
> > and thus requires the use of SWIOTLB.
> >
> > The commit 8396c793ffdf ("mmc: dw_mmc: Fix IDMAC operation with pages
> > bigger than 4K") increased the max_seq_size, even for 4K pages, causing
> > "swiotlb buffer is full" to happen because swiotlb can only handle a
> > memory size up to 256kB only.
> >
> > Fix the issue, by making sure the dw_mmc driver doesn't use segments
> > bigger than what SWIOTLB can handle.
> >
> > Reported-by: Ron Economos <re@w6rz.net>
> > Reported-by: Jing Luo <jing@jing.rocks>
> > Fixes: 8396c793ffdf ("mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
>
> Thanks for working on this!

+1

> Looks like we have managed to mess things
> up. Besides the issue that you have been working on to fix, apparently
> there seems to be another one too [1].
>
> Unfortunately, $subject patch doesn't seem to fix the problem in [1],
> as has been reported by Adam.
>
> I have looped in some more people to this thread, hopefully we agree
> on how this should be fixed properly. Otherwise, I tend to say that we
> should simply revert the offending commit and start over.

Yes, unfortunately this patch also doesn't fix MMC when running 6.12-rc4 on the
StarFive VisionFive V1 (JH7100 SoC).

/Emil
