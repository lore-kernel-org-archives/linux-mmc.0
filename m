Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B5D27AC44;
	Tue, 22 Jul 2025 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753209237; cv=none; b=X2keS3WOTEI086bXfb2dhW0XqOQtKwQ5BRddMtRK1u6rioGq73XMWlERVDhxb3sBixPcjqlvpu6aPTtualx0T2AiIaGnV2DaXAWNF3oJn4GtR/jBjGXqB1iQSgjEgWWt9PNP7m2Hw7p4mXHBpnIVbpP5FwTfhDuqpnYAXJ9OsK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753209237; c=relaxed/simple;
	bh=Do8f/s41nR8VObMpW0ia4Dw4dU8R3/z+HYjGjI6xSRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mF87J6rv6ZMYmwjfe7toofdJpqVmz7AoiF/pyJTaY6x06lTZT1VhByXMebdTc/+IA8VA8Q/7Bl890TiF4qPBXVvHbox/tWun6Qi/+6Ae0uwq+K/Ohgfzw+DtWmkexeh/fYytfeANSHVbaKbaziO4Bb3SWIxIHP4YGCTsxOd7Gbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34B9E106F;
	Tue, 22 Jul 2025 11:33:45 -0700 (PDT)
Received: from [10.57.0.201] (unknown [10.57.0.201])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2F513F5A1;
	Tue, 22 Jul 2025 11:33:46 -0700 (PDT)
Message-ID: <f81b88df-9959-4968-a60a-b7efd3d5ea24@arm.com>
Date: Tue, 22 Jul 2025 19:33:43 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/8] mmc: sdhci-of-dwcmshc: add common bulk optional
 clocks support
To: Chen Wang <unicornxw@gmail.com>, adrian.hunter@intel.com,
 aou@eecs.berkeley.edu, conor+dt@kernel.org, guoren@kernel.org,
 inochiama@outlook.com, jszhang@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, robh@kernel.org, ulf.hansson@linaro.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
 tingzhu.wang@sophgo.com
Cc: Chen Wang <unicorn_wang@outlook.com>, Drew Fustini <drew@pdp7.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
References: <cover.1722847198.git.unicorn_wang@outlook.com>
 <e57e8c51da81f176b49608269a884f840903e78e.1722847198.git.unicorn_wang@outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <e57e8c51da81f176b49608269a884f840903e78e.1722847198.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

A bit late for a "review", but Diederik and I have just been
IRC-debugging a crash on RK3568 which by inspection seems to be caused
by this patch:

On 2024-08-05 10:17 am, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> In addition to the required core clock and optional
> bus clock, the soc will expand its own clocks, so
> the bulk clock mechanism is abstracted.
> 
> Note, I call the bulk clocks as "other clocks" due
> to the bus clock has been called as "optional".
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> Tested-by: Drew Fustini <drew@pdp7.com> # TH1520
> Tested-by: Inochi Amaoto <inochiama@outlook.com> # Duo and Huashan Pi
> ---
[...]
> +static int dwcmshc_get_enable_other_clks(struct device *dev,
> +					 struct dwcmshc_priv *priv,
> +					 int num_clks,
> +					 const char * const clk_ids[])
> +{
> +	int err;
> +
> +	if (num_clks > DWCMSHC_MAX_OTHER_CLKS)
> +		return -EINVAL;
> +
> +	for (int i = 0; i < num_clks; i++)
> +		priv->other_clks[i].id = clk_ids[i];
> +
> +	err = devm_clk_bulk_get_optional(dev, num_clks, priv->other_clks);

This leaves a pointer into "priv" in the devres list...

> +	if (err) {
> +		dev_err(dev, "failed to get clocks %d\n", err);
> +		return err;
> +	}
> +
> +	err = clk_bulk_prepare_enable(num_clks, priv->other_clks);
> +	if (err)
> +		dev_err(dev, "failed to enable clocks %d\n", err);
> +
> +	priv->num_other_clks = num_clks;
> +
> +	return err;
> +}
> +
>   /*
>    * If DMA addr spans 128MB boundary, we split the DMA transfer into two
>    * so that each DMA transfer doesn't exceed the boundary.
[...]
> @@ -1280,9 +1300,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>   err_clk:
>   	clk_disable_unprepare(pltfm_host->clk);
>   	clk_disable_unprepare(priv->bus_clk);
> -	if (rk_priv)
> -		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
> -					   rk_priv->rockchip_clks);
> +	clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
>   free_pltfm:
>   	sdhci_pltfm_free(pdev);

...but upon, say, -EPROBE_DEFER from sdhci_setup_host() because a
regulator isn't ready yet, that "priv" is freed here, so by the time the
devres callbacks eventually run, that "devres->clks" pointer which used
to represent "priv->other_clocks" points to who knows what, and this
sort of thing happens:

[   12.470827] Unable to handle kernel paging request at virtual address 002df7b378917664
[   12.472104] Mem abort info:
[   12.472471]   ESR = 0x0000000096000004
[   12.475991]   EC = 0x25: DABT (current EL), IL = 32 bits
[   12.476657]   SET = 0, FnV = 0
[   12.477146]   EA = 0, S1PTW = 0
[   12.477547]   FSC = 0x04: level 0 translation fault
[   12.478127] Data abort info:
[   12.478126] rockchip-gpio fdd60000.gpio: probed /pinctrl/gpio@fdd60000
[   12.478413]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[   12.479826]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   12.480418]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   12.481282] [002df7b378917664] address between user and kernel address ranges
[   12.482421] Internal error: Oops: 0000000096000004 [#1]  SMP
[   12.482980] Modules linked in: sdhci_of_dwcmshc drm_dp_aux_bus gpio_rockchip(+) drm_display_helper dw_mmc_rockchip drm_client_lib sdhci_pltfm drm_dma_helper fwnode_mdio sdhci dw_mmc_pltf
m libphy fixed rockchip_dfi drm_kms_helper cqhci pl330(+) phy_rockchip_naneng_combphy dw_wdt phy_rockchip_snps_pcie3 phy_rockchip_inno_usb2 dw_mmc mdio_bus dwc3 ehci_platform ohci_platform
ehci_hcd drm ohci_hcd udc_core io_domain i2c_rk3x usbcore ulpi usb_common
[   12.486871] CPU: 0 UID: 0 PID: 64 Comm: kworker/u16:3 Not tainted 6.16-rc7-arm64-cknow #1 PREEMPTLAZY  Debian 6.16~rc7-1
[   12.487901] Hardware name: FriendlyElec NanoPi R5S (DT)
[   12.488412] Workqueue: async async_run_entry_fn
[   12.488879] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   12.489539] pc : __clk_put+0x2c/0x138
[   12.489913] lr : __clk_put+0x2c/0x138
[   12.490281] sp : ffff800080713b10
[   12.490607] x29: ffff800080713b10 x28: ffff0001f001a120 x27: 0000000000000000
[   12.491302] x26: ffff0001f98e01a0 x25: 0000000000000000 x24: ffff0001f0f35408
[   12.491995] x23: ffffa8da199b4b40 x22: ffff800080713bb0 x21: ffff0001f0f35010
[   12.492689] x20: ffff0001f94aafd0 x19: 0a2df7b378917634 x18: 00000000ffffffff
[   12.493381] x17: 3d4d455453595342 x16: 555300307075656b x15: ffff0001f4885650
[   12.494075] x14: 0000000000000000 x13: ffff0001f025b810 x12: 0000000000008000
[   12.494765] x11: ffffa8da1a73ef98 x10: ffffa8da1a460000 x9 : 0000000000000078
[   12.495454] x8 : 0000000000000049 x7 : ffffa8da18c2fbe0 x6 : 0000000000000001
[   12.496145] x5 : 0000000000000004 x4 : 000000006cb6bb63 x3 : 0000000000000000
[   12.496833] x2 : 0000000000000000 x1 : ffff0001f1365ac0 x0 : 0000000000000001
[   12.497524] Call trace:
[   12.497776]  __clk_put+0x2c/0x138 (P)
[   12.498154]  clk_put+0x18/0x30
[   12.498471]  clk_bulk_put+0x40/0x68
[   12.498825]  devm_clk_bulk_release+0x24/0x40
[   12.499248]  release_nodes+0x64/0xa0
[   12.499608]  devres_release_all+0x98/0xf8
[   12.500004]  device_unbind_cleanup+0x20/0x70
[   12.500426]  really_probe+0x1e8/0x3a0
[   12.500793]  __driver_probe_device+0x84/0x160
[   12.501225]  driver_probe_device+0x44/0x128
[   12.501640]  __driver_attach_async_helper+0x5c/0x108
[   12.502125]  async_run_entry_fn+0x40/0x180
[   12.502535]  process_one_work+0x23c/0x640
[   12.502939]  worker_thread+0x1b4/0x360
[   12.503315]  kthread+0x150/0x250
[   12.503646]  ret_from_fork+0x10/0x20
[   12.504015] Code: aa0003f3 b140041f 540006c8 97ffd9c4 (b9403260)
[   12.504598] ---[ end trace 0000000000000000 ]---


TBH I'm not sure what to do as a straight revert seems impractical by
now, so we hope someone else might have a good idea.

Thanks,
Robin.
