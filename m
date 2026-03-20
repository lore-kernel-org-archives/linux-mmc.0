Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC313DA5C4;
	Fri, 20 Mar 2026 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029543; cv=none; b=RwXTOF22zwRal5gfJNNhWJwK72lUkVmC56WbMHqHIPf8YNTz1cbgMRLSu7Vys+QM9f1KkTdy444uEa9zY06mzq5iZSQ2aKbfQOIyY48delW6GD6ZoyHFfu6nN+riOCZOILUlRVtytIiYYicYBTn55L4Yd+cezigD2VvUO7jT8G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029543; c=relaxed/simple;
	bh=1u8BxdByVk4O+osWK2qdls0t4zAfFZHG562xkZw83Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCEyQ69ttCRVyYXaVVaDDu8ltxdoRENy+MpLtJdVkmiVJLYDweZbNYza2+CTiZxNGFaki3fYXZ7aU3jcMbkF2fenFBqvwK6sZxQhukgTFP3tQAIxwEALL3kSS7dg9LT6zWNwfuMo2SHyCzhEjfkZdzeXEYMQdA9YRrAKXcSMj0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RgDe06fr; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RgDe06fr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774029541; x=1805565541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1u8BxdByVk4O+osWK2qdls0t4zAfFZHG562xkZw83Ic=;
  b=RgDe06frkR8rHFF6xbUjVuSXHaRgbEJUQsDVCfsRRnu1l7vJZJyVaaRz
   m8UtzafNg846RZto6HU2/QCraSzbSCssjebZ9lr7cbPAUMV1HqozSQIwr
   yJNubGvq1se0Z3fpR6a3u8rXZVvnZHk5/autSANeEqm91TYY7cPCcJtb1
   mozUDNFIvAr7sUVW5MFjjWZt8ialaZoU96SpVSTq8GLxv90SOLPs36sFX
   1vp483KcWHZ+pDINpgzVPF+FrVv+tgRw7DlVILCB4Z4inVr5GlLJ9DGM6
   /cD8P5V6eODGpoHS5wg0vmtreTD/c+9KTGfGI6IooaBLH40BBvwD2LJU/
   g==;
X-CSE-ConnectionGUID: +AS6h/qcQNmPt7OMQvVAdA==
X-CSE-MsgGUID: W/IFiwtESzOf6dW5G21F2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="74137886"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="74137886"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 10:59:01 -0700
X-CSE-ConnectionGUID: HtgDhIWLTgOU1VZ3FT6Pvw==
X-CSE-MsgGUID: Efmy/k3ITIKZqmybLaIB8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="222452464"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 20 Mar 2026 10:58:59 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6464598; Fri, 20 Mar 2026 18:58:58 +0100 (CET)
Date: Fri, 20 Mar 2026 18:58:58 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nelson Johnson <nzjfr547@gmail.com>
Cc: linux-mmc@vger.kernel.org, adrian.hunter@intel.com,
	ulf.hansson@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mmc: sdhci-pci: disable aggressive runtime PM for
 Braswell SD on Lenovo N22
Message-ID: <ab2K4jIby9yJZ8TN@black.igk.intel.com>
References: <20260316212325.4207-1-nzjfr547@gmail.com>
 <20260316212325.4207-2-nzjfr547@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316212325.4207-2-nzjfr547@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 16, 2026 at 04:23:23PM -0500, Nelson Johnson wrote:
> Lenovo N22 systems with the Braswell SD controller (PCI ID 8086:2296) regress on kernels newer than 4.9.

v4.9

> On this machine the SD slot is exposed through both PCI and ACPI firmware nodes, and enabling the newer aggressive runtime PM/card-detect wake path causes the controller to stop behaving like the older working configuration.
> 
> Keep the Lenovo N22 on the pre-4.14 behavior by skipping MMC_CAP_AGGRESSIVE_PM and MMC_CAP_CD_WAKE for the 8086:2296 slot on this DMI match, and disable runtime PM for that host.
> 
> This preserves the rest of the Braswell/Atom handling while restoring the power-management behavior that allows the slot to function on the Lenovo N22.

When creating the commit message you need to wrap the lines around ~72
characters per line.

-- 
With Best Regards,
Andy Shevchenko


