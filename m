Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382884;
	b=wOjsxoTgdGWk78sAn943FCHnZpN5/QVYQzC4Z3wP06SR27j63uiHwYUwDk54dsjfPeVX
	 PMNZ9tx2wQtNNg+xVQ1GOuUyFQEj8t8iT2pkFXqrmi3YOtRT6Mbti106Q/kkqd7F/mRJN
	 eHUREjWB+IxiJXJHSvdMsnYk22j+j3IvTjWU/R/OkFI5bzk0xA23Oif5r64kyKfKAZQJa
	 ZLJy+33EGDcWGRnQXnAEyuVjwt8oaT8M2G06ltmfXBDlFi8UUCQm1Af9W2cjFwH20VAxh
	 ZxyVDvpSDuC2wbMlDf92lpJPH1D8NKBG3kxDxBm7P1Ap6n92MG0IFmU0uUBdXD7urng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382884;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2Swr35UQMEtStvRBDsckhwhaLnsfKwl/Ed2AD30OenE=;
	b=NDGmIJJ48YTIePc5ZYT/1mpRqORh9XXUAPdytd4UQWbOgtiDsjP1kROufnlyAAojceXz
	 FpJy5OVce8xYfWcNZASTErGnbqNgqbIA0D5S9ntJTYLn/Mc+s5bmqAjvxqTDUOj1Z434P
	 tSJrLELeWSDitzZOnOWrq664RXRx9Qgo9AYfC5QRMOwcnBJebpYFy84sSTw7iX/DmR1Ht
	 ZTHJVx0/ciw6iC31XCm2X6AVtFAni47bahxyON5YYsIg8xAKUzBvOpydI8PpH/mPHiw/J
	 rvmyIKkw7BDeio0wanicJeHVGnuHw0BkXI4fW1B12s4XY6lYej1FZXWYCMqtyNHVu+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PZBhOQGM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFE2606A31A;
	Fri, 30 Oct 2026 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PZBhOQGM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCB91F00A16;
	Fri, 30 Oct 2026 17:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793382883;
	bh=2Swr35UQMEtStvRBDsckhwhaLnsfKwl/Ed2AD30OenE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PZBhOQGMCKGPWpMKesbTO4ucPaUydLckPJz5FI9KI5T4yfohbMdnbRA9Tr+kvJvg+
	 MwH6hCKvUBGu0nKmwfwgztQLHgtt7zHZL+5c/j0fgXOI4wfnOWiamb5RLt15hpJulV
	 OlsS0rT00gkhg9BoWnZPBDtrGwfMVUXNnJYjQTfhb+GbknIyH7B3LzB6fAx5Mzmtxf
	 dQ6hXmInfvlnyDQSOS3eZcS77M+q9hzOefQnS/vpj6+fK5xaT/2c568K6a4rJm/+5J
	 uqhQ5bhGo0fuRUlJSdYg0//qoZ5VJIPtuOYN1xW0Gzw4ayFQY7p/atDfD8DmNCaZWT
	 lM1qbKPG5373A==
Date: Fri, 30 Oct 2026 12:54:41 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cunhao Lu <1579567540@qq.com>
Cc: linux-arm-kernel@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>,
	"David S. Miller" <davem@davemloft.net>, linux-mmc@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>, netdev@vger.kernel.org,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>,
	linux-serial@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Linus Walleij <linusw@kernel.org>,
	David Wu <david.wu@rock-chips.com>,
	Jaehoon Chung <jh80.chung@samsung.com>, linux-pm@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Zhang Rui <rui.zhang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	mfd@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-rockchip@lists.infradead.org, Lee Jones <lee@kernel.org>,
	linux-usb@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>,
	linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
	Ulf Hansson <ulfh@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-kernel@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-clk@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH 11/27] dt-bindings: i2c: rk3x: Add RK3572
Message-ID: <179338288072.1036803.16687310470489748099.robh@kernel.org>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-11-0b0fd85a31ee@qq.com>
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
In-Reply-To: <20261022-add-board-ok3572-c-v1-11-0b0fd85a31ee@qq.com>


On Thu, 22 Oct 2026 00:11:08 +0800, Cunhao Lu wrote:
> Add the RK3572 I2C compatible using the RK3399 fallback.
> 
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

