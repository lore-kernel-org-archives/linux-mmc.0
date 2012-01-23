From: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
Subject: Re: [PATCH 2/4] ARM: pxa168: Add SDHCI support
Date: Mon, 23 Jan 2012 16:45:23 -0600
Message-ID: <4F1DE303.2020203@einfochips.com>
References: <CAN1soZwwPe1Xdh=EO-wdynihaBQ8DvWV=imjokJvDZVC+qqdSg@mail.gmail.com> <1325166236-18650-1-git-send-email-tanmay.upadhyay@einfochips.com> <CAN1soZwG37noxK8CUe7zMtaNJPTWSok5ROUXj_YvZ+dLEVkomA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ahm.einfochips.com ([203.76.128.206]:1785 "EHLO
	ahm.einfochips.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491Ab2AWWpf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Jan 2012 17:45:35 -0500
In-Reply-To: <CAN1soZwG37noxK8CUe7zMtaNJPTWSok5ROUXj_YvZ+dLEVkomA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: eric.y.miao@gmail.com, jason.chagas@marvell.com
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, prakity@marvell.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org



On Thursday 29 December 2011 06:36 PM, Haojian Zhuang wrote:
> On Thu, Dec 29, 2011 at 9:43 PM, Tanmay Upadhyay
> <tanmay.upadhyay@einfochips.com>  wrote:
>> v2 - clock register for SDHCI are not common across all MMP SoCs.
>>      So, move PXA168 implementation to pxa168.c
>>
>> v3 - sdhci-pxav1 driver code is merged with sdhci-pxav2. So, change
>>      the device name accordingly
>>    - start sdhci device numbering from 1 as other PXA168 devices
>>      does that
>>
>> v4 - Use different names for SD clock registers for PXA168 instead
>>      of redefining them in pxa168.c. Suggested by Haojian Zhuang
>>
>> v5 - Have two different clock enable functions for clock block 1&  2
>>      &  don't change indentation in regs-apmu.h as suggested by Haojian
>>      Zhuang
>>    - Use device name while adding clock as suggested by Russell King
>>
>> Signed-off-by: Tanmay Upadhyay<tanmay.upadhyay@einfochips.com>
>> Reviewed-by: Philip Rakity<prakity@marvell.com>
>> ---
> Acked-by: Haojian Zhuang<haojian.zhuang@gmail.com>

Hi Eric, Jason,

Does this look good to you?

Thanks,

Tanmay
