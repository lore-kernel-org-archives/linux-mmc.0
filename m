Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF304266A8;
	Fri, 15 May 2026 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836085; cv=none; b=NZ2G5M7jVozZTvC+WDfop/dg669g9yCYehE+SP+Am5pxKj7e1sS198G/WBbGaJMns6SAOyVoyEmIJRcuds6RdU2vOoeyISqnY4tcwg17rMUj2lUATtXlByZ6GyKWOrlaH2M4tO/OXa/XQksxk1EhUqVFbvl+yUcaGdjHEtgOH+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836085; c=relaxed/simple;
	bh=EGDvlXSZJJdhyw95UvC9o4yaYlh2x+sp03RxqtQ0GNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mU5VUYFGoszk9ZX4EfzYWo1pFhaenQk7M6WGS2Z/sUxqKtBEtgOuC2A8HMKxZsfDaBJVR34GSdgLAZQkA4fF9JnzDM5h/K3ypSa/RhepAKhfv9d6K1m+UHPVFrLWdYqogdPa0XX2feIduU7eGX0rwV98eMe5U851v+A5sO4bQRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=as/Y0OGv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="as/Y0OGv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAA8C2BCB0;
	Fri, 15 May 2026 09:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778836084;
	bh=EGDvlXSZJJdhyw95UvC9o4yaYlh2x+sp03RxqtQ0GNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=as/Y0OGv5ybndniXqhFo1XfDzUY6bIvFOD3hPYTZ22sQFP6SVqk63Lv4jLHWfebEX
	 RpN292YFb+VHCVAQ4WdCN6OGDDswM1ifQHi+o+uZCSv+cbY3tW3pJgVz7f9CxdaGRC
	 TUTR39MCH6Fu6Qrg69PozC01DZnzI+h1YiCHRHs0sCk7omxoz3NQDkPRj8J+hH70uf
	 Ch+iuN54nO/wT7ldzXdMPXUz8Q8/h+9liJlgGVMAzsdt1CDT1J8WHtdOqxRDlR+y5F
	 REnEGp02CO3MaPIi2ZVaPhC79LhHoH2hc1DRGWW/Wql+hZ+GxAiz9FWB6j1t+3/llZ
	 N+0ZlaSE7vbMw==
Date: Fri, 15 May 2026 11:08:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-msm: Add Eliza compatible
Message-ID: <20260515-meticulous-mustard-swift-e0fec4@quoll>
References: <20260513-eliza-bindings-sdhci-v1-1-b2cae44163c1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513-eliza-bindings-sdhci-v1-1-b2cae44163c1@oss.qualcomm.com>

On Wed, May 13, 2026 at 02:19:37PM +0300, Abel Vesa wrote:
> Document the compatible string for the SDHCI controller on the
> Eliza platform.
> 
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

