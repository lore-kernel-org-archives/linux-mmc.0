Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382920;
	b=uFw7sIStPWHE1TjOW2yWX6zK678didZu6LJN64Ae7FLItLrEHcrloLZY+mnHH8Y9aKax
	 LSWhtLBNkZiuqIOXbUKq7Zjyu6NfFSfXq/X2jNgM71sQXmwbSkjMWgXlql4LZOjZjX4PI
	 txOkWtJ87VtzHAo8nQnsVD5Hs0tAn5bNf//z48TyKCSJA2f91KttEFl0Y3KoiJDcjRcHz
	 mWXEZ6i9LQvRyH7uYSxQlggBc+LMSZO/fZnyHGbo8QeQH3snYh1P4EQ57xi5Y+vcnmMVt
	 /NiKG+d5NTNX1F6krFudLLXUwU38eNAmlFmnyzk3Q9ijA6MvXeAzC9IcVut7t2VWSKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382920;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dHqkgOMA9Td5gDdmO7PZl3wHOa87W28GWf0OpcKFz7Q=;
	b=JLqYVcl5UOP+kwn3Vs6jnmV9FnhficNVG2zdBzijE/z4nPcNvRTgmkJMOffYIIC9fARf
	 sE4CIFIaZi4Jf8cSCbW4GPKnQK/xQZlj0iGesuVeWOAWOnXfTDVNnT7m6cvgfPCE0mQT+
	 NXNsuSXx0SzE5y3fCsa6HXA+ZedKf3Zsn8Kdp7KX9+P8Ohlz8bf4v+kPlQC5In9yPis74
	 /1S1rAg5EYABa245o16c56v2nUITVDvlHbQAFBm7pBKmnddPV55HE2DOiME7wNBAHbgW0
	 VXiMCJL+fn9XBAGwWcFP/hwd+Y2ypcIKSG4XuvpHP0BryBFYY7JYt2nlaBDka0zNMbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JiDfY8hP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5BB606A31A;
	Fri, 30 Oct 2026 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JiDfY8hP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A401F0093A;
	Fri, 30 Oct 2026 17:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793382919;
	bh=dHqkgOMA9Td5gDdmO7PZl3wHOa87W28GWf0OpcKFz7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JiDfY8hPHUzLfE9EHO+s/TGhLElxX1Wla9Khx5gkIOcGm/DwIIfz6fG8npD6sAh4K
	 OjMD4sYU8zaXkHZcn6tU88lzOkBuhPeiv3pmgrS4aENXVLa0p+1vf9VEXuYLR4X7C3
	 CXSGFOr70PNRXT89GaHNXb8Na98574GNsxuTegalueX6TrMNiKEGCTRSYbiRgKNVPO
	 uqStMScNCOH8KFgYmQ0j05VVFJcLLLBiq+M6erAfSlCmTys/Dy8/c47E/Oy96LnVMC
	 UGd+Q4U20Sbr8/VQCZ8JZflXDAb9/TaH0qNlwjZXaeGBq+GlYFQqgTnRz4TmSucEko
	 VkXkcX4V+6Jpw==
Date: Fri, 30 Oct 2026 12:55:17 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cunhao Lu <1579567540@qq.com>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jisheng Zhang <jszhang@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	mfd@lists.linux.dev, Brian Masney <bmasney+clk@redhat.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-serial@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Jiri Slaby <jirislaby@kernel.org>, linux-gpio@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-usb@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-phy@lists.infradead.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	David Wu <david.wu@rock-chips.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulfh@kernel.org>,
	Lee Jones <lee@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Linus Walleij <linusw@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 02/27] dt-bindings: power: rockchip: Add RK3572 power
 domains
Message-ID: <179338291694.1040563.11893867184826906953.robh@kernel.org>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-2-0b0fd85a31ee@qq.com>
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
In-Reply-To: <20261022-add-board-ok3572-c-v1-2-0b0fd85a31ee@qq.com>


On Thu, 22 Oct 2026 00:10:59 +0800, Cunhao Lu wrote:
> Define the RK3572 power-domain IDs and require the system GRF used to
> check firewall status.
> 
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> ---
>  .../bindings/power/rockchip,power-controller.yaml  | 17 ++++++++++++
>  .../power/rockchip,rk3572-power-controller.h       | 30 ++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

