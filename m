Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990E22522BE;
	Wed,  1 Oct 2025 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759323313; cv=none; b=iXXRe/yqeIeibXCsmIxtyXD1Hb7uwnx40vddeeMcXo+Vc7OcO6IPoSPxneRA/cm0K2k/09kbpB7jszbGwSfnizB5pdl0e0vMuei9HKt2YCYr/9nI29/qrGcbLqbtiITobvJVvMmZGhCabfG5KJNgPM3FTwm1nP1KX9v5R8df0QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759323313; c=relaxed/simple;
	bh=LRPAIU7oUMh2EMMgZZBYLQFZsIlE0AA8tKcdEBDoFCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RX/4bUwFx+ZOQxQhujKZtrrj6w8QUAZjRvCTXSzCyfRpoA5bj/htPKkFwQFVzWQSSzQsJAvYWA5x+XEVF9eBR7tAcKNZSTmEsy7cLcvfXpCtP5V8kIXM3virgt4V601D+Wkng4hp8ojz8wm4cd3HnIcP4ECwUBNepwcgtOsCqKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKiDXyTZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKiDXyTZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798B9C4CEF4;
	Wed,  1 Oct 2025 12:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759323313;
	bh=LRPAIU7oUMh2EMMgZZBYLQFZsIlE0AA8tKcdEBDoFCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZKiDXyTZkU1mJCAZsavBe4swvM2lZoX/FlntfD5DsO0H12GtnACGXA+6hrP/2523g
	 EBuJHohENuaN2IGd0NGDCkUiRncgQpdLXAp97yVusHX0qW3V0ag12uHzSG/yUOy1CJ
	 yQCLnIcWO9MPEBvb3BGBd4t64NMMqH5Q5xmyAqo+eGijsRsP82uZhh62UtsCliPJrz
	 WrsD3guUrnNbaYOawmMlXsKbaKt4ewyW0vG03gGKBUYoXIaVjMHCx41Hw2eYYajVEt
	 RJZdJUcNf/ccG2O75khqcerZKVdDDnzdHGVV3FWlt7d4shMzCKn1ZPUFqUCXRJqD9T
	 xw/tBcCZKf5lg==
Date: Wed, 1 Oct 2025 07:55:10 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Akiyoshi Kurita <weibu@redadmin.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] dt-bindings: mmc: Correct typo "upto" to "up to"
Message-ID: <175932328886.1147501.11874097725207297926.robh@kernel.org>
References: <20250930134547.1096686-1-weibu@redadmin.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930134547.1096686-1-weibu@redadmin.org>


On Tue, 30 Sep 2025 22:45:47 +0900, Akiyoshi Kurita wrote:
> The word "upto" is a typo for "up to". Correct this typo in the
> mmc-controller-common binding documentation.
> 
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
> ---
>  .../devicetree/bindings/mmc/mmc-controller-common.yaml          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

