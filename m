Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B5338CFF3;
	Fri, 13 Mar 2026 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408017; cv=none; b=Igg+/8RhPCrqGwfSwG79V9yaRXCWLNoBc5uUDwzofdKmvix7QGgdWrBBUA3lhAzWgjKALR8L7WAwoZRt7aoX8fz0A2yo5XrXeGmOXRpPQl26vWdzNOMwsr17svUkIO/UnjV+9q1qR19qSTHg/jfmwk1iLrlVRBozdUKJFImm9dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408017; c=relaxed/simple;
	bh=kdgwRUuWZ77wMPrVDP4ONiPHd65HIy7Q9WZkdQl66C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJvZQxILfAzCY3n94ItBFYfvbRNM8ASdpRrgkuCyZxzlzuMApJBMXnZfOB6TlY3TskeNG5FY2JTEq45Rm5y2cm3PQLhuRig4M84NJBbdjNK5/sNfrmYL/a1t5kjV1icVYqDIwXyvE7YIM5KT1Fuo5L7hDJG/FuOwORXXGQe9Rf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WY7Kr4/a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WY7Kr4/a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E859AC19421;
	Fri, 13 Mar 2026 13:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773408017;
	bh=kdgwRUuWZ77wMPrVDP4ONiPHd65HIy7Q9WZkdQl66C8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WY7Kr4/aLxVRDUw3ROGUiZEAwOiLZvVctkoXRyQezvfwEimFtKTmvoCr8FWO1ItUZ
	 L7FMf5yPpzOmli/cHXGqJyT38ME4HEhapStNXdtzTPrKCFPPEhd/oQKp+oL3fFrSfJ
	 V6Ap2ZNKswfrzTltXVkfutBVSX7eVH0aboJ/xprdfq+X3jGb4kOGv/n6gSA5Upi9Ll
	 nIi0WYcVnGOlqHwPZ6plEaQ3DZ/OXLQQecIsuDXcWDqjwHPUQKZpjh2BAP9fDeg0ow
	 3TvegrJ24dx6sv7ppgPNpnhamZlbpL7VbC/RrxH2nCcubFMzwEvIU7VeYfY9pvfK0f
	 Ke3PCcf8m+4/A==
Date: Fri, 13 Mar 2026 14:20:15 +0100
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
Subject: Re: [PATCH 5/9] dt-bindings: qcom: add ipq5210 boards
Message-ID: <20260313-beneficial-shark-of-fragrance-b06fe2@quoll>
References: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
 <20260311-ipq5210_boot_to_shell-v1-5-fe857d68d698@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260311-ipq5210_boot_to_shell-v1-5-fe857d68d698@oss.qualcomm.com>

On Wed, Mar 11, 2026 at 03:15:47PM +0530, Kathiravan Thirumoorthy wrote:
> Document the new ipq5210 SoC/board device tree bindings.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

