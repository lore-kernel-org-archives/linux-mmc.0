Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.224.81.90
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793062408;
	b=2kPa5IRq7EJvdvjtPewsBKtrzZz6W/PIc41nKPpYlKgPJER8v0sEcGFOUub9YX1e4Elb
	 necJqfG5Azj6x8h15DxvXe92yZq0HwpiHU6dV7xhSQfpt3MHuO8XxbdFx/lem/g7WLewc
	 3fDtLj7ddzBJaUXESgaOJbYOC0DV2k8hfBXrU6HrFxbLTcJBJpkUt/nVnAYVQ/CJni777
	 HPhpS/uf32WjXGktqfyMrTTI5LMEybV2UQmFeB8hDd1uotBQ5IQFFYvWo84eBh1kyakXj
	 hcKepKE0CAfEPqhNDnwdPKWutXXD+kkMjHFioIRmLympDx01CG4F383Hgog/GIc07+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793062408;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=wghg31XooAJPKL/XTiGnCxCN5pFUy2mBUdUxi6yrLos=;
	b=hsqc+Gv09Vibsh4zPxQF0+f1hqGEsB+xnje/B5sxXEBwklVJZTP/NAUzYwSpCEROr+kA
	 3iOP+u1Ar1bp/EYH7+1ts8/IgloPHXyYKxP5LmSOY+1UjRC0lv+AE0F3KHlHz+n0W4Th2
	 UjGXDRTKoIjqsU8xzcL257v5Zc4tmsGsdDsyVE+e8ivOJp9Mucud9fRZoGvL9iS60Wuwq
	 Pxf5tFfwgM7LXxTU3EfHNOHRRVKoZ1kLOjPhNEF69gewYqa9hHjRwm6h8wAmTCJ1SbH7o
	 OQHAVGtkWRjuoj2k2ZjA/VClm7DxoxVV2DogKQVaMmq7dFR1JJiTh3XNzJ9fIvYWD5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=IJsQys7w;
	arc=none smtp.remote-ip=156.224.81.90
Received: from mail-m8190.xmail.ntesmail.com (mail-m8190.xmail.ntesmail.com [156.224.81.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320C1606A31A;
	Tue, 27 Oct 2026 00:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 320C1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=IJsQys7w
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 526e8ceb0;
	Tue, 27 Oct 2026 08:53:12 +0800 (GMT+08:00)
Message-ID: <bb38e2c8-1868-4a66-9e0d-78d9f68ab4be@rock-chips.com>
Date: Tue, 27 Oct 2026 08:53:09 +0800
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 mfd@lists.linux.dev, linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-phy@lists.infradead.org,
 linux-usb@vger.kernel.org
Subject: Re: [PATCH 24/27] mmc: dw_mmc-rockchip: Keep RK3572 NVM domain
 powered
To: 1579567540@qq.com, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Elaine Zhang <zhangqing@rock-chips.com>, Lee Jones <lee@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Wu <david.wu@rock-chips.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
References: <20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com>
 <20261022-add-board-ok3572-c-v1-24-0b0fd85a31ee@qq.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261022-add-board-ok3572-c-v1-24-0b0fd85a31ee@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa17ad8d47003a4kunm11e232fa473cda
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTh1CVh1KTR9CSE1LQx4fGFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
	b=IJsQys7w6ZxV+DGACFu7tp6IC2XPPwcJXSelxQSD1vTGjhE9PoZcuZz9xwdeWJyiMmawVu+MEW+G8WAm2iMk67hmhZOiMs56Iq7OGWJB2jXbZ7rtdDSqWunDi5ua9gLF9vWCsJIjLwel7Nty1TbOGwqxXT82cvpybuOOJTauLtE=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=wghg31XooAJPKL/XTiGnCxCN5pFUy2mBUdUxi6yrLos=;
	h=date:mime-version:subject:message-id:from;

Hi Cunhao,

在 2026/10/22 星期四 0:11, Cunhao Lu via B4 Relay 写道:
> From: Cunhao Lu <1579567540@qq.com>
> 
> Power cycling the RK3572 NVM domain causes repeated SD recovery. Keep it
> powered during runtime suspend without disabling controller runtime PM.
> 

Before your v2 about this path, I would like to ask why you need this?
The dw_mmc-rockchip controller is always under A power domain on every
SoC, none of the predecessors need this kind of change. If you see
some errors during RPM, perhaps you should have a look[1] and check your
DTS.

[1] 
https://lore.kernel.org/linux-mmc/1768524932-163929-1-git-send-email-shawn.lin@rock-chips.com/

> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> ---
>   drivers/mmc/host/dw_mmc-rockchip.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index 75c82ff20f177..8bc55d4b996c6 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -10,6 +10,7 @@
>   #include <linux/mmc/host.h>
>   #include <linux/of_address.h>
>   #include <linux/mmc/slot-gpio.h>
> +#include <linux/pm_domain.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/slab.h>
>   
> @@ -528,6 +529,19 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
>   	return 0;
>   }
>   
> +static int dw_mci_rk3572_init(struct dw_mci *host)
> +{
> +	int ret;
> +
> +	/* Power cycling the NVM domain disrupts SDMMC recovery. */
> +	ret = dev_pm_genpd_rpm_always_on(host->dev, true);
> +	if (ret && ret != -EOPNOTSUPP)
> +		dev_warn(host->dev, "failed to keep power domain on: %pe\n",
> +			 ERR_PTR(ret));
> +
> +	return dw_mci_rockchip_init(host);
> +}
> +
>   static const struct dw_mci_drv_data rk2928_drv_data = {
>   	.init			= dw_mci_rockchip_init,
>   	.parse_dt		= dw_mci_rk2928_parse_dt,
> @@ -541,6 +555,14 @@ static const struct dw_mci_drv_data rk3288_drv_data = {
>   	.init			= dw_mci_rockchip_init,
>   };
>   
> +static const struct dw_mci_drv_data rk3572_drv_data = {
> +	.common_caps		= MMC_CAP_CMD23,
> +	.set_ios		= dw_mci_rk3288_set_ios,
> +	.execute_tuning		= dw_mci_rk3288_execute_tuning,
> +	.parse_dt		= dw_mci_rk3576_parse_dt,
> +	.init			= dw_mci_rk3572_init,
> +};
> +
>   static const struct dw_mci_drv_data rk3576_drv_data = {
>   	.common_caps		= MMC_CAP_CMD23,
>   	.set_ios		= dw_mci_rk3288_set_ios,
> @@ -554,6 +576,8 @@ static const struct of_device_id dw_mci_rockchip_match[] = {
>   		.data = &rk2928_drv_data },
>   	{ .compatible = "rockchip,rk3288-dw-mshc",
>   		.data = &rk3288_drv_data },
> +	{ .compatible = "rockchip,rk3572-dw-mshc",
> +		.data = &rk3572_drv_data },
>   	{ .compatible = "rockchip,rk3576-dw-mshc",
>   		.data = &rk3576_drv_data },
>   	{},
> 

