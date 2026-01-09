Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C537C3559D4;
	Fri,  9 Jan 2026 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949096; cv=none; b=VQgyKFf7hvaRjQIpLgqP/AGPk4Joeg1zLl8tStYfQJJG5ElZSnwFShTSnD4A+b6VIa4+ZfWIkHKzpEhRIcnjsX8vXW+CGE2Z25EoWu+WrqKqJRtLcNThJGCL9vibqWgzw8f3SQun64JPk6vlpimGtaPIqZCanNd1evyz0Zp77E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949096; c=relaxed/simple;
	bh=ojRtnWmofiQARBjo7qW80usOLanqMK69sII42EyQ+c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DV8HLLfR4sapoMntvjY9pJhsSosr6iCCmh0Ly0F1qjuaS0DlGkchhhdgDats85NWzgT4NIP9wnK/nCVgpsv/P9qDQfsDQJTgqHIHJVpNoL/7OLBJXhMitPY90y3shCbcy9dEFZaKlJOIG9Cx0/nZA52g7hJXw44khGtQTaXRGMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nb0ayqB/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nb0ayqB/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52239C16AAE;
	Fri,  9 Jan 2026 08:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767949094;
	bh=ojRtnWmofiQARBjo7qW80usOLanqMK69sII42EyQ+c8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nb0ayqB/SCXA98L61KR3yBuhxUIb5T3KqLoO9s1MORr+OPktlhNuvICzGLOC7RNJy
	 F6Mmi6hEisoKXaZXsXVEGq46+lPrjwncQfvVVajBz2FxVRki4h4tVdAd4xwiGkLiDu
	 6dcK3LmWBm3bguWgXvIKRbhGoVY8hGZHaztObxn8q638ywiikcnw993nvWpmXXxCk/
	 U+zrptLJ0zUnT+bzAdNcrstJ+tUeC9cwNoSQbNWYZFFK3aznWhAmYIvWNE3Azv2HwP
	 4krcHSEvQdt+SfcPvPt8vHgI0IfrLvwkaZwAZitTOAzormvp0N+uOttVJWIHabvWG7
	 Em8XymrfSgC1Q==
Date: Fri, 9 Jan 2026 09:58:12 +0100
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
Subject: Re: [PATCH 02/10] dt-bindings: mtd: fixed-partitions: Move
 "compression" to partition node
Message-ID: <20260109-didactic-knowing-buffalo-528062@quoll>
References: <20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org>
 <20260108-dt-mtd-partitions-v1-2-124a53ce6279@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260108-dt-mtd-partitions-v1-2-124a53ce6279@kernel.org>

On Thu, Jan 08, 2026 at 11:53:11AM -0600, Rob Herring (Arm) wrote:
> The "compression" property is defined in the wrong place as it applies
> to individual partitions nodes, not all nodes.
> 
> Fixes: 8baba8d52ff5 ("dt-bindings: mtd: fixed-partitions: Add compression property")
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/mtd/partitions/fixed-partitions.yaml      | 18 ------------------
>  .../devicetree/bindings/mtd/partitions/partition.yaml  | 18 ++++++++++++++++++
>  2 files changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

