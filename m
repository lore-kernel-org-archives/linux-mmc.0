Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AD11CA680
	for <linux-mmc@vger.kernel.org>; Tue,  3 Sep 2024 12:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367979; cv=none; b=hicAcwy2PXQMC19IzCa4DAxuTUvNMcTUwump+xj2xQy+ULJtkX+GMGWxmxlicZO53kS7Ra1capPcl0Yesy37NqCiwkWzQe/yCJUFnYF9qXR/zqZvCVCx3ekB2UwMU3XJawNL0lpyYzkOuFrYD0oV3cABpzBuP7SaZEe45D2v1o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367979; c=relaxed/simple;
	bh=atSkSNUlm/IC0jciIn5xkBGHQPxFqCMpqrCYb6mDVJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mw3vFVJzgQuA3WTHDX/hHWsaruxGjqGtIXgL/bsrows+wGyG6op1bipcmIand22WS9xycubz0oEGAZWUmnrb8kvg3Sh3+8PL6ijpKWpVgAey8eYLHyKDZ7zXl3bWX0CMxOLzoa/sd4W3KMyvKDTnq2BhgK3Dhf1P4orWO36SgGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CLqpTx9t; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLqpTx9t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725367978; x=1756903978;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=atSkSNUlm/IC0jciIn5xkBGHQPxFqCMpqrCYb6mDVJU=;
  b=CLqpTx9tUegf+vgm4UQ2C0TH1h58jNOAEF8juneiM0FvQc1tPS2CayFS
   tGUaQ45GTBorvF0nUlx6+WMVdBwgdXcC5+yPjyGtd/iig0WfVVFkPkeWH
   DCGPq0+M2VUDxcGUr80fYf8Pqygcilw3Fq9LoLE3G504Vss0vlB+2SaVz
   QRXpMkdLRHpviaz6qEk8GnsrMykioMm0YsDPcXa4PrBkkFGYxAVCRom07
   5KqT/fIidtNlUEvEjKfG3C/tq+PEfKH2ZOntkUWKP9NwCsS/zG60vJUuB
   JZ6fLK1GUDl+nAoQKBzTK5+dscXiWm9rdZ+ELY4wlq1PJqSP8wQvGFgta
   w==;
X-CSE-ConnectionGUID: NZlkMxkJQ4GR/AHrdFdyog==
X-CSE-MsgGUID: Ch6k8CxrSa6jDhWXZy7Pzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24081098"
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="24081098"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 05:52:55 -0700
X-CSE-ConnectionGUID: 3rL5n96XTuquq1x4F5taUg==
X-CSE-MsgGUID: vHFif/G9TSuYatS+AF8MJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="64920937"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.0.178])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 05:52:53 -0700
Message-ID: <a7b19646-d44e-4a0d-bf7e-5eea109dd48c@intel.com>
Date: Tue, 3 Sep 2024 15:52:48 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: mmc: Add mmc-test doc
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org
References: <20240903105151.3581457-1-avri.altman@wdc.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240903105151.3581457-1-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/09/24 13:51, Avri Altman wrote:
> Add missing documentation for mmc-test.
> 
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  Documentation/driver-api/mmc/index.rst    |   1 +
>  Documentation/driver-api/mmc/mmc-test.rst | 287 ++++++++++++++++++++++
>  2 files changed, 288 insertions(+)
>  create mode 100644 Documentation/driver-api/mmc/mmc-test.rst
> 
> diff --git a/Documentation/driver-api/mmc/index.rst b/Documentation/driver-api/mmc/index.rst
> index 7339736ac774..8188863e5959 100644
> --- a/Documentation/driver-api/mmc/index.rst
> +++ b/Documentation/driver-api/mmc/index.rst
> @@ -10,4 +10,5 @@ MMC/SD/SDIO card support
>     mmc-dev-attrs
>     mmc-dev-parts
>     mmc-async-req
> +   mmc-test
>     mmc-tools
> diff --git a/Documentation/driver-api/mmc/mmc-test.rst b/Documentation/driver-api/mmc/mmc-test.rst
> new file mode 100644
> index 000000000000..924f87abcb77
> --- /dev/null
> +++ b/Documentation/driver-api/mmc/mmc-test.rst
> @@ -0,0 +1,287 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +========================
> +MMC Test Framework
> +========================
> +
> +Overview
> +========
> +
> +The MMC Test Framework (`mmc_test`) is designed to facilitate testing of MMC (MultiMediaCard) devices. It provides a set of tests and utilities to verify the functionality and performance of MMC devices.

Plus:

Note that whatever is on your card will be overwritten by these tests.

