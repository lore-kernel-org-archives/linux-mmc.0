Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793384387;
	b=tOK2Hxt5OZJqnCCIM06Fatap9UMxGDYtu42Y2P1V0WdpBNAM0OUP0LbWSZwqE2/36lbF
	 cZvoVInjP7gTlWb6jU0U9B4gYGYE0HSkO5Ab0aUiP1pV3aQ0MUoQFYcf44fFVcDJ1njNP
	 nbMEaqMUkhrodt+yMW56+HYW44amTSvg4X2u6ecWzVNkyXKHs3hHK2f3d+/cYBZxIPcbM
	 MEmiDa2V8vxpkiEeojIbaLqFOWRIGWiSAJVoeMvvtf5JDts0UgvRxN/jg/UaraJJ6kDD8
	 gnGisfGZhQQnDjN423jJ4fvkh6J0zHd4NSV/d/R2q9wKHjawqhN5sPXy/FWFS/kGs1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793384387;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=t9k0BgLWrg0mUnaOFTvLZXWxj8nv9nzACn3VaTjGowg=;
	b=tm9UcE9ueF6nKCARlLbix9ZQY3GLVoOPMMaDn3oNRkUQZV8qTUH1LFVre2GdboCLIfz1
	 Hbi54qbZ+xBNMZolckRD2QxxBaBKffC7w+7ivl6uzGJIHHNwO97QykjNFMpo3Zdv7pBmB
	 X+Ngxf7RyXrkuyiHLKLf+RErDhAmzIe56jzyerRyfKN0jT6c8Gg3nEyXRXM4UZ9p0MYH9
	 h8d7zVYxdtyVmxw2ja3KTLjl8Rkd2YAZEHTTE+E0ARgUy4uXVeeaOYPAftpCGbZJOVBHG
	 nxlAG2jT0YnLJL9vKb0DinOK7u/861hMPV0FT0GpR3SsUxU/jzQl3kawcBY9KZ4ETgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GUQgTEW/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F302606A31A;
	Fri, 30 Oct 2026 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GUQgTEW/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D351E1F000C1;
	Fri, 30 Oct 2026 18:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793384387;
	bh=t9k0BgLWrg0mUnaOFTvLZXWxj8nv9nzACn3VaTjGowg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GUQgTEW/T3UIswkAHLvn4oCvzwgBSpQxdyWQcY9WV9CIvLZjqNBcLb72+RvfvltfV
	 tWQhVoH5G9sEFXejJkpQvfX3R2tTbHKbt3vFjZoFyv8oZ5HSIS0h/jQQsx0axMuO4g
	 TxA1awu6asKWvsnoVD6+k5Dzq57ldWC8SkhjAixObYwjmARl03NJLnDIHjbFgjESk/
	 C3I4bxi1vFVuc7qtV7gsiSVE4QSR6kInbi7l+B6sJDfuMhQ4YzTqllZQCVYsQBJXKo
	 GHhm7najGasgVQrYJENzMvqpo0qtbJsUi41wQ7Wz7x7RnfSZ1CKX/JfMkxUHvgcE/W
	 dBVEDTKFnqzWQ==
Date: Fri, 30 Oct 2026 13:19:43 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cunhao Lu <1579567540@qq.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
	Brian Masney <bmasney+clk@redhat.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>, Eric Dumazet <edumazet@kernel.org>,
	Lee Jones <lee@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	David Wu <david.wu@rock-chips.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Linus Walleij <linusw@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Jisheng Zhang <jszhang@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
	linux-rockchip@lists.infradead.org, mfd@lists.linux.dev,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>, linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH 25/27] dt-bindings: arm: rockchip: Add Forlinx OK3572-C
Message-ID: <179338438342.1201325.14780731681186218967.robh@kernel.org>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-25-0b0fd85a31ee@qq.com>
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
In-Reply-To: <20261022-add-board-ok3572-c-v1-25-0b0fd85a31ee@qq.com>


On Thu, 22 Oct 2026 00:11:22 +0800, Cunhao Lu wrote:
> The board uses the FET3572-C system-on-module and falls back to the
> RK3572 SoC compatible.
> 
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

