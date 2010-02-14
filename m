From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH v2] Enable DMA for Ricoh reader on Lenovo laptops
Date: Sun, 14 Feb 2010 18:39:08 +0200
Message-ID: <1266165548.3451.1.camel@maxim-laptop>
References: <201002011111.13010.anarsoul@gmail.com>
	 <201002021817.35773.anarsoul@gmail.com>
	 <201002140038.05614.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:45889 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab0BNQjN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 14 Feb 2010 11:39:13 -0500
Received: by fxm27 with SMTP id 27so382665fxm.25
        for <linux-mmc@vger.kernel.org>; Sun, 14 Feb 2010 08:39:12 -0800 (PST)
In-Reply-To: <201002140038.05614.anarsoul@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: linux-mmc@vger.kernel.org

On Sun, 2010-02-14 at 00:38 +0200, Vasily Khoruzhick wrote:=20
> =D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 2 =D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=D1=8F 2010 18:17:15 =D0=B0=D0=
=B2=D1=82=D0=BE=D1=80 Vasily Khoruzhick =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BB:
> > It seems that Ricoh R5C822 card reader on mentioned laptops need on=
e more
> > quirk. Here's updated patch.
>=20
> Ping :)

I am very interested in this patch.
I do have a ricoh reader, and SDHCI portion indeed works in PIO only.
If you need to read xD cards with this reader I have written a driver
for xD portion.

Best regards,
Maxim Levitsky

