Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6487E305075
	for <linux-mmc@vger.kernel.org>; Tue, 19 Aug 2025 12:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606972; cv=none; b=krUAyo1ONWEmtCQXgetxQbQNBrNRzQ+qsWH3ot6lWVUO12YbnIv6trEhumkRUV4gRqCqCKRYu6k5Z4Hw/gDp4Bb7t612lR0k44VZ5VyS5VoCd9Lqb4FMP+chGn9MRAUF8d4oBwwDAtT0G1OGsUkGq/SVGkBkkkGARyMWmuLgUEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606972; c=relaxed/simple;
	bh=uLmoeTEPLRsdPKevsA7Wu19y02YUzzv2ebc4f/4P8rI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZZSoDymUWl7X9NMvdhN63YbLdTO+G5wmFL/Q4frwu9CJ38qONzpVdgfO9QRq8qp/Q/Gj0+WuTxD0Zrx20ZfvlRQ34jsZKVEYKMNn7/ym7JwKoMCByMAmsMfZAtutGFWfqsF4KozYyX9RFmDBk5joF2O8YxtWxoPhTAXctIT15o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=syVdo2Vl; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="syVdo2Vl"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d603a269cso42340387b3.1
        for <linux-mmc@vger.kernel.org>; Tue, 19 Aug 2025 05:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755606968; x=1756211768; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S500HgKRMvfBRecyDLJ9zoSuVb5mEhYt0fyH2bKRAms=;
        b=syVdo2VlS7eNwUje2EYRfPFfliH+zm2KwZPpc1IjbSlIkatZxUJn1rFdEdu+BsX8g3
         ZLveuLXWFzJfUfPJ6XE1uNL+e4c3lEuhLJYGl4z1bM4ARI75JpAuM8+fR1btlphbBZxR
         OPqDX8e5x09pzHzPdP5oXPZzxnPhxG2uZGVnufd+Ltmb6C06Z2U17NXxcDH8SfxtBs4X
         x74+bIrwQoKoiVQ3nPzGVIh41nheUmx9b3YMpzaNhrpZgJ1vtNrlBqomHwN/9ynWGVxl
         JXRdIAUUc51SKc562p3HRyb36odAHshr3zF0pO2VE+oUf7P+LgL+ZP9s3Ks2H4xZBW/9
         6SbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606968; x=1756211768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S500HgKRMvfBRecyDLJ9zoSuVb5mEhYt0fyH2bKRAms=;
        b=HcwP+cBquVA0qyP1HHLPfDzJyw9dRfZ/QGgLPA96qiM3RnZF23gXHZrELPP2OMztOI
         sgR8bRF8/34D8j08fnMwmeazhwo+3K8+QEZgGUgEcCFgr2X1CPnzuUIcnl0nr+D+Mp6+
         q3fkolFRzdP0887SojAho1jU0C+W/clzQlrO/qd0zcrI9LTknk4ByYfIXpqgiIsUB5vh
         56bRWH1amdty9rkpHyq5OFHzMGO9t1KK8M3gej0h0w0iWjpWckQXlF7VOXTFf7f7xpra
         fNHQOYY116rL+uT5SyP5hVVOFr0eYon9YCO+Tld/kr0gteKi5xU+CqFiBEda5SgnDiUW
         GZLw==
X-Forwarded-Encrypted: i=1; AJvYcCVE2CGw/EjshezKRvORJMsjlvPH1zWFM+f2dVFpT0hLB5db5yL0k8y0QSec5grFXwPWEU1d3LUHU4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnRXW+cQ1cCMAwt2YJoif8n21Ab3cQazFNCdnZXZCj6eTUI9JL
	eEYS2tJtfktZLWfevnFOu5ozrLFDzZrhBl6wwN/5NpZUPtInnJirRzmUVjVRpxNU8w41lisvy21
	FNAV0K2T8Xu9qY68YB+/d0gh7EysMIwjQCl+68S2UWw==
X-Gm-Gg: ASbGncsE30pgeF+laASGR7zXLtcar28Mu4aS0Dor1mVc1PJyrM7fGIY9T6y6PvP688q
	+ibYLST/I7HHwEgDFY4nkin78kfiVWWFWs7ffcYHQJnBA/YNdp0RhxERG9wV9zgE5mT86vX18Fc
	9xRlMBUYgFaLRILtwF/QUu6QZNTv4Ii7OXjJA1hwzcSFHo7mXz/Jxp2+7/i2ON3sMVpjGFzeDas
	cIHvhM=
X-Google-Smtp-Source: AGHT+IEZC9xBY6/DAM78NuJbtaoZs1NU7ump47Zvi54A4GCPGfkKW4Xc5CuVqSxtuuIbne9iaz4fTB/gFateGh85WrI=
X-Received: by 2002:a05:690c:9a8d:b0:71a:1f51:291b with SMTP id
 00721157ae682-71f9d4cbc58mr23090687b3.12.1755606968233; Tue, 19 Aug 2025
 05:36:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728082230.1037917-1-rex.chen_1@nxp.com> <CAPDyKFrSYohNh3tFRZoaPjAm=4GOe_Q1P2RS=8GD7i=BhD=UZw@mail.gmail.com>
 <PAXPR04MB833574367C8BC478C5196201FC30A@PAXPR04MB8335.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB833574367C8BC478C5196201FC30A@PAXPR04MB8335.eurprd04.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 19 Aug 2025 14:35:31 +0200
X-Gm-Features: Ac12FXz6BOf_e8mCrlczoSdRxV6lU_MsmWBmJf4rJBB150nDm05KXA21awFATb8
Message-ID: <CAPDyKFqQs8nH9EQdGhUCG29EYmipy4d2XJ7Li8VsEXcZOiSxyw@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v3 0/2]
To: Rex Chen <rex.chen_1@nxp.com>
Cc: "conor.dooley@microchip.com" <conor.dooley@microchip.com>, 
	"bartosz.golaszewski@linaro.org" <bartosz.golaszewski@linaro.org>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "avri.altman@wdc.com" <avri.altman@wdc.com>, 
	"shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>, 
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>, 
	"wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Aug 2025 at 08:04, Rex Chen <rex.chen_1@nxp.com> wrote:
>
> On Mon, 28 Jul 2025 at 10:22, Rex Chen <rex.chen_1@nxp.com> wrote:
> >
> > [patch 1/2]
> > No change for patch 1
> > [patch 2/2]
> > Add more details in commit message
> >
> > Rex Chen (2):
> >   mmc: core: SPI mode remove cmd7
> >   mmc: mmc_spi: multiple block read remove read crc ack
> >
> >  drivers/mmc/core/sdio.c    | 6 +++++-
> >  drivers/mmc/host/mmc_spi.c | 2 +-
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> >
> > --
> > 2.25.1
> >
>
> The series applied for next, thanks!
>
> Do you think we should tag these for stable kernels too?
> ------------------------
> RE from Rex:
> Thanks, Pls apply the patch to stable kernels.
> ------------------------
>

Okay, I have tagged the patches for stable too.

Kind regards
Uffe
