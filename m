Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025C3433A0;
	Mon, 17 Jun 2024 02:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718591777; cv=none; b=VrPpWRLJvWrF8az7naNOOKBHai5VALchGEY/7LusaPtSwtN9qk0yA9j2Ds8QZlIAkQFWTwDxf3/T3mf0MGO4h8FzZSwu3hdnUiFqyNeDTFExCcdV/NUwKxyhnOHkwkPp6wd3j2XYi9SIVarby+d6vW3u6yhb26tqcEdIfqIVJ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718591777; c=relaxed/simple;
	bh=avLxiTbr2hZOXLZqS+bzuinJ+DnSpN8T7kEP/BWMQFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyaDSGkgbSUsxiU8xOExKoz6Mr0ETC/b1667X7VVi2ohSbVPm78wy1qyiLZYfIOjnf8ybyEpIAsVHx2DmUuuSULawPxkFW/0EXtc+TMWJSmF9kZ0Mi9SOTgvbvuN7NUuqaivk8s63BiGE85dUMgIMUGpz4sydI2Z41471iQ8r3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=lKni1Uel; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="lKni1Uel"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=53RT71/gJhh3KSDTNrn1PfJkyyOiqhQIN18tBU+cdU0=;
	b=lKni1Uel2RCukDr4Zf7WbwCuH/BjaijZ5Yi62kOY4yCKMHpkUIH+bNb0ghb+Kw
	ROp6uCvehpOAQPCkueOQwGQHOM6r5SMaptLj6nSJgzoF9vxUc1rNXes87T9U/IAu
	ydhhusOszVa/JQSeAbyEAagT1lLI6YaqD1LKkObkE6frc=
Received: from dragon (unknown [114.216.76.201])
	by smtp1 (Coremail) with SMTP id ClUQrAD3_3bnoG9mgmAMCA--.4517S3;
	Mon, 17 Jun 2024 10:35:20 +0800 (CST)
Date: Mon, 17 Jun 2024 10:35:19 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v5 3/3] arm64: dts: layerscape: Change node name from
 'esdhc' to 'mmc'
Message-ID: <Zm+g5x6mCX0EY64j@dragon>
References: <20240613-ls_waring_esdhc-v5-0-36644e2fe21c@nxp.com>
 <20240613-ls_waring_esdhc-v5-3-36644e2fe21c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613-ls_waring_esdhc-v5-3-36644e2fe21c@nxp.com>
X-CM-TRANSID:ClUQrAD3_3bnoG9mgmAMCA--.4517S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr47Ar4kCw4DXr43Cw48WFg_yoW8Wr4xp3
	WUZr1UGrZ3KFyakasa9w1xCrnrKw4Sgrn09rnrWasFg3sxuFW0vF1rtana9w18Xw1rAw4x
	Ka45Jry8tryYqw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jfiSdUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDhABZVszYrukEQABs-

On Thu, Jun 13, 2024 at 10:32:07AM -0400, Frank Li wrote:
> Use common node name 'mmc' to fix DTB_CHECK warning.
> Add compatible string 'fsl,ls2080a-esdhc' for fsl-lx2160a.
> 
> arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb: esdhc@1560000: $nodename:0: 'esdhc@1560000' does not match '^mmc(@.*)?$'
> arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: esdhc@1560000: $nodename:0: 'esdhc@1560000' does not match '^mmc(@.*)?$'
> arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dtb: esdhc@1560000: $nodename:0: 'esdhc@1560000' does not match '^mmc(@.*)?$'
> arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'
> arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'
> arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: esdhc@2140000: compatible:0: 'fsl,esdhc' is not one of ['fsl,mpc8536-esdhc', 'fsl,mpc8378-esdhc', 'fsl,p2020-esdhc', 'fsl,p4080-esdhc', 'fsl,t1040-esdhc', 'fsl,t4240-esdhc', 'fsl,ls1012a-esdhc', 'fsl,ls1028a-esdhc', 'fsl,ls1088a-esdhc', 'fsl,ls1043a-esdhc', 'fsl,ls1046a-esdhc', 'fsl,ls2080a-esdhc']
>         from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
> arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!

