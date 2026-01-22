Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D93D3ED100;
	Thu, 22 Jan 2026 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077934; cv=none; b=kiBAXNENvPObjyGjhAaahGont2JC+LifTQGXlznrxrbpMkGyVJWH8eZdBc51s/AZq3kHRcgYZkRsrJHHlOkEzr3bPcksnz+RULmZpIWf8H7D9zWaqP+BgyJ+XOeo8OgYd4DA9jXut/nOfrJMDbWSt8Dh+0Ms4/T1K0bVy/Imyvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077934; c=relaxed/simple;
	bh=ryhJKdIrubrtkhY998UD9rUltkB54cVzq5qpVX6sT0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kbhi8DOI2XVR0HYsWWDGcnG272cqNJ0OpujvN310HnZzoQZYayrvEqAKWhYqwF1zzmrtVG/VBKVxsZZNUK/ManG5aQ6NY5pylOGVgfGfTS2LKZVig4I/G4MQ9qiMZYCW3vRRx8qRUApu7QvMPHIMiRLC7d9jxoMPCXDC4xsmS/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=n9VwJlT/; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n9VwJlT/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 37F334E421EB;
	Thu, 22 Jan 2026 10:32:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0B64E606B6;
	Thu, 22 Jan 2026 10:32:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E4720119B2652;
	Thu, 22 Jan 2026 11:31:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769077923; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ryhJKdIrubrtkhY998UD9rUltkB54cVzq5qpVX6sT0w=;
	b=n9VwJlT/bDSClmAYLwqJ5gM67D0CnPLgczwU+8WRBcs7yiQSC9sK/6fndI4xhMSOdVDFEy
	3CRmi6m88cyUQhVzhlonegTTJrvQnSClabqt/YUoXi4QuUImlpUzMvtiDBI8POkocXD0jO
	VQOGrRApe0+dF2w23GhVUIHMkJk0rO9JQyNij5BmXu3lFgmkI2lQr3T1QT430a9IG1Trhf
	4cmnikguSPMyMAf0pQTyZmlxHCwc94Lnj1ap42/YVemOVgUum3ZnRGQj0URh5XuD276fb9
	rHON4Kqqq7YJhtfuEGAM5eKfjXg4BMTUIPB7jxw0cTgMey8GeoLLizxZDdjWMw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,  Chad Monroe
 <chad.monroe@adtran.com>,  Richard Weinberger <richard@nod.at>,  Vignesh
 Raghavendra <vigneshr@ti.com>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>,  Brian Norris
 <computersforpeace@gmail.com>,  Kamal Dasu <kdasu.kdev@gmail.com>,
  William Zhang <william.zhang@broadcom.com>,  Nick Terrell
 <terrelln@fb.com>,  David Sterba <dsterba@suse.com>,  =?utf-8?Q?Rafa?=
 =?utf-8?Q?=C5=82_Mi=C5=82ecki?=
 <rafal@milecki.pl>,  Simon Glass <sjg@chromium.org>,  Linus Walleij
 <linusw@kernel.org>,  Ulf Hansson <ulf.hansson@linaro.org>,  Marcus
 Folkesson <marcus.folkesson@gmail.com>,  Tony Lindgren <tony@atomide.com>,
  Roger Quadros <rogerq@kernel.org>,  Hauke Mehrtens <hauke@hauke-m.de>,
  linux-mtd@lists.infradead.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mmc@vger.kernel.org,  Krzysztof
 Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 06/10] dt-bindings: mtd: partitions: Drop
 partitions.yaml
In-Reply-To: <aXFCws0XUToQ03UH@makrotopia.org> (Daniel Golle's message of
	"Wed, 21 Jan 2026 21:18:58 +0000")
References: <20260121-dt-mtd-partitions-v3-0-ec3af93c8f93@kernel.org>
	<20260121-dt-mtd-partitions-v3-6-ec3af93c8f93@kernel.org>
	<aXFCws0XUToQ03UH@makrotopia.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 22 Jan 2026 11:31:54 +0100
Message-ID: <87tsweos4l.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 21/01/2026 at 21:18:58 GMT, Daniel Golle <daniel@makrotopia.org> wrote:

> On Wed, Jan 21, 2026 at 01:56:39PM -0600, Rob Herring (Arm) wrote:
>> The partitions.yaml schema is an unusual structure in that it includes
>> all possible partition types, and it disables the normal matching by
>> compatible strings. As partitions.yaml has nothing to match on, it is
>> only applied when explicitly referenced. The use of "oneOf" also results
>> in misleading warnings which are difficult to understand. Drop
>> partitions.yaml and rely on the standard compatible matching instead.
>>=20
>> The "mmc-card" case previously allowed any partition type, but now only
>> allows "fixed-partitions". There aren't any users and the original
>> intent appeared to be only for "fixed-partitions".
>
> It would actually be great to also allow 'gpt-partitions' as compatible
> type with #address-cells =3D <0> and #size-cells =3D <0> and allow matchi=
ng
> on partition UUID, name or index. This has previously been discussed and
> would avoid having to extract MAC addresses and WiFi EEPROM data in
> userspace on many devices which rely on such conventions.

Out of curiosity, why not exposing this data through an NVMEM cell
instead? Anyway, this (re?)addition can probably be part of a follow-up
series and is almost orthogonal to this cleanup IMO.

Thanks,
Miqu=C3=A8l
