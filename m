From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH 1/7] mmc: sdhci: add support for using external DMA
 devices
Date: Mon, 28 Jan 2019 16:13:31 +0530
Message-ID: <a68b68f6-ea5f-2193-188f-cddeec9f6ef4@ti.com>
References: <20190111110851.6805-1-faiz_abbas@ti.com>
 <20190111110851.6805-2-faiz_abbas@ti.com>
 <bcea7bae-41c8-358a-11c1-3886f9dc0351@intel.com>
 <CAG2=9p-HsbghD2-m6VPEPCQVuSWC_1mZ=GL+aKZwZTgOgSO0sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAG2=9p-HsbghD2-m6VPEPCQVuSWC_1mZ=GL+aKZwZTgOgSO0sQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.chunyan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On 28/01/19 3:50 PM, Chunyan Zhang wrote:
> On Thu, 24 Jan 2019 at 19:41, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 11/01/19 1:08 PM, Faiz Abbas wrote:
>>> From: Chunyan Zhang <zhang.chunyan@linaro.org>
>>>
>>> Some standard SD host controllers can support both external dma
>>> controllers as well as ADMA/SDMA in which the SD host controller
>>> acts as DMA master. TI's omap controller is the case as an example.
>>>
>>> Currently the generic SDHCI code supports ADMA/SDMA integrated in
>>> the host controller but does not have any support for external DMA
>>> controllers implemented using dmaengine, meaning that custom code is
>>> needed for any systems that use an external DMA controller with SDHCI.
>>>
>>> Fixes by Faiz Abbas <faiz_abbas@ti.com>:
>>> 1. Map scatterlists before dmaengine_prep_slave_sg()
>>> 2. Use dma_async() functions inside of the send_command() path and
>>> synchronize once at the start of each request.
>>
>> Sorry for the slow reply, but I do have some concerns.  Please see the comments.
>>
>>>
>>> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>> ---
>>>  drivers/mmc/host/Kconfig |   3 +
>>>  drivers/mmc/host/sdhci.c | 266 ++++++++++++++++++++++++++++++++++++++-
>>>  drivers/mmc/host/sdhci.h |   8 ++
>>>  3 files changed, 273 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>>> index e26b8145efb3..333292e8ecdd 100644
>>> --- a/drivers/mmc/host/Kconfig
>>> +++ b/drivers/mmc/host/Kconfig
>>> @@ -999,3 +999,6 @@ config MMC_SDHCI_AM654
>>>         If you have a controller with this interface, say Y or M here.
>>>
>>>         If unsure, say N.
>>> +
>>> +config MMC_SDHCI_EXTERNAL_DMA
>>> +        bool
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index a22e11a65658..4a9044c06e21 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -14,6 +14,7 @@
>>>   */
>>>
>>>  #include <linux/delay.h>
>>> +#include <linux/dmaengine.h>
>>>  #include <linux/ktime.h>
>>>  #include <linux/highmem.h>
>>>  #include <linux/io.h>
>>> @@ -1118,6 +1119,226 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>>>       }
>>>  }
>>>
>>> +#if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
>>> +static int sdhci_external_dma_init(struct sdhci_host *host)
>>> +{
>>> +     int ret = 0;
>>> +     struct mmc_host *mmc = host->mmc;
>>> +
>>> +     host->tx_chan = dma_request_chan(mmc->parent, "tx");
>>> +     if (IS_ERR(host->tx_chan)) {
>>> +             ret = PTR_ERR(host->tx_chan);
>>> +             if (ret != -EPROBE_DEFER)
>>> +                     pr_warn("Failed to request TX DMA channel.\n");
>>> +             host->tx_chan = NULL;
>>> +             return ret;
>>> +     }
>>> +
>>> +     host->rx_chan = dma_request_chan(mmc->parent, "rx");
>>> +     if (IS_ERR(host->rx_chan)) {
>>> +             if (host->tx_chan) {
>>> +                     dma_release_channel(host->tx_chan);
>>> +                     host->tx_chan = NULL;
>>> +             }
>>> +
>>> +             ret = PTR_ERR(host->rx_chan);
>>> +             if (ret != -EPROBE_DEFER)
>>> +                     pr_warn("Failed to request RX DMA channel.\n");
>>> +             host->rx_chan = NULL;
>>> +     }
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static inline struct dma_chan *
>>> +sdhci_external_dma_channel(struct sdhci_host *host, struct mmc_data *data)
>>> +{
>>> +     return data->flags & MMC_DATA_WRITE ? host->tx_chan : host->rx_chan;
>>> +}
>>> +
>>> +static int sdhci_external_dma_setup(struct sdhci_host *host,
>>> +                                 struct mmc_command *cmd)
>>> +{
>>> +     int ret, i;
>>> +     struct dma_async_tx_descriptor *desc;
>>> +     struct mmc_data *data = cmd->data;
>>> +     struct dma_chan *chan;
>>> +     struct dma_slave_config cfg;
>>> +     dma_cookie_t cookie;
>>> +     int sg_cnt;
>>> +
>>> +     if (!host->mapbase)
>>> +             return -EINVAL;
>>> +
>>> +     cfg.src_addr = host->mapbase + SDHCI_BUFFER;
>>> +     cfg.dst_addr = host->mapbase + SDHCI_BUFFER;
>>> +     cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>>> +     cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>>> +     cfg.src_maxburst = data->blksz / 4;
>>> +     cfg.dst_maxburst = data->blksz / 4;
>>> +
>>> +     /* Sanity check: all the SG entries must be aligned by block size. */
>>> +     for (i = 0; i < data->sg_len; i++) {
>>> +             if ((data->sg + i)->length % data->blksz)
>>> +                     return -EINVAL;
>>> +     }
>>> +
>>> +     chan = sdhci_external_dma_channel(host, data);
>>> +
>>> +     ret = dmaengine_slave_config(chan, &cfg);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     sg_cnt = sdhci_pre_dma_transfer(host, data, COOKIE_MAPPED);
>>> +     if (sg_cnt <= 0)
>>> +             return -EINVAL;
>>> +
>>> +     desc = dmaengine_prep_slave_sg(chan, data->sg, data->sg_len,
>>> +                                    mmc_get_dma_dir(data),
>>> +                                    DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>>> +     if (!desc)
>>> +             return -EINVAL;
>>> +
>>> +     desc->callback = NULL;
>>> +     desc->callback_param = NULL;
>>> +
>>> +     cookie = dmaengine_submit(desc);
>>> +     if (cookie < 0)
>>> +             ret = cookie;
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static void sdhci_external_dma_release(struct sdhci_host *host)
>>> +{
>>> +     if (host->tx_chan) {
>>> +             dma_release_channel(host->tx_chan);
>>> +             host->tx_chan = NULL;
>>> +     }
>>> +
>>> +     if (host->rx_chan) {
>>> +             dma_release_channel(host->rx_chan);
>>> +             host->rx_chan = NULL;
>>> +     }
>>> +
>>> +     sdhci_switch_external_dma(host, false);
>>> +}
>>> +
>>> +static int __sdhci_external_dma_prepare_data(struct sdhci_host *host,
>>> +                                          struct mmc_command *cmd)
>>> +{
>>> +     struct mmc_data *data = cmd->data;
>>> +
>>> +     host->data_timeout = 0;
>>> +
>>> +     if (sdhci_data_line_cmd(cmd))
>>> +             sdhci_set_timeout(host, cmd);
>>> +
>>> +     WARN_ON(host->data);
>>> +
>>> +     /* Sanity checks */
>>> +     WARN_ON(data->blksz * data->blocks > 524288);
>>> +     WARN_ON(data->blksz > host->mmc->max_blk_size);
>>> +     WARN_ON(data->blocks > 65535);
>>> +
>>> +     host->flags |= SDHCI_REQ_USE_DMA;
>>> +     host->data = data;
>>> +     host->data_early = 0;
>>> +     host->data->bytes_xfered = 0;
>>> +
>>> +     sdhci_set_transfer_irqs(host);
>>> +
>>> +     /*
>>> +      * For Version 4.10 onwards, if v4 mode is enabled, 32-bit Block Count
>>> +      * can be supported, in that case 16-bit block count register must be 0.
>>> +      */
>>> +     if (host->version >= SDHCI_SPEC_410 && host->v4_mode &&
>>> +         (host->quirks2 & SDHCI_QUIRK2_USE_32BIT_BLK_CNT)) {
>>> +             if (sdhci_readw(host, SDHCI_BLOCK_COUNT))
>>> +                     sdhci_writew(host, 0, SDHCI_BLOCK_COUNT);
>>> +             sdhci_writew(host, data->blocks, SDHCI_32BIT_BLK_CNT);
>>> +     } else {
>>> +             sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
>>> +     }
>>
>> It is probably worth factoring out the code that is shared with
>> sdhci_prepare_data() where possible.
>>
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static void sdhci_external_dma_prepare_data(struct sdhci_host *host,
>>> +                                         struct mmc_command *cmd)
>>> +{
>>> +     struct mmc_data *data = cmd->data;
>>> +
>>> +     if (!data)
>>> +             return;
>>
>> Even in the !data case, we still need to set up a timeout for commands with
>> busy waiting.  I suggest checking the !data case before calling
>> sdhci_external_dma_prepare_data()
> 
> Ok.
> 
>>
>>> +
>>> +     if (sdhci_external_dma_setup(host, cmd) ||
>>> +         __sdhci_external_dma_prepare_data(host, cmd)) {
>>> +             sdhci_external_dma_release(host);
>>> +             pr_err("%s: Cannot use external DMA, switch to the DMA/PIO which standard SDHCI provides.\n",
>>> +                    mmc_hostname(host->mmc));
>>> +             sdhci_prepare_data(host, cmd);
>>> +     }
>>> +}
>>> +
>>> +static void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
>>> +                                         struct mmc_command *cmd)
>>> +{
>>> +     struct dma_chan *chan;
>>> +
>>> +     if (!cmd->data || cmd->opcode == MMC_SET_BLOCK_COUNT)
>>
>> MMC_SET_BLOCK_COUNT never has cmd->data and so does not need to be checked.
> 
> Ok.
> 
>>
>>> +             return;
>>> +
>>> +     sdhci_writew(host, cmd->data->blksz, SDHCI_BLOCK_SIZE);
>>
>> Block size is set in __sdhci_external_dma_prepare_data() so does it need to
>> be set here also.
> 
> Ok.

That is BLOCK_COUNT. This is BLOCK_SIZE.

> 
>>
>>> +     chan = sdhci_external_dma_channel(host, cmd->data);
>>> +     if (chan)
>>> +             dma_async_issue_pending(chan);
>>> +}
>>> +
>>> +static int sdhci_external_dma_cleanup(struct sdhci_host *host,
>>> +                                 struct mmc_data *data)
>>
>> Please align parameters with open parenthesis
>>
>>> +{
>>> +     struct dma_chan *chan = sdhci_external_dma_channel(host, data);
>>> +     int ret = 0;
>>> +
>>> +     if (chan)
>>> +             ret = dmaengine_terminate_async(chan);
>>> +
>>> +     return ret;
>>> +}
>>> +#else
>>> +static int sdhci_external_dma_init(struct sdhci_host *host)
>>> +{
>>> +     return -EOPNOTSUPP;
>>> +}
>>> +
>>> +static void sdhci_external_dma_release(struct sdhci_host *host)
>>> +{}
>>> +
>>> +static void sdhci_external_dma_prepare_data(struct sdhci_host *host,
>>> +                                         struct mmc_command *cmd)
>>> +{
>>> +     /* If MMC_SDHCI_EXTERNAL_DMA not supported, PIO will be used */
>>> +     sdhci_prepare_data(host, cmd);
>>> +}
>>> +
>>> +static void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
>>> +                                         struct mmc_command *cmd)
>>> +{}
>>> +
>>> +static int sdhci_external_dma_cleanup(struct sdhci_host *host,
>>> +                                 struct mmc_data *data)
>>
>> Please align parameters with open parenthesis
>>
>>> +{
>>> +     return 0;
>>> +}
>>> +#endif
>>> +
>>> +void sdhci_switch_external_dma(struct sdhci_host *host, bool en)
>>> +{
>>> +     host->use_external_dma = en;
>>> +}
>>> +EXPORT_SYMBOL_GPL(sdhci_switch_external_dma);
>>> +
>>>  static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
>>>                                   struct mmc_request *mrq)
>>>  {
>>> @@ -1374,7 +1595,10 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>>>               host->data_cmd = cmd;
>>>       }
>>>
>>> -     sdhci_prepare_data(host, cmd);
>>> +     if (host->use_external_dma)
>>
>> As mentioned above wrt sdhci_external_dma_prepare_data():
>>
>>         if (host->use_external_dma && cmd->data)
>>
> 
> Maybe we should move checking the !data case out of both
> _prepare_data, and add it to sdhci_send_command() before calling
> _prepare_data(), that's saying we can do set up a timeout in
> sdhci_send_command().

Lets just factor out everything in common as Adrian said. The !data,
BLOCK_COUNT writes and busy waiting.

> 
>>> +             sdhci_external_dma_prepare_data(host, cmd);
>>> +     else
>>> +             sdhci_prepare_data(host, cmd);
>>>
>>>       sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
>>>
>>> @@ -1416,6 +1640,9 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>>>               timeout += 10 * HZ;
>>>       sdhci_mod_timer(host, cmd->mrq, timeout);
>>>
>>> +     if (host->use_external_dma)
>>> +             sdhci_external_dma_pre_transfer(host, cmd);
>>
>> Why is sdhci_external_dma_pre_transfer() needed here - couldn't it be done
>> in sdhci_external_dma_prepare_data()?
>>
> 
> I'm not sure dma_async_issue_pending() can be done so early in
> sdhci_external_dma_prepare_data().
> 
>>> +
>>>       sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
>>>  }
>>>  EXPORT_SYMBOL_GPL(sdhci_send_command);
>>> @@ -1781,6 +2008,11 @@ void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>>
>>>       sdhci_led_activate(host);
>>>
>>> +     if (host->use_external_dma && mrq->data) {
>>> +             struct dma_chan *chan = sdhci_external_dma_channel(host,
>>> +                                                                mrq->data);
>>
>> sdhci_external_dma_channel is not declared if
>> !IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
> 
> Ok, I guess this can be moved to sdhci_external_dma_prepare_data().

No. We have to synchronize from a guaranteed non-atomic context. Maybe
add another empty sdhci_external_dma_channel definition in the #else part?

> 
>>
>>> +             dmaengine_synchronize(chan);
>>
>> So this is to cover for using dmaengine_terminate_async()?

Yes.

> 
> Ok.
> 
>>
>>> +     }
>>>       /*
>>>        * Ensure we don't send the STOP for non-SET_BLOCK_COUNTED
>>>        * requests if Auto-CMD12 is enabled.
>>> @@ -2658,6 +2890,8 @@ static bool sdhci_request_done(struct sdhci_host *host)
>>>                               dma_unmap_sg(mmc_dev(host->mmc), data->sg,
>>>                                            data->sg_len,
>>>                                            mmc_get_dma_dir(data));
>>> +                             if (host->use_external_dma)
>>> +                                     sdhci_external_dma_cleanup(host, data);
>>
>> Is sdhci_external_dma_cleanup() only needed in the error case?
>>
>> The DMA must be stopped before the memory is unmapped and potentially freed.
>>
>> Isn't the DMA cleanup also needed in the bounce buffer case?
>>
>> Isn't the DMA cleanup also needed in the COOKIE_PRE_MAPPED case?
>>
>> dmaengine_terminate_async() doesn't stop the DMA but
>> dmaengine_terminate_sync() is not atomic, which looks like a problem.
>>
>> Perhaps you look at scheduling some work for the external dma error case
>> instead of calling __sdhci_finish_mrq()?  Then the work can do the
>> dmaengine_terminate_sync() and call __sdhci_finish_mrq().
> 
> Ok, I will look at these issues.
> 
>>
>>>                       }
>>>                       data->host_cookie = COOKIE_UNMAPPED;
>>>               }
>>> @@ -3692,12 +3926,15 @@ int sdhci_setup_host(struct sdhci_host *host)
>>>                      mmc_hostname(mmc), host->version);
>>>       }
>>>
>>> -     if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
>>> +     if (host->quirks & SDHCI_QUIRK_FORCE_DMA) {
>>>               host->flags |= SDHCI_USE_SDMA;
>>> -     else if (!(host->caps & SDHCI_CAN_DO_SDMA))
>>> +     } else if (!(host->caps & SDHCI_CAN_DO_SDMA)) {
>>>               DBG("Controller doesn't have SDMA capability\n");
>>> -     else
>>> +     } else if (host->use_external_dma) {
>>> +             /* Using dma-names to detect external dma capability */
>>> +     } else {
>>>               host->flags |= SDHCI_USE_SDMA;
>>> +     }
>>
>> These if-statements are about setting SDHCI_USE_SDMA but why is a change
>> needed for the host->use_external_dma case?
> 
> Yes, this is not needed, otherwise the controller cannot switch back
> to SDMA if it is supported in the controller.

The else case means that the host always uses SDMA. Needed to make sure
this doesn't happen in the external_dma case. Its not SDHCI_CAN_DO_SDMA,
its SDHCI_USE_SDMA.

> 
>>
>>>
>>>       if ((host->quirks & SDHCI_QUIRK_BROKEN_DMA) &&
>>>               (host->flags & SDHCI_USE_SDMA)) {
>>> @@ -3785,6 +4022,19 @@ int sdhci_setup_host(struct sdhci_host *host)
>>>               }
>>>       }
>>>
>>> +     if (host->use_external_dma) {
>>> +             ret = sdhci_external_dma_init(host);
>>> +             if (ret == -EPROBE_DEFER)
>>> +                     goto unreg;
>>> +
>>> +             /*
>>> +              * Fall back to use the DMA/PIO integrated in standard SDHCI
>>> +              * instead of external DMA devices.
>>> +              */
>>> +             if (ret)
>>> +                     sdhci_switch_external_dma(host, false);
>>> +     }
>>> +
>>>       /*
>>>        * If we use DMA, then it's up to the caller to set the DMA
>>>        * mask, but PIO does not need the hw shim so we set a new
>>> @@ -4201,6 +4451,10 @@ void sdhci_cleanup_host(struct sdhci_host *host)
>>>               dma_free_coherent(mmc_dev(mmc), host->align_buffer_sz +
>>>                                 host->adma_table_sz, host->align_buffer,
>>>                                 host->align_addr);
>>> +
>>> +     if (host->use_external_dma)
>>> +             sdhci_external_dma_release(host);
>>> +
>>>       host->adma_table = NULL;
>>>       host->align_buffer = NULL;
>>>  }
>>> @@ -4247,6 +4501,7 @@ int __sdhci_add_host(struct sdhci_host *host)
>>>
>>>       pr_info("%s: SDHCI controller on %s [%s] using %s\n",
>>>               mmc_hostname(mmc), host->hw_name, dev_name(mmc_dev(mmc)),
>>> +             host->use_external_dma ? "External DMA" :
>>>               (host->flags & SDHCI_USE_ADMA) ?
>>>               (host->flags & SDHCI_USE_64_BIT_DMA) ? "ADMA 64-bit" : "ADMA" :
>>>               (host->flags & SDHCI_USE_SDMA) ? "DMA" : "PIO");
>>> @@ -4335,6 +4590,9 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
>>>                                 host->adma_table_sz, host->align_buffer,
>>>                                 host->align_addr);
>>>
>>> +     if (host->use_external_dma)
>>> +             sdhci_external_dma_release(host);
>>> +
>>>       host->adma_table = NULL;
>>>       host->align_buffer = NULL;
>>>  }
>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>> index 6cc9a3c2ac66..7a52823ebef4 100644
>>> --- a/drivers/mmc/host/sdhci.h
>>> +++ b/drivers/mmc/host/sdhci.h
>>> @@ -482,6 +482,7 @@ struct sdhci_host {
>>>
>>>       int irq;                /* Device IRQ */
>>>       void __iomem *ioaddr;   /* Mapped address */
>>> +     phys_addr_t mapbase;    /* physical address base */
>>>       char *bounce_buffer;    /* For packing SDMA reads/writes */
>>>       dma_addr_t bounce_addr;
>>>       unsigned int bounce_buffer_size;
>>> @@ -531,6 +532,7 @@ struct sdhci_host {
>>>       bool pending_reset;     /* Cmd/data reset is pending */
>>>       bool irq_wake_enabled;  /* IRQ wakeup is enabled */
>>>       bool v4_mode;           /* Host Version 4 Enable */
>>> +     bool use_external_dma; /* Host selects to use external DMA */
>>
>> Please align /**/ with above i.e. use tab

Will fix.

Thanks,
Faiz
