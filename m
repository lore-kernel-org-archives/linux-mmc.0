From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V4 10/11] mmc: cqhci: support for command queue enabled
 host
Date: Mon, 31 Jul 2017 10:03:46 +0300
Message-ID: <c55921b3-48ed-e57b-0ac9-737a1c39931d@intel.com>
References: <1500630584-22852-1-git-send-email-adrian.hunter@intel.com>
 <1500630584-22852-11-git-send-email-adrian.hunter@intel.com>
 <AM4PR0401MB2324C6913207B78E8A71C24190BB0@AM4PR0401MB2324.eurprd04.prod.outlook.com>
 <56c06a10-db37-d3e1-e9d6-5bdd214c7efd@intel.com>
 <36c36b83-08ff-df50-41af-d73ea6e57fdb@intel.com>
 <AM4PR0401MB2324CD0F80CECD1E3208B44290B20@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13775 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751740AbdGaHKL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 31 Jul 2017 03:10:11 -0400
In-Reply-To: <AM4PR0401MB2324CD0F80CECD1E3208B44290B20@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bough Chen <haibo.chen@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 31/07/17 10:03, Bough Chen wrote:
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> owner@vger.kernel.org] On Behalf Of Adrian Hunter
>> Sent: Monday, July 31, 2017 2:41 PM
>> To: Bough Chen <haibo.chen@nxp.com>; Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: linux-mmc <linux-mmc@vger.kernel.org>; Alex Lemberg
>> <alex.lemberg@sandisk.com>; Mateusz Nowak <mateusz.nowak@intel.com>;
>> Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>; Jaehoon Chung
>> <jh80.chung@samsung.com>; Dong Aisheng <dongas86@gmail.com>; Das
>> Asutosh <asutoshd@codeaurora.org>; Zhangfei Gao
>> <zhangfei.gao@gmail.com>; Dorfman Konstantin
>> <kdorfman@codeaurora.org>; Sahitya Tummala <stummala@codeaurora.org>;
>> Harjani Ritesh <riteshh@codeaurora.org>; Venu Byravarasu
>> <vbyravarasu@nvidia.com>; Linus Walleij <linus.walleij@linaro.org>; Shawn Lin
>> <shawn.lin@rock-chips.com>
>> Subject: Re: [PATCH V4 10/11] mmc: cqhci: support for command queue
>> enabled host
>>
>> On 24/07/17 13:21, Adrian Hunter wrote:
>>> On 24/07/17 11:52, Bough Chen wrote:
>>>> [...]
>>>>
>>>>> -----Original Message-----
>>>>> From: Adrian Hunter [mailto:adrian.hunter@intel.com]
>>>>> Sent: Friday, July 21, 2017 5:50 PM
>>>>> To: Ulf Hansson <ulf.hansson@linaro.org>
>>>>> Cc: linux-mmc <linux-mmc@vger.kernel.org>; Bough Chen
>>>>> <haibo.chen@nxp.com>; Alex Lemberg <alex.lemberg@sandisk.com>;
>>>>> Mateusz Nowak <mateusz.nowak@intel.com>; Yuliy Izrailov
>>>>> <Yuliy.Izrailov@sandisk.com>; Jaehoon Chung
>>>>> <jh80.chung@samsung.com>; Dong Aisheng <dongas86@gmail.com>; Das
>>>>> Asutosh <asutoshd@codeaurora.org>; Zhangfei Gao
>>>>> <zhangfei.gao@gmail.com>; Dorfman Konstantin
>>>>> <kdorfman@codeaurora.org>; David Griego <david.griego@linaro.org>;
>>>>> Sahitya Tummala <stummala@codeaurora.org>; Harjani Ritesh
>>>>> <riteshh@codeaurora.org>; Venu Byravarasu <vbyravarasu@nvidia.com>;
>>>>> Linus Walleij <linus.walleij@linaro.org>; Shawn Lin
>>>>> <shawn.lin@rock-chips.com>
>>>>> Subject: [PATCH V4 10/11] mmc: cqhci: support for command queue
>>>>> enabled host
>>>>>
>>>>> From: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>>>>>
>>>>> This patch adds CMDQ support for command-queue compatible hosts.
>>>>>
>>>>> Command queue is added in eMMC-5.1 specification. This enables the
>>>>> controller to process upto 32 requests at a time.
>>>>>
>>>>> Adrian Hunter contributed renaming to cqhci, recovery, suspend and
>>>>> resume, cqhci_off, cqhci_wait_for_idle, and external timeout handling.
>>>>>
>>>>> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
>>>>> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
>>>>> Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
>>>>> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>>>>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
>>>>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
>>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>>> ---
>>>>>  drivers/mmc/host/Kconfig  |   13 +
>>>>>  drivers/mmc/host/Makefile |    1 +
>>>>>  drivers/mmc/host/cqhci.c  | 1146
>>>>> +++++++++++++++++++++++++++++++++++++++++++++
>>>>>  drivers/mmc/host/cqhci.h  |  240 ++++++++++
>>>>>  4 files changed, 1400 insertions(+)  create mode 100644
>>>>> drivers/mmc/host/cqhci.c  create mode 100644
>>>>> drivers/mmc/host/cqhci.h
>>>>>
>>>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>>>>> index 2242633550df..3a164a03f2bc 100644
>>>>> --- a/drivers/mmc/host/Kconfig
>>>>> +++ b/drivers/mmc/host/Kconfig
>>>>> @@ -834,6 +834,19 @@ config MMC_SUNXI
>>>>>  	  This selects support for the SD/MMC Host Controller on
>>>>>  	  Allwinner sunxi SoCs.
>>>>>
>>>>> +config MMC_CQHCI
>>>>> +	tristate "Command Queue Host Controller Interface support"
>>>>> +	depends on HAS_DMA
>>>>> +	help
>>>>> +	  This selects the Command Queue Host Controller Interface (CQHCI)
>>>>> +	  support present in host controllers of Qualcomm Technologies, Inc
>>>>> +	  amongst others.
>>>>> +	  This controller supports eMMC devices with command queue support.
>>>>> +
>>>>> +	  If you have a controller with this interface, say Y or M here.
>>>>> +
>>>>> +	  If unsure, say N.
>>>>> +
>>>>>  config MMC_TOSHIBA_PCI
>>>>>  	tristate "Toshiba Type A SD/MMC Card Interface Driver"
>>>>>  	depends on PCI
>>>>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
>>>>> index
>>>>> 8c46766c000c..3ae71e006890 100644
>>>>> --- a/drivers/mmc/host/Makefile
>>>>> +++ b/drivers/mmc/host/Makefile
>>>>> @@ -88,6 +88,7 @@ obj-$(CONFIG_MMC_SDHCI_MSM)		+=
>>>>> sdhci-msm.o
>>>>>  obj-$(CONFIG_MMC_SDHCI_ST)		+= sdhci-st.o
>>>>>  obj-$(CONFIG_MMC_SDHCI_MICROCHIP_PIC32)	+= sdhci-pic32.o
>>>>>  obj-$(CONFIG_MMC_SDHCI_BRCMSTB)		+= sdhci-brcmstb.o
>>>>> +obj-$(CONFIG_MMC_CQHCI)			+= cqhci.o
>>>>>
>>>>>  ifeq ($(CONFIG_CB710_DEBUG),y)
>>>>>  	CFLAGS-cb710-mmc	+= -DDEBUG
>>>>> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c new
>>>>> file mode 100644 index 000000000000..302421a26230
>>>>> --- /dev/null
>>>>> +++ b/drivers/mmc/host/cqhci.c
>>>>> @@ -0,0 +1,1146 @@
>>>>
>>>> <SNIP>
>>>>
>>>>> +
>>>>> +static int cqhci_request(struct mmc_host *mmc, struct mmc_request
>>>>> +*mrq) {
>>>>> +	int err = 0;
>>>>> +	u64 data = 0;
>>>>> +	u64 *task_desc = NULL;
>>>>> +	int tag = cqhci_tag(mrq);
>>>>> +	struct cqhci_host *cq_host = mmc->cqe_private;
>>>>> +	unsigned long flags;
>>>>> +
>>>>> +	if (!cq_host->enabled) {
>>>>> +		pr_err("%s: cqhci: not enabled\n", mmc_hostname(mmc));
>>>>> +		return -EINVAL;
>>>>> +	}
>>>>> +
>>>>> +	/* First request after resume has to re-enable */
>>>>> +	if (!cq_host->activated)
>>>>> +		__cqhci_enable(cq_host);
>>>>> +
>>>>> +	if (!mmc->cqe_on) {
>>>>> +		cqhci_writel(cq_host, 0, CQHCI_CTL);
>>>>> +		mmc->cqe_on = true;
>>>>> +		pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
>>>>> +		if (cqhci_readl(cq_host, CQHCI_CTL) && CQHCI_HALT) {
>>>>> +			pr_err("%s: cqhci: CQE failed to exit halt state\n",
>>>>> +			       mmc_hostname(mmc));
>>>>> +		}
>>>>> +		if (cq_host->ops->enable)
>>>>> +			cq_host->ops->enable(mmc);
>>>>> +	}
>>>>> +
>>>>> +	if (mrq->data) {
>>>>> +		task_desc = (__le64 __force *)get_desc(cq_host, tag);
>>>>> +		cqhci_prep_task_desc(mrq, &data, 1);
>>>>> +		*task_desc = cpu_to_le64(data);
>>>>> +		err = cqhci_prep_tran_desc(mrq, cq_host, tag);
>>>>> +		if (err) {
>>>>> +			pr_err("%s: cqhci: failed to setup tx desc: %d\n",
>>>>> +			       mmc_hostname(mmc), err);
>>>>> +			return err;
>>>>> +		}
>>>>> +	} else {
>>>>> +		cqhci_prep_dcmd_desc(mmc, mrq);
>>>>> +	}
>>>>> +
>>>> Hi Adrian,
>>>>
>>>> For cqhci data request, I think we need to also config
>> SDHCI_TRNS_BLK_CNT_EN and SDHCI_TRNS_DMA,  just like function
>> sdhci_set_transfer_mode(): set SDHCI_TRNS_BLK_CNT_EN and
>> SDHCI_TRNS_DMA in every request.
>>>>
>>>> Currently, we do not do this for cqhci request, if support Runtime
>>>> PM, when runtime resume,
>>>> sdhci_runtime_resume_host() --> sdhci_init(host, 0) -->
>>>> sdhci_do_reset(host, SDHCI_RESET_ALL)
>>>> sdhci_reset() will do software reset for all, this will clear some SDHCI register,
>> including SDHCI_TRNS_BLK_CNT_EN and SDHCI_TRNS_DMA, then when use
>> cqhci request, error happens. I meet cqhci wait timeout error on our i.MX8.
>> After set these two bits, this issue gone.
>>>
>>> CQE anyway needs to write the transfer mode bit-4 so it is a bit
>>> strange that it doesn't write the other bits too.  Nevertheless
>>> anything you need to set can be done in the ->enable() callback.  For example
>> see glk_cqe_enable().
>>>
>>
>> How is it going?
> 
> Yes, the ->enable() callback is a good place to set the i.mx special config, now CMDQ can works well
> On our i.MX8.

So your tested-by still applies, also to V4?
