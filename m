From: Philip Rakity <prakity@marvell.com>
Subject: Re: [BUG] CMD52 sent as first command not CMD0
Date: Sun, 6 Feb 2011 12:50:38 -0800
Message-ID: <00AF35E9-3CE0-44C7-AF18-E765AD5184D0@marvell.com>
References: <C85F98EE-B8C5-4037-A0FF-203265A7575C@marvell.com>
 <20110206003845.GA15019@void.printf.net>
 <BC6C6C10-631A-4482-BA1B-C6F0057BC54A@marvell.com>
 <20110206011514.GA15322@void.printf.net>
 <173274DF-475D-44FB-8C34-25728D12ADBB@marvell.com> <4D4E826E.40905@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:49468 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754044Ab1BFUun convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 6 Feb 2011 15:50:43 -0500
In-Reply-To: <4D4E826E.40905@yahoo.es>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


On Feb 6, 2011, at 3:13 AM, Albert Herranz wrote:

> Hi,
> 
> On 02/06/2011 02:35 AM, Philip Rakity wrote:
>> 
>> proposed solution:  I cannot verify this fix until Monday.
>> =====
>> 
>> CMD52 is a reset for SDIO cards.  CMD0 is not sufficient when
>> the card is being re-initialized.  Only send CMD52 if
>> a) doing a reinitialize
>> b) card is SDIO or SDIO_COMBO
>> 
>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>> ---
>> drivers/mmc/core/core.c |    7 ++++++-
>> 1 files changed, 6 insertions(+), 1 deletions(-)
>> 
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 30d4da4..f0ce6f6 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1521,7 +1521,12 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
>> 		mmc_hostname(host), __func__, host->f_init);
>> #endif
>> 	mmc_power_up(host);
>> -	sdio_reset(host);
>> +
>> +	/* reset sdio before CMD0 when card is being reinitialized */
>> +	if (host->card &&
>> +		(host->card->type == MMC_TYPE_SDIO ||
>> +		host->card->type == MMC_TYPE_SD_COMBO))
>> +			sdio_reset(host);
>> 	mmc_go_idle(host);
>> 	mmc_hwungate_clock(host);
>> 
> 
> At least on the Nintendo Wii, a platform reset _does not_ reset the SDIO hardware, and there is no known way to power-off/power-on it.
> So, in some cases like after a system reboot, we need to issue a CMD52 before a CMD0 (even if on that particular case host->card is NULL) to properly reset the Nintendo Wii SDIO-based Wireless LAN card from its previous state, otherwise the card is not detected.
> 
> The proposed fix breaks this and makes the card unavailable after a system reboot.
> 
> If you are concerned about unconditionally issuing a CMD52 then we can use a quirk to make sure that we always perform a SDIO reset at least for the Nintendo Wii.

Would be happy with either a quirk or comment in the code.   Comment seems easiest.

/* sdhci_reset will generate CMD52 to reset card.  SD/eMMC cards are ignore this */

or something like that.
> 
> Cheers,
> Albert



