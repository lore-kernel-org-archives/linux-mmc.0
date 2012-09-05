From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 3/5] mmc: dw-mmc: add the header file for exynos
 specific code.
Date: Wed, 05 Sep 2012 17:33:00 +0900
Message-ID: <50470E3C.5030800@samsung.com>
References: <503C797F.4040506@samsung.com> <5045D215.3080201@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:40688 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059Ab2IEIdW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Sep 2012 04:33:22 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M9V00N1KBR34SQ0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 05 Sep 2012 17:33:05 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M9V006LCBR4EX80@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 05 Sep 2012 17:33:05 +0900 (KST)
In-reply-to: <5045D215.3080201@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, Thomas Abraham <thomas.abraham@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>


>> +static inline void exynos_set_clk_drv_sample(struct dw_mci *host,
>> +		struct mmc_ios *ios)
>> +{
>> +	u32 regs, ratio;
>> +
>> +	regs = mci_readl(host, EXYNOS_CLKSEL);
>> +	ratio = SDMMC_GET_DIV_RATIO(reg);
>> +	if (!ratio) {
>> +		regs &= ~SDMMC_CLK_RESET_DRV_SAMPLE;
>> +		regs |= ratio;
>> +		if (ios->timing == MMC_TIMING_UHS_DDR50)
>> +			regs |= host->pdata->ddr_timing;
>> +		else
>> +			regs |= host->pdata->sdr_timing;
> 
> Ah right, I see you're using them from a different patch. It feels wrong
> to platform specific data within the general platform data structure as
> it would be there unused for every other platform. Perhaps it would be
> better to have an outer exynos platform data struct which contains the
> standard one, and then use container_of to access it using the pointer
> to the inner one. Does that make sense?
I will check this. thanks for comment..

Best Regards,
Jaehoon Chung
> 
>> +	} else
>> +		regs &= ~SDMMC_CLK_RESET_DRV_SAMPLE;
>> +
>> +	mci_writel(host, EXYNOS_CLKSEL, regs);
>> +}
>> +
>> +#endif /* _EXYNOS_DW_MMC_H */
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

