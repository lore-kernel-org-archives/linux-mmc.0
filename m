From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: modified the DMA threshold for SD card
Date: Mon, 26 Sep 2011 17:34:46 +0900
Message-ID: <4E803926.4070508@samsung.com>
References: <4E7B0797.4030605@samsung.com> <4E7B0A58.8040408@imgtec.com>
 <4E7FFE74.3090000@samsung.com> <4E8036F1.8060304@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:19584 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400Ab1IZIfX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Sep 2011 04:35:23 -0400
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LS400H6FFURI310@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 26 Sep 2011 17:35:21 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LS400MMHFUX2E70@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 26 Sep 2011 17:35:21 +0900 (KST)
In-reply-to: <4E8036F1.8060304@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>

Hi James.

I found other problem about not reading scr register.

Did you have 2.40a spec?

Our code is based on lower version than 2.40a.
In DWC_mobile_storage 2.40a spec, DATA register address is changed.

Now we used DATA register address is 0x100.(in 2.40a, Address 0x100 is used for CardThrCtl register)
But in 2.40a, DATA register address is 0x200... 
Maybe i think the reason why PIO mode is broken.

We need to set DATA register according to VERID.(reading VERID register)

I will send the patch for this point.

Best Regards,
Jaehoon Chung
 

> Our current hardware also has a data width of 32.
> 
> Does it work if you disable DMA (by returning -ENODEV at the beginning
> of dw_mci_submit_data_dma)? That would prove that the problem wasn't
> caused by DMA mode leaving the hardware in a bad state before switching
> to PIO mode.

> 

> Cheers
> James
> 
>> Best regards,
>> Jaehon Chung
>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


