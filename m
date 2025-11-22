Received: from mail-m19731120.qiye.163.com (mail-m19731120.qiye.163.com [220.197.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBFD36D4E7
	for <linux-mmc@vger.kernel.org>; Sat, 22 Nov 2025 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763809907; cv=none; b=rTCaUi4lc1dqoed3uWFQTj721HdKFi+mumLjO/lMVRFho0m7jsvVku6Gc+3U5Xwm+t3OgppknE9leIkwOpBsD9m7VUmnYCf0hWRdOT5Z002DKBZpyco+TDdwTrIuumiMjtvQ2VRDKcOnJBx8YyJsBc07zPJnRXO8t79HEX5WVd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763809907; c=relaxed/simple;
	bh=kz/qnzxRAkNRtjGQXuSSMhoIERETMisx8TGYhpGRo7Y=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rpZGd2sLZXG6t8Vdx3b1G9nI9yg4mWb9cT07xjALnhpDyYT36b1ZuSq2K+D60GduaJ2uj35Sk0tWSt1e82nqyyTv7yEW5X4EJv2IU7eVSJQELnVE2LECTJhx8hVP08gy7jYt5uNG2YwvKRUaSQeI8HWtPzU/3PaIHCbvsCi1aD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=RekA0ZBw; arc=none smtp.client-ip=220.197.31.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="RekA0ZBw"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2a83b2ec1;
	Sat, 22 Nov 2025 19:06:26 +0800 (GMT+08:00)
Message-ID: <e9fefbde-3da2-44ad-9003-75b937595d31@rock-chips.com>
Date: Sat, 22 Nov 2025 19:06:25 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Avri Altman <avri.altman@sandisk.com>
Subject: Re: [PATCH 1/2] mmc: core: Adjust MDT beyond 2025
To: Avri Altman <avri.altman@gmail.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
References: <20251122070442.111690-1-avri.altman@sandisk.com>
 <20251122070442.111690-2-avri.altman@sandisk.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251122070442.111690-2-avri.altman@sandisk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9aab3e6c8409cckunmce7607c02b2daf
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkhLQlZOTR9NQkpNGUNKHUpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=RekA0ZBwuFvynlATomDKcr+PHW6kwnXQI9WmON70p6TFTZY+CcRLm8f9Dsor0/2OGDYbj8TNKeZWebNx80YVDFVsK1tujWpGXTCN4DWX1Ug5id2Zt2puhHHFURAZn0r2Ky+5Pg7dDnN/HX3d5fgvghs3N5RMjDXU+UmuSGvQbeI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=Vne6DXiEBPJKL2keXs+rQEszg/L80crTJPb4MMlODLo=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/22 星期六 15:04, Avri Altman 写道:
> JEDEC JC64.1 proposal, which was recently approved, increases the
> manufacturing year limit for eMMC devices. The eMMC manufacturing year
> is stored in a 4-bit field in the CID register. Originally, it covered
> 1997–2012. Later, with EXT_CSD_REV=8, it was extended up to 2025. Now,
> with EXT_CSD_REV=9, the range is rolled over by another 16 years, up to
> 2038.
> 
> The mapping is as follows:
> cid[8..11] | rev ≤ 4 | 8 ≥ rev > 4 | rev > 8
> ---------------------------------------------
> 0          | 1997    | 2013        | 2029
> 1          | 1998    | 2014        | 2030
> 2          | 1999    | 2015        | 2031
> 3          | 2000    | 2016        | 2032
> 4          | 2001    | 2017        | 2033
> 5          | 2002    | 2018        | 2034
> 6          | 2003    | 2019        | 2035
> 7          | 2004    | 2020        | 2036
> 8          | 2005    | 2021        | 2037
> 9          | 2006    | 2022        | 2038
> 10         | 2007    | 2023        |
> 11         | 2008    | 2024        |
> 12         | 2009    | 2025        |
> 13         | 2010    |             | 2026
> 14         | 2011    |             | 2027
> 15         | 2012    |             | 2028
> 
> Signed-off-by: Avri Altman <avri.altman@sandisk.com>
> ---
>   drivers/mmc/core/mmc.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 7c86efb1044a..4c36029b28a3 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -671,7 +671,14 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>   		card->ext_csd.enhanced_rpmb_supported =
>   					(card->ext_csd.rel_param &
>   					 EXT_CSD_WR_REL_PARAM_EN_RPMB_REL_WR);
> +
> +                if (card->ext_csd.rev >= 9) {
> +		        /* Adjust production date as per JEDEC JC64.1 */

Given other comment in mmc subsystem  used JESD84-B451/B50/B51，should
we use JESD84-B51B released in Sept. 2025 instead?

Anyway,
Reviewed-by: Shawn Lin <shawn.linrock-chips.com>

> +		        if (card->cid.year < 2023)
> +			        card->cid.year += 16;
> +	        }
>   	}
> +
>   out:
>   	return err;
>   }

