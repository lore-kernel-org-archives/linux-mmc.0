Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E70842E8E7;
	Thu,  3 Sep 2026 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431360; cv=none; b=cRRdpoEtx7BEKXqVzbJXs4bo3z69QaNneAL4Kh2eWOyE6ByLIRZy6hJvtVJceyT8FwbeTfCjbvQE3eMaTGzcMAEK1vmO6X9JfYHKYcqG7jsZRw/SzHw4NwEbI7GhvBgYF3X/LNdcJsrQE9uQH5F2MIWL/WUg6cVXDX2HFnkT+YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431360; c=relaxed/simple;
	bh=qNzl1taBMBLHaW3n3XEpadKSIx7K5y09i1Y68j+mhq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRL+WGSgbXVStDkliKfNWh9Lx0r7rByQzufQpfducc29OvhRRfqH2dDZ45cpGAvYBCLNjBM4E4RGF24XMmefmICd7eyWhS5Ejf3sJs7G5xXpmik/bqGKuA5jhEpZAtUZjnmiS6YVUX22XY/KKg35h3AZ2P+7JNghT6KW4dZkeiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a64GfkJl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a64GfkJl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BE31F00A3D;
	Thu,  3 Sep 2026 10:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788431348;
	bh=Xl6S+lrfej0E5kqwaHD3xh0FXNTExpQMqDVcQS859OU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a64GfkJlH7aSPaW1PZ5YurY5GcRkZ75SkIo0aEr+LmN2Gb0G1XQFNUPIYFBjBFNDu
	 +Ioh3VkWf6xEUr2oEMEk5yVcXOYGHa9Xy5lHHs1I5JpzOthfyFcjeEjvAVEK1bBGaA
	 B0UyR5A6tIkM8oKdS2ROuugbsXFmYF76UPTEgCOL+/xrRgk+iOiWPdOiJT1MDMFGiB
	 zmzSKKWNuA38FgtOrQw8Lzo3GIwXEkbobWIubk69vChTlIwedkcprZNm0zgpfNIaYC
	 Oalb3M0AEQKG88a8JzW4NEHCj107BfwSqhZ3pz2th71p90vZEo8R6wA7eB719wZV0L
	 y0gXsGpewocjA==
Date: Thu, 3 Sep 2026 10:29:05 +0000
From: Yixun Lan <dlan@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Long Wan <long.wan@linux.spacemit.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mmc: sdhci-of-k1: Set clock-frequency of io clock
Message-ID: <20260903102905-GKB1974@kernel.org>
References: <20260902-07-k3-sdhci-dts-v1-0-4e7909cf4233@kernel.org>
 <20260902-07-k3-sdhci-dts-v1-3-4e7909cf4233@kernel.org>
 <DL5D2ETDDPX1.3QTJ53KUA3JED@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DL5D2ETDDPX1.3QTJ53KUA3JED@linux.spacemit.com>

Hi Troy,

On 11:29 Thu 03 Sep     , Troy Mitchell wrote:
> On Wed Sep 2, 2026 at 3:03 PM +08, Yixun Lan wrote:
> > From: Long Wan <long.wan@linux.spacemit.com>
> >
> > Add a clock-frequency property to set the rate of io clock, for SDIO
> > case, a clock frequency need to propagate down early.
> >
> > Signed-off-by: Long Wan <long.wan@linux.spacemit.com>
> > Signed-off-by: Yixun Lan <dlan@kernel.org>
> Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> 
Thanks for looking, this patch is obsolete, I will drop in next version

-- 
Yixun Lan (dlan)
