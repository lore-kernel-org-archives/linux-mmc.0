Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793054090;
	b=hOPSWizYvXoXdUkrd3+WDrr980zJoj/1MI20jJTKxvfDOhIbFNxaphRtoq9+du3ez0P9
	 BktqDtlsALEAQMcY64zN5U+MkhkWAzSEj6wUGk7TxSm9ZOWtK7XCRPI8GI+zQ5epTlF3C
	 E5+2kLrTObUyNuHk5jzPDLJ9U1De1x5p/81f075G8yVXiq+KGXZQ3HJ5jdPhPWpGj7idV
	 JosIyv51ebUZQ/K/pszwkYaSe5GI9prVek9F6SKP+d3G8S0etihyT8w41/6KdoaDZBYJ2
	 kW/nxnbOMnXmLDQOd32YmdhgHWYGFfQs9Hd3ZVwyREqbKBA6JXRTl1ao9z3Zj2nUEvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793054090;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=v2Nrgywn65NL+RE7paBhmd1KoquJfEvns7IjUonmCkc=;
	b=Okysfav3LdbuHBVVtOc7Ti1WwVFqTRX+XXmoK12xmjIiSfnCclUDW+LyKERTqgN+ow1h
	 MA9IicOgcVuIM6NDTJezIje/gbpt835NHcw406+JcZczA+ogw+evoIi2RZLYEi/DU046v
	 JJWQSn9BDiEX/U40sspFiZaqawJngJr5+Sa9hUvTuhM5tJC8b+jkBqKkIyZfRYrb+nbXY
	 3H1t4djQO7O1sLqzGC6kp7iZjY80uybaow3senheMYJuE+M6pygUiCbzAVqeXzN2fWOPq
	 LSE2BFGZ29x2nUjI8smyvMwB56Pv53U3Lr75TveFWvvwdUgRvwjmjBYvwIHYcn1iuEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfr1jagI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C13606A31F;
	Mon, 26 Oct 2026 22:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfr1jagI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255931F01828;
	Mon, 26 Oct 2026 22:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793054089;
	bh=v2Nrgywn65NL+RE7paBhmd1KoquJfEvns7IjUonmCkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jfr1jagI2Pt7wvdiivuSrWwaHZsjr7u7Ggk+4UrVhiB5fU4Je/W8tTTJCjIxJpK1J
	 Tzeb1RBUqdUJfpPxa1yyfqbGUkdK04/mN2ACZgCpTU6LHGP/tBhQfJllPNAePmdlgv
	 w2FMqcuwbZKetfkBm18RKMOUZLiTglEecAMrH8KVJRgxWcALpS1wsHMbbxGetnnn8x
	 iyLLIEa5I5iQ7M1jTzvYZuPkJcIxab5Z+kank8/A6ajRzxrW+QNFbHS/XuOJAQJLq9
	 4nGIAS98j6N+ECXwN3QSrQGmckdeTHGPoT0dOuN0TAuyngnPnRE0glbUHmUA/vBlCL
	 /oGT3gc4ZA0sw==
Date: Mon, 26 Oct 2026 23:34:46 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: 1579567540@qq.com
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Elaine Zhang <zhangqing@rock-chips.com>, Lee Jones <lee@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Ulf Hansson <ulfh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Wu <david.wu@rock-chips.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mfd@lists.linux.dev, linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-phy@lists.infradead.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 11/27] dt-bindings: i2c: rk3x: Add RK3572
Message-ID: <at_VaLUwxn7h3Dal@zenone.zhora.eu>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-11-0b0fd85a31ee@qq.com>
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
In-Reply-To: <20261022-add-board-ok3572-c-v1-11-0b0fd85a31ee@qq.com>

Hi Cunhao,

On Thu, Oct 22, 2026 at 12:11:08AM +0800, Cunhao Lu via B4 Relay wrote:
> From: Cunhao Lu <1579567540@qq.com>
> 
> Add the RK3572 I2C compatible using the RK3399 fallback.
> 
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

Acked-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
