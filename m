Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79A921B905;
	Fri, 11 Apr 2025 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744391019; cv=none; b=Y/8oXtJVDab3qckn/KnxNH29NTImhdQCYuWKDeLJZw8Bdv2FN9pifBg23C4arR08C3zUtR3tqAfWQ/1wHXs9Lb/w0EkVpkAkKJ3781k6trsbvyo5+TybYcrhv8QOWC24N1DrzUCJTpHorrlRgk61YHoZuVC1FBpkXECb4aOtogg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744391019; c=relaxed/simple;
	bh=lTRD/ogPCfC2CaO6K3z7kIWgrD+QpMzRDVdDjdeTbrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJGIPWXxGYYtVsl/gKsnd/kS+9+2Khjl3qSWfkGaxH2AAMx8kDUKFDKTC7NN+t048CxRoXnw2aF4+0hQikrRc5pomh3f103inm6DKbyQE5odPAy7r8lLmUfwYy1vevj+PrnL920R8FPnPpCUbd+xbSsAQo61kVPdIglHpS/1N+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3usqmWR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3usqmWR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C18C4CEE2;
	Fri, 11 Apr 2025 17:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744391018;
	bh=lTRD/ogPCfC2CaO6K3z7kIWgrD+QpMzRDVdDjdeTbrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q3usqmWR5CRy7u8qPLvL7e1tH00uWcv6p7zLwGpIk5SoCaY3D7mwozL+ZAZCByyvZ
	 vsOEFqNvf3/ih+Ezlgt56uQeiLYyP/UU5V3fF/L2B9kNCsHS1ED52zeTiFTNnw3l8y
	 gAMR0ydoDRS//e+Yf9hjTnttaPZ1Zxjv22WaPklwohbXHRxY+ZESkE8KAt6h7wfM1H
	 /w/oI9TtPdmsAd1xq4ywywiWQyJMcqZdEnkuLIw3biEL34T+A6MEH4d1a459Sf+eqS
	 3iI9zfq11Fn40xm6Ec5CoE5CLUTlhJ6YJ+SjPXvl226y6pX9NsB3+nJ9FE0tI0KroO
	 s80a6hj5tNCWA==
Date: Fri, 11 Apr 2025 12:03:37 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	loongarch@lists.linux.dev, Xuerui Wang <kernel@xen0n.name>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Conor Dooley <conor+dt@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Binbin Zhou <zhoubb.aaron@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/4] dt-bindings: mmc: Add Loongson-2K SD/SDIO/eMMC
 controller binding
Message-ID: <174439101645.3390925.18194031700115958837.robh@kernel.org>
References: <cover.1744273956.git.zhoubinbin@loongson.cn>
 <9c8d0f4b28e8023ecbfe49cc934b6d0c2e0e1fdc.1744273956.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c8d0f4b28e8023ecbfe49cc934b6d0c2e0e1fdc.1744273956.git.zhoubinbin@loongson.cn>


On Thu, 10 Apr 2025 16:40:35 +0800, Binbin Zhou wrote:
> Add the Loongson-2K SoC's SD/SDIO/eMMC controller binding with DT schema
> format using json-schema.
> 
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  .../bindings/mmc/loongson,ls2k-mmc.yaml       | 67 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/loongson,ls2k-mmc.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

