Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D5B3BB47;
	Tue, 13 Aug 2024 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540548; cv=none; b=ju4gRDKsHmSeY6B/LIDMZrZwX3Pg1KR7JBKCdxa1gmRpK/GhDvvuPjLjfpBNX2f1uICa23I85nxQCxXTDGGj5MtgQLD0eVQ9oqLtlFfoI9PPsVmJ3/TlCsDPBySWHSA3wNGKGi0nR1ko5E0B6VDIgxCEnW7KzhRY5HWBUW6VHpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540548; c=relaxed/simple;
	bh=3DFgHxnnZNSpCQ7BeBat9XOxsXgYsrPX5Songv5ncrI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=jNmKwiPQqyq+GbfJrSO50q0274ZWRqHf/DBSmZAG0BzTp1F2+lDUh5P8laD6dt5lZFlWbmowqxrv5dgCkkhmqgw/LErWj68eeGrBcCr7kxmwYG27OdAum0/BxYKBnexVwbXc1g2Ymux2GEOyh04wv5SvsRUz4OIa2oieTQv6DXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=d5dn+5kl; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="d5dn+5kl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723540507; x=1724145307; i=markus.elfring@web.de;
	bh=rGguLSfwniavDEMHMy3GgVchwkMAgtGND+6W9QtIiDc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=d5dn+5kltuhJs+yuGh2lf8dfvJaXvvciQnd54XEgwRZJo8cjfX2+W9DHfMDFAnRr
	 oSpeJMNhQZ+xRSgUMaw9dtiSuGP/+3XXDgqBn20m9B7uSHvULJR8NcaMdqXjTaqpy
	 XlpwQ9WqhDkYAiz3/dHqg9i+sH/z5QPhQyB6fvHTbTlSglVuFAFgzylDODlukXD7y
	 Q/HER3TJ7bVzCl/2fsXGaIk6t5uKRT/nX5OWt2MtaxDaDhEUh1vLqn8Ni8mrtBfFm
	 0FqRC6VbxIto64aRQRSiEU7pDfAmYr7XTxqN96Jlr4sws/DIoFaUUMNODKY+7mUmj
	 wRMHI5XxapfQM8Cn2A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVrbz-1snSHu1zMb-00UOJc; Tue, 13
 Aug 2024 11:15:07 +0200
Message-ID: <d49cf866-2223-45e9-9ef6-c72990d87a3a@web.de>
Date: Tue, 13 Aug 2024 11:15:04 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christian Marangi <ansuelsmth@gmail.com>, linux-nvme@lists.infradead.org,
 linux-mtd@lists.infradead.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Jens Axboe <axboe@kernel.dk>, Joern Engel <joern@lazybastard.org>,
 Keith Busch <kbusch@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Rob Herring <robh@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Saravana Kannan <saravanak@google.com>,
 =?UTF-8?Q?Thomas_Bogend=C3=B6rfer?= <tsbogend@alpha.franken.de>,
 Ulf Hansson <ulf.hansson@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20240809172106.25892-3-ansuelsmth@gmail.com>
Subject: Re: [PATCH v4 2/7] nvme: assign of_node to nvme device
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240809172106.25892-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5OSznLC1x5l4DccGvfE0cxn4yFFn97VuHg47N4spG6KwoK18cCa
 u7rC+LnBerN5Fj1djIeJHC6ZxqyG7ZBcxRpFbTchUIFAChFRqkBj6wpD3oqHdOEEgRtDlAC
 HtE4KPgNjcMfqicWP1nbyFIFu1giD/7GYtwnkDB7ZP5HD8l4Xm4RETt47ea7DrRFOc6jI9A
 QNidh/HFdpT2P/8HmYCtg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Np8KOEmCYsI=;z/+4c8gTK4XQuaeM7RbBj1+xKBe
 GnmhKkOHHh7e2w732IW8Ag8dTzkXWWfoFRPDNRTDGp4oBqnzRFaqT+QJbgQQzC5q6DoheDvy4
 4K6hzfjCrIfu1vC7alajleh3cyZ2aBMvJRAnti80z1OClHWKpyU+mLguk1rPeZWI3VNsnjP+a
 l8ZkQeoG0gceLGFDodqgh9p0ukXev3bK4614cWlibUmfPs6N3YNly+XAR4sUkNF6Gi0TKJsS9
 hubWrA3hNvPzUJSlFw4ISIRx6o+r7YnU7J2pKPWy6vgmUgKzcUHhwD3K8HDcPgOoRgw+403/c
 JpzEz60bFdXa0J7JUAdpZrD+577k+Vl+S2iHX3wpIzu4ahBML1W/4sCyzDEgeSd3KRI2xfVI2
 kdE/Cq3EwMociuNW+MJkQaEc6/PzjG56aiZYqnM4YgYSXcizwNvx3KM2Npxq27nG7HErsi1c2
 L8P8AY8CeYDNtgdzsLF2H4pr3q11W6YZSNZLYiCHIojtSZ7LXF4PIg1ibLyEzFaaUcj9ypMPV
 n63CvwhN4LzUcjFE7+JCcPow/boReJ0/oyROQ+Ma830y1msb9f/kF2SCdhbq+6YiH40GRzZot
 LMeWdIma1ZZs+76tDn6IQ2k4YADjqiRKCt+t4GtoaA74dEjaRzeilmv6Vv1mdtW0g1Sw/imUn
 KdGibm3XsP/wn4CYQcjGHH/dnKNnRL7GKKaU7dYu7r0Mxad+CGBoQnV3LFbdUO5gLSTnLTLlV
 PVDDFYhJTg0NhnHj75a7PtNc3iEd/KBBh6G/2B+OswXxAUGsr6JcX3NThjfdQXHro2VXnXY6J
 PLaVer5xX68HLw1Rsd5DNE6g==

=E2=80=A6
> This follow a similar implementation done for mmc =E2=80=A6

       follows?

Regards,
Markus
