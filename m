Received: from mail-m49194.qiye.163.com (mail-m49194.qiye.163.com [45.254.49.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939342FB977;
	Wed, 14 Jan 2026 08:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768378452; cv=none; b=AGuhjt/x+1lGyP7yaALxQt0cYLCjKyEQAnW10MG6oWmHrfTUJLEsMAZIHweWQuGue6M/LmRYgHewm1295H+yz0ck58lr9/HV13nUOefRl/I2dNueF/bwYqFHO/lGhtLw693/cDhcYOFtibrGgrpl+1xeW0G9hreMlezjbMmx8mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768378452; c=relaxed/simple;
	bh=zGn/XRcMqwwFuNLx0uSDVvM6VyHfqCJQGeCI1eHoVDQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qBdi93kzkIn3UPStbHTJdmGk8CTLaBDSYQogm82lk9+tLLvrMgxFdOxny9tCo5k9aDDtjoO6xDk96tbO5+xmPVBrlivtUgbY1eiXTvNA3lK5ed95ddWaSBayaJf6mczI0LKkBNhXle9sS+aJM7UOWyf7ypdjjipu8gwsf/58EYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=jt/DYDIZ; arc=none smtp.client-ip=45.254.49.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="jt/DYDIZ"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 309b22e7b;
	Wed, 14 Jan 2026 16:08:44 +0800 (GMT+08:00)
Message-ID: <6934ae0d-16c5-436f-97f6-c11d304ca51d@rock-chips.com>
Date: Wed, 14 Jan 2026 16:08:43 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-rockchip@lists.infradead.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, heiko@sntech.de, ulf.hansson@linaro.org
Subject: Re: [PATCH v1 0/3] mmc: dw_mmc-rockchip: Add stability quirk for
 NanoPi R76S
To: Marco Schirrmeister <mschirrmeister@gmail.com>
References: <20260110010715.1610159-1-mschirrmeister@gmail.com>
 <67ccb8f6-f9bd-4266-b79a-b688bd6d030b@rock-chips.com>
 <8536413c-8687-4d75-befb-8f25e54838bf@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <8536413c-8687-4d75-befb-8f25e54838bf@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bbb8cc99a09cckunm9a308b3948f3f9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkxMQlYaGE5PSx5OGkxPH05WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=jt/DYDIZPuInsl91a4KACW2hxs/z0RuH25bcKV7dul2XAuJBK6dSpkMoPrFZiufslHvTBdw6k63r1heN1qGUMdrl+snPB6OUfwOyQteYKn1TnIfMxUSGknCjppyYocg8r9VyH4ToDIZgaLjI1ib6+xWaECZ+pAEW1uzaL95PNsQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=8+Ps+QJX7O1TTlQB7KtvJFbgo7HUqA8ymA/xt0D2c0U=;
	h=date:mime-version:subject:message-id:from;

在 2026/01/12 星期一 11:56, Shawn Lin 写道:
> 在 2026/01/12 星期一 9:32, Shawn Lin 写道:
>> 在 2026/01/10 星期六 9:07, Marco Schirrmeister 写道:
>>> This series addresses a microSD stability issue on the FriendlyElec
>>> NanoPi R76S (RK3576). The board currently suffers from a 400kHz
>>> retuning loop when the controller attempts to enter runtime-suspend
>>> during idle periods.
>>>
>>> Evidence of the failure in dmesg:
>>> [Fri Jan  2 01:28:02 2026] mmc_host mmc1: Bus speed (slot 0) = 400000Hz
>>> [Fri Jan  2 01:28:03 2026] mmc_host mmc1: Bus speed (slot 0) = 
>>> 198000000Hz
>>> [Fri Jan  2 01:28:03 2026] dwmmc_rockchip 2a310000.mmc: Successfully 
>>> tuned phase to 233
>>> [Fri Jan  2 01:28:04 2026] mmc_host mmc1: Bus speed (slot 0) = 400000Hz
>>>
>>
>> Does this problem happen with all microSDs or just *a* microSD per
>> your description?
>> Have you ever tried to disable SDR104 support?
>>
> 
> A quick update.
> 
> I found several problems on RK3576 for supporting sd cards. I wondered
> how all upstream RK3576 boards claiming SD support work? Anyway, I sent
> a series to the list[1], not sure if it fixes the problem you faced, but
> these should be the right patches you should have a try.
> 
> 
> [1]https://lore.kernel.org/linux-rockchip/1768189768-96333-1-git-send- 
> email-shawn.lin@rock-chips.com/T/#t


Except for the patch mentioned above for fixing the hot-plug problem
which you confirmed to work fine. I looked the code a bit and see
a potential problem related to the runtime suspend + power-domain.
Please check the patch to see if it fixes your problem:

--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -36,6 +36,8 @@ struct dw_mci_rockchip_priv_data {
         int                     default_sample_phase;
         int                     num_phases;
         bool                    internal_phase;
+       int                     sample_phase;
+       int                     drv_phase;
  };

  /*
@@ -573,9 +575,43 @@ static void dw_mci_rockchip_remove(struct 
platform_device *pdev)
         dw_mci_pltfm_remove(pdev);
  }

+static int dw_mci_rockchip_runtime_suspend(struct device *dev)
+{
+       struct platform_device *pdev = to_platform_device(dev);
+       struct dw_mci *host = platform_get_drvdata(pdev);
+       struct dw_mci_rockchip_priv_data *priv = host->priv;
+
+       if (priv->internal_phase) {
+               priv->sample_phase = rockchip_mmc_get_phase(host, true);
+               priv->drv_phase = rockchip_mmc_get_phase(host, false);
+       }
+
+       return dw_mci_runtime_suspend(dev);
+}
+
+static int dw_mci_rockchip_runtime_resume(struct device *dev)
+{
+       struct platform_device *pdev = to_platform_device(dev);
+       struct dw_mci *host = platform_get_drvdata(pdev);
+       struct dw_mci_rockchip_priv_data *priv = host->priv;
+       int ret;
+
+       ret = dw_mci_runtime_resume(dev);
+       if (ret)
+               return ret;
+
+       if (priv->internal_phase) {
+               rockchip_mmc_set_phase(host, true, priv->sample_phase);
+               rockchip_mmc_set_phase(host, false, priv->drv_phase);
+               mci_writel(host, MISC_CON, MEM_CLK_AUTOGATE_ENABLE);
+       }
+
+       return ret;
+}
+
  static const struct dev_pm_ops dw_mci_rockchip_dev_pm_ops = {
         SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, 
pm_runtime_force_resume)
-       RUNTIME_PM_OPS(dw_mci_runtime_suspend, dw_mci_runtime_resume, NULL)
+       RUNTIME_PM_OPS(dw_mci_rockchip_runtime_suspend, 
dw_mci_rockchip_runtime_resume, NULL)
  };

  static struct platform_driver dw_mci_rockchip_pltfm_driver = {




> 
>>> Testing confirmed that the issue can be manually addressed by
>>> disabling runtime PM via sysfs:
>>> echo on > /sys/devices/platform/soc/2a310000.mmc/power/control
>>>
>>> I experimented with various changes in the Device Tree, including
>>> lowering the bus frequency and attempting to keep the power domains
>>> active, but nothing stopped the retuning loop.
>>> The issue only went away when I forced the controller to stay active
>>> by disabling the runtime power management.
>>>
>>> This quirk is the only way I have found to keep the SDR104 link from
>>> crashing on the NanoPi R76S, I am open to suggestions if there is
>>> a better way to handle this in the driver or the DTS.
>>>
>>> Marco Schirrmeister (3):
>>>    dt-bindings: mmc: rockchip-dw-mshc: add rockchip,disable-runtime-pm
>>>    mmc: host: dw_mmc-rockchip: add rockchip,disable-runtime-pm quirk
>>>    arm64: dts: rockchip: add stability quirk to NanoPi R76S
>>>
>>>   .../bindings/mmc/rockchip-dw-mshc.yaml        |  8 ++++++
>>>   .../boot/dts/rockchip/rk3576-nanopi-r76s.dts  |  1 +
>>>   drivers/mmc/host/dw_mmc-rockchip.c            | 25 ++++++++++++++++---
>>>   3 files changed, 31 insertions(+), 3 deletions(-)
>>>
>>
>>
> 
> 

