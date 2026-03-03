Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBED37DEBD;
	Tue,  3 Mar 2026 04:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772511116; cv=pass; b=dyC48HJIq2DAl6UlSyE6tHQs3+mbPk2kJ7231cSkIZpEpcHvYbza+k6I9j9YfGSfTh4Jrv4xZndWCuBf6kUwOOEp7tgz2AygoSjfnl56Xr61sQtutMDawVxCIvoCH0Ty8Z4dmcezBgnSdi07VlRcvHmP4J2gYzF6j8HrSKiIY3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772511116; c=relaxed/simple;
	bh=TY11tP+fjvCydeVTJmTrTv4lTOv8tyIwbrRjCYcormg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dzg4HQE2VFAFUQnG3w3Dj5Vv+b8uv1pdiiLs8RfHPL38Y6yb5GU0lS3cIi0iZE4VzFuFKLWKgb67mtB/IPBmZuOFX3A39/CIvb3Yw6DFzOdq4hYDnyiLUkDlyMkNlyDac9ym3EJVa1iLNqubqdhQ9mRXoxNczLUhqcQx+UXyADc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=IxM0//KW; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="IxM0//KW"
ARC-Seal: i=1; a=rsa-sha256; t=1772511082; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Nwd9ijqe9wv6K0c1fJjpp7BhOomKu43HENZ9U+A9NHlJQLFetbov2b9WEO6CM5rM6YD3r63aH8daaiHXRVxuolzadDSBBWFMCyIUdQB4l07TUxSKJ5iAmTBBeDHBUuAIC8n543oqABQcjz1nF3Vr+MbpNW7oblg/8SxHjk/ArIM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772511082; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=K+eU4GhIMfoBUPBn8WXtEEB/bAz12IYbwXDw+L/CKZ0=; 
	b=Pv8JAHYoaATi8tchKflcyt62D6M0I4CfPrhuXV6LCvZ3rjyQVkqrtW5PmJv7hZ7WaAfEHJwkOh0cgVZSvWaqtuK2uJYosiFMDT8vqH2xUMPE2vdqwc+iuZZ+pqXoM2NGAyFcLI0mgwJhgyoeygVHmNAm1LzamVLjpvCTHpZtUqY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772511082;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=K+eU4GhIMfoBUPBn8WXtEEB/bAz12IYbwXDw+L/CKZ0=;
	b=IxM0//KWXKzn7VPRtt3fLDCmqrjs+oVOtA7heOxoAFjKb3ew4et/slXb0VPKG+Up
	ZTIP83KQnCKyzRA2e42uPfdE00GCUGts3lkunclkCdESsp6ZCgOLAtJksDREV6xxsWC
	nQm3KpwXHj80F70EznVrR6MdEAQvlq3F2DEc7F/k=
Received: by mx.zohomail.com with SMTPS id 1772511080557943.3150450884574;
	Mon, 2 Mar 2026 20:11:20 -0800 (PST)
Date: Tue, 3 Mar 2026 04:11:01 +0000
From: Yao Zi <me@ziyao.cc>
To: Iker Pedrosa <ikerpedrosam@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] mmc: sdhci-of-k1: add regulator framework support
Message-ID: <aaZfVZoCe3AxTzAf@pie>
References: <20260302-orangepi-sd-card-uhs-v1-0-89c219973c0c@gmail.com>
 <20260302-orangepi-sd-card-uhs-v1-3-89c219973c0c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-orangepi-sd-card-uhs-v1-3-89c219973c0c@gmail.com>
X-ZohoMailClient: External

On Mon, Mar 02, 2026 at 04:13:24PM +0100, Iker Pedrosa wrote:
> Add regulator framework support for voltage switching operations. This
> enables proper PMIC control for UHS voltage switching between 3.3V and
> 1.8V signaling levels.
> 
> - Add regulator supply parsing
> - Implement voltage switching callback
> - Enable mmc regulator framework integration
> 
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
>  drivers/mmc/host/sdhci-of-k1.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

It seems PATCH 4 should be squashed into this one, or the functionality
of voltage switching isn't really complete.

> diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
> index b703b78282ed8d89183c816477c149c0a565618a..c260cb89704ae7a25bec0f07831d495553405bbd 100644
> --- a/drivers/mmc/host/sdhci-of-k1.c
> +++ b/drivers/mmc/host/sdhci-of-k1.c

...

> @@ -291,6 +297,12 @@ static int spacemit_sdhci_probe(struct platform_device *pdev)
>  
>  	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
>  
> +	ret = mmc_regulator_get_supply(host->mmc);
> +	if (ret)
> +		dev_warn(dev, "Failed to get regulators: %d\n", ret);
> +
> +	host->mmc_host_ops.start_signal_voltage_switch = spacemit_sdhci_start_signal_voltage_switch;

Why not assign start_signal_voltage_switch in the declaration of
spacemit_sdhci_ops?

>  	ret = spacemit_sdhci_get_clocks(dev, pltfm_host);
>  	if (ret)
>  		goto err_pltfm;
> 
> -- 
> 2.53.0

Best regards,
Yao Zi
