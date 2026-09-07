Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E682364EB2
	for <linux-mmc@vger.kernel.org>; Mon,  7 Sep 2026 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770866; cv=pass; b=XSoqCY7YfeF7n5pnAgT5oSEGR3Tz8jXyaAwRLTlGuP/3W2NFkJdOkPXL5kuNnCZhh7dVwAHcjbHvRtJg04H5e5uf0udKcHBa+nXuXcjS3/6rsmdXtinwg+u60VleqEG2CwheX4iiLlT9LpC1zB+Et2dDfZYQG6uoIdiB2hINNvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770866; c=relaxed/simple;
	bh=KCb+AEWT222QOqqi/nfb/AJwudII8A22iwSuXfgeJ0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oR6Lz1ftMjFcNcfibYcRaUaNWBOkyPCTO8f9or2tg9xpkPBVJtOoe6UOfvQhZ+58tdAXpVfXdMw56Vk9BBbWzJB4GtBW3fFruZHaAu5xcVIbY29G9GOB3ug4E8WsPdDeGYSHzBbxZHbLLjFvWvqgftcwIoUDF9cdoSwo8KT9Zdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=MaM3+GZ8; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="MaM3+GZ8"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d53197d8b5so28430715ad.3
        for <linux-mmc@vger.kernel.org>; Mon, 07 Sep 2026 01:47:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788770864; cv=none;
        d=google.com; s=arc-20260327;
        b=dxDryJwusC5UjBqCS3T+y0Eh51QLQxjAhjiFXv2buUqudQln8Fb9Sv05U1QVOvJLQW
         hgcsBognSCkTPwqRex3osIW4xl0KGxDoGmbG9WM79Z2Awk0F+9WEomIuNXa9YmmN3JDC
         YTDYZOfGKBqY63f5eWd+Hufy7/3DA5t63OUnnScthWAcZhp1Z48S0JtdGo3PX+XhBR+j
         9HhTQF9vI6QArOuqxLVEeefu6iMRnVd9kZHG/KDLHHwtIzEk8bQzjrsw51Q19NGDBdNy
         KJR+rruTjxifRF6+s5r3iK+8ZsmNFm528K6YuAg8YlazLvxUBWwrCBeeNkp7wxdw0/tP
         hM4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vD4jMxO/NmU/pHfxFJ8NQMuBlPLvKvFHeSpZFwyymkM=;
        fh=GdCMrnCg24QspH4uSvucQ1wc9P0jc15xchU/2vXE1Fg=;
        b=HEkym3YgOZ5j+1Mm0MAHaIZ61Kk1rb7H6J+/cBlveZMy3P8sHVtAfRBQgcxFu9SdS+
         xRpM5D+cvqM6ZE6vt0hLVR++GkcTEqkQ2WRFtKcC6YY0dT7REA2DHVmHA9MBGFZg1Tfk
         2K5GjzhDRar3ZUdTMtt+d9NiHV3HUB8/LwecTc4C8lR9mSKREdftF0y+OxdqixP3kJZe
         yZL2t04W768yHkA4vKcVGZadn/k0hvKtREv+9CfqGJS5XefukF+zwpURleKQ5pOw36LL
         EnYbgpfNSMJpFsmnHWl1r7j4KqxCJkYYRJQP+l2IdyWiaCTLAYgKiozuoyxzHkIC9sup
         NI1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1788770864; x=1789375664; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vD4jMxO/NmU/pHfxFJ8NQMuBlPLvKvFHeSpZFwyymkM=;
        b=MaM3+GZ8CgUjDMCr9OVjhS62XoBR2OhkcGnUyOFxHL/yysmPcnJr88vUUdsA6fk3qg
         sDj0ihjZqfYbfEiOD17ky21fh4irAn67OgELzwnJyT7Bg1M3KCUd29T7R6QWvebfw5AZ
         ZiuCwC28nb6glW1Gh+RU3U26ITznkrlcXDQ7iEOhejEu2HaoBFvOw41UqG7uR81v8fae
         yYFkcoc76cF+70EvjsQNTvhIuHwOfFrf6LTi/zVfR+s9s9mi6U5LrZWGX9eTc8RWDc6I
         dymI4+kM/T1PEr1x+wXDI/sBiKhsn7shAgo0sxCgX3G1wSzyNonEbwG3eBWP+ZCZaSTD
         S1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788770864; x=1789375664;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vD4jMxO/NmU/pHfxFJ8NQMuBlPLvKvFHeSpZFwyymkM=;
        b=cgfY1STLQ0fdAWbaUkw/cnHvjC17Bz3qTWxoYXgKjctGcPwF2OZBJij5yggX821YR1
         uYCdjY7plg4tCk3YvwLLiHzdSSq7+bqbumivjMkwEic3oVrr+YRnKOLFI27hwR5BiYSY
         cqd2DSDtVUsNRtDUYZmFmWL1WXbDoLNAtkAmj5KIzU4+WieJcp6RK1rczrjR85PwkFwP
         wsSOtg5d4x6N/790Ho2jb/XoyjNfB2qXIscop4OIh7Q/lSAeu/X9DbAiwk05YJPptxHU
         VtZMZ77XicO/tqBkPQWZAlfYScdM3WorzI51plzTHM/bF7T65ErsgUU1/W7xiNyQy+/f
         sU2g==
X-Forwarded-Encrypted: i=1; AKwUvBz7UGP9wg+goho3heFZyOnJVXUTdktJh03yzYrFH6l0scjEaV075W9FT6RpSdXg6HjwAr+hlveKIVc=@vger.kernel.org
X-Gm-Message-State: AFuF++l8nobxyfw6qQv85wwd+kO/+kYq5fOzROW7ZsVcjYpX2HtTNybj
	aAAnkYItJ0RvIB0OIu86AXWf5Nil4h5J7ZGk2YL/zxGH8xkeTpbi4RfXSKYD2sBXtmfufaekmRJ
	+yxVRxceQvTwahpFVYuHbZa7RhQ39maTNFV0u/2KswA==
X-Gm-Gg: AYBFou2K6tSUyGP5nDNYJ3FYkilC6Q/WrAv+Rh2EFwet9xjsOczZf12crU7gZHWNFYk
	U5T2Z+kAyEK9Fyp1sZHhBF2uo4NFHEy7P+fw0bo+hu5PvnPPDXH4WwwhVvoE+Gqok/661dzx4gY
	0AdgDoAB0i3W7QhZXJTw+1SQk/vQCdFDEXoLKlgxyMsX+DoWkocFDmXz4nfo6yy5/dFJ5ovJsv4
	rfJ6FFZ6Y/IIIZRugBEXPiGqNhdr/P25SOaIPfvHASipFcAUDXS+lNS8Xuc4gEZsMDdm0bvrnZM
	j3Kz5/T6wRGMBZLu5q0ouFp5h51wKH1H+HJn4lKFRA01nTBkr9sZjb0lCwAjwxkRCbNJ8UZ+Qek
	rWNmJmpjAIX40lsClEtMQCGRG3g==
X-Received: by 2002:a17:902:ba98:b0:2d6:fee6:65ae with SMTP id
 d9443c01a7336-2db1232e1c3mr208841035ad.4.1788770863774; Mon, 07 Sep 2026
 01:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824110432.1074136-1-robert.marko@sartura.hr>
 <20260824110432.1074136-2-robert.marko@sartura.hr> <0cc2d875-7aab-4091-816c-031f21f3cbac@microchip.com>
In-Reply-To: <0cc2d875-7aab-4091-816c-031f21f3cbac@microchip.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Mon, 7 Sep 2026 10:47:32 +0200
X-Gm-Features: AcwNN1UN3QTAaO3T5aX08ZJGRbzWUSCSQzk2RVV1wbUqXENm6k12pDenn8TnFIY
Message-ID: <CA+HBbNFdqjAJYduFukaZL4+EN12OrsT4qsso95tds828m_z0ag@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: dts: microchip: lan969x: add SDMMC nodes
To: Aubin Constans <aubin.constans@microchip.com>
Cc: ulfh@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 7:14=E2=80=AFPM Aubin Constans
<aubin.constans@microchip.com> wrote:
>
> On 24/08/2026 12:56, Robert Marko wrote:
> > Add nodes for both SDMMC controllers.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >   arch/arm64/boot/dts/microchip/lan9691.dtsi | 24 +++++++++++++++++++++=
+
> >   1 file changed, 24 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/microchip/lan9691.dtsi b/arch/arm64/bo=
ot/dts/microchip/lan9691.dtsi
> > index a8541c6a098d..2d943ea75768 100644
> > --- a/arch/arm64/boot/dts/microchip/lan9691.dtsi
> > +++ b/arch/arm64/boot/dts/microchip/lan9691.dtsi
> > @@ -414,6 +414,30 @@ qspi0: spi@e0804000 {
> >                          status =3D "disabled";
> >                  };
> >
> > +               sdmmc0: mmc@e0830000 {
> > +                       compatible =3D "microchip,lan9691-sdhci",
> > +                                    "microchip,sam9x60-sdhci";
> > +                       reg =3D <0xe0830000 0x00000300>;
> > +                       interrupts =3D <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>=
;
> > +                       clocks =3D <&clks GCK_ID_SDMMC0>, <&clks GCK_ID=
_SDMMC0>;
> > +                       clock-names =3D "hclock", "multclk";
> > +                       assigned-clocks =3D <&clks GCK_ID_SDMMC0>;
> > +                       assigned-clock-rates =3D <100000000>;
>
> If always targeting an e.MMC, capped at the High Speed DDR mode, one migh=
t consider
> a multiple of 52 MHz here.

Hi Aubin,
The issue is that LAN969x cannot derive a 52MHz nor 104Mhz clock.
Requsting 104MHz would be around 111MHz, while with 100MHz the end
clock is 50MHz.

Regards,
Robert
>
> > +                       status =3D "disabled";
> > +               };
> > +
> > +               sdmmc1: mmc@e0838000 {
> > +                       compatible =3D "microchip,lan9691-sdhci",
> > +                                    "microchip,sam9x60-sdhci";
> > +                       reg =3D <0xe0838000 0x00000300>;
> > +                       interrupts =3D <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>=
;
> > +                       clocks =3D <&clks GCK_ID_SDMMC1>, <&clks GCK_ID=
_SDMMC1>;
> > +                       clock-names =3D "hclock", "multclk";
> > +                       assigned-clocks =3D <&clks GCK_ID_SDMMC1>;
> > +                       assigned-clock-rates =3D <45000000>;
> > +                       status =3D "disabled";
> > +               };
> > +
> >                  qspi2: spi@e0834000 {
> >                          compatible =3D "microchip,lan9691-qspi";
> >                          reg =3D <0xe0834000 0x00000100>,
> > --
> > 2.55.0
> >
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
