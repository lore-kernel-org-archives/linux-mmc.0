Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE9923AB88;
	Sun, 11 Jan 2026 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768124711; cv=none; b=XSHQMG2PEzXRDVk6emSI6duflPpKEUP0VfnkR+XG9Szxs6hg6HT7ckhYvNmnGYuBJrvZBJOmvfLh1eS1rtnRI22rI7FbwPLi8RrYOo32oNwTkp6x7Kp4loROLUJPyUvpSmZNtNcwQbsYeqHiZ3mBd+dhFurEiPBI1yYPnJN/VPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768124711; c=relaxed/simple;
	bh=iMeDM31hA+TKBnDpzxob+nvBPL1aNcZnT38bW8owbxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHVtugg7OO1XoMGOM1Saoy+uTchGO78yZUUwSUgsJ9eVFxia+ZTD0nH9oBxxu6uIFyNM+aaVtsjQrLnJZh4ORu8RmaI3oN6iIpF8ZFTeZF/cy94bq3tg6smgS1Z1BTdH6EMfbtVKTKNimmFPytZ5iqTNXUFZ0At9pr04A2Smgpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAeZzExz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAeZzExz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26673C4CEF7;
	Sun, 11 Jan 2026 09:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768124710;
	bh=iMeDM31hA+TKBnDpzxob+nvBPL1aNcZnT38bW8owbxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uAeZzExzyMhF7j4TRwWr8LDVUBUKshw8sYhjbK1j01mWnix3nz596zYWjasHemqO2
	 pmpuMrUZZJ4kvVR0Qu7h6sfzU7KvzkmAc54AwVT7/vp7iUmI32VwfPgbg/8X9W0Dwf
	 wEMmtFygLkDEb0S7tzWeHRc38cv2a+6Xgnt5b4Ug9NrYbkkZ2sWdl32+Ibw72yejxE
	 Li+os7LzEYeR+FC6u4WjntR0YJdiKAbIY776+sOwJPsSqJDntDoz7TfokyXgIGaxNB
	 xCEpiHCwLtvxUzjEt0aVh4HFKTSSW6Njqo37koMdX1DJYR+us6PMS7E/ewEFN9TdxJ
	 QiVolSZP8uJvQ==
Date: Sun, 11 Jan 2026 10:45:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Brian Norris <computersforpeace@gmail.com>, Kamal Dasu <kdasu.kdev@gmail.com>, 
	William Zhang <william.zhang@broadcom.com>, Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, 
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Simon Glass <sjg@chromium.org>, 
	Linus Walleij <linusw@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Roger Quadros <rogerq@kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>, linux-mtd@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 07/10] dt-bindings: mtd: Ensure partition node properties
 are documented
Message-ID: <20260111-cobra-of-hypothetical-popularity-e3dbee@quoll>
References: <20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org>
 <20260108-dt-mtd-partitions-v1-7-124a53ce6279@kernel.org>
 <20260109-affable-poetic-albatross-ff7fcf@quoll>
 <CAL_JsqLcVUMJqTKnYpP_r4Z16Sw1pVcQ=HCFJG0bY_O=q3psVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL_JsqLcVUMJqTKnYpP_r4Z16Sw1pVcQ=HCFJG0bY_O=q3psVQ@mail.gmail.com>

On Fri, Jan 09, 2026 at 06:25:32PM -0600, Rob Herring wrote:
> > > -    $ref: partitions/partition.yaml
> > > -    deprecated: true
> > > -
> > > -  "^partition@[0-9a-f]+":
> > > -    $ref: partitions/partition.yaml
> > > +  "(^partition)?@[0-9a-f]+$":
> > > +    $ref: /schemas/mtd/partitions/partition.yaml#/$defs/partition-node
> > >      deprecated: true
> >
> > This makes partition@ deprecated. Looks unintended or needds commit msg
> > explanation.
> 
> No, the only change here is I combined the entries. "partition@" is
> deprecated when not under "partitions" node.

Indeed, I misread the diff.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

