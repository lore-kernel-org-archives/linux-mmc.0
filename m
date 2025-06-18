Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151B7A94F;
	Wed, 18 Jun 2025 02:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750215410; cv=none; b=IIO7yVpHXu19rmLkHjpn25ELt6rApXb2TJ/iQYRVSmuUiyqdmg+Hk2Gx1rHVRJbijJmpXGl5IWjevVfsvomPvZroez3JQ2SeMx4h9LzPBVcKoaSpM85v/nUR8G4QZ+bX6r877zEMpOs1l2YFsbsy6yTTiWMwBkCHK1Cra7w9XE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750215410; c=relaxed/simple;
	bh=4pKigNPmZrFFJC/kPV5i7vSCvjFvbcP0l1T50tmE0zw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aAhcluBC3YBr8kem2AOFe5QL4qJNOGaYmrYv5aZOLDwmeX4FBpUiz/m2Y1LVN1KF6FpBrtnsYlkVu5sKrZnMidqE5gxNyuzHjCNVz1pMmtjbZbSC+3kz5ZR5IqNtbfSEBgeEGspH67vKyTfiGjhA+/mN+EkqZnWJ6taH+Oy/c4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=MDag//uu; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="MDag//uu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750215406;
	bh=4pKigNPmZrFFJC/kPV5i7vSCvjFvbcP0l1T50tmE0zw=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=MDag//uujeHgEIW8EjiXtf2BXnS05nbJYgYjInjggZnP4NvHya2YAyfHshB529YMQ
	 GnNytvTl57xg/M0pZLHsAFClcKzo7i+WhMqY3yMN9f0NZrbiuRbMDiIXM64j3IzRwl
	 Fdg0SmXvmffbLAcTMcTRioMOEPx3PsFnEdVD+5k451s5ztDWyPHnPQOhoNRqHcrZHN
	 5YnvQuCAm9Eg9F4DfzrXtz5UER3pRbxAV5OtksZcvATKXB7fBZK7lEQ6NGL04Zite4
	 kl0xJKcUnFVaQCJghNvtu7EdT9Y68qT/rwbkz5GRqi5zIdSyYWayaLrsHiu/kJYKHp
	 20ch+tM1+XPig==
Received: from [192.168.68.112] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 404B5640A0;
	Wed, 18 Jun 2025 10:56:46 +0800 (AWST)
Message-ID: <9c85755a8aff6e6f8a5548f0b5e758dce7d6353e.camel@codeconstruct.com.au>
Subject: Re: [PATCH 7/8] mmc: sdhci-of-aspeed: Remove timing phase
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Cool Lee <cool_lee@aspeedtech.com>, adrian.hunter@intel.com, 
	ulf.hansson@linaro.org, joel@jms.id.au, p.zabel@pengutronix.de, 
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 18 Jun 2025 12:26:45 +0930
In-Reply-To: <20250615035803.3752235-8-cool_lee@aspeedtech.com>
References: <20250615035803.3752235-1-cool_lee@aspeedtech.com>
	 <20250615035803.3752235-8-cool_lee@aspeedtech.com>
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
> The timing phase is no more needed since the auto tuning is applied.
>=20

I feel this is unwise: we're now ignoring constraints set in the
devicetree. Auto-tuning is fine, but I think that should be a feature
that new platforms can exploit by default. Older platforms that do
specify the phase values via the devicetree can be converted at the
leisure of their maintainers (by removing the phase properties).

Support needs to remain in the driver until there are no (aspeed-based)
devicetrees specifying the phases.

Andrew
