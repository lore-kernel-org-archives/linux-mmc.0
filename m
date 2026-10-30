Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382958;
	b=tBSa8KqjW4/Nu7B2DO7LrQup2Fi3l8Ck/hN0VVyON6bz7GhLMydjkNF0ihPpB7LZOEVF
	 AYq3bZTRXLBwwad1X5xlK2lH5EaFgQAD7kJFNQ8R7KXg0tNcf26ALjs3ntBDCZ3f9ezMg
	 6XIWM5sOw4xjq4zyrDub3TMUszUwt0xMBQ2L7t6METKh6Ls7SqZRSaWn+/yl4iM84p62q
	 GlJZi14k7KdsmZoI7+jES4+hlY3uSkEIM+YS3EuQV1F04OxW12ytbl6X+K/jQ470JrX8w
	 p5T2pj5ZgTlWwxnNFeacJMYaDoLf8eGW/55VPPhASPRRqLED+WXlAVQWB+DbngVNoqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382958;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HOlvw6TtlLEyeDzklF14OzFxPLInEpTXEyR96pUm1vo=;
	b=Z06J3GPyFZXQihXN8Vbr3rt7flspqjeZlvGyMz1idpFtoumlkJCgDxOXL32XIsuIov8a
	 yy0QrYmyF3JF/tYIANR20FJW1C4c5CqaJ8y2IWqfedptkfz4eWRsVd4b8cJKfYb3pyWez
	 JB7aNOUV+6IZdS7noZIfHMavHsKsIzrq/8O7FMkVj4rtYV8BRsc8E+rXQIUwhjS7xd72s
	 CNAh5Iu19ufkZMPWg5IP1lnPSn4ix8OSKQ3btctoT+ah+legXljW9OZMlRTqFgOMacnhs
	 GOk5BcxcDMm8tdKBmAhPqeXjXa074jy7UF/mEKVxxLsVkyVdnw1eQPUoWxBGbNlfRNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bEhbfpHy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D1E606A325;
	Fri, 30 Oct 2026 17:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bEhbfpHy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BE91F0093A;
	Fri, 30 Oct 2026 17:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793382957;
	bh=HOlvw6TtlLEyeDzklF14OzFxPLInEpTXEyR96pUm1vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bEhbfpHyBrMJd3jFzbnI8JCvKCQo99Jjw12CDskIYZWw+dWG2AwSbU4AAN1/qsU7n
	 Sx1yxF2MjRjn4x/2j3gcMhhwYcFqig2G1BCGCsZi3h4j2yOY4r2UsnOt5iAm7zZM7z
	 /HnuYVUV841HhxXkClsCuZ07QLuo6UUMOl+lQZ1UcJtUR7oAmo0EIpbbsJvqJmDL30
	 r/MYPCx199IggQdwqttGZ3VMNCilM9NmGSi4733P9B0g+QQtCwGYH0FlfRQXStgL1S
	 EaKwrz+W4ZL1WW71+2JUaK5Kpbg/MFHGwlYyU9g0XgUdBuYZzgxlLHw/7TIATY/sdO
	 +PJP8b1V3jwOg==
Date: Fri, 30 Oct 2026 12:55:53 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cunhao Lu <1579567540@qq.com>
Cc: linux-pm@vger.kernel.org, David Wu <david.wu@rock-chips.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Vinod Koul <vkoul@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
	linux-clk@vger.kernel.org, Brian Masney <bmasney+clk@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
	linux-mmc@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
	linux-gpio@vger.kernel.org,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Linus Walleij <linusw@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-usb@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	mfd@lists.linux.dev, Bartosz Golaszewski <brgl@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>, linux-i2c@vger.kernel.org,
	linux-serial@vger.kernel.org, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	linux-rockchip@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>, linux-phy@lists.infradead.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 20/27] dt-bindings: usb: rockchip: Add RK3572 DWC3
 controller
Message-ID: <179338295338.1044358.128940246641930324.robh@kernel.org>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-20-0b0fd85a31ee@qq.com>
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
In-Reply-To: <20261022-add-board-ok3572-c-v1-20-0b0fd85a31ee@qq.com>


On Thu, 22 Oct 2026 00:11:17 +0800, Cunhao Lu wrote:
> Describe the PHP GRF register used to configure the DWC3 PIPE port before
> controller discovery.
> 
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> ---
>  .../bindings/usb/rockchip,rk3572-dwc3.yaml         | 100 +++++++++++++++++++++
>  1 file changed, 100 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

