Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBEE32E6BC;
	Wed,  5 Aug 2026 06:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785913107; cv=none; b=tFW0a22qzo2fgAN8Wh7Ew17vgGL4lHCxlJe92XnrgRZd6gfirYSrlBoiF3HrspWBibNemSeH+sydYp+VLbu8seJzITNNTJjxBrzWApekzXiIBOEThMTLs09HrthME9WJnqre7pqJC7WSqsUNKKHeTJVAk2xiT72kZkkVpNlEuVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785913107; c=relaxed/simple;
	bh=RbkXrt2k9z768fTNE0nq/5i828KpnnTeZ+ula4wDRZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxDFG//sNB9y672HowFtJ/2Sn9hCt8sAE6AwlNOn2MpUszihobGMXzUdNK8i1nowH6MLqmAWWtoJbrEE/4ffbckpRnLiwcA9lvr4xBWS+Va7RB7fLaqrInVEISnOytSB9zX5adioaWw24YlarDEgKfLgehm5vfuDy6V5Zr8ID3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBQA31Nb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBQA31Nb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1611D1F00A3A;
	Wed,  5 Aug 2026 06:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785913103;
	bh=kxFrzaJr33qm/7SeRWBrrFdarAJHa+Ao0DCkEa/DjCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jBQA31NbjNciVlFu7ufhxf5OYBtmCQ7gcOuLlkGymIjBclSAwjbNt4Zo6BxSRW52L
	 BhxMDGnznejqtOL3IsWOtnP2gyc6OPxEgGm3IV0x4C1TSk5aGymx5JyD0b4vgCmPp+
	 g2GAohWP9PK79T1QL1jTjLTLi6XLzkIlWH+aFIA4ZOzrso0HnmB4hni1NZXmQTb7PZ
	 GWcN7w5zXLEg4k2TvUkSb0QpngddNOoLC1HnYEeoWfMkALUQ3cqrwLue5CRrL1P++g
	 FCv//uIK6AzRc/pFjAtOz9k1KORak1jf6wbUpYkLzjbKhUQ4jVOICYObTf+XllZG48
	 RPugTd8W45+CA==
Date: Wed, 5 Aug 2026 08:58:20 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: Ulf Hansson <ulfh@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Avri Altman <avri.altman@sandisk.com>, 
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>, Erick Shepherd <erick.shepherd@ni.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] dt-bindings: mmc: Add reset-card-at-resume
 property
Message-ID: <20260805-lorikeet-of-marvelous-wholeness-ca84e6@quoll>
References: <20260804203818.881765-1-kamal.dasu@broadcom.com>
 <20260804203818.881765-3-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260804203818.881765-3-kamal.dasu@broadcom.com>

On Tue, Aug 04, 2026 at 04:38:17PM -0400, Kamal Dasu wrote:
> On some platforms, firmware or other hardware accesses the card
> during suspend/resume, before the kernel's own resume path has run,
> leaving the card in a state the kernel can no longer assume it knows.
> Add a flag property so such boards can tell the mmc core the card
> needs to be reset before it can be used again.
> 
> This is expected to be paired with keep-power-in-suspend on boards
> whose firmware needs the card to stay powered and live throughout
> suspend: since the card is never power-cycled, nothing else would
> force it back to a known state on resume.
> 
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

