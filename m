Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F9A1A072C;
	Wed, 26 Mar 2025 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976822; cv=none; b=DNanHUuYLR++gHognPbzV72N7XPD65Y/+zQ1VTuaJadbawOl+9dJuLYcWhqcN/g11QOouy4OG1d6Y6GeoW+BN3Yyrfe2Nq4ExOZCOO7wM8ZMe064DWn+RPUAzEwvbGvmtSdZjtmdguyLuFF3q54RofJYq20PkglSb3xI1tXy/bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976822; c=relaxed/simple;
	bh=mxd9NklVcoOr+WMrk13jMbsMArO4Lmm6XiRTjoB62+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSuClFrf31T5qMyPlKbhsh1ViFXbFStxuVEB7OMECIUXTCCIJBByRAlL8+Yy93CQ3CiGfXn8FqMqx5T26HuNpbXJmjjKevpIva5LP/ZqxLopXk0QLlPFZkl1kBr28A5B4EIul4/K+eTKdrnDirHSBjLXGnOpQE5uHpXs2lg3+UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmVrElu2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmVrElu2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E82C4CEE2;
	Wed, 26 Mar 2025 08:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742976820;
	bh=mxd9NklVcoOr+WMrk13jMbsMArO4Lmm6XiRTjoB62+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WmVrElu2k6+b07kci6agVxrhNtwTVcVrEHwz/uJwdd0/tcqZu3PYR7K0pIxoWl9A4
	 S1EmzqUUWkuuqtwPl44MWn4f4nwp/JpsEsR6XfFfAmWWsULn85BPrsrRrKqDgX8PSj
	 qzw7LiC3GI2jy75clApJmZvt/jA9QNXEDmiqVLHDbMnd7QgMTAOBAnuIlzV06Xr/9T
	 0ELkZRKuy0hzXjYf3r27PByyt8rtI0hDyz5iBhgOmip+M8s2xm8hi7Oc7Vr1HLdGtG
	 V1ea5RHwiVek0BJ+ZwXlu7lmx+LXItRDH+djAwsdKWd7KzRbv13/29NFkbCag7lxyz
	 iU2A/+Hj5cf6w==
Date: Wed, 26 Mar 2025 09:13:36 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: mmc: marvell,xenon-sdhci: Allow
 "dma-coherent" and "iommus"
Message-ID: <20250326-accurate-remarkable-caiman-a73cd6@krzk-bin>
References: <20250320-dt-marvell-mmc-v1-0-e51002ea0238@kernel.org>
 <20250320-dt-marvell-mmc-v1-1-e51002ea0238@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250320-dt-marvell-mmc-v1-1-e51002ea0238@kernel.org>

On Thu, Mar 20, 2025 at 04:35:46PM -0500, Rob Herring (Arm) wrote:
> The Marvell xenon-sdhci block can be cache-coherent and needs the
> "dma-coherent" property. It can also be behind an IOMMU and needs the
> "iommus" property.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

