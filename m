Received: from mail-m19731100.qiye.163.com (mail-m19731100.qiye.163.com [220.197.31.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B721DF73C;
	Tue, 25 Nov 2025 03:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764039738; cv=none; b=aEc8+XuznjdNUCRzA6FrzytUCkzxTLahL+l6r/Z0gN6oW8WYysCclPdX+a5w/UNg1FNwPnYelszVuJnMuV7EjYSpge+kenvM1WfkVOWIy34vT6c2BP3VwhfYBIQ6ZIjZeM13J5TBYXyffgbrrxzKsuspoz49dcQdx38IDH8IyYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764039738; c=relaxed/simple;
	bh=ZbggHlLijkDIPlyFLLLScmsc8UPHQ1G4SXFmd0CkoAw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uao/tUJ3cYTBCngMy5WUu4ejXck+cwAZu0qF1yrhYMXBMhD07yJZ+Q1rYS1smChlSQCb3LVfgywf8q+CfLR474LWd5zIEu77uFNCkjV8CPA42eUHHaNPO23/uXDUXZYf6tCoUxjCDJoOsWo2FxqHree+LICKPyuH1izikAWr3is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=YdC5ZnZo; arc=none smtp.client-ip=220.197.31.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="YdC5ZnZo"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2ac3df67c;
	Tue, 25 Nov 2025 11:02:03 +0800 (GMT+08:00)
Message-ID: <784f6364-e49d-4452-91c0-c8f24706951b@rock-chips.com>
Date: Tue, 25 Nov 2025 11:02:03 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Fix command queue support for
 RK3576
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Yifeng Zhao <yifeng.zhao@rock-chips.com>
References: <20251121-rockchip-emmc-cqe-rk3576-fix-v1-1-a77805f40072@collabora.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251121-rockchip-emmc-cqe-rk3576-fix-v1-1-a77805f40072@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ab8f60ac309cckunm1956caa443e704
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk5OS1ZCTB0aQkgaHUpMGE9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=YdC5ZnZo6g2ktdySEBNtohxJI9WNGnnpoTT+W/PO7G853pv6BD2C8rbgzDG7Gi5Z9xoYmpoHSbR5zAoyj4DNQxAkzua1ihNY7SBPxTNm8pp/cyh55QTNEFqQujDBj0SfseYmfDxzz894ektuG0aoL8nXJiSlsGd85wRM/xlWjl0=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=SuHFIVlB89k1v2cvDQ8z3NTybDz745v41RWXBeWzgO4=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/22 星期六 0:26, Sebastian Reichel 写道:
> When I added command queue engine (CQE) support for the Rockchip eMMC
> controller, I missed that RK3576 has a separate platform data struct.
> While things are working fine on RK3588 (I tested the ROCK 5B) and
> the suspend issue is fixed on the RK3576 (I tested the Sige5), this
> results in stability issues. By also adding the necessary hooks for
> the RK3576 platform the following problems can be avoided:
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> [   15.606895] mmc0: running CQE recovery
> [   15.616189] mmc0: running CQE recovery
> [...]
> [   25.911484] mmc0: running CQE recovery
> [   25.926305] mmc0: running CQE recovery
> [   25.927468] mmc0: running CQE recovery
> [...]
> [   26.255719] mmc0: running CQE recovery
> [   26.257162] ------------[ cut here ]------------
> [   26.257581] mmc0: cqhci: spurious TCN for tag 31
> [   26.258034] WARNING: CPU: 0 PID: 0 at drivers/mmc/host/cqhci-core.c:796 cqhci_irq+0x440/0x68c
> [   26.263786] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.18.0-rc6-gd984ebbf0d15 #1 PREEMPT
> [   26.264561] Hardware name: ArmSoM Sige5 (DT)
> [...]
> [   26.272748] Call trace:
> [   26.272964]  cqhci_irq+0x440/0x68c (P)
> [   26.273296]  dwcmshc_cqe_irq_handler+0x54/0x88
> [   26.273689]  sdhci_irq+0xbc/0x1200
> [   26.273991]  __handle_irq_event_percpu+0x54/0x1d0
> [...]
> 
> Note that the above problems do not necessarily happen with every boot.
> 
> Reported-by: Adrian Hunter <adrian.hunter@intel.com>
> Closes: https://lore.kernel.org/linux-rockchip/01949bc9-4873-498b-ac7d-f008393ccc4c@intel.com/
> Fixes: fda1e0af7c28f ("mmc: sdhci-of-dwcmshc: Add command queue support for rockchip SOCs")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> Sorry for the delay in sending this :)
> ---
>   drivers/mmc/host/sdhci-of-dwcmshc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index c66a8dfad47c..ee0008d91b98 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -1767,6 +1767,7 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk3576_pdata = {
>   		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>   			   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>   	},
> +	.cqhci_host_ops = &rk35xx_cqhci_ops,
>   	.init = dwcmshc_rk35xx_init,
>   	.postinit = dwcmshc_rk3576_postinit,
>   };
> 
> ---
> base-commit: dcbce328d3a2d87770133834210cf328c083d480
> change-id: 20251121-rockchip-emmc-cqe-rk3576-fix-ec8ac72e6e32
> 
> Best regards,

