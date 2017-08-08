From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V4 04/11] mmc: core: Turn off CQE before sending commands
Date: Tue, 8 Aug 2017 15:04:52 +0300
Message-ID: <d5c5cf9a-f64c-ca30-95bb-9e284daeb6dc@intel.com>
References: <1500630584-22852-1-git-send-email-adrian.hunter@intel.com>
 <1500630584-22852-5-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFq2X-k-qubjD5gadYb0RHcPJNbi6X1Lkz5SCLUzA-oWjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:4313 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752169AbdHHMLU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 8 Aug 2017 08:11:20 -0400
In-Reply-To: <CAPDyKFq2X-k-qubjD5gadYb0RHcPJNbi6X1Lkz5SCLUzA-oWjw@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 07/08/17 16:59, Ulf Hansson wrote:
> On 21 July 2017 at 11:49, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> Turn off the CQE before sending commands, and ensure it is off in any reset
>> or power management paths, or re-tuning.
> 
> Please explain a bit why this is needed.
> 
> Also, it's not clear how it becomes re-enabled. Or it doesn't have to?

OK, I answered that in the previous email.  I can add more explanation here.

> 
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  drivers/mmc/core/core.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 26431267a3e2..b0af9db18eef 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -260,6 +260,9 @@ static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>>
>>         trace_mmc_request_start(host, mrq);
>>
>> +       if (host->cqe_on)
>> +               host->cqe_ops->cqe_off(host);
>> +
> 
> Why can't you use the ->cqe_disable() callback here instead?
> 
> I guess what puzzles me is that there is no corresponding ->cqe_on()
> callback. When does cqe gets turned on again?

That was covered in the previous email too.

> 
>>         host->ops->request(host, mrq);
>>  }
>>
>> @@ -982,6 +985,9 @@ int mmc_execute_tuning(struct mmc_card *card)
>>         if (!host->ops->execute_tuning)
>>                 return 0;
>>
>> +       if (host->cqe_on)
>> +               host->cqe_ops->cqe_off(host);
>> +
>>         if (mmc_card_mmc(card))
>>                 opcode = MMC_SEND_TUNING_BLOCK_HS200;
>>         else
>> @@ -1021,6 +1027,9 @@ void mmc_set_bus_width(struct mmc_host *host, unsigned int width)
>>   */
>>  void mmc_set_initial_state(struct mmc_host *host)
>>  {
>> +       if (host->cqe_on)
>> +               host->cqe_ops->cqe_off(host);
>> +
>>         mmc_retune_disable(host);
>>
>>         if (mmc_host_is_spi(host))
>> --
>> 1.9.1
>>
> 
> Kind regards
> Uffe
> 

