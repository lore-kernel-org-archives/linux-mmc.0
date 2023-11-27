Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AD1FB8;
	Mon, 27 Nov 2023 05:36:09 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD0D12F4;
	Mon, 27 Nov 2023 05:36:56 -0800 (PST)
Received: from [10.57.71.110] (unknown [10.57.71.110])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBB583F5A1;
	Mon, 27 Nov 2023 05:36:07 -0800 (PST)
Message-ID: <3912dd1e-b15b-49a9-9c91-88e00e986efd@arm.com>
Date: Mon, 27 Nov 2023 13:36:05 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: Enable timeout quirk for
 BlueField-3 SoC
Content-Language: en-US
To: Liming Sun <limings@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, David Thompson <davthompson@nvidia.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6082b74cbc681e8c24354828941361f4f4294242.1700315051.git.limings@nvidia.com>
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <6082b74cbc681e8c24354828941361f4f4294242.1700315051.git.limings@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/11/2023 13:46, Liming Sun wrote:
> This commit enables SDHCI_QUIRK_BROKEN_TIMEOUT_VAL to solve the
> intermittent eMMC timeout issue reported on some cards under eMMC
> stress test.
> 
> Reported error message:
>   dwcmshc MLNXBF30:00: __mmc_blk_ioctl_cmd: data error -110
> 
> Signed-off-by: Liming Sun <limings@nvidia.com>
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

__mmc_blk_ioctl_cmd: data error ?
What stresstest are you running that issues ioctl commands?
On which commands does the timeout occur?
Anyway you should be able to increase the timeout in ioctl structure
directly, i.e. in userspace, or does that not work?
