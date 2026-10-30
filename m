Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793384101;
	b=VXwPFvO1TliYH4NGQykiLezwRusN9vlppwNonQOp+yvI1z3WRBMbfHvyu+xeXppBWnkR
	 Rmcm9omcAgDmoQOiRplm0QzMy6TzDecXQ8LE740DXcIiulaeuDiWD0Za4jV0XXaHLWv6+
	 q+zPuuHzFKTY/3H4pNGaz5Mmb8KuYz07MpqUhYPsYm5wOULnrKHg57A5dvG2aG0mPAUkI
	 tK83eVYtddNs6LT/qsf+fbNsJNWpk6XU5SFUghPg1au7k+H6w3J8WbxMi6UdbxHjhePv5
	 1RvJta039NZ4vHbLo7gyBd6TuHE4b2rw1U7wqOkFQ2AIApgH3/KrnGlixa2DzV0LngA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793384101;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xX4+/ngw10imxtV7Qx0M5QC+PH9quwicLxr3n+FYyZc=;
	b=sTdecuee0XxpDhGWs+28QaNmJDIPPLzZx2OmCKGBTmabZIebnv/A7NNCABZyUBUYXdt3
	 cMtbYVjmhVye3E9neX9frVV9RUPOg4nOVG0PWwsikFmBz+Puf2BS7x6U3ywxqRAIB0CNB
	 4oJCcC31nDmB33eiuRjYSCkJwsrdUx6TxYBCB4lhfm/DceBFmMPClyjBJQpK6v8e3Pz1M
	 RNRP+lrvRjS9cgqs57bz9wZxbDKRmMejmLur7Xub+HrmHcI9fENztUPv8eT5h6Sxja82k
	 ma/gircrU3D23K4Kbix8lJt6ycuO2x/dGRAh7TJNsmYkELw2uVtaokgeTeSSssqIl3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+rTn4qL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9AD606A31A;
	Fri, 30 Oct 2026 18:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+rTn4qL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB531F000C1;
	Fri, 30 Oct 2026 18:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793384100;
	bh=xX4+/ngw10imxtV7Qx0M5QC+PH9quwicLxr3n+FYyZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U+rTn4qL9aKfAqK24WGz11+2HZDRD7OcmjFhcTHsKLHulDk+qJB0jX6OIJTW5dqv5
	 bhAyVUPKMK5g5OPQw6v67tHcs41p3Qz95LDNO30NKVSfbbZD3eI2o6lUAs/JOVicYD
	 Jm0Z882bafmmMiLZkzflj4+qaNReXe8iCQ1DYeO0aFA02mNWCQWjQM4qUDOMCG/1Yc
	 i4G5qRJBWOQ6Tw1D2duEbyG8JIHXPNE4NpMDtyiQ+5vL92riH/rmmdy7Aj9yoY7pcg
	 1wcV0QkSPPYD2Ly9j0vwfbdlNEfnC5IKQFK7Np4Z5BtOmYmlRL2ViMFzgMbRwTJvRF
	 UTUaSSI8/Gxxg==
Date: Fri, 30 Oct 2026 13:14:56 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cunhao Lu <1579567540@qq.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-gpio@vger.kernel.org,
	linux-phy@lists.infradead.org,
	"David S. Miller" <davem@davemloft.net>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jisheng Zhang <jszhang@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-clk@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	linux-usb@vger.kernel.org, Lee Jones <lee@kernel.org>,
	mfd@lists.linux.dev, Jiri Slaby <jirislaby@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Wu <david.wu@rock-chips.com>, linux-kernel@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>, linux-serial@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-mmc@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH 05/27] dt-bindings: pinctrl: rockchip: Add RK3572
Message-ID: <179338409611.1169964.10654719461707272138.robh@kernel.org>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-5-0b0fd85a31ee@qq.com>
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
In-Reply-To: <20261022-add-board-ok3572-c-v1-5-0b0fd85a31ee@qq.com>


On Thu, 22 Oct 2026 00:11:02 +0800, Cunhao Lu wrote:
> Add the RK3572 pinctrl compatible.
> 
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

