Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144B715217F;
	Mon, 12 Aug 2024 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723452609; cv=none; b=f7mNUJP+dmHNTTm/gmNRDOI26EcVYEwfbZrngzSUIAUmk+A8Fjc7Zof8mbHIcTHJzLoxldgfNsNU66mxWUHOxx7h0Vf9NTlhU8Th1bC0gSERLEp8O2KDh2gYpPI9qYzEq6lw6ktHAyvIYzL3vMXQy36EM1oxmRYJzf6Qangb3rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723452609; c=relaxed/simple;
	bh=bn9/o/w9h70XTKRovlpwhdS5d/DKUDih333jFZm8c+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCZ71PXTKSuKb4+vrz/zjKuFEPA5qyrlRy2uffVIJ3CqA0uIdH/oIXRS5MnjaRTi5IKME6hUJQCq1XW+GOb7idHJp+BHvaPP7rHkkHd7k3RlpiHWKqihduqWszlqS+xeK7/BsBt52NuRLgUAUFn8i+fFCTFrsjW/+SSt4nqQgO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hsUZH/C8; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hsUZH/C8"
Received: by mail.gandi.net (Postfix) with ESMTPSA id A7AE420007;
	Mon, 12 Aug 2024 08:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723452599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73GvcgdSLrMZXGcYPjAJiYsspT+yFL38vgOcQSxgjFk=;
	b=hsUZH/C8PXrcNQJubX+GqA3kU3D3BCLoUqm0Nuwf/7zwdpBWAhom6I5lp+UeuskT4/kWmz
	ftrP1rxNG10SZ4ErGuXCdc33Wl9LPw6QSB++RRHH3gFDd/uYKExSJGihp9k5EO5DGpZRWS
	Vhug+ZdnbZCC7T/doh7pjomhBB0v6AthvjEYPTC1WEKTeV+zjEPFpeqqEOmZKcIVzCdP9N
	VckV7vn4nKMrx12x2qerZAXsz4COE8RZhfbTGbMmn5Dhhlo7SqFwIws17BKJcODEQDwM+P
	bJ4gepsVvcU/1x3lF6f4fU2YKzRk3W0mow+kBu19yQpGsDh6BtkWPN96iehkMw==
Date: Mon, 12 Aug 2024 10:49:54 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Joern Engel <joern@lazybastard.org>, Keith
 Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
 <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Saravana Kannan
 <saravanak@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, Florian Fainelli
 <f.fainelli@gmail.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 0/7] mtd: improve block2mtd + airoha parser
Message-ID: <20240812104954.1e8d55f7@xps-13>
In-Reply-To: <20240809172106.25892-1-ansuelsmth@gmail.com>
References: <20240809172106.25892-1-ansuelsmth@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Christian,

ansuelsmth@gmail.com wrote on Fri,  9 Aug 2024 19:20:58 +0200:

> This small series handle 2 problems.
>=20
> It does try to ""standardize"" the usage of block2mtd module with
> MTD OF nodes.
>=20
> It is very easy to add support for MTD parser by just adding an
> OF node to the mtd created for block2mtd.
>=20
> This apply only if the root block is used for block2mtd to allow
> scenario where the full eMMC or an NVME is used for MTD and it doesn't
> have any partition table.
>=20
> To also support NVME, similar to how it's done with eMMC, we introduce
> a subnode to the NVME controller that needs to have the "nvme-card"
> compatible where a dev can define fixed-paritions for MTD parser usage.
>=20
> This series also add support for the Airoha partition table where
> the last partition is always ART and is placed at the end of the flash.
>=20
> This require dynamic calculation of the offset as some dedicated
> driver for bad block management might be used that reserve some space
> at the end of the flash for block accounting.

Who is reserving this space? And this is not reflected anywhere in the
partition table?

> New aarch64 Airoha SoC make use of this partition table and use block2mtd
> for eMMC to treat them as MTD with custom bad block management and block
> tracking.

I am sorry, I am not used to such use cases, and I really fail getting
why you would like to use mtd with an eMMC. Can you explain a little
bit more what is not available in the block world that you really need
from mtd?

Also, did you consider nvmem layouts instead to detect and define the
ART area? (just asking).

Thanks,
Miqu=C3=A8l
