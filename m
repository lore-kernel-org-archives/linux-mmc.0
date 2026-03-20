Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24D92F3600;
	Fri, 20 Mar 2026 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030126; cv=none; b=uNnFG5KtW/FFXAjA9x8eknjOgeGqKL4ZWyef68tp+XHlyjHDxymG3YQ2vETdxoIIVm2bg0Iz5XpyItfWd6IcXVKb4E87egSLnzi2HUjp+qn4eFm+YuSo/GrpRKLphv4g47UcPUhCi7dbEKqtMo20ZafChqI/eta1Pj0jgfL2Ag4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030126; c=relaxed/simple;
	bh=j9oGe19p6enAP415iQkzVWqOBaxfa7xflEVYIfasXJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+KpZsww4FbKrt33ewXXWm1KM9/kzCYhJJN0VoPdOUqpJQGm3Ijw3Fh8dj680rAsoCyvsoIHlQPWKLay/zX4GqzCe4YSQxM549GzW49KPlv51FfhypvFvDDhBcPu9rJ+jVuUQN1Xgz9hi3w1W/xHB37p04z8VGQGip4wfoJCaC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AGKpWvrz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AGKpWvrz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774030125; x=1805566125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j9oGe19p6enAP415iQkzVWqOBaxfa7xflEVYIfasXJo=;
  b=AGKpWvrz1HldKkPIxxV/5H6+4A21K5tXsFu7iffKQ9N3yHLyCxwrDPWL
   P9x3Fr5lDmLYs/vPhrRNv9EniFdKLJARCQWvfoxVsigiVh6i/nlJlOen9
   HMfqUlN2e8yIA3ssTvBh0Qv70HfgwDIDk9z1PQWwQjVRc3Gxq+qa2ilfi
   jgeTFm/X7LMuvQCt5xzpDYTSrr+LT+1ZQVA1OsrKzUnRUjwFmZg3l8qXx
   GzcyFSIQqCEtRkbXq4YQIjE04Rj3cqYmq/l4Z6yy4bOT8R1v8hD1sXo/s
   XJNNdkKeipOxM9SD2ONUM17z7nagUluTLqApVFD7AmXzZzf9ajie5cezE
   w==;
X-CSE-ConnectionGUID: nlJrmZDvTZ+nHPqZNpIlZQ==
X-CSE-MsgGUID: NuSe/VMlTgyHK6qifkCu0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="86598713"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86598713"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 11:08:44 -0700
X-CSE-ConnectionGUID: 9mV0v22VRB6sip7foNc4YQ==
X-CSE-MsgGUID: ag0aja+dTSOaxc1+CcNipg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="225255084"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 20 Mar 2026 11:08:42 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id A917498; Fri, 20 Mar 2026 19:08:41 +0100 (CET)
Date: Fri, 20 Mar 2026 19:08:41 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nelson Johnson <nzjfr547@gmail.com>, Hans de Goede <hansg@kernel.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 0/3] mmc: Lenovo N22 Braswell SD slot fixes
Message-ID: <ab2NKT4uioc8O-7-@black.igk.intel.com>
References: <2cb3de9f-2c07-48c6-a3e7-63d34b49ca32@intel.com>
 <20260320164753.536-1-nzjfr547@gmail.com>
 <ab2J-MrwPAQ_BjGs@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab2J-MrwPAQ_BjGs@black.igk.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 20, 2026 at 06:55:04PM +0100, Andy Shevchenko wrote:
> On Fri, Mar 20, 2026 at 11:47:53AM -0500, Nelson Johnson wrote:
> > On Fri, Mar 20, 2026 at 8:27 AM Adrian Hunter wrote:

...

> I kinda tend to agree to make patches go in. We have tons of Bay Trail

(Same applicable to Braswell and Cherry Trail (Cherry View) devices.)

> machines from recent years and they are still supported well enough by
> vanilla kernel (thanks to Hans).
> 
> TL;DR: I can look a bit closer and review the patches.

Okay, after looking closer at them I think it feels like a hack approach
(or one that is done in a wrong place). If you read my comment on patch 3
the ACPI enumeration and PM domain is handled there. When device is present
in both PCI and ACPI in accordance with ACPI specification, if I am not
mistaken, it should extend the existing PCI capabilities. I.o.w. if any
contradictions with PCI resources or so the PCI should be taken as correct
ones.

Cam you share ACPI DSDT excerpt (from DSDT table of firmware, you can get it by
copying file from /sys/firmware/acpi/tables/DSDT and decode it with `iasl -d
DSDT`) and output of `lspci -vv -n -s $SDHCI_SLOT`? Because it might be that
the problem should be solved just by providing better fixes to GPIO detection
or so.

-- 
With Best Regards,
Andy Shevchenko


