Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793959482;
	b=3aQg7/ds0eM2C5mrrF9aJ9HJisJWdf4/zuhDGT5SRfVXvJ/kIYVQgDD6LWyl5WGUJaxR
	 tOiufaB0izJ4FchvTeeHeqrlRh1n72rht2ammLXV/69XKj05MkjcGTdEJBl10GW2AIKhl
	 9oBOgJ9xT02XgeUrZseZkPQaybEN/kMmx+LE/+pWQl8QW9ueskS7tidwRtXEgcXKHTB9N
	 nbIguRa6oYaIYwYzRTPKF2RbHElgpH4FQMFV/+XE1E/qPapGpD6kRvWmTYylU5YYvBJt+
	 lEX0LVXAj3kvfambbkohAScxyuSlNg5kc6jEjKLm+taTEn0wdgUyuWITdt7OWrvdFNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959482;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=E30LKCk16cx9qTN9HOhUZe7RDTiEawi3RYRVo2ca6qc=;
	b=qTrjqoX4gqGU0/BwLKVPzaVanuJrAaJwvjN5SYBo7vze2zqn1oAiOhUSgIdcYjQDX2ph
	 GVN0M9BU7RX5iRS1ksTSgUPzq09KjB1Eoney2tHr+DJlx3aJ/n22pe6joqbWQCALzN5eo
	 QGcesrJ7QM0xxXzG2DJBN/08KZxxAea7z7D9S8/bju3bNbfM4qYnDy+JS+kHe6PAffk2j
	 iizvqzsEasVLRpIziZLD+DuQ295XvScfFGQCSGrRTqrF1eHr8s/sQB5AkQa4BpVUjzsoQ
	 nMJBxB/3XJPMx4R1qlWnXNr7N/Y632BlhCwZuUAYMj/k5ujeTNp/Vg5m+BrC514fXMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="H9OK/dkj";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BAC606A329;
	Fri,  6 Nov 2026 10:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1BAC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=H9OK/dkj
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 60E23200B4C;
	Fri, 06 Nov 2026 11:04:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793959478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E30LKCk16cx9qTN9HOhUZe7RDTiEawi3RYRVo2ca6qc=;
	b=H9OK/dkjxwsZIZIcV+Hn9L5EPukiz/UuPQboeBcOiGsnIgm8EU8hlNH8ZEfC8eT890B9do
	t/rVb6rpXkjXoACppi+7N/n7cVqNJSdPp8aqJEDW+PSEkbyYieVNpk7IxfAhDwiTKAo4xL
	ado3BN8BtQG2+jWeulvtNUN0sRI8hMB6TUrLMnMdIaBwnpvCOnLQNSnfJG05+Fg8G6ekNx
	wTLI3RyrFamrS95tpbWjU2DpyH0pHRLvdlYDV9INwKl9ANlUtS0gMOEillr9PYvhf0nAci
	tlHTWlWPibrPVmhg/UBeAtmwpkx0cSwSe2O4flM5/za76ilVe0iFc5wMSZZi8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793959478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E30LKCk16cx9qTN9HOhUZe7RDTiEawi3RYRVo2ca6qc=;
	b=U0A/V3EsJYIkir8OlEXILK/QpaaTBcw+TopekKMn/NBDo9BnMSPBGSaMxFf7b71vee5BSS
	XdsZo+oUKVHpOooM1bntAsnxElc4F0668OOL40DTxMbvJhD664+xzqWfSLGVl/6yrJlpx0
	q6jwNN8j5amCXX0YZPdqg8yCJpxmx8gZ0zcLYdUQD4ZzO+eqHr1xXCcj6TkRFQkYP14un5
	NbxmfHk72rsHovLcFS2Nqw/AjUPwzpyKA0petrgLmfqsG2bX2hmmJ+c7u9U2IfnGGJrnlv
	NI3igvN4DvRU3w2u+mblG4zqDHeDvwYjSEx41O+1t10D9V0xDChRkvNIBYFzYQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793959478; a=rsa-sha256;
	cv=none;
	b=E5AANVgEXfZ4XGSE7OrvMeYfjW72YCl7fwTT5Jh29NZsLDpdrZf+uFVSoGpiOmSlCUZeWI
	qzmWBNW9eUwtEarw1v4VhuAZbtXsakr1HiWvDX0mmQkT9A2VS580i4WJJjGhrxQkm1zBks
	vHvLQtN6ncJiArAuBrEnY5UkDDuuPUSy/OrFmA9WSiQRSmhdDeb88zX3PJPg/E3SBAAda/
	W2onN0t6PpOhdrPi6TixFlrTdDmqz9nHhtC0jkwPXdhg2YK5BUqySwvQfwouIwdO9W7Bdd
	3T2Ve0hH3P0NvEOdJOUpeSZdH4rtKXSrVPZxoL0qEmcKBThow//f+ymqktcRGg==
Message-ID: <35d9bc34110d1663af947189bc74f4ba758612cf.camel@pengutronix.de>
Subject: Re: [PATCH 24/25] riscv: add Metanoia MT2824 SoC and MT5824 EVB
 support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: =?ISO-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Jun Chang <jun.chang@metanoia-comm.com>, Paul
 Walmsley	 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou	
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Sebastian Reichel
	 <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong	
 <neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, Conor
 Dooley <conor@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Lad
 Prabhakar	 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Thomas Gleixner
 <tglx@kernel.org>,  Radu Rendec <radu@rendec.net>, Samuel Holland
 <samuel.holland@sifive.com>, Ben Zong-You Xie	 <ben717@andestech.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Ulf Hansson	 <ulfh@kernel.org>,
 Jisheng Zhang <jszhang@kernel.org>, CL Wang	 <cl634@andestech.com>, Mark
 Brown <broonie@kernel.org>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Adrian Hunter
 <adrian.hunter@intel.com>, Minas Harutyunyan	 <hminas@synopsys.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Randolph Sheng-Kai
 =?UTF-8?Q?Lin=28=E6=9E=97=E8=81=96=E5=87=B1=29?=
	 <randolph@andestech.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-phy@lists.infradead.org, Paul Walmsley
	 <paul.walmsley@sifive.com>, linux-mmc@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-watchdog@vger.kernel.org
Date: Fri, 06 Nov 2026 11:04:38 +0100
In-Reply-To: <20261106-mt2824-v1-24-86087eaf5af4@bootlin.com>
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
	 <20261106-mt2824-v1-24-86087eaf5af4@bootlin.com>
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

On Fr, 2026-11-06 at 10:30 +0100, Beno=C3=AEt Monin wrote:
> Add the device tree for the Metanoia MT2824, a dual-core Andes
> AX45MP-based SoC, and for the MT5824 evaluation board.
>=20
> The SoC device tree describes the CPUs and their L2 cache, the PLIC,
> PLICSW and PLMT, the reset controller, the reboot controller, the
> watchdog, two UARTs, the QSPI and eight SPI controllers, the DWC
> MSHC MMC controller, and the USB2 controller.
>=20
> The MT5824 EVB enables the watchdog, the two UARTs, the MMC
> controller, the QSPI port with its SPI-NOR flash, the first three SPI
> controllers, and the USB controller.
>=20
> Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
> Signed-off-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com>
> ---
>  arch/riscv/boot/dts/Makefile                |   1 +
>  arch/riscv/boot/dts/metanoia/Makefile       |   2 +
>  arch/riscv/boot/dts/metanoia/mt2824.dtsi    | 330 ++++++++++++++++++++++=
++++++
>  arch/riscv/boot/dts/metanoia/mt5824-evb.dts |  81 +++++++
>  4 files changed, 414 insertions(+)
>=20
[...]
> diff --git a/arch/riscv/boot/dts/metanoia/mt2824.dtsi b/arch/riscv/boot/d=
ts/metanoia/mt2824.dtsi
> new file mode 100644
> index 000000000000..5f73c6d3760b
> --- /dev/null
> +++ b/arch/riscv/boot/dts/metanoia/mt2824.dtsi
> @@ -0,0 +1,330 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2026 Metanoia Communications Inc.. All rights reserved.
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
[...]
> +	soc: soc {
[...]
> +
> +		reboot: reboot@10000004 {
> +			compatible =3D "metanoia,mt2824-reboot";
> +			reg =3D <0x0 0x10000004 0x0 0x08>;
> +		};
> +
> +		rst: reset-controller@1000000c {
> +			#reset-cells =3D <1>;
> +			compatible =3D "metanoia,mt2824-reset";
> +			reg =3D <0x0 0x1000000c 0x0 0x04>;
> +		};

This looks unusual. Are you sure these are not both part of a single
device @10000000 ?

regards
Philipp=20
