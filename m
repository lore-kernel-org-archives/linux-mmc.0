Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6F212E61;
	Tue, 11 Jun 2024 20:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136993; cv=none; b=n7nH/t4d60Eb7XaQz/PlzuYU2F6FAH+xWqKlU4NCsXjkGEsvHzX6SOuPBI9FxpC69cIQcI88RULL+RMsIksnopLwE0Nwl/o6fBVR/aY2B4x7xiZ2yCfP+g2h6iD47HDW6Vhgpxn6WM3iP2/JAmNswSFfcRq1BZh74dTicEVl3jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136993; c=relaxed/simple;
	bh=ypjaG6RRmQ019AQrSCd6Tnv5zFqudupklgD00PZTb0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTSF4ermusMn23Lt0V8Q2u0quQToSZY0zTVlp7FxVHIHYvHoz/gbzE1DxttVj49YwQVdv4LfUbGGuhV1Fm9QAF2VYGCvG7n+uM9sYH8KoLWz27D/ym+n51Op0YmBfsNuoYjoAe5QcL2XZgTlulAesqtCXoVhmOBGpCy3PcE5smM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfmV+4HT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfmV+4HT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE569C2BD10;
	Tue, 11 Jun 2024 20:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718136993;
	bh=ypjaG6RRmQ019AQrSCd6Tnv5zFqudupklgD00PZTb0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QfmV+4HTAuNi17zzOZZge2d9OmlcazjXGzXNMsh+/nlePzdP8VpoBL1cnX6bZM1RC
	 D5PHW76sSoUHMIQL/oBIBI9MJTKO6e34DKpHW22nJzBzdhpo1Ts/f4mmjcsVyNFr9P
	 Zkqfq561aJ56e2xqYyEho8w7Yk0iPpRTxhwUZmDhVqJ+UZ/i1Zf+wn/MOE33yGP3Ld
	 NxtzY0h8fps8+Rh4BuQAC4pP1DyzAbeK+P+XWqEvCwutXCn30xSsd8vIwqfdXtGedM
	 Ne6RQivU2UPhCD//IunnJUa+f+RIlxUnLY+7FRv8X6G7OcUvEfJd5x7fQDU9qMQ0Uw
	 RbG0kXapbLEdA==
Date: Tue, 11 Jun 2024 14:16:31 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 0/8] arm64: dts: convert fsl,esdhc.txt to yaml and fix
 layerscape dts warning
Message-ID: <20240611201631.GA3003237-robh@kernel.org>
References: <20240611-ls_waring_esdhc-v4-0-d0d8a5b3f3cb@nxp.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611-ls_waring_esdhc-v4-0-d0d8a5b3f3cb@nxp.com>

On Tue, Jun 11, 2024 at 12:01:45PM -0400, Frank Li wrote:
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
>       dt-bindings: mmc: mmc-spi-slot: Change voltage-ranges to uint32-matrix

>       arm64: dts: ls1012a: Chang node name from 'esdhc' to 'mmc'
>       arm64: dts: ls1043a: Chang node name from 'esdhc' to 'mmc'
>       arm64: dts: ls1046a: Chang node name from 'esdhc' to 'mmc'
>       arm64: dts: ls1088a: Chang node name from 'esdhc' to 'mmc'
>       arm64: dts: ls208ax: Chang node name from 'esdhc' to 'mmc'
>       arm64: dts: lx2160a: Chang node name from 'esdhc' to 'mmc'

It is all the same change to the same maintainer, so these can be just 
one patch. Then you just have 1 typo to fix.

Rob
