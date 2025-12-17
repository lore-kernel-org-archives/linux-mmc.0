Received: from mail-m32113.qiye.163.com (mail-m32113.qiye.163.com [220.197.32.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638752EA731
	for <linux-mmc@vger.kernel.org>; Wed, 17 Dec 2025 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765959452; cv=none; b=UPs6PDxPXG7nwor64x2dWK/JCI2H0u4riW5UFJBe05SbFQx1/i+GcF0rHDww+0DM8NKHEJjcUf2sPmNohxYIczWP1nsxbeO5jIZhSMYijWUTD+4mHK4wEmOS+wk103EA4MIjO9ucsIpGA6yowW0ftq9KLDuVyaXUSPauVVLQz2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765959452; c=relaxed/simple;
	bh=FUM5iwXi28r29aBFqoKpbCp6ptcrc1ZuZDz2w63VMYc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tCeio/XGzC9GY1qW/pP2rk1oBkZOcfmFzSmdDHmuwq2tU236lFlqzXrr+6+uKcbBbidU/3YZW7lwSYPNa6EdVWsHhdU1w7BEyhnU6UE954qqUuKJFSNa4yazyO3f5syA6D8EJxhGUC9kTr8xOKsUglwZc3Ea7SwdSoBmWXZhXCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=gW8pL3+8; arc=none smtp.client-ip=220.197.32.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="gW8pL3+8"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2d8f4751c;
	Wed, 17 Dec 2025 16:12:15 +0800 (GMT+08:00)
Message-ID: <93579df3-a91d-4dc6-b460-89cb5c6fdaf3@rock-chips.com>
Date: Wed, 17 Dec 2025 16:12:14 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org
Subject: Re: [bug report] mmc: dw_mmc: add dw_mci_prepare_desc() for both of
 32bit and 64bit DMA
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <aUJatHzP5fr1zvRF@stanley.mountain>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aUJatHzP5fr1zvRF@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b2b5df12109cckunm5d400dae490a36
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRoeSVYYTE1CGENLTRpMHU5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=gW8pL3+8D44R31kDtvy4ZPCVVz9tuy+e8+aRj/vtDE/PvwFnhEbVNbjXa1QqH502aBuxkgBjZ0nJjRgNHxdPGNqGwRSGgX1KsJN2HuPMRHr5vI8y0OWIV9TmRZxQfqMGBOTqwlW41z09Zn2b9nFZGnZz+zLwxIAvbbqwsi+pkTo=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Yh4K2JAarAA1F1+HWjrjgST79G2bF2eTryD8gG/rVBc=;
	h=date:mime-version:subject:message-id:from;

Hi Dan,

在 2025/12/17 星期三 15:24, Dan Carpenter 写道:
> Hello Shawn Lin,
> 
> Commit af7dde31afcc ("mmc: dw_mmc: add dw_mci_prepare_desc() for both
> of 32bit and 64bit DMA") from Nov 26, 2025 (linux-next), leads to the
> following Smatch static checker warning:
> 
> 	drivers/mmc/host/dw_mmc.c:597 dw_mci_prepare_desc()
> 	error: uninitialized symbol 'desc'.
> 

Thanks for pointing out this issue. I've sent an incremental patch.

Ulf, could you please help fold it into the offending patch? Sorry for
the inconvenience.


> drivers/mmc/host/dw_mmc.c
>      578 static inline int dw_mci_prepare_desc(struct dw_mci *host, struct mmc_data *data,
>      579                                       unsigned int sg_len, bool is_64bit)
>      580 {
>      581         unsigned int desc_len;
>      582         struct idmac_desc *desc_first, *desc_last, *desc;
>      583         struct idmac_desc_64addr *desc64_first, *desc64_last, *desc64;
>      584         u32 val, des0;
>      585         int i, err;
>      586
>      587         if (is_64bit)
>      588                 desc64_first = desc64_last = desc64 = host->sg_cpu;
>      589         else
>      590                 desc_first = desc_last = desc = host->sg_cpu;
>                                                   ^^^^
> 
>      591
>      592         for (i = 0; i < sg_len; i++) {
>      593                 unsigned int length = sg_dma_len(&data->sg[i]);
>      594
>      595                 u64 mem_addr = sg_dma_address(&data->sg[i]);
>      596
> --> 597                 for ( ; length ; desc++) {
> 
> desc is only initialized for 32bit.
> 
>      598                         desc_len = (length <= DW_MCI_DESC_DATA_LENGTH) ?
>      599                                    length : DW_MCI_DESC_DATA_LENGTH;
>      600
>      601                         length -= desc_len;
>      602
>      603                         /*
>      604                          * Wait for the former clear OWN bit operation
>      605                          * of IDMAC to make sure that this descriptor
>      606                          * isn't still owned by IDMAC as IDMAC's write
>      607                          * ops and CPU's read ops are asynchronous.
>      608                          */
>      609                         if (is_64bit)
>      610                                 err = readl_poll_timeout_atomic(&desc64->des0, val,
>      611                                         IDMAC_OWN_CLR64(val), 10, 100 * USEC_PER_MSEC);
>      612                         else
>      613                                 err = readl_poll_timeout_atomic(&desc->des0, val,
>      614                                         IDMAC_OWN_CLR64(val), 10, 100 * USEC_PER_MSEC);
>      615                         if (err)
>      616                                 goto err_own_bit;
>      617
>      618                         des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC | IDMAC_DES0_CH;
>      619                         if (is_64bit)
>      620                                 desc64->des0 = des0;
>      621                         else
>      622                                 desc->des0 = cpu_to_le32(des0);
>      623
>      624                         /*
>      625                          * 1. Set OWN bit and disable interrupts for this descriptor
>      626                          * 2. Set Buffer length
>      627                          * Set physical address to DMA to/from
>      628                          */
>      629                         if (is_64bit) {
>      630                                 desc64->des0 = IDMAC_DES0_OWN | IDMAC_DES0_DIC | IDMAC_DES0_CH;
>      631                                 IDMAC_64ADDR_SET_BUFFER1_SIZE(desc64, desc_len);
>      632                                 desc64->des4 = mem_addr & 0xffffffff;
>      633                                 desc64->des5 = mem_addr >> 32;
>      634                         } else {
>      635                                 IDMAC_SET_BUFFER1_SIZE(desc, desc_len);
>      636                                 desc->des2 = cpu_to_le32(mem_addr);
>      637                         }
>      638
>      639                         /* Update physical address for the next desc */
>      640                         mem_addr += desc_len;
>      641
>      642                         /* Save pointer to the last descriptor */
>      643                         if (is_64bit)
>      644                                 desc64_last = desc64;
>      645                         else
>      646                                 desc_last = desc;
>      647                 }
>      648         }
>      649
>      650         /* Set the first descriptor and the last descriptor */
>      651         if (is_64bit) {
>      652                 desc64_first->des0 |= IDMAC_DES0_FD;
>      653                 desc64_last->des0 &= ~(IDMAC_DES0_CH | IDMAC_DES0_DIC);
>      654                 desc64_last->des0 |= IDMAC_DES0_LD;
>      655         } else {
>      656                 desc_first->des0 |= cpu_to_le32(IDMAC_DES0_FD);
>      657                 desc_last->des0 &= cpu_to_le32(~(IDMAC_DES0_CH | IDMAC_DES0_DIC));
>      658                 desc_last->des0 |= cpu_to_le32(IDMAC_DES0_LD);
>      659         }
>      660
>      661         return 0;
>      662 err_own_bit:
>      663         /* restore the descriptor chain as it's polluted */
>      664         dev_dbg(host->dev, "descriptor is still owned by IDMAC.\n");
>      665         memset(host->sg_cpu, 0, DESC_RING_BUF_SZ);
>      666         dw_mci_idmac_init(host);
>      667         return -EINVAL;
>      668 }
> 
> regards,
> dan carpenter
> 

