Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A52338655E;
	Mon, 18 May 2026 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779129307; cv=none; b=uEhsqILM2SJetvfzSgX/A+guubnql2zOoz0yZdpxJzclcNBe5WZvMIfhjVTu4/1lpPYHM06yXy4rsjuGESYEgBgQag1JQIxkqkXV8U3EkmcrY+vexXCcctcSGw7KSWswrdwLSh8mb7zmCV1kDhFIn3YYTYLg0FNnFegxIhA7U3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779129307; c=relaxed/simple;
	bh=mWxzG3qj/BaOLGYrMxw6sLrhUIyqaD1zmYfR6ZBCLgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjPffmYGP0rHEPxLb3u3UTLtjnlwlwXoTE4jdheB/p3RnR4hpYitGCj12CbPD2fbOwIKRHIjpJLKXbAVV9lReod9PAypZR6dRVhpYfmkFD2i1n8CjEk4L+Q/KPaxcfqENYgjZZ/eVUP8N09TM29CXuq/5j5rsL4EtDZ1mMBiR7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBeEDNeI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBeEDNeI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779129306; x=1810665306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mWxzG3qj/BaOLGYrMxw6sLrhUIyqaD1zmYfR6ZBCLgs=;
  b=HBeEDNeICiZ7lClxr4Boc6Mr+0GvR+g7ipY2S3niIPx5XBW4p+auHE91
   D20bqhvJoNZyZydGV7bWGTBoYDNbZ1oq8UATn36TomszV+BlgjWoCvB+X
   yYfwpZUzGLgKPuJokniiXBAw1vz6IKgk2MYwbYyq43peb8oa6v0f0ZXNW
   RyGg8tAMYoigY4TWKY2mbQe6TZ7xpTqbnsdAge1p6aO1adX/G+NtjVOTo
   hMQY90r8BwUA9nDVuioyK2icE/BnO7O2lkJ0tZIHSXSOvuv8hk3mVyr83
   eDZngeLB7hGDG5R8AIm6P2RhQGz4sAc+RTI/sv6TMuCdVJ/sqvd1Wl9P5
   Q==;
X-CSE-ConnectionGUID: yRFlXzxJSPyM298XUG8PmQ==
X-CSE-MsgGUID: 7euaYn9TT6eDQCqKGTFAdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="91098289"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="91098289"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 11:35:06 -0700
X-CSE-ConnectionGUID: aoPLcj+oRomopRDPhgNzDg==
X-CSE-MsgGUID: uFtTZ34IQruvO6NoZiNClQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="269862298"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.3])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 11:35:05 -0700
Date: Mon, 18 May 2026 21:35:01 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: adrian.hunter@intel.com, ulfh@kernel.org, p.zabel@pengutronix.de,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mmc: sdhci-of-dwcmshc: improve delay handling with
 fsleep()
Message-ID: <agtb1VVEaOamRnEl@ashevche-desk.local>
References: <20260518110034.142587-1-a.shimko.dev@gmail.com>
 <20260518110034.142587-2-a.shimko.dev@gmail.com>
 <agsfSBAmxzd1lIg8@ashevche-desk.local>
 <CAOPX746JbZamfeJcY+vT1EWDpFCSVe4zc8AHGL8sGobUnzC9ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOPX746JbZamfeJcY+vT1EWDpFCSVe4zc8AHGL8sGobUnzC9ew@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 18, 2026 at 05:50:55PM +0300, Artem Shimko wrote:
> On Mon, May 18, 2026 at 5:16 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > Read, what you wrote. With the above commit message this is no point in this
> > patch.
> 
> I tried to replace *sleep() with fsleep() API. It seems I
> misunderstood the hint [1].

Yep, the hint was basically about uses of usleep_range(). udelay for 1 or 2
microseconds is fine as is. Of course for the sake of consistency it can be
moved to fsleep() (when the context is non-atomic), but solely udelay(1) -->
fsleep(1) makes no needed churn.

> Or is that the commit description mistake?
> 
> Thank you for reviewing it.
> 
> [1] https://lore.kernel.org/all/ad-mCsvOWWgqt-rc@ashevche-desk.local/

-- 
With Best Regards,
Andy Shevchenko


