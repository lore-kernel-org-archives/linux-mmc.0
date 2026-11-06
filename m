Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965769;
	b=pYPXKQfBydgnF5P7CWG3FJjmfQEmXn7SITYY19F2til4v7a7Gc1Sdg2sxtkwl0DuPzLB
	 N2dL5Fg+Ri8+sBNV4Zy+XS+9BawTYxLB5iEvL2pDSRcJPxVeVlVxyGWCZ+loQy0IRX6py
	 w50quOHONG9kLVtS1bNZGwzmBkagXDCDCivB1JfiCFX7o8L1YMSzLGtcyyXnWZ6hWZSGw
	 Awd0+D7/k6Vn0CN4Jbh7n7PYtFsn2HhDqFB7uTlWeMZAOf9WeFFdTZUnrSraGE4qMOQ0X
	 haVrySnck+fEOJXP8AECNhOUkxCxJNn02nuGTJblSrrctF2uzW5PNogZPqHqx1RY8eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965769;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=pvAK8vumV1CMjx7B9+4wQQ+5r1Xl3bHb8AOs+rHc89k=;
	b=CuNxIUtSBQRT4eCCWv7XdfkCO1HQqDfw65RM/nSAh5LwPIO3MZGlbZ38R4M0NdCgwu6i
	 vCLBO/dVPUFanNpoQGGUd09bjKTAANyJ8wM4eLVjOoiDC6tkF0kiR/1kQhHBRuZShKOxV
	 RyoK2pkUR2dN/TBZbNJ4Fpr3buIp9z/HJ0mzQYAflc+Psblt8VqysvDwV5n5HsBjq7QEG
	 YHbOH4HSHsgpO3K07huxN8XFHftSRP0ECoFKaBQp6SnIAmSuj8oUsIpEIvAQ6v5SOH2S2
	 GaT7cFUKQj4yvwqeoky3iuNtOD5q1aH592f8U7Ckcr1pRNZufnMQyuEqyOouy4Ycx0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESf9+xCG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDA3606A32C;
	Fri,  6 Nov 2026 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESf9+xCG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2E91F008A4;
	Fri,  6 Nov 2026 11:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965768;
	bh=pvAK8vumV1CMjx7B9+4wQQ+5r1Xl3bHb8AOs+rHc89k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ESf9+xCGMJOB8JJ24Z9JidY98q6I3VG1LS5xQUaWbDSnIun3yQuj2X+4l+3TBybsW
	 M85ANVNZeyV7zC914Cl8UnpY+2E0gwb2p9YdpiBk8N3LuekyQtbAjKEzKFQHhXkTQM
	 ny5W4HFdt5mIzoUT6X1H/uigMZ0PLB2m870aZdLmhfcLFpvR2Sxw0txQymUcy4qVgq
	 spFx2BzmJdXXc7zAeUYxLRytLBpPZnLraoa1g3CM/4nheX1TRGXU9uCHvkbN6GOVYo
	 tx3mPBdLpQd//K0e9NFcMMnlWHmupctEwHdQISS6N8uOd8UQ8N7coTjWUYRvTMobJe
	 YcHIOlOG4mwaQ==
Date: Fri, 6 Nov 2026 12:49:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?Q?Beno=C3=AEt?= Monin <benoit.monin@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jun Chang <jun.chang@metanoia-comm.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Conor Dooley <conor@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Samuel Holland <samuel.holland@sifive.com>, Ben Zong-You Xie <ben717@andestech.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, CL Wang <cl634@andestech.com>, Mark Brown <broonie@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Adrian Hunter <adrian.hunter@intel.com>, 
	Minas Harutyunyan <hminas@synopsys.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Randolph Sheng-Kai =?utf-8?B?TGluKOael+iBluWHsSk=?= <randolph@andestech.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, linux-phy@lists.infradead.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 11/25] dt-bindings: spi: andestech,ae350-spi: make DMA
 and interrupts optional
Message-ID: <20261106-agate-sponge-of-influence-993ee9@quoll>
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
 <20261106-mt2824-v1-11-86087eaf5af4@bootlin.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261106-mt2824-v1-11-86087eaf5af4@bootlin.com>

On Fri, Nov 06, 2026 at 10:30:08AM +0100, Beno=C3=AEt Monin wrote:
> The ATCSPI200 controller can be used in PIO mode, without DMA, and PIO

Maybe the ae350-spi cannot and only your variant can?

> transfers can optionally use the controller's interrupt. Make dmas,
> dma-names and interrupts optional, and require dma-names if dmas is
> specified.
>=20
> Originally-by: Jun Chang <jun.chang@metanoia-comm.com>

Please drop, as mentioned in earlier message.

Best regards,
Krzysztof

