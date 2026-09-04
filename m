Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9608D52E041;
	Fri,  4 Sep 2026 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553948; cv=none; b=OmDQZXAp5l+ZufsxAlxNdASxZb7/rzUdnEWvu63q79UstljKrP0Qt00EujHn2gsbuZZ6bflVsoVSpb2DiC4d7CvTpIzVvlbjFODlQgOZV8v3fqbVLiqel29oIds5CNqysXGq7kx0h2pfSkoLWor90YhD9vCARy/pD84ybiut8xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553948; c=relaxed/simple;
	bh=BiOxyZNflQ6jKLPZfSmDsv65jE+qkHmXoaUaxz6rFc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXk/ifuIpMeQgGmcUVvC49lOlA5744vaHohV8eB3rl9kuBJAJRIrD6TrC6TeISyhSoicjNu/VOsbLTFgjRhrjlcIrdHQ4ftF8ifvb9xO79kOMZEAMiBCpypUE7SaGdYuEhh6c/zqtR5mk9wm4BowopbRqGDp3DLr9tSHq6zq6DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNXVkHm2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNXVkHm2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F421F00ACF;
	Fri,  4 Sep 2026 20:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553941;
	bh=faGt6RM9nZNDLVI5nWQekSsP9/y8RIHlIgi2gEzyN+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BNXVkHm2rG8675ikzmcjNnHgunSqXRbTTuayweLcKMp8l7UE7v92MRw5pWImYbIz5
	 lGYTGnfotzQUypdlQyN7Yc51U7QJ5LLsGIhcBgkp965Qb2y8OUXTpQpulEcztklLIW
	 iPRAYMyLchGPR1us8b4z6VcIyOqcyTX1RzEGyPXuRdFVLIbj9IiciQUehrSMirVvWg
	 ZAOBV2jL5frRz9h01vDYBVEYypKroLjgNUFpuMV5o2Hyt6XBxXeYMqmsPnBelfmqDl
	 /cltB37YfZEdHn0FG0F6R30iQ3ZjfIG1mmYh9KAAA683HakS8XUxINeWODQGHQlCGx
	 XYTOO9LiVe8aQ==
Date: Fri, 4 Sep 2026 20:32:19 +0000
From: Yixun Lan <dlan@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Long Wan <long.wan@linux.spacemit.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: mmc: spacemit,sdhci: Add tx delay
 property
Message-ID: <20260904203219-GKC1974@kernel.org>
References: <20260902-07-k3-sdhci-dts-v1-0-4e7909cf4233@kernel.org>
 <20260902-07-k3-sdhci-dts-v1-2-4e7909cf4233@kernel.org>
 <20260903-tactful-scorpion-from-nibiru-a4ebe2@quoll>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260903-tactful-scorpion-from-nibiru-a4ebe2@quoll>

Hi Krzysztof,

On 15:00 Thu 03 Sep     , Krzysztof Kozlowski wrote:
> On Wed, Sep 02, 2026 at 07:03:13AM +0000, Yixun Lan wrote:
> > From: Long Wan <long.wan@linux.spacemit.com>
> > 
> > Introduce a vendor specific property to configure the step count of TX
> > delay line which should be applied before RX tuning, compensating for
> > board level trace differences. The TX delay line result comes from test
> > out of real board which vary from different hardware layout.
> > 
> > Signed-off-by: Long Wan <long.wan@linux.spacemit.com>
> > Signed-off-by: Yixun Lan <dlan@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
> > index f35bf7ce08dd..3399a2d076dc 100644
> > --- a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
> > @@ -63,6 +63,16 @@ properties:
> >    pinctrl-1:
> >      description: Optional pinctrl state for 1.8V UHS operation with "uhs" name
> >  
> > +  spacemit,tx-delay:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0
> > +    maximum: 255
> 
> default: 0, I guess?
> 
It's actually 127, I will fix it in next version

Also in my second thought, I will change the data type to uint8
then drop this additional minimum/maximum property, which will
 also simplify the code with device_property_read_u8() a bit

-- 
Yixun Lan (dlan)
