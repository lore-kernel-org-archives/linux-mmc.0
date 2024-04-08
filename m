Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A2B14038F;
	Mon,  8 Apr 2024 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589810; cv=none; b=s/GbfFwrAL9wiqfq1RZXl6CmoRJELqCEXss/CyH/RfepeqsEXUuUFhgSOE2Fx26BsXPnvUkJnDqTwN4AP+P41tUZF10cbi3jMg6juqxfkUAOJYEjJN+xC9nlfKK4VMrsN+qrrhLR6OC3HAqLeWVpGE7Ffzp4yNBSLoCnZGS8IeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589810; c=relaxed/simple;
	bh=VBPO8FIHpRsFN6ArdLvjW2VoHXym4U8Qjitl3JNxpdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ivba3glgzhBmgo15HgDD2gfoUzymow5XINqj85OLMuGLN+vdEEt0uM6h+dCvhQA7SRhTt2P7EmzivOIzzb/VaxRdN6+GnmJFbCitQ+rXl9kVycUZfZsVh8BCzTiV6+R+j7gNs3AK50TY6eHjzhptaGoJcmJ6eS/olgiCIZ67oj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: bw8QXPMpSfaAofrOi10mhA==
X-CSE-MsgGUID: cBBNW8WKTTu0WqW0FMVoEg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8034091"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="8034091"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:23:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="915368503"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="915368503"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 08:23:26 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rtqqC-00000002Yrl-22uy;
	Mon, 08 Apr 2024 18:23:24 +0300
Date: Mon, 8 Apr 2024 18:23:24 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 1/6] mmc: core: Add mmc_gpiod_set_cd_config() function
Message-ID: <ZhQL7KmvVYgRpz46@smile.fi.intel.com>
References: <20240407200453.40829-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407200453.40829-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Apr 07, 2024 at 10:04:48PM +0200, Hans de Goede wrote:
> Some mmc host drivers may need to fixup a card-detection GPIO's config
> to e.g. enable the GPIO controllers builtin pull-up resistor on devices
> where the firmware description of the GPIO is broken (e.g. GpioInt with
> PullNone instead of PullUp in ACPI DSDT).
> 
> Since this is the exception rather then the rule adding a config
> parameter to mmc_gpiod_request_cd() seems undesirable, so instead
> add a new mmc_gpiod_set_cd_config() function. This is simply a wrapper
> to call gpiod_set_config() on the card-detect GPIO acquired through
> mmc_gpiod_request_cd().

FWIW,
Reviewed-by: Andy Shevchenko <andy@kernel.org>
assuming you considered addressing nit-picks.

-- 
With Best Regards,
Andy Shevchenko


