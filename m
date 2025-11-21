Received: from mail-m32109.qiye.163.com (mail-m32109.qiye.163.com [220.197.32.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81BD33985;
	Fri, 21 Nov 2025 00:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763685223; cv=none; b=rccy5Oq7wxXVXYcTgfFTvhvhidu5iqYL1/kz3AmwyKLHyAywKjz4RBqXt2dGROs171mVivVyM7JRS9/szoq8EnRvPsMWBcRh+TG6Mkxmj3k1GL+3PP8ss7XhAZQgyzGex5qbbEXt2rL/obSZjS2+6/B8jLG+KaR2E32yOKLFTas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763685223; c=relaxed/simple;
	bh=1FPC5SKoHRHaX9oZ3hB66WlmRWjBGfmxkQBkWeCFpFk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cs9cKmQMGlDJJ2sr4qur5LkdY/no7VzB3jrX3Xr8cTWqkKYxfRdQwt3LshsIU2NBS+gKnxaYernUDDj/YKk8ogrK3vt4T7D16FVeckUjBHNaGemRFCTBQeXb1uW9caQtSfHAYcGBWhANEddcE1RwXdQBIZF+x2kGrtgQ5l8oM/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=eb5BssPx; arc=none smtp.client-ip=220.197.32.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="eb5BssPx"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2a581c997;
	Fri, 21 Nov 2025 08:33:29 +0800 (GMT+08:00)
Message-ID: <f05d6fff-e909-4885-935a-0b5460f226fb@rock-chips.com>
Date: Fri, 21 Nov 2025 08:33:26 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>,
 William Qiu <william.qiu@starfivetech.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Shawn Lin as co-maintainer for dw_mmc
 drivers
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
References: <20251120142902.252513-1-ulf.hansson@linaro.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251120142902.252513-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9aa3d4943b09cckunm7925e4251b958b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU9DTVZKHx9DQ0waS04YQk1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=eb5BssPx0JDVEVEg2JFuAMdkUfW6Upv/DGIEYZyFTZLGGJd3eOKtda+unl3+xjK0rzJvA/DXxGyUIQJrgYpU93cgtAfC1gMvUcZXD9LUt/6WQeM6b2awqdL+BGG+fY5Zo6DW65cHU31/CAsV7WqbuTLi/rWfHQB1nLNsAGJDzWk=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=GR+OTi4QbkQV0HHydhca4YuVISOqqH/skMVy6fXOYGg=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/20 星期四 22:29, Ulf Hansson 写道:
> Shawn offered to help with the Synposys Designware MMC/SD/SDIO drivers,
> let's add him as a co-maintainer.
>

Thanks Ulf.

Acked-by: Shawn Lin <shawn.lin@rock-chips.com> > Signed-off-by: Ulf 
Hansson <ulf.hansson@linaro.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 545a4776795e..64cb7c0c4ee2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24930,6 +24930,7 @@ F:	include/linux/soc/amd/isp4_misc.h
>   
>   SYNOPSYS DESIGNWARE MMC/SD/SDIO DRIVER
>   M:	Jaehoon Chung <jh80.chung@samsung.com>
> +M:	Shawn Lin <shawn.lin@rock-chips.com>
>   L:	linux-mmc@vger.kernel.org
>   S:	Maintained
>   F:	drivers/mmc/host/dw_mmc*

