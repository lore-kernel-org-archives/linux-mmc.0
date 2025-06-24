Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683AC26B0B6;
	Tue, 24 Jun 2025 23:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807909; cv=none; b=lmrvMuKEKLhDcCLKEyJJJNwn4vPgYs+b3xpCvYIL6puiXQjIqD8Xg2sT6QxF88jvDliic5u2+EHpgncIUrTtg342lVCQAZeGJ6CFuXfAAS2/typCxKQnYRVfgh6jpURr+ICFn3toeUocLLoygjMSOGjrNWd8iSK369jr/xZDQIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807909; c=relaxed/simple;
	bh=wAMDHm88X5DnFfTxjTMlZawEVZqAwKU/UMzX5RRrhEw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qQ5phYTIopve9Q6Md5JE7xgYS6nOjy/DIOdeuVwrmKXy3bF7CCFugbzOWNI454WBrb03LRrZvOiPTI8TWH+nK1Ffxok4UoImdRT6Zk/8GHqTGi8yFIe1BjUQR2zWB6TlH/PFtd5HW7ewYj/q94/spjW5252Otk8Uk5lQu0OehE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Y6jvrWrI; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Y6jvrWrI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750807905;
	bh=wAMDHm88X5DnFfTxjTMlZawEVZqAwKU/UMzX5RRrhEw=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=Y6jvrWrI5GNZ8lXWo//Q5UUJUo0iIL68eNHWVPCv70YpSP9TgqLYIqrhLciejhrJ4
	 sr7IxwJDOYd14/Uvs+JF68Am0yAqaZfy2MqMB36oE1tNHNGmRA/3XoCLPqnM9Mif3O
	 g8GYNQ1O7JgeKupftTkehLa/o0vmjTAUa30cVSD827oJ3ezXewbD59Go4c7BycZDW2
	 PENUZQ9mEIVg1qqezl7FA93VIgUQ3gB2899NYCNjre75vK6P1yByCpAtVcCnrYYxJ3
	 8FsitDufw47hob7JSjlkvJUg23ARqKE8K3Qw44qXdJM7JAk283yaT8sihzjwLfCXyn
	 54yrE/oJjuR8A==
Received: from [192.168.68.112] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 2B1F7640CD;
	Wed, 25 Jun 2025 07:31:43 +0800 (AWST)
Message-ID: <c41c3dfc38c1adc5d544e365de355579d42f90b5.camel@codeconstruct.com.au>
Subject: Re: [PATCH 7/8] mmc: sdhci-of-aspeed: Remove timing phase
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Cool Lee <cool_lee@aspeedtech.com>, "adrian.hunter@intel.com"
 <adrian.hunter@intel.com>, "ulf.hansson@linaro.org"
 <ulf.hansson@linaro.org>,  "joel@jms.id.au" <joel@jms.id.au>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, 
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, BMC-SW <BMC-SW@aspeedtech.com>
Date: Wed, 25 Jun 2025 09:01:42 +0930
In-Reply-To: <SEYPR06MB7072FC07B4EFC03BB25B537F957CA@SEYPR06MB7072.apcprd06.prod.outlook.com>
References: <20250615035803.3752235-1-cool_lee@aspeedtech.com>
	 <20250615035803.3752235-8-cool_lee@aspeedtech.com>
	 <9c85755a8aff6e6f8a5548f0b5e758dce7d6353e.camel@codeconstruct.com.au>
	 <SEYPR06MB7072FC07B4EFC03BB25B537F957CA@SEYPR06MB7072.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-06-20 at 10:23 +0000, Cool Lee wrote:
>=20
> > > The timing phase is no more needed since the auto tuning is
> > > applied.
> > >=20
> >=20
> > I feel this is unwise: we're now ignoring constraints set in the
> > devicetree.
> > Auto-tuning is fine, but I think that should be a feature that new
> > platforms can
> > exploit by default. Older platforms that do specify the phase
> > values via the
> > devicetree can be converted at the leisure of their maintainers (by
> > removing
> > the phase properties).
> >=20
> > Support needs to remain in the driver until there are no (aspeed-
> > based)
> > devicetrees specifying the phases.
> The timing phase only works on AST2600 or newer platform which has
> added a delay cell in the RTL.
> The older platform AST2500, AST2400 doesn't support the timing phase.
> It supposed no effect on older platform.=20
> The old manner that a static timing value customized from devicetree
> is inconvenient because customer needs to check waveform associated
> with each delay taps. Once the emmc parts changed, a fixed timing
> value may not work. That's why auto tune here instead of a static
> value.

Sure, I understand that auto-tuning is more convenient, but in my view,
there's no reason to remove support for static phase values for now. On
the contrary, switching entirely to auto-tuning risks regressions for
existing platforms that do specify static values.

Can you please drop the patch for now? We can revisit removing static
value support in the future.

Andrew
