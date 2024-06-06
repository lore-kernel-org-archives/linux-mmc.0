Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A9810F7;
	Thu,  6 Jun 2024 00:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717633997; cv=none; b=qPSWEWBC69qhgaMM3IWDbdRNRvpE9rAohtr1jdvQElavRvt/mvZKz74wD+eOr21T6AUQvtKHga8bLwqgRnP+A1gRSTkSgyH1GOjLR1KO1/gwsNbNzcDJyiz4MDo0K5e1UTFHNWR7XOBib6PQ37H5StUfGkYQBXuMSjhydIrCwj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717633997; c=relaxed/simple;
	bh=WQF0gHP8Z0+bptDb1mHSImhPzB/SQ12M5264wKzMY5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmmV+7WfUHXsbglDG396XYSJz3CEwhLOXYwWea6ppMnNV+rR5DGnedZKpcSGsCJD7CiMDyTSR4YMX1U27CVPQyWBF6Wdu3M2Md4P4O0XRGNW8WIsaJyJIMpp3Yx7Z+XJMHE1DsNaigPNjdfPJZHSlIyQXepLVPg0yBdXZreOeI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLgHCFPv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLgHCFPv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE93C2BD11;
	Thu,  6 Jun 2024 00:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717633996;
	bh=WQF0gHP8Z0+bptDb1mHSImhPzB/SQ12M5264wKzMY5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bLgHCFPvdj12ouyCp2nhTERThnl3msBGm6S6R5Glz4n+rmeMjnM+Ofv7AXjMVRFnk
	 T3BPG9OUGwYxO/yspQrFZu6Ql+3bi+yW9rDNnpa2aTa9jaDsflyriLNeWZTSFt35ak
	 0Agw6hO6zC/TWBLNXhllP5TgOuIbRTyc+W7gwW23Di9jE9vfpGE2/coDik5fSQ9MK+
	 HuHjnsjYqPjTeeAUqvmjVu4JPUkolyX0oOMkUtgW8q0iS4cLAjAVH2+7oWJaFhXgpO
	 Me4Sx7E6+X3aiR9qh3i5jrHwfpkWBNUiigmvLmKU4W8uEvvD6SBEOcH7fXrScX2O8T
	 I0c+AF5sb9WMg==
Date: Wed, 5 Jun 2024 18:33:13 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: meson-gx: add optional power-domains
Message-ID: <171763399122.3518466.10613163286977063987.robh@kernel.org>
References: <20240605-topic-amlogic-upstream-bindings-fixes-power-domains-mmc-v1-1-4acbb8cc2626@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-topic-amlogic-upstream-bindings-fixes-power-domains-mmc-v1-1-4acbb8cc2626@linaro.org>


On Wed, 05 Jun 2024 11:34:46 +0200, Neil Armstrong wrote:
> On newer SoCs, the MMC controller can require a power-domain to operate,
> add it as optional.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

