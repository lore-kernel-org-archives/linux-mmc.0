Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794134133;
	b=lLn87ns9AWY31b3wA0ZA6eo4XDM2Q13GL2CkRGio/y5NYmZiqqjOqhk5Z+GX+jSzdlOV
	 uuyYpZJNn5SLzZx6G/lZT9mIDhy/pXjt06sNCGL/w4T3WQNccOxZwmTjNmbjBvTUa+/LU
	 Ui20R9wnMPsR2ML9Aiu4Q1UGozAekFfNGYl++GjB5rl5gE472J0iWAkGmCoiR2EhdoRAU
	 GGqzKoB8BoIwzRXEa2STd8hWBVEDDsuew9b31L1Nix7qGhJRriqXMOTNAZUdmd6TY92/s
	 pnxzmVDVCb7Gvpf/ng/Gv5Nx/QS+YJH+GD5iRyGU5Mq7SpakkRg/z74dnpV96PLqpkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794134133;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=biMNnuk3Zlmj9i5odT0zZonccKXcOUkOod+xD4mMBfI=;
	b=uRNWcpJTwwIvxR6j1Evsw+aDRz6SDzwpcBqM5G28VkdNYNIWsYhtTAyNWIyr3zjQpmf4
	 g3Wjp3SzPsi2LALmfbH2tj7fL3bF0UIhQ323eCsj+pk77GjIgpoP241JeP/gzC1FATXod
	 C3TEGOnBYPM95C9btCWdV2yDvXR5SDIPinr8paPwY3A1jldN6hu0RUWqkqrHBifidqbLu
	 l7vVYubixcb/jv/xqfQYyueZpG3OBsvCwRzMnNe5/Ryoqod3exPI07BIglFo4ncnOOm/4
	 k5zgpp26AyvCAssCrI2pjjF1HJdTG050TQch/jDXIponAaULsNAOGpHDQUTZKZwKg9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S6m3DuiP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAD4606A31C;
	Sun,  8 Nov 2026 10:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S6m3DuiP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634381F0089F;
	Sun,  8 Nov 2026 10:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794134132;
	bh=biMNnuk3Zlmj9i5odT0zZonccKXcOUkOod+xD4mMBfI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=S6m3DuiPCro/XVd9cTVILY+yPCtzVh9cHIV+UfdN6l8+YrF40Kn2cFHQ8q2z1DCtD
	 4s8UKkireKEwxex+AFmUaSCEcEbwna400Hlm3HcUr961wosTKtozeUVLHX0k0hgrGv
	 uZ6aTNHBksLDsX3C5IogzhsQTh3Xs2kdeyhJHHOmpaOoKvXYIB9Gl3AZj7mXsDBz5o
	 DQa5n3qXqViIIUWS1gpYcwxv6BrOmAh9CH/wvwTdBtscnuQyIpNj7m+BsLgrITzmsN
	 ECGCu7Tq6B5AdbnecxOgF9vIU0YfCNvDhOsOnyyrN2tYALCRMaBr/OyvfiBufmCWxv
	 KNAz4FCcHKIKw==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 7861D2BDF2ED;
	Sun, 08 Nov 2026 10:35:30 +0000 (GMT)
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
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 17/25] spi: atcspi200: add optional interrupt support
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jun Chang <jun.chang@metanoia-comm.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Sebastian Reichel <sre@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Ben Zong-You Xie <ben717@andestech.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Jisheng Zhang <jszhang@kernel.org>, CL Wang <cl634@andestech.com>, 
 Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Adrian Hunter <adrian.hunter@intel.com>, 
 Minas Harutyunyan <hminas@synopsys.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Randolph_Sheng-Kai_Lin=28=E6=9E=97=E8=81=96=E5=87=B1=29?= <randolph@andestech.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-phy@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20261106-mt2824-v1-17-86087eaf5af4@bootlin.com>
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
 <20261106-mt2824-v1-17-86087eaf5af4@bootlin.com>
Date: Sun, 08 Nov 2026 10:35:28 +0000
Message-Id: <179413412862.3424803.13503591139483354665.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1694; i=broonie@kernel.org;
 h=from:subject:message-id; bh=nZ4p7qaMdUmUqeh0nBYdZQklXm66HLo9DRQs7Nyk6nw=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI+BBSp6d+beeDcy2WPH+13K7z/edOeA5c2WgYkFUt/2
 b5CKJGPq6OUhUGMi0FWTJElLov7ZX3J6zV8Bxe2wcxhZQIZwsDFKQATSVFgZPg3m+NHgS/D5yks
 Qh36OjbTa86LF9nmHJ6w4fPxPbf/ip8GqtBw2vv6YbL1paYdsqznI81qzuZ5rO73OWFmLW6uxv2
 KBwA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> For PIO transfers, the driver busy-polls the FIFO empty/full flags and
> the SPI active bit for completion. When the controller's interrupt is
> available, use it instead of polling to keep the FIFO serviced and to
> detect the end of transfer.

> +static irqreturn_t atcspi_irq(int irq, void *dev_id)
> +{

> +	if (st & ATCSPI_TX_FIFO_INT) {
> +		n = min(atcspi_tx_fifo_avail(spi, status), spi->tx_words);
> +		atcspi_fifo_write(spi, spi->tx_ptr, n);
> +		spi->tx_words -= n;
> +		spi->tx_ptr = (unsigned char *)spi->tx_ptr + n * num_byte;

You're casting away const here for some reason...

> +	regmap_read(spi->regmap, ATCSPI_CTRL, &ctrl);
> +	ctrl &= ~(CTRL_TX_THRES | CTRL_RX_THRES);
> +	ctrl |= FIELD_PREP(CTRL_TX_THRES, spi->txfifo_size / 2) |
> +	FIELD_PREP(CTRL_RX_THRES, spi->rxfifo_size / 2);

Weird indentation of the continuation.

> +	if (spi->tx_words) {
> +		unsigned int status, nb_words;
> +
> +		regmap_read(spi->regmap, ATCSPI_STATUS, &status);
> +		nb_words = min(atcspi_tx_fifo_avail(spi, status), spi->tx_words);
> +		atcspi_fifo_write(spi, spi->tx_ptr, nb_words);
> +		spi->tx_words -= nb_words;
> +		spi->tx_ptr = (unsigned char *)spi->tx_ptr + nb_words * num_byte;
> +	}
> +
> +	regmap_write(spi->regmap, ATCSPI_INTR_ST, ATCSPI_INTR_ALL);
> +	regmap_write(spi->regmap, ATCSPI_INTR_EN, en);

Do we need the TX interrupt if everything fit into the FIFO?

> +	regmap_write(spi->regmap, ATCSPI_INTR_EN, 0);
> +	regmap_write(spi->regmap, ATCSPI_INTR_ST, ATCSPI_INTR_ALL);

This just blindly clears all the interrupts, including the under/overrun
interrupts but we didn't handle them all.

-- 
Mark Brown <broonie@kernel.org>
