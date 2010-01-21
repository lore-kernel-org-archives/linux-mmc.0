From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH] OMAP35xx:SDIO IRQ Support for OMAP35xx
Date: Thu, 21 Jan 2010 08:36:56 +0200
Message-ID: <4B57F608.1030508@compulab.co.il>
References: <1261400646-7641-1-git-send-email-phani@embwise.com> <4B2FA66C.7010902@compulab.co.il> <4B573F04.8080604@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:54289 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754957Ab0AUGha (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Jan 2010 01:37:30 -0500
In-Reply-To: <4B573F04.8080604@googlemail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: Phaneendra Kumar Alapati <phani@embwise.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Madhusudhan Chikkature <madhu.cr@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@nokia.com>, "Paasikivi Teemu.3 (EXT-Ixonos/Tampere)" <ext-teemu.3.paasikivi@nokia.com>

Hi Dirk,

Dirk Behme wrote:
> On 21.12.2009 17:46, Mike Rapoport wrote:
>> Hi,
>>
>> Phaneendra Kumar Alapati wrote:
>>> This patch adds SDIO IRQ support for OMAP35xx. Tested on OMAP3530EVM
>>> with Marvell 88W8686 card and below are the observed throughput results
>>> (ttcp utility): 13Mbps (Downlink), 10.5 Mbps(Uplink)
>>>
>>> Signed-off-by: Phaneendra Kumar<phani@embwise.com>
>>> ---
>>>   drivers/mmc/host/omap_hsmmc.c |   55
>>> ++++++++++++++++++++++++++++++++++++----
>>>   1 files changed, 49 insertions(+), 6 deletions(-)
>>
>> I've tried the patch on CM-T35 that has Marvell 88W8686 on-board and
>> surprisingly I get a lot of command timeouts from the libertas driver :(
>> ---
>> libertas: requeueing command 0x0006 due to timeout (#1)
>> libertas: Received result 0 to command 6 after 1 retries
>> libertas: command 0x0006 timed out
>> ---
>> I hope I'll find time to debug it in the next few days and provide
>> more valuable
>> information...
> 
> There is a test report from Overo air that there it doesn't work, too:
> 
> http://old.nabble.com/Re%3A-Overo-wifi-speed-and-WPA2-connection-issue-p27231874.html
> 
> 
> Any news on this patch?

Unfortunately I haven't got time to see why libertas is unhappy with
this patch.. :(

> Best regards
> 
> Dirk
> 
>>> diff --git a/drivers/mmc/host/omap_hsmmc.c
>>> b/drivers/mmc/host/omap_hsmmc.c
>>> index 4b23225..fa94580 100644
>>> --- a/drivers/mmc/host/omap_hsmmc.c
>>> +++ b/drivers/mmc/host/omap_hsmmc.c
>>> @@ -100,6 +100,10 @@
>>>   #define SRD            (1<<  26)
>>>   #define SOFTRESET        (1<<  1)
>>>   #define RESETDONE        (1<<  0)
>>> +#define CIRQ        (1<<  8)
>>> +#define CIRQ_ENABLE    (1<<  8)
>>> +#define CTPL        (1<<  11)
>>> +#define CLKEXTFREE    (1<<  16)
>>>
>>>   /*
>>>    * FIXME: Most likely all the data using these _DEVID defines
>>> should come
>>> @@ -171,6 +175,7 @@ struct omap_hsmmc_host {
>>>       int            vdd;
>>>       int            protect_card;
>>>       int            reqs_blocked;
>>> +    int            sdio_int;
>>>
>>>       struct    omap_mmc_platform_data    *pdata;
>>>   };
>>> @@ -436,6 +441,13 @@ omap_hsmmc_start_command(struct omap_hsmmc_host
>>> *host, struct mmc_command *cmd,
>>>       else
>>>           OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
>>>
>>> +    if (host->sdio_int) {
>>> +        OMAP_HSMMC_WRITE(host->base, ISE,
>>> +            (OMAP_HSMMC_READ(host->base, ISE) | CIRQ_ENABLE));
>>> +        OMAP_HSMMC_WRITE(host->base, IE,
>>> +            (OMAP_HSMMC_READ(host->base, IE) | CIRQ_ENABLE));
>>> +    }
>>> +
>>>       host->response_busy = 0;
>>>       if (cmd->flags&  MMC_RSP_PRESENT) {
>>>           if (cmd->flags&  MMC_RSP_136)
>>> @@ -640,6 +652,17 @@ static irqreturn_t omap_hsmmc_irq(int irq, void
>>> *dev_id)
>>>
>>>       spin_lock(&host->irq_lock);
>>>
>>> +    data = host->data;
>>> +    status = OMAP_HSMMC_READ(host->base, STAT);
>>> +    dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
>>> +
>>> +    if (host->mmc->caps&  MMC_CAP_SDIO_IRQ) {
>>> +        if (status&  CIRQ) {
>>> +            dev_dbg(mmc_dev(host->mmc), "SDIO Card Interrupt\n");
>>> +            mmc_signal_sdio_irq(host->mmc);
>>> +        }
>>> +    }
>>> +
>>>       if (host->mrq == NULL) {
>>>           OMAP_HSMMC_WRITE(host->base, STAT,
>>>               OMAP_HSMMC_READ(host->base, STAT));
>>> @@ -649,10 +672,6 @@ static irqreturn_t omap_hsmmc_irq(int irq, void
>>> *dev_id)
>>>           return IRQ_HANDLED;
>>>       }
>>>
>>> -    data = host->data;
>>> -    status = OMAP_HSMMC_READ(host->base, STAT);
>>> -    dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
>>> -
>>>       if (status&  ERR) {
>>>   #ifdef CONFIG_MMC_DEBUG
>>>           omap_hsmmc_report_irq(host, status);
>>> @@ -1254,6 +1273,25 @@ static int omap_hsmmc_get_ro(struct mmc_host
>>> *mmc)
>>>       return mmc_slot(host).get_ro(host->dev, 0);
>>>   }
>>>
>>> +static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int
>>> enable)
>>> +{
>>> +    struct omap_hsmmc_host *host = mmc_priv(mmc);
>>> +
>>> +    host->sdio_int = enable;
>>> +    if (enable) {
>>> +        OMAP_HSMMC_WRITE(host->base, ISE,
>>> +            (OMAP_HSMMC_READ(host->base, ISE) | CIRQ_ENABLE));
>>> +        OMAP_HSMMC_WRITE(host->base, IE,
>>> +            (OMAP_HSMMC_READ(host->base, IE) | CIRQ_ENABLE));
>>> +    } else {
>>> +        OMAP_HSMMC_WRITE(host->base, IE,
>>> +            (OMAP_HSMMC_READ(host->base, IE)&  (~CIRQ_ENABLE)));
>>> +        OMAP_HSMMC_WRITE(host->base, ISE,
>>> +            (OMAP_HSMMC_READ(host->base, ISE)&  (~CIRQ_ENABLE)));
>>> +    }
>>> +
>>> +}
>>> +
>>>   static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
>>>   {
>>>       u32 hctl, capa, value;
>>> @@ -1519,7 +1557,7 @@ static const struct mmc_host_ops omap_hsmmc_ops
>>> = {
>>>       .set_ios = omap_hsmmc_set_ios,
>>>       .get_cd = omap_hsmmc_get_cd,
>>>       .get_ro = omap_hsmmc_get_ro,
>>> -    /* NYET -- enable_sdio_irq */
>>> +    .enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
>>>   };
>>>
>>>   static const struct mmc_host_ops omap_hsmmc_ps_ops = {
>>> @@ -1529,7 +1567,7 @@ static const struct mmc_host_ops
>>> omap_hsmmc_ps_ops = {
>>>       .set_ios = omap_hsmmc_set_ios,
>>>       .get_cd = omap_hsmmc_get_cd,
>>>       .get_ro = omap_hsmmc_get_ro,
>>> -    /* NYET -- enable_sdio_irq */
>>> +    .enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
>>>   };
>>>
>>>   #ifdef CONFIG_DEBUG_FS
>>> @@ -1657,6 +1695,7 @@ static int __init omap_hsmmc_probe(struct
>>> platform_device *pdev)
>>>       host->mapbase    = res->start;
>>>       host->base    = ioremap(host->mapbase, SZ_4K);
>>>       host->power_mode = -1;
>>> +    host->sdio_int = 0;
>>>
>>>       platform_set_drvdata(pdev, host);
>>>       INIT_WORK(&host->mmc_carddetect_work, omap_hsmmc_detect);
>>> @@ -1744,6 +1783,10 @@ static int __init omap_hsmmc_probe(struct
>>> platform_device *pdev)
>>>       if (mmc_slot(host).nonremovable)
>>>           mmc->caps |= MMC_CAP_NONREMOVABLE;
>>>
>>> +    mmc->caps |= MMC_CAP_SDIO_IRQ;
>>> +    OMAP_HSMMC_WRITE(host->base, CON,
>>> +            OMAP_HSMMC_READ(host->base, CON) | (CTPL | CLKEXTFREE));
>>> +
>>>       omap_hsmmc_conf_bus_power(host);
>>>
>>>       /* Select DMA lines */
>>
> 


-- 
Sincerely yours,
Mike.
