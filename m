Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16F43BD24F;
	Fri, 13 Mar 2026 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408315; cv=none; b=dJb/Y+mVtr+FQZmPLQXZPlR/dIWQCKJu8qwOYkUgqIK3TaIMYrTW52wu0cUhWisaTGtwZEbdhwIsKjCx/upSZ68sJIJdFhF/LzsB7js8EexyxxxVRv+a4lNPXik0sDtAgqb4YXmvxA0kWZE+FvCqUwFalnbpIyBI0wRSCyq5YYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408315; c=relaxed/simple;
	bh=4c86BLk/dI3NXdF++uHeN10FLncIlDSsx+Zc0PHkiYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZKJJG3SuzNbgqGFMaGsgzcp1bxkkXHGsJX43VC0ZQKdUIEnKWDG8Ur+z+Y3sE7RZDaib1xoThX8Hl8iLUV4cRDaNtdQY0V9paXZUdG1IZpZ3KWxsrQbg/n2vWCi03arJVCt7JZlkanjLe38gQChIyBXEXsLvkhnHSXCNcRbYHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2GeQNG3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2GeQNG3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EA1C19425;
	Fri, 13 Mar 2026 13:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773408315;
	bh=4c86BLk/dI3NXdF++uHeN10FLncIlDSsx+Zc0PHkiYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U2GeQNG3fSVCdV+Hv0LKEuvolEub88KtSSZ2NhkQ8rB+eWnywyD619eA1h0Ff5v8c
	 vgaaKvYdZPJnD23f6m+/wrAFpwRxe+jiNLm/JClwQlzCeq8ZFCuXFoN+0/QZNLfGNR
	 nQDkjiCu5os1Hhek96SmSDOtmYlmYz5cOHoB20ZjkAI9IXuwwEqkcuJ0Q8ou0sCj4R
	 tH8hPKXWWmy58MxZpkzWX3hWOMMt4UdxJJ7fWAhZ69ADoBXvk6cZ6JN4EljU9UUVY5
	 p/KLnwgb1LwsQRR/alXvn1Y/6wK/2JUmJmJyHM3+rtU/hRPvDvPvjAfcgPF9TySkCW
	 Bw/JInl12LTug==
Date: Fri, 13 Mar 2026 14:25:12 +0100
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
Subject: Re: [PATCH 0/9] Add minimal boot support for Qualcomm IPQ5210
Message-ID: <20260313-serious-calm-chamois-4a0af3@quoll>
References: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>

On Wed, Mar 11, 2026 at 03:15:42PM +0530, Kathiravan Thirumoorthy wrote:
> The IPQ5210 is Qualcomm's SoC for Routers, Gateways and Access Points. This
> series adds minimal board boot support for ipq5210-rdp504 board.

You combined around four or five independent subsystems. Where are
dependencies and merging conflicts/strategy explained?

Best regards,
Krzysztof

