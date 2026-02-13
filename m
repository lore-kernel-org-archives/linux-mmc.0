Received: from mail-m15567.qiye.163.com (mail-m15567.qiye.163.com [101.71.155.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4042517A5;
	Fri, 13 Feb 2026 06:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770965974; cv=none; b=hrZA/epgGhg6VpifLIlsUGaUSegPxOR68W8UPIZzSpK0G//3cT2jzVWOcRqdVRWXOJgfdw4y7rH0bTpkRiX+Y03ajzKZTUqdvX1lLdDvbGjn8eybAKMyEFJTiFYF7ESlkqrVEQ3j9otsrVV0xBH6cN0FOkYCfWPoRkmB3VtCzwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770965974; c=relaxed/simple;
	bh=T+1dAvXihdTLt+JzbcHlKRPtx3bEUIxKVWcjWOF7U/o=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=b+XQdKCAx0473+Rh1BGmIfIjjZwRSDwJX3JJIeXED0ebWb7IzooSt1i2VZP9N6YKOxeA6fL2UmQrroJ/mC8Ue8ls1ag9ZCpX7Foyc2oNCAudze/dvWQC15U9s+FVoup3LNieppkGYnXCxyM/Ktw72JFi3YQC0vLtyz5GVzts/2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=fUz1u53Y; arc=none smtp.client-ip=101.71.155.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="fUz1u53Y"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 340b3d5c3;
	Fri, 13 Feb 2026 11:30:08 +0800 (GMT+08:00)
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, hy50.seo@samsung.com, kwangwon.min@samsung.com
Subject: Re: [PATCH v2 2/3] mmc: dw_mmc-k3: before set biu_clk rate, check
 biu_clk available or not
To: "ping.gao" <ping.gao@samsung.com>, ulf.hansson@linaro.org,
 jh80.chung@samsung.com, sebastian.reichel@collabora.com
References: <CGME20260123085150epcas5p42f2cc04843ae7657380b2968261246cb@epcas5p4.samsung.com>
 <20260213030851.1134504-1-ping.gao@samsung.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <b27ec5ce-6298-7d06-3716-851c8bdb02b0@rock-chips.com>
Date: Fri, 13 Feb 2026 11:30:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260213030851.1134504-1-ping.gao@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c550c818e09cckunm757da81025d0da
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk4dQ1YZGU4YTkxMQhpPQkhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=fUz1u53YbUpUVH2UehDYSA4XOjRUZdNYpiLeVrZawF8Rr7hoDlbQGT9Qty5R3Vldge1rodbw14v0WxlkvkZ+ARMzqvOpKj8wytkNpAlg/n9bJWasr1Wka/viirxHaDJh7l2QJEm9IklDtvFvaRt3Kn6CIFI8lob2XaPrF//SZFo=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=8Oj7TbPCvdAJqC3XmY4wq/NQkC3YGlummLRL86KUpYc=;
	h=date:mime-version:subject:message-id:from;


在 2026/02/13 星期五 11:08, ping.gao 写道:
> if biu_clk not available, shouldn't set_rate or get_rate
> 

I would rephrase something like this:
If biu_clk is not available, no need to try to set and get
rate of it, just bail out and print a warning.

> Signed-off-by: ping.gao <ping.gao@samsung.com>
> ---
>   drivers/mmc/host/dw_mmc-k3.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
> index ad6aa1aea549..9c68e162b373 100644
> --- a/drivers/mmc/host/dw_mmc-k3.c
> +++ b/drivers/mmc/host/dw_mmc-k3.c
> @@ -190,6 +190,11 @@ static void dw_mci_hi6220_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>   	int ret;
>   	unsigned int clock;
>   
> +	if (IS_ERR_OR_NULL(host->biu_clk)) {
> +		dev_warn(host->dev, "biu_clk not available\n");

dev_err(host->dev, "biu_clk is not available\n");

Should be a error for k3 driver as it needs biu_clk.

> +		return;
> +	}
> +
>   	clock = (ios->clock <= 25000000) ? 25000000 : ios->clock;
>   
>   	ret = clk_set_rate(host->biu_clk, clock);
> 
