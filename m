Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HvSLQTUg"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5963293;
	Sun, 19 Nov 2023 22:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700462960; x=1731998960;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UHO3wfmlSf1E4uPDGAZd4a2QtXkOq00AuYR77gFl4qs=;
  b=HvSLQTUgKd9oOTyCT/0IUn4b7KhgNuZwXZiZICvL6U1dSCWM8WqEHz3V
   nsWYTYhIAEMzJsihtX1YBLFkm1jOTomGLo8Au3azH8D2G8QiF8nlPuMn1
   lJaytpe+GNK2SVBgHepS8AUCoFVFzU0aQk8i7DNe5w6IuSDHLYfekoVaB
   U1GER+80VtNkEIgJiYcEBaQ9y5AseC5TAcapWIBpL5amftNo2fpfmsbC3
   7cW4MpBsToYQ3ToVjMK9WdxpdwDnOYHWxiGT3VhLIU32wfE1hu10WEfYZ
   KHn1QUiSLumt2wFn76NYEsM5L7gc6YhkpKp95moZt07D5Ngil2AFMaPsr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="381952770"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="381952770"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 22:49:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="795374748"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="795374748"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.219.253])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 22:49:18 -0800
Message-ID: <47367cdc-f512-4f0d-958f-2d8fbe450cbf@intel.com>
Date: Mon, 20 Nov 2023 08:49:16 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: Enable timeout quirk for
 BlueField-3 SoC
To: Liming Sun <limings@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 David Thompson <davthompson@nvidia.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6082b74cbc681e8c24354828941361f4f4294242.1700315051.git.limings@nvidia.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <6082b74cbc681e8c24354828941361f4f4294242.1700315051.git.limings@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/11/23 15:46, Liming Sun wrote:
> This commit enables SDHCI_QUIRK_BROKEN_TIMEOUT_VAL to solve the
> intermittent eMMC timeout issue reported on some cards under eMMC
> stress test.
> 
> Reported error message:
>   dwcmshc MLNXBF30:00: __mmc_blk_ioctl_cmd: data error -110

Were you able to determine the root cause?  For example,
is the host controller timeout correct, is the eMMC
providing correct timeout values, is the mmc subsystem
calculating a correct value, is sdhci programming a correct
value?

If there are problems outside the host controller then we
need to address them also.

> 
> Signed-off-by: Liming Sun <limings@nvidia.com>

Fixes tag?

> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 3a3bae6948a8..3c8fe8aec558 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -365,7 +365,8 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
>  #ifdef CONFIG_ACPI
>  static const struct sdhci_pltfm_data sdhci_dwcmshc_bf3_pdata = {
>  	.ops = &sdhci_dwcmshc_ops,
> -	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>  		   SDHCI_QUIRK2_ACMD23_BROKEN,
>  };

