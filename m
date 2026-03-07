Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDF0346E41;
	Sat,  7 Mar 2026 10:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772881111; cv=none; b=H95UJ0QEhe9lLlNt2CP1DlC1+P/qrRNfpV4HKlydIaT8Ir2cJunxsAiXnlBHELLeabIBdhRJslIKlCzF688/kXzxoJ7ZjmH2R9a6LnYr6rYsqB5l0gH0DbyTK4ggnW+hOplbAZOnBrnh9vyFdN7ej6Re/VVyfqe5xXYOkx0eNM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772881111; c=relaxed/simple;
	bh=T+DInVoVYcTQuJxe+itH4ZSL1wK4q6WToZhQ3bulP9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prKqkoyJUFrIsNxDv0ZEax3nfDv7C79fanXIcaFuQSCj3PXCnwKlEo2mjZF91xljawvsTh075pz4g5lkv4KlUMNkUf4uQeRpYLM++/+RjKd/zJ0OCCizj8AdGtzNiSyg4GNR5yJ6WOwSldOPRCyljvy0m4PSgSS1e0/3ocA1bjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yk4RKLsK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yk4RKLsK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FECBC19422;
	Sat,  7 Mar 2026 10:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772881110;
	bh=T+DInVoVYcTQuJxe+itH4ZSL1wK4q6WToZhQ3bulP9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yk4RKLsKh0PVPQd0DBKglnZnVwLA50kpPa0uiheB37siWsDO0CWYubZiKqv+hpILK
	 u3b3JXLVwesb6sbtdLSlQzhrbb433VzcYFrYGTj0kuMfYr3WhP+JO8jBuptJGPmVio
	 fR/h6jo35pJpFuGIIPbzwfuun+1iVT8zb0qgY7tWTmm6LcWd5RptuUqnMAziMD/jNp
	 DSBY+cLM/RMzbE/vm4UEng4qEti+hfP2LFAHH514hgAgXUjRvBm7LsznY5Jrfw6AaF
	 6TuUnzh/jiFaMZtmv9DaRRwAv5zM7NLL9oYbELaxyHZBU755fvBLPQXXEYejwIZDb0
	 fFsI/RrbRmcWg==
Date: Sat, 7 Mar 2026 11:58:28 +0100
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
Subject: Re: [PATCH v4 2/8] dt-bindings: mmc: fsl-imx-esdhc: add S32N79
 support
Message-ID: <20260307-tremendous-hot-toad-63ec2e@quoll>
References: <20260306161555.9000-1-ciprianmarian.costea@oss.nxp.com>
 <20260306161555.9000-3-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260306161555.9000-3-ciprianmarian.costea@oss.nxp.com>

On Fri, Mar 06, 2026 at 05:15:49PM +0100, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> Add compatible string "nxp,s32n79-usdhc" for the uSDHC controller found in
> NXP S32N79 series automotive SoCs.
> 
> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

