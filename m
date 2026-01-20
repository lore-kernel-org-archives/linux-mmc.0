Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6BF33D50B;
	Tue, 20 Jan 2026 07:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895687; cv=none; b=VlS0CidMTEPl4GwRRn5iRAZoFNSAC8byXB0QRVtHsyywxHhJZD3kp3VdE8JZAQeAsGMIM54JP59RAcCO8Ycy9xGhOWTfvUsY8hCva2zGNmX0UeCT6BKK3z77/vOinBfgSuNQgnCAxVqCoBo9iGSfB4wLVI1rFwQh3HBG/Uxyjw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895687; c=relaxed/simple;
	bh=B726PHTSmFoDDIvtou6n2TxR0c1xXbiJY524zsjJtpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sy7fpomTkyho7QvIG0HoSdheFBeK8cl0jDCHVezJHmMf0anNvmK3eJnEJakarRvKBy1Idej7KsI7DQptt8fjK4YVT18E+Qbs3e98p4/N79hWCyxq8xXbizQt0Oy9W1ZvrdysG4ujQSrA3wHEDWd5xN0PHBIJDK3EhN1CoT8cU5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0C6eT+9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0C6eT+9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F985C16AAE;
	Tue, 20 Jan 2026 07:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768895686;
	bh=B726PHTSmFoDDIvtou6n2TxR0c1xXbiJY524zsjJtpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H0C6eT+994EWlYBN33+wT2pGsYHsDgja6wB3ZmJcS8QQAeSIinXoiartbKEzfPZAi
	 IfDUu5MoQ5sQrnfa2tdGy3frZrkMgsM9flVupYVy3J8umUc2jwa9Wgams+vfJgLdVr
	 4edxaL24YiiBITeEarfWWqOjszsdvy0on8c7pdpQGB7/MrsEGgS3l+wR+NcSB12u4+
	 eIlS0x4Av9Wzl8hTr7cSaTNLBwivl2zF7pRz4cxgThRykeEupIEqX8WPJCQEdHva9J
	 hPFLeEU41UFX4KJpIODM5XUvjkrNqS2HhOxOT3vHHx0Ud/YeDSCn5d5TiMJEgshkrC
	 Xix/LScERsVfw==
Date: Tue, 20 Jan 2026 08:54:44 +0100
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
Subject: Re: [PATCH v2 08/10] dt-bindings: mtd: fixed-partitions: Restrict
 undefined properties
Message-ID: <20260120-lime-nautilus-of-promise-8db3a2@quoll>
References: <20260119-dt-mtd-partitions-v2-0-77ebb958a312@kernel.org>
 <20260119-dt-mtd-partitions-v2-8-77ebb958a312@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260119-dt-mtd-partitions-v2-8-77ebb958a312@kernel.org>

On Mon, Jan 19, 2026 at 07:48:29PM -0600, Rob Herring (Arm) wrote:
> The fixed-partitions schema allowed undefined properties in order to
> avoid warnings when there are nested fixed-partitions.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/mtd/partitions/fixed-partitions.yaml       | 7 +++++--
>  Documentation/devicetree/bindings/mtd/partitions/partition.yaml    | 2 +-
>  2 files changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

