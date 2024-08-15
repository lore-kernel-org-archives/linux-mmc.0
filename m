Received: from mail-m49225.qiye.163.com (mail-m49225.qiye.163.com [45.254.49.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD1C7DA63
	for <linux-mmc@vger.kernel.org>; Thu, 15 Aug 2024 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725578; cv=none; b=aYBTHCEFuIIb5Q7BJQl+9+jliO3Rpw6nA5Y+DQEyZ2U8LvQI+uFVi5JIWIQABxDMmFLPR4Ok1PNOzbpJ6ZIO+YnwiEqqkdQ1ueWgaCY7F8Y9lZCXj8ItdVriVrMjzhV+ifapvbDjBuRPT1jUlJRDnTpxASM7wP40ilnrgzpaWbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725578; c=relaxed/simple;
	bh=J1gaBgW4f/j48RpigO48ZYPCBTeeQJSXBq9jgkuC72E=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iwYD+ykDdRLaxDjc5dVsThScy1ofn9zS/W6BxER6tjm0oWX+4LLnilaL11AkjFDHzxx+9R3b80kpZzGHBXO/hecZRW/2IL4M+jXnmOenvfEJlbmsNvR2c1S4VkE811gIsqHl2DbwdCgwJs6D5jaq/U6nU3cnsc54OGyMIMkgM/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=jrR4XYlK; arc=none smtp.client-ip=45.254.49.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="jrR4XYlK"
DKIM-Signature: a=rsa-sha256;
	b=jrR4XYlKx1/ujBNffXA3C56y3a2RFpzP/NdG9IrdfSBib1YBn3iHCLvQ7I3/4VWBpPnUlhkq1Bgw609aLCb6IOUpu/t04gX9i7HsvdOYb72QA8y6U2kIsQgPhxJ9CaulXZS3m5+A3ioux95cAKn7Kqf7lZTMtvzw5MRz4Blveh0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=uRw6GvejijH8fkpp9InYMIjN8c3bD5QuIHPwxgikl+Y=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.45] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id DDE624608E4;
	Thu, 15 Aug 2024 19:44:15 +0800 (CST)
Message-ID: <aa4bd0dc-b349-4ef7-83a7-59af67d61cbf@rock-chips.com>
Date: Thu, 15 Aug 2024 19:44:15 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Ricky WU <ricky_wu@realtek.com>
Subject: Re: [PATCH v3 10/10] mmc: core: Adjust ACMD22 to SDUC
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org
References: <20240814072934.2559911-1-avri.altman@wdc.com>
 <20240814072934.2559911-11-avri.altman@wdc.com>
Content-Language: en-GB
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20240814072934.2559911-11-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhgeSlYaS0xNS0pNTEtIGhhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9155da4f5903aekunmdde624608e4
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NAw6Shw5FzIrH0I0DiIjAxEw
	Px1PCw1VSlVKTElITElJSU5NTUJIVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlKTk43Bg++

Hi Avri,

在 2024/8/14 15:29, Avri Altman 写道:
> @@ -948,13 +949,20 @@  static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
>   	int err;
>   	u32 result;
>   	__be32 *blocks;
> -
> + u8 resp_sz;
>   	struct mmc_request mrq = {};
>   	struct mmc_command cmd = {};
>   	struct mmc_data data = {};
> -
>   	struct scatterlist sg;
>   
> + /*
> + * SD cards, specifically high volume cards, expect to be allowed with the
> + * full 500msec busy period post write. Otherwise, they may not indicate
> + * correctly the number of bytes written.
> + */
> + if (mmc_card_is_sduc(card->host))
> + mmc_delay(500);

Could you kindly point me to the right section of SD spec which states 
this 500ms before ACMD22 ? Is it the write busy time?

And as you mentioned high volume cards, I am curious if 1TB sandisk
MircoSDXC need 500ms delay as well?
