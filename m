From: Philip Rakity <prakity@marvell.com>
Subject: RFC: add support for eMMC
Date: Mon, 21 Mar 2011 10:31:57 -0700
Message-ID: <62230604-99EF-480B-A1D5-DA5B852330C2@marvell.com>
References: <6C03668EAF45B747AF947A1603D1B300EA3398AF@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:38887 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752933Ab1CURdL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 21 Mar 2011 13:33:11 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Arindam Nath <arindam.nath@amd.com>


> 
>> -----Original Message-----
>> From: Philip Rakity [mailto:prakity@marvell.com]
>> Sent: Sunday, March 20, 2011 11:41 AM
>> To: Nath, Arindam
>> Subject: eMMC now working on old patch set -- SDIO more complicated
>> 
>> Hi Arindam,
>> 
>> Have eMMC working.  Note the comment about voltage !
>> 
>> SDIO cannot validate as trace lines for plug in card are too long to
>> support SDR50.  If I force the clock down to 50MHz then it is okay.
>> says ultra high speed.  Not a validation but a data point.
>> 
>> I will need a host->ops in sdhci.c -- already have a patch for this but
>> will resubmit.  Our controller requires we set 18V enable when we do
>> UHS.  Setting the bit does not affect the voltage.
>> 
>> Philip
>> 
>> 
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 87dae37..b51165c 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -718,7 +718,7 @@ void mmc_set_bus_width_ddr(struct mmc_host *host,
>> unsigned int width,
>> 			   unsigned int ddr)
>> {
>> 	host->ios.bus_width = width;
>> -	host->ios.ddr = ddr;
>> +	host->ios.timing = ddr;
>> 	mmc_set_ios(host);
>> }
>> 
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 14e95f3..d3896b8 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -20,6 +20,7 @@
>> #include "core.h"
>> #include "bus.h"
>> #include "mmc_ops.h"
>> +#include "sd_ops.h"
>> 
>> static const unsigned int tran_exp[] = {
>> 	10000,		100000,		1000000,	10000000,
>> @@ -668,8 +669,27 @@ static int mmc_init_card(struct mmc_host *host,
>> u32 ocr,
>> 				1 << bus_width, ddr);
>> 			goto free_card;
>> 		} else if (ddr) {
>> +			/*
>> +			 * eMMC cards can support 3.3V to 1.2V i/o (vccq)
>> +			 * signaling.
>> +			 *
>> +			 * EXT_CSD_CARD_TYPE_DDR_1_8V means 3.3V or 1.8V vccq.
>> +			 *
>> +			 * 1.8V vccq at 3.3V core voltage (vcc) is not required
>> +			 * in the JEDEC spec for DDR.
>> +			 *
>> +			 * Do not force change in vccq since we are obviously
>> +			 * working and no change to vccq is needed.
>> +			 *
>> +			 * WARNING: eMMC rules are NOT the same as SD DDR
>> +			 */
>> +			if (ddr == EXT_CSD_CARD_TYPE_DDR_1_2V) {
>> +				err = mmc_start_voltage_switch(host);
>> +				if (err)
>> +					goto err;
>> +			}
>> 			mmc_card_set_ddr_mode(card);
>> -			mmc_set_bus_width_ddr(card->host, bus_width, ddr);
>> +			mmc_set_bus_width_ddr(card->host, bus_width,
>> MMC_TIMING_UHS_DDR50);
>> 		}
>> 	}
>> 
>> 
>> 
>> 
> 
> 

