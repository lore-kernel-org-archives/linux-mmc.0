Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793384340;
	b=cOf2zxZCNog4woOZiMzmcKffT4udVlkbZ9vAMZfdrIDK7UZvYtr9Q9EtJGluRDy6wBSs
	 kmjCrI/9PytWHChObwMgBmuFHC6/sVTF3Jo3YME1wyhcqf9OCiINdrVenVqRMlwBk8SUr
	 owGLufxhGBA3zW5uqgGUH0lJIaY6vmtJvLAxTvKv7zWOqI1aid/ANmWjMgnYWxqbdsDmZ
	 a1Pnk6GMHV0P1d93B6uOIooHnv6tMMW62a8DmERVBgmqMdROk055b+qu28GAxnZcq5ro7
	 nFGXAT5U5GnwUtX0Z2TihP3vgiKIdGUd1OF59liiEE8dARlpyDTg8rplf2kUjmdrSag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793384340;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/86/zTFvnDVScJqAiZwRttfyW+WaA8SdHKVirRpFfLg=;
	b=MRgvBJtDE9E4bWPx7I316AHdLykSX4eZQFQXBPbRNWR6IFEMc//DX4ztsdU5icmYhuK+
	 q/FHlg6HGQLW6qFUpnKQ/tpBzLsqbB//CxUkK4uFykQVN5MWMEALZ/9L3eLE+84MKcwQA
	 gGXi9QW/luX8IvttrJf3ZPnQ37rYyIsijASJ+Bfc/gdN67VKU9EbiTAnlrXzAk0bci8aO
	 JCtxxStCe927DPbu7ZY3Ggar7sVktT/RCeIW1rdYVEuBKnfG2zbks8Hps6AFBKoC8oCha
	 9sORAQ8hNRNduBkHv6D948lIvYo8IbYpPsNlBrtAlT+FhQgG3VIbgz9EzQ2sQwDJPgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gDyaGAuh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E29F606A31C;
	Fri, 30 Oct 2026 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gDyaGAuh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E441F000C1;
	Fri, 30 Oct 2026 18:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793384339;
	bh=/86/zTFvnDVScJqAiZwRttfyW+WaA8SdHKVirRpFfLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gDyaGAuhwSMS4Uxww8tbJ+uX2T6fAKbb2TWpaBEp8xgQ9d0Dj3LEEIRfjLIKGxyzc
	 RG1zNn49EjcuRe4tPpTakD/KEHtV/orWfreE5HSZe/DDf9A2pu/OVgkZokmHfW2yH3
	 Koj+5phapacpf6OzO+C325iOlqWc0gaWBccH/lFvANRz/Muo1++S8pY4cy2PCN/9Ze
	 d+0xamfYGDaD91WF3Q0MnuGmlaFzWBt1M1DbBnWOOQHwPmN38xoOWbRegNHOpTIFD9
	 ZXLayVjJnG/yATtVtf0GFnbQlu1LuFb2XSiGaR4fhOqsBdfOyZfTkqtsETfiOM4Bic
	 dqhzRXZKdSrdw==
Date: Fri, 30 Oct 2026 13:18:56 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cunhao Lu <1579567540@qq.com>
Cc: netdev@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-i2c@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Manivannan Sadhasivam <mani@kernel.org>, linux-mmc@vger.kernel.org,
	Jisheng Zhang <jszhang@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>, Paolo Abeni <pabeni@redhat.com>,
	David Wu <david.wu@rock-chips.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, Lee Jones <lee@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-clk@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	Ulf Hansson <ulfh@kernel.org>, linux-usb@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>, linux-serial@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	linux-rockchip@lists.infradead.org,
	Jerome Brunet <jbrunet+clk@baylibre.com>, mfd@lists.linux.dev,
	Lukasz Luba <lukasz.luba@arm.com>, Jakub Kicinski <kuba@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, devicetree@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	linux-phy@lists.infradead.org,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Linus Walleij <linusw@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Brian Masney <bmasney+clk@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Subject: Re: [PATCH 12/27] dt-bindings: serial: snps-dw-apb-uart: Add RK3572
Message-ID: <179338433630.1195689.10561281082605142294.robh@kernel.org>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-12-0b0fd85a31ee@qq.com>
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
In-Reply-To: <20261022-add-board-ok3572-c-v1-12-0b0fd85a31ee@qq.com>


On Thu, 22 Oct 2026 00:11:09 +0800, Cunhao Lu wrote:
> Add the RK3572 UART compatible using the Synopsys fallback.
> 
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> ---
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

