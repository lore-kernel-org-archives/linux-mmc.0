Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBD6321439;
	Thu, 14 Aug 2025 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180452; cv=none; b=naV4Bkd90PZXUO6TAfEYbXuCUjOvwF3dXBXWPhFUglk6rMuc6IdIPIdsxRL4cUk4UoyAmFbyjFsqMHeL8Q81fzQA47+wJSw27Td5oj0Dv3h2FDPJqIYx0dvDz41biAuuq24PImgTUd5c+ZQgRmUVvKrxSTdW9G2cGskbkK6toKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180452; c=relaxed/simple;
	bh=TjveqBrhNy6GTxpiLaKBmk6h8jvO3csWqsY9XiP+i/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pgGV3GQL1fieU3W04yG6ME+dwwRHJ3rQNeLwURb+VYACIqHCjHPYnTPavXn61V4xD2DCmaiitr/hqWrCsOAIOy/ARB/t4VtA4Whxgrz+/AybD6O9guH1aogn9mABAsIcZ4gN3q+wrYRnxmPAdDqlg5Aq9DIR3L1gAzYMcNElhsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WsRMYz6M; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WsRMYz6M"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3AF54449AE;
	Thu, 14 Aug 2025 14:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1755180448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TjveqBrhNy6GTxpiLaKBmk6h8jvO3csWqsY9XiP+i/8=;
	b=WsRMYz6MxE7ZGg61wnvxsrhq2FRhJ+W/wIajKUk38kUNgHp5dKrtnANwDRgr4EIRUiVGAT
	cDoI2WlzWmodjmyxbP1esQg8c1RdqtzbxSr+kIOfNoCyDkq0J+XtCIVIoj6Kllb8+Ndqr0
	qLA9D+fkuyDAtDUb6IS0HAGcPOdUT9/uxyn70k6EzPf3dd18HLnREgukf9k3w81ImGHar1
	KRnN3WlS+8XManmzk/iJZ0gjXAsV77N/ph1/Vpgdi5CsI5KqlFPAWcPchyvPMbvdIlZZh9
	41ij3IyqRjel/5RRZ2nb8XqBRPt9JE8k4uVCuCyQ9Bv52uU3AKZvvpc1srjVmQ==
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 0/6] mmc: introduce multi-block read gap tuning
Date: Thu, 14 Aug 2025 16:07:27 +0200
Message-ID: <4977174.OV4Wx5bFTl@benoit.monin>
In-Reply-To:
 <CAPDyKFqa6ut25uaDN6pP50wGi2+DZ8MJ6_OZ6ujtgjfHz4hxzg@mail.gmail.com>
References:
 <20250716-mobileye-emmc-for-upstream-4-v3-0-dc979d8edef0@bootlin.com>
 <CAPDyKFqa6ut25uaDN6pP50wGi2+DZ8MJ6_OZ6ujtgjfHz4hxzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeduvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpeeuvghnohpfthcuofhonhhinhcuoegsvghnohhithdrmhhonhhinhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvddtteduleekueetffegudeltedtfeeigeefffethedvveduteejfedvffevudeunecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemudehfeejmehffeehmeelfeeiugemvgelvdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeduheefjeemfhefheemleefiegumegvledvhedphhgvlhhopehfrhgrmhgvfihorhhkrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpegsvghnohhithdrmhhonhhinhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepkedprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopegrughrihgrnhdrhhhunhhtvghrsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqmhhmt
 gesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvlhgrughimhhirhdrkhhonhgurhgrthhivghvsehmohgsihhlvgihvgdrtghomhdprhgtphhtthhopehtrgiffhhikhdrsggrhihouhhksehmohgsihhlvgihvgdrtghomhdprhgtphhtthhopehgrhgvghhorhihrdgtlhgvmhgvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm

Hello Ulf,

On Friday, 18 July 2025 at 15:04:18 CEST, Ulf Hansson wrote:
> A quick review made me feel a lot better about this, thanks!
>=20
> Although I will need a few more days for review and possibly it's
> getting too late for v6.17 for me, but let's see, I will do my best.
>=20
Any update on the review?

I have a new version with the small changes suggested by Adrian. I can send
it but I'd rather wait if you also have some comments to avoid doing two
separate versions of the patchset.

Best regards,
=2D-=20
Beno=C3=AEt Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



