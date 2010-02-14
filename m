From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH v2] Enable DMA for Ricoh reader on Lenovo laptops
Date: Mon, 15 Feb 2010 01:20:52 +0200
Message-ID: <1266189652.11083.1.camel@maxim-laptop>
References: <201002011111.13010.anarsoul@gmail.com>
	 <201002140038.05614.anarsoul@gmail.com>
	 <1266165548.3451.1.camel@maxim-laptop>
	 <201002150106.13925.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:64115 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608Ab0BNXU5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 14 Feb 2010 18:20:57 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1078787eyd.19
        for <linux-mmc@vger.kernel.org>; Sun, 14 Feb 2010 15:20:56 -0800 (PST)
In-Reply-To: <201002150106.13925.anarsoul@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: linux-mmc@vger.kernel.org

On Mon, 2010-02-15 at 01:06 +0200, Vasily Khoruzhick wrote:=20
> =D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 14 =D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=D1=8F 2010 18:39:08 Maxim L=
evitsky =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
> =20
> > I am very interested in this patch.
>=20
> Is your reader integrated in some Lenovo's laptop? If it is, what is =
exact=20
> model of laptop? What about Acked-by/Tested-by if patch works for you=
?
Acer Aspire 5720.=20
>=20
> > I do have a ricoh reader, and SDHCI portion indeed works in PIO onl=
y.
> > If you need to read xD cards with this reader I have written a driv=
er
> > for xD portion.
>=20
> Where patch for xD can be obtained? I'll test it once I find xD card =
:)
I post the patch series regularly to linux-mtd.
Hope that it will be merged upstream soon.


Best regards,
Maxim Levitsky

