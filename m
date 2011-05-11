From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH v4 13/15] mmc eMMC signal voltage does not use CMD11
Date: Wed, 11 May 2011 08:01:31 -0700
Message-ID: <4354DA4C-591C-4199-8C9E-06C20001EB70@marvell.com>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
 <1304578151-1775-14-git-send-email-arindam.nath@amd.com>
 <BANLkTikpBMhTjxkuua9LV6tFvKp-4vuyvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:40564 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754016Ab1EKPin convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 May 2011 11:38:43 -0400
In-Reply-To: <BANLkTikpBMhTjxkuua9LV6tFvKp-4vuyvg@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Arindam Nath <arindam.nath@amd.com>, "cjb@laptop.org" <cjb@laptop.org>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "henry.su@amd.com" <henry.su@amd.com>, "aaron.lu@amd.com" <aaron.lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>


On May 11, 2011, at 2:19 AM, zhangfei gao wrote:

> On Thu, May 5, 2011 at 2:49 AM, Arindam Nath <arindam.nath@amd.com> wrote:
>> eMMC chips do not use CMD11 when changing voltage.  Add extra
>> argument to call to indicate if CMD11 needs to be sent.
> 
> mmc_set_signal_voltage or start_signal_voltage_switch may not support
> emmc, not only cmd11, but also start_signal_voltage_switch is wrote
> according to sd phys spec.

the callback may go to a different driver then sdhci.c  

> JESD84-A441 A8.1 describes how to support dual voltage of emmc,
> however it only support to 1.8v.
> Still not find emmc card which could support 1.2v.

eMMC 
vcc -- 3.3v  then vccq can be 3.3 or 1.8 or 1.2v
vcc -- 1.8v then vccq can be 1.8v or 1.2v

1.2 v vccq support is indicated in the CARD TYPE [196]

a standard SD host controller does not support 1.2v vccq but folks could extend the standard.

eMMC is not expected to be voltage switched.  The expectation is the board designer will
fix the voltages and no changes are needed. 

vccq is independent of vcc. see section 12.5.3.


> 
>> 
>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>> Reviewed-by: Arindam Nath <arindam.nath@amd.com>
>> ---
>>  drivers/mmc/core/core.c |    4 ++--
>>  drivers/mmc/core/core.h |    3 ++-
>>  drivers/mmc/core/sd.c   |    4 ++--
>>  3 files changed, 6 insertions(+), 5 deletions(-)
>> 
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 78a9b51..74b4409 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -942,7 +942,7 @@ u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
>>        return ocr;
>>  }
>> 
>> -int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
>> +int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, int cmd11)
>>  {
>>        struct mmc_command cmd;
>>        int err = 0;
>> @@ -953,7 +953,7 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
>>         * Send CMD11 only if the request is to switch the card to
>>         * 1.8V signalling.
>>         */
>> -       if (signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
>> +       if ((signal_voltage != MMC_SIGNAL_VOLTAGE_330) && cmd11) {
>>                memset(&cmd, 0, sizeof(struct mmc_command));
>> 
>>                cmd.opcode = SD_SWITCH_VOLTAGE;
>> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
>> index 93f3397..3c11e17 100644
>> --- a/drivers/mmc/core/core.h
>> +++ b/drivers/mmc/core/core.h
>> @@ -41,7 +41,8 @@ void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
>>  void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width,
>>                           unsigned int ddr);
>>  u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
>> -int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage);
>> +int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage,
>> +                          int cmd11);
>>  void mmc_set_timing(struct mmc_host *host, unsigned int timing);
>>  void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
>> 
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>> index 851c8fc..d2a05ab 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -731,7 +731,7 @@ try_again:
>>         */
>>        if (!mmc_host_is_spi(host) && rocr &&
>>           ((*rocr & 0x41000000) == 0x41000000)) {
>> -               err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
>> +               err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180, 1);
>>                if (err) {
>>                        ocr &= ~SD_OCR_S18R;
>>                        goto try_again;
>> @@ -1104,7 +1104,7 @@ int mmc_attach_sd(struct mmc_host *host)
>>        WARN_ON(!host->claimed);
>> 
>>        /* Make sure we are at 3.3V signalling voltage */
>> -       err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330);
>> +       err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330, 0);
>>        if (err)
>>                return err;
>> 
>> --
>> 1.7.1
>> 
>> 

