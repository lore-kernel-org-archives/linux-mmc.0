Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5EB221F09;
	Tue,  3 Jun 2025 21:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748986113; cv=none; b=dU62y3MhApzz9qZNzSmALihK59IwYm096HLfHrkB4grDHfWitoGJzxPPe4KQirnmKr78XY0REl167tWKzbX8iywdfUjqhrLr4lnO0Jm+JUretbMV76WnpzrZMuipYR/aN1Ila0sqqD8LcOnpNm9V2YSZwHxCoL7p5ma/dYBNbW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748986113; c=relaxed/simple;
	bh=Gy9dNaig71hrcxBXbrHTFcnl1mHgKYw+Bxh3hUPJVb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oVmxZewHPvWxooa/o3OwzpdWnP9E3mg9WtWYjY5iFkgs7TIG9jPYHEofbqfLN+9Q2xWQ5BeG/5NFhG86uHKt8SPTPc+MvTWN1KnnJlrO7QVWP4UoYgPbAdJw4yt9wHgz3t61osjfEzWXLjC6J4v9oie/8EEeI6RK70yB28I3vNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=AP3SrC7y; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="AP3SrC7y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1748986096; x=1749590896; i=wahrenst@gmx.net;
	bh=Gy9dNaig71hrcxBXbrHTFcnl1mHgKYw+Bxh3hUPJVb4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AP3SrC7yoil0xp9VMDOry8/xRmaZJ1JbPWumFqw7RTVB/NkodljDcjYIo5asWiFQ
	 YQZ9ngnKErej2Kt9TOvP8To7n2fJzIib5umO5Uf69pmlqtAEmgqZmCwzXTk5oaq/z
	 nKu8UgHPQqcH3vgHUWeV7IxXh4VEpm43jqfxJxhro7wuJbMxarHoC1riTIRXMSXDI
	 TFfSNcjNC1VZ3dQJ3h+FFu9EkvRYLrrP80UIcjGykES0RYK4+6S/tJd5Z6RxgQEob
	 NA7r6j8U6MahtbJcmg/qIe74eCSUeVXvFQJya8JyP8hLxoVo6Xebtvx0hDYZlXi+k
	 mOGcNJabNBhAPuEWRQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.103] ([91.41.216.208]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHXBp-1u94lt27o9-0075NH; Tue, 03
 Jun 2025 23:28:16 +0200
Message-ID: <9483df46-0c1d-4646-9ba1-c38014a22495@gmx.net>
Date: Tue, 3 Jun 2025 23:28:15 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] dt-bindings: mmc: mxs-mmc: change ref to
 mmc-controller-common.yaml from mmc-controller.yaml
To: Frank Li <Frank.Li@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..."
 <linux-mmc@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250603152245.1068740-1-Frank.Li@nxp.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20250603152245.1068740-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9mJJ9KzYyiEND0uwEQ3VH0FpznhMWOfzChMkl4h0E9E6tUmuony
 c+SkdZQP/qOrV16VBQfeHB6kV8gE58rboMRp2PHw68Nxo4dRH7js6jt45IsLrBQzl9ZBR8R
 kfpJZ8FdMqNjCBWGGjnqkqF7Ka09QWEYiGz610GUKXXd/NG4tg8MIIevbxjZqayjspr8809
 QlwzTyFA1u7Hs4pYfXYLw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wIwnshtLzdM=;E1dtyHGZzuFNMgvAxBEgUe5Ciqt
 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
 z3wajrF2lunfBwSK

Am 03.06.25 um 17:22 schrieb Frank Li:
> Change ref to mmc-controller-common.yaml from mmc-controller.yaml because
> imx23/imx28 use dual mode controller (spi and mmc). So default dts node
> name use spi instead of mmc. The legacy reason, it use difference
> compatible string to distringuish work mode (spi / mmc).
>
> Fix below CHECK_DTB warnings:
> arch/arm/boot/dts/nxp/mxs/imx23-olinuxino.dtb: spi@80010000 (fsl,imx23-mmc): $nodename:0: 'spi@80010000' does not match '^mmc(@.*)?$'
>
> Additional add clocks property.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
