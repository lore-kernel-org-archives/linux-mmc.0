Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A25246BB6
	for <linux-mmc@vger.kernel.org>; Mon, 23 Jun 2025 11:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679621; cv=none; b=HLjmSWQh8vgzATW/odkQsvI59pELrGei4VWZSawZZXMNxR8Xs/VhPCF1j6TuW4WjLKiyyG/wjuFWPkRr5JZ2taqBSaii6e/gSYe9rCJrdpncPSWMBCuGPQGL+wGNKGNM2uJCIuPyKjNwEYeLxPMRJkjh9sLWu6R3fqA8OZ7NKPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679621; c=relaxed/simple;
	bh=RDI8cBCzVZwn53XlfucxBuC50lClvnDZ28m1ys46gaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChanYfT1ic4zu+tt3IA8VUS83axYopBnZ/EGPlMfqEHe5YlLOdPlCvf+oEjpx4OXr1J915Y/1d3vFMQC5qvtwghC2ThyguxnAt6M/A9r+y+qUfHHi6ZApUDmNBDmLdzb6KgieEqBxjdxS+h0qskOUgSmOMWQl2lIvDoswB13fYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TqhPuCML; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TqhPuCML"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e84207a8aa3so2415461276.3
        for <linux-mmc@vger.kernel.org>; Mon, 23 Jun 2025 04:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750679618; x=1751284418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZaYyZl4DS0u6LRC5+ULPLhB5YslLRXaRQhUnx/sEOs=;
        b=TqhPuCMLGlWs9C41COiwUMSqTwb3R2dlCdU0LAKvismv63CX3NNoQXbHuTzwFf2iXH
         PS8MG6PsQ136QbW9NCtK2J077lA00SM0odAxMVV3HboA73SA9hlN/bN5l/5rblPmjF63
         4m1wUKXPjMMe2AZGM+GIiCW1Nu/ekW/QdYQekypghsm2UcZ6v20XD+/PO9d+KaMC+Z38
         5TyqH8BatqlR/N5YIYBR8l2vK4eCHJLyHjLUuX2GLKBzH2V/f4Aoj8L8PwN3TeUjt2Cd
         9qt4VEliSHBmV5vEdjls6JiHeg79+stsAvwr1LGntoJoZmycvM7H4SSvpf7WRrxwkMsS
         tZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750679618; x=1751284418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZaYyZl4DS0u6LRC5+ULPLhB5YslLRXaRQhUnx/sEOs=;
        b=DeHi3upUzs7voDTEXvsFIGi5e1ai5QEwxKHYc2tTq8eYXOIjeL7TiYkGpWWyFvbb5W
         zNDsRzHEjqeUXnbxXy5u37+JDkWGdFygkt2JYdQ7XfE1gUbFlUI6Agn0khrMIQD9+6ZF
         AMOIeUYwCz9W/YqFec3bZSBf0O3EmOhxxaWw1i1uIBmp7G2070Qr59Gi4EbCJc2nXRQ2
         zdU5ws70s9isNdUMLdTYIjXEhNJOCdPAugMJwS24/6Viv4GIQvGsyiofC2pLhAxJ0WWv
         gb/CE0SOrfqyLSuZtBELV/UuPUPrfq+e50ufYpoN5DlpRwcWet/9yHUwRpvBElAr2nUX
         n9qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWowGGLxBmkw8UW7njGRH/LrE6HO6uG42XDB8AOpXuMrIkRYu5eblmlBV7aOJh7H7q7rD1fBexVp1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeJdNVPj5KYqGhGyiBqm9632n2YZ+jq9x5X6EKHWGKJv40mXRC
	G/anEU+82odwFpGabfH61bwWRNk2cRzXvq5MT8ujIb/ThHyFEJDNSf8cxxBnq3Fg+ejIgcp6QOJ
	QIWAzKXFxXBIunr2RmI4901y8FtyDduIO7fx/Goi/Gw==
X-Gm-Gg: ASbGncvSJDa5WVQkbJLPUvtW6mvDXLZ47v2hLJWLEk3vg6T2SeDvHTGmQGl/p5r0I7+
	p19t0QQKj6RWPibLfCLV9yJBEKWXe/tdop+uUqk815+ey84+AjBwy+oX5/4Ci1AchLNkbSqjHOm
	SPIZxpLpDAKYKJGM/gzVS2zJJZj5mUZvbLSB44CSek9pjx
X-Google-Smtp-Source: AGHT+IE8T8YQqjuX2RPIqOvp84NFBEnBd2nf0HMGfblzPzNNFCpE1rQMJhmR6YAjwyaBmt1T2phZME3iCUpiJakAinM=
X-Received: by 2002:a05:6902:230d:b0:e81:78f7:5532 with SMTP id
 3f1490d57ef6-e842bd1787emr15542569276.46.1750679618337; Mon, 23 Jun 2025
 04:53:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750156323.git.benoit.monin@bootlin.com>
In-Reply-To: <cover.1750156323.git.benoit.monin@bootlin.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Jun 2025 13:53:02 +0200
X-Gm-Features: AX0GCFvg50-pG60deTth1xrFtJ6E3jTjfDgX9C52hAY0wmcdIa--eh2NYl1Ihyo
Message-ID: <CAPDyKFqy54LpU2HxKX75HUKNcis06C5aMC8NUOW37ws0QiTOdg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add MMC support for Mobileye EyeQ5 and EyeQ6 SoCs
To: =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Gregory CLEMENT <gregory.clement@bootlin.com>, =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Adrian Hunter <adrian.hunter@intel.com>, 
	Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Jun 2025 at 15:26, Beno=C3=AEt Monin <benoit.monin@bootlin.com> =
wrote:
>
> The MMC/SDHCI controller found in Mobileye EyeQ5 and EyeQ6 SoCs is
> based on Cadence cdns sd4hc IP. It supports up to HS400HS mode. The
> only peculiarity of the hardware is that it needs the preset value
> quirk to configure the clock properly at speed slower than HS200.
>
> This patchset adds a compatible device tree binding to cdns sdhci for
> mobileye then uses it in the sdhci-cadence driver.
>
> It also adds an emmc entry in the dtsi of each SoC and the config
> options in each defconfig to allow using an eMMC for the rootfs.
>
> Beno=C3=AEt Monin (6):
>   dt-bindings: mmc: cdns: add Mobileye EyeQ MMC/SDHCI controller
>   mmc: sdhci-cadence: add Mobileye eyeQ support
>   MIPS: mobileye: dts: eyeq6h: add the emmc controller
>   MIPS: eyeq6_defconfig: add cadence MMC/SDHCI driver
>   MIPS: mobileye: dts: eyeq5: add the emmc controller
>   MIPS: eyeq5_defconfig: add cadence MMC/SDHCI driver
>
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml   |  1 +
>  arch/mips/boot/dts/mobileye/eyeq5.dtsi        | 22 +++++++++++++++++++
>  arch/mips/boot/dts/mobileye/eyeq6h.dtsi       | 22 +++++++++++++++++++
>  arch/mips/configs/eyeq5_defconfig             |  2 ++
>  arch/mips/configs/eyeq6_defconfig             |  2 ++
>  drivers/mmc/host/sdhci-cadence.c              | 11 ++++++++++
>  6 files changed, 60 insertions(+)
>

Patch1 and patch2 applied for next, thanks!

Kind regards
Uffe
