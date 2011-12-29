From: Xie Shaohui-B21989 <B21989@freescale.com>
Subject: RE: [PATCH] mmc:sdhci: restore the enabled dma when do reset all
Date: Thu, 29 Dec 2011 09:05:22 +0000
Message-ID: <ED492CCEAF882048BC2237DE806547C901BA03@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1325065281-17785-1-git-send-email-Shaohui.Xie@freescale.com>
 <4EFB00AC.5070209@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:38315 "EHLO
	TX2EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829Ab1L2JFY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Dec 2011 04:05:24 -0500
In-Reply-To: <4EFB00AC.5070209@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>

>-----Original Message-----
>From: Adrian Hunter [mailto:adrian.hunter@intel.com]
>Sent: Wednesday, December 28, 2011 7:43 PM
>To: Xie Shaohui-B21989
>Cc: linux-mmc@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
>Subject: Re: [PATCH] mmc:sdhci: restore the enabled dma when do reset all
>
>On 28/12/11 11:41, Shaohui Xie wrote:
>> If dma is enabled, it'll be cleared when reset all is performed, this
>> can be observed on some platforms, such as P2041 which has a version
>> 2.3 controller, but platform like P4080 which has a version 2.2
>> controller, does not suffer this, so we will check if the dma is
>> enabled, we should restore it after reset all.
>>
>> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
>> ---
>> based on http://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git,
>> branch 'for-linus'.
>>
>>  drivers/mmc/host/sdhci.c |    7 +++++++
>>  1 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
>> 19ed580..22033c3 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -29,6 +29,7 @@
>>  #include <linux/mmc/host.h>
>>
>>  #include "sdhci.h"
>> +#include "sdhci-esdhc.h"
>>
>>  #define DRIVER_NAME "sdhci"
>>
>> @@ -176,6 +177,7 @@ static void sdhci_reset(struct sdhci_host *host,
>> u8 mask)  {
>>  	unsigned long timeout;
>>  	u32 uninitialized_var(ier);
>> +	u32 uninitialized_var(dma);
>>
>>  	if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
>>  		if (!(sdhci_readl(host, SDHCI_PRESENT_STATE) & @@ -189,6
>+191,8 @@
>> static void sdhci_reset(struct sdhci_host *host, u8 mask)
>>  	if (host->ops->platform_reset_enter)
>>  		host->ops->platform_reset_enter(host, mask);
>>
>> +	dma = sdhci_readl(host, ESDHC_DMA_SYSCTL);
>
>
>You must not access eSDHC-specific registers in generic SDHCI code
[Xie Shaohui] OK. Thank you, I'll call the wrapper API here.


Best Regards, 
Shaohui Xie


