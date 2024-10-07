Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA27A1D8E07;
	Mon,  7 Oct 2024 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316780; cv=none; b=JcYLaM2L4i51Gq3hYV9jCsvTroGoaEzcEmnDutXjS24fNhJ9yaA93qB5pPNW5x4YDPG0lG/I8EUMKdZcDcGF+beiBDRrLzf500sGnsstLPca2oBpRN/nUDHlHqaSkJNB4oDPvzyA85VlXfbhYGN1QRPiBtQM12W4ieF+9t1UoZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316780; c=relaxed/simple;
	bh=fhPtbJcYuo2EIiYOBX9N2FPoMgTuRpLRKCd9jzg6Vt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDt0b1nfS40+Q/qIQyBzJBj7q3zKiy8RjwFUJwI7ixT1kgtyIZoE+Bbi4iOBtstNANudxeaGSqxRGj+wNs6a9Tw2YlctRXsWlvJN7ZvNv3RK/lPYV6tb6HYXSHybAQ5roAMhhTDy8gW8p30JyY9Gz39mFy3+9ewC7j+G84X/hPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUsH9KoJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUsH9KoJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30748C4CEC6;
	Mon,  7 Oct 2024 15:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728316780;
	bh=fhPtbJcYuo2EIiYOBX9N2FPoMgTuRpLRKCd9jzg6Vt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kUsH9KoJ/pcRJzTf0yiA76pFtXQToF3xoqGGBMSO/255O9nNZJx396sPE1Qn1deZc
	 VbEIMzU76zibDubgGE9FYQOsPiKXrpR6mOEM0/z8ZrDnRI7xE1ad+UZMcc67dii7Yf
	 fu+Ti3BrJasdXWC9/KH/aWR8juwbZy0PietEoRxpUJHCxDSxx5i8kWv24prO34EePT
	 rQMOx5pNzv553+BV2nKmuoONMyk81DN7HbL+OWsDwSQ32WNjrdCfar/3lysObkE7Ng
	 V7kVxHq76AYgAlJyIV4Cm01BV3+1UDRYwq3DGXY3lDRablkJqXEUIRDscEcOMIlmOH
	 Kn5FCb6rlGxjA==
Date: Mon, 7 Oct 2024 10:59:39 -0500
From: Rob Herring <robh@kernel.org>
To: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: mmc-pwrseq-simple: add support for
 reset control
Message-ID: <20241007155939.GA849826-robh@kernel.org>
References: <20241004120740.2887776-1-catalin.popescu@leica-geosystems.com>
 <20241005182632.GA496820-robh@kernel.org>
 <92a27d06-cd37-42ff-ac48-687981d24d41@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92a27d06-cd37-42ff-ac48-687981d24d41@leica-geosystems.com>

On Mon, Oct 07, 2024 at 03:32:42PM +0000, POPESCU Catalin wrote:
> On 05/10/2024 20:26, Rob Herring wrote:
> > [Some people who received this message don't often get email from robh@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > This email is not from Hexagon’s Office 365 instance. Please be careful while clicking links, opening attachments, or replying to this email.
> >
> >
> > On Fri, Oct 04, 2024 at 02:07:39PM +0200, Catalin Popescu wrote:
> >> Add compatible value "mmc-pwrseq-simple-reset" to support reset control
> >> instead of gpios. Reset controls being refcounted, they allow to use
> >> shared resets or gpios across drivers. Support of reset control is
> >> limited to one single reset control.
> > Can't you do this without a binding change? Just use reset controls when
> > there is only 1 GPIO.
> 
> That's a good question. The idea was to keep in place the gpio support 
> w/o impacting any platform using pwrseq-simple.

Why would it matter? If not shared, then the behavior should be the 
same. If shared, we want to maintain the broken behavior?

> 
> Also, later on when support for a list of reset gpios will be added to 
> the reset framework, this would not work anymore...

Why not?

How an OS handles reset-gpios is up to the OS. It can evolve. The 
binding can't evolve because it is an ABI.

Also, a list is kind of broken to begin with for a "generic" binding. 
What's the order the lines should be asserted/deasserted? What about 
timing requirements? You don't know because every device is different. 
This binding would not be accepted now, so extending it is questionable.

Rob
