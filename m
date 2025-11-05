Received: from mail-m49223.qiye.163.com (mail-m49223.qiye.163.com [45.254.49.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE30A927
	for <linux-mmc@vger.kernel.org>; Wed,  5 Nov 2025 07:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762327757; cv=none; b=p+LZkNQ5bTPk0h5Neww7nPF3wtAsAfuN8r6T5ohJfFZnzmp6NOSqC5+7rB0/Y/Z0cq82Fzb+QoUBa0P/pvkrECjlhCCEVMHaFZmguG9KEnQCZEy9IPi6YCfIbXUVmlYxqO8awvOjDQOuDKOTKBKoahVZld7Ddg3Pae8jaEHNJvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762327757; c=relaxed/simple;
	bh=BPfL+EGWIQvRriLA6dtJwlRRWIx8yuX3DUjDxdXJa5E=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aPab/OYE0ZdSIvWhyYGgO2Cv9dmt8nvQz2zdyZw7Q/qBys4KHXu/y7sgN0+w7iBF/+7CH2p2EhueV21pOyzGeNTorxXSQQZ0cgRsoKyn9A5bSMHPqlNgOIDryF4m/x56iDvz0McaxjlUNNZvKwDzbejzY36TOSK0NsSfErRdii8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=iJDPZ8Hd; arc=none smtp.client-ip=45.254.49.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="iJDPZ8Hd"
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2875a7266;
	Wed, 5 Nov 2025 15:23:56 +0800 (GMT+08:00)
Message-ID: <77ce48fa-dfdf-43c9-8094-c1c47ff48aac@rock-chips.com>
Date: Wed, 5 Nov 2025 15:23:55 +0800
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
 <af77b269-a9e3-470b-a6bf-81636235bf5e@rock-chips.com>
 <87qzud6jq8.fsf@dell.be.48ers.dk>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <87qzud6jq8.fsf@dell.be.48ers.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a52e69c1809cckunme2b6a04bcc4505
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxhIH1ZCQh8eHUhNTUxPHkJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=iJDPZ8HdLricoS7FAY/rFniQDbCITQr98C0NHn5l2423mOrUdzO3hZ3GWHjOfqoovxguWBcbRlkaTMfsiMVFExQFe1d4nX3esyGO8b6wnJNuTN1lHTtUrh8W3yaNeR9WPRJQYGNTP2ACUZ3suUFjvwu0AQgIOq43Q2gJDx+SM64=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=FG7ZkO03yFdyJz3ZeHSFDdkaSnehpNIebtqvQhr+gb8=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/05 星期三 15:07, Peter Korsgaard 写道:
>>>>>> "Shawn" == Shawn Lin <shawn.lin@rock-chips.com> writes:
> 
> Hi,
> 
>   > From the JESD84-B51, section 7.2.7,
> 
>   > For e•MMC 4.41 and later devices, indicated by a value larger than 4 in
>   > EXT_CSD_REV [192], the 4-bit“y” field shall roll over after 2012, so
>   > that y=0 shall be used for 2013. See Table 77 for a list of valid y
>   > values for specific e•MMC versions.
> 
>   > So mdt_year + 1997 seems wrong, too.
> 
> That tweak is even not enough, E.G. I see the kernel does:
> 
>         if (card->ext_csd.rev >= 5) {
>                  /* Adjust production date as per JEDEC JESD84-B451 */
>                  if (card->cid.year < 2010)
>                          card->cid.year += 16;
> 
> 2009 + 16 = 2025, so what will happen in a few months?
> 

TBH, I don't know if there is any update from JEDEC. :)

