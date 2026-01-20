Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549DD33F8BA;
	Tue, 20 Jan 2026 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895665; cv=none; b=iPcDRaIMYO6aJ3f5rB/Umugr6cRzP9TKA0I9TodVR+CQokc5pG2TllKs4Wtizq7MpGt5xjuPqRjkeFfgczb3QZGdWODBLiFtXq8r0ktPPiCOaOEU2ProN2kAW6T2gC+VaMeyw4oi5LJB3DKpeBtzGQ8ufvgW8ZZ7KoOWZULq4s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895665; c=relaxed/simple;
	bh=dtywpyfo8zGST6RB5ITRINgYqOsM26JAXnMDKRpEcJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxsZrhR3BXQKzx+5qVHhKnNt4dQ4DY0rtQH9FdcsBrxdtAA8/gJMvuZAwloKOAndfqxDz2gLt1SaZsH1fNnoH3Fo2iO0BFKW01PxcBg/LVBXh2k7yKzNMoLZk0JUEB2HimnbTdS3HggXXVZijhpE9jIv6FNSTb/X+hJfQqpJzTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhvnELd8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhvnELd8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6480DC16AAE;
	Tue, 20 Jan 2026 07:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768895664;
	bh=dtywpyfo8zGST6RB5ITRINgYqOsM26JAXnMDKRpEcJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dhvnELd8NYlUuXA15lXZfDELufQqVoagcWtL3A+pxU/GZZ7/CK/h9PWaJnLWpq4KC
	 nIXhyQgWiLPpppZcLd6SDe76FfCzXvrYw8S5c0LxC2z5jMsHez8kHmw+i9IpsBFjF2
	 fi5ojhi1QLjNNkcUKA7+TKpivlBqaCiE1Qa+cG+iW6HR5WrAI4AFXQo3dFN/McNREo
	 MzycpzgNQFzlU/w7pubEITjbojGpnelnb4k+Sk9qoIpr3Ju+Z7+A0FzI99pqI/IKsR
	 FkY36T6Hk4UKORtl0+b49axcUGkfuRDpsy8LqYF/87vvXj3jD7ukKNjaHSa2ykETAK
	 GHXXMTOHVQ+zw==
Date: Tue, 20 Jan 2026 08:54:22 +0100
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
Subject: Re: [PATCH v2 05/10] dt-bindings: mtd: partitions: Define
 "#{address,size}-cells" in specific schemas
Message-ID: <20260120-wondrous-wapiti-from-tartarus-abf0ca@quoll>
References: <20260119-dt-mtd-partitions-v2-0-77ebb958a312@kernel.org>
 <20260119-dt-mtd-partitions-v2-5-77ebb958a312@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260119-dt-mtd-partitions-v2-5-77ebb958a312@kernel.org>

On Mon, Jan 19, 2026 at 07:48:26PM -0600, Rob Herring (Arm) wrote:
> Whether "#address-cells" and "#size-cells" are used or not depends on
> the specific partition type, so drop them from partitions.yaml and
> define them in the specific partition schemas as needed.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/mtd/partitions/fixed-partitions.yaml        | 6 ++++--
>  Documentation/devicetree/bindings/mtd/partitions/partitions.yaml    | 6 ------
>  Documentation/devicetree/bindings/mtd/partitions/redboot-fis.yaml   | 4 ----
>  3 files changed, 4 insertions(+), 12 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

