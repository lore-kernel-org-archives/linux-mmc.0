Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9A813D518;
	Mon,  9 Dec 2024 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733762641; cv=none; b=O24z/N8JOa1B3ci+yBqoZycvepSl0Zq4sUy+qTBj+KOVe15hzDxfd2i3w4QQRb6k8JaXzkILbuRKgeDX2FsJPhoLcEXf4mxEd8+/uVFxDd+EAHSn/gdvS5oWzaAbg59ailhHleLwvsjo3YINr/Q6AqxSyvne3nQ4d4WXVKoGows=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733762641; c=relaxed/simple;
	bh=gPBsh7kBxwTkWDxaPUYHX2x5XD0ROwzR2gKerLn0ZD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZFP8B0vVjn7AtbYy3M5gY/3vBoyK8CnqB2O6iTO38TttrzZpjVXZ0Jhvdo14srZYjV2MlUR2gF5puIjxyk8L0Z/tJ+s+5qe8U1Nr/vZxdVuJXfudLS2G3m/lmdiL5DhDFnLadCoDW5LtaH0hbdQO7Q1AoOra6AwHbIzNwmI2bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fe+DFVRW; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fe+DFVRW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733762640; x=1765298640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gPBsh7kBxwTkWDxaPUYHX2x5XD0ROwzR2gKerLn0ZD4=;
  b=Fe+DFVRW8tsJj1I4G9EGmPFTEdqsKGaGAvrk2yGkDyAarJXFY4lPnFYz
   /CBCUd/i6wry2+dNmAZEnAgoKeJfAFt0CgtV2tXciHCViprw6IPEtQ45e
   w2mQXfsLXfGR/Lafk96PsJH2LTB8oeyoFgJvPVWoAEMEo8gmD5t9WZ0kB
   yEK5uqbkyDT3BHSHP5QzrQfY4nNW8ni6Brz4fG872WvxZMvTSuv8mT9bh
   igSVC2TP2hJ4L26syZa6E1E0qZ5ncBPiYYfhLnIS8aQiG95zlM4DPUcj4
   0EVYfoc+CUoLdc+YMbGqq29YGeHQHRyui1GHetD96PvYfrBYi0k8FF+6P
   Q==;
X-CSE-ConnectionGUID: SDa2ObizSn6sq2oWhdudlw==
X-CSE-MsgGUID: G6CTbBCTSOeJAWcgBJRMfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="34128181"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="34128181"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 08:44:00 -0800
X-CSE-ConnectionGUID: Pv8sxWOXR3O8vwYdI5BG/w==
X-CSE-MsgGUID: IN/Va6CeTLeOE1vVR1X0lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="94828598"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 08:43:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tKgrT-00000005neT-3JUl;
	Mon, 09 Dec 2024 18:43:55 +0200
Date: Mon, 9 Dec 2024 18:43:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] mmc: sdhci-acpi: Don't use "proxy" headers
Message-ID: <Z1ceS7FksaPeqYjF@smile.fi.intel.com>
References: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
 <20241101101441.3518612-7-andriy.shevchenko@linux.intel.com>
 <52ac8bbc-49d1-4104-98e2-40bb69c23f09@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52ac8bbc-49d1-4104-98e2-40bb69c23f09@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 09, 2024 at 01:32:36PM +0200, Adrian Hunter wrote:
> On 1/11/24 12:11, Andy Shevchenko wrote:
> > Update header inclusions to follow IWYU (Include What You Use) principle.
> > While at it, sort them alphabetically for better maintenance.
> 
> Not a fan of alphabetical order for include files.
> In this case it makes it hard to see what actually
> changed.

Huh?! It will be quite easy to see if anything is being added or removed and
makes code robust against (possible) duplications. Much easier to maintain!

If you are talking about _this_ change, then it's true, but only for _this_
change, and not for the future changes. Alphabetical order is natural for
humans (and we write code for humans) which our brains are trained for. So
the processing time of the ordered data is higher and less resource-consuming.

-- 
With Best Regards,
Andy Shevchenko


