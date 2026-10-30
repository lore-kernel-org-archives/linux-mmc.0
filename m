Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793383031;
	b=41I9eXPfZzyv4J+HcVSA6PZKyP5vAKDUP2pYWurAEistXV/0YrZHJ2Y00fNQEMBEFOvj
	 YQJlxwxh+Aw0W1OrW4GQj1wjv18+4XSvlLem45V/a25by/IZNcOBJsMFvM/xhl4t/bOup
	 en+egmMCfGMA11iZd/CRbHlnIr0+AhqMwr4ChBCfkJQ0P124rHOREYlKgJ8HhGwK9atx4
	 G0xeU4t357kqKeCttJYB1Kt+YkIFfzhBugLKWTPZlOemePFWSCQ93r8zVzTe8A8OMRjqe
	 S3fR6TXYyVu1RMNaz+ulhLjOPg+nF1hfm9AkENpimAjFSyXbw+q4yjMEaFXhjzbkcrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383031;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gFpY/CcR/0PfOj1nIommMYQjTVE3zadszE3CB4i7mAE=;
	b=oRlAogAGS0SV/WymqHQK0kznJ/CPcYG3Xl60PMe1mmwpF9htvSlxCQhhvSSB9d7uRjA5
	 Iv+LbDcjbRvac0sex2/+vXZTi0mR43QtcM89P/tPuD4J5+Vh9jaCCXj7ZTfiCMcm8gIc7
	 Gtdz++MW/rn8KzOYXpDrPLAAbahpxyI4QOgE1eaXpB4kKRrBd91ubgEavqTrhTTOzD0ha
	 MkLhrEq/k1U2vcDYAf6aUKP+c5/c5CcwkpiTujUZ0MHtfxVpsPMgS1XdOW18LYe5T/o7c
	 OXkx/zEX5ReE76zLwwqIekMFr6T5Y9WDMItRXn/53vsMsF62b+mTW5bH8V9vxK79a9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iRrrY2w2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B028606A31A;
	Fri, 30 Oct 2026 17:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iRrrY2w2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51321F000C1;
	Fri, 30 Oct 2026 17:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793383031;
	bh=gFpY/CcR/0PfOj1nIommMYQjTVE3zadszE3CB4i7mAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iRrrY2w2Y9xtSge+L94oD6rgtPud3fBfQiMrTX+Al7/W8zTnhkfqM7RDC18GrIhox
	 ewQIqX1WdvTOZ7Bnb8kEiJxB7vhfupJcXLrqJHfVJmQuVjhMMGXh4BltBQj2wnNR+f
	 gHAKGwB4eULVAAtBRqGGT+UhCMdv1ulj+vFdkMfOiB/4G3wIYw5rBSpE4srr4r0CmW
	 q76IDsn7CCP3CkEPo3n6bChvAruH3xBsEU7scFsGK7oWP5/Q9cRFt4v4aV25qfb1ak
	 aJKqW1mvY/un9fp6I0lUH/lcAIhAvvtx3QVQGuyqUr+A1akCy+DS634oukVT0Fm81S
	 JylpU6Y2OJtGg==
Date: Fri, 30 Oct 2026 12:57:07 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cunhao Lu <1579567540@qq.com>
Cc: Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-i2c@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
	linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>,
	linux-usb@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-gpio@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	linux-serial@vger.kernel.org, linux-phy@lists.infradead.org,
	David Wu <david.wu@rock-chips.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	Andi Shyti <andi.shyti@kernel.org>, netdev@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Stephen Boyd <sboyd@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, linux-clk@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
	linux-pm@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>,
	Linus Walleij <linusw@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Jiri Slaby <jirislaby@kernel.org>, mfd@lists.linux.dev,
	Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 15/27] dt-bindings: thermal: rockchip: Add RK3572
Message-ID: <179338302704.1052003.1217038556098024817.robh@kernel.org>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-15-0b0fd85a31ee@qq.com>
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
In-Reply-To: <20261022-add-board-ok3572-c-v1-15-0b0fd85a31ee@qq.com>


On Thu, 22 Oct 2026 00:11:12 +0800, Cunhao Lu wrote:
> Add the RK3572 thermal sensor compatible.
> 
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> ---
>  Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

