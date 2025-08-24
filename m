Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816CF28F4;
	Sun, 24 Aug 2025 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756053126; cv=none; b=Kj6jRt1Z2+NruuUz3YCVginQvp5gjrH3BPOqBv5D/UeY7blRxwHRwDpCh1tFRUuavpB83Cv+e1M6Po+jdru162ynbQHl+X8ySnzpNePkS3bt6djnKVtvRFzj68LAON43Prq9CluUBgWEHbk2XT2rpiZvoBHUIxQvQXPJQd6O2ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756053126; c=relaxed/simple;
	bh=G2OHILXUuHJu2eH22mnptPrLtTmml/fktiLPE1KzmDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJwvkUNijSn0cwkyO93svrkDQUMjVqOXFIzBFvHKO1XDkguNZKgevIKP6BtGPHnaE4zPcvcxWYtaqCnBAc+0jzUB2Du7L4TpK1+6BtEZkCf18Fh/I+JOWR+IANCsERKsxQTHI7Y2C/TjkQhmiXolYGbxjtzs8UDSXLh4wKof7G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=ORwhDOb+; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="ORwhDOb+"
DKIM-Signature: a=rsa-sha256; bh=KBMwXOKWo3H5shr3lU27LMOukqdPgtvWMNq4qyPQjsk=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1756053033; v=1; x=1756485033;
 b=ORwhDOb+RWlGUXOku+owQSOhL6+X82KxUA7Z8ZFg5fhCgmduoWGxsKTcBmv3lOTUn3v7b4cz
 nbH3hcwLCQietNt4EG2Aj3ekxB1uaV+mBb4/A8ZlvM54c4cXvpwBYRz9+XbrdxwtSxu7sFDhyWI
 eABzqalZo5qYsnrIAwDxIJzcXrK9a/v0GBCYHk2wkDqWU1kA4Dgrsqz64gM4BGV4lnWO+eZE3Dk
 9o9PpBa2l7u74pRLS4ENbH/z1gwWdmt35IKaNKtCks6/t52GoNykON5cINHmTFH18r+4fqVqvDK
 qojvQVU7GVehloturu99MMSlwA+3/5UWl5Yuxrrt1VwUA==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 3921b3f8; Sun, 24 Aug 2025 18:30:33 +0200
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>
To: Karel Balej <balejk@matfyz.cz>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH mmc/next 1/3] arm64: dts: samsung,coreprimevelte: add PMIC
Date: Sun, 24 Aug 2025 18:30:32 +0200
Message-ID: <4701387.LvFx2qVVIh@radijator>
In-Reply-To: <20250824110039.28258-2-balejk@matfyz.cz>
References:
 <20250824110039.28258-1-balejk@matfyz.cz>
 <20250824110039.28258-2-balejk@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Sunday, 24 August 2025 12:53:43 Central European Summer Time Karel Balej 
wrote:
>  &twsi2 {
>  	status = "okay";
> +
> +	pmic@30 {
> +		compatible = "marvell,88pm886-a1";
> +		reg = <0x30>;
> +		interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;

Use GIC_SPI instead of 0 here.

> +		interrupt-parent = <&gic>;

Drop, root node already uses the GIC as the interrupt parent.

Regards,
--
Duje


