From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH v2 1/3] mmc: support sdhci-mmp2
Date: Sun, 29 May 2011 23:10:28 -0700
Message-ID: <8F4CBB18-D8BC-4637-9B32-BC7C7AD198A7@marvell.com>
References: <1306315367-15602-1-git-send-email-zhangfei.gao@marvell.com>
 <201105271746.04775.arnd@arndb.de>
 <BANLkTi=S=Q+AdKECCHg2u6X=VWEOtEox_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:39025 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751737Ab1E3GKt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 30 May 2011 02:10:49 -0400
In-Reply-To: <BANLkTi=S=Q+AdKECCHg2u6X=VWEOtEox_w@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Zhangfei Gao <zgao6@marvell.com>, Nicolas Pitre <nico@fluxnic.net>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Qiming Wu <wuqm@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>


On May 29, 2011, at 10:42 PM, zhangfei gao wrote:

> On Fri, May 27, 2011 at 11:46 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wednesday 25 May 2011, Zhangfei Gao wrote:
>>>       Instead of sharing sdhci-pxa.c, use sdhci-mmp2.c specificlly for mmp2.
>>>       sdhci-pxa.c is used to share among pxa serious, like pxa910, mmp2, etc.
>>>       The platfrom difference are put under arch/arm, while is not easy to track.
>>> 
>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>>> ---
>>>  arch/arm/plat-pxa/include/plat/sdhci.h |   43 ++++-
>>>  drivers/mmc/host/Kconfig               |   11 +-
>>>  drivers/mmc/host/Makefile              |    2 +-
>>>  drivers/mmc/host/sdhci-mmp2.c          |  303 ++++++++++++++++++++++++++++++++
>>>  drivers/mmc/host/sdhci-pxa.c           |  303 --------------------------------
>>>  5 files changed, 349 insertions(+), 313 deletions(-)
>>>  create mode 100644 drivers/mmc/host/sdhci-mmp2.c
>>>  delete mode 100644 drivers/mmc/host/sdhci-pxa.c
>> 
>> Yes, looks good for the most part. I was rather confused by the fact that the old
>> and new file are both 303 lines, so I assumed they would be identical, when they
>> are really completely different.
>> 
>> There is a little room for simplification, I think:
>> 
>>> +static unsigned int mmp2_get_ro(struct sdhci_host *host)
>>> +{
>>> +     /* Micro SD does not support write-protect feature */
>>> +     return 0;
>>> +}
>> 
>> You shouldn't need to provide an empty get_ro function, the
>> default is that there is no write-protect.
> 
> Thanks Arnd for review.
> The reason to put get_ro here is some board use micro sd, while some
> board design is general sd card.
> The micro sd do not use write-protect, while SDHCI_WRITE_PROTECT will
> return 1 in our controller, so it shows read only.
> So add one call back for the board with micro sd card via flag.
> 
>> 
>>> +static void mmp2_set_clock(struct sdhci_host *host, unsigned int clock)
>>> +{
>>> +     struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>> +     struct sdhci_pxa *pxa = pltfm_host->priv;
>>> +
>>> +     if (clock)
>>> +             mmp2_soc_set_timing(host, pxa->pdata);
>>> +}
>> 
>> The mmp2_soc_set_timing() function is only called here, so you can easily
>> merge the two into one, starting with
>> 
>>        if (!clock)
>>                return;
> OK, thanks,
>> 
>>> +static int __devinit sdhci_mmp2_probe(struct platform_device *pdev)
>>> +{
>>> +     struct sdhci_pltfm_host *pltfm_host;
>>> +     struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
>>> +     struct device *dev = &pdev->dev;
>>> +     struct sdhci_host *host = NULL;
>>> +     struct sdhci_pxa *pxa = NULL;
>>> +     int ret;
>>> +     struct clk *clk;
>> 
>> The probe and release functions for mmp2 and pxa910 are almost identical.
>> I'd suggest you leave them in sdhci-pxa.c as a library, and export them
>> using EXPORT_SYMBOL_GPL. Then you can call them from the respective
>> probe functions, e.g.
>> 
>> static struct sdhci_mmp2_ops = {
>>        .set_clock = mmp2_set_clock,
>>        .set_uhs_signaling = mmp2_set_uhs_signaling,
>>        .get_ro = mmp2_get_ro,
>> };
>> static int __devinit sdhci_mmp2_probe(struct platform_device *pdev)
>> {
>>         unsigned int quirks = SDHCI_QUIRK_BROKEN_ADMA
>>                | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
>>                | SDHCI_QUIRK_32BIT_DMA_ADDR
>>                | SDHCI_QUIRK_32BIT_DMA_SIZE
>>                | SDHCI_QUIRK_32BIT_ADMA_SIZE
>>                | SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
>> 
>>        return sdhci_pxa_probe(pdev, quirks, sdhci_mmp2_ops);
>> }
>> 
>>> +     pxa = kzalloc(sizeof(struct sdhci_pxa), GFP_KERNEL);
>>> +     if (!pxa) {
>>> +             ret = -ENOMEM;
>>> +             goto out;
>>> +     }
>>> +     pxa->ops = kzalloc(sizeof(struct sdhci_ops), GFP_KERNEL);
>>> +     if (!pxa->ops) {
>>> +             ret = -ENOMEM;
>>> +             goto out;
>>> +     }
>> 
>> I think you really shouldn't allocate the sdhci_ops dynamically.
>> In fact, it would be much better if we were able to mark them
>> as const in all drivers.
> 
> We found some issues when supporting multi-slot, each slot may have
> different ops.
> So use the method of allocating the sdhci_ops dynamically instead of
> using static ops.
> For example, emmc has 74_clocks call back, while mmc and sdio slot
> does not have such ops.
> If not dynamically allocate sdhci_ops, all slot ops may become same,
> and 74_clocks may be called for every slot.
> Also, some board may have get_ro, while other board may not, so
> transfer the ops via flags.

74 clock code causes no harm for SD/eMMC/SDIO.  You can
save 74 clocks if that really is important for SDIO.  I do not know what
a SD slot is.  You cannot make any assumptions about what card 
the user will put into a slot.

> 
> Not sure whether it is worthy to add additional common files to share
> probe and remove function.
> Also the init the ops part are different.
> 
>> 
>>> +
>>> +#ifdef CONFIG_PM
>>> +static int sdhci_mmp2_suspend(struct platform_device *dev, pm_message_t state)
>>> +{
>>> +     struct sdhci_host *host = platform_get_drvdata(dev);
>>> +
>>> +     return sdhci_suspend_host(host, state);
>>> +}
>>> +
>>> +static int sdhci_mmp2_resume(struct platform_device *dev)
>>> +{
>>> +     struct sdhci_host *host = platform_get_drvdata(dev);
>>> +
>>> +     return sdhci_resume_host(host);
>>> +}
>>> +#else
>>> +#define sdhci_mmp2_suspend   NULL
>>> +#define sdhci_mmp2_resume    NULL
>>> +#endif
>> 
>> Similarly, I think it would be good if sdhci-pltfm.c would simply
>> export these functions so you could refer to them in your driver.
>> There is no need to have identical copies in each variant.
>> 
> 
> There are some additional code for suspend and resume, so
> sdhci_pltfm_suspend may not enough.
> For example, when enable wifi host sleep feature, additional register
> have to be configured.
> 
>>        Arnd
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 

