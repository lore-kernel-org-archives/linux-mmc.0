Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53777374E47;
	Mon, 18 May 2026 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779113807; cv=none; b=EOpdlI0M73RFKeL8z2dElAUBZSwqZkK+IFuM6R3V3CGYgYQ5xjD4vjyqYblMUH9YqqSyZGXNM4qzfohxNi7JyZM8r03mQDfV8eSJIHkyWF1NuWf+uYCsALcp72bOUdLpIDVSKb3EpVabo8Bz6kIyHttY4Sl4a/bVN81djZmOk1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779113807; c=relaxed/simple;
	bh=UPILesnZx8r3bKrTXMAmsxNr0L7To+SPJKYP8uHN3Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rj5oglY6FFxIL/ojeKWfSNkBL3VF1iOAxVgovJs+k663wbjG6v3ftMk1JNAcIP58MUgudHANLQxpDgKOMbNxmkrSFNhaANRn2MljNqHmhtMAeegtb29j50dW+V0RIusEU5BmEkKV7yKr+bJHh1EaCLOWJ7v3U5JRwNelHOVMmSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a1RYsI0n; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1RYsI0n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779113805; x=1810649805;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UPILesnZx8r3bKrTXMAmsxNr0L7To+SPJKYP8uHN3Po=;
  b=a1RYsI0n+onBxqQlediAeDpDMjsX3+w/2+xlKRbVPPUGGkkl9Zvsu6aS
   LorDoVgW2jd60fc0vf9/4BbTXifdDAbp6l3I8fjGdtX0deM3G1O4bNRBI
   SLHtLA0Gwv+djZ3sI36DEK402t5nhBjQub45X9fnN7MNKHvWC0k12JdBV
   p8b0HPIqoQ2a/Pqs1a45NCGJ8Rn3bGnd+duOD+9/YnLe0PNPxVODtCKu2
   13+nPg6WHHeJ78GwU+hPkxMVAEuv5ZqBDpXMAmqtZqwKWMBJe6BnvVaTg
   2PvMraGEUYlj9m/ZWobwWZBnMuj7VA/X5QU3c2kLVPPM4f63xBdlMalsM
   g==;
X-CSE-ConnectionGUID: WJ0JDkb9QcKkqW/YWeo56g==
X-CSE-MsgGUID: vPYKwZdGSh2Gl9WCnC4oDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="83583039"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="83583039"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 07:16:45 -0700
X-CSE-ConnectionGUID: +lnXfLVsRVO4JDN/Oit2MA==
X-CSE-MsgGUID: fPpJ8xgTTaySurCuzKKxYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="235196308"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.3])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 07:16:43 -0700
Date: Mon, 18 May 2026 17:16:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: adrian.hunter@intel.com, ulfh@kernel.org, p.zabel@pengutronix.de,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mmc: sdhci-of-dwcmshc: improve delay handling with
 fsleep()
Message-ID: <agsfSBAmxzd1lIg8@ashevche-desk.local>
References: <20260518110034.142587-1-a.shimko.dev@gmail.com>
 <20260518110034.142587-2-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518110034.142587-2-a.shimko.dev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 18, 2026 at 02:00:31PM +0300, Artem Shimko wrote:
> The driver currently uses udelay() for short delays, which performs
> busy-waiting and may not be optimal even for very short durations.
> While udelay() is appropriate for atomic context, these specific delays
> occur in non-atomic contexts where sleeping is allowed.
> 
> Replace udelay(1) with fsleep(1) in dwcmshc_rk3568_set_clock() and
> rk35xx_sdhci_reset(). The fsleep() function automatically selects the
> optimal delay mechanism based on the requested duration - for
> delays <= 10 microseconds it will use udelay() internally, but provides
> better flexibility for future adjustments and makes the code more
> consistent with kernel best practices. No functional change is intended.

Read, what you wrote. With the above commit message this is no point in this
patch.

-- 
With Best Regards,
Andy Shevchenko


