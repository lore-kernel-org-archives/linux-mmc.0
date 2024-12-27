Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF171474A7;
	Fri, 27 Dec 2024 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735285289; cv=none; b=bOz+p5f8dwSBg+7uCGsbMt7/jkye8EzQ9u2AOsXKPwHh7CCAw+JMdFHrS8rgM1T9fzd9JnVCkwzjk4N6XTmGu67UswSiaVuQr0Jf0/tJEOIehyLxxCG7kdnMv7SqPzISIZT/T+kr/a38ohUJszUA5XrOXlzPU5ILbWJP7Zu9yto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735285289; c=relaxed/simple;
	bh=FtA+adBmn4Tc44PWrXmCgKMhhJV/rkvT2y5z+qWhnSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZA6yXMXyaEK0Lfgbqe/v2FXIvn+CSANQe7ciDfID9xb6GCILotpeEnz7Jwxq5N7a7FtX9oAs3O6KXdYduFLenSsz6WOmF2yikDTgOt4yl/VQfJ0l471YGYJ1n+p0p92pMeyJB36tXN/NTOHbTG0sjrxWT7Htu4l6fNeFD2El/uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyB+h0RU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyB+h0RU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA5CC4CED0;
	Fri, 27 Dec 2024 07:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735285288;
	bh=FtA+adBmn4Tc44PWrXmCgKMhhJV/rkvT2y5z+qWhnSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AyB+h0RUIm+bzM/nsAJAghJ90XnFctsZTH5AjaUawPw4iTOjV5CUXjeAlcaQDnPMT
	 ythinKx0gkmrcg1IskEFXRhNCQimm+vvmscPmClMe+uzrWm4qxCK09mA2SU6c0GSKY
	 a9Z3UQ6vx49qqTOnpGxP8xdxXY56k5JbFApnqy5c89F6rxpElG5R/5lkTYsJoWiuGq
	 revePAJvGrBQDqMQD25CiLhoLQtRue8ZIx8NaGkxoivY3UueLB6BWzlzF4sf279u+2
	 Meztq4+8x/N6MK3tLSU+o20oBCOUpFuoYHZct3KgHuPEJbwmx+bM6wNY+oo244Z1k8
	 LZWdpEwIVonhw==
Date: Fri, 27 Dec 2024 08:41:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 03/17] dt-bindings: mmc: rockchip-dw-mshc: Add rk3562
 compatible string
Message-ID: <n35dljnwvup4e4mye2v4lgygwsefvux7jbnjlvx263m6bfupap@ajm22inne7do>
References: <20241224094920.3821861-1-kever.yang@rock-chips.com>
 <20241224094920.3821861-4-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241224094920.3821861-4-kever.yang@rock-chips.com>

On Tue, Dec 24, 2024 at 05:49:06PM +0800, Kever Yang wrote:
> Add RK3588 compatible string for SD interface.
> 

This we see from the diff. Say something not obvious. Where is the
driver change? Why devices are or are not compatible?

Best regards,
Krzysztof

