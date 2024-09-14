Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B741482F3;
	Sat, 14 Sep 2024 11:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726314765; cv=none; b=ayPmPWdKgE8uApKBoMiGOTpHJj/RkgUbXEHVpcgzw3OLJY5VEJnG2p4vx+jwYXLSLPSclxxZbSUH2DNrQll2TaAwH4nJmQh+nEU2NMbDA4gHJUE5yxpl51/ZENmeyfWC5WIAWSne7uc6EXsmnAV8KC67p6IqmQW1haccBYJjEhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726314765; c=relaxed/simple;
	bh=PseeGydaW7P7gcDIexeJPYFC9+KYnfOcDOJjNIwz30g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+Yjm8DhJ6LRDS5Rz3mOXQ9pPArqJFRRRMOWdMyqJPZrsDY8cfnB/veqHvV5l+Bfy6iOXFzeYEvoh1v/HrVvsFohrg4lAD2dheFA9UPMWNuDG71GsFRGLVaRlaTarj1pTlChpZC5CzbGUJbTEpLS2YWRwThYedwpKj+RYlkIoGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=JlJIyRWL; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="JlJIyRWL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JMlYom8FcCA2dWJkTLSCkHY6YrKnhlwr8nNq9Iy+Jik=; b=JlJIyRWLqr5n+VG1fxF1P4qHWc
	tLrfVEw4jDFiCMDfrKcbLa0gF0LOiKZxmDmvCi2uYck1Wy2ZRz4eUKrdx44pmSSmw7ukc6oMHCuHd
	WFiMEg6zWT1e+mGl4F4806ujcawN5w+I6ifuVqDYhAD3pHuvraC72dIY7IoKnxDjRWaj07JQcU9EJ
	QIAyc4BsJjzJsIZFpvEQvRgBUBGKiw0kwJoqDl47Z8UmQRaVBI+ioVw/hy2fwF/V5pnZCffdWa/EF
	HDE+LF6qxhlCrmgu5xhhm8nAc43OH9bSJioM5CtoHGEPodM2EAEwlQzCUf5VunTdaLqpcnma0e0Yh
	9VyZv2oA==;
Received: from i53875af6.versanet.de ([83.135.90.246] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1spRKK-0003Qy-U9; Sat, 14 Sep 2024 13:52:32 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org,
 Kever Yang <kever.yang@rock-chips.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
Subject:
 Re: [PATCH] mmc: dw_mmc: rockchip: Keep controller working for card detect
Date: Sat, 14 Sep 2024 13:52:32 +0200
Message-ID: <4920950.GXAFRqVoOG@diego>
In-Reply-To:
 <20240912152538.1.I858c2a0bf83606c8b59ba1ab6944978a398d2ac5@changeid>
References:
 <20240912152538.1.I858c2a0bf83606c8b59ba1ab6944978a398d2ac5@changeid>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 12. September 2024, 09:26:14 CEST schrieb Kever Yang:
> In order to make the SD card hotplug working we need the card detect
> function logic inside the controller always working. The runtime PM will
> gate the clock and the power domain, which stops controller working when
> no data transfer happen.
> 
> So lets skip enable runtime PM when the card needs to detected by the
> controller and the card is removable.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

So for the change itself this looks good, i.e. it fixes an issue for baords relying
on the on-chip-card-detect.


But for boards doing that, the controller will be running _all the time_
even if there is never any card inserted.

So relying on the on-soc card-detect will effectively increase the power-
consumption of the board - even it it'll never use any sd-card?

> ---
> 
>  drivers/mmc/host/dw_mmc-rockchip.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index b07190ba4b7a..df91205f9cd3 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -345,28 +345,39 @@ static int dw_mci_rockchip_probe(struct platform_device *pdev)
>  	const struct dw_mci_drv_data *drv_data;
>  	const struct of_device_id *match;
>  	int ret;
> +	bool use_rpm = true;
>  
>  	if (!pdev->dev.of_node)
>  		return -ENODEV;
>  
> +	if (!device_property_read_bool(&pdev->dev, "non-removable") &&

It would be nice to add a comment here about the fact that this will
disable power-management for the controller.

Also shouldn't non-removable already work, making the case above not
necessary?


Thanks
Heiko

> +	     !device_property_read_bool(&pdev->dev, "cd-gpios"))
> +		use_rpm = false;
> +
>  	match = of_match_node(dw_mci_rockchip_match, pdev->dev.of_node);
>  	drv_data = match->data;
>  
>  	pm_runtime_get_noresume(&pdev->dev);
>  	pm_runtime_set_active(&pdev->dev);
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
>  	ret = dw_mci_pltfm_register(pdev, drv_data);
>  	if (ret) {
> -		pm_runtime_disable(&pdev->dev);
> -		pm_runtime_set_suspended(&pdev->dev);
> +		if (use_rpm) {
> +			pm_runtime_disable(&pdev->dev);
> +			pm_runtime_set_suspended(&pdev->dev);
> +		}
>  		pm_runtime_put_noidle(&pdev->dev);
>  		return ret;
>  	}
>  
> -	pm_runtime_put_autosuspend(&pdev->dev);
> +	if (use_rpm)
> +		pm_runtime_put_autosuspend(&pdev->dev);
>  
>  	return 0;
>  }
> 




