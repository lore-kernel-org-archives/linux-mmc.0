Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361EC1A23AD;
	Wed, 26 Mar 2025 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976902; cv=none; b=nV6h0JuofkYSFSoJnIC16OWtKIjxfCuGrQWtDha/HXPrDvR8CA2buwyK+Ic3B0TBSfUk6PBmdtmWvFqoRl9D4EjqUEjlC1mV2/vVtE0P92FmDNixdSnDCFCbQPqAF+7asMd1I/urOQ/1QrTqYmOTCEfuDrepTr05L4ek4Pxx4Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976902; c=relaxed/simple;
	bh=gAniqJkuUHX0bLXDcqTZVfwYS6QnDyYuQRRlQh3xL/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qgi6dC/yPOSM35v21fHuFxeK4ABb08Ou6jerf1UA3nuMXKJsJ9Qk3qPzRBPnB+X4rxbEV9H1RtU/WFa82HIZ5ne+qa2ZKNQE6lO8mg5LefUL2VDiWgLLmD5h5GErqf7cq47X9xIRZU3ZSEMs7djynWkh1Zi+nwy+7F0E+UgsYoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nhssw/C0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nhssw/C0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DE6C4CEE2;
	Wed, 26 Mar 2025 08:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742976901;
	bh=gAniqJkuUHX0bLXDcqTZVfwYS6QnDyYuQRRlQh3xL/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nhssw/C0U+wwnY8xBlcTunqXAO/YAjz2Y0JICwMOInOIIbhtZb32J/if7AZYDjQ/n
	 +6fQqMVw6e2npjuMDnyK9Uorf/nXu92RWjuaJz9FNIjhIoQ2SQoDNbxgYDgUPydkPd
	 qEUu1oujj0YCBZqNSFRLIs60GbBf8krWzODE3T9YpPGMYXX2s8NMwYWekc0GvOChw0
	 fglOKrE3V5hKGwew8mYR6x6jAaeMsTdGvGtEQP6oCM/vybtc7idXH4yLhGE3aCH/pT
	 NL318W3jc8zV/TamNSVmF9Tetnm/ST6rQBE2tUXFrGbfQKHFNeuyHrmGjgF15WW8+S
	 m5PW2lQT6BXcw==
Date: Wed, 26 Mar 2025 09:14:57 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: mmc: marvell,xenon-sdhci: Drop
 requiring 2 clocks
Message-ID: <20250326-light-shellfish-of-aptitude-2e64aa@krzk-bin>
References: <20250320-dt-marvell-mmc-v1-0-e51002ea0238@kernel.org>
 <20250320-dt-marvell-mmc-v1-3-e51002ea0238@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250320-dt-marvell-mmc-v1-3-e51002ea0238@kernel.org>

On Thu, Mar 20, 2025 at 04:35:48PM -0500, Rob Herring (Arm) wrote:
> The "axi" clock is optional on at least the "marvell,armada-ap806-sdhci"
> variant. Not sure what's correct here, so just drop the constraint.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/mmc/marvell,xenon-sdhci.yaml | 20 --------------------
>  1 file changed, 20 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

