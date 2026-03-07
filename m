Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BC82066DE;
	Sat,  7 Mar 2026 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772881121; cv=none; b=XWSWwCMbLn7O5UFTl1YuOCJ8mb+FaAB91Qb+WQBw9ACm8ZHjONFzRT0gr9x28L/Mqc1Qetkrn71qXFv/Gbali46UlMsKP8s6TYbp8bQqUSsJ6kBGuZhP5ndNsVe5cFzE4NbHuY7DE2Gbz5ONqZzWN22Ps74wuj+RtbsE3ukQJOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772881121; c=relaxed/simple;
	bh=Ionuc70jSLfmmprV1aKJDSZDnPZ8MojStxxeRXicepU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtlTPi3n5PpDyD0a+NAIcX+5g3xBA+bxnTpZ/9gnB/19yHXlCjr5gV+AdWaRMAnvHXw1ey894+P2JIrn1CfWhAC8uqsZ6kb6gBOscp55EGngPYA2qoFKYEMYsbh5smiB8u55iGEriP0wfEuCBPeVNVcBmmOUZstEUyEdnRzL3RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEtEiiKp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEtEiiKp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D1EC19425;
	Sat,  7 Mar 2026 10:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772881120;
	bh=Ionuc70jSLfmmprV1aKJDSZDnPZ8MojStxxeRXicepU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dEtEiiKpAEb+n96mbEzQTIiREcREP+9eTE0PJRTbtZ2MiUPTEuJWT9is67QzMC/Se
	 pobTAeI3jvSQ9zwppaiEEujN2WC0sMxtEDbDlo1ReLnZuF3bkz0Gi3q+cQyCHDTmBC
	 lDY4MWZv6Ghwl3zUqxeQQskJRsakr4Xqq8ctanRTVBcEzKJ2j1ba+1FH5w4F2id2kg
	 rdlCyQCoZUmwSn0iCC3tHZjijmyOoITEyQbYfTbP7Uuehk4LAwMYs9+kQvmvDg2b3X
	 VDlDHcz6RNHQvk+a47trCID2LP3bqYeR+YZPklZanCVAbkTqwawGNaoxEj31Qv5L3e
	 IxW6QLlzm6/Tg==
Date: Sat, 7 Mar 2026 11:58:38 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Shawn Guo <shawnguo@kernel.org>, 
	Lucas Stach <l.stach@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, s32@nxp.com, 
	Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>, 
	Enric Balletbo <eballetb@redhat.com>, Eric Chanudet <echanude@redhat.com>, 
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: Re: [PATCH v4 3/8] dt-bindings: arm: fsl: Add NXP S32N79 SoC and RDB
 board
Message-ID: <20260307-tentacled-antique-agama-e8a80b@quoll>
References: <20260306161555.9000-1-ciprianmarian.costea@oss.nxp.com>
 <20260306161555.9000-4-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260306161555.9000-4-ciprianmarian.costea@oss.nxp.com>

On Fri, Mar 06, 2026 at 05:15:50PM +0100, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> Add device tree binding documentation for the NXP S32N79 automotive SoC
> and the S32N79 Reference Design Board (S32N79-RDB).
> 
> The S32N79 is an automotive-grade SoC featuring eight ARM Cortex-A78AE
> cores organized for high-performance networking and gateway applications
> in vehicles.
> 
> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

