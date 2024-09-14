Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D022154BE0;
	Sat, 14 Sep 2024 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726312911; cv=none; b=bcoP3nfjYGwsen29zXq+puQGQ0KQPhrGRkeBMH5aSO0QEX+Gc6GdJtXD36b29up+GLsk7IBk3vyLGwqdye1DYUEUqWbvF5FKg92FRWr0xJO/+vOQTORSZq0+8/iVtLvNi4Ar3Z2icslel0ziTHCXXU1yyckckbTcl8GIKgtyScE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726312911; c=relaxed/simple;
	bh=wYs6+e3ncIibwOg937qyqqpMKoEQH/DfvlRasOabw7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQso1rdfR5Mefp/PBAgFEe65GeMKPs+6/kMdpIvtdjZRLlMdqSlpPfi1YgPHY9wZJb3esrs1JqIFCLn+rM7sO7TrnqinzHUrUCE5Vb20HQxzF3WCLEEYmthKdVOcS1FQdFRb3FLK6O06qMU3X2YCbGo3oB5XXubLiIT9nGAU80w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: bizesmtpsz7t1726312842t8wcg69
X-QQ-Originating-IP: SOLrjz+HwFUP3pt84UGTG+9SZb7SAJ5qXRN8euUzMpw=
Received: from [192.168.159.131] ( [106.150.157.243])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 14 Sep 2024 19:20:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2777605266862131744
Message-ID: <46A8525FAB17E4F4+92686d5e-1de3-40c6-9767-ba9f7fedd984@radxa.com>
Date: Sat, 14 Sep 2024 20:20:39 +0900
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: dw_mmc: rockchip: Keep controller working for card
 detect
To: Kever Yang <kever.yang@rock-chips.com>, heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org, Jaehoon Chung
 <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <20240912152538.1.I858c2a0bf83606c8b59ba1ab6944978a398d2ac5@changeid>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20240912152538.1.I858c2a0bf83606c8b59ba1ab6944978a398d2ac5@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1

hi

On 9/12/24 16:26, Kever Yang wrote:
> In order to make the SD card hotplug working we need the card detect
> function logic inside the controller always working. The runtime PM will
> gate the clock and the power domain, which stops controller working when
> no data transfer happen.
> 
> So lets skip enable runtime PM when the card needs to detected by the
> controller and the card is removable.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

following RK3588(s) boards work fine without cd-gpios,

- Radxa E54C
- Radxa ROCK 5A
- Radxa ROCK 5B
- Radxa ROCK 5C

thank you very much!

Tested-by: FUKAUMI Naoki <naoki@radxa.com>

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> ---
> 
>   drivers/mmc/host/dw_mmc-rockchip.c | 23 +++++++++++++++++------
>   1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index b07190ba4b7a..df91205f9cd3 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -345,28 +345,39 @@ static int dw_mci_rockchip_probe(struct platform_device *pdev)
>   	const struct dw_mci_drv_data *drv_data;
>   	const struct of_device_id *match;
>   	int ret;
> +	bool use_rpm = true;
>   
>   	if (!pdev->dev.of_node)
>   		return -ENODEV;
>   
> +	if (!device_property_read_bool(&pdev->dev, "non-removable") &&
> +	     !device_property_read_bool(&pdev->dev, "cd-gpios"))
> +		use_rpm = false;
> +
>   	match = of_match_node(dw_mci_rockchip_match, pdev->dev.of_node);
>   	drv_data = match->data;
>   
>   	pm_runtime_get_noresume(&pdev->dev);
>   	pm_runtime_set_active(&pdev->dev);
> -	pm_runtime_enable(&pdev->dev);
> -	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> -	pm_runtime_use_autosuspend(&pdev->dev);
> +
> +	if (use_rpm) {
> +		pm_runtime_enable(&pdev->dev);
> +		pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> +		pm_runtime_use_autosuspend(&pdev->dev);
> +	}
>   
>   	ret = dw_mci_pltfm_register(pdev, drv_data);
>   	if (ret) {
> -		pm_runtime_disable(&pdev->dev);
> -		pm_runtime_set_suspended(&pdev->dev);
> +		if (use_rpm) {
> +			pm_runtime_disable(&pdev->dev);
> +			pm_runtime_set_suspended(&pdev->dev);
> +		}
>   		pm_runtime_put_noidle(&pdev->dev);
>   		return ret;
>   	}
>   
> -	pm_runtime_put_autosuspend(&pdev->dev);
> +	if (use_rpm)
> +		pm_runtime_put_autosuspend(&pdev->dev);
>   
>   	return 0;
>   }
