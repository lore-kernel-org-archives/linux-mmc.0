Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ACE22BAD9;
	Thu, 16 Jan 2025 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737040581; cv=none; b=AjaYzeXLKeUudYp0QgzBXRsq1Du0foXF0C1untDMaQ3smPqTlZj+9Q3GHVLuouAIRp+i6FMeLpnhIUMjrhlaqqFex0aQ3XutbMkV1bkavHf8GvGuhbLZTsmq+WxeIo++26FuUwCUGbDyQ6Gx9DDaRr7piOZV2ByvFSKwGzQyx9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737040581; c=relaxed/simple;
	bh=O7CxRbJXwbmTQNGbZ59weOBZ/C6CuXkjd/CRI/PVH44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZE9x5OD2ASxg0GmSPrG9B/UFidTXs9VwfxUj/hF/PCX9CRUXxdzHOR+dYCxjU1cF//QbbJEF+WdvDvNnX/EDGF0mrjFXUc6KptxP6Ghxy6sMmgXMYi0dGCDD+sOT+JF0YTlrp0iCGmRD3hg0TkTuPVVI09sLQcJpUfQQLBuPkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bC77o+iR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bC77o+iR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737040580; x=1768576580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O7CxRbJXwbmTQNGbZ59weOBZ/C6CuXkjd/CRI/PVH44=;
  b=bC77o+iRV/lVsZkDzq4IGloDaJfCThxr/5NjV8xlI19RYSWP79wzSCQ9
   pIWRvv8IN0lYxNeoyd/phklgX2CijDWp/fp6pHkzC8oEwBestlpKXdFR5
   uT4TKCGh3nJ3ve6ywwAuvXMSxlSrEk99sz6N6b+P6ymnA9qVdiC10VFBp
   oUGAmiokCvOYEFxx+0ZhkjpJ89O511V9/XRj5I3+Vv7fVF/79lLOqbXIx
   2t3184pIiS/KCphECPcklIOY5m5j9RIUT0PVZPOkIuvbMWYcY1tRVoks0
   I3r2q4/Vwfzf8LTxGbJqrUPPd1IBxzctr4vvmVIvxtMbzI3XMxNJz6eRP
   A==;
X-CSE-ConnectionGUID: tUaX4GDkTOKwoHqIO0SBqg==
X-CSE-MsgGUID: uGAiNfQIRouurBoRRScNbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="59908305"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="59908305"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 07:16:12 -0800
X-CSE-ConnectionGUID: u4nvIOUfQfixxgYlCCuF5A==
X-CSE-MsgGUID: op80HpUVS0iPM8Ft8AEuSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="105671517"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 07:16:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tYRbL-00000001iEa-1s78;
	Thu, 16 Jan 2025 17:16:07 +0200
Date: Thu, 16 Jan 2025 17:16:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] mmc: sdhci-acpi: Tidy up ACPI ID table
Message-ID: <Z4kit8lLPsa9QkAr@smile.fi.intel.com>
References: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
 <20241101101441.3518612-6-andriy.shevchenko@linux.intel.com>
 <8faca5b6-bd8f-4e9f-ba0f-45e78d203667@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8faca5b6-bd8f-4e9f-ba0f-45e78d203667@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 09, 2024 at 01:29:19PM +0200, Adrian Hunter wrote:
> On 1/11/24 12:11, Andy Shevchenko wrote:
> > Tidy up ACPI ID table:
> > - sort entries alphabetically for better maintenance
> 
> Not a fan of alphabetical order just for the sake of it.
> In this case, it seems to me more useful to keep different
> vendors IDs together.

But it will be natural outcome.
Should I specifically put them into groups?

> > - drop comma in the terminator entry

-- 
With Best Regards,
Andy Shevchenko


