Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4053CC7CA;
	Fri, 11 Sep 2026 09:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120158; cv=none; b=QBqgUw9bw4B0HDChv7rph+d0C5iPsIxtFAgmbiU/9yXUy0RZWgPTDm6wMA86MXn94OuOXaRPMxBfNp8YafOIG+X57qlNpELGQwhrQ4rb12tfW/TVMd8yF493zjtcqnbu8ACWIfiNFY3vOjZb8BNBnHI+NvYUrpmMH084GnTTS9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120158; c=relaxed/simple;
	bh=qx268NLrHhuGhviZiNPFDc36sFBiuKSQoW6e2WXDB1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwMagZl/PuHARKqMuU9CTg08Bwo1dlSkBr/gZCDGrX+j/p4XbkpVgqWMbv2qVeo81UstQn3eFqw2r9X6pkmmmdB8TbJVL9NhwvMJ4HTOcGvKEon2Syz5Nw4qbamv1xG+/QBmSkYmGAQxx9KZ3dW7CUDxsNCgbDiEvXe8qaKWVMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJGzyjXX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJGzyjXX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF481F000FF;
	Fri, 11 Sep 2026 09:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789120156;
	bh=6iSyyl3v50z+WchOw/IzvU15q/CBl73uNaobF2OoGP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SJGzyjXXWpn8rhgey8YchWNZupeB4i3jQBZJUNZlcdqQHKU1x7/8racbZ5M37Zagb
	 LRI5Zla3L0I7t8PYSyakYY4VnxlCCCUzsqtSlj10SvMGOWk+sEDR0e5sF5KCl2/eN6
	 R8FTpiTLiNHoxMtZRQyugij23s/Nf4SeamFzd2pwVBpr6b6iiwOb9bk6jjghDBKbBl
	 lTu21zckN6KVUZVYLyBCkRw5Mm+a5ALGFexZ01zvZSSPkXZnQTLJjuWPgjMZ4YEU8c
	 Dfz+2+PBE7zsn/ONv2NNTeUMmkHnt+x4VksFO/xyZXkvCplczimQD4LIZ70JQgzauf
	 73Ocn6Zyee8EQ==
Message-ID: <2de9b4cb-4b26-4435-b991-5f716b825abb@kernel.org>
Date: Fri, 11 Sep 2026 04:49:14 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v7 0/9] mmc: sdhci-cadence: add SD6HC support and Agilex5
 enablement
Content-Language: en-US
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 linux-mmc@vger.kernel.org
Cc: ulfh@kernel.org, adrian.hunter@intel.com, krzk+dt@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260901184828.15653-1-tanmay.kathpalia@altera.com>
 <e9559842-8283-457f-97d4-02752f1ed850@altera.com>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <e9559842-8283-457f-97d4-02752f1ed850@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/11/26 02:35, Kathpalia, Tanmay wrote:
> Hi Ulf, Dinh,
> 
> A gentle ping on this series.
> 
> All comments from the earlier revisions have been addressed. Patch 1
> carries a Reviewed-by from Krzysztof Kozlowski, patch 4 an Acked-by
> from Conor Dooley, and patches 6-9 an Acked-by from Adrian Hunter.
> Thanks to everyone who reviewed it.
> 
> Could you please pick up the patches that belong in your trees?
> 
> Both dependencies noted in the cover letter are now in mainline:
> ab45ecfab540 ("dt-bindings: reset: altr: add COMBOPHY_RESET for
> Agilex5") since v7.2-rc4, and 10cf797f3f8a ("arm64: dts: socfpga:
> agilex5: Enable the SMMU") since v7.3-rc1. The patches were generated on
> mmc/next, which predates both, so those commits need to be merged first
> if the DT patches are applied there.
> 
I've queue the following patches locally, but waiting on the SDHC 
maintainers to take the driver portion.

[2/9] arm64: dts: agilex5: add SD/eMMC host controller
       commit: c2b598317688f8e599bf6ca048863db311482450
[3/9] arm64: dts: agilex5: enable SD card on SOCDK OOBE card
       commit: 65a8ab194ffb427bd2ae37a1da54710eddf10845
[4/9] dt-bindings: arm: altera: add Agilex5 SOCDK eMMC board variant
       commit: f78580fddb9b9d39eaea23f847a53b0ce974687b

Dinh
