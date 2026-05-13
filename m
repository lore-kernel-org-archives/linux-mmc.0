Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DE43890F7;
	Wed, 13 May 2026 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778714343; cv=none; b=e6Br0E7JzSvTOeZfdhMH7KIbGwwyaE8GJs2yeZB0MXFryXspKHRzZ3OI1PJ3WH4av248vjGY1OZf9T6kVh3IUw+M4JehRhi4SyBLVPXpnA/EV1oO26CNQr9kpGdcVeyxRIWyRU93JB1Jfr8xAqAXFt1ZaQVXqhVnhSOtucs9ASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778714343; c=relaxed/simple;
	bh=Wsi7ZEqIvwGeDqkWI7PrvzFdTNan5ipG+HHvNDMl7Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/aJxOEpWeOisAvUOHI7RSYUwVVZArZm6Y4rd37+jjYfa4xRxaM4urH2vHjJ6Us+extJ0WGQxhslGgzZqasAZkzHP15m4W4brkFazVSjx9GPMjat7sV3ekULqfTwBxEAM66/cCF2ZkiUPz+zTRP5c7CfVNexrOXvRmJUbSsJOI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQZTYjwZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQZTYjwZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9588EC19425;
	Wed, 13 May 2026 23:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778714343;
	bh=Wsi7ZEqIvwGeDqkWI7PrvzFdTNan5ipG+HHvNDMl7Y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQZTYjwZ/E1PbisaLWNnXAIsEQZrKbI4Aj+XApdUC5DlvT7nRF5NFMhx2JiB5GauQ
	 6F7PSZVxP5+Tf2oUE1/UGIKg9xAWkmUWSyuIcp85wJBvYRli0OANRahLBUuYUrVYM4
	 SrmisaPT6LW2qZz9+mc3XoEJ9tY0/BN7QJydpbCF/djNSd0wKXfc5o96i9jBNznpCa
	 kpZwce0nBDVuzGopyXncy6RVj6aRWORSSVn6YJxdUPf5d7UvU5yJRPSGr7voMlSysF
	 M76VmYHgOBuzcxCXuOgJsB04TdwGmfRLBUAGN0EAeqk6QgXm7Bj9/GZXI431M2xR/C
	 7q7YAP8Kvd30g==
Date: Wed, 13 May 2026 18:18:59 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Monish Chunara <monish.chunara@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
	linux-mmc@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>,
	linux-kernel@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
	Nitin Rawat <nitin.rawat@oss.qualcomm.com>
Subject: Re: [PATCH V2] dt-bindings: mmc: sdhci-msm: Document the Shikra
 compatible
Message-ID: <177871433921.2289837.16381739543304518406.robh@kernel.org>
References: <20260508101544.736317-1-monish.chunara@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508101544.736317-1-monish.chunara@oss.qualcomm.com>


On Fri, 08 May 2026 15:45:44 +0530, Monish Chunara wrote:
> Document the Shikra-specific SDHCI compatible in the sdhci-msm binding.
> Use "qcom,sdhci-msm-v5" as the fallback compatible for the MSM SDHCI v5
> controller used on Shikra.
> 
> Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

