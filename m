Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D0E2AE77;
	Wed,  3 Sep 2025 21:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756936381; cv=none; b=PcbglegFTi4U4pwTXMRj65IXANSBpgiol55Acv3zTtD0tss1m7oRBvtSiA+oVJuPtR4AEnZPTIGWuro646ehL8a3kebp18bK2o6Az0l9jJg6cSpdA9hU/24GqgRQf+IFWdcOq9WgwF9aGXlQ2SkvxYdlomc2WAl+n+ITowzNFsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756936381; c=relaxed/simple;
	bh=xIp9Re0oOmQ14h92t4+Z5fUJJqI80eHAryoMweGEamI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3X+sO6Q/dIaIXws86YlonYi1065DW72GJC5DikTBE8gHUgt6rtfkKD8VbEIvLZ4mzNE5Qq2mNJRMDV4o48HgxipzyBLdFZOy2cLbWn2epILR9v1HBrgQihTZysIJZyuvYyEAtXhsjdHRcg7bDULA/WmYfdAN6SrfYA6kgbEaVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCu5VNVF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCu5VNVF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772E4C4CEE7;
	Wed,  3 Sep 2025 21:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756936380;
	bh=xIp9Re0oOmQ14h92t4+Z5fUJJqI80eHAryoMweGEamI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GCu5VNVFZNJ43YxR1dN14tLxpugbb3PMY4rryUv4l4GvS2Jvc4AUKC3I51W1OFQ9p
	 5hMkrgqoq93j/VF67sWUYXzzUzaAHd54olEMsN9OQb72ccwp8foRqyXrDmM/57NeBE
	 t/KgzkF9tZfvaGUYevgTw5o9OQmS72zJGfeUTgm23Ck2bHMbcj9O+fjffxSxkco3j5
	 zEcSJ6ESOFmsuC4GNXNi2AUNNyVwOCVS1THK684wf555j/Ya5mwJMJqCHQLRav9a37
	 DmZTEknoCXf9CeMGJdBkZH32ik/tSAYkOObqeGjSbCMGF5z3rXnGHx/D3NShfMuq2a
	 Q3fZSq+IozbzQ==
Date: Wed, 3 Sep 2025 16:52:57 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-mmc@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-pxa: Add minItems to
 pinctrl-names
Message-ID: <175693637687.2903278.2157614494014372736.robh@kernel.org>
References: <20250903-pxav3-uhs-fix-v1-1-9f56b0b54749@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903-pxav3-uhs-fix-v1-1-9f56b0b54749@dujemihanovic.xyz>


On Wed, 03 Sep 2025 12:51:39 +0200, Duje Mihanović wrote:
> Some older boards only require a default pinctrl. Add a minItems
> property so these don't cause dt-validate warnings.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202509030625.PBgLIAwG-lkp@intel.com/
> Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

