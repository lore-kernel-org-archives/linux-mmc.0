Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C54158535;
	Mon, 16 Sep 2024 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726499963; cv=none; b=Kk9q8jgk6fYhqkfAXsApxyAoI5u8sA/am5MroarAouOh30ksdiRk58T+T/W9BxjdWuv/uK6nByQIF0BlbORgrH0QQTWl1tvxQir+PRd1BQ1929BvqZkhDO5Yb+dnnmXM4f76a5sYEXGpPlFqo1PT8yUb7RJD4w1FNGm4conloeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726499963; c=relaxed/simple;
	bh=JZ3BFYtDh8YO27fqrqRAy5T61ZDm3ETJXvi4DTu5xJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaFq0iUc8c9sOrvbvSOXrHhcza4GjE0aiukecBfTkcYKrEn9RKlA3xFXoNnTKcNs9gmD/0ITRl7/Y1hidFFr9T9NWjHHXyvfbzHlkk0qDvFxsoKu9tRKa503UnQtMOBDn4QgUIUXJsp3EWLgVY/SDHBsFsR4be2mryUmrqX1XmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQFqd53J; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQFqd53J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726499961; x=1758035961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JZ3BFYtDh8YO27fqrqRAy5T61ZDm3ETJXvi4DTu5xJw=;
  b=hQFqd53JFoMMHioyXir5ef/VKGb2Uz3DAvJbpCk9lu8MW6aBh0kny1hu
   2FoqafR6LkwknEdD2x5wlRPf60CbNwtwJiI9cf2Ei8R27FiCPyr/Pa5H3
   EedLYl9pIQ9DYSDyds113h04vupAsujiqTEBxbuaXGBPZXhHEXilqm2JH
   ZaKwke5zpWHcWshrd+e69WtfjMgme0Ao+7IZymyTfugR3OhRhoZ2qKnRm
   QlTfi972L21C8hTtS4XiKLF93gZqPLA3UHcRv/d+ThXtuGMSUuUtgXhok
   2PqxqrQ40PGdwUBAtkPKDRSxvdOEK0lvAr0Y5qNtL7lfVAYksjk/gkn7c
   g==;
X-CSE-ConnectionGUID: 4InGTeALTHSG5S+G+lvJCQ==
X-CSE-MsgGUID: No4Fl18HTuav4wLO2FSfBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11197"; a="35910161"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="35910161"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 08:19:20 -0700
X-CSE-ConnectionGUID: 13bJ/0fbTWmNrlD8HcMaqg==
X-CSE-MsgGUID: nugNF5T/TCCZZRqthX91LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="69380367"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 16 Sep 2024 08:19:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E9FF13CB; Mon, 16 Sep 2024 18:19:17 +0300 (EEST)
Date: Mon, 16 Sep 2024 18:19:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Riyan Dhiman <riyandhiman14@gmail.com>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: core: convert simple_stroul to kstroul
Message-ID: <ZuhMdXFhhVUXh8Il@black.fi.intel.com>
References: <20240901182244.45543-1-riyandhiman14@gmail.com>
 <CAPDyKFqdu07MwGyoJ8oMmpFw2u2=1zc8m6LCais8Wva58uTcug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqdu07MwGyoJ8oMmpFw2u2=1zc8m6LCais8Wva58uTcug@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Sep 03, 2024 at 02:37:25PM +0200, Ulf Hansson wrote:
> On Sun, 1 Sept 2024 at 20:22, Riyan Dhiman <riyandhiman14@gmail.com> wrote:
> >
> > simple_strtoul() is obsolete and lacks proper error handling, making it
> > unsafe for converting strings to unsigned long values. Replace it with
> > kstrtoul(), which provides robust error checking and better safety.
> >
> > This change improves the reliability of the string-to-integer conversion
> > and aligns with current kernel coding standards. Error handling is added
> > to catch conversion failures, returning -EINVAL when input is invalid.
> >
> > Issue reported by checkpatch:
> > - WARNING: simple_strtoul is obsolete, use kstrtoul instead

In rare cases this is a false positive, here seems to be okay.

...

> > +       if (kstrtoul(buf, 0, &set)) {
> >                 ret = -EINVAL;
> >                 goto out;
> >         }

Now you shadow the error code of kstrtox(), this has to be as simple as

       ret = kstrtoul(buf, 0, &set);
       if (ret)
               goto out;

-- 
With Best Regards,
Andy Shevchenko


