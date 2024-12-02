Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E40A205E03;
	Mon,  2 Dec 2024 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153488; cv=none; b=QJOyDTNqvERKDf8VqAY6NXvMx/DaiHQXee2hxxlmypdG5pVPgdRpru6LLFBBuHohWJcQ6yzg/TSBZyw9yj9YjHES4pMF9euYuSXXjjcM2RYTSAjTSYaStdnq6Ps9ucHuouri/DyN10iuiJ9qdM1W4GocQz6302a9O5FVzdr5pB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153488; c=relaxed/simple;
	bh=LIC22lvcg0GEAsloGNR0vIWhLAC8DJjmvoKLwQeuxU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnHfmG7qyippzJI45T6Aezt24QRq3Rmu+oytC3FJpAkDvEnb107k1oTXZOneULYfgitI7hmLwDECgImAYhu/RP6iUIPKk7a8Aa9V3RaTepmq5czz2YTJ09XRj5bIsPtVetKbK8sld6jBaZckJaLgwyQtn1eWDgwteXURkoK06+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ll+g4aD6; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ll+g4aD6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733153486; x=1764689486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LIC22lvcg0GEAsloGNR0vIWhLAC8DJjmvoKLwQeuxU8=;
  b=ll+g4aD6SCxCfx9cTrf98+jU+uOrFWjAqhH1Er3lr9q936zAqnxmO1qU
   L87428/D4D/oDJtvy43MmzqfB9RCfPZnWVibBzQqlkl+yGDhTEf1DOIs/
   RMGuAe5TXxhdLp/QJGh13+krJlwzAa64BmxPCt8bm5MNXGAWo8M+ecMyS
   v0FDhiyqFizdwdb88iiZ2Q9X/XvVFQ0r82oG2kRAUSeEq1myHt8b/m+hR
   LBUozLLwv9aTz+lzREf2nHlnXZGvVuTI+WHtqLik67K2HAR8R3IZY5v54
   9lY/ocgkMgOpxpgbuwXmdfdJ5LqthZ9Dpg2Q6Ik5o5OlJqWnMd42gej7B
   Q==;
X-CSE-ConnectionGUID: i1ddb5X9TO+y3Lxq25RuqQ==
X-CSE-MsgGUID: ezRFIptKTe251l/tG6sNeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33204328"
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="33204328"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 07:31:09 -0800
X-CSE-ConnectionGUID: joznqKyGSpyauln+woZzrA==
X-CSE-MsgGUID: jhia9RVPQnacitl/6RWCdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="116396336"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 07:31:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tI8O7-00000003BAq-3FcZ;
	Mon, 02 Dec 2024 17:31:03 +0200
Date: Mon, 2 Dec 2024 17:31:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] mmc: sdhci-acpi: A few cleanups
Message-ID: <Z03St5LVqoNWWqcv@smile.fi.intel.com>
References: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
 <CAPDyKFqNKXRPT_QonnJ8frY_OvA6FkEMyj09Ywiqhtu0ZL34Xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqNKXRPT_QonnJ8frY_OvA6FkEMyj09Ywiqhtu0ZL34Xg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 02, 2024 at 04:24:00PM +0100, Ulf Hansson wrote:
> On Fri, 1 Nov 2024 at 11:14, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > A few almost independent cleanups for the driver because of
> > new available APIs.
> >
> > In v2:
> > - added patch 1 to solve compilation error (LKP)
> > - split patch 3 out of (previous version of) patch 4 (Christophe)
> > - added patches 5 and 6

> This looks good to me, but deferring to apply it a few more days to
> allow Adrian to share his opinion.

Sure, no hurry.

-- 
With Best Regards,
Andy Shevchenko


