Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AA62AEF5
	for <linux-mmc@vger.kernel.org>; Fri,  6 Mar 2026 02:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772762484; cv=none; b=KmV6pprLBADdmwqownoEbMZbGDOUSPhHCu00qTeN6vtd9XRV5ELjUCe+BsNsOxTfg75PsKZ/plV2mM6kz6ofbc0QF4DewXhkzyjfpmGCPP+8kYlzXuI0e0aMDR+LN0SHlW+Il1+8VfUEsSkY5OmzfqcM5SaptOk56B4ZPSXKYHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772762484; c=relaxed/simple;
	bh=tczAGiLTNTlVkAfIKqbcrO1sCTnpBRXtkEo0FQkD38A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=g98rguavbbpxF15DT/U7xXR8UgkctDVdOVS8VkbHBWm9+VeRUjWr839FxQaedffE4bE49YSWgCfK9JZDdDdYrg3PbT7qFpdw0kU41ftDg8e9+JN3NGUrGEXVMU7RpbGhGKeb5fElCF+m17mIlvXsAgCAt9FEAL6wLiJU/uBNYPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Uy3ZW8Ej; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Uy3ZW8Ej"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260306020114epoutp02696064d887b0cf917429b2b98248314b~aHhP-J3dm2640326403epoutp02I
	for <linux-mmc@vger.kernel.org>; Fri,  6 Mar 2026 02:01:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260306020114epoutp02696064d887b0cf917429b2b98248314b~aHhP-J3dm2640326403epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1772762474;
	bh=NWgQzFAZ28BnLYaVoO5JZ4Bx3J4LTL+fK+YOPVejmnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uy3ZW8EjXifLibGzcgt1AF0jjDhvQB1HCXnFGlUMj5uJjKw7AGi+ysDX6X0QI69sP
	 j1cl8AgqS5Sh8/U/3BwbS84d826vGuFFCvXP/cR5NvrzsAdFh+vXe72yz1nFdkErU1
	 IWenD6ahqFLkmTAKS3qv2m9+Flz8LiAVG9oJ91KU=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260306020113epcas5p12aa5e30ac8c1a4faae2c1b332cba14c7~aHhPc_Xvp1914119141epcas5p1E;
	Fri,  6 Mar 2026 02:01:13 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4fRqQ16nGyz2SSL5; Fri,  6 Mar
	2026 02:01:13 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260306020113epcas5p1a94d06c1ae38ada4be86abb940996eb8~aHhPOUhfY1914119141epcas5p1D;
	Fri,  6 Mar 2026 02:01:13 +0000 (GMT)
Received: from hzsscr.. (unknown [109.120.22.104]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20260306020112epsmtip21b68d36c0be880fe0a561e85e01af3fc~aHhOcjwdH1287412874epsmtip2H;
	Fri,  6 Mar 2026 02:01:12 +0000 (GMT)
From: "ping.gao" <ping.gao@samsung.com>
To: krzk@kernel.org
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, hy50.seo@samsung.com,
	jh80.chung@samsung.com, krzk+dt@kernel.org, kwangwon.min@samsung.com,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	ping.gao@samsung.com, robh@kernel.org, shawn.lin@rock-chips.com,
	ulf.hansson@linaro.org, kwmad.kim@samsung.com
Subject: Re: [PATCH v4 1/3] dt-bindings: mmc: synopsys-dw-mshc: relax clocks
 constraint
Date: Fri,  6 Mar 2026 10:05:56 +0800
Message-ID: <20260306020557.3809453-1-ping.gao@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260228-pygmy-cricket-of-chemistry-54a9ea@quoll>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260306020113epcas5p1a94d06c1ae38ada4be86abb940996eb8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20260306020113epcas5p1a94d06c1ae38ada4be86abb940996eb8
References: <20260228-pygmy-cricket-of-chemistry-54a9ea@quoll>
	<CGME20260306020113epcas5p1a94d06c1ae38ada4be86abb940996eb8@epcas5p1.samsung.com>

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

Hi Krzysztof,

I apologise for repeatedly submitting patches that did not address your feedback on the
Exynos clock architecture. My earlier patches assumed that some Exynos platforms
use a single clock, while, as you correctly pointed out, all Exynos SoCs expose both a
BIU (Bus Interface Unit) and a CIU (Card Interface Unit) clock.

I regret the oversight and the extra time it has taken you to point this out several
times. 

I appreciate your patience and the guidance you have provided. 

Thank you for your time and understanding.

Best regards,
Ping Gao
