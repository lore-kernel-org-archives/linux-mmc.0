Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793384253;
	b=ZLIqwcl71CDNK+7XF5nHJZSOnSyHQVglqsQdOZEtFZ1KVR0tEHkp+fUrQTdddlURT397
	 bgjwXTkTped7YiUXbrq/NtuRZoykmApX73vUgO0M6+lLzA/3YKkCi04TJa1e2e1QfnNdn
	 zkRw2A33I76tZY6xiMFxmHSzhDltUAPEKfV6f0yRHstD8RAbfvqBSNPBIM3mpT4O6TE8Y
	 B56i1r9cCUSCZ2qOO7VsL8lhDZtEI7VgB7vwpUHnNprcSyr/89psn1sfG9gfrSVjEQzOh
	 ESEa3SvLhfcNu75UlvEVefcWW2S4UC5yn34ZWIptDWAWUwenlF14qJ5h+xJFxMPovrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793384253;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=X5x7xBzSu9MQJx0VW5rlzSeRxFUOvmHNtGRPFRc0mBI=;
	b=teIp1lRicFI8Hml4k8QZThoduiRANQo8Kz8904dagDzYfkKn1/RFp2LZqd4aiTcUSgx6
	 8GkxPDq7W9jnC12/X6V77fn6EJePSjsRfyHTNAwS7PynWTfwnfN32tu3HFR7qKauX6DHA
	 6lYaIUviabZpOhXcLlFy3KR80+ah528lEb2sg5kv0HDBPvSnE/IhKT4MWRSnxnwcyXhI0
	 Vj3PnKsd320pZeXA03C9/sJcDUO+swBG4BaZwHoLovB0jAiTn1t7GKQ2nyWVNeV3+ymZO
	 0JvqD9w5N+mTR+aOtuJ/1nmf2kQrhk954QfsdAFH7vO38sWOU1V2rM6FiK4t+e/Flfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m1+tweTA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DEB606A325;
	Fri, 30 Oct 2026 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m1+tweTA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90241F000C1;
	Fri, 30 Oct 2026 18:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793384253;
	bh=X5x7xBzSu9MQJx0VW5rlzSeRxFUOvmHNtGRPFRc0mBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m1+tweTAyDL+KzKUMPs4dGwRjv+e38a0bJy8T2f9MRPJqMUJdetcYqltW7co3sQLO
	 6uare3isNFNyCc057oyfIbeQxzQVz5ReHHOWiJWDTKKTcP4Ah3Bpw/KyAHTcrPiQU3
	 ivIZPnmfsM934Ejwl5FUp6jACqhsqgI09YPpDmq+k47eKhC93J1dU9+EhzL9K8PJC8
	 jcEkg8jBgib97x7RuNt0KkA9/5e/Wm16Xr7D9lmFtu2EtSqKZbZRZ8rre8u68kJA6C
	 n8PBZdVdlJ97ogHIhBHMPxU+l3kJK4w6GE7TlVSTGW760S0BBNCWz5AA3NOF1mOXUs
	 /K81BO/2wxgOA==
Date: Fri, 30 Oct 2026 13:17:29 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cunhao Lu <1579567540@qq.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Brian Masney <bmasney+clk@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <mani@kernel.org>, netdev@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-mmc@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Elaine Zhang <zhangqing@rock-chips.com>, linux-pm@vger.kernel.org,
	linux-i2c@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	devicetree@vger.kernel.org, David Wu <david.wu@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Daniel Lezcano <daniel.lezcano@kernel.org>, mfd@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-phy@lists.infradead.org,
	linux-gpio@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Zhang Rui <rui.zhang@intel.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-clk@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 19/27] dt-bindings: phy: rockchip-naneng-combphy: Add
 RK3572
Message-ID: <179338424846.1186130.13019984691130046587.robh@kernel.org>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-19-0b0fd85a31ee@qq.com>
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
In-Reply-To: <20261022-add-board-ok3572-c-v1-19-0b0fd85a31ee@qq.com>


On Thu, 22 Oct 2026 00:11:16 +0800, Cunhao Lu wrote:
> The RK3572 combo PHY uses two input clocks and one reset.
> 
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> ---
>  .../bindings/phy/phy-rockchip-naneng-combphy.yaml  | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

