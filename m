Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A615155A4E;
	Wed, 18 Jun 2025 02:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750213969; cv=none; b=LY8hNeq2nSEWOFl+vU02+6A8Q3QerBoxMjBJxl2vAokv2ZqennEMMOCmu2Pw7GWOQziP6UcvhXTGljnmtTpN7j5xNTIL8MZJuI8UDScI0syVZ5CX/kAEOxC8TFUgWjYHZDv7qHBeb9NBplomRrLTO8hU+QWYB858XbM3jb9CQ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750213969; c=relaxed/simple;
	bh=AR29u6dqmK6ehegRcbbijgUNzEMQNsv2oGLo6lBr3lU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U2LHd4bB9u9nb2CUCU8Ip0bnjS/t6FKvN7x5TD+KiVtdmq//X+WbtMufwCZjfnfAM9Ynb2xmvCq/VFbgKdl25sxBsHae8NCOSMD14A7XgGBmTVto8igSCcAdJ241qYtdWwrbNR66wY0CtRgeL8XWqjVoiGkJErtoXotkUH2b6vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=c8yy43Lx; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="c8yy43Lx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750213966;
	bh=AR29u6dqmK6ehegRcbbijgUNzEMQNsv2oGLo6lBr3lU=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=c8yy43LxWxntWCAOlzFtJQAOwl4vSyG4RXS1nvNxQc2BzJW8ypHz9yJ/Q90//MlXV
	 Oma6DS17CsIYdYRhl7qtRMRRNMGkjbmYg9nghh3dwVcaQRzZfuxE02c1a5bZjdhAo3
	 Ly4x5rwRK9gQVoI+Z4+3xall0uLUpOT/BSZd5gP0dZJizBU8SYGXQ/1fxPTjpxg8ps
	 aP63LasTIY3Wz2orNMECmD7DHxpPJhxCYsqKSZyoTA/wP9rpX3VgIZyn+mkCuw9Cj2
	 AXoxBORWQHcrQ0M29SNwhxuMI3DwYyC1A5RRqoEODdIkV0n5ewfG0ESnqm4NN0a37C
	 i2LWYha0Dx0Fw==
Received: from [192.168.68.112] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 60A1D640A0;
	Wed, 18 Jun 2025 10:32:45 +0800 (AWST)
Message-ID: <100bed083e9a98432888c0b1db8cbc445f96cd64.camel@codeconstruct.com.au>
Subject: Re: [PATCH 3/8] mmc: sdhci-of-aspeed: Patch HOST_CONTROL2 register
 missing after top reset
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Cool Lee <cool_lee@aspeedtech.com>, adrian.hunter@intel.com, 
	ulf.hansson@linaro.org, joel@jms.id.au, p.zabel@pengutronix.de, 
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 18 Jun 2025 12:02:44 +0930
In-Reply-To: <20250615035803.3752235-4-cool_lee@aspeedtech.com>
References: <20250615035803.3752235-1-cool_lee@aspeedtech.com>
	 <20250615035803.3752235-4-cool_lee@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-06-15 at 11:57 +0800, Cool Lee wrote:
> HOST_CONTROL2 register will be cleared after top reset,
> it needs to be saved/resotred while reset.
>=20
> Signed-off-by: Cool Lee <cool_lee@aspeedtech.com>

Please squash this into the first patch.

Andrew

