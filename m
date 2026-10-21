Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792621634;
	b=EB+183yw609ETxXYTuwhI6loKz6Q83RwXmK5j8hM1+mnkONhUNo8pSXRj3fzygyzxw+Q
	 qhQvEWvRpBp6jRnge78tidJUMu7vO0EFsn1SYDgU2bg0N4GLv0bVYeLkrvuWY2ObdAEUN
	 psY6sSUwKlIkQzdmnGs3cuyGIpELhURTiicSH3bFsz7vbgqwtH6h57pHI2NYdKxq0vcwJ
	 gWaJ/jL10Ivv4DsyuJFtGFaUFPGZj3nG1ICkr/D7fpdIcbVQFA0Eq24i6TKY5T0xJQ63E
	 e8Kcg9ilt6aCgazf24Rp3E9Pw1nSyWAO+usLThzvSKACBgk9vVT5A5MFTiAFzZS6v6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792621634;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=/Fy3vYhdZ1fZJw/ef1BHjs8s8zcYhlFJOKnLAYjNcDY=;
	b=m5DovQUu+w7RQA51yf5x1KbzOqvZ+LWVZNDnzWwnpNygsxW0rk2HQOJJZ6M3N5kLjZLm
	 SZbF+rKVFEhoaFMSqRGEa+rdfdC53bNlDP9ksIpmglQjZaAtT8ROcKAO/RVmQ5OBhjqrO
	 u9F1nF6ISziGF7X5i+GEC+tfY2RNNRes22XD3zbkFUoL0j8h+57nkzfFm2mXTlbL+fOLB
	 4btVB3schFmbqJdLC86q95KqLA1QWVLweWEBFs/dEadi71r0cmhjbEbfofoacBr0MR1lD
	 9COktDhuGjiOTV3ySalt+3CIteZpNMCF1V6dWsL71sVO9JCBtOWJCCB/6Rnfv2Gkd/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=ahip0nLo;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076AE606A319;
	Wed, 21 Oct 2026 22:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 076AE606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=ahip0nLo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=/Fy3vYhdZ1fZJw/ef1BHjs8s8zcYhlFJOKnLAYjNcDY=; b=ahip0nLoapq7XNH6QNpOVtb4m1
	v9qkpz3ynmvBUaq1pY2hva8QWaxHgiHoOeSnNhhju1iR+aDBpS/dLNMOwzBYJvRU8rBPIPtekaBih
	UFFW3nOQB74FBnrB9qM1ynbrPFfu2WgCeIeDxxh5fTnvTP1vua3IhW9hjFaW7tpx+IUehaWhXHRtw
	7/hAQlyEEAMuIHnEvSMdaZpb8O+NYdHRn0bTvbMeVN7wUbB1Um8gTTRDs1MkuumU5I+IKAMeHv3gJ
	4iSFShsmBWdNiqU6W/oEkAqlpYEgjRHYL1hTuijyP7XwhRv89sbfIX1K7DnO5doVnMZhhbY111jaH
	pVKUI+cg==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Elaine Zhang <zhangqing@rock-chips.com>, Lee Jones <lee@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Wu <david.wu@rock-chips.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>,
 1579567540@qq.com
Cc: Cunhao Lu <1579567540@qq.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 mfd@lists.linux.dev, linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-phy@lists.infradead.org,
 linux-usb@vger.kernel.org
Subject: Re: [PATCH 07/27] clk: rockchip: Add RK3572 clock and reset support
Date: Thu, 22 Oct 2026 00:26:36 +0200
Message-ID: <2339330.72vocr9iq0@diego>
In-Reply-To: <20261022-add-board-ok3572-c-v1-7-0b0fd85a31ee@qq.com>
References:
 <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-7-0b0fd85a31ee@qq.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

Am Mittwoch, 21. Oktober 2026, 18:11:04 Mitteleurop=C3=A4ische Sommerzeit s=
chrieb Cunhao Lu via B4 Relay:
> From: Cunhao Lu <1579567540@qq.com>
>=20
> CPU clocks are managed by SCMI. Keep BPLL and LPLL enabled for firmware
> consumers.
>=20
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

[...]

> diff --git a/drivers/clk/rockchip/clk-rk3572.c b/drivers/clk/rockchip/clk=
=2Drk3572.c
> new file mode 100644
> index 000000000000..78fd35f5f27d
> --- /dev/null
> +++ b/drivers/clk/rockchip/clk-rk3572.c
> @@ -0,0 +1,1972 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Rockchip Electronics Co., Ltd.
> + * Author: Elaine Zhang <zhangqing@rock-chips.com>
> + */

As you didn't write this driver on your own and even kept the original
author, please also credit the original author in the commit itself.

This can be done for example with something like
	git commit --amend --author=3D"Elaine Zhang <zhangqing@rock-chips.com>"
and in the commit also have both signed-offs-by, aka Elaine first
then yours below as the submitter, i.e. like

+++++++++++
Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
[document what changes you did inside the brackets]
Signed-off-by: Cunhao Lu <1579567540@qq.com>
+++++++++++

The same applies to all commits coming from the Rockchip vendor kernel.


Thanks
Heiko


