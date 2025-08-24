Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198CE1D63CD;
	Sun, 24 Aug 2025 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756053730; cv=none; b=lwzWKmDaSLoGWcWkuDaUFVF5W2ZQirzQ3V4HO3xc6W1O/11icZHbrWG8FA4Uwu3dvV3ONztyevOumkU1dK9dpnmX+XGMXgAtI31Z4vQN2A95T9OM6amhlIbxqhsLotElbqAyfq9bFMPoj8q2ypn1cLn5mHwn4ap3trHcKzg3zIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756053730; c=relaxed/simple;
	bh=g0dsBv+tZKoLLuVmXNG3YPHgvwDEQRIwt+zROqJGaUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p58KScBDRiuGJTEk5YNcCdLFhVQG3woUeV/tak+s0eqh4jvR4GmUJneya+nzRg6c8U/dDtxIEFh4YpLclmXx7ghkcdFVCan/m5X1AYBSy6rShZCt3N0BMZxVJnmg1JzkwYcvG/dk0x668rlhn+T1asuKqRMjpU387E7CI66hu1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=FqGZ5J1b; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="FqGZ5J1b"
DKIM-Signature: a=rsa-sha256; bh=ysizyDV1UE87HUIt7ZRiS1yeJatz3bjdvsDuraJC0sE=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1756053719; v=1; x=1756485719;
 b=FqGZ5J1b5tJ9wpjENynkSsp3flST81ymQP3gVZTq7KLZr1N3j5diukQb3EJ1AWNZ+Bd/fhOJ
 JONJKTOw6apCmTTTT0XAbCFzE1PwfFwDAsqmsaxaCxRGQShmlbc8YOt1ru4Sdn1i+xJk90FTmJB
 QvtC4s8Fn0HDHwjOkaINvRLUv8PT6Bap4jBdnxbTV24jFGJ8+mS9C3+rkolJ7Kjy7B7gEoDeHG6
 2xRQH5rcEB8GHMbQW295UhSpYMgOJtk178OlZvBbx9JfvTr2bKysn8soVW9IbUqDg/dQQc4iVAq
 UphxzeWON+RRwWb/UJNRtmBCwauQBJpjLHk3jVHUGe0oA==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 6acb09e9; Sun, 24 Aug 2025 18:41:59 +0200
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>
To: Karel Balej <balejk@matfyz.cz>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Karel Balej <balejk@matfyz.cz>
Subject: Re: [PATCH mmc/next 3/3] arm64: dts: samsung,coreprimevelte: add SDIO
Date: Sun, 24 Aug 2025 18:41:58 +0200
Message-ID: <13858228.uLZWGnKmhe@radijator>
In-Reply-To: <20250824110039.28258-4-balejk@matfyz.cz>
References:
 <20250824110039.28258-1-balejk@matfyz.cz>
 <20250824110039.28258-4-balejk@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Sunday, 24 August 2025 12:53:45 Central European Summer Time Karel Balej 
wrote:
> @@ -368,3 +505,12 @@ &sdh0 {
>  	vmmc-supply = <&ldo14>;
>  	vqmmc-supply = <&ldo6>;
>  };
> +
> +&sdh1 {
> +	pinctrl-names = "default", "state_uhs";
> +	pinctrl-0 = <&sdh1_pins_0 &sdh1_pins_1 &sdh1_pins_2>;
> +	pinctrl-1 = <&sdh1_fast_pins_0 &sdh1_fast_pins_1 &sdh1_pins_2>;
> +	bus-width = <4>;
> +	broken-cd;
> +	non-removable;

non-removable overrides broken-cd, drop the latter.

Regards,
--
Duje


