From: Arend van Spriel <arend@broadcom.com>
Subject: Re: [PATCH v2] mmc: sunxi: Don't start commands while the card is
 busy
Date: Tue, 28 Jul 2015 21:22:30 +0200
Message-ID: <55B7D676.1020800@broadcom.com>
References: <1436541284-11800-1-git-send-email-hdegoede@redhat.com> <CAPDyKFoNe0bghfSXs48stHzZToTc7Hjd5gVPy-VbDF8bzdVVMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:63300 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbbG1TWg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jul 2015 15:22:36 -0400
In-Reply-To: <CAPDyKFoNe0bghfSXs48stHzZToTc7Hjd5gVPy-VbDF8bzdVVMQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Chris Ball <chris@printf.net>, Mike Turquette <mturquette@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com, Eugene K <sigintmailru@gmail.com>

On 07/21/2015 02:15 PM, Ulf Hansson wrote:
> On 10 July 2015 at 17:14, Hans de Goede <hdegoede@redhat.com> wrote:
>> Some sdio wifi modules have not been working reliable with the sunxi-mmc
>> host code. This turns out to be caused by it starting new commands while
>> the card signals that it is still busy processing a previous command.
>
> Which are those commands? Or more interesting, which response types do
> these commands expect?
> I don't think this is a sunxi specific issue, I have seen similar
> issues for other host controllers.

Indeed. A similar fix was needed for dw_mmc host controller.

> I am thinking that perhaps this should be managed by the mmc core
> instead of local hacks to sunxi. Potentially we could make the core to
> invoke the already existing host_ops->card_busy() callback when
> needed...

The problem here is that there are a number of host controllers out 
there not implementing that callback. That may be because the hardware 
is dealing properly with busy signalling, but I would not bet on that.

Regards,
Arend

> Within this context, could I ask whether you controller supports IRQ
> based HW-busy detection? Or you need polling of the status register?
>
>>
>> This commit fixes this, thereby fixing the wifi reliability issues on
>> the Cubietruck and other sunxi boards using sdio wifi.
>>
>> Reported-by: Eugene K <sigintmailru@gmail.com>
>> Suggested-by: Eugene K <sigintmailru@gmail.com>
>> Cc: Eugene K <sigintmailru@gmail.com>
>> Cc: Arend van Spriel <arend@broadcom.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -Properly accredit Eugene K for coming up with the fix for this
>> ---
>>   drivers/mmc/host/sunxi-mmc.c | 32 ++++++++++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
>> index 4d3e1ff..daa90b7 100644
>> --- a/drivers/mmc/host/sunxi-mmc.c
>> +++ b/drivers/mmc/host/sunxi-mmc.c
>> @@ -289,6 +289,24 @@ static int sunxi_mmc_init_host(struct mmc_host *mmc)
>>          return 0;
>>   }
>>
>> +/* Wait for card to report ready before starting a new cmd */
>> +static int sunxi_mmc_wait_card_ready(struct sunxi_mmc_host *host)
>> +{
>> +       unsigned long expire = jiffies + msecs_to_jiffies(500);
>> +       u32 rval;
>> +
>> +       do {
>> +               rval = mmc_readl(host, REG_STAS);
>> +       } while (time_before(jiffies, expire) && (rval & SDXC_CARD_DATA_BUSY));
>> +
>> +       if (rval & SDXC_CARD_DATA_BUSY) {
>> +               dev_err(mmc_dev(host->mmc), "Error R1 ready timeout\n");
>> +               return -EIO;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>   static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
>>                                      struct mmc_data *data)
>>   {
>> @@ -383,6 +401,8 @@ static void sunxi_mmc_send_manual_stop(struct sunxi_mmc_host *host,
>>          u32 arg, cmd_val, ri;
>>          unsigned long expire = jiffies + msecs_to_jiffies(1000);
>>
>> +       sunxi_mmc_wait_card_ready(host);
>> +
>>          cmd_val = SDXC_START | SDXC_RESP_EXPIRE |
>>                    SDXC_STOP_ABORT_CMD | SDXC_CHECK_RESPONSE_CRC;
>>
>> @@ -597,6 +617,11 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
>>   {
>>          unsigned long expire = jiffies + msecs_to_jiffies(250);
>>          u32 rval;
>> +       int ret;
>> +
>> +       ret = sunxi_mmc_wait_card_ready(host);
>> +       if (ret)
>> +               return ret;
>>
>>          rval = mmc_readl(host, REG_CLKCR);
>>          rval &= ~(SDXC_CARD_CLOCK_ON | SDXC_LOW_POWER_ON);
>> @@ -785,6 +810,13 @@ static void sunxi_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>                  return;
>>          }
>>
>> +       ret = sunxi_mmc_wait_card_ready(host);
>> +       if (ret) {
>> +               mrq->cmd->error = ret;
>> +               mmc_request_done(mmc, mrq);
>> +               return;
>> +       }
>> +
>>          if (data) {
>>                  ret = sunxi_mmc_map_dma(host, data);
>>                  if (ret < 0) {
>> --
>> 2.4.3
>>
>
> Kind regards
> Uffe
>

