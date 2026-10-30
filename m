Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382862;
	b=4l+hX+BntNUWdFxS+SARucmUSJJr5MMUJ1BQvnZ3Gp97HGdLy7CyxZulhTgvcFweK3MB
	 rEEZ8xG7iIZA/YWq/zIyjys32no3uwxfJgWNV+xINXUdTPq4jpWFe31C7vlUpJdKMdkBS
	 84Qj1upPYdTHtsAHTTZOqkfMDXBSFJdUonZbYAmSjxp4CBpCSzJRGDSUwOx/SBKfzXdsm
	 sx+t+jIeOIqnKjzOM/oo3v4CMiKwgdx87oKLwd96GwuhFrpMTV7/0ERfoVBgjWgi5hrf3
	 69i2oNULQF3eUvaMtFk8YmUkqjNGdxr+/88KC2H/WvN/U5edyNBxLOIXvCflNx/34Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382862;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ofYepfLWGmWwLQwuVQyBDsj69K2Ei2/q9XqZv+jRkos=;
	b=PT0uhrF8t6NM+TQFpaaPszz+mkM2Axsjy6LbryMcrJg6mAoE1Usx2CROcu4TWodWYG7u
	 ruHhZPBT09SisjeZOWGB0M7XqtSs7xt6KDnCP14ffWcNw66zCyR9jlBl3LDB6tOsrXPc4
	 VT7K631FQfY8KTpLmRXUxCBnCAQ8QfQbbhw5bdhfsIOq4oZpNbaJ5wKBo1uf1Lu27h9ec
	 J7dQ75exrLcDCI2eDOX82V6x1E2ZRkBvGxMVZGmRIDMwnLYXe5wSB86iu5Lhn9f7EfxB/
	 zwWLDpgPY4E7w8gl49sO+8l3AiPDQNpjoLK6lAL87UaJ3fdsOJ1/bX/FnL9keddRBPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mTUwbBoX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F168606A31A;
	Fri, 30 Oct 2026 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mTUwbBoX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CA51F00A18;
	Fri, 30 Oct 2026 17:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793382861;
	bh=ofYepfLWGmWwLQwuVQyBDsj69K2Ei2/q9XqZv+jRkos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mTUwbBoX2F2BEoFWM1svESWoPutzqIVDXGy5rbc2beDz2TNMpie8iOSq/Jk9UoqMT
	 vb28Lr4mQcYzMzgJZ/nRg+S1CjWFAZsAw7rdNVIdLourlHpWzxThwR+EWeyrtiCHzi
	 veetsBeHMAUwwEPUFau84GaoJl2cwmNd2qqkv4mHu5yB6ckOWqNXMx6H9MPOGzIkA1
	 jcrDtorzsFDc5l7baBuakCuQ5St7COgkLx+yfEjGtFYB9CebcoduvrFyXLFnrimGs6
	 rrpVEUAOxK2FsVkHqAbKvLPU5kpj5dMuUODIh0ZhuTzLGGmZKLJweAkWy6YLLWYUex
	 Ztl8mfTpXyZ2Q==
Date: Fri, 30 Oct 2026 12:54:19 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cunhao Lu <1579567540@qq.com>
Cc: Eric Dumazet <edumazet@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, devicetree@vger.kernel.org,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Jiri Slaby <jirislaby@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-i2c@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	linux-mmc@vger.kernel.org, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	linux-gpio@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-phy@lists.infradead.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>, linux-usb@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Bartosz Golaszewski <brgl@kernel.org>, Lee Jones <lee@kernel.org>,
	netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stephen Boyd <sboyd@kernel.org>, David Wu <david.wu@rock-chips.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-rockchip@lists.infradead.org,
	Jaehoon Chung <jh80.chung@samsung.com>, linux-pm@vger.kernel.org,
	Brian Masney <bmasney+clk@redhat.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Linus Walleij <linusw@kernel.org>, linux-clk@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>,
	Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH 13/27] dt-bindings: mmc: rockchip: Add RK3572 controllers
Message-ID: <179338285864.1034428.5820071698056740457.robh@kernel.org>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-13-0b0fd85a31ee@qq.com>
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
In-Reply-To: <20261022-add-board-ok3572-c-v1-13-0b0fd85a31ee@qq.com>


On Thu, 22 Oct 2026 00:11:10 +0800, Cunhao Lu wrote:
> Add the RK3572 SD and eMMC compatibles using the RK3576 fallbacks.
> 
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> ---
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml   | 1 +
>  Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 3 +++
>  2 files changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

