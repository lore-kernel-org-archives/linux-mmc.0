Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FAA3998A4;
	Tue, 23 Jun 2026 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246415; cv=none; b=fDCunhbSCUj1NpmFagp6EFmjOAVRnscpMgAMVyanPRI7oHUzp8Y5qZSS18R93kZkToV3g/76sQYvQSNLhGMl+/f4sWyPqqWjXUnnS5Jyx5OqJaS1KVE9DCaGVGKMv7SacEA0WglTDQRIMHgAfsVqnaQUEV+zvS9USoPWyK00b8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246415; c=relaxed/simple;
	bh=/SK4QNgdunGn1N8wdLrCElrEdfOZM2pD0csWQG2dai4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3C+fEzMjsQRCM/styMg0LGPr/aoC9P5PcVSj4m0MiTekMWfTFaXXs6McCMGBl7t/DCtFS8yIvhy5AMZsfcXJQn44RezZCaTOkBXTN1AoxJP4CWAr3ad6pOKEoBONAdNaB14k6kMSw4AQvKjjRPTzpJ1XLkhIjY1PPNmRHpgdZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdV3vIl1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdV3vIl1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEB11F000E9;
	Tue, 23 Jun 2026 20:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782246413;
	bh=ie03j2TujfKNZ9SmiUM47+g20ngBeN5app0Z2aJgO5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SdV3vIl1abrSY17gzTT9hztTEbhwquYA6Vs7OUZpc94JI6ISBgsnmR1vFRzYAbNF7
	 9Tr2FIHpVBlYa6NElHKrnxsvp4Pi62ZRiu6ZcNK/Ddnb9d+0N55yg70A7Sc3OAmmuo
	 gGH+W4Rk+ut9YdHxepJ2JBs3Fgot++hdLbyAB+Ue1wEYl/JBrUyiS4KBsgbj99LLj1
	 JuKTNkbso/iyDMuwzRNmR+ilwZL9W66z6iWVP0IYIXe4oSGIeh+mhOSbn0eoQ0BsNF
	 pWx8lZpIIBAwvItYGkl8IE2xb8GXHH9TV3F1Zon8KTDKEA9NP2ugzAVfCv6XE10pKo
	 tuRPBdR9JzcXw==
Date: Tue, 23 Jun 2026 22:26:50 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-sound@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: Drop incorrect usage of double '::'
Message-ID: <ajrr5pWNSmx4K-Dc@zenone.zhora.eu>
References: <20260623054842.21831-3-krzysztof.kozlowski@oss.qualcomm.com>
 <20260623054842.21831-4-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260623054842.21831-4-krzysztof.kozlowski@oss.qualcomm.com>

Hi Krzysztof,

On Tue, Jun 23, 2026 at 07:48:44AM +0200, Krzysztof Kozlowski wrote:
> There is no use of double colon '::' in YAML. OTOH, the literal style
> block, e.g. using '|' treats all characters as content [1] therefore
> single use of ':' in descriptions is perfectly fine, whenever '|' is
> used.
> 
> Cleanup existing code, so the confusing style won't be re-used in new
> contributions.
> 
> Link: https://yaml.org/spec/1.2.2/#literal-style [1]
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Alim Akhtar <alim.akhtar@samsung.com>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Acked-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Acked-by: Mark Brown <broonie@kernel.org>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be> # renesas
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Acked-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
