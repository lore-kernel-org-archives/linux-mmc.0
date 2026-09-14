Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5B743A7F2;
	Mon, 14 Sep 2026 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395326; cv=none; b=JufxhXhQXZjLQMDcgiw34+xlEOLzCs9Rw1o4br2pcVgdc1rdwNPFkbXY1bXW9uUfAi8GxEN5zSbkniBL2q1/29MaTJlpAb99wj5Yd1pg6VFYtXJP+t0/ZFo+5M71gO0uUx2kNGu89ndsHWftyzTTolqBm+ttVJk7sfWT28aDE7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395326; c=relaxed/simple;
	bh=LLp7SRJCJil3jKQyBrx5kqLbpNRcXwIPNhCIaK9/AqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZsOfZpGRgwITL6xZPOTkdybstMeYWB5BMmAn89Wi9WHva3I46ATRfTFjDn7aJKYoqgly24QDhDH8Vg2tBQaAEoijCPRaaDT7TA1ZZWIgGL/rUa4yZed8lsjQOGxUlx7yYaLsMMQu5SiPLk5WM/QTRYc6oQ5v74evpxOYAuIZtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfsEWMQD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfsEWMQD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40FD1F000FF;
	Mon, 14 Sep 2026 14:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789395324;
	bh=NKqcjGct+eUYDqDO+z5tPRvHdSbBaPD9daayrfidjpI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cfsEWMQDZmt9/TaeWAwAvlJc2N8UhUGXWjB2MqRq5a02Y1zqJOTbdJtIXLpbfBjLr
	 EbD0eJtCPuytMu3rE5xMhLFYo3CrOoEENR+j43PR5Z751Qbf2me44reBICcHe6co8G
	 op5xnCMqzUSHr0as8quDCLy+ayH88qYzSgQui7fQloN+OeqKKE97XniCGpe9KtyvO8
	 WV6Dmvt1tSAcP4QUCh647X695Gyi3UyS6DkgpHytTPPBGoAGrMWa+tgaxO02N6ePim
	 HEaO4+08lVMqhE8VPXLpI2oc+/YzZB2xhErRXhBhCKLwaULDfL8J2R5GBFCsFu1enL
	 FJiJpAbhvZ9Jw==
Message-ID: <85e04f9e-e326-4fcc-90ad-3b23c988c6b6@kernel.org>
Date: Mon, 14 Sep 2026 09:15:22 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/9] mmc: sdhci-cadence: add SD6HC support and Agilex5
 enablement
Content-Language: en-US
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: linux-mmc@vger.kernel.org, ulfh@kernel.org, adrian.hunter@intel.com,
 krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260901184828.15653-1-tanmay.kathpalia@altera.com>
 <CAPx+jO_6bH8i5BV=64i=dLdi2CVwiu1wceXcqWB14ux3FuX9Bw@mail.gmail.com>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <CAPx+jO_6bH8i5BV=64i=dLdi2CVwiu1wceXcqWB14ux3FuX9Bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/11/26 10:40, Ulf Hansson wrote:
> On Tue, Sep 1, 2026 at 8:49 PM Tanmay Kathpalia
> <tanmay.kathpalia@altera.com> wrote:
>>
>> This series adds support for the Cadence SD6HC (sixth-generation) SDHCI
>> controller and enables it on Altera Agilex5 SoCs.
>>
>> The SD6HC PHY architecture differs substantially from the SD4HC: it
>> requires dedicated per-speed-mode IO cell timing parameters and a
>> DLL-based delay line to achieve correct signal margins across all speed
>> grades from Default Speed through HS400. These are programmed through a
>> new sdhci-cadence-phy-v6.c file; shared driver infrastructure lives in
>> sdhci-cadence-core.c.
>>
>> Note: this series depends on commit ab45ecfab540 ("dt-bindings: reset:
>> altr: add COMBOPHY_RESET for Agilex5"), which is already in mainline via
>> the reset tree. It is not yet in mmc/next; apply or merge that commit
>> when building/testing this series on top of mmc/next. The previous v1/v2
>> reset binding patch is therefore omitted from this series.
>>
>> Board DTS files do not enable the SMMU; that is provided by commit
>> 10cf797f3f8a ("arm64: dts: socfpga: agilex5: Enable the SMMU") in the
>> SoC DT tree. It is not yet in mmc/next. Apply or merge that commit when
>> building/testing this series on top of mmc/next, otherwise the SMMU
>> stays disabled in socfpga_agilex5.dtsi.
>>
>> Patch 1: DT binding
>>    Adds a dedicated cdns,sd6hc.yaml binding with SD6HC compatible strings,
>>    clock/reset/IOMMU constraints, and PHY timing properties.
>>
>> Patches 2-5: Device tree
>>    Patch 2 adds the SD6HC controller node to the Agilex5 SoC DTSI as
>>    sdmmc, left disabled.
>>    Patch 3 enables SD card operation (4-bit, SDR104, 200 MHz) on the
>>    SOCDK OOBE board with GPIO-switched IO-voltage regulation.
>>    Patch 4 registers the intel,socfpga-agilex5-socdk-emmc board variant
>>    in the arm/altera binding.
>>    Patch 5 adds socfpga_agilex5_socdk_emmc.dts for eMMC-only operation
>>    (8-bit, HS200/HS400, 1.8 V IO, 200 MHz).
>>
>> Patches 6-9: Driver
>>    Patch 6 renames SD4HC-specific functions and structures with a "cdns4"
>>    prefix to separate them from shared driver paths.
>>    Patch 7 encapsulates SD4HC PHY probing in sdhci_cdns4_phy_probe() and
>>    makes every of_device_id entry carry explicit platform data, removing
>>    the silent fallback.
>>    Patch 8 introduces the SD6HC PHY driver (sdhci-cadence-phy-v6.c): DLL
>>    lock/bypass, per-speed-mode IO cell timing, tuning, and HW reset. The
>>    common driver core selects between v4 and v6 PHY operations based on
>>    the SDHCI specification version reported by the controller, and
>>    reprograms the PHY from set_clock and set_uhs_signaling. SD6HC clocks
>>    are requested by name ("ciu" and "biu").
>>    Patch 9 adds the Agilex5 platform overlay under altr,agilex5-sd6hc:
>>    40-bit DMA mask for the SMMU address space, quirks for
>>    CAP_CLOCK_BASE_BROKEN, PRESET_VALUE_BROKEN, ACMD23_BROKEN and
>>    MULTIBLOCK_READ_ACMD12, .get_max_clock set to
>>    sdhci_pltfm_clk_get_max_clock, and an init hook that asserts and
>>    deasserts the three named resets together, keeping exclusive ownership
>>    via devm so they stay deasserted for the life of the device.
>>
>> Tested on Agilex5 SOCDK:
>>    - SD card: Default Speed, High Speed, SDR25, SDR50, SDR104
>>    - eMMC daughter board: HS200, HS400
>>
>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>>
>> ---
>> Changes in v7:
>>
> 
> [...]
> 
> Patch 1 and 6-9 from the v7 series, applied for next, thanks!
> 
Patch 2,3,4,5 appled for next.

Thanks,
Dinh
