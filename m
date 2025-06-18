Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CC21A08A4;
	Wed, 18 Jun 2025 02:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750215115; cv=none; b=kdf3trs4anlnJxH0hX1Xr+u0KEPfXsGgkzxra6O/g2cZUH1tHc+pkKStXlxG9FIM+nc2bxqUff6sva5Mis9kq0T3XuEcy5W0Ls5cfQw9eycitdGAGXOsYLMCtuoc+MHI/tcKfXXt4fQfvnPEguvBFydN2SWfp21w0ozm5sW1x4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750215115; c=relaxed/simple;
	bh=D1AwwVl5J34oJoBmS9eZWUT+dg5sJUr6+s7pSO+AbC4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EkdoCb81zOWNaE68QyJ5Z77uC6if7zJBaEFwRcD7ZZtoROvlIxhlKt8OUmO0ywGZ27UwIpfE8qXxJhjPIHkEPIUAe8EKGrkMi2WSs9vDg8qn2x6CKEVwOVU1ff9lb7ArpNyfm6wvm+cA+8MTaOwMjBw2WAu7NgOKjkShmB0Fb+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=VHF/CZyz; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="VHF/CZyz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750215112;
	bh=D1AwwVl5J34oJoBmS9eZWUT+dg5sJUr6+s7pSO+AbC4=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=VHF/CZyzUlu1fWRJQyr6aBvgr+jSpBFyJ6XNTq/nNjBJSHXOnL9vcWJBoeuYLAsed
	 e8VqQeS8Y3yPl2+PHmPu5a58y3mtZ//ultIggqnNgLlp8x3HDLwbwPYKNpJbRnrdVL
	 oAo8rTJlt16aqFsXrqau31rwx9KDX9Lc/ji+0BkZB6Ak7ggCx6Q4CVVNOID99L38B3
	 Ud92uuywCuBgjB+zf5CVuCRaBZb0h0DK9+9KaTVQONynupPDFDJYDMay3oS21v9Cd5
	 3KFEMFLu+ktnLxwrtJpDaU9B1Zy91QEDqb6kNXrM/MImnxeeVdxQbjiQxl54I3ca64
	 fpRkdJlMCs0nQ==
Received: from [192.168.68.112] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 91D13640A0;
	Wed, 18 Jun 2025 10:51:51 +0800 (AWST)
Message-ID: <eaba29c18db8883f88e5e105f905a735a0087a3d.camel@codeconstruct.com.au>
Subject: Re: [PATCH 6/8] mmc: sdhci-of-aspeed: Add output timing phase tuning
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Cool Lee <cool_lee@aspeedtech.com>, adrian.hunter@intel.com, 
	ulf.hansson@linaro.org, joel@jms.id.au, p.zabel@pengutronix.de, 
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 18 Jun 2025 12:21:51 +0930
In-Reply-To: <20250615035803.3752235-7-cool_lee@aspeedtech.com>
References: <20250615035803.3752235-1-cool_lee@aspeedtech.com>
	 <20250615035803.3752235-7-cool_lee@aspeedtech.com>
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
> Enhance auto tuning with input and output calibration.
>=20

Might be best to squash this into the patch with input phase tuning?
Why split it?

Andrew

