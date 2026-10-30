Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382806;
	b=ONsdjWfmniPzIvLlMvYsRq4xsHBpJ81xnWoONiNZAwjXeKD0cT4siW1fl1PzNQzX3Wse
	 L62KTpSCDY7wVNGJFQRNxBVcjIEKgoDEJcAXyuqgxIQNAKMa9Ho/GymwNqT38bZ1qrFot
	 y14ULLV3ETo6dnRHejhVDABUSOARU8AP2rH1h3/dPTFySehqNKNpeE0ZCbgoVLhKFuKyM
	 x2fhdSDjmB7lON6F9gbNGbwgHQ4JnOZ0BJyMUytYnLWWu3TbWNDxBdgaqcpn8Qtn/U+5R
	 Il1MEvDSdnVQP0gWfvCLvpum+jOBGbtHM0vYQ/k4TNFWqDEhwScDSiyL3BbCjOciKtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382806;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qAHbjk8CdSYMrdXZz4m+f6oiU/FYO+zPJ4vMCM6876U=;
	b=Hp1np5j4BKLTDg/+2ndVwtNUcjdEDYuPU/eQOTlarlIzpuTKn+APWxqmCQe8jY2Ps5AZ
	 i4fxW4tb6SuoqKLEyFVpyDbGwgexJWD9okOU4IyJXPIr/SA7LpKOQxRlsgQeELQG+AYdy
	 JRFQe8FC2ZlSYPfM7Rqj6fT5xaz+FNFj9zqC95QZ06ghpSVXhMOUDOA3yG6LnEAi1WKxM
	 l/5078uaMjQDEvW66xrflhUCge+bHebBVEG655D5ZZtVld0p2N9NQkPQbZTjC4GQk9zEA
	 hlUckgurqxgVBpmRUJRfADE+ztZ+l8Bz4zIFgY8AmG+Hq3mfok0p4zxHWFT07ubyQfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HrOY1TXt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00800606A31C;
	Fri, 30 Oct 2026 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HrOY1TXt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70991F000C1;
	Fri, 30 Oct 2026 17:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793382805;
	bh=qAHbjk8CdSYMrdXZz4m+f6oiU/FYO+zPJ4vMCM6876U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HrOY1TXtar5XJSzJGmiWQiDfcAMm2pqpGIRjWapPMz+cBBiZ29zDZ7b4qK38g5JgH
	 gdpsGXDVTNA17RjnCFg4MDmZ3vDHWX2brR5PTmzPjHFdaw1Okptji2gIgR3mi+Ce4b
	 PUcITCSURdx4PD5i4myqkfz3yQmO4wi8LhK4gNzV3byoKQkxaVnbHkL4mZ/pzdFH1E
	 VdiKgu24ohq9yEaZb+98JlM4IpCPr/QXYDFiCmc6MT5yN/oVvWFRqLVeFGAG/o0S94
	 hf5kyAZQ25+tNqH6pezcger4d2NhlnEC7Hk2AdIehgSJ2TxxsqZppaizU2olmE37+P
	 HojWzxsgkZrng==
Date: Fri, 30 Oct 2026 12:53:21 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cunhao Lu <1579567540@qq.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	mfd@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-i2c@vger.kernel.org, linux-usb@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, Lee Jones <lee@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>, linux-mmc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	linux-rockchip@lists.infradead.org, Ulf Hansson <ulfh@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, David Wu <david.wu@rock-chips.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	linux-gpio@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-phy@lists.infradead.org, Linus Walleij <linusw@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, linux-serial@vger.kernel.org,
	linux-clk@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Elaine Zhang <zhangqing@rock-chips.com>, netdev@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Brian Masney <bmasney+clk@redhat.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Subject: Re: [PATCH 01/27] dt-bindings: clock: rockchip: Add RK3572 CRU
Message-ID: <179338280056.1028517.4147995505996173358.robh@kernel.org>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-1-0b0fd85a31ee@qq.com>
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
In-Reply-To: <20261022-add-board-ok3572-c-v1-1-0b0fd85a31ee@qq.com>


On Thu, 22 Oct 2026 00:10:58 +0800, Cunhao Lu wrote:
> The CRU uses the PMU0 GRF for PLL status and the AUPLL reference mux.
> Describe the controller and define its clock and reset IDs.
> 
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> ---
>  .../bindings/clock/rockchip,rk3572-cru.yaml        |  57 ++
>  include/dt-bindings/clock/rockchip,rk3572-cru.h    | 560 ++++++++++++++++
>  include/dt-bindings/reset/rockchip,rk3572-cru.h    | 713 +++++++++++++++++++++
>  3 files changed, 1330 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

