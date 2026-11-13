Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565085;
	b=5JDOZXPyU8H1Z6300bl+CUSfQzfAsfsAzpd4WTzmAm4sEQXSxa66D93TNUNKR/XOZEic
	 +Fcd+CY26jJn/UVh1SP19v+flsItaLEr37bPKWYr9ahWfPrHikc45S7AlSwxurpH3iBqd
	 tv0b7+ClMFyXqSSUFsgbKEjSLZc1In6dt1zTAQ1OhHb3Qyn07K1fcsop9i4VYTmuSTIHA
	 OqFlKa9cbvAvRofXciZOsIiGBJYEN15i8RXHaa+zdI1BFZ3BW0f8zt5j8vA8BWvW0/lwl
	 G6vjAhpStjtdrLjdE5UgouDK+AOkJJ1md7yQf0QZpEkV4IwyN55i+NGaF39AEsRcy8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565085;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oWpj+fMcU0ldZMemXXF2GwJUPPqvOroaTzblSr6zsuI=;
	b=tIfB7OZeybEytraTgtrbFtUvmhCJj8kTc+klD6zprwVLmIHgOgxkRyl9HZXnqWNRjQ8o
	 fQFzWJovtOerxI6Ixu5hyllzlSmzVD3gXwMHKtI/JtBaDBNZg//vyctI5jaXKtnUS2ZPa
	 lbDL5BbqI1hBhsGrwkLmqkeUouOZPsBu43I2bT6BVY/WmYB1+0VIRdW0lXtCWqfr3lc23
	 h8+VGBYQkQU5oRJsdTXdGPVEznWeuwbGEAutPNe3LYv7xoEKLkpZzAjZi6YUvJuYFI8yh
	 oUiJLOlYUQ9PxE7zY55gyO3twJx2j+5jHCDDrgMg3dC2seCmC5is9Xaw50E0XTIfLFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IEGnZ9s7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB8F60A2609
	for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 10:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IEGnZ9s7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FBB1F000C6
	for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 10:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794565085;
	bh=oWpj+fMcU0ldZMemXXF2GwJUPPqvOroaTzblSr6zsuI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IEGnZ9s71CxuM1FatGWVZ7MjS/Ksms7wsHnU0cCjvI8yD6ri1brzQWsOTKwvf9scE
	 1x6Ik/hWXwA68bNMOJ2qk0IELCj40VL2vurKZg2CBldMMMeZzCnayO4J2Gnj0Az3+8
	 sLcpEApwpShOgzgYGnsC5zQ/BTQA1pPyK8jNvC4x12yPuP5UtkKRgIIy+9jLBgNocB
	 L9MMZWBtHuoQNREggu7MnqN8y/aUPyWkH6bNpbqXdfg0nDqFJKcg78yywZyRRLPCde
	 WmTYkuNtdC17dgd1l0oq+eyfgjAcECX5WMpRB1C91OhxyakR/QzDsp75gUIpaHPi3l
	 K27CaA5AGXzPw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-717080a2d50so1192089eaf.0
        for <linux-mmc@vger.kernel.org>; Fri, 13 Nov 2026 02:18:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF6mAQPHsFTPxXo3Br1HS2TEVSWnQJysQ5OyyoA6xLSYDzhOVnl1SlO0GKV5oiMtX4iiUUYBH/19SY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6VsRJeuFXIQ3dYfRuowSX0sXdEMSHQIZ8ztO1ji7kdpI5SQMP
	u3k/GALZjfPn0Ez1Id+Jx3Gq1MTOY9M1qBQYFGS1g8bMlHscZH73O3frSFq/40KBtQlfDZHP0oN
	3Cl3nL3ffKUcoTZ1OcF0fyLvGp8/FI/Y=
X-Received: by 2002:a05:6820:2228:b0:70a:1787:2696 with SMTP id
 006d021491bc7-71ab50522aamr1246436eaf.61.1794565084106; Fri, 13 Nov 2026
 02:18:04 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com> <20261022-add-board-ok3572-c-v1-8-0b0fd85a31ee@qq.com>
In-Reply-To: <20261022-add-board-ok3572-c-v1-8-0b0fd85a31ee@qq.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 13 Nov 2026 11:17:47 +0100
X-Gmail-Original-Message-ID: <CAD++jLkJsYtjKOF7wpiUqSLoBuiOe+C5sMEQo7XZ1dW773+pJQ@mail.gmail.com>
X-Gm-Features: AclHuK9FczXasoO8qxg9IxepytTJahNxlbbuShGYzvO1iLyvCzMkO5H7q2dWjZE
Message-ID: <CAD++jLkJsYtjKOF7wpiUqSLoBuiOe+C5sMEQo7XZ1dW773+pJQ@mail.gmail.com>
Subject: Re: [PATCH 08/27] pinctrl: rockchip: Add RK3572 support
To: 1579567540@qq.com
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Elaine Zhang <zhangqing@rock-chips.com>, Lee Jones <lee@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Ulf Hansson <ulfh@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Wu <david.wu@rock-chips.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mfd@lists.linux.dev, linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-phy@lists.infradead.org, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 6:12=E2=80=AFPM Cunhao Lu via B4 Relay
<devnull+1579567540.qq.com@kernel.org> wrote:

> From: Cunhao Lu <1579567540@qq.com>
>
> Support RK3572 pinmux, bias, drive-strength, and Schmitt controls.
> Enable input buffers during mux changes for the RGMII receive clocks.
>
> Signed-off-by: Cunhao Lu <1579567540@qq.com>

This patch 8/27 applied to the pinctrl tree.

Yours,
Linus Walleij
