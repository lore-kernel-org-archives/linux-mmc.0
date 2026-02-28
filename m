Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B63A12B94;
	Sat, 28 Feb 2026 10:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772273576; cv=none; b=FLsh1W2lPmsC2QY7lUEmP9exlNa0UuIMLMPTzzh0CmBzSLDME0weIy8s/9YOnzYwnZ1HY3teiHL5T+QkmgT+uInaUjnst1AY6SPMWiEQNch+7MsNgXmizO8T/E+jlMMfbMAqcIfsx9GutpOAu2JFyMnzJmy7jj3nSERZ3vst1m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772273576; c=relaxed/simple;
	bh=Wyd/XL1w2AqP4PQ2aLzCjy6EZ0rWFJ6/fVMDwvM4h40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfyYSsdExeWoZMm8vugvcqChOgCOcDWFVosKmo56fMzeg3xpNcdpaqH90ZDSQeun89LqxiNXM2oBrDIrjLijRl9++HGkp+cZgwO9MMSum0oXSjAnDgtcoadgaJAAu2QeynuMSJ2E6f40X2BKcjCt8dF9BDX8M0AhppeX/defJlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaYhH3br; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaYhH3br"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F494C116D0;
	Sat, 28 Feb 2026 10:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772273575;
	bh=Wyd/XL1w2AqP4PQ2aLzCjy6EZ0rWFJ6/fVMDwvM4h40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JaYhH3brmyBLj65Rz+wBOkADmItRpehvX+EIYcMuIofweofOF2HgKK1EELKXNinW3
	 WyMdjesIfpSXwb6S/KUfm5fTFrYGIUOU6GpNoR2T3JbiO1ZNQMF1fck/bybH7OM1eU
	 h4wMwkIlGafCWzVyux3bHtYqPQHYYrOFI/hDXp6UAB+zSWwy92IuzraNXayLws8VIv
	 4gQvWRba/XEdaxLM7fPSCZu9MxBKOYJ8N/GubCtqVJ2XGVEPGj1ED7cMDk/p6SrEyT
	 6ogPRJtbnJcmJpvMj/BHPXmY6eLwb9gxUjk/Li41pM0L41yDDtKPxzPE8KuxA4DWL4
	 5sn4pINItIEtg==
Date: Sat, 28 Feb 2026 11:12:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "ping.gao" <ping.gao@samsung.com>, ulf.hansson@linaro.org, 
	jh80.chung@samsung.com
Cc: shawn.lin@rock-chips.com, krzk+dt@kernel.org, robh@kernel.org, 
	conor+dt@kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kwangwon.min@samsung.com, hy50.seo@samsung.com
Subject: Re: [PATCH v4 1/3] dt-bindings: mmc: synopsys-dw-mshc: relax clocks
 constraint
Message-ID: <20260228-pygmy-cricket-of-chemistry-54a9ea@quoll>
References: <20260228062457.3210099-1-ping.gao@samsung.com>
 <CGME20260228062024epcas5p4a9f901ea58ead972a352cb4546464c1c@epcas5p4.samsung.com>
 <20260228062457.3210099-2-ping.gao@samsung.com>
 <69da7192-e2c5-407c-a8d5-4739d10197f5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69da7192-e2c5-407c-a8d5-4739d10197f5@kernel.org>

On Sat, Feb 28, 2026 at 10:44:03AM +0100, Krzysztof Kozlowski wrote:
> On 28/02/2026 07:24, ping.gao wrote:
> > From: Ping Gao <ping.gao@samsung.com>
> > 
> > In some SoC designs (e.g., certain Samsung Exynos platforms), the Bus
> > Interface Unit (BIU) and Card Interface Unit (CIU) clocks are tied
> 
> Again, no.
> 
> Read and respond to previous feedback. It's like third version where you
> did not do it...
> 
> Samsung Exynos platforms have all two clocks. Look at the sources.

And to clarify before you respond "but my downstream Exynos 999999 has
one clock": downstream does not exist. We don't care about it. I advise
to fix your downstream if that's the problem you are having.

If you keep sending the same for sixth time without responding to
feedback, I might get inpatient and NAK it without giving arguments,
because I already feel like this is wasting my time.

Best regards,
Krzysztof

