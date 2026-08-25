Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3A63FF1B5;
	Tue, 25 Aug 2026 11:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657923; cv=none; b=QkHxY2B5vyyikIcA9n/bWrAHbJF4FvUyYH9jFuOpybGy3IMx9+8dsovQ/diPNPG/xCbxTKgkKEuPRRDK3JEr2HerpncCCf2/4dUr4rDCzWesXj8QEKM72mYx8qmvUI/7RVUbTZL8GHU0C+pUkxA08BIRNqK9pz7TSdIim/x9vPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657923; c=relaxed/simple;
	bh=XrK1FoTy7bStmvPEdH9i7YgI3GVbgjtUO+DQ+0miFqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NwkmWQPjK6w+s/I2It8ZnhLwdfkpbk1aSupdtFopFjuknxpFRULNdb5T6M/CBWbY3TwV0jajnLl66ACOTKbZOVXTqiLMqZRjtw4oitFK25yQ5nlilq83S4Nu+Eo02PEwDhhs7Mqk8Homnh6xpBYnY7hbj2vRao+SsNNy97wWBvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdSbmOK9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdSbmOK9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA671F000E9;
	Tue, 25 Aug 2026 11:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787657922;
	bh=hfAz0lmNWjCpnbTFBMb785/r6Eq03EkY7I1r1n+4OeM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PdSbmOK9OLNLDMyij418TNAJLodlVu/fmnQsp4P+YBtMVmOq/yK+0DXZJvez1Gm93
	 sZMKMza5rWwitYV6lmCG18rFuG4Vgy6D6aQpf/hNw2SRf+DC3ekkncFAC06HFxa/ag
	 7dSVHjScOFcwiZZxVYCU5u2XYySipz4x+wOhDWuxpQFOHSgRTKtgxfOlwItVHX+pVi
	 cGMm7npO9rZgA42SMnz8Tlnf3FjXG0Yi4b8cgw7nBiy+msCV0LWd4IXy4d28fLGbDY
	 JGVLXqf+ugzfTurNltNAWtwb1gu59/ll4s5Ef9B/43OAtbhNpLhE3pKNsN7rVoNWmF
	 RlCojBSPgKg0Q==
Message-ID: <c5a4b16d-c55b-4448-91ee-fbc5956bcd21@kernel.org>
Date: Tue, 25 Aug 2026 13:38:35 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] mmc: sdhci-cadence: Add CQE support
To: rohan1sj@cadence.com, Ulf Hansson <ulfh@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mparab@cadence.com, pawell@cadence.com,
 sjakhade@cadence.com, mpillai@cadence.com, razb@mobileye.com, blarson@amd.com
References: <20260825-cdns_sdhci_cqe-support-v4-0-e9f72e338373@cadence.com>
 <20260825-cdns_sdhci_cqe-support-v4-2-e9f72e338373@cadence.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260825-cdns_sdhci_cqe-support-v4-2-e9f72e338373@cadence.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/08/2026 13:10, Rohan Joshi via B4 Relay wrote:
> From: Rohan Joshi <rohan1sj@cadence.com>
> 
> Cadence host controller has optional CQE (Command Queue Engine).
> The HW presence of CQE is determined by an additional host capability
> register. Look up for "cqhci" register space from the DT and when
> present, initialize CQHCI engine.
> 
> Signed-off-by: Rohan Joshi <rohan1sj@cadence.com>
> ---
>  drivers/mmc/host/Kconfig         |   1 +
>  drivers/mmc/host/sdhci-cadence.c | 125 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 122 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 4f060d3e5636..2cc8133e8ef3 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -293,6 +293,7 @@ config MMC_SDHCI_CADENCE
>  	depends on MMC_SDHCI_PLTFM
>  	depends on OF
>  	select MMC_SDHCI_IO_ACCESSORS
> +	select MMC_CQHCI
>  	help
>  	  This selects the Cadence SD/SDIO/eMMC driver.
>  
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 435603c8c00b..aa4431ef2b39 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -15,6 +15,8 @@
>  #include <linux/reset.h>
>  
>  #include "sdhci-pltfm.h"
> +#include "sdhci-cqhci.h"
> +#include "cqhci.h"
>  
>  /* HRS - Host Register Set (specific to Cadence) */
>  #define SDHCI_CDNS_HRS04		0x10		/* PHY access port */
> @@ -36,6 +38,10 @@
>  #define   SDHCI_CDNS_HRS06_MODE_MMC_HS400	0x5
>  #define   SDHCI_CDNS_HRS06_MODE_MMC_HS400ES	0x6
>  
> +/* Host capabilities not covered by the standard capability registers (SRS16-SRS18) */
> +#define SDHCI_CDNS_HRS30		0x78	/* Host capabilities */
> +#define SDHCI_CDNS_HRS30_CQE_SUPPORTED	BIT(0)
> +
>  /* Read block gap */
>  #define SDHCI_CDNS_HRS37		0x94	/* interface mode select */
>  #define   SDHCI_CDNS_HRS37_MODE_DS		0x0
> @@ -88,6 +94,7 @@ struct sdhci_cdns_priv {
>  	void __iomem *ctl_addr;	/* write control */
>  	spinlock_t wrlock;	/* write lock */
>  	bool enhanced_strobe;
> +	bool cqe_support;	/* Command Queuing Engine support */
>  	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
>  	struct reset_control *rst_hw;
>  	unsigned int nr_phy_params;
> @@ -385,6 +392,68 @@ static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
>  		sdhci_set_uhs_signaling(host, timing);
>  }
>  
> +static u32 sdhci_cdns_cqhci_irq(struct sdhci_host *host, u32 intmask)
> +{
> +	int cmd_err = 0;
> +	int data_err = 0;
> +
> +	/* return original intmask to be handled by other handlers if it's not a CQE interrupt */
> +	if (!sdhci_cqe_irq(host, intmask, &cmd_err, &data_err))
> +		return intmask;
> +
> +	cqhci_irq(host->mmc, cmd_err, data_err);
> +
> +	return 0;
> +}
> +
> +static const struct cqhci_host_ops sdhci_cdns_cqhci_ops = {
> +	.enable		= sdhci_cqe_enable,
> +	.disable	= sdhci_cqe_disable,
> +};
> +
> +static int sdhci_cdns_cqe_add_host(struct sdhci_host *host, struct platform_device *pdev)
> +{
> +	struct cqhci_host *cq_host;
> +	bool dma64;
> +	int ret;
> +
> +	ret = sdhci_setup_host(host);
> +	if (ret)
> +		return ret;
> +
> +	cq_host = cqhci_pltfm_init(pdev);
> +	if (IS_ERR(cq_host)) {
> +		ret = PTR_ERR(cq_host);
> +		dev_err_probe(&pdev->dev, ret, "cqhci platform init failed\n");

If this is probe path, why aren't you using standard syntax:
ret = dev_err_probe?

> +		goto cleanup;
> +	}
> +
> +	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
> +	if (dma64)
> +		cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
> +
> +	cq_host->ops = &sdhci_cdns_cqhci_ops;
> +
> +	host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
> +
> +	ret = cqhci_init(cq_host, host->mmc, dma64);
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret, "cqhci init failed\n");
> +		goto cleanup;
> +	}
> +
> +	/* add host to MMC subsystem */
> +	ret = __sdhci_add_host(host);
> +	if (ret)
> +		goto cleanup;
> +
> +	return 0;


Best regards,
Krzysztof
