Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F803BFE46;
	Thu, 15 Jan 2026 17:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497911; cv=none; b=n3yargCxnR0E/6FF55vV2GykYk53+4YnuYqeJ61sYI3Df68nvmcQbMfxAgXPaFtnRPSB/HV1ooYe9S3IBoXk7VYpSGwSiJTehYIkIEN2W1QWimxo05z0Ac8iCtFicSqirO+vTrBgqiOOwZDWEhBAzeY58Cgs+Rz/C6TgtJSST1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497911; c=relaxed/simple;
	bh=F301zU1vCBsJJwhbHsinIGYvb2uYINoBUeXNJkJ9o9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCNM3BEQuAMd9c1y6AEzs3XR4TnTqo0OqIB6Fsne+Y89lTkJIiD0tB2lfmp0qILpQMR5fqhyDuqusTXAsxIRorfBkwdWkrStsK1/oVMqMJeJg6UAy5OM4a+IpykCT26vG6GMPfgRli9vpXsiquzMBRaAK82mvqZv4iN3Z2Z8OhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5NEArbr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5NEArbr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C42AC19422;
	Thu, 15 Jan 2026 17:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768497911;
	bh=F301zU1vCBsJJwhbHsinIGYvb2uYINoBUeXNJkJ9o9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W5NEArbrEFalAlEMGWfQYfz8F8ozBniK0/E+j/Xcyee57fhbtiuM3A5wqwTQo/kSE
	 5Qmt0iocmyAhTCgyChCXJHqcPxZ2m/M8LIP/x4OGtPexlhrD+cKG9YZ81e1S9grPMa
	 03Kj7oFRSssmrzo4j/PSnDusZ4YuSXnTf8aVYLYiP9FRqMxnGTYwcXjkYNfn+qBzA+
	 bKZxNUG3l2JYlly1CP4LjTMQ3MXaudRSab6U/F748Yy3RIdHnGOB3DoenjNOqZet0M
	 qU3Pl/vFg/SnxGqhCWJS9o9SNnRhpsudlk/IDY6Ss0GvRL78wVOPVCOC3xIXd3lqBi
	 6XGHYJhCcz6Iw==
Date: Thu, 15 Jan 2026 11:25:10 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Francesco Valla <francesco@valla.it>
Cc: linux-kernel@vger.kernel.org, Saravana Kannan <saravanak@kernel.org>,
	linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] of: property: fw_devlink: Add support for "mmc-pwrseq"
Message-ID: <176849790816.916369.13545562565648281883.robh@kernel.org>
References: <20260110-mmc-pwrseq-v1-1-73de9d6456f4@valla.it>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260110-mmc-pwrseq-v1-1-73de9d6456f4@valla.it>


On Sat, 10 Jan 2026 16:27:59 +0100, Francesco Valla wrote:
> Add support for parsing MMC power sequencing (pwrseq) binding so that
> fw_devlink can enforce the dependency.
> 
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
> Resending this patch as it slipped through the cracks (of my attention,
> at least).
> 
> Original submission is at [0]; there it appears as a v2 because it was
> the first time I used b4. It was also part of [1], which wasn't really
> a patchset but a follow-up to the boot time SIG meeting.
> 
> I added Ulf and CC'd the mmc list, hoping they can (more
> authoritatively than me) reply to Saravan's question:
> 
> """
> I took a quick look at the documentation. It's not clear to me that
> mmc-pwrseq always points to a supplier. Can someone with more
> experience on this confirm that is what it's supposed to point at?
> 
> Meaning if A lists B as pwrseq, is it always the case that B needs to
> be powered on? The binding documentation doesn't say anything about B
> needs to be powered on first. It's just saying A and B have an
> ordering requirement.
> 
> If the meaning of the binding is _ALWAYS_ B needs to be powered on
> first, then yes, this patch is correct and I can give a reviewed-by.
> """
> 
> [0] https://lore.kernel.org/all/20250930-mmc_pwrseq-v2-1-80a8c6be0fb0@valla.it/
> [1] https://lore.kernel.org/linux-embedded/20251126-beagleplay-probes-v1-0-c833defd4c9b@valla.it/T/
> 
> Thank you!
> 
> Regards,
> Francesco
> ---
>  drivers/of/property.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!

