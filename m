Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7D5199D9
	for <linux-mmc@vger.kernel.org>; Wed, 24 Jan 2024 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706102201; cv=none; b=n2tKJXSuuwy+lKAO6194glN7DllzLv4KqJjy2/0skNgAAWkNYNrXJjz8+/jtkJIi47N9dBGZXef0oVRJM8lPvEAP75PKnbU4Sd7oAAfjHV3QzZemXsHoV1xMwVaOdlHzdlMY7fk3Auq4VlSrCEQDRGhxJNM2nJMdw74Iai3jWD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706102201; c=relaxed/simple;
	bh=2bjLgAz3a7tqX1k7T5j6VO1O6ZhK3NX5ET3med42/Z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKl5E1lG3cidP8d885v0lJxQ7SR6l0dfs20Cq/Ym/r3n88fwwMw8gRal+5hBY/WYtFR/zqFpLYuO1AXo7MJfYM/JeNu7j+Xvvt5eUNT95AzMDkikbcFvtfrfGYz/eWfdKVNCOCJG1gDE+VpXqHrUlyPBRVz9SR8+T4ElV4Gbfuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qrU59SKx; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qrU59SKx"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60036bfdbfeso20531767b3.3
        for <linux-mmc@vger.kernel.org>; Wed, 24 Jan 2024 05:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706102198; x=1706706998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqACfH9e+02bTDags9N4+DhFDaXyN0QeqA8PRkhGZaU=;
        b=qrU59SKxUXxeabXC9GGjqIkjDgy1t1GekUdPnl4YfEli6WDUlYSgYJmi/is20Xv7SK
         kcya3cRR7C6i6zxWDCAVoiGbFZTFI5VF8HXsXj8v0oAgbkaV5lE7R3816Hvf+f+nNvPp
         cOUv81A1KiGljUxNXOek8tWeLFGtPqWDksUhZPuP0ckUQfmhXCHWUpH9zR41GERTb4Ig
         WV+FBuT5SkUg8QoH08QL5S05syra7nN9kLksIlLqyXFsKEX9yugwQgnDDXTletL5/ptx
         EHXBFtm/1VjJtZq1vPf6a4PQt2v0QulAyIhi0+Spv7u6mOGfaKVtwqa5siBVcccarD5i
         +JvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706102198; x=1706706998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqACfH9e+02bTDags9N4+DhFDaXyN0QeqA8PRkhGZaU=;
        b=pDhth+3bE8ORoiIbWSEUz9R+Tgd0a6XjeW8GPN0hdm4XBeSgvP9DZqo2EfhWB/swwZ
         eESYjH+ck1tAMaSD/KR/qDLPIWsgJtDWuCJCvkHbxbQvSwe5RWK7U7L/FEzqWsaDFfDh
         WxSr0QVbaD43hjWYogHQkR9b1/6y68X33F2Igj2uS48n++cZSFQNMZ49VMuU2+Y0Aa6f
         hixx2L2S8u2PYbfY84DiCILzWeWiBz8kljEe7vchDQGdnLKWm9z+63keSk0z8UEYbAMv
         XY3sbqoPyPg9tMVQGWJV6V9Tycu/fLD52rF0ChZVql+ghgGfEivCzO4y+FrrnjEbihbh
         Q/7g==
X-Gm-Message-State: AOJu0Ywu3qMi5mY2J01c2Ux6Ox5BSZYs5Fw/n/D7o66ZsBLWhprtwPGc
	aeGdK7AZddNe6ZIO+2rK/se24W9TniSxDhruUpgp/j/MkpzbNYMDIzquS8XrekfAsNno98UVL8K
	eeCqIrlCB+ZhZyPsk6ZQvBsuwTuBDCUkmoB2BUA==
X-Google-Smtp-Source: AGHT+IFvuW/L3aGOhkLb3rfpPf3217BJkwjIgLllSNo0MTbm2G1v3ICxHUZ/V6B6q27qE6FCPDqx+Yih427O708o6S8=
X-Received: by 2002:a0d:d5ca:0:b0:5ff:d0ef:2d1c with SMTP id
 x193-20020a0dd5ca000000b005ffd0ef2d1cmr728827ywd.67.1706102198632; Wed, 24
 Jan 2024 05:16:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112054449.GA6829@lst.de> <9eb0f18e-f3ce-497c-931d-339efee2190d@kernel.dk>
 <CAPDyKFpmEB9FGAmGAQNdEH+DtRtcCNnFszfv_ewihzUU9du+Xg@mail.gmail.com>
 <20240122073423.GA25859@lst.de> <14ea6933-763f-4ba7-9109-1eea580e1c29@app.fastmail.com>
 <20240122133932.GB20434@lst.de> <d2289b38-f463-43e6-a60c-486fd479d275@app.fastmail.com>
 <20240123091132.GA32056@lst.de> <6f38c2db-3aae-42fe-ab97-dd027b90b690@app.fastmail.com>
 <CACRpkdbw8mGBUOh9W_E=KZQsOpc3TefL3QWApB+t5Z6w6wNRdA@mail.gmail.com> <9650b123-5954-4d80-a909-a46ec08ef052@app.fastmail.com>
In-Reply-To: <9650b123-5954-4d80-a909-a46ec08ef052@app.fastmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 24 Jan 2024 14:16:27 +0100
Message-ID: <CACRpkdYYtpk8fMe6Gjo5Fu9byS=PqA5GJGeJpKTaw9QxcLqY8A@mail.gmail.com>
Subject: Re: mmc vs highmem, was: Re: [PATCH 2/2] blk-mq: ensure a
 q_usage_counter reference is held when splitting bios
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>, 
	Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org, 
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 1:55=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:

> > So I am seeing if these can be excluded from the "most omap2plus
> > systems" list.
>
> Unfortunately excluding Nokia n8x0 would turn the omap2plus
> defconfig into an omap3plus_defconfig effectively.

I did like this:

@@ -135,7 +135,7 @@ config ARCH_OMAP2PLUS_TYPICAL
        bool "Typical OMAP configuration"
        default y
        select AEABI
-       select HIGHMEM
+       select HIGHMEM if !SOC_OMAP2420

Effectively disabling HIGHMEM when using omap2plus_defconfig.

If we want all systems supported, we just apply this at the expense
of highmem for OMAP 2430, OMAP3 and OMAP4 and the

We can then either

- Disable SOC_OMAP2420 in omap2plus_defconfig (I made a
  patch for this) turning it
  into an omap3plus_defconfig as you say

or

- Actually add a new defconfig named omap3plus_defconfig
  with highmem enabled but SOC_OMAP2420 disabled.

I don't know which option is the lesser evil ... it's a bit hairy.

(A third option would be to reexamine runtime restriction options...)

Yours,
Linus Walleij
