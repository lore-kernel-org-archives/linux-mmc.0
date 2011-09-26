From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: modified the DMA threshold for SD card
Date: Mon, 26 Sep 2011 13:24:20 +0900
Message-ID: <4E7FFE74.3090000@samsung.com>
References: <4E7B0797.4030605@samsung.com> <4E7B0A58.8040408@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:16618 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab1IZEYz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Sep 2011 00:24:55 -0400
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LS4009TV48T9HB0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 26 Sep 2011 13:24:54 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LS400G6149ILG40@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 26 Sep 2011 13:24:54 +0900 (KST)
In-reply-to: <4E7B0A58.8040408@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>

James Hogan wrote:

> On 09/22/2011 11:01 AM, Jaehoon Chung wrote:
>> This patch modified the DMA threshold.
>>
>> I didn't know exactly why need this threshold.
>> But if this value is 16, we didn't read SCR register for SD card.
>> Because in mmc_app_send_scr this values are used data.blocks=1 and data.blksz=8.
>> (data.blocks * data.blksz = 8...so return -EINVAL)
> 
> The idea is that for a small transaction the time to set up the DMA is
> probably not worth the effort, therefore it does it using PIO mode (see
> dw_mci_submit_data, if dw_mci_submit_data_dma fails, it sets itself up
> for pio mode instead).

Is there some reason that threshold is set 16?

> 
> So if it's using PIO mode and the SCR cannot be read, then PIO mode is
> broken. What's the value of the register HCON? dw_mci_probe reads it and
> decides which pio push and pull function to use based on the host data
> width. I've only tested one of them as we only have one configuration of
> hardware available, but you may have a different one.


i used push/pull_data_32. What do you doubt this problem?

Best regards,
Jaehon Chung


