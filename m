Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795106920;
	b=pS1opmsLoFaujEUDNGTyMn6iVzfb3cqSVgTCpk4h/tccctc1NhCRx+Wk+E44CeatfmFd
	 7PMBO5OtJZKxrzg8heygMr+B76DRuZLEEvZSFGfEqr5So/0H/q6GyXLvx8e/07ucYm4tO
	 uLx0gXjRWso872rAY1Et7N2Vd8i9s54drmSlzJ1YTgFzXT9EeGSF6ALrP7IMhH/yI3YJD
	 rfIBs8oXDJRBPJlvClBoym4W85+yS6KuTayxOom3/3yNGn7V/xmTVpnjpGhrLne1f70N/
	 3YdRPMt+i1IT+jOq4DTvz+1DyiDSqMd1Fu9OV4qd1n1CHIm7tGQOLnnAMp4UHanINOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106920;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=8HXa68Qw9U8seRwWAPXNB/ewGGSCzzxtMHD1FScJ9Vo=;
	b=PofsEpGhEyxi0Xsm43IzCuu+v3Jxjt9/EMls+HEs5OqkCcvZ2nJx5NnQl/Kr6a5elEFY
	 9gO/iwUbVxDOIyUxnNiOU8oj+idWIT4uFnJbE0bAlkY12emGwj9PBAC09HYh4ogkNzot0
	 eDS+hx3efGpq+WGSHI++WMAyJA/nAkctPR8xyuxfSoMTazW6NDj8JH1SAHNFiZYu/y6Oh
	 uD/p5j3emF+KLZNK6aLdyML0ZeYLFvedem9AKWP2Pdc/ICYrp21+uQMWAVAbWz8lPAt/t
	 yQRvfNQ+lz5oqULq5bG4GVtHVWIcQAHtl+T9L4Jwywmestn5/MVA9qQvNTxjhOUQPiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOGW4L7i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FBF606A320;
	Thu, 19 Nov 2026 16:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOGW4L7i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DBF1F000C7;
	Thu, 19 Nov 2026 16:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795106920;
	bh=8HXa68Qw9U8seRwWAPXNB/ewGGSCzzxtMHD1FScJ9Vo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=hOGW4L7iXcp23kZoYzOxl244lck6jnSGkO3u/foitA0/9XQXVU0S6YWNWJy74lRWJ
	 IZnpmAUyFvq0Kth/zdeWp/9lb+Xft6SlOmA00sPRSsX+vj6M3eUb15cntpHPNHu3I+
	 sqWeySL6onzxSn+OubDpygDV8ycIfwI6hjP5vEYboR6jH/XruUjQGwrpadH3FLRBcO
	 gWUmEu1Z6nHSwlR1k0HTIr5MQngxOUnS0sAJofHnQaqKOuTNDvPfkoLQ1H0G6fh82g
	 xkyXaRVVzeEs5ghlRSE6AjISFFFCihwgbiuQnBWawAOyXcTAmDsRfoRAXwvKbSihVw
	 K/J2K3KG5X2vQ==
From: Lee Jones <lee@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Lee Jones <lee@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Wu <david.wu@rock-chips.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Cunhao Lu <1579567540@qq.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
 linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-phy@lists.infradead.org, 
 linux-usb@vger.kernel.org
In-Reply-To: <20261022-add-board-ok3572-c-v1-4-0b0fd85a31ee@qq.com>
References: <20261022-add-board-ok3572-c-v1-4-0b0fd85a31ee@qq.com>
Subject: Re: (subset) [PATCH 04/27] dt-bindings: mfd: syscon: Add RK3572
 QoS register compatible
Message-Id: <179510691068.78262.17485799721461490431.b4-ty@b4>
Date: Thu, 19 Nov 2026 16:48:30 +0000
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Thu, 22 Oct 2026 00:11:01 +0800, Cunhao Lu wrote:
> Add rockchip,rk3572-qos to the syscon compatible list.

Applied, thanks!

[04/27] dt-bindings: mfd: syscon: Add RK3572 QoS register compatible
        commit: 9776fbb47d6c9d0928c66734ed565d870d8fdfe9

--
Lee Jones [李琼斯]

