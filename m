Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB9B360EFB;
	Fri, 22 May 2026 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470490; cv=none; b=FRhX2Fej0jN6pWuqEA2MW25/z0GE8Gvf8su+iZFbVIpih/ghx/l4x3+F9bzlcfbppNUTkfN7jSn5PCP3tdfWYDT2njc7+JAZPAQroz3yf8QnlBmelM3H35xc6Gc0jRyWwDzheBCfVpBw8Q3yYXbUGKU8TsJBhttd8qFhccL2Wio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470490; c=relaxed/simple;
	bh=iAS4Ul5TqgTii8jRify/SVec0YlyOzLlrWKXaDzuNM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQ9VIzcubzp0FUYY6O9TL9EU6wHBMPYhX98m0xvbUJGICyyycw5ufSwwIs4BI9M4rBzOdu3lwbJziODPLLj373uQORm0psRnM9Uq5uIoCzZ4epqJe6OypEeeDvofEiJdjAFY0AA87UfMzpDXo+1kNkESrREBb8Y8DbARpn9EgW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=vh7PRy8P; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vh7PRy8P"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gMXBD2VH5z9v2j;
	Fri, 22 May 2026 19:21:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1779470484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e9xMgLOI1cS11QU37jU00P3mPm7u8NVNTN1EpkK6OCI=;
	b=vh7PRy8PKXI7TtWXkPQ6X4TnSBSGgF5ICMPn/MTOwcrmKahVesVTjlHTZUrheQmeC9qYqt
	/CxlWBG5gkYtE5b2CgsmUVbZjLuQlf5cDkYBP/9ri5jIdCCC6tgR3aUDaTbKomB8x9fFqR
	dH52ZD77CLTkfYERUUl17Uk+ece/QHHkZiZ1ex+bywqHaaxIToBzuksI7snw109o5uNubI
	MGSEahQiMFzrGveGQMQtN/LIEhrQmBMEDi9JfU7qWaDEuzSlMKvsTjqBpx2FJZMPG9KgqL
	aiHhcjq61F2MrfSrMx4hjmhptmYdyQFaoZ9XNbTy103WjHe9ql8m/Qx/UETuMw==
Message-ID: <cc9fea02-4b92-4542-9f97-64226179f2a3@mailbox.org>
Date: Fri, 22 May 2026 19:21:17 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 7/7] arm64: dts: renesas: r8a779md: Add support for
 R-Car M3Le R8A779MD Geist
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-arm-kernel@lists.infradead.org,
 Nguyen Tran <nguyen.tran.pz@bp.renesas.com>,
 Brian Masney <bmasney@redhat.com>, Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20260504144534.43745-1-marek.vasut+renesas@mailbox.org>
 <20260504144534.43745-8-marek.vasut+renesas@mailbox.org>
 <CAMuHMdWwantdbvPSFoYm=+_OoQQkKwz+K=qwWgy-7tSp1BNJBw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMuHMdWwantdbvPSFoYm=+_OoQQkKwz+K=qwWgy-7tSp1BNJBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: nsbpgrknzctogmk1dc6wqeswpo4mh6gp
X-MBO-RS-ID: 76a7294ae1c8eed5402

On 5/22/26 5:47 PM, Geert Uytterhoeven wrote:

Hello Geert,

>> +++ b/arch/arm64/boot/dts/renesas/r8a779md-geist.dts
> 
>> +&avb {
>> +       pinctrl-0 = <&avb_pins>;
>> +       pinctrl-names = "default";
>> +       phy-handle = <&phy0>;
>> +       tx-internal-delay-ps = <2000>;
>> +       status = "okay";
>> +
>> +       phy0: ethernet-phy@0 {
>> +               compatible = "ethernet-phy-id0022.1622";
>> +               rxc-skew-ps = <1500>;
>> +               reg = <0>;
>> +               interrupts-extended = <&gpio2 11 IRQ_TYPE_LEVEL_LOW>;
>> +               reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
>> +               reset-assert-us = <100>;
> 
> 10000?
> 
>> +               reset-deassert-us = <100>;
> 
> 300?
> 
>> +       };
>> +};
> 
>> +&pfc {
> 
>> +       pwm2_pins: pwm2 {
>> +               groups = "pwm2_a";
>> +               function = "pwm2";
>> +       };
> 
> Shall I drop this while applying?
> 
>> +&pwm2 {
>> +       pinctrl-0 = <&pwm2_pins>;
>> +       pinctrl-names = "default";
>> +
>> +       status = "okay";
>> +};
> 
> Shall I drop this while applying?
> 
> With the above fixed:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
I sent a V3 only of the 7/7 In-Reply-To this message, I hope it helps.

Thank you for the reviews !
