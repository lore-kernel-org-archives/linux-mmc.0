From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH v2] Enable DMA for Ricoh reader on Lenovo laptops
Date: Wed, 17 Feb 2010 02:35:35 +0200
Message-ID: <1266366935.4820.0.camel@maxim-laptop>
References: <201002011111.13010.anarsoul@gmail.com>
	 <201002151150.00761.anarsoul@gmail.com>
	 <1266249504.10662.5.camel@maxim-laptop>
	 <201002151820.45110.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f215.google.com ([209.85.220.215]:38420 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933626Ab0BQAfl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Feb 2010 19:35:41 -0500
Received: by fxm7 with SMTP id 7so7963510fxm.28
        for <linux-mmc@vger.kernel.org>; Tue, 16 Feb 2010 16:35:38 -0800 (PST)
In-Reply-To: <201002151820.45110.anarsoul@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: linux-mmc@vger.kernel.org

On Mon, 2010-02-15 at 18:20 +0200, Vasily Khoruzhick wrote:=20
> =D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 15 =D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=D1=8F 2010 17:58:24 =D0=B0=D0=
=B2=D1=82=D0=BE=D1=80 Maxim Levitsky =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=BB:
> > Not sure if I need the SDHCI_QUIRK_CLOCK_BEFORE_RESET.
>=20
> Driver sometimes doesn't detect card without this quirk for me.
>=20
> > What I don't get is why DMA capability isn't advertised?
> >=20
> > Since xD and memstick portions do support DMA, I can't belive that =
they
> > don't use DMA in SD/SDHCI portion.=20
> >=20
> > Ah, I forgot that SDHCI is handled by microsoft driver.... Maybe it
> > doesn't test the DMA bits.
> >=20
> > If we were to follow the way MS driver works, we wouldn't need the
> > quirks, right?
>=20
> We need generic quirk for ricoh readers, see attached patch
>=20
> Regards
> Vasily
Tested-by: Maxim Levitsky <maximlevitsky@gmail.com>

Best regards,
Maxim Levitsky

