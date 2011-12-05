From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH] arm, da8xx, mmc: set second MMC controllers default queue
Date: Mon, 05 Dec 2011 11:46:33 +0100
Message-ID: <4EDCA109.2090204@denx.de>
References: <1322991210-20486-1-git-send-email-hs@denx.de>
 <B6A220404B6BFC4BBD2AB91C54D39DF4029FE5@DBDE01.ent.ti.com>
Reply-To: hs@denx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from a.relay.invitel.net ([62.77.203.3]:39907 "EHLO
	a.relay.invitel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755896Ab1LEKqi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2011 05:46:38 -0500
In-reply-to: <B6A220404B6BFC4BBD2AB91C54D39DF4029FE5@DBDE01.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "juha.kuikka@gmail.com" <juha.kuikka@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Ido Yariv <ido@wizery.com>, "Nori, Sekhar" <nsekhar@ti.com>, Wolfgang Denk <wd@denx.de>

Hello Rajashekhara,

Rajashekhara, Sudhakar wrote:
> Hi,
> 
> On Sun, Dec 04, 2011 at 15:03:30, Heiko Schocher wrote:
>> The MMC driver allocates channels with EVENTQ_DEFAULT they
>> get put into EVENTQ_1 which the second EDMA controller does
>> not have and hence transfers stall. This is tried to fix
>> in commit f23fe857bbea393b4b94fe2218c98d934bd3d4cf
>> from Ido Yariv, but missed a fix for the second MMC
>> controller on da850.
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> Signed-off-by: juha.kuikka@gmail.com
>> Reported-by: juha.kuikka@gmail.com
>> Cc: linux-mmc@vger.kernel.org
>> Cc: davinci-linux-open-source@linux.davincidsp.com
>> Cc: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
>> Cc: Ido Yariv <ido@wizery.com>
>> Cc: Sekhar Nori <nsekhar@ti.com>
>> Cc: Wolfgang Denk <wd@denx.de>
>> ---
>>  arch/arm/mach-davinci/dma.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
>> index da90103..e10a251 100644
>> --- a/arch/arm/mach-davinci/dma.c
>> +++ b/arch/arm/mach-davinci/dma.c
>> @@ -1513,7 +1513,7 @@ static int __init edma_probe(struct platform_device *pdev)
>>  		 * started by the codec engine will not cause audio defects.
>>  		 */
>>  		for (i = 0; i < edma_cc[j]->num_channels; i++)
>> -			map_dmach_queue(j, i, EVENTQ_1);
>> +			map_dmach_queue(j, i, info[j]->default_queue);
>>  
>>  		queue_tc_mapping = info[j]->queue_tc_mapping;
>>  		queue_priority_mapping = info[j]->queue_priority_mapping;
> 
> Acked-by: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>

Thanks, but as Ido commented, this patch is no longer necessary, sorry
for the noise.

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
