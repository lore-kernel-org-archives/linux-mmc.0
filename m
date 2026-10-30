Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382711;
	b=cEFEKGPbmA0rnwQgOGWOeGs1k1fVcse88iqmlpDVI0ACybRduKFXqiaN9L2F+1irswCg
	 tUPBFLcKQPiuGCY2Zg1gdI0qHnX7gISVPcNkZBs7EyxkJrGgMx5ROgvkdRM1WT/wItpkb
	 ZwVyzo1279MRUnX9pmY7dh0K0TkyxIeuQq1t6EziHjto8v9jarwa44I8vO/bFTvK4gdUE
	 83KGBx1QJRf/BgAxy0XgIczZmug/yegQLV94qhz7SWT5DEoJU6yqBZN4PTz2TQFPQ0CCt
	 XW+tHaLUNygdcce5KglZbhXnsMwv5uGavjODwvCgLyFaS0x8UsGV4/ta9NGCULv4Otg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382711;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ayqwgRHACXH+SFqhaDzomPKX9uSy7Y6hyx5tLAf6IwQ=;
	b=Kkoc2Diw6MdXV2y+acSV3QPlI0dyaZeRRIIygnPISYVpBxrEntIfBF824sBYb+oLO7Mp
	 61i7BqCI1bVKwNYZgVuzpbXg9rUFkB5VOWY/TVNL3Ov8z1OghMbsvCWk+37DSni5c60qR
	 I4L9/kGt8l9av4JCq1Raa9mgWsVHg2rcYNcSq+iz3rb1oVXqgLLvXF5Qll45anDujbInK
	 ZWcCWFp7N+8Ect3jmG4xoExFMLMqLMsjfYpEV0SAw1ANOJYwXicZb8KdloHv681S2fr/m
	 D1nJrX4tSEGKOYJZ4mf6pDASuZ/evoUZhU0E/bFeBhCzC5lCjf+dYMSoTnzTqxwKlaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOJuBrbP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24936606A320;
	Fri, 30 Oct 2026 17:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOJuBrbP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631561F000C1;
	Fri, 30 Oct 2026 17:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793382710;
	bh=ayqwgRHACXH+SFqhaDzomPKX9uSy7Y6hyx5tLAf6IwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DOJuBrbPJsL9PyQJ0j++GXkM0ur22mU6Tw74m4mz1qxIJy+ctz5iw7JWPSE8lSji1
	 UX3aHxiFM0K77MP1897A9nyjFl7GXZEOwpoVGPezRXaRNTZrOWH9dAxeAQNlT3WpNE
	 hlkubG4PeAqrToOEK7ehcs6dE8KVomyy1GbIKeeA+R5w8SM4avEeOx5hE4Xgr46nGY
	 0eDqMME8/hgABVMRmkYFKx7uT8Z05+mUu6mhd7GFzg4j8quP21VDoeB7k3ax2jka/S
	 LMyr3x4445njHS9AlXkvGLc5qLQfDnEpMp049ML8fcNaKUwdBJiVnZx55MKy2JC2Bq
	 GUGGeSUYFXagA==
Date: Fri, 30 Oct 2026 12:51:47 -0500
From: Rob Herring <robh@kernel.org>
To: Cunhao Lu <1579567540@qq.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Elaine Zhang <zhangqing@rock-chips.com>, Lee Jones <lee@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wu <david.wu@rock-chips.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	mfd@lists.linux.dev, linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-phy@lists.infradead.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 04/27] dt-bindings: mfd: syscon: Add RK3572 QoS register
 compatible
Message-ID: <20261030175147.GA1015085-robh@kernel.org>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-4-0b0fd85a31ee@qq.com>
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
In-Reply-To: <20261022-add-board-ok3572-c-v1-4-0b0fd85a31ee@qq.com>

On Thu, Oct 22, 2026 at 12:11:01AM +0800, Cunhao Lu wrote:
> Add rockchip,rk3572-qos to the syscon compatible list.
> 
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring (Arm) <robh@kernel.org>
