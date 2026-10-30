Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793383010;
	b=iVIzCgdbYSxbDtTJt9rL7x+Q1Py1QZjVqdWNVojKRQPhganRpYGO/flcaBAR7OJKCB49
	 YFZfR7SMnOsbkStWS/orqGSV0wG9hnnYllY0M1awisfGKIeG4poFK2jf1/qWykCQ4eO8I
	 vQjjQUGlPQC+lcS4bR3+/lH6uIHw8qTZl5X6kjpFcMXIFEdtGYZ18L88OiFydICrwm/CQ
	 HMb16r2/AH6j5rYVDv2ww6IBdefGy5k2zV/WQ13FwDlViJ8+6dZQki/fKU+equQ7Drj/B
	 Xoipg4Dcgi4dcgvtTNT94m5PMxcYsX5O/DTBLu8tLBWAcle5FN0XtNI4Wo4AAWuLTUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383010;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8cdpE6839eJEKckHSdgRiQPzZZ0j8j5oYXi5kHAbloM=;
	b=hr6lYjsQ3X8U2mWyM1Ftg5wM8ezPF5f10r8F4N9FKaV/Vj03Rt4L/t3AKhrMF7zJh3zY
	 kDPYH2mlU43mw0a7s3urNrCF2XAIxv+k+FhG0ZzrcPn5nt92+VLGERFK49BeYqXwoZVKn
	 EeIWBoks9zy382uOkpMWmZS5yL3MmPn9WJw8Immy3cVai5vZNsJ8jiPEfSHw0EL3Ub/Bl
	 vZIRwZC/fL5d/dnubFbjp1mGmIrQTtCTp6o1tnNhHasZDAAyPXCsGV58VMvElIfoRKg24
	 MOuOhA+VwRxqeTloBhgqFqLzHgtAB47FIcogqCFkx34Z4p5KoYe2TtT0r7sEuDKjycw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EgLXCoI4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A14606A324;
	Fri, 30 Oct 2026 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EgLXCoI4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28521F000C1;
	Fri, 30 Oct 2026 17:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793383010;
	bh=8cdpE6839eJEKckHSdgRiQPzZZ0j8j5oYXi5kHAbloM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EgLXCoI4Qk0dMcWa6J6QvneHF9GqIKBJBKus+6bWJzYDAwW+VhWj0aXYNNitIDBNS
	 p11jQYP0/HbO9NK/jb+9EOE3UxPLRpSnrbNSdpltBcjz9Cpq7DI3M7VZUA/z0Tzkay
	 b6oCBLaDa8fWV/kezv6Ey0X+XjxQ/Rde8PV/jYhNRh1OiEIiyP7lXFKhHDKtGRa53H
	 RAgWiTihRMGHC3rfX8N8XfQot3oE6O/PQYhofsRQ20dC8WbNVJ8NgHINzvNYfe/cD4
	 HxiiKYAbjV/Xd7fTN8X2ncDBfpQSZIxRX/X0BbYv+bSDI/LvQtg7ZoZ6gGzPgRnTp0
	 qcbC5uDSZ30kw==
Date: Fri, 30 Oct 2026 12:56:46 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cunhao Lu <1579567540@qq.com>
Cc: Paolo Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>, mfd@lists.linux.dev,
	Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Brian Masney <bmasney+clk@redhat.com>, linux-gpio@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	David Wu <david.wu@rock-chips.com>, Lee Jones <lee@kernel.org>,
	linux-phy@lists.infradead.org, Andi Shyti <andi.shyti@kernel.org>,
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-rockchip@lists.infradead.org,
	Bartosz Golaszewski <brgl@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-serial@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/27] dt-bindings: phy: rockchip-inno-usb2: Add RK3572
Message-ID: <179338300613.1049771.15100889276507832651.robh@kernel.org>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-18-0b0fd85a31ee@qq.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022-add-board-ok3572-c-v1-18-0b0fd85a31ee@qq.com>


On Thu, 22 Oct 2026 00:11:15 +0800, Cunhao Lu wrote:
> Add the RK3572 USB2 PHY compatible.
> 
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> ---
>  .../devicetree/bindings/phy/rockchip,inno-usb2phy.yaml     | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

