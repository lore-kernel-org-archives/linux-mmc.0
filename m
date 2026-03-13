Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A7130C63A;
	Fri, 13 Mar 2026 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407978; cv=none; b=m2mgZjHVIuzUhknqa4NGNAW2BqVx0YrmMe9z80NstFOqkcj+5MLxxjUPsp2irHuEPDmevR31zVLt4QjmTATaHOVItyllE/kMhKlhi6HXqgFoE9ysUeHoRwBgSMPQQNgh1/Xm45mlIX3v5mFRqNiEEkJ+2K21LMCgi+CthoJqt7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407978; c=relaxed/simple;
	bh=sczW/ndVy0XXEZbOfpH504SGT34YR4CVDjtStoYvlvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdDS3zDPJT2jX5asp/8eVTnO4dirfp+6sq3Evgvjq57QT3LVL1PZMiao5tcrqIUvPVPMl3cFbHj5Br/FD/kBRPQq86Jbly3h5x8c6Z0CKEqsOmLkK+TDygXq8kqh3F7oT3mH8PWuRGSYKFDC2nNCL6teQWhok7C5zl961fNvT58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csFwMpzt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csFwMpzt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73910C2BC86;
	Fri, 13 Mar 2026 13:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773407978;
	bh=sczW/ndVy0XXEZbOfpH504SGT34YR4CVDjtStoYvlvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=csFwMpztGgTndFg9Nef8LYBKzb/ufR6SN9xrd4z6xGAe+Kg2HZ+eAiG+84T0NvbWa
	 Xuqb30Qu2q3sfwda3eqUlsZEBM80zQAZUBiZpXPU3Moae0l8kLOKlWq4iT2UZXa0+U
	 uKpngo33N7zd8YXOg3UMQur7N4idJrwT3MqYRkyxLo02Jk1jxPbAwqvHzQajqN+44M
	 f62I4ycpMoObSMU3MEATvhMgUpl1JnVqOitZA/gzcv/CYGmojgAvwmTDEHHef++9Ys
	 SZs9v4s7sgS/ucVAcuSH2LCyOF7ZfBfLgmkj90b/YZTqltyinQZpihxQ3PHCakpCB5
	 zF8eFAsohsRfA==
Date: Fri, 13 Mar 2026 14:19:35 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 9/9] arm64: defconfig: enable IPQ5210 RDP504 base configs
Message-ID: <20260313-llama-of-absolute-champagne-4934a4@quoll>
References: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
 <20260311-ipq5210_boot_to_shell-v1-9-fe857d68d698@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260311-ipq5210_boot_to_shell-v1-9-fe857d68d698@oss.qualcomm.com>

On Wed, Mar 11, 2026 at 03:15:51PM +0530, Kathiravan Thirumoorthy wrote:
> Enable GCC, Pinctrl for Qualcomm's IPQ5210 SoC which is required to boot
> ipq5210-rdp504 board to a console shell.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

