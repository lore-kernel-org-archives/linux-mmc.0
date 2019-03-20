From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v3_1/3=5d_mmc=3a_dw=5fmmc=3a_Check_busy_st?=
 =?UTF-8?B?YXRlIGluIGR3X21jaV9yZXF1ZXN0KCnjgJDor7fms6jmhI/vvIzpgq7ku7bnlLFs?=
 =?UTF-8?B?aW51eC1tbWMtb3duZXJAdmdlci5rZXJuZWwub3Jn5Luj5Y+R44CR?=
Date: Wed, 20 Mar 2019 10:06:39 +0800
Message-ID: <cd9d8614-87fb-8016-baf6-5bfd98fcf135@rock-chips.com>
References: <1552986778-33904-1-git-send-email-shawn.lin@rock-chips.com>
 <1552986778-33904-2-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFqMjEbM1L5=AjDv46xZt5KxOk8GLMGbWsdq2Xcxoi3gTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAPDyKFqMjEbM1L5=AjDv46xZt5KxOk8GLMGbWsdq2Xcxoi3gTg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


On 2019/3/19 22:41, Ulf Hansson wrote:
> On Tue, 19 Mar 2019 at 10:14, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
>>
>> Move it from dw_mci_start_command() to dw_mci_request().
>> Then dw_mci_wait_while_busy() isn't called with host's
>> lock hold.
> 
> So, I decided to have a closer look at this.
> 
>>
>> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>> Tested-by: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>> ---
>>
>> Changes in v3: None
>> Changes in v2: None
>>
>>   drivers/mmc/host/dw_mmc.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 80dc2fd..703dedf 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -426,7 +426,6 @@ static void dw_mci_start_command(struct dw_mci *host,
>>
>>          mci_writel(host, CMDARG, cmd->arg);
>>          wmb(); /* drain writebuffer */
>> -       dw_mci_wait_while_busy(host, cmd_flags);
>>
>>          mci_writel(host, CMD, cmd_flags | SDMMC_CMD_START);
>>
>> @@ -1419,6 +1418,10 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>                  return;
>>          }
>>
>> +       if ((mrq->cmd->opcode != MMC_SEND_STATUS && mrq->cmd->data) &&
>> +           !(mrq->cmd->opcode == SD_SWITCH_VOLTAGE))
>> +               dw_mci_wait_while_busy(host, SDMMC_CMD_PRV_DAT_WAIT);
>> +
> 
> This looks weird, because according to the change-log it sounds like
> you are moving things around to just avoid having the "lock" held.
> 
> To me, there seems to be more changes because of the new checks for
> the "opcode" above, no?

yes, that's what original dw_mci_wait_while_busy() did internally.

> 
>   Moreover, dw_mci_wait_while_busy() is also called from
> mci_send_cmd(), which means it may still be called with the "lock" is
> held. That is really confusing and needs more explanation.

dwmmc need to send a *NULL* cmd with SDMMC_CMD_UPD_CLK set in its CMD
register, in order to update bus clock, which is quite differnet from
others hosts. So mci_send_cmd()->dw_mci_wait_while_busy() is used for 
updating bus clock but not in the hot path. So the main concern is to
move dw_mci_wait_while_busy() out from normal data requst.


> 
>>          spin_lock_bh(&host->lock);
>>
>>          dw_mci_queue_request(host, slot, mrq);
>> --
>> 1.9.1
>>
>>
>>
> 
> Finally, I am not sure I understand why dw_mci_wait_while_busy() is
> called before starting a command, at all. That seems wrong to me.
> Instead, shouldn't we look at cmd->flags & MMC_RSP_BUSY, for the
> request in question and don't call mmc_request_done() for it, before
> the card have stop signaled busy. At least that the behavior the mmc
> core expects by the driver.
> 

yes, that was from commit 0bdbd0e88cf6b603("mmc: dw_mmc: Don't start 
commands while busy"), and it says "We'll leverage the existing dw_mmc
knowledge about whether it should wait for the previous command to
finish to know whether we should check for busy before sending the
command". I think the word, "leverage", explains the whole point, seems
a little tricky though.

> Kind regards
> Uffe
> 
> 
