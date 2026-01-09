Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9255E3590D0;
	Fri,  9 Jan 2026 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767950580; cv=none; b=lCbqKLxTcBrxHwkvabj6nQhLKnMyVqNIEXqyWLAxYl0LcFN9qb9MryhR5fhnBMDfYqXUKQ/2ZiWucNIGP4nFDJajIQbUAI4FQPvctOxTfaDw7P1tdlCwjw5OGMTPOUWY+9pLtCu8KrH/jdYp/nfLGKrY3EV/6r32FfRaUYHPpyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767950580; c=relaxed/simple;
	bh=fDjknpTo2lzuUrNgnyE3m0P/unrZfxoS8RB6wXYpCeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seJfUIAoyyNyLSZiUQ2oaEcRGE6AYXrk/5SsXzpvYcBcDkn6suPG9Z7PoR6Z483MtyWvbyScor5TjhWzuFABCJBLqT4xJUKnzoDTvg34v8fW+Xsnos/rqQRVRJM6/FUjtx5NHQZ1J9uPJDe8e4hAafrWS9i25elcgspC7/z135U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRVF5er2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRVF5er2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D165C4CEF1;
	Fri,  9 Jan 2026 09:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767950580;
	bh=fDjknpTo2lzuUrNgnyE3m0P/unrZfxoS8RB6wXYpCeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aRVF5er2sAorYuc5fNexanbpCVcOxfnFyMsBvt3WyA8sGEKwXL3nCkQvCNmdiuLRH
	 atKxffbSuoWb9O+SNDmWqPhMNJ0Zr+Xsp2Tbgu9zcSPrjEatme9Yj3r3ytQ4bA2h+V
	 wWnXATGGNajVPFpHIkBa2OqrbPXKGpan/hXE1FBjb4BxdivUlt4hwxzQR6uHtYyW8z
	 2SplE3ARhWk8Uu+e5MjlaTc3YwLbAVDe9oDEcmKSvL69rrM07wqBzYYQsfICiRX4eM
	 nNVP/ZqL8L2Efg8+/qOED8hIo2ZG8/uJRaeg1ZNDWOcBNTZ3ij3AvXYNUvWBGcM/EQ
	 3qNiP3KJYQCHA==
Date: Fri, 9 Jan 2026 10:22:57 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
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
Subject: Re: [PATCH 03/10] dt-bindings: mtd: partitions: Move
 "sercomm,scpart-id" to partition.yaml
Message-ID: <20260109-clay-giraffe-of-typhoon-cb954f@quoll>
References: <20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org>
 <20260108-dt-mtd-partitions-v1-3-124a53ce6279@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260108-dt-mtd-partitions-v1-3-124a53ce6279@kernel.org>

On Thu, Jan 08, 2026 at 11:53:12AM -0600, Rob Herring (Arm) wrote:
> Defining child node properties specific to the parent schema doesn't work
> unless all the child node properties are known. They aren't known because
> any partition can define its own properties. The solution to this is
> typically something like spi-peripheral-props.yaml, but that's overkill for
> this single property. Just move it to partition.yaml instead.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/mtd/partitions/fixed-partitions.yaml   | 10 ----------
>  .../devicetree/bindings/mtd/partitions/partition.yaml          |  9 +++++++++
>  2 files changed, 9 insertions(+), 10 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

