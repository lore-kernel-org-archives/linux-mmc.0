Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDD83597B;
	Mon,  9 Dec 2024 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733762450; cv=none; b=G9Mh/rQ99JyTWjS7IHyVx8qTBbYAa/26SaBlZoz/DQBAwIIb2xc/oPsMdfOe3hGE8D28BvhLjBvTgw+uG4TjOAr2iyMGDqbuRLn495w0BZZbHfkIfJjmYY4lx6D6rk/mcyHwlqvSbJLn9Vrs1T4RMd7DuXUQbIEudF2sIiDqmBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733762450; c=relaxed/simple;
	bh=k+sIdzLe2v7tDCVKEoz1d1ZWfZz3ZvVlgO8jRJHsQvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXMQHmkxNIXmNENvZIHOBuh6dRoCtFZRhS1sa3qONw+P2Nn9+xhT2AQCVIMMUQCSCzXvN0zkYgLr+ixO6/ilZlfOrq8VPJf7OmD18otJhWZ74HpeJwZwXwAnqgz3rB3QYWWq4Kq9mybZnPfws9oj4ro8f29DCtJgWNJDll2+sa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0e4ZMAJ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0e4ZMAJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733762450; x=1765298450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k+sIdzLe2v7tDCVKEoz1d1ZWfZz3ZvVlgO8jRJHsQvw=;
  b=I0e4ZMAJ/BQRbjKqobTVdkG3FUUu6ONgyhcPgWpyX9f2k9DCAAtVwfye
   39u24sm7gHXWwJpYrtAX79OkWpK2IDyTHbTTLewRdScOdsdMJaO95QwZS
   k1ILBH5HcHBwMI+uEfjmWu3lFAU8WeEthLtZCP+/gTTgOxKqsXQWvVWZ7
   d8uvbGQeuugVjroq7OCNFmrpE6d8bF6/Q7hC0aI0DJlT+A46EuLsl9I8e
   4kM3BI1P//uGME9KESP4HZYwrOcjv4pHhP/gn1IC6VfcMvA6HRKuCeEys
   6qN+mdzqeCMVZAkl44irQO0yJ7qkW26/YJnRGRpi2Vpa92hISpk1HbI/p
   w==;
X-CSE-ConnectionGUID: bswMT7tDQIyrHwDY8tLyaQ==
X-CSE-MsgGUID: ZNoB3eb8R2CG8J6hVlYFYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45449575"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45449575"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 08:40:49 -0800
X-CSE-ConnectionGUID: tbVmHngTRB2hx7NbAnKlkA==
X-CSE-MsgGUID: KxV7ftppREORuZk1dhVr3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="99599735"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 08:40:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tKgoO-00000005nb4-2uHf;
	Mon, 09 Dec 2024 18:40:44 +0200
Date: Mon, 9 Dec 2024 18:40:44 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] mmc: sdhci-acpi: Tidy up ACPI ID table
Message-ID: <Z1cdjFiv61v08CNF@smile.fi.intel.com>
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

It's not for the sake of it, that makes easier to see what's going on with the
IDs. It's not the first time I stumbled over (unsorted) ID list and questioning
what the ID belongs to (vendor wise) and how many of them from the same vendor
and how many of them are invalid.

> In this case, it seems to me more useful to keep different
> vendors IDs together.

Agree, but also note, alphabetical order roughly gives the different vendor IDs
together with also grouping PNP/ACPI/invalid ACPI IDs.


-- 
With Best Regards,
Andy Shevchenko


