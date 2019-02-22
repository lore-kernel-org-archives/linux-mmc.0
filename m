From: Laura Abbott <labbott@redhat.com>
Subject: Re: panic with CONFIG_FAIL_MMC_REQUEST and cqhci
Date: Fri, 22 Feb 2019 13:16:14 -0800
Message-ID: <248f4e5f-f204-b998-bd14-a08dfb774932@redhat.com>
References: <d220878f-2981-5e5e-22b0-5534cc037e8d@redhat.com>
 <5e81d594-15bb-81f5-75a0-a147fd5cfc18@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5e81d594-15bb-81f5-75a0-a147fd5cfc18@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Asutosh Das <asutoshd@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

On 2/22/19 5:42 AM, Ritesh Harjani wrote:
> Hi Laura,
> 
> On 2/19/2019 12:59 AM, Laura Abbott wrote:
>> Hi,
>>
>> Fedora got report of a panic when I accidentally left debugging enabled
>> on a build https://bugzilla.redhat.com/show_bug.cgi?id=1677438
>>
>> It looks like a panic from code in CONFIG_FAIL_MMC_REQUEST from the
>> cqhci driver because there isn't a command (high level overview)
> 
> With CQHCI, in case of non-DCMD (data) requests, mrq->cmd can be NULL.
> Is this crash happening always (100% on bootup) with CQHCI & CONFIG_FAIL_MMC_REQUEST enabled?
> 
> Sure, I will role out a patch to handle this case.
> It will be great, if you could also confirm it from your side.
> 

Thanks, I'll have to follow up with the reporter and see if he
gets back to me.

> Regards
> Ritesh
> 
> 
>>
>> (gdb) list *(mmc_should_fail_request+0xa)
>> 0x149a is in mmc_should_fail_request (drivers/mmc/core/core.c:98).
>> 93        };
>> 94
>> 95        if (!data)
>> 96            return;
>> 97
>> 98        if (cmd->error || data->error ||
>> 99            !should_fail(&host->fail_mmc_request, data->blksz * data->blocks))
>> 100            return;
>> 101
>> 102        data->error = data_errors[prandom_u32() % ARRAY_SIZE(data_errors)];
>> (gdb)
>>
>> (gdb) list *(mmc_cqe_request_done+0x1c)
>> 0x2a6c is in mmc_cqe_request_done (drivers/mmc/core/core.c:505).
>> 500    void mmc_cqe_request_done(struct mmc_host *host, struct mmc_request *mrq)
>> 501    {
>> 502        mmc_should_fail_request(host, mrq);
>> 503
>> 504        /* Flag re-tuning needed on CRC errors */
>> 505        if ((mrq->cmd && mrq->cmd->error == -EILSEQ) ||
>> 506            (mrq->data && mrq->data->error == -EILSEQ))
>> 507            mmc_retune_needed(host);
>> 508
>> 509        trace_mmc_request_done(host, mrq);
>>
>>
>> (gdb) list *(cqhci_irq+0x1d2)
>> 0x1172 is in cqhci_irq (drivers/mmc/host/cqhci.c:747).
>> 742                data->bytes_xfered = 0;
>> 743            else
>> 744                data->bytes_xfered = data->blksz * data->blocks;
>> 745        }
>> 746
>> 747        mmc_cqe_request_done(mmc, mrq);
>> 748    }
>> 749
>> 750    irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
>> 751                  int data_error)
>>
>> This can be worked around by turning off the option but it
>> seems like something to fix up.
>>
>> Thanks,
>> Laura
