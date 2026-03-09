Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C04358380;
	Mon,  9 Mar 2026 06:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773038067; cv=none; b=hTtRtZX8U45lt+4AbkpKhK+dpiN4S0BaP5J4cC67Z2hvfUFahTW/VXr6VchyCCDXjWqESVEq5LgJE4SOKg776thNBvv0nmRES5reO0sZ5wL5Hbf6YYtRbM+TWEloj0IXdmeyl7WIV1Uq7/Cpv6rzQBrViFhc+Wd6P0jnDOYm3KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773038067; c=relaxed/simple;
	bh=3Wnjim6yO+itYQGtawQz3xTRie9Znb5BqvmJhBhwVYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ae1Psti1rypxRWMXwWcXGuSeyb9Hcg4ZnJjwMLcX2UzglktOgX7n9Af5G1Ied90pjzWIXDsZlwtm33sxOcnbxNA8CyvZ3Q+4k9sP2Qfm/WVG/ysS/qEpiGuxWE3LCA1OKEm/M3PZgngjfuRLVZ4xv2xKuJtBM/9BW3FiVQvijV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id AC5C4335DB5;
	Mon, 09 Mar 2026 06:34:23 +0000 (UTC)
Date: Mon, 9 Mar 2026 14:34:16 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] mmc: sdhci-of-k1: add regulator framework support
Message-ID: <20260309063416-GYB318052@gentoo.org>
References: <20260302-orangepi-sd-card-uhs-v1-0-89c219973c0c@gmail.com>
 <20260302-orangepi-sd-card-uhs-v1-3-89c219973c0c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-orangepi-sd-card-uhs-v1-3-89c219973c0c@gmail.com>

Hi IKer,

On 16:13 Mon 02 Mar     , Iker Pedrosa wrote:
> Add regulator framework support for voltage switching operations. This
> enables proper PMIC control for UHS voltage switching between 3.3V and
> 1.8V signaling levels.
> 
> - Add regulator supply parsing
> - Implement voltage switching callback
> - Enable mmc regulator framework integration
> 
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
>  drivers/mmc/host/sdhci-of-k1.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
> index b703b78282ed8d89183c816477c149c0a565618a..c260cb89704ae7a25bec0f07831d495553405bbd 100644
> --- a/drivers/mmc/host/sdhci-of-k1.c
> +++ b/drivers/mmc/host/sdhci-of-k1.c
> @@ -216,6 +216,12 @@ static void spacemit_sdhci_pre_hs400_to_hs200(struct mmc_host *mmc)
>  			       SPACEMIT_SDHC_PHY_CTRL_REG);
>  }
>  
> +static int spacemit_sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> +						      struct mmc_ios *ios)
> +{
> +	return sdhci_start_signal_voltage_switch(mmc, ios);
> +}
I'd suggest to implement voltage_switch() instead of start_signal_voltage_switch(),
and put the pinctrl state switch here, which will be called by
start_signal_voltage_switch(), see drivers/mmc/host/sdhci.c for more detail

sdhci_start_signal_voltage_switch() -> voltage_switch()

static const struct sdhci_ops spacemit_sdhci_ops = {
..
	.voltage_switch         = spacemit_sdhci_voltage_switch,
..

> +
>  static inline int spacemit_sdhci_get_clocks(struct device *dev,
>  					    struct sdhci_pltfm_host *pltfm_host)
>  {
> @@ -291,6 +297,12 @@ static int spacemit_sdhci_probe(struct platform_device *pdev)
>  
>  	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
>  
..
> +	ret = mmc_regulator_get_supply(host->mmc);
I think this is unnecessary which already handled in core framework, see
spacemit_sdhci_probbe() -> sdhci_add_host() -> sdhci_setup_host()

https://github.com/torvalds/linux/blob/v7.0-rc3/drivers/mmc/host/sdhci.c#L4289

> +	if (ret)
> +		dev_warn(dev, "Failed to get regulators: %d\n", ret);
> +
> +	host->mmc_host_ops.start_signal_voltage_switch = spacemit_sdhci_start_signal_voltage_switch;
> +
with above, this line can be dropped too

>  	ret = spacemit_sdhci_get_clocks(dev, pltfm_host);
>  	if (ret)
>  		goto err_pltfm;
> 
> -- 
> 2.53.0
> 

-- 
Yixun Lan (dlan)
