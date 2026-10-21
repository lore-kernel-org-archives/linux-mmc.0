Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602909;
	b=UhbwxaRz0nXBmdFss7sVKxgMaHYCR30TvoGXjabcosVEapbSBCIEzpKNnfXpyu+scdpE
	 AeQMqZvZ+UheK0va51vdafeM1upws+ZdVvUHSIc0cZuXJ5cenfFtTpC45dDLdMRu+6SJ3
	 T+0KcWuYlxOT3tRMU+1Rhoeb2gMEvcRcq9aRMybkAkINZpspivBvf4hMQj9mjP8vGidHA
	 f0XIeSGKoFKQJ+53CTCf83lv1gGq6mu9MjI54NEke3W3XFMg3fOwawUIuAyHhRFei0wXq
	 bKEtJ8I3Dzp+4d8EYZE+54hbIiW1Irh1NGeyxW1cWxWjLoyUUMD+M6TJtVgVxcc+Jcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602909;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=Fp5SMzjGwR8UTbVROtVUKvftRt8E5iWuXvuIAwCI39M=;
	b=zRTnmi1sk8RDSo5vHWEK6/Kr6MRuhmwtxKU/71Qd7gJh4z+UastSljLW8lAft3iPFgcQ
	 LScscMWwb4xMnduNAImQCFwgajqjpZQw6DLVWDMSPgY9TmpGIPtVjiPXaOjOU96DXdlbx
	 tGTklakM+yrHod6loFRYquOrkoZSpot/F0rKyQ4HJyA7JD4MRI8WcUmbfYpurBEp6gVQZ
	 BMZVLHLk/S3P+hND8R3IkxGyIGjov2WbGTWlE58wfi3vX3hgwC6xEZunWDczYzLyzREuS
	 0BEQClduXsSRYwgUtoiquwbZtAMY+Z86+JDg37el1Wz5ObT1MQOsPUoJj/OhW3w/ARw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=pB0gOMT+;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6C7606A32F;
	Wed, 21 Oct 2026 17:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB6C7606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=pB0gOMT+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Fp5SMzjGwR8UTbVROtVUKvftRt8E5iWuXvuIAwCI39M=; b=pB0gOMT+fyr6rtWEChBRV7r7IT
	jKdlJAhyeHmefQZV1x+Z3xhu/kaR+8JuTGSXi53eInrvAAJE/6KGlf9cZ6sid/bPGmBeJyuiV2G63
	+baotz7vL9WSkRAtWN4z2lJE8tnFheyeJnkUbqlG/v0qp67qEW6kXutLT+keqS4mDvkU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xJZtj-00C8Oq-Fd; Wed, 21 Oct 2026 19:14:43 +0200
Date: Wed, 21 Oct 2026 19:14:43 +0200
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
Subject: Re: [PATCH 14/27] dt-bindings: net: rockchip-dwmac: Add RK3572
Message-ID: <09c223e6-6872-4bb6-a915-870c3ee614cb@lunn.ch>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-14-0b0fd85a31ee@qq.com>
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
In-Reply-To: <20261022-add-board-ok3572-c-v1-14-0b0fd85a31ee@qq.com>

On Thu, Oct 22, 2026 at 12:11:11AM +0800, Cunhao Lu via B4 Relay wrote:
> From: Cunhao Lu <1579567540@qq.com>
> 
> Add the RK3572 GMAC compatible using the snps,dwmac-4.20a fallback.

Since this is a new device, please don't allow tx_delay and rx_delay,
which should be considered deprecated, replaced by
rx-internal-delay-ps and tx-internal-delay-ps.

We have to keep tx_delay and rx_delay for older devices because of
backwards compatibility, but there is no reason new devices should use
them.

	Andrew
