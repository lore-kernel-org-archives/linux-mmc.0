From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] mmc: sunxi: Don't start commands while the card is
 busy
Date: Sat, 1 Aug 2015 11:01:18 +0200
Message-ID: <55BC8ADE.3070802@redhat.com>
References: <1436541284-11800-1-git-send-email-hdegoede@redhat.com>
 <CAPDyKFoNe0bghfSXs48stHzZToTc7Hjd5gVPy-VbDF8bzdVVMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFoNe0bghfSXs48stHzZToTc7Hjd5gVPy-VbDF8bzdVVMQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Eugene K <sigintmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On 21-07-15 14:15, Ulf Hansson wrote:
> On 10 July 2015 at 17:14, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> Some sdio wifi modules have not been working reliable with the sunxi-mmc
>> host code. This turns out to be caused by it starting new commands while
>> the card signals that it is still busy processing a previous command.
>
> Which are those commands?

The code were things get stuck when not waiting for the busy signal uses
the following sdio helper functions:

sdio_readb/sdio_writeb
sdio_f0_readb/sdio_f0_writeb
sdio_readw/sdio_writew
sdio_readl/sdio_writel
sdio_readsb
sdio_memcpy_fromio/sdio_memcpy_toio

And directly issues the following command:

         mmc_dat.flags = write ? MMC_DATA_WRITE : MMC_DATA_READ;
         mmc_cmd.opcode = SD_IO_RW_EXTENDED;
         mmc_cmd.arg = write ? 1<<31 : 0;        /* write flag  */
         mmc_cmd.arg |= (fn & 0x7) << 28;        /* SDIO func num */
         mmc_cmd.arg |= 1<<27;                   /* block mode */
         /* for function 1 the addr will be incremented */
         mmc_cmd.arg |= (fn == 1) ? 1<<26 : 0;
         mmc_cmd.flags = MMC_RSP_SPI_R5 | MMC_RSP_R5 | MMC_CMD_ADTC;

I do not know if the busy wait is necessary for all
of these, but the hack in the android kernel code,
which inserts calls to a wait_card_busy function directly
into: drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c

Does so for all of these.

 > Or more interesting, which response types do
> these commands expect?
> I don't think this is a sunxi specific issue, I have seen similar
> issues for other host controllers.

Agreed, recent dw-mmc patches address the same issue, also involving
broadcom sdio wifi chips.

> I am thinking that perhaps this should be managed by the mmc core
> instead of local hacks to sunxi. Potentially we could make the core to
> invoke the already existing host_ops->card_busy() callback when
> needed...

I'm fine with solving this either way, implementing host_ops->card_busy()
for sunxi is easy, and if the core os modified to call that function
before issue sdio io ops (which seems to be the common thing here),
then that indeed is better then having the sunxi code always do
the busy check.

> Within this context, could I ask whether you controller supports IRQ
> based HW-busy detection? Or you need polling of the status register?

I'm afraid that we need to poll the status register. I've been unable
to find an irq flag corresponding to this.

Regards,

Hans


>> This commit fixes this, thereby fixing the wifi reliability issues on
>> the Cubietruck and other sunxi boards using sdio wifi.
>>
>> Reported-by: Eugene K <sigintmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Suggested-by: Eugene K <sigintmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Cc: Eugene K <sigintmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Cc: Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
