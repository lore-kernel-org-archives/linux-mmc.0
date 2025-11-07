Received: from mail-m128172.netease.com (mail-m128172.netease.com [103.209.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0742F83B8
	for <linux-mmc@vger.kernel.org>; Fri,  7 Nov 2025 01:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.209.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762479563; cv=none; b=kf4UZMeAMys8drIFtn71hTpqP5hLc6peXxc21I/hXULPrDIXtkB/g0PP+Acc7kP3VLHvy+iWw5Hseol3YzMotXi8gJQtxOFn8WbKuyUbaXBVLcj16fwyZm9uvRvDTOyhWiJ8/TDwf02yiIPRNa7oeS4/6YSa/mhqPWsgNvw9tdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762479563; c=relaxed/simple;
	bh=JisxTYeEBHtGpujlREjBFIwlfBMKp3ga2vJX7p5jkQM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HmwVCrfXt8roTLBS92CrmWoZAmZg5H7N0bHJmzbdTLvWgJKRFqj4xUMzk5Tyh0Wb2oN/shkKnybE4DER6kCT1dZ7pE6Me3mvK0aTAETgv8RP6u9QIEEEL5fxmNeFpAClRuiZZkmxeG6ojtBMkxdT2jxXfEPtAFhr5RzEtAfAwsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=iXI0AM96; arc=none smtp.client-ip=103.209.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="iXI0AM96"
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 28b4a78c4;
	Fri, 7 Nov 2025 09:39:11 +0800 (GMT+08:00)
Message-ID: <b568ac6f-5089-4e40-8e17-2c23e9ca85d6@rock-chips.com>
Date: Fri, 7 Nov 2025 09:39:07 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH 1/2] mmc-utils: lsmmc.c: print_mmc_cid(): correct
 year/month parsing
To: Avri Altman <Avri.Altman@sandisk.com>
References: <20251104200008.940057-1-peter@korsgaard.com>
 <af77b269-a9e3-470b-a6bf-81636235bf5e@rock-chips.com>
 <87qzud6jq8.fsf@dell.be.48ers.dk>
 <77ce48fa-dfdf-43c9-8094-c1c47ff48aac@rock-chips.com>
 <PH7PR16MB619676787C5B72C51598EFEBE5C5A@PH7PR16MB6196.namprd16.prod.outlook.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <PH7PR16MB619676787C5B72C51598EFEBE5C5A@PH7PR16MB6196.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a5bf7b22b09cckunma417e9a3f45ea3
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR8ZTVZIH0pCGh9KGk4eTE5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=iXI0AM96PW3vQhgweNf4oyv3yvgy8tJoz3+/LKGFwB+lACxE5sUcM7GhNNyudmlk2Z397B3Q5+hcovMElZUDTerq1Q41E8eh77colWfD3lZFIyt9SVfFV3k+0dsJDEwjdDOQQlYNacRKLAxtNA8u1lg3ZDXiIWBr66PW46pLOKo=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=n2wJBhwT1kVUStvlWRfnOkzrTGJ7jDGO7K/Sduv6Z+M=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/06 星期四 3:57, Avri Altman 写道:
> 
> 
>> -----Original Message-----
>> From: Shawn Lin <shawn.lin@rock-chips.com>
>> Sent: Wednesday, November 5, 2025 9:24 AM
>> To: Peter Korsgaard <peter@korsgaard.com>
>> Cc: shawn.lin@rock-chips.com; linux-mmc@vger.kernel.org; Avri Altman
>> <avri.altman@wdc.com>; Ulf Hansson <ulf.hansson@linaro.org>
>> Subject: Re: [PATCH 1/2] mmc-utils: lsmmc.c: print_mmc_cid(): correct
>> year/month parsing
>>
>> CAUTION: This email originated from outside of Sandisk. Do not click on links or
>> open attachments unless you recognize the sender and know that the contents
>> are safe.
>>
>>
>> 在 2025/11/05 星期三 15:07, Peter Korsgaard 写道:
>>>>>>>> "Shawn" == Shawn Lin <shawn.lin@rock-chips.com> writes:
>>>
>>> Hi,
>>>
>>>    > From the JESD84-B51, section 7.2.7,
>>>
>>>    > For e•MMC 4.41 and later devices, indicated by a value larger than 4 in
>>>    > EXT_CSD_REV [192], the 4-bit“y” field shall roll over after 2012, so
>>>    > that y=0 shall be used for 2013. See Table 77 for a list of valid y
>>>    > values for specific e•MMC versions.
>>>
>>>    > So mdt_year + 1997 seems wrong, too.
>>>
>>> That tweak is even not enough, E.G. I see the kernel does:
>>>
>>>          if (card->ext_csd.rev >= 5) {
>>>                   /* Adjust production date as per JEDEC JESD84-B451 */
>>>                   if (card->cid.year < 2010)
>>>                           card->cid.year += 16;
>>>
>>> 2009 + 16 = 2025, so what will happen in a few months?
>>>
>>
>> TBH, I don't know if there is any update from JEDEC. :)
> Hi,
> Yeah - they noticed that as well and proposed a similar approach by extending the ext-csd-rev to 9.0.
> I had the code ready for a while now but somehow failed to submit it yet.
> Here it is.
> Thanks for fixing the year-month misplacement.
> 
> Thanks,
> Avri
> 
> 
>  From c0e5ec1d3670161444943c8984b6cdafb82fac67 Mon Sep 17 00:00:00 2001
> From: Avri Altman <avri.altman@sandisk.com>
> Date: Thu, 13 Mar 2025 10:10:49 +0200
> Subject: [PATCH] mmc: core: Adjust MDT beyond 2025
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> JEDEC JC64.1 proposal, which was recently approved, increases the

Ah, I thinks I should have checked the JESD84-B51b.

> manufacturing year limit for eMMC devices. The eMMC manufacturing year
> is stored in a 4-bit field in the CID register. Originally, it covered
> 1997–2012. Later, with EXT_CSD_REV=8, it was extended up to 2025. Now,
> with EXT_CSD_REV=9, the range is rolled over by another 16 years, up to
> 2038.
> 
> The mapping is as follows:
> 
> | cid[8..11] | ver ≤ 4 | rev > 4 | rev > 8 |
> |------------|---------|---------|---------|
> | 0          | 1997    | 2013    | 2029    |
> | 1          | 1998    | 2014    | 2030    |
> | 2          | 1999    | 2015    | 2031    |
> | 3          | 2000    | 2016    | 2032    |
> | 4          | 2001    | 2017    | 2033    |
> | 5          | 2002    | 2018    | 2034    |
> | 6          | 2003    | 2019    | 2035    |
> | 7          | 2004    | 2020    | 2036    |
> | 8          | 2005    | 2021    | 2037    |
> | 9          | 2006    | 2022    | 2038    |
> | 10         | 2007    | 2023    |         |
> | 11         | 2008    | 2024    |         |
> | 12         | 2009    | 2025    |         |
> | 13         | 2010    |         | 2026    |
> | 14         | 2011    |         | 2027    |
> | 15         | 2012    |         | 2028    |
> 
> Signed-off-by: Avri Altman <avri.altman@sandisk.com>


LGTM,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> ---
>   drivers/mmc/core/mmc.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 3e7d9437477c..8f355a72b84c 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -672,6 +672,13 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>   					(card->ext_csd.rel_param &
>   					 EXT_CSD_WR_REL_PARAM_EN_RPMB_REL_WR);
>   	}
> +
> +	if (card->ext_csd.rev >= 9) {
> +		/* Adjust production date as per JEDEC JC64.1 */
> +		if (card->cid.year < 2023)
> +			card->cid.year += 16;
> +	}
> +
>   out:
>   	return err;
>   }

