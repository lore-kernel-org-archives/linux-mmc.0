Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC3B7404F;
	Tue, 11 Jun 2024 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131705; cv=none; b=To/+3tGcrNi7dQkN8X/DW55PVW8A96PLOtztMrKRHPAL3rY2o0hI/yf9so1RHC6T5xk04XUproWaD/wdCtobyyNzOXrDUAJBq6oEzGFb511Neb9ASiwxqGlzY/qnxdLUwKEz3moDwiFu7fxh8Z4hVUHq1ngxkwUlv8N+z1hBhdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131705; c=relaxed/simple;
	bh=Icqk58bHNQpmqcH0SQq+ysoIzb40fVRvR1VlJKa7kBE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=FkkrCxCNEQseYASJBzoDc6Mx9QttfLLvT/QEQkDAn5zvjaWSKdL+QIr2XYs8XYFMdc+9EY3lbxusEGj8CapxjACf3QIrPSFdFUUygOpMaTdXO6laVxfeoyswtXdaZ0yvjRAo5/k+b4JiIQiSg2wBlcUiqKa2ojaScwH17mziM8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=dmPM0NPF; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="dmPM0NPF"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1718131699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hBtxcdOxJTOjlj2FBleR4Qh4QGHB6NSgACszEOvwy/I=;
	b=dmPM0NPFa+Pl1FLHihlW+/5Ay7uMd4qTXv3RqSCicUE3xta3wnPvuDzJZIeipr7W6xeTXP
	om3pKp4287ufJnbrlPLjpu2D/oe2MPTjYmx3R9i4WAanGMu3d2zrKoSPPBxUzNPR+a6+WI
	MBJ3qaMe595YKVTuOhGqrokM2mOYfKQZOQCrB/vxajtHjpz18GtMcoNIJ0v/B90JwRjMNG
	VmeUTLNbUxm9KhdxixH8oArxSmQGRXypm0+Gp6gj51ch8UbD24cCRdwBXx2w5IJwNr9bG9
	djVKzsb/kZYybEOEJ54lTBlW8WXVMUIrBvx+N50J6GGEDsd8Jd4Km+5bjF6kQQ==
Date: Tue, 11 Jun 2024 20:48:19 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev
Subject: Re: [PATCH v4 0/8] arm64: dts: convert fsl,esdhc.txt to yaml and fix
 layerscape dts warning
In-Reply-To: <20240611-ls_waring_esdhc-v4-0-d0d8a5b3f3cb@nxp.com>
References: <20240611-ls_waring_esdhc-v4-0-d0d8a5b3f3cb@nxp.com>
Message-ID: <ea54d6b7794fbbd81df7653b4e988915@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Frank,

Please see my comment below.

On 2024-06-11 18:01, Frank Li wrote:
> Start from v4 because fsl.esdhc.txt to yaml already sent out as v3.
> 
> Change from v3 to v4
> - Add dts warning fixes
> - Add mmc-spi-slot's voltage range fix, (not sure why it apply to
> layserscape's dts file.
> - clock-frequency is not required property
> - add dma-conherence: true in binding doc
> 
> Now only "bit-endian" proptery warning left.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Frank Li (8):
>       dt-bindings: mmc: Convert fsl-esdhc.txt to yaml
>       dt-bindings: mmc: mmc-spi-slot: Change voltage-ranges to 
> uint32-matrix
>       arm64: dts: ls1012a: Chang node name from 'esdhc' to 'mmc'
>       arm64: dts: ls1043a: Chang node name from 'esdhc' to 'mmc'
>       arm64: dts: ls1046a: Chang node name from 'esdhc' to 'mmc'
>       arm64: dts: ls1088a: Chang node name from 'esdhc' to 'mmc'
>       arm64: dts: ls208ax: Chang node name from 'esdhc' to 'mmc'
>       arm64: dts: lx2160a: Chang node name from 'esdhc' to 'mmc'

s/Chang /Change / -- in all patch subjects

>  .../devicetree/bindings/mmc/fsl,esdhc.yaml         | 105 
> +++++++++++++++++++++
>  .../devicetree/bindings/mmc/fsl-esdhc.txt          |  52 ----------
>  .../devicetree/bindings/mmc/mmc-spi-slot.yaml      |  17 ++--
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |   4 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |   2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |   2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     |   2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |   2 +-
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |   8 +-
>  9 files changed, 125 insertions(+), 69 deletions(-)
> ---
> base-commit: d35b2284e966c0bef3e2182a5c5ea02177dd32e4
> change-id: 20240610-ls_waring_esdhc-93136a5dd794
> 
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
