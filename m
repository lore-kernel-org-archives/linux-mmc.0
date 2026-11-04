Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809110;
	b=OZ/Ij9hdNCEFR3c3zSCgvDTmfJy8NQ2H4JF/syHP0o27nv+FqnCiREJuHjWCIChAFOKW
	 iSU33wq4Mzluhnz1RH24MethMjJceMMJXX2sbJ0rj9SqdEzmZvaE9MI/GUtaYSxFE9Kf3
	 LdAEqLjIARuIXQphnvEiHC2aPpidZnVF5TS8dYFNHSneoplBE3MhsNBw1at7P/LarNmFj
	 ZNj6T/noDX2cqY/h89O4qpXfGYAsp2x4+OuMnug1QFdqAXumzip6kkeeSNylahQ1IuXOM
	 X5EcHLFcTdmLWTVTZwqhMCK6WBbzSUG1+n5d5K6gDkgUpkWJlA5CxljlWlgKV2QFkmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809110;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:
	 X-Last-TLS-Session-Version;
	bh=oSfws3W30fOYudbmrQezA5vgk29hrsCEgX3XIqUkwoQ=;
	b=iMeACzxiySZAl2HW2YnITWORrkgf5j3h3odyfT54RB69vjrqZFpKVOpu58I6sqxUlfEa
	 n6NEdv/DBq+7t3lb5t/03qQ397e/o0gcFHb4IvZJOra4LHjIVA1BxRJvrzFpaWPHTPeda
	 AAYc1gw/rluymOAzQTDLOHxdggwj7mipW8UEfBraBgMDH9jJIDbgkufy2OfwBMHG2J4PR
	 q6jB9JBfUxrksCicAOUzYKE8rkbDajHmv25oP8wU0TQE6LC9r1A2g9xBA2VvYWQrr7eei
	 HxJnSmjAGbD2eB41admNhLmSxu4CajunjOJcd0jMVBoRmdc80KNGw+QGtgCFfZVYjWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=fiV8FBWD;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6320860A5BC9
	for <linux-mmc@vger.kernel.org>; Wed,  4 Nov 2026 16:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6320860A5BC9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=fiV8FBWD
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9F18CC49F62
	for <linux-mmc@vger.kernel.org>; Wed,  4 Nov 2026 16:19:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 69CF960770;
	Wed,  4 Nov 2026 16:18:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 42897103291FD;
	Wed,  4 Nov 2026 17:18:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793809105; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oSfws3W30fOYudbmrQezA5vgk29hrsCEgX3XIqUkwoQ=;
	b=fiV8FBWDpx5QcgNQ/9XNu+R88Az0OSeLN0zKlNqdCZ5Rn84ykN3DgxsJO17APexg5YwPY8
	3VVBWs5KR6edjF1oRFKQvtZAcD0aJltb4cI/kqwDhk5UZ0iYx1WmXhhSNDlFF9Pkp+xyx0
	WnpH7B1QNDm4iQeeQcBJvT0q/fihds1StaUUqU3ogBJ1KSlv3S1tWDwxM5AftIGqMyrClN
	W+yUmUUauqS6PGgb4sUY4Cp/mT/VcwSZR6UeiMCeC1POucJrN5eigh16G4jO0qqDAcbCwn
	qwt3tuPyCxOQNa18me0RkD8L9UK9pL3n5l8fJQklt+GAFOvaDCY0XkbEWXyesw==
Message-ID: <5496704ade7e7f2ea2d7bedf2a68e31daa76518c.camel@bootlin.com>
Subject: Re: [PATCH] mmc: sdhci-cadence: enable probing from ACPI
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Tanmay Kathpalia
	 <tanmay.kathpalia@altera.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas
 Petazzoni	 <thomas.petazzoni@bootlin.com>
Date: Wed, 04 Nov 2026 17:18:21 +0100
In-Reply-To: <d9a9f45c-931f-4799-8c17-3f39bf4dc50d@intel.com>
References: <20261103093501.218232-1-paul.cercueil@bootlin.com>
	 <c8dc0612-7ba2-45f0-9aa9-5e312fc8aab4@intel.com>
	 <21015d0ab9c99bbe8b187792836ecd267e02d4dd.camel@bootlin.com>
	 <d9a9f45c-931f-4799-8c17-3f39bf4dc50d@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

Le mercredi 04 novembre 2026 =C3=A0 18:05 +0200, Adrian Hunter a =C3=A9crit=
=C2=A0:
> On 04/11/2026 16:38, Paul Cercueil wrote:
> > Hi Adrian,
> >=20
> > Le mercredi 04 novembre 2026 =C3=A0 16:30 +0200, Adrian Hunter a =C3=A9=
crit=C2=A0:
> > > On 03/11/2026 11:35, Paul Cercueil wrote:
> > > > Use the device property API instead of the OF-specific property API=
.
> > > > This way, the driver will also probe from ACPI.
> > > >=20
> > > > Note the change in the core's probe function for SD6HC. We can't ha=
ve
> > > > named clocks in ACPI.
> > >=20
> > > Do you mean in the future?=C2=A0 ACPI does not provide clocks at all
> > > at the moment does it?=C2=A0 Otherwise, clocks registered directly by
> > > clk_register_clkdev() can have names.=C2=A0 Maybe I misunderstand,
> > > but perhaps clarify the commit message.
> >=20
> > I sent another patch in parallel of this one, that adds basic support f=
or
> > clock
> > resources introduced in ACPI 6.5:
> >=20
> > https://lore.kernel.org/linux-acpi/20261103084718.8222-1-paul.cercueil@=
bootlin.com/T/#u
> >=20
> Would have been worth mentioning that in a cover letter.
>=20
> Seems like it gives the clock a name
>=20
> +		snprintf(name, sizeof(name), "%s-clk%u", dev_name(dev), data-
> >idx++);
> +
> +		err =3D devm_clk_hw_register_clkdev(dev, clk, name,
> dev_name(dev));
>=20
> =C2=A0but clk_find() doesn't look like it would match then - the comment =
says:
> =C2=A0*=C2=A0 An entry with a NULL ID is assumed to be a wildcard.
> =C2=A0*=C2=A0 If an entry has a device ID, it must match
> =C2=A0*=C2=A0 If an entry has a connection ID, it must match	<------

You're missing part 3 ;)

https://lore.kernel.org/linux-arm-kernel/20261103084915.8405-1-paul.cercuei=
l@bootlin.com/T/#u

I also considered not giving them a name (which wouldn't require the clkdev
patch), but thought that there's probably some ACPI tables out there that
provide more than one fixed clock for the same device, so it felt like the
safest option.

Cheers,
-Paul
