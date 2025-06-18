Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD84A199E9D;
	Wed, 18 Jun 2025 03:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750215984; cv=none; b=khxAff6dYt84XSL6D+J/xV+NAwiEwmfsqXI8QpQ2oXHtpjmTB7K/alHYNC88lXYkkIswxc1SJOK7fX41J2Jdivb+wtCg6sThOWmnr+qT1GlbaXhbMyuofKcXoSTEkEnqT3v5YVC+bphNfdvFnGb6/YaY0CatOPLSuMxsVVZtohA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750215984; c=relaxed/simple;
	bh=qN9NPv1XQrsC3dwPyHVqoYgRHQm03qU19l77O6/+NkY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T6F3Cgo/3bKwy111jk5uYUrLE8AcQ3e/E+8Rxku1XvNH1ffN7uQ6FBXUVzdMc1vxDrvvk9EgFVp6E+8+MZbPHDUROqDncxZutWOKLLLE/rEk+nsEzSsr6zW6hhY6JDfQRb2F2pt1D7r9ZZKOH2N+/8yclFOfvUAnpSKS2YQU71U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=LTxBQNyB; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="LTxBQNyB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750215980;
	bh=qN9NPv1XQrsC3dwPyHVqoYgRHQm03qU19l77O6/+NkY=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=LTxBQNyBuJBxJiNhQgy5vLgg2Q1cilu5sqxx4AN8cNHwXn3HgrmJ49pIjCSxchnhf
	 k+FNxzchFLCwwXtnx1qCPCG1f7j2s3vs3CZN21KTO+p/EaEXiSUeIjL8bM/PbWThMX
	 fq2fBARicrss4AGOgQ/ZU368YBmgxKZkpjza4B2yywBn+g4IwGNksuuUUfVXxbqQ7e
	 5LpdYkclvvubJ3u0UFwr+Rv+4D2o+67rXcweW/LXnMiQ/f4eF4kRCHw8xTgZ7ZcJqJ
	 M8vbxOhLi9T5AgbG4Jr+Gp33Ow0BZ+P+BitiamvWb4iimO95tuBYdl4DJYo5oBqU01
	 loocYLcuF8ttQ==
Received: from [192.168.68.112] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E875E640A0;
	Wed, 18 Jun 2025 11:06:19 +0800 (AWST)
Message-ID: <064a5583e43ee0b67da1112fb5fc9fa421e4f96e.camel@codeconstruct.com.au>
Subject: Re: [PATCH 8/8] mmc: sdhci-of-aspeed: Add sdr50 support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Cool Lee <cool_lee@aspeedtech.com>, adrian.hunter@intel.com, 
	ulf.hansson@linaro.org, joel@jms.id.au, p.zabel@pengutronix.de, 
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 18 Jun 2025 12:36:19 +0930
In-Reply-To: <20250615035803.3752235-9-cool_lee@aspeedtech.com>
References: <20250615035803.3752235-1-cool_lee@aspeedtech.com>
	 <20250615035803.3752235-9-cool_lee@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-06-15 at 11:58 +0800, Cool Lee wrote:
> Add support for SDR50 mode in the Aspeed SDHCI driver by setting
> capability shadow register.
>=20
> Signed-off-by: Cool Lee <cool_lee@aspeedtech.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
