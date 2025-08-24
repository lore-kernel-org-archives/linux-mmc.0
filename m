Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3764317D;
	Sun, 24 Aug 2025 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756034057; cv=none; b=W67bOjZyK6KM25WO8dpTIQ0PBUyUqnbkCzpNyqAdxt3g/9bzoMj9xcXJ/M93la82tk2rGlcUEvUoM5T+ohycDFBtlUHIqzJTK1OBkvszxM+gecSklnxKjE/NG5WbodzCJUAspyWs1KkVrBITumDESZmb2vmEt03z0v50D1/zqhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756034057; c=relaxed/simple;
	bh=FerGia3PhqrqFYSjiLJULWoh3Jr9z/+AiMZOROAQOmY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Cc:Subject:
	 References:In-Reply-To; b=KP6oQd+1ZF/mAa1LfCFC/wM0bA7Wr43NYqpFBdIbwGwqgUQBHnrjWNH+Yr3tx+2rYr8ZKjZXmVIofW7/0hGoyGSehHdO7F6ph0c5iQxMmRJHSqwerNPBLozllFnmPmsVotwHjnrVvZnf/85tV3uYbnG+J9NyJZRePOGGJ/yB0u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=BIX6Ywur; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="BIX6Ywur"
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1756034023; x=1757334023;
	bh=ADa+fVNGO4WZmlPkY9EPlfFvm3fduD+G2BAy5zB2N7o=; h=From;
	b=BIX6Ywury7THcZTUYmmkJAPhdSkdCI4UXdME4S4FwGX213bfIVVUGxYziYzSB4Otd
	 aO7LNYITNTTfZc+bz5Gwt2lOk+o4BkyNAAHPccl0otCve2rbHcP4sCS0lFu+TXV+85
	 YSYIPBEU/wmSzQAXhb9Fu7kdkMdkhw4alxrSmbgn1JrEZIbgBIdaEg16EWXKt9/DUC
	 SyF0oFa9HIR8p2phDhHrQnxf/mfczW3shD7zzKiiFdmPjV56J+XCYNF9ZODDAK+sV4
	 siF/aep1v4S1dUr2OgxYgbswwnmpG9uRE2lQIpI7RktRhjAEVqzwF++EhoQDY+EjTl
	 HZp07okK8RPMQ==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 57OBDf7f084268
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 24 Aug 2025 13:13:43 +0200 (CEST)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 24 Aug 2025 13:13:41 +0200
Message-Id: <DCAM3WTJ4EXA.32GZBS4G7GWFJ@matfyz.cz>
To: <linux-mmc@vger.kernel.org>, <ulf.hansson@linaro.org>,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
        "Andrew Lunn"
 <andrew@lunn.ch>,
        "Gregory Clement" <gregory.clement@bootlin.com>,
        "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>,
        "Rob Herring"
 <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: "Karel Balej" <balejk@matfyz.cz>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>
Subject: Re: [PATCH mmc/next 3/3] arm64: dts: samsung,coreprimevelte: add
 SDIO
References: <20250824110039.28258-1-balejk@matfyz.cz>
 <20250824110039.28258-4-balejk@matfyz.cz>
In-Reply-To: <20250824110039.28258-4-balejk@matfyz.cz>

Karel Balej, 2025-08-24T12:53:45+02:00:
> +	sdh2_pins_0: sdh2-pins-0 {
> +		pinctrl-single,pins =3D <
> +			0x24 1
> +			0x28 1
> +			0x2c 1
> +			0x30 1
> +			0x34 1
> +			0x38 1
> +			0x3c 1
> +			0x40 1
> +		>;
> +		pinctrl-single,drive-strength =3D <0x1000 0x1800>;
> +		pinctrl-single,bias-pullup =3D <0 0xc000 0 0xc000>;
> +		pinctrl-single,bias-pulldown =3D <0 0xa000 0 0xa000>;
> +		pinctrl-single,input-schmitt =3D <0 0x30>;
> +		pinctrl-single,input-schmitt-enable =3D <0x40 0 0x40 0x40>;
> +		pinctrl-single,low-power-mode =3D <0 0x388>;
> +	};
> +
> +	sdh2_pins_1: sdh2-pins-1 {
> +		pinctrl-single,pins =3D <0x64 1>;
> +		pinctrl-single,drive-strength =3D <0x1000 0x1800>;
> +		pinctrl-single,bias-pullup =3D <0 0xc000 0 0xc000>;
> +		pinctrl-single,bias-pulldown =3D <0 0xa000 0 0xa000>;
> +		pinctrl-single,input-schmitt =3D <0 0x30>;
> +		pinctrl-single,input-schmitt-enable =3D <0x40 0 0x40 0x40>;
> +		pinctrl-single,low-power-mode =3D <0x208 0x388>;
> +	};
> +
> +	sdh2_pins_2: sdh2-pins-2 {
> +		pinctrl-single,pins =3D <0x5c 1>;
> +		pinctrl-single,bias-pullup =3D <0xc000 0xc000 0 0xc000>;
> +		pinctrl-single,bias-pulldown =3D <0x8000 0xa000 0x8000 0xa000>;
> +		pinctrl-single,low-power-mode =3D <0x288 0x388>;
> +	};
> +
> +	sdh2_fast_pins_0: sdh2-fast-pins-0 {
> +		pinctrl-single,pins =3D <
> +			0x24 1
> +			0x28 1
> +			0x2c 1
> +			0x30 1
> +			0x34 1
> +			0x38 1
> +			0x3c 1
> +			0x40 1
> +		>;
> +		pinctrl-single,drive-strength =3D <0x1800 0x1800>;
> +		pinctrl-single,bias-pullup =3D <0 0xc000 0 0xc000>;
> +		pinctrl-single,bias-pulldown =3D <0 0xa000 0 0xa000>;
> +		pinctrl-single,input-schmitt =3D <0 0x30>;
> +		pinctrl-single,input-schmitt-enable =3D <0x40 0 0x40 0x40>;
> +		pinctrl-single,low-power-mode =3D <0 0x388>;
> +	};
> +
> +	sdh2_fast_pins_1: sdh2-fast-pins-1 {
> +		pinctrl-single,pins =3D <0x64 1>;
> +		pinctrl-single,drive-strength =3D <0x1800 0x1800>;
> +		pinctrl-single,bias-pullup =3D <0 0xc000 0 0xc000>;
> +		pinctrl-single,bias-pulldown =3D <0 0xa000 0 0xa000>;
> +		pinctrl-single,input-schmitt =3D <0 0x30>;
> +		pinctrl-single,input-schmitt-enable =3D <0x40 0 0x40 0x40>;
> +		pinctrl-single,low-power-mode =3D <0x208 0x388>;
> +	};
> +
> +	sdh2_fast_pins_2: sdh2-fast-pins-2 {
> +		pinctrl-single,pins =3D <0x5c 1>;
> +		pinctrl-single,drive-strength =3D <0x1800 0x1800>;
> +		pinctrl-single,bias-pullup =3D <0xc000 0xc000 0 0xc000>;
> +		pinctrl-single,bias-pulldown =3D <0x8000 0xa000 0x8000 0xa000>;
> +		pinctrl-single,low-power-mode =3D <0x288 0x388>;
> +	};

Sorry, these got mixed in by accident and should be in a separate future
patch enabling the eMMC support. I will drop them from here when I send
the next version.

K. B.
