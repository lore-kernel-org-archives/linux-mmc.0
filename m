Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA52F289E1F;
	Tue, 20 May 2025 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747771277; cv=none; b=KW76CrKm6F8CxpJNz2odOY3+83VewWOAcGFwedBdTzcvQXTct+f6nZZ4q0D/nwMrMJqe1lwVdEHF0kMb5n6ZyonI7TWz1gY1vRISEYl5P6xRzcYIkE1z31c4WOWiHKtdu/JoeyEK7BnfeO462x7ueyw+nlj8SO4xzvlFlvA/SDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747771277; c=relaxed/simple;
	bh=ZhAAhyi7KBLB1twgdfejQUFumQAN8ZKWTtuSA8sOxPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oax4tcYVNA0smpqGc+Ifz1wHJ/tc8vHF4+T9Fl/tqIceVHcw0dij37PpqYUhr9Uz2L6UoQSmjRdAigqVtck/MaDAm+2wTugPFR0/6FMAB6Llog1EK25D5XqBPcunfz0y9IR8CSyyq2IqkhQAD5X0KP/mqf5mZVUIlSuTay0RqaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SovhHJTm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SovhHJTm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2B7C4CEE9;
	Tue, 20 May 2025 20:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747771277;
	bh=ZhAAhyi7KBLB1twgdfejQUFumQAN8ZKWTtuSA8sOxPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SovhHJTm19Xuu/BO0qAL+8mJ2aA2CvJx/CzW4dCN5wrzM1Bvgyg3DkWf7ZEWx1oIl
	 zHyM2J1i32NEY2GEAR5eCimerLmqJrbEAKn64KN42ZJBxKVnV1QOjy6cuXGSQRp4fP
	 H61/jYHvV9mK9dw6qfdpW27LqG31Twa6paGDvT9fs8Fl5hzGGIeiux9QRqLzEvis/r
	 aeGjMpZIn1eG8Ga4KVLJG0TSrpugIcmL2ReJuJjKGduowp7Cw/ZY6kx7Twm/QUK9RO
	 MjlcXCUHk9ew9uZZLilR4pnib+GRurD8PaJDQVNaHPrU5/n+243px+JhHWNZQaYjOU
	 CCegz8fa6L64Q==
Date: Tue, 20 May 2025 15:01:15 -0500
From: Rob Herring <robh@kernel.org>
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: mmc: ti-omap: convert text based binding
 to json schema
Message-ID: <20250520200115.GB1261173-robh@kernel.org>
References: <20250519-ti-omap-v2-1-2a0dbc08fb9c@gmail.com>
 <6a3a7e99-8d45-4e44-8014-14d182de5dd6@kernel.org>
 <97474249-7d4b-4a74-b2c2-13b89db1dc6f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97474249-7d4b-4a74-b2c2-13b89db1dc6f@gmail.com>

On Tue, May 20, 2025 at 10:41:31AM +0530, Charan Pedumuru wrote:
> 
> 
> On 19-05-2025 21:36, Krzysztof Kozlowski wrote:
> > On 19/05/2025 15:11, Charan Pedumuru wrote:
> >> +
> >> +  ti,hwmods:
> >> +    maxItems: 1
> >> +    items:
> >> +      type: string
> > 
> > That's not really correct. That's just a string, so no items, no
> > maxItems and use proper ref, not type string.
> 
> Okay, I will define string definition using $ref

You can actually just omit it and just have 'pattern'. Anything that's a 
pattern is implicitly a string.

Rob
