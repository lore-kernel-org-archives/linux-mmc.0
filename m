Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA98280CF6;
	Fri, 20 Mar 2026 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029309; cv=none; b=gyZo9qHlS9h3txVNvfjfepusEg3FX6Uef25+bVz5VFFTAtxzh+nCK469c85NnQsck03Idc5CiR6UVZnWJXmTZdTUQ0bUGxdJ7/Z/Ff1acp2TPMeK3xXLcsJ3OtcCem/B1xnwhPTu+lpAPYTpBvHuccVbfj1mBToAk57pTVGIW0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029309; c=relaxed/simple;
	bh=rMgFI6ds1mAkCxEANcBQGhT8bAdD0d3u7Q3t5sAovHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdE7uSxmyGJBVtPz2sy3vNWXhgDFAfHjCpVChCXQVhjQsrESY87vVhzverZ18HfrRZ1vw8Ev6J2kHbhBj8WLMzRz6DSVjoDOYpVpUKlXCKIea6oJ4to9YFmrXiz7kn17xNlmBxDVXrmA/kTqH1118ejYLyJ/88hgDIsY8AbaDg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JhMPdJMf; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JhMPdJMf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774029307; x=1805565307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rMgFI6ds1mAkCxEANcBQGhT8bAdD0d3u7Q3t5sAovHY=;
  b=JhMPdJMfaj/kH3/rcK4IXYZw4NRr0XqCzoJEToamSyxXun0lNGVpXdEm
   cOYS9utfmLe8g6LUK7r4QfGOJ/sEEe87MnUAmQsbBk6HrkDLAzz4fQvm9
   wOCEtL7ZP6MynFW7OMGR2j/PejWUZfTZ2mZvwN6RiwZeAoNo0G+65HKCm
   rBdu2n451xrwwNxQOkMtpC83OzEabFM+EN0FjEfgZGzqCUnR3vW0GdB5N
   ctVj3NqaMDOhxtBmNCJZ7afLvatt2drNhmed6H+q9xerogp49w2dIU9wj
   UT8fPDriDBYdZKY/Spf74C7/KypT7Ok0FZmfx1DUmqSF3YvAMja4i04uS
   w==;
X-CSE-ConnectionGUID: c5Oa5ShoSlmgVHpHtD4Q8g==
X-CSE-MsgGUID: JLtwRFYRSOmU9AaA5Crzug==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="75007238"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="75007238"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 10:55:07 -0700
X-CSE-ConnectionGUID: wSNT1YclRSeKVy4hNI6oGA==
X-CSE-MsgGUID: 0UhoPRXYTbK7ysaTgstV8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="228079565"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 20 Mar 2026 10:55:05 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 15B9898; Fri, 20 Mar 2026 18:55:04 +0100 (CET)
Date: Fri, 20 Mar 2026 18:55:04 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nelson Johnson <nzjfr547@gmail.com>, Hans de Goede <hansg@kernel.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 0/3] mmc: Lenovo N22 Braswell SD slot fixes
Message-ID: <ab2J-MrwPAQ_BjGs@black.igk.intel.com>
References: <2cb3de9f-2c07-48c6-a3e7-63d34b49ca32@intel.com>
 <20260320164753.536-1-nzjfr547@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320164753.536-1-nzjfr547@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

+Cc: Hans

On Fri, Mar 20, 2026 at 11:47:53AM -0500, Nelson Johnson wrote:
> On Fri, Mar 20, 2026 at 8:27 AM Adrian Hunter wrote:
> > These changes seem more like they work around the problem rather
> > than fix the problem, but you say it worked OK in v4.14? I see also
> > mention of v4.9 in patch 1? When it was working, was it using the ACPI
> > driver or the PCI driver?
> 
> You are right that this series is a workaround for a firmware-specific
> problem rather than a generic root-cause fix.
> 
> My confirmed working baseline is v4.9, and on that kernel the
> controller was owned by sdhci-pci, not sdhci-acpi. The INT33BB:00
> ACPI node was present in firmware but did not prevent the PCI path
> from working. I should have been more precise in the cover letter.
> What I can state from testing is:
> 
>   - v4.9: slot works via sdhci-pci
>   - current kernels: slot is unusable
>   - current kernels with this series applied: slot works again via sdhci-pci
> 
> > In patch 3, you say the SDHCI ACPI driver repeatedly defers. Is that
> > because it is waiting for the GPIO driver for the Card Detect GPIO?
> 
> Yes. On this machine INT33BB:00 defers waiting for the card-detect
> GPIO dependency, and that dependency never becomes available. In the
> broken state the ACPI path does not successfully probe and the slot
> remains unusable. Excluding INT33BB:00 on this DMI match allows
> sdhci-pci to own 0000:00:12.0 and restores card detection.
> 
> I am not aware of an existing generic ownership-arbitration mechanism
> between sdhci-acpi and sdhci-pci for this dual-enumerated firmware
> layout, so I chose the narrowest fix available: a DMI-scoped exclusion
> on the affected machine only. That approach is consistent with how the
> subsystem has handled similar firmware defects elsewhere. sdhci-acpi.c
> already carries a maintained quirk table covering the Lenovo Miix 320,
> Acer Aspire Switch 10, Lenovo Yoga Tablet 2 Pro, Toshiba Encore 2, and
> ASUS T100TA, all firmware defects fixed with DMI scope and accepted
> with stable tags. sdhci-pci-core.c follows the same pattern, as
> jsl_broken_hs400es() immediately above the new helper demonstrates.
> 
> > Note Lenovo N22 seems to date back to 2017. Is it really worth
> > spending time on something that old, especially as no one seems
> > to have worried about it before?
> 
> My argument for upstream is mainly that the quirk is small and
> low-risk, and that PCI ID 8086:2296 is part of the wider Braswell SD
> controller family rather than unique to this one machine. Although the
> Lenovo N22 is an older platform, Braswell systems remain in active
> secondary use. The Lenovo IdeaPad 100S-14IBR carries the same
> controller and has a documented bug report showing sdhci-pci not
> binding on kernel 4.10 after working on 4.8, the same symptom pattern.
> The commit documents the failure mode, the correct driver ownership
> decision, and the workaround approach in a place where anyone dealing
> with a similar Braswell platform can find and reference it.
> 
> That said, I defer to your judgment on whether this serves value to
> the wider community. I am happy to carry it as a local patch if you
> feel it does not belong upstream.

I believe Adrian added me to the Cc list to hear my opinion as I heard
about Bay Trail and similar machines more often than him nowadays. Yet
I am not working directly with them much, Hans does (or at least recently
did a lot). Nevertheless, looking briefly into the series and this message
I kinda tend to agree to make patches go in. We have tons of Bay Trail
machines from recent years and they are still supported well enough by
vanilla kernel (thanks to Hans).

TL;DR: I can look a bit closer and review the patches.

P.S.
I have installed a home router last year based on Bay Trail :-)


-- 
With Best Regards,
Andy Shevchenko


