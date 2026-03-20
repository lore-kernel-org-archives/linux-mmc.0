Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904423D8101;
	Fri, 20 Mar 2026 17:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774028999; cv=none; b=jqE4b9SbtvAt2W4bm7mu+RIwtvHQvUHuWm5PHrRog1CGi5hZtMfTwhXYTUrNsJi3cscuWGrLjgs1hnuviVnqx19Gm3LNmFsdBjP9Wub5hh8P5GTPG5kkmfjAAjwwQcapOj5aeQkG5kJppzBB/y7fjJfsezPoFugQTzSavlB6n2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774028999; c=relaxed/simple;
	bh=muyRZ4UYsSvQXsXGKypb7/LCocJh1biYiczwdZObtmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjMcjBFyvnCYjvPkg1oBLR8798ku5dQiU7x7j3ZqTFUydd2OmCUAQigz9Cil754RJ7sHnRcv5hWMjIeR850E89JQsDgsykRU4xpUJAFEerym2oW0hV4/gwDD9/k4NyJTlzollfrQ6wX+MYAgXodxu7lOQU7ioYqZtkJoylV4FYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=efCIXik1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="efCIXik1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774028996; x=1805564996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=muyRZ4UYsSvQXsXGKypb7/LCocJh1biYiczwdZObtmY=;
  b=efCIXik1N7mvwL77Qcqs+LjHN6pE6dpMyr3YjUGoxOBLhj0VeTv7S3w6
   GwjoH70bO4fyEmhdD5d2NNO8HchcUr8KqVJniqLZgHJtp/9kT2YIgLbZ4
   Mevoc6o3xq/1Q38Tg33amBemswNTtffC+4+/u4XsYjrAZN1JCMRgzkKKx
   BPkV1PL/7bpDE0PUMWnr4cWnn0oUv3fJpxtrvMFUe5Cj+FwCp2+Wrtr0e
   BzgWFHXGkoHQUZbMCLTuBkLiQXZW0wM9dQ2PR5F46WiznviHJ6FDCr9uH
   EHm4WClWvWVJMPvr/4uaT5cRUca7mxWKWg49uCyy5OulYLUw9aKgNR8pU
   Q==;
X-CSE-ConnectionGUID: L4hWuzCYR8CeVCf7OfA8xQ==
X-CSE-MsgGUID: pFwdf58NRkyAxE+WJi/1CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="75029464"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="75029464"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 10:49:55 -0700
X-CSE-ConnectionGUID: 0EqXHLxTTL2JpNFfVmCGKw==
X-CSE-MsgGUID: dfTNhSTjRmyNGQMwzd8UgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="247429824"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 20 Mar 2026 10:49:53 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4E2DF98; Fri, 20 Mar 2026 18:49:52 +0100 (CET)
Date: Fri, 20 Mar 2026 18:49:52 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nelson Johnson <nzjfr547@gmail.com>, Hans de Goede <hansg@kernel.org>
Cc: linux-mmc@vger.kernel.org, adrian.hunter@intel.com,
	ulf.hansson@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] mmc: Lenovo N22 Braswell SD slot fixes
Message-ID: <ab2IwKoPy8g7Ldm9@black.igk.intel.com>
References: <20260316212325.4207-1-nzjfr547@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316212325.4207-1-nzjfr547@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

+Cc: Hans on FYI basis, but your ideas, comments, et cetera are welcome!

On Mon, Mar 16, 2026 at 04:23:22PM -0500, Nelson Johnson wrote:
> This series fixes the long-broken SD slot on the Lenovo N22
> (Model 80S6 / MTM 80S60001US) with Intel Celeron N3050 Braswell
> hardware running Debian 13 and Linux 6.19.6.
> 
> The regression goes back to kernel 4.14. The Braswell SD controller
> (PCI ID 8086:2296) is exposed by firmware through both PCI
> 0000:00:12.0 and ACPI INT33BB:00 at \_SB_.PCI0.SDHB.
> 
> On this machine the newer runtime PM and card-detect handling no
> longer works reliably, and the ACPI path permanently defers because
> its dependency never becomes available. That leaves the slot unusable
> unless the controller is forced back onto the working PCI path with
> machine-specific quirks.
> 
> This series does three things, all scoped to the Lenovo N22 DMI
> match:
> 
> 1. Disable the aggressive runtime PM/card-detect wake path for the
>    Braswell PCI SD controller.
> 2. Bypass the broken firmware card-detect GPIO path and use polling
>    for card insertion detection.
> 3. Prevent the competing ACPI INT33BB:00 node from binding on this
>    machine so the PCI SDHCI driver can own the controller.
> 
> With these changes applied, the SD slot binds through sdhci-pci and
> detects and mounts SD cards again on the Lenovo N22.

> Tested on:
>   Lenovo N22 Model 80S6 / MTM 80S60001US
>   Intel Celeron N3050 (Braswell)
>   Debian 13
>   Linux 6.19.6

-- 
With Best Regards,
Andy Shevchenko


