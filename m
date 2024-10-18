Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B837D185B6F;
	Fri, 18 Oct 2024 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729236072; cv=none; b=Bvf2nsRm6dTGrX0w3f9WKCNYs/myZs1ZiSbzYQTpaUKukkhaYnvx9h0m2YpZmRY44l+nmX8mDGN25bOz22E10PP7khoIuRQvzNhFYkKHFELbu6Mb7fsl7mMdSCuBEtLF9vmNRC6OQPS+LjCYbWTNtx1uqAZD/w5L9yNnS3Vjfxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729236072; c=relaxed/simple;
	bh=RBpBaLrgUrWyCzlWxpbI2oXQCxrf9xWJZi2qSEG43hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOO85IebkHzwg8Fx6By5v2t77SQt6fJWrq8VNX/peDXD1I9FPzPjALwjakUFUd6AMyNYcWlprQ4R/Q45wiNNDnPebUe0Ik4uf2RpTNUQUVhJm++ZW1dF0OVW43uMlgl7B4b7RgWvi2G1EbMdB2LWj852Um/1EczK/Hn3pghRxcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKQ0p1d/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKQ0p1d/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D66C4CEC3;
	Fri, 18 Oct 2024 07:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729236072;
	bh=RBpBaLrgUrWyCzlWxpbI2oXQCxrf9xWJZi2qSEG43hY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YKQ0p1d/X97NWSG+C5Tr9oRRyxFIjUbaUEmxNGrJ266K4oHEQoLEIAkZP0DAJtwfP
	 o3gOXHlnm0iVH4/qWvqKPqlpvwL/ETC9DXoJc7Ve9zALw+XHxFHDXUxO3CCOu8OsJ4
	 Bstgy32q0RJR+ZPF60CPhUESEtq7YFIHRCCL+YHQG5iSzzIsoABwOYM0s+bb0MZo1+
	 oNM3MeGfGA3X9b6E24GLCXV+we6AnlXjaJeB/xlTlqLx+nvfs+SQyEeOq64Wpes5US
	 VRaCIQvANpDUrnmJZxXFvQ+oS3dF6xr4Iq52GhzDIXsDZL63kmNGHT8Fps79WNO2/v
	 HsdJs04g+v4TA==
Date: Fri, 18 Oct 2024 09:21:08 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bhupesh Sharma <bhupesh.sharma@linaro.org>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-msm: Add SAR2130P compatible
Message-ID: <6iqvng3barptkl24lxetqkjbdx5b6zelnf7toc7xocj64kswbj@bov5636rlqyn>
References: <20241017-sar2130p-mmc-v1-1-c84da16a001e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017-sar2130p-mmc-v1-1-c84da16a001e@linaro.org>

On Thu, Oct 17, 2024 at 09:15:37PM +0300, Dmitry Baryshkov wrote:
> Document compatible for the SDHCI Controller on SAR2130P platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

