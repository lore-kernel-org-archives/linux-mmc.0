Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793384311;
	b=A+I9hJtP9EnBlM8xjsEgxdL0HLyVk4VbJPgZPBFFq1FNK+q+5ECo+w2ydrKkngPUv0+/
	 7Z5CCWaPZWWjjcu5BC93u81wjpznjSqWIRKHXJeqe7462/qIgwUdBSOBH37srs/Op/ED8
	 MapXGM++cpmQBD9MKE5mEMq5Qy21TxszCvSXHn75rujJm6kkUOVE5ocSgzLcwNp3ZCZm5
	 eKGVDl8XmhryR5YxLp5/uG2tY64+g4tO5o7BeMiYlfRe4DGhqP9rpFjNkq4dijt7i2cj9
	 8eck0czMXvWuVoqHhJyDj5It8qg//0cpkF8EL9LJ108UrRsYzYBQMwgybVnjM+80iJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793384311;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+TpGUdvhMV3H/GhPEjCy0KY1DV4UXmx7Z3C1Se8S5rI=;
	b=j1JQeZhkAZlxFEtSJMDiDB9LvsQkyCfcyI8oLC9zhhWNqTBcvXxolCWxN0vzoOV6guya
	 tyBO3B8FwgOTDgoA3bxi3dbbl5CqsDK60jlCOa6sMVv/DzLVu13PbN/TcG4wSBehtvShW
	 EKq/gtm0KyFjbqLRt0CjxpKIJYa/W3Ch6crjrTmfjsBtsrR3U0JXRWxX8t7IS8NrqG4QH
	 gKIemV4PdoVgeXe4JcvWKmxy+ulzElgXjlw6YCr0EtH73gPMLl+km9WyrIE2AcdN9JXMX
	 /iebyy9enRZUaLV8hoqzrVb1o7dBlUdv6HeeJcqLO9jmnSO8DIEOevqprao48n9U+Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C2XEOoC4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7186A606A322;
	Fri, 30 Oct 2026 18:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C2XEOoC4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61031F000C1;
	Fri, 30 Oct 2026 18:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793384311;
	bh=+TpGUdvhMV3H/GhPEjCy0KY1DV4UXmx7Z3C1Se8S5rI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C2XEOoC4/BSj8bC2Vu8/6qSa2+3P6tl/x9wMN1O1BFLnunwIM+EChoHB16Q5MMtzG
	 7l5AqUGD5cL52WYqeUPE8Utz4CzvFdVp1g/fG5vr5UzrPhlxo4d6lTVwMcd8FPtU65
	 wdfJx5q3ZejJR+xHCzWqPg7nIFQ0Z7lSPFGQQyhHKNZXX/geWpMjVKZEXNmshKY5Cj
	 8hu1BUDk1Lo1wYqkWA9mIkGmKp+LnIB23JdzAj4xkgO20ZzqC1qNSjrmIwlKVg+EAd
	 03obfjx8NJ7MyYrWfyq0XFxAg0kecvPlRnmLA9U9Aspdo50AGXyNZTJUEzjTQzghVK
	 DMRLa4VUCrxqg==
Date: Fri, 30 Oct 2026 13:18:27 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cunhao Lu <1579567540@qq.com>
Cc: linux-mmc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	linux-clk@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Jiri Slaby <jirislaby@kernel.org>,
	David Wu <david.wu@rock-chips.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Daniel Lezcano <daniel.lezcano@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	linux-serial@vger.kernel.org,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Linus Walleij <linusw@kernel.org>, linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
	linux-gpio@vger.kernel.org, mfd@lists.linux.dev,
	Brian Masney <bmasney+clk@redhat.com>, linux-i2c@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-phy@lists.infradead.org,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>, Lee Jones <lee@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>
Subject: Re: [PATCH 06/27] dt-bindings: gpio: rockchip: Add RK3572 GPIO banks
Message-ID: <179338430620.1192537.10304827355794981405.robh@kernel.org>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-6-0b0fd85a31ee@qq.com>
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
In-Reply-To: <20261022-add-board-ok3572-c-v1-6-0b0fd85a31ee@qq.com>


On Thu, 22 Oct 2026 00:11:03 +0800, Cunhao Lu wrote:
> RK3572 GPIO banks have four parent interrupts and a separate debounce
> clock.
> 
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> ---
>  .../bindings/gpio/rockchip,gpio-bank.yaml          | 24 +++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

