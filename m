Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7057729405;
	Fri, 16 May 2025 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747401463; cv=none; b=cpKhpsUEfjQf3UrLq+eq1S142RPJg0cfyRf85v7JBPS7pRbvXrf85kdCj01lGhVMWtshRj4ZZr5PLUy3etigZnvMPGif80Dulti8Y/MrDge6coyVn2QSPX/y/Iy7Fb3SoATtn8nob0ml4q5sOvWSOD1gHDXpNM7C69PTsrqC7CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747401463; c=relaxed/simple;
	bh=WaeCnVBazQ+YlcBWxAdDSDvj9AsqW9s0Dw/UGULgngY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yr1gPYLaBacbH2B8iI5bW5WQLqBDCx9OfiKxR0OIFw5iKBCCzoh+oH9tlHS+gZzmqO8NFdnideRFzeBZaidUfA/6rvBfpbxEFlbpjeeIEpShhkmLS2AVF/CUD1yVKEFq1UmFbkm7d4hRfyifq9w4z8N8zDtisnLoODvgrJ6eLVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1ezGQT+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1ezGQT+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F482C4CEE4;
	Fri, 16 May 2025 13:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747401463;
	bh=WaeCnVBazQ+YlcBWxAdDSDvj9AsqW9s0Dw/UGULgngY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L1ezGQT+JmrNZJauTjpvV2Q4ADhQBcbCfrmtpv/q8h5oJt8m+2kaWXGEo7XcttxCA
	 LSo3E84yYZIoQGGT5F7C8Rm2xiqt4gcuARDO+6YZv1ciFWG7oiRalVDg23iL/p1HE5
	 WwfD/ziAODaPhw5oAehb+1a7NfC3fXhSDYGUaqcN8isNcpfmFe5J9+tUxn4gLwZhIw
	 0pKydHTIqdvB9GqUmHR9K8zlxp1erohaj9hnrM7Zq5uqRt3oQtRKrMphvOmyEGxGOt
	 McRvcTmIGlICejAtCPKFFl5bUGlu281xxwyAjfCe6KgSOE54NjAX9QLEa2LSEC+r32
	 xqu0ZAMfCZA9w==
Message-ID: <15bbeaaf-6dcc-49ce-baff-03692fcb90a9@kernel.org>
Date: Fri, 16 May 2025 15:17:37 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] sdhci: eswin: Add eic7700 sdhci driver
To: dongxuyang@eswincomputing.com, ulf.hansson@linaro.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 adrian.hunter@intel.com, p.zabel@pengutronix.de, shanchun1218@gmail.com
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
 xuxiang@eswincomputing.com
References: <20250516091259.774-1-dongxuyang@eswincomputing.com>
 <20250516091727.887-1-dongxuyang@eswincomputing.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250516091727.887-1-dongxuyang@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/05/2025 11:17, dongxuyang@eswincomputing.com wrote:
> +	if (of_property_read_u32(np, "#clock-cells", &num_clks) < 0)
> +		return 0;
> +
> +	ret = eswin_sdhci_sdio_register_sdcardclk(eswin_sdhci_sdio, clk_xin,
> +						  dev);
> +	if (ret)
> +		return ret;
> +
> +	if (num_clks) {
> +		ret = eswin_sdhci_sdio_register_sampleclk(eswin_sdhci_sdio,
> +							  clk_xin, dev);
> +		if (ret) {
> +			eswin_sdhci_sdio_unregister_sdclk(dev);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int eswin_sdhci_sdio_add_host(struct eswin_sdhci_data *eswin_sdhci_sdio)
> +{
> +	struct sdhci_host *host = eswin_sdhci_sdio->host;

Why do you have two probes for one driver?

> +	struct cqhci_host *cq_host;
> +	bool dma64;
> +	int ret;
> +
> +	if (!eswin_sdhci_sdio->has_cqe)
> +		return sdhci_add_host(host);
> +
> +	ret = sdhci_setup_host(host);
> +	if (ret)
> +		return ret;
> +
> +	cq_host = devm_kzalloc(host->mmc->parent, sizeof(*cq_host), GFP_KERNEL);
> +	if (!cq_host) {
> +		ret = -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	cq_host->mmio = host->ioaddr + ESWIN_SDHCI_SD_CQE_BASE_ADDR;
> +	cq_host->ops = &eswin_sdhci_sdio_cqhci_ops;
> +
> +	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
> +	if (dma64)
> +		cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
> +
> +	ret = cqhci_init(cq_host, host->mmc, dma64);
> +	if (ret)
> +		goto cleanup;
> +
> +	ret = __sdhci_add_host(host);
> +	if (ret)
> +		goto cleanup;
> +
> +	return 0;
> +
> +cleanup:
> +	sdhci_cleanup_host(host);
> +	return ret;
> +}
> +
> +static int eswin_sdhci_sdio_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct clk *clk_xin;
> +	struct clk *clk_spll2_fout3;
> +	struct clk *clk_mux;
> +	struct sdhci_host *host;
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct eswin_sdhci_data *eswin_sdhci_sdio;
> +	const struct eswin_sdhci_of_data *data;
> +	unsigned int val = 0;
> +
> +	data = of_device_get_match_data(dev);
> +	host = sdhci_pltfm_init(pdev, data->pdata, sizeof(*eswin_sdhci_sdio));
> +
> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +
> +	pltfm_host = sdhci_priv(host);
> +	eswin_sdhci_sdio = sdhci_pltfm_priv(pltfm_host);
> +	eswin_sdhci_sdio->host = host;
> +	eswin_sdhci_sdio->has_cqe = false;
> +
> +	sdhci_get_of_property(pdev);
> +
> +	eswin_sdhci_sdio->clk_ops = data->clk_ops;
> +	eswin_sdhci_sdio->clk_ahb = devm_clk_get(dev, "clk_ahb");
> +	if (IS_ERR(eswin_sdhci_sdio->clk_ahb)) {
> +		ret = dev_err_probe(dev, PTR_ERR(eswin_sdhci_sdio->clk_ahb),
> +				    "clk_ahb clock not found.\n");
> +		goto err_pltfm_free;
> +	}
> +
> +	clk_xin = devm_clk_get(dev, "clk_xin");
> +	if (IS_ERR(clk_xin)) {
> +		ret = dev_err_probe(dev, PTR_ERR(clk_xin),
> +				    "clk_xin clock not found.\n");
> +		goto err_pltfm_free;
> +	}
> +
> +	clk_spll2_fout3 = devm_clk_get(dev, "clk_spll2_fout3");
> +
> +	if (IS_ERR(clk_spll2_fout3)) {
> +		ret = dev_err_probe(dev, PTR_ERR(clk_spll2_fout3),
> +				    "clk_spll2_fout3 clock not found.\n");
> +		goto err_pltfm_free;
> +	}
> +
> +	if (of_device_is_compatible(np, "eswin,sdhci-sdio")) {
> +		clk_mux = devm_clk_get(dev, "clk_mux1_1");
> +		if (IS_ERR(clk_mux)) {
> +			ret = dev_err_probe(dev, PTR_ERR(clk_mux),
> +					    "clk_mux1_1 clock not found.\n");
> +			goto err_pltfm_free;
> +		}
> +		/*switch the core clk source*/
> +		clk_set_parent(clk_mux, clk_spll2_fout3);
> +	}
> +
> +	ret = clk_prepare_enable(eswin_sdhci_sdio->clk_ahb);
> +	if (ret) {
> +		dev_err(dev, "Unable to enable AHB clock.\n");
> +		goto err_pltfm_free;
> +	}
> +	/* If clock-frequency property is set, use the provided value */
> +	if (pltfm_host->clock && pltfm_host->clock != clk_get_rate(clk_xin)) {
> +		ret = clk_set_rate(clk_xin, pltfm_host->clock);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Failed to set SD clock rate\n");
> +			goto clk_dis_ahb;
> +		}
> +	}
> +
> +	ret = clk_prepare_enable(clk_xin);
> +	if (ret) {
> +		dev_err(dev, "Unable to enable SD clock.\n");
> +		goto clk_dis_ahb;
> +	}
> +
> +	pltfm_host->clk = clk_xin;
> +	ret = eswin_sdhci_sdio_register_sdclk(eswin_sdhci_sdio, clk_xin, dev);
> +	if (ret)
> +		goto clk_disable_all;
> +
> +	ret = eswin_sdhci_reset_init(dev, eswin_sdhci_sdio);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to reset\n");
> +		goto clk_disable_all;
> +	}
> +
> +	eswin_sdhci_sdio->crg_regmap = syscon_regmap_lookup_by_phandle(
> +		pdev->dev.of_node, "eswin,syscrg_csr");
> +	if (IS_ERR(eswin_sdhci_sdio->crg_regmap)) {
> +		dev_dbg(&pdev->dev, "No syscrg_csr phandle specified\n");
> +		goto clk_disable_all;
> +	}
> +
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,syscrg_csr",
> +					 1, &eswin_sdhci_sdio->crg_core_clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "can't get crg_core_clk (%d)\n", ret);
> +		goto clk_disable_all;
> +	}
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,syscrg_csr",
> +					 2, &eswin_sdhci_sdio->crg_aclk_ctrl);
> +	if (ret) {
> +		dev_err(&pdev->dev, "can't get crg_aclk_ctrl (%d)\n", ret);
> +		goto clk_disable_all;
> +	}
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,syscrg_csr",
> +					 3, &eswin_sdhci_sdio->crg_cfg_ctrl);
> +	if (ret) {
> +		dev_err(&pdev->dev, "can't get crg_cfg_ctrl (%d)\n", ret);
> +		goto clk_disable_all;
> +	}
> +
> +	eswin_sdhci_sdio->hsp_regmap = syscon_regmap_lookup_by_phandle(
> +		dev->of_node, "eswin,hsp_sp_csr");
> +	if (IS_ERR(eswin_sdhci_sdio->hsp_regmap)) {
> +		dev_dbg(dev, "No hsp_sp_csr phandle specified\n");
> +		goto clk_disable_all;
> +	}
> +
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,hsp_sp_csr",
> +					 2, &eswin_sdhci_sdio->hsp_int_status);
> +	if (ret) {
> +		dev_err(&pdev->dev, "can't get hsp_int_status (%d)\n", ret);
> +		goto clk_disable_all;
> +	}
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,hsp_sp_csr",
> +					 3, &eswin_sdhci_sdio->hsp_pwr_ctrl);
> +	if (ret) {
> +		dev_err(&pdev->dev, "can't get hsp_pwr_ctrl (%d)\n", ret);
> +		goto clk_disable_all;
> +	}
> +
> +	regmap_write(eswin_sdhci_sdio->hsp_regmap,
> +		     eswin_sdhci_sdio->hsp_int_status, MSHC_INT_CLK_STABLE);
> +	regmap_write(eswin_sdhci_sdio->hsp_regmap,
> +		     eswin_sdhci_sdio->hsp_pwr_ctrl, MSHC_HOST_VAL_STABLE);
> +
> +	if (!of_property_read_u32(dev->of_node, "delay_code", &val))
> +		eswin_sdhci_sdio->phy.delay_code = val;
> +
> +	if (!of_property_read_u32(dev->of_node, "drive-impedance-ohm", &val))
> +		eswin_sdhci_sdio->phy.drive_impedance =
> +			eswin_convert_drive_impedance_ohm(pdev, val);
> +
> +	if (of_property_read_bool(dev->of_node, "enable-cmd-pullup"))
> +		eswin_sdhci_sdio->phy.enable_cmd_pullup = ENABLE;
> +	else
> +		eswin_sdhci_sdio->phy.enable_cmd_pullup = DISABLE;
> +
> +	if (of_property_read_bool(dev->of_node, "enable-data-pullup"))
> +		eswin_sdhci_sdio->phy.enable_data_pullup = ENABLE;
> +	else
> +		eswin_sdhci_sdio->phy.enable_data_pullup = DISABLE;
> +
> +	eswin_sdhci_dt_parse_clk_phases(dev, &eswin_sdhci_sdio->clk_data);
> +	ret = mmc_of_parse(host->mmc);
> +	if (ret) {
> +		ret = dev_err_probe(dev, ret, "parsing dt failed.\n");
> +		goto unreg_clk;
> +	}
> +
> +	ret = eswin_sdhci_sdio_add_host(eswin_sdhci_sdio);
> +	if (ret)
> +		goto unreg_clk;
> +
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_suspend_ignore_children(&pdev->dev, 1);
> +	pm_runtime_enable(&pdev->dev);
> +
> +	return 0;
> +
> +unreg_clk:
> +	eswin_sdhci_sdio_unregister_sdclk(dev);
> +clk_disable_all:
> +	clk_disable_unprepare(clk_xin);
> +clk_dis_ahb:
> +	clk_disable_unprepare(eswin_sdhci_sdio->clk_ahb);
> +err_pltfm_free:
> +	sdhci_pltfm_free(pdev);
> +	return ret;
> +}


....

> +
> +static int eswin_sdhci_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct clk *clk_xin;
> +	struct sdhci_host *host;
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct device *dev = &pdev->dev;
> +	struct eswin_sdhci_data *eswin_sdhci;
> +	const struct eswin_sdhci_of_data *data;
> +	unsigned int val = 0;
> +
> +	data = of_device_get_match_data(dev);
> +	host = sdhci_pltfm_init(pdev, data->pdata, sizeof(*eswin_sdhci));
> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +
> +	pltfm_host = sdhci_priv(host);
> +	eswin_sdhci = sdhci_pltfm_priv(pltfm_host);
> +	eswin_sdhci->host = host;
> +	eswin_sdhci->clk_ops = data->clk_ops;
> +
> +	eswin_sdhci->clk_ahb = devm_clk_get(dev, "clk_ahb");

Undocumented ABI

Anyway, drop clk_ in property name.

> +	if (IS_ERR(eswin_sdhci->clk_ahb)) {
> +		ret = dev_err_probe(dev, PTR_ERR(eswin_sdhci->clk_ahb),
> +				    "clk_ahb clock not found.\n");
> +		goto err_pltfm_free;
> +	}
> +
> +	clk_xin = devm_clk_get(dev, "clk_xin");

drop clk_ in property name.

> +	if (IS_ERR(clk_xin)) {
> +		ret = dev_err_probe(dev, PTR_ERR(clk_xin),
> +				    "clk_xin clock not found.\n");
> +		goto err_pltfm_free;
> +	}
> +
> +	ret = clk_prepare_enable(eswin_sdhci->clk_ahb);

So just use devm_clk_get_enabled.

> +	if (ret) {
> +		dev_err(dev, "Unable to enable AHB clock.\n");
> +		goto err_pltfm_free;
> +	}
> +
> +	ret = clk_prepare_enable(clk_xin);
> +	if (ret) {
> +		dev_err(dev, "Unable to enable SD clock.\n");
> +		goto clk_dis_ahb;
> +	}
> +
> +	ret = eswin_sdhci_reset_init(dev, eswin_sdhci);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to reset\n");
> +		goto clk_disable_all;
> +	}
> +
> +	eswin_sdhci->crg_regmap = syscon_regmap_lookup_by_phandle(

Use wrapper for getting the arguments.

> +		pdev->dev.of_node, "eswin,syscrg_csr");
> +	if (IS_ERR(eswin_sdhci->crg_regmap)) {
> +		dev_dbg(&pdev->dev, "No syscrg_csr phandle specified\n");
> +		goto clk_disable_all;
> +	}
> +
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,syscrg_csr",
> +					 1, &eswin_sdhci->crg_core_clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "can't get crg_core_clk (%d)\n", ret);
> +		goto clk_disable_all;
> +	}
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,syscrg_csr",
> +					 2, &eswin_sdhci->crg_aclk_ctrl);
> +	if (ret) {
> +		dev_err(&pdev->dev, "can't get crg_aclk_ctrl (%d)\n", ret);
> +		goto clk_disable_all;
> +	}
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,syscrg_csr",
> +					 3, &eswin_sdhci->crg_cfg_ctrl);
> +	if (ret) {
> +		dev_err(&pdev->dev, "can't get crg_cfg_ctrl (%d)\n", ret);
> +		goto clk_disable_all;
> +	}
> +
> +	eswin_sdhci->hsp_regmap = syscon_regmap_lookup_by_phandle(
> +		dev->of_node, "eswin,hsp_sp_csr");
> +	if (IS_ERR(eswin_sdhci->hsp_regmap)) {
> +		dev_dbg(dev, "No hsp_sp_csr phandle specified\n");
> +		goto clk_disable_all;
> +	}
> +
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,hsp_sp_csr",
> +					 2, &eswin_sdhci->hsp_int_status);
> +	if (ret) {
> +		dev_err(&pdev->dev, "can't get hsp_int_status (%d)\n", ret);
> +		goto clk_disable_all;
> +	}
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,hsp_sp_csr",
> +					 3, &eswin_sdhci->hsp_pwr_ctrl);
> +	if (ret) {
> +		dev_err(&pdev->dev, "can't get hsp_pwr_ctrl (%d)\n", ret);
> +		goto clk_disable_all;
> +	}
> +
> +	regmap_write(eswin_sdhci->hsp_regmap, eswin_sdhci->hsp_int_status,
> +		     MSHC_INT_CLK_STABLE);
> +	regmap_write(eswin_sdhci->hsp_regmap, eswin_sdhci->hsp_pwr_ctrl,
> +		     MSHC_HOST_VAL_STABLE);
> +
> +	if (!of_property_read_u32(dev->of_node, "delay_code", &val))

NAK, undocumented ABI.

> +		eswin_sdhci->phy.delay_code = val;
> +
> +	if (!of_property_read_u32(dev->of_node, "drive-impedance-ohm", &val))

NAK

> +		eswin_sdhci->phy.drive_impedance =
> +			eswin_convert_drive_impedance_ohm(pdev, val);
> +
> +	if (of_property_read_bool(dev->of_node, "enable-cmd-pullup"))

NAK

> +		eswin_sdhci->phy.enable_cmd_pullup = ENABLE;
> +	else
> +		eswin_sdhci->phy.enable_cmd_pullup = DISABLE;
> +
> +	if (of_property_read_bool(dev->of_node, "enable-data-pullup"))

NAK


> +		eswin_sdhci->phy.enable_data_pullup = ENABLE;
> +	else
> +		eswin_sdhci->phy.enable_data_pullup = DISABLE;
> +
> +	if (of_property_read_bool(dev->of_node, "enable-strobe-pulldown"))
> +		eswin_sdhci->phy.enable_strobe_pulldown = ENABLE;
> +	else
> +		eswin_sdhci->phy.enable_strobe_pulldown = DISABLE;
> +
> +	sdhci_get_of_property(pdev);
> +
> +	pltfm_host->clk = clk_xin;
> +
> +	ret = eswin_sdhci_register_sdclk(eswin_sdhci, clk_xin, dev);
> +	if (ret)
> +		goto clk_disable_all;
> +
> +	eswin_sdhci_dt_parse_clk_phases(dev, &eswin_sdhci->clk_data);
> +
> +	ret = mmc_of_parse(host->mmc);
> +	if (ret) {
> +		ret = dev_err_probe(dev, ret, "parsing dt failed.\n");
> +		goto unreg_clk;
> +	}
> +
> +	if (of_device_is_compatible(dev->of_node, "eswin,sdhci-5.1")) {

NAK, there is no such compatible. If you tested your DTS, you would spot it.

This driver is in really poor shape.

> +		host->mmc_host_ops.hs400_enhanced_strobe =
> +			eswin_sdhci_hs400_enhanced_strobe;
> +		eswin_sdhci->has_cqe = true;
> +		host->mmc->caps2 |= MMC_CAP2_CQE;
> +
> +		if (!of_property_read_bool(dev->of_node, "disable-cqe-dcmd"))
> +			host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
> +	}
> +
> +	sdhci_enable_v4_mode(eswin_sdhci->host);
> +
> +	ret = eswin_sdhci_add_host(eswin_sdhci);
> +	if (ret)
> +		goto unreg_clk;
> +
> +	return 0;
> +
> +unreg_clk:
> +	eswin_sdhci_unregister_sdclk(dev);
> +clk_disable_all:
> +	clk_disable_unprepare(clk_xin);
> +clk_dis_ahb:
> +	clk_disable_unprepare(eswin_sdhci->clk_ahb);
> +err_pltfm_free:
> +	sdhci_pltfm_free(pdev);
> +	return ret;
> +}
> +
> +static void eswin_sdhci_remove(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct eswin_sdhci_data *eswin_sdhci = sdhci_pltfm_priv(pltfm_host);
> +	struct clk *clk_ahb = eswin_sdhci->clk_ahb;
> +
> +	sdhci_pltfm_remove(pdev);
> +
> +	if (eswin_sdhci->txrx_rst) {
> +		ret = reset_control_assert(eswin_sdhci->txrx_rst);
> +		WARN_ON(ret != 0);

Drop. You can print some useful error msg, but you cannot have WARNs. It
not useful at all.


Best regards,
Krzysztof
