Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3F737649E;
	Wed, 15 Apr 2026 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264721; cv=none; b=sUijsaizwebqE4Iuexg8QAGcxQWFil3SPJ+PgiFYFMuuCGYnTDJ8h8/98rlfGTvGQbG7MtfEY3gZb24wNHzRYCA6lp3AEeeeEf9lNAWA2FpiQFBDNNHllYEtr82eF36ExStTZbvaybhJmSc2AH0WZfxCRa5waKPdbE+/Gsai6VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264721; c=relaxed/simple;
	bh=HggK1B0z9LDqrpUWBaxTvrXS4T07TEvhJ+nJMdpve6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFmQRJQj+Pz26wJzs2kKDq25L7oTe0TTHoCrfg1QAi7kfw73lp4XHinXW7mJ0BwzKWJb3b/fDhkIuivMCSERVlfIrsHhMsuosaJyhmVSK+MCpGfFInvg0mp1RfSFkChhsj5S1vsPY0FW4BOXulliLF0uAJ0n27GZTT6kLoZbj5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YfKTQ3o2; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YfKTQ3o2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776264720; x=1807800720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HggK1B0z9LDqrpUWBaxTvrXS4T07TEvhJ+nJMdpve6Q=;
  b=YfKTQ3o2S97ykaHskXgpyPljaCyZRpoL/Jz+VHn/BKR+6Uj2WdGOsHeY
   LzuF/h3U7Mjm2xGrYGeEGwkRJh4TE5ZFHiZzcjGOFux/JFb9xbDjpkgm8
   7/nbYybEQtoyd0ND7x8Unvvxb5olnlhITBbivt8ITRRnoHIaU65aXZ6Zy
   kC52z2cAt+yPi1Ha1SkZry7pg0zi7xe9bca85wEKdPwjg+qd29GUFF30E
   btNRjAlMD4kPE+HALnX/HzMbtZFNAyoS+Ev5G8rASvL/dbdxL2AMVFYeU
   CfSN2nSFLCyo3FgEt3jMo4y2nW2vcQZR6e2t1AzDv9Iw542ye0BxUuVPq
   w==;
X-CSE-ConnectionGUID: IWhzps7zSVW4W5xwSCa47g==
X-CSE-MsgGUID: ZcKRl9YpQXKEJHrsjP97FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77218751"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77218751"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 07:51:59 -0700
X-CSE-ConnectionGUID: IlxtgxlfQQic8MYP2GxAKQ==
X-CSE-MsgGUID: gccNdDrlRG68wWrRCHPJ8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="260865359"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.34])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 07:51:57 -0700
Date: Wed, 15 Apr 2026 17:51:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: Jisheng.Zhang@synaptics.com, hehuan1@eswincomputing.com,
	yifeng.zhao@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: add reset control support in
 suspend/resume
Message-ID: <ad-mCsvOWWgqt-rc@ashevche-desk.local>
References: <20260415123411.437450-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415123411.437450-1-a.shimko.dev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 15, 2026 at 03:34:10PM +0300, Artem Shimko wrote:
> The driver currently handles reset control only during initializations,
> but does not manage the controller reset signal during system
> suspend/resume. This can leave the hardware in an undefined state
> after resume. Additionally, the reset control is stored in vendor
> structs making it inaccessible for power management operations.
> 
> Move the reset control to dwcmshc_priv structure and add proper
> assertion during suspend and deassertion during resume. This ensures the
> controller is properly reset before entering low power state and correctly
> reinitialized upon wake.

...

> ---
> 
> Hello maintainers and reviewers,

No need to repeat the commit message in the comments. It does not add any value.

> This patch adds reset control support for the MMC controller
> during system suspend/resume.
> 
> Currently, the reset control is only handled during initialization and
> is stored in vendor-specific private structures. This makes it
> inaccessible to the common power management code and leaves the
> controller in an undefined state after resume.
> 
> The changes move the reset control to the generic dwcmshc_priv structure,
> update all platform-specific users (Rockchip, EIC7700), and add proper
> reset assertion/deassertion in dwcmshc_suspend/resume.

This is serious behaviour change (might not be, one needs to understand what it
does in comparison to no reset (and in accordance with datasheet).

Do you have any HW to test?

...

>  	clk_disable_unprepare(pltfm_host->clk);
>  	if (!IS_ERR(priv->bus_clk))
>  		clk_disable_unprepare(priv->bus_clk);

The driver seems can be refactored a lot (with no functional changes) by:
- replacing *sleep() with fsleep() API
- dropping unneeded checks like above, clk_disable_unprepare() is error
pointer-aware IIRC (or it can be made so it is either NULL or valid one)
- using 'return dev_err_probe()'

This is just a side note in case you are interested.

>  	if (ret)
>  		goto disable_bus_clk;

...

> -	ret = sdhci_resume_host(host);
> +	ret = reset_control_deassert(priv->reset);
>  	if (ret)
>  		goto disable_other_clks;
>  
> +

No need to add an extra blank line.

> +	ret = sdhci_resume_host(host);
> +	if (ret)
> +		goto assert_reset;

-- 
With Best Regards,
Andy Shevchenko


