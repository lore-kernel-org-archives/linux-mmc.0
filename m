Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382555;
	b=knYuQiWgPWIIfj82hvE+milhxdvn0Lo4CubGWDXYOSfiO07jl18nk6uOQj21E3LJROGe
	 FBQdRyRH/rDUGl5JAxhqx1VgImC3JqrexE3wJEy8a/EhK6Q80vWygus81CWZAYH0KGcrC
	 9xAcUQcK8FyrE7QQHD9IIkzzpP3B3Ag2bz6AwqnWqZwjHoV2wTEjjPQM4kdE1tiGTy2tM
	 3eCe0Gyx+wCzq009jkZqsIo4+HXC/q7yJMizWQrHR7HwrGVsIbvnlpsrphFhLpBqoKl0v
	 qviIYtHTsmPstT1LAXbJ7xM+h/gN/D5q41el4HJnJ5VaHP4qtzA637AXO/3i/mNnBDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382555;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZLx/b2ua4Zd1yUXxRK6Mux+7pE/jsjGxjCPHmBP7rM4=;
	b=vwmxTwwnjraYMVPRSf67ht1yYQW5CjDpIP8WKfHA+Llnjhvbx85Fkv9RBdaNALzikqbu
	 Rzru6eYT/ZJAksnWOVO+ZhS41bB9BGAunw+D+lSqlESJX+s3q3IJ1jZE10VrceUs9uNZC
	 9z3WTFjJWU8k8NraMljYRmSDg/z1e0Y4A0cy7t90zkmf1JsvFBdkLOJEy+51mMQ8AATqx
	 kt6A0aFyaHRn5p2uoJ5WKJjUcCxhYLGRKL12x4Dyhd0d1WuRBOFwx7LBZV2S1gQz6T5KQ
	 xWbQjpbE+drV6kWH9zDGG0pzXikgDMdJj8ad0lmB9qNc0k/2pfZ9fIhhvBnLnDAZRRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JVXKBOye;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39602606A31C;
	Fri, 30 Oct 2026 17:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JVXKBOye
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B951F00A02;
	Fri, 30 Oct 2026 17:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793382554;
	bh=ZLx/b2ua4Zd1yUXxRK6Mux+7pE/jsjGxjCPHmBP7rM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JVXKBOyeacLReNNa2EEW3SAE8Ys5gImVRYowVR1gsFBt+Bu8DUy6D2cLOJw92crbf
	 Ysrn4MNX4WGx5BqOWOxpn5RwmdiLabSOcqkXbiuvtw+bqLEek0rA6CcEE9WA0j7pr9
	 cfiCvIP6eAb4H2GQyGhEd+qezjMDOFiUFpZ8cznscnZtVxfDLS+VziBqPeXe4lmq64
	 S0n62bXlHRiBzJQDIF3dkXiq5EuS7j5k4qrg3XTvKLVl0TvbFf6ucpwBkrcrQdy8+C
	 eNrGUxkyg+QCaevcoMKLTZ8QEcD8A9lL+yYUSOXKBU81us4OrwtgFUEUi+xD65uY8J
	 hOTu58dWq2tGg==
Date: Fri, 30 Oct 2026 12:49:11 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cunhao Lu <1579567540@qq.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-clk@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-phy@lists.infradead.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Elaine Zhang <zhangqing@rock-chips.com>, Lee Jones <lee@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>, mfd@lists.linux.dev,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Paolo Abeni <pabeni@redhat.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-pm@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	David Wu <david.wu@rock-chips.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-i2c@vger.kernel.org,
	linux-mmc@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Richard Cochran <richardcochran@gmail.com>,
	Shawn Lin <shawn.lin@rock-chips.com>, linux-gpio@vger.kernel.org,
	linux-serial@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	Linus Walleij <linusw@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-rockchip@lists.infradead.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jisheng Zhang <jszhang@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH 03/27] dt-bindings: soc: rockchip: Add RK3572 PMU and GRF
Message-ID: <179338255087.1001548.4507997389311414177.robh@kernel.org>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-3-0b0fd85a31ee@qq.com>
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
In-Reply-To: <20261022-add-board-ok3572-c-v1-3-0b0fd85a31ee@qq.com>


On Thu, 22 Oct 2026 00:11:00 +0800, Cunhao Lu wrote:
> The RK3572 PMU and GRF blocks are system controllers shared with the
> clock, power-domain, and USB PHY drivers.
> 
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip/pmu.yaml |  2 ++
>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 12 ++++++++++++
>  2 files changed, 14 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

