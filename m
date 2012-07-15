From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw-mmc: retry to send when inform ciu
Date: Mon, 16 Jul 2012 08:39:22 +0900
Message-ID: <500354AA.8040909@samsung.com>
References: <4FFF9CD7.6000904@samsung.com>
 <CAGxe1ZGu9AiDxxmgN30h=ZvVE9-EGaqgUyXE9BSyrxED-WuthA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:23801 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399Ab2GOXjj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 15 Jul 2012 19:39:39 -0400
Received: from epcpsbgm2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M78008LX721YMB0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 16 Jul 2012 08:39:37 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M7800ELZ720HK90@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 16 Jul 2012 08:39:37 +0900 (KST)
In-reply-to: <CAGxe1ZGu9AiDxxmgN30h=ZvVE9-EGaqgUyXE9BSyrxED-WuthA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>

On 07/13/2012 03:49 PM, Girish K S wrote:

> On 13 July 2012 09:28, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> As DesignWare spec, when inform ciu, waiting for clearing start_bit
>> or HLE is set. In case of HLE, repeat the command.
>>
>> Before the patch, repeat the below message.
>> mmc_host mmc0: Timeout sending command (cmd 0x202000 arg 0x0 status 0x80202000)
>> If this message is produced, repeat the send command during 10 times.
> I dont understand what the above message. its not clear. can you
> please explain it

That message is meant that didn't send command.(debugging message at dw-mmc.c).
It means also that exist the other command in buffer. So second/third command can't send.
Then maybe set HLE bit. And produced that message..

>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c |   39 +++++++++++++++++++++++++++++++--------
>>  1 files changed, 31 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 72dc3cd..bec1a67 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -603,7 +603,7 @@ static void dw_mci_submit_data(struct dw_mci *host, struct mmc_data *data)
>>         }
>>  }
>>
>> -static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
>> +static int mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
>>  {
>>         struct dw_mci *host = slot->host;
>>         unsigned long timeout = jiffies + msecs_to_jiffies(500);
>> @@ -616,11 +616,37 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
>>         while (time_before(jiffies, timeout)) {
>>                 cmd_status = mci_readl(host, CMD);
>>                 if (!(cmd_status & SDMMC_CMD_START))
>> -                       return;
>> +                       return 0;
>>         }
>>         dev_err(&slot->mmc->class_dev,
>>                 "Timeout sending command (cmd %#x arg %#x status %#x)\n",
>>                 cmd, arg, cmd_status);
>> +
>> +       return -ETIMEDOUT;
>> +}
>> +
>> +static void dw_mci_inform_ciu(struct dw_mci_slot *slot)
>> +{
>> +       struct dw_mci *host = slot->host;
>> +       unsigned long retry = 10;
>> +       int ret;
>> +       u32 ctrl;
>> +
>> +       while (1) {
>> +               ret = mci_send_cmd(slot,
>> +                    SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
>> +               if (!ret)
>> +                       break;
> the returned error type is timeout. Is it not necessary to read and
> check the HLE bit here before resending.

i didn't feel the necessity. if produced that message, then just repeat command.
I think that its case is only HLE case.

Best Regards,
Jaehoon Chung

>> +               ctrl = mci_readl(host, CTRL);
>> +               ctrl |= SDMMC_CTRL_RESET;
>> +               mci_writel(host, CTRL, ctrl);
>> +
>> +               if (retry-- == 0) {
>> +                       dev_err(&slot->mmc->class_dev,"Timeout inform CIU\n");
>> +                       break;
>> +               } else
>> +                       dev_info(&slot->mmc->class_dev,"Retry send command\n");
>> +       }
>>  }
>>
>>  static void dw_mci_setup_bus(struct dw_mci_slot *slot)
>> @@ -649,23 +675,20 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot)
>>                 mci_writel(host, CLKSRC, 0);
>>
>>                 /* inform CIU */
>> -               mci_send_cmd(slot,
>> -                            SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
>> +               dw_mci_inform_ciu(slot);
>>
>>                 /* set clock to desired speed */
>>                 mci_writel(host, CLKDIV, div);
>>
>>                 /* inform CIU */
>> -               mci_send_cmd(slot,
>> -                            SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
>> +               dw_mci_inform_ciu(slot);
>>
>>                 /* enable clock */
>>                 mci_writel(host, CLKENA, ((SDMMC_CLKEN_ENABLE |
>>                            SDMMC_CLKEN_LOW_PWR) << slot->id));
>>
>>                 /* inform CIU */
>> -               mci_send_cmd(slot,
>> -                            SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
>> +               dw_mci_inform_ciu(slot);
>>
>>                 host->current_speed = slot->clock;
>>         }
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


