From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH v2] Enable DMA for Ricoh reader on Lenovo laptops
Date: Mon, 15 Feb 2010 17:58:24 +0200
Message-ID: <1266249504.10662.5.camel@maxim-laptop>
References: <201002011111.13010.anarsoul@gmail.com>
	 <201002150106.13925.anarsoul@gmail.com>
	 <1266189652.11083.1.camel@maxim-laptop>
	 <201002151150.00761.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f220.google.com ([209.85.220.220]:64889 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755990Ab0BOP6a (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Feb 2010 10:58:30 -0500
Received: by fxm20 with SMTP id 20so5018768fxm.1
        for <linux-mmc@vger.kernel.org>; Mon, 15 Feb 2010 07:58:28 -0800 (PST)
In-Reply-To: <201002151150.00761.anarsoul@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: linux-mmc@vger.kernel.org

On Mon, 2010-02-15 at 11:49 +0200, Vasily Khoruzhick wrote:=20
> =D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 15 =D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=D1=8F 2010 01:20:52 =D0=B0=D0=
=B2=D1=82=D0=BE=D1=80 Maxim Levitsky =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=BB:
> =20
> > Acer Aspire 5720.
>=20
> So my patch with quirk addition for Lenovo will not work for you. May=
be it'll=20
> be better to enable DMA by default on all Ricoh readers?
> =20
> Regards,
> Vasily

Yep, works for me.

I used this:

@@ -87,6 +87,8 @@ static int ricoh_probe(struct sdhci_pci_chip *chip)
            chip->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_SONY)
                chip->quirks |=3D SDHCI_QUIRK_NO_CARD_NO_RESET;

+       chip->quirks |=3D SDHCI_QUIRK_CLOCK_BEFORE_RESET;
+       chip->quirks |=3D SDHCI_QUIRK_FORCE_DMA;
        return 0;
}

Not sure if I need the SDHCI_QUIRK_CLOCK_BEFORE_RESET.


What I don't get is why DMA capability isn't advertised?

Since xD and memstick portions do support DMA, I can't belive that they
don't use DMA in SD/SDHCI portion.


Ah, I forgot that SDHCI is handled by microsoft driver.... Maybe it
doesn't test the DMA bits.

If we were to follow the way MS driver works, we wouldn't need the
quirks, right?

Best regards,
Maxim Levitsky

