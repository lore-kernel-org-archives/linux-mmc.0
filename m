From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V4 07/11] mmc: mmc: Enable CQE's
Date: Thu, 10 Aug 2017 12:49:20 +0300
Message-ID: <fc32caa5-fd58-4b45-c40a-3e4976b412a6@intel.com>
References: <1500630584-22852-1-git-send-email-adrian.hunter@intel.com>
 <1500630584-22852-8-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFq93Q132JPVpXFFGFcQA_CjM6v2sZ2Ci69pZ3kr3fZoMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:13036 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750909AbdHJJ5I (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 10 Aug 2017 05:57:08 -0400
In-Reply-To: <CAPDyKFq93Q132JPVpXFFGFcQA_CjM6v2sZ2Ci69pZ3kr3fZoMA@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 07/08/17 17:51, Ulf Hansson wrote:
> On 21 July 2017 at 11:49, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> Enable or disable CQE when a card is added or removed respectively.
> 
> As a standalone change, this is hard to understand.
> 
> Perhaps if you squash this with some the patche calling ->cqe_off()
> and the one actually setting ext_csd.cmdq_en, I can get a better
> picture.

No they are not related.

> 
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  drivers/mmc/core/bus.c |  7 +++++++
>>  drivers/mmc/core/mmc.c | 13 +++++++++++++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
>> index 301246513a37..a4b49e25fe96 100644
>> --- a/drivers/mmc/core/bus.c
>> +++ b/drivers/mmc/core/bus.c
>> @@ -369,10 +369,17 @@ int mmc_add_card(struct mmc_card *card)
>>   */
>>  void mmc_remove_card(struct mmc_card *card)
>>  {
>> +       struct mmc_host *host = card->host;
>> +
>>  #ifdef CONFIG_DEBUG_FS
>>         mmc_remove_card_debugfs(card);
>>  #endif
>>
>> +       if (host->cqe_enabled) {
>> +               host->cqe_ops->cqe_disable(host);
>> +               host->cqe_enabled = false;
>> +       }
>> +
> 
> This doesn't feel like the correct place to disable cqe.
> 
> Primarily because I don't think you enable cqe in mmc_add_card(), so
> this isn't consistent.

mmc_add_card() and mmc_remove_card() are not paired functions. Instead
mmc_remove_card() is on the error path of the ..._init_card() functions and
consequently this is the best place for cqe->disable().

> 
>>         if (mmc_card_present(card)) {
>>                 if (mmc_host_is_spi(card->host)) {
>>                         pr_info("%s: SPI card removed\n",
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 2ff0caf92bc8..92c6167d64e0 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1804,6 +1804,19 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>>          */
>>         card->reenable_cmdq = card->ext_csd.cmdq_en;
>>
>> +       if (card->ext_csd.cmdq_en && (host->caps2 & MMC_CAP2_CQE) &&
>> +           !host->cqe_enabled) {
> 
> I assume card->ext_csd.cmdq_en can't be set, unless the MMC_CAP2_CQE
> bit also is set. So there should be no reason to check it here again?

Yes, it is a left-over from software command queue support.  I will remove it.

> 
> Also, can ever host->cqe_enabled be true in this path? If so, isn't
> that wrong by itself?

No, it can be set on the reset path.

> 
>> +               err = host->cqe_ops->cqe_enable(host, card);
>> +               if (err) {
>> +                       pr_err("%s: Failed to enable CQE, error %d\n",
>> +                               mmc_hostname(host), err);
>> +               } else {
>> +                       host->cqe_enabled = true;
>> +                       pr_info("%s: Command Queue Engine enabled\n",
>> +                               mmc_hostname(host));
>> +               }
>> +       }
>> +
>>         /*
>>          * The mandatory minimum values are defined for packed command.
>>          * read: 5, write: 3
>> --
>> 1.9.1
>>
> 
> Kind regards
> Uffe
> 

