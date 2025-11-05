Received: from mail-m49219.qiye.163.com (mail-m49219.qiye.163.com [45.254.49.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823FE28DC4
	for <linux-mmc@vger.kernel.org>; Wed,  5 Nov 2025 02:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762308260; cv=none; b=QTtjuhhZWc9eXP3CLr7hJe+KWKE2jgCudT74aWNeF/JY9s9BsXx0iVfZ0iXnUi8ljHn5iV6dUP5342zGoUo2pvEAeifjpnm+cc0oBYFECjUwj+LhG8zUpJp6GVojVIITVRnXQtK7Qxz8wB4Z7E7j1LCFyXt5xHiRMv20BDxHJI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762308260; c=relaxed/simple;
	bh=gzcEdymnsljsIjpPqIzXG1A5mM1HAQkwgxo6QInTCfQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pDQUDCCjKpdTf7z/R8i7pH9k2vmhw0NBWZnQW5JV/dSesISf4+5jl/NB3HG8Nv9VXNDMWKby6yA/vo/ZPBrQs1K4+W+euKECYz4mD4cDWn7AuizhEzU5DY9QoqF6B1dOuGqAKLSRxK41P7/UgoMJbh+GzdBwLdyvJ7jThG54C00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=LWwNPkFQ; arc=none smtp.client-ip=45.254.49.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="LWwNPkFQ"
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 286988934;
	Wed, 5 Nov 2025 10:04:12 +0800 (GMT+08:00)
Message-ID: <af77b269-a9e3-470b-a6bf-81636235bf5e@rock-chips.com>
Date: Wed, 5 Nov 2025 10:04:12 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc-utils: lsmmc.c: print_mmc_cid(): correct
 year/month parsing
To: Peter Korsgaard <peter@korsgaard.com>
References: <20251104200008.940057-1-peter@korsgaard.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251104200008.940057-1-peter@korsgaard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a51c1e44009cckunm8e3ff480c47ffa
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxpPS1ZMSUlKThpDSB0ZTEtWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=LWwNPkFQcAoqtChdhMYZILBWbXQy1LswnlPTEJa9ci+OXQJYWSuzEihoEAL/H/fsgAVmLuREVyvbE5GqL3IliE+R1go1r0OizrGnjSzDiAQvu6xojdON2XtsVINUIhA4vO3bk156ni0bTFDe/B9QEWF8HITiNKXvrd2oOgHsjO4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=/E8T2vgjXrNTvDGqmfsaIhkja0fe2SVgVv0IDdRlGCA=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/05 星期三 4:00, Peter Korsgaard 写道:
> The parsing logic for the MMC manufacturing date had the year and month
> swapped.  From JESD84:
> 
> The manufacturing date, MDT, is composed of two hexadecimal digits, four
> bits each, representing a two digits date code m/y; The “m” field, most
> significant nibble, is the month code.  1 = January.  The “y” field, least
> significant nibble, is the year code.
> 
> Notice that this is the opposite of the SD bit ordering.
> 

That's ture.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

Another problem I noticed when reading the code is:

  628                 printf("\tMDT: 0x%01x%01x %u %s\n", mdt_month, 
mdt_year,
  629                        1997 + mdt_year, months[mdt_month]);
  630                 printf("\tCRC: 0x%02x\n", crc);

 From the JESD84-B51, section 7.2.7,

For e•MMC 4.41 and later devices, indicated by a value larger than 4 in
EXT_CSD_REV [192], the 4-bit“y” field shall roll over after 2012, so
that y=0 shall be used for 2013. See Table 77 for a list of valid y
values for specific e•MMC versions.

So mdt_year + 1997 seems wrong, too.

> Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
> ---
>   lsmmc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lsmmc.c b/lsmmc.c
> index 799e1ea..7331c1b 100644
> --- a/lsmmc.c
> +++ b/lsmmc.c
> @@ -589,7 +589,7 @@ static void print_mmc_cid(struct config *config, char *cid)
>   
>   	parse_bin(cid, "8u6r2u8u48a4u4u32u4u4u7u1r",
>   		&mid, &cbx, &oid, &pnm[0], &prv_major, &prv_minor, &psn,
> -		&mdt_year, &mdt_month, &crc);
> +		&mdt_month, &mdt_year, &crc);
>   
>   	pnm[6] = '\0';
>   

