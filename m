Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DED1B85F6;
	Mon, 25 Nov 2024 18:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732559125; cv=none; b=TkfheCVerAingAGnawRZ9g8mW9hNAzqnuddZG4th2zCrX7gKMMUM6Pva/eGYaBXk5KfXsmJvs9wTckg/nDbjDyr11fEbyyid7+jKl364IIuJKZye8vrGjuVd+lZxEIOSBtOugNVJnq4DEuzsPoCvEc+gdAXmISPV01NHAHk2v6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732559125; c=relaxed/simple;
	bh=6aRiboS4Jxrz+jvRtPC54qrBkrsY/RgG6OavSsJocjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qmx6Xz1rWFWdyEVNMeTCj0C4KAfmYeo5zkwKI+uBtv4Ghq6XlR1BlgqGwOI67B6AQzNxirsngdVLWSb1p+ljzNj7hYAPuA5xcphd7ahJMrtkWXZiPBXDpdQSjx7TaxR1Z8d2rNw/5GbV+V439n9igGl5UPu2dA8g3sHiuv9x6hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kuPrOPzs; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kuPrOPzs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732559124; x=1764095124;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6aRiboS4Jxrz+jvRtPC54qrBkrsY/RgG6OavSsJocjI=;
  b=kuPrOPzskyaJ7Ol1sakkPUK+MUqQPEIgxPUeISFRP+F5hxK4qCVJBSwR
   mx3xU33UXY5hgWhSO3f+7KnlH7/q3Yl7SbOg6fa699/6ClmlsFU03X/IQ
   vaJrwCFki6vaOFrGaziwqbc9joFDjsFgPIup8TJ7eqGpSptpQpyWq+aCN
   bbIIwXY2AvFHa8qQa2OWk3ZWpaW9dIGeWXdVy7cjI9sYx3XNwubaoti5j
   FNWvCr7GJzoARZl3ZWib36lt+SFt4bpLItR/ptAImA2/hZy8Nj1eUL+Ey
   LFEWfrQtNFs3faqPHyG9lnxZVqd/II32hHgS+8c6XEKd4q5XywfosOkWN
   g==;
X-CSE-ConnectionGUID: 7g/BMNlaRNCxoobHamNmmg==
X-CSE-MsgGUID: lrpmkxAdQP2w7EusoaAzAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="43751854"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="43751854"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 10:25:00 -0800
X-CSE-ConnectionGUID: INFUjcOqQSy+Joj9bnk6cA==
X-CSE-MsgGUID: OMdoFMV9SvODLT5m/kOgjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="95440526"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.115.59])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 10:24:55 -0800
Message-ID: <8bd461ba-7fbe-4f1b-91cf-d33483cb4930@intel.com>
Date: Mon, 25 Nov 2024 20:24:48 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: enable 'SDHCI_QUIRK_NO_LED' quirk
 for S32G
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>,
 Haibo Chen <haibo.chen@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, imx@lists.linux.dev,
 linux-mmc@vger.kernel.org, s32@nxp.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20241125083357.1041949-1-ciprianmarian.costea@oss.nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241125083357.1041949-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/11/24 10:33, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> Enable 'SDHCI_QUIRK_NO_LED' quirk for S32G2/S32G3 SoCs.
> S32G SDHCI controller does not have a LED signal line.
> 
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index d55d045ef236..e23177ea9d91 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -304,6 +304,7 @@ static struct esdhc_soc_data usdhc_s32g2_data = {
>  			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>  			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
>  			| ESDHC_FLAG_SKIP_ERR004536 | ESDHC_FLAG_SKIP_CD_WAKE,
> +	.quirks = SDHCI_QUIRK_NO_LED,
>  };
>  
>  static struct esdhc_soc_data usdhc_imx7ulp_data = {

