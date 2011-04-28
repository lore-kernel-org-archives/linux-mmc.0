From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] mmc: eMMC signal voltage does not use CMD11
Date: Thu, 28 Apr 2011 15:46:28 -0700
Message-ID: <E389301A-B40E-4857-8678-DC806A710BB7@marvell.com>
References: <ABE44455-4F1B-45A2-AED9-150C8E5DBED0@marvell.com>
 <6C03668EAF45B747AF947A1603D1B300EB72D36F@SAUSEXMBP01.amd.com>
 <390DC252-295C-4B82-8D5F-43E92EA5D3AF@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:34078 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756607Ab1D1Wqd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Apr 2011 18:46:33 -0400
In-Reply-To: <390DC252-295C-4B82-8D5F-43E92EA5D3AF@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <Arindam.Nath@amd.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


Hi Arindam,

Since this mmc_set_signal_voltage() routine will be used by SDIO and MMC should the code be moved
the code core.c ?

I am not sure about drive strength or driver type since SDIO handles these differently then SD.

Philip

On Apr 26, 2011, at 8:26 AM, Philip Rakity wrote:

> 
> Hi Arindam,
> 
> On Apr 25, 2011, at 11:45 PM, Nath, Arindam wrote:
> 
>> Hi Philip,
>> 
>> 
>>> -----Original Message-----
>>> From: Philip Rakity [mailto:prakity@marvell.com]
>>> Sent: Saturday, April 23, 2011 1:56 AM
>>> To: linux-mmc@vger.kernel.org
>>> Cc: Nath, Arindam
>>> Subject: [PATCH] mmc: eMMC signal voltage does not use CMD11
>>> 
>>> 
>>> eMMC chips do not use CMD11 when changing voltage.  Add extra
>>> argument to call to indicate if CMD11 needs to be sent.
>>> 
>>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>>> ---
>>> drivers/mmc/core/sd.c     |    4 ++--
>>> drivers/mmc/core/sd_ops.c |    4 ++--
>>> drivers/mmc/core/sd_ops.h |    3 ++-
>>> 3 files changed, 6 insertions(+), 5 deletions(-)
>>> 
>>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>>> index ed6b11b..362716c 100644
>>> --- a/drivers/mmc/core/sd.c
>>> +++ b/drivers/mmc/core/sd.c
>>> @@ -734,7 +734,7 @@ try_again:
>>> 	 */
>>> 	if (!mmc_host_is_spi(host) && rocr &&
>>> 	   ((*rocr & 0x41000000) == 0x41000000)) {
>>> -		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
>>> +		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180,
>>> 1);
>>> 		if (err) {
>>> 			ocr &= ~(1 << 24);
>>> 			goto try_again;
>>> @@ -1115,7 +1115,7 @@ int mmc_attach_sd(struct mmc_host *host)
>>> 		host->ocr_avail = host->ocr_avail_sd;
>>> 
>>> 	/* Make sure we are at 3.3V signalling voltage */
>>> -	err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330);
>>> +	err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330, 0);
>>> 	if (err)
>>> 		return err;
>>> 
>>> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
>>> index fc7edc4..6fd35f6 100644
>>> --- a/drivers/mmc/core/sd_ops.c
>>> +++ b/drivers/mmc/core/sd_ops.c
>>> @@ -149,7 +149,7 @@ int mmc_app_set_bus_width(struct mmc_card *card,
>>> int width)
>>> 	return 0;
>>> }
>>> 
>>> -int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
>>> +int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage,
>>> int cmd11)
>>> {
>>> 	struct mmc_command cmd;
>>> 	int err = 0;
>>> @@ -160,7 +160,7 @@ int mmc_set_signal_voltage(struct mmc_host *host,
>>> int signal_voltage)
>>> 	 * Send CMD11 only if the request is to switch the card to
>>> 	 * 1.8V signalling.
>>> 	 */
>>> -	if (signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
>>> +	if (signal_voltage != MMC_SIGNAL_VOLTAGE_330 && cmd11) {
>> 
>> Since we are going to send CMD11 only to change to 1.8V signaling, and when cmd11 is set, isn't it better to have
>> 
>> 	if ((signal_voltage == MMC_SIGNAL_VOLTAGE_180) && cmd11) {
> 
> I am okay with this.  Wanted to cover the possible future case for 1.2V support and CMD11.  I know eMMC does not do
> CMD11 but incase SD or SDIO ever did.   If you feel strongly will change code.
>> 
>> Thanks,
>> Arindam
>> 
>>> 		memset(&cmd, 0, sizeof(struct mmc_command));
>>> 
>>> 		cmd.opcode = SD_SWITCH_VOLTAGE;
>>> diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
>>> index d5bdda5..2670e71 100644
>>> --- a/drivers/mmc/core/sd_ops.h
>>> +++ b/drivers/mmc/core/sd_ops.h
>>> @@ -20,7 +20,8 @@ int mmc_app_send_scr(struct mmc_card *card, u32
>>> *scr);
>>> int mmc_sd_switch(struct mmc_card *card, int mode, int group,
>>> 	u8 value, u8 *resp);
>>> int mmc_app_sd_status(struct mmc_card *card, void *ssr);
>>> -int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage);
>>> +int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage,
>>> +	int cmd11);
>>> 
>>> #endif
>>> 
>>> --
>>> 1.7.0.4
>>> 
>>> 
>> 
>> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

