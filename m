Received: from mail-m1973187.qiye.163.com (mail-m1973187.qiye.163.com [220.197.31.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BCE13D891;
	Fri, 13 Feb 2026 03:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770952786; cv=none; b=ZU6ufezABBTqcQq2P/Ic9aenyCp+KuXlYL4uvafPGybOPF7QqX6vJIgESTH7zKFB9x13jGp58x4iGBMIBmlkvmMcIzoNyUdqjygNtDw33CPbAGVur+UVz4SY9wmnUVNh5YX6XKT+TNA1P0esk5dJcd+2s2n/ziGkj1ut2C2C+FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770952786; c=relaxed/simple;
	bh=Z9lIvkhR4dBEOFO6s0jI0vfx+4t0GJ5Gbhg/4/decn4=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aczkSqA/n6j9SnGgvOHeT0qSyJlLWD0A9mFiOEuhSLb8L6bZJtwE5VFzYDfv/IVo75Lti9zDxq2zO8jwmSnf8EqZvgP3Q/l+Cy0blYSBSFzQ6yrofs4FVupCQqfczws70zTB4PLbPZTiwEwBcUvGOzpgD6Fw/b3BBmVLkI1kPw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=KZOuDmff; arc=none smtp.client-ip=220.197.31.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="KZOuDmff"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 340ae4e4c;
	Fri, 13 Feb 2026 11:14:26 +0800 (GMT+08:00)
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, hy50.seo@samsung.com,
 kwangwon.min@samsung.com, ulf.hansson@linaro.org, jh80.chung@samsung.com,
 sebastian.reichel@collabora.com
Subject: Re: [PATCH v2 3/3] dt-bindings: mmc: synopsys-dw-mshc: clk is not a
 must of two
To: "ping.gao" <ping.gao@samsung.com>
References: <CGME20260123085150epcas5p42f2cc04843ae7657380b2968261246cb@epcas5p4.samsung.com>
 <20260213030905.1134519-1-ping.gao@samsung.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <8e8b0782-d7bc-3ff1-b1c7-8500cad7ea8f@rock-chips.com>
Date: Fri, 13 Feb 2026 11:14:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260213030905.1134519-1-ping.gao@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c54fe1e2d09cckunm730bf0ba25ae4a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0xMS1ZISUJIGkJDQkhJHUJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=KZOuDmff/JpLqoJ6hPodCDYIpBqHNq6cFPaAEhW1cyHmBpXI64FW6ypSEiH1l8lTDKvy10jlQNDfCF1AZ7/WEOH4dV+Z4eYUF2UlqD84/dDEAxPlRxHyxsz+dP8eqx1/pKgRLJ5aVf0sUwcK8A7oULZ1yN7JCdKetSepNavjw10=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=qfRTWj720q7Jo9BOmzXdCAkMuVOoXkdjvBEg044KwyE=;
	h=date:mime-version:subject:message-id:from;

在 2026/02/13 星期五 11:09, ping.gao 写道:
> mmc biu and ciu clk don't have to be set
> 

This commit message is incorrect. ciu is not a optional one now.
And this patch should be the first patch of this patchset, not the last
one.

> Signed-off-by: ping.gao <ping.gao@samsung.com>
> ---
>   Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> index a6292777e376..e86fd53ed217 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> @@ -24,7 +24,6 @@ properties:
>       maxItems: 1
>   
>     clocks:
> -    minItems: 2

minItems should still need 1, for ciu.

>       maxItems: 2
>       description:
>         Handle to "biu" and "ciu" clocks for the
> 
