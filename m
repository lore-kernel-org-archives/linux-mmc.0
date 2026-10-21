Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602590;
	b=zatQU4BIQmCe3GEc/ape3T9G1Tra7xrVOToXkbcvPuN74I3LsfhE/DymvPIYt3GRuIwG
	 gtoXCe0DBzih6/uIxXS+9W2yPILZfkggRoUUHcTBLwtkx23g+MNx2dpfPzOV9S7Km9gG4
	 41R6YLEj5o40pbTE00Oa+KfInWv7F8iUGZlF5mLIaiYf+RoJLvSv0lJKhoEiDM9uEtibZ
	 rEXXrcUrVzgyNmJPUegJ6NG47SjQA07irZdgA3jIo8ewMmY/Hl4yv2ZIQyDRWyp/dDtLo
	 QzqWwlcagBMcQRhO4b3OKJhlkOHzA4fns9KqI0RjJkadl7AOEQxlUPY02uUQVq+ThSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602590;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=mFv5pCfeZJzksfug+IhiQDAbXtzLBXfiEtm++e+fXl4=;
	b=MGsuTx3Xce44Z+4R0qsWt9BNzpxuWmzeRFfeqQopPNNiOsSD8L+E6bqv54IKxZbO8Pyl
	 eONqZItsuy1RH/sWS5dOItv8ah9S1VVVPVREWPXMTKUCLuOY4yTPJPIGD4mundh5cU+6n
	 z//dQe8maCRkSM3hVC1rtSjwAZxrDOqzcd+UdxKE3RPJ49bJc0XnZj6ZvHpCSggAyrKMh
	 j6Z9EZT9Z/P/VV6V4g0HhH/a4bMZz7L2kD25yA0bMydqo7ythvlyKMeRVPDNyvEN6zMxv
	 36RSOopOxmxfjyra5mu9OJ2oyQDtAqosuaf1+FfXiaZDCZACrP+oZq0jIJCX5HYLGXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=N0cW9jJh;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFABD606A31E;
	Wed, 21 Oct 2026 17:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFABD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=N0cW9jJh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mFv5pCfeZJzksfug+IhiQDAbXtzLBXfiEtm++e+fXl4=; b=N0cW9jJhVDgBhyA7mkVjr84ZHZ
	o6ImQUTsxEzTezoVDyMHzOq8hghs3gOCuNS8lTNLPIJwNtfHF6J7qym8rM3bRkp7/1xxRzCrk6ct7
	V7Ng27LunL3z0yimFw4xYhp6vBuegAZvc/ZD22ZgM3X4IgVnjTZXoKoQ6Tf/tWr49cG4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xJZoS-00C8M0-Mc; Wed, 21 Oct 2026 19:09:16 +0200
Date: Wed, 21 Oct 2026 19:09:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: 1579567540@qq.com
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH 16/27] net: stmmac: dwmac-rk: Add RK3572 support
Message-ID: <b1ab0503-628c-4f96-af38-727d4be06f8a@lunn.ch>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-16-0b0fd85a31ee@qq.com>
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
In-Reply-To: <20261022-add-board-ok3572-c-v1-16-0b0fd85a31ee@qq.com>

On Thu, Oct 22, 2026 at 12:11:13AM +0800, Cunhao Lu via B4 Relay wrote:
> From: Cunhao Lu <1579567540@qq.com>
> 
> Configure RGMII delays and clocks for both RK3572 GMAC controllers,
> using GMAC-specific GRF registers.

You need to split this patches per subsystem. Please send all
networking patches to netdev, once the merge window closes.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

---
pw-bot: cr
