Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9355E142659;
	Fri, 23 Aug 2024 07:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724398627; cv=none; b=nYSRH1bpZD3qEGunWNA4ZB0t3xMQtjgMyF0QBslvlTImBhVIZvogaj9+J4Rt6bAqQPM01Wk7KM7cGhxJ3oIFXgz0Adv5jzttAgH7s9XzJdn9fDMBG3x8c9aKNmpAC0Y8slj1kug+PePvRYvx0PF9AMN5Uyb2XM5mNGeKOCiAhG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724398627; c=relaxed/simple;
	bh=yKju3w6wlSIHPFZKtk3ngZboHQ6setVGKEEDPv4vNYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBFAH7a+NNHNmx0Tla00hSo4lY5mdf0XSCBE6GLDjA8+xPb/GkItVQMaSSEx6ON1oJ9PkVpZ9GjWuZhzPdFfSCJhKgZPkUANP1iRod/LU12GPkMEs6/ZuRwLJ4b309MeH3SOs8IH8sUTOSDtA8WdZwAdjXNpblEvuXpyszteTU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rw/yRpFY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rw/yRpFY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9CDC32786;
	Fri, 23 Aug 2024 07:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724398627;
	bh=yKju3w6wlSIHPFZKtk3ngZboHQ6setVGKEEDPv4vNYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rw/yRpFYx64PLBY6grtWSGYLh2tRcRkdSOiPdyEfizJstkjch8haK97hLfDp0aEvg
	 9mt+lbZwdIw3rrEE8auuu6RgxvoujGbG7zxva5v0cEoE0cSKVdYKugRg1lG+J4fjSE
	 ztiIwI5dgpUR2ozwMcAjfaOLshqKVe7ixGXYesZCH6EZBKcwzmK5dq5rEnTPORQo2d
	 BowvCn32g6o5sOjgMkE+wMVmVz5umN1YzjAfUPigzd8l0kO89lsS5plS/aoUCbCl5Q
	 rgrENZu6tM5j0DpsLpOKWnQ1gZp/LCPftY3J96YFBJF9/SQfcSVqvdtWNzhV0KVQCP
	 K2+dqT0Isw20w==
Date: Fri, 23 Aug 2024 09:36:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v4 1/4] dt-bindings: mmc: Add support for rk3576 dw-mshc
Message-ID: <ps42lcnfombj2u6wz6o2mgcyexhdhtmvvuzwrxdjwiet2xawi4@pjbvkv66dj5k>
References: <20240822212418.982927-1-detlev.casanova@collabora.com>
 <20240822212418.982927-2-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240822212418.982927-2-detlev.casanova@collabora.com>

On Thu, Aug 22, 2024 at 05:15:31PM -0400, Detlev Casanova wrote:
> Add the compatible string for rockchip,rk3576-dw-mshc in its own new
> block, for devices that have internal pahse settings instead of external

typo: phase

> clocks.
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 2 ++

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

