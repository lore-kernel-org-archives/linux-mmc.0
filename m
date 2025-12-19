Received: from mail-m32108.qiye.163.com (mail-m32108.qiye.163.com [220.197.32.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E1C2D5A01
	for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2025 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766133367; cv=none; b=U52ZEjH0jhzREHZJMU5zzj+/x+K64HjQY/Tj1w94EZq87Hw43Rq9m2+K7XRaayHYg6orilATFv5X9io4U9H1dvyfMYgJYdxDTnHoorR9/9g3HGA17uHD6CRY/8+l5zHB/0MY/ZTzpm0hrVhqJAm2q88y5lPoVCPWPm8wQe/4mkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766133367; c=relaxed/simple;
	bh=6ii+IWuEue4mYrQrcofUEe5v1T3CQDxg/7OIxi5aRdI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dttvqvncX+nMMO1Qo52OgUMqCT/mfldH8MLF9s/5dwrreb7DG+auzcKSEXhbeopkWFGAl6cRmIMQ04WiijuMDIgbUdwXuAHZwiUAxalSxi/pEqbc0aAE19jLRE99K6IfZ9q8MaZ1dgskNZU+980Idxan3DDucBC0hWRstJpqpjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=hiEJ3/QX; arc=none smtp.client-ip=220.197.32.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="hiEJ3/QX"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2ddee8fe9;
	Fri, 19 Dec 2025 16:30:43 +0800 (GMT+08:00)
Message-ID: <e9400876-275e-4516-849f-d72d67efe84d@rock-chips.com>
Date: Fri, 19 Dec 2025 16:30:39 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org
Subject: Re: [bug report] mmc: dw_mmc: Remove struct dw_mci_slot
To: Dan Carpenter <dan.carpenter@linaro.org>
References: <aUUKD0YbuIIcK5pT@stanley.mountain>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aUUKD0YbuIIcK5pT@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b35bb920209cckunmaeb713a294860
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ05MGVZMT00aTxkfT05NQh1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=hiEJ3/QXt+bd9W0rC9domOthfDim9hRLo4wSQRIu4T3fJsDIPqO6SGxJ5/ktaubddcD5b6xrgn4keuafRmyK03AVELQxQnX4Ii8NumwnKYon84mRjENmQneWo87lH+RDwmZ4NdfsUirid8XwtVkKKKw/yYlGl1KdMUufFMyNsrc=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=gXzAmSaUxxq6xjcBQ8p50wrC5NO7fpq/uYJUqA03uk4=;
	h=date:mime-version:subject:message-id:from;

在 2025/12/19 星期五 16:17, Dan Carpenter 写道:
> Hello Shawn Lin,
> 
> Commit 926311cf3361 ("mmc: dw_mmc: Remove struct dw_mci_slot") from
> Dec 16, 2025 (linux-next), leads to the following Smatch static
> checker warning:
> 
> 	drivers/mmc/host/dw_mmc.c:3467 dw_mci_remove()
> 	error: we previously assumed 'host' could be null (see line 3464)
> 
> drivers/mmc/host/dw_mmc.c
>      3457         return ret;
>      3458 }
>      3459 EXPORT_SYMBOL(dw_mci_probe);
>      3460
>      3461 void dw_mci_remove(struct dw_mci *host)
>      3462 {
>      3463         dev_dbg(host->dev, "remove host\n");
>                           ^^^^^^^^^
> Host is dereferenced
> 
>      3464         if (host)
> 
> Then checked for NULL.
> 
>      3465                 dw_mci_cleanup_host(host);
> 
> The dw_mci_cleanup_host() function gives up our claim to host which
> allows it to be re-used.
> 
>      3466
> --> 3467         mci_writel(host, RINTSTS, 0xFFFFFFFF);
> 
> So it's surprising to me that we keep on using it throughout the
> rest of the function.
> 

Thanks Dan. Smatch is so smart! Yes, this check is redundant, could be
removed. Will fix it later.

>      3468         mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
>      3469
>      3470         /* disable clock to CIU */
>      3471         mci_writel(host, CLKENA, 0);
>      3472         mci_writel(host, CLKSRC, 0);
>      3473
>      3474         if (host->use_dma && host->dma_ops->exit)
>      3475                 host->dma_ops->exit(host);
>      3476
>      3477         reset_control_assert(host->pdata->rstc);
>      3478
>      3479         clk_disable_unprepare(host->ciu_clk);
>      3480         clk_disable_unprepare(host->biu_clk);
>      3481 }
> 
> regards,
> dan carpenter
> 

