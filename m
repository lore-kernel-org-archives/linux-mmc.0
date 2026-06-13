Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683962D7DF1;
	Sat, 13 Jun 2026 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781375032; cv=none; b=nZVEReNmnNoLEucTAdyXa1AYObiJKeTbs6PCB/DJ8oPfb6UXbM7AHKvPV7Z2FM0o/dbpEDNPDWufjaofzN4i/vT9SKrT5d5HBmM68UDB+mZ0AB0OtXzUfQEx1hqLO4KYybLWX9a8XbqMILz7ptBResbctbBi8s+aNRlP05IO8Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781375032; c=relaxed/simple;
	bh=1gh2xQx7ax35Ma/iu7vPLX6Mu7o7bKJI+5MUIAzfFVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ur56iS0bKPMRf/5UhKgWtAmAzOazs5mV2mqHgoxxB4QxOJQ+LJFtTrMZpNDFFv163wPVJnq6ZE/bTdZ3h4gwZKOGPZXiYxhiioJNO974kMVf/SD6j9rdxDE6CbPM6GmyJklUIk8/0DCuijG+di2VfNySG3jx0jiAITOH7Wb6APk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=No1Ztip0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="No1Ztip0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617DC1F000E9;
	Sat, 13 Jun 2026 18:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781375031;
	bh=bW2ZyNL9PiJBJq/IMQkuWCqxi4Vg0c2aSHkAUwoZk6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=No1Ztip04mrjRw05vEGbGPvtUmEvkfRBo5kfLRBSnzDsATn8fI3HuMuMXdkr7IBxL
	 U/j1GNs2mA+/8aRN9VBSYVUDpphiGvaOtc8YU87Zr300snMOrYtWc24nRjrLP0NweU
	 X6spneq9II0WyxlKl7je+qLjEp8ef6xAvlwaIkilbKuWo1oXfq1l8jMeYI0w6DOVmj
	 bQ775jZr+KSfKvsRKuVsdlvxI2sapb77Vj654UFyE9KYh/IjCm9nCNNoYYvPQEL8BJ
	 0MHKiaJZUAwB+2vz5Vrcr5ciDEVX00L9OyRQ2h+orYgi81RBrVJu2yUiz8AtaqHMPz
	 dcwVc0Ofnix0w==
Date: Sat, 13 Jun 2026 20:23:48 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Patrice Chotard <patrice.chotard@foss.st.com>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/2] arm: dts: st: align node patterns with
 established convention
Message-ID: <20260613-wondrous-shapeless-pelican-6b927d@quoll>
References: <20260613-st-mmc-v4-0-b3c385617c16@gmail.com>
 <20260613-st-mmc-v4-1-b3c385617c16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260613-st-mmc-v4-1-b3c385617c16@gmail.com>

On Sat, Jun 13, 2026 at 09:39:39AM +0000, Charan Pedumuru wrote:
> Update ST MMC DTS node patterns to match established convention.
> 
> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
> ---
>  arch/arm/boot/dts/st/stih407-family.dtsi | 4 ++--

Thanks, but please fix all the files of stih in one commit, not file by
file. git grep gives more instances of it.

>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/st/stih407-family.dtsi b/arch/arm/boot/dts/st/stih407-family.dtsi
> index 3e6a0542e3ae..08acba209c56 100644
> --- a/arch/arm/boot/dts/st/stih407-family.dtsi

Best regards,
Krzysztof

