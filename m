Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6607271443;
	Fri, 20 Mar 2026 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029752; cv=none; b=Wri/v3uMGKJCefQh3P4C0N1rTYdz2mI1iFndtH6ip6Wdrq/AZwpd5imJD2ybmscX9gzCVlVUWwQdVDoIu5E/x9FRyFu/cI4S4XOy1KiNN4K85tadvCFx6Q1oTyo8/wSLmeNZiTmPFkJ91/QBym7cgTX/zuBAWnishddo0X/M53Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029752; c=relaxed/simple;
	bh=ygddwQBlct0Qle7k0qca1QnPQuw/+Y9jQs0PyYUD65U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bu61ICNRbTqPxtOd48pJzDgmzjgaGF2svprGNczLNt0o6d2VFwa4oJcTS04klBjbOfB2aLXfL8cQykuV3uTUIl8W590l92VMLmqFBXrdRON2JvjrG0g3oVeXo3OR1GH6kCThrtY9R+2hxoIJ6Js9NJJZfm+jkoMVkmCQjk50404=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NjKG5vtk; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NjKG5vtk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774029750; x=1805565750;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ygddwQBlct0Qle7k0qca1QnPQuw/+Y9jQs0PyYUD65U=;
  b=NjKG5vtkSr1JOZps5/NtHsirtp+IAddgHp0DnHTUxzFTWTE+i93sh4J8
   3zElU+TiObQ0i2FHVCvhRpVeY1BHX61NfYWUogjFA4sU8m6AX0+hXyVyf
   3wWYrV39V3W2AV9mtl9GJFCDzKLj7381l0ZE1D33LalrGf+7r/8W+UY75
   MB6xxl/J01E5JoH33kBV1hRvLt+gyLAVI9xEDmQvIcp2bx6MfBe9K1Ilh
   co0e9pKf1P8/RpZY0DTLADjMC+AJmMHO0tWmZZTIqihHStySLa9otRpan
   4g1f9tfbODv5A/vv5srR3OMda7qq8crko0tFg4rLMMSKs8nXUzejcQNHu
   w==;
X-CSE-ConnectionGUID: Qc/3Gs/nQRacUQF5so85Mw==
X-CSE-MsgGUID: xg0M4Rk6R4ClOho1piaFgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="77729292"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="77729292"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 11:02:30 -0700
X-CSE-ConnectionGUID: tvypbnx4TYeHzp54b1uAyA==
X-CSE-MsgGUID: HoWnxFNUT4ehQ/t8AmTwFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="220688373"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 20 Mar 2026 11:02:28 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 0AF1A98; Fri, 20 Mar 2026 19:02:28 +0100 (CET)
Date: Fri, 20 Mar 2026 19:02:28 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nelson Johnson <nzjfr547@gmail.com>
Cc: linux-mmc@vger.kernel.org, adrian.hunter@intel.com,
	ulf.hansson@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mmc: sdhci-acpi: exclude INT33BB:00 from ACPI
 binding on Lenovo N22
Message-ID: <ab2LtPclnoAXeYHQ@black.igk.intel.com>
References: <20260316212325.4207-1-nzjfr547@gmail.com>
 <20260316212325.4207-4-nzjfr547@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316212325.4207-4-nzjfr547@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 16, 2026 at 04:23:25PM -0500, Nelson Johnson wrote:
> On the Lenovo N22, the firmware exposes the Braswell SD controller through both PCI 0000:00:12.0 and ACPI INT33BB:00. The ACPI path for INT33BB:00 never finishes probing on this machine and repeatedly defers, which leaves the slot in the broken ACPI path instead of letting the working PCI path own the controller.
> 
> Return -ENODEV early for INT33BB:00 on the Lenovo N22 so that sdhci-acpi does not bind this machine-specific firmware node. That leaves the controller to the PCI SDHCI driver, which is the path that works once the N22-specific runtime PM and card-detect quirks are applied.
> 
> Scope the exclusion to the Lenovo N22 DMI match so other INT33BB systems continue to use the normal ACPI handling.

This should be done somewhere in drivers/acpi/x86/lpss.c I believe. That's the
driver that responsible for ACPI enumeration of LPSS devices on Braswell
machines.



-- 
With Best Regards,
Andy Shevchenko


