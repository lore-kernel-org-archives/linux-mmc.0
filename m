Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909931F759D;
	Wed,  4 Dec 2024 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321730; cv=none; b=klkpQaofUczFiuGVpnNOoEA/Q0rHjpEOpl60kiYvLdahd4UhcqoezCu6n0KBRQoVZfKLaQsL7o23NCv4sjDmT90SxPGexoP5bwpobs6m+XJVCAyKRhSAwQ8cVATguz7re0WSGHq8ADcSRkm6ynetdfZtKHPxS7uOQ97P3bNCqe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321730; c=relaxed/simple;
	bh=fJGcZcCvocrYYD5ARLmU36d5qyxLWZqmfekPOwaJlFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvQQx19Vhe/If9TmuFxRhUFc7Ghk5rsrl83ePywyRh3WYJwQgam2zMZf0pOVKj98BO8PMk+SeSuFw50QtbZSWeX34qgnPWtO/cMwvXUjCB4HovZ3aoDp6Ehfh7Yyb6ctlq8Whhoc9MibeSgQMwMBmJ4IgzA/SEdH+VJiqCtyZpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xaje4v2L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xaje4v2L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADEBC4CECD;
	Wed,  4 Dec 2024 14:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733321730;
	bh=fJGcZcCvocrYYD5ARLmU36d5qyxLWZqmfekPOwaJlFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xaje4v2LAo8DiuFogqnwp0IxwdRAJSvcAF4Wqr6Nl27/WXwqHyhLjcZoZFQLFZQgv
	 nhjO6vDUgg4YxbLx4d1gGM8prSl/a6VeIPjqirl5LO86NR7//gBFH9NUUvHuCgo7iy
	 4jv6yQOrkKrruEIthtgtxI0MmBf/ZfZLJnVft9XIKPl87097OCFBBNVnlMVPVRCHMc
	 MhmTiwa6tNhJQcAHSRmIQUGsleSQqjzCFMWDhuS/JtqIJXylgbmhRfOed42ws5YmlF
	 UIrf1CFqsqVScW7V8ObteDN+t1Tudkac15fKjBQ1JhxiRNqLxtlg/eLRHJlKYgSCxk
	 LSr5AXQ2QTPYg==
Date: Wed, 4 Dec 2024 08:15:28 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Kevin Hilman <khilman@baylibre.com>,
	Maxime Ripard <mripard@kernel.org>,
	linux-amlogic@lists.infradead.org,
	Jerome Brunet <jbrunet@baylibre.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: mmc: controller: clarify the
 address-cells description
Message-ID: <173332172731.169103.7423360262255147051.robh@kernel.org>
References: <20241128-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v4-0-11d9f9200a59@linaro.org>
 <20241128-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v4-1-11d9f9200a59@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v4-1-11d9f9200a59@linaro.org>


On Thu, 28 Nov 2024 16:16:41 +0100, Neil Armstrong wrote:
> The term "slot ID" has nothing to do with the SDIO function number
> which is specified in the reg property of the subnodes, rephrase
> the description to be more accurate.
> 
> Fixes: f9b7989859dd ("dt-bindings: mmc: Add YAML schemas for the generic MMC options")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

