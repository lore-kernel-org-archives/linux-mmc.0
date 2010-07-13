From: Yusuke Goda <yusuke.goda.sx@renesas.com>
Subject: Re: [PATCH] tmio_mmc: Prevents unexpected status clear
Date: Tue, 13 Jul 2010 10:16:39 +0900
Message-ID: <4C3BBE77.8080000@renesas.com>
References: <4C33DF98.10409@renesas.com>
 <20100708144626.2091f6c1.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.renesas.com ([202.234.163.13]:36065 "EHLO
	mail08.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754766Ab0GMBRB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Jul 2010 21:17:01 -0400
In-reply-to: <20100708144626.2091f6c1.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Hi Andrew

Thank you for your comment.

>>  #define ack_mmc_irqs(host, i) \
>>  	do { \
>> -		u32 mask;\
>> -		mask  = sd_ctrl_read32((host), CTL_STATUS); \
>> -		mask &= ~((i) & TMIO_MASK_IRQ); \
>> -		sd_ctrl_write32((host), CTL_STATUS, mask); \
>> +		sd_ctrl_write32((host), CTL_STATUS, ~(i)); \
>>  	} while (0)
> 
> Can we have a better changelog please?
> 
> What was wrong with the old code?
> 
> How does the patch fix it?
> 
> What are the user-visible runtime effects of the bug?
> 
> (It looks like that was a pretty gross bug - how did it pass testing??)
Example
 - CMD53(Single block read / Received data size : 64Byte)

 1) Send CMD53
 2) Receive "CMD53 response"
 3) Call tmio_mmc_cmd_irq(host, status);
-- original code ----------------------------------------------------
 #define ack_mmc_irqs(host, i) \
	do { \
		u32 mask;\
		mask  = sd_ctrl_read32((host), CTL_STATUS); \
	< case 1 >
		mask &= ~((i) & TMIO_MASK_IRQ); \
	< case 2 >
		sd_ctrl_write32((host), CTL_STATUS, mask); \
	} while (0)
---------------------------------------------------------------------

TMIO_STAT_RXRDY status will be cleared by "sd_ctrl_write32((host), CTL_STATUS, mask);"
if TMIO_STAT_RXRDY becomes effective between "< case 1 >" and "< case 2 >".

This causes the phenomenon that a TMIO_STAT_RXRDY interrupt does not occur.
When received data are small, it rarely occurs.


Thanks,
Goda

