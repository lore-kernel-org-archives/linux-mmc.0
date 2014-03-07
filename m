From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v4 1/7] mmc: dw_mmc: use the mmc_of_parse() instead of
 local parser
Date: Fri, 07 Mar 2014 11:30:35 +0900
Message-ID: <53192F4B.3090505@samsung.com>
References: <5313EAB9.7010001@gmail.com>
 <CAPDyKFrk7JUgK4hpa3H9sg=DWNyhUd7Kt153ZOYEFL8=kqjmiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:9074 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbaCGCaM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Mar 2014 21:30:12 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N2100DH9OAA75D0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 07 Mar 2014 11:30:10 +0900 (KST)
In-reply-to: <CAPDyKFrk7JUgK4hpa3H9sg=DWNyhUd7Kt153ZOYEFL8=kqjmiw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>

On 03/06/2014 04:18 PM, Ulf Hansson wrote:
> On 3 March 2014 03:36, Jaehoon Chung <jh80.chung@gmail.com> wrote:
>> mmc_of_parse() have been already parsed the general capability.
>> Didn't need to use the local parser.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>> Changelog V4:
>>         - None
>> Changelog V3:
>>         - Remove the caps2-mmc-hs-1_8v/1_2v into synopsys-dw-mshc.txt
>> Changelog V2:
>>         - None
>>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |    5 --
>>  drivers/mmc/host/dw_mmc.c                          |   49 +-------------------
>>  2 files changed, 1 insertion(+), 53 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> index 8f3f133..2d4a725 100644
>> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> @@ -69,10 +69,6 @@ Optional properties:
>>
>>  * supports-highspeed: Enables support for high speed cards (up to 50MHz)
>>
>> -* caps2-mmc-hs200-1_8v: Supports mmc HS200 SDR 1.8V mode
>> -
>> -* caps2-mmc-hs200-1_2v: Supports mmc HS200 SDR 1.2V mode
>> -
>>  * broken-cd: as documented in mmc core bindings.
>>
>>  * vmmc-supply: The phandle to the regulator to use for vmmc.  If this is
>> @@ -103,7 +99,6 @@ board specific portions as listed below.
>>                 clock-freq-min-max = <400000 200000000>;
>>                 num-slots = <1>;
>>                 supports-highspeed;
>> -               caps2-mmc-hs200-1_8v;
>>                 broken-cd;
>>                 fifo-depth = <0x80>;
>>                 card-detect-delay = <200>;
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 55cd110..8193e21 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -2046,21 +2046,6 @@ static int dw_mci_of_get_slot_quirks(struct device *dev, u8 slot)
>>         return quirks;
>>  }
>>
>> -/* find out bus-width for a given slot */
>> -static u32 dw_mci_of_get_bus_wd(struct device *dev, u8 slot)
>> -{
>> -       struct device_node *np = dw_mci_of_find_slot_node(dev, slot);
>> -       u32 bus_wd = 1;
>> -
>> -       if (!np)
>> -               return 1;
>> -
>> -       if (of_property_read_u32(np, "bus-width", &bus_wd))
>> -               dev_err(dev, "bus-width property not found, assuming width"
>> -                              " as 1\n");
>> -       return bus_wd;
>> -}
>> -
>>  /* find the write protect gpio for a given slot; or -1 if none specified */
>>  static int dw_mci_of_get_wp_gpio(struct device *dev, u8 slot)
>>  {
>> @@ -2108,10 +2093,6 @@ static int dw_mci_of_get_slot_quirks(struct device *dev, u8 slot)
>>  {
>>         return 0;
>>  }
>> -static u32 dw_mci_of_get_bus_wd(struct device *dev, u8 slot)
>> -{
>> -       return 1;
>> -}
>>  static struct device_node *dw_mci_of_find_slot_node(struct device *dev, u8 slot)
>>  {
>>         return NULL;
>> @@ -2134,7 +2115,6 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>>         const struct dw_mci_drv_data *drv_data = host->drv_data;
>>         int ctrl_id, ret;
>>         u32 freq[2];
>> -       u8 bus_width;
>>
>>         mmc = mmc_alloc_host(sizeof(struct dw_mci_slot), host->dev);
>>         if (!mmc)
>> @@ -2189,19 +2169,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>>         if (host->pdata->caps2)
>>                 mmc->caps2 = host->pdata->caps2;
>>
>> -       if (host->pdata->get_bus_wd)
>> -               bus_width = host->pdata->get_bus_wd(slot->id);
>> -       else if (host->dev->of_node)
>> -               bus_width = dw_mci_of_get_bus_wd(host->dev, slot->id);
>> -       else
>> -               bus_width = 1;
>> -
>> -       switch (bus_width) {
>> -       case 8:
>> -               mmc->caps |= MMC_CAP_8_BIT_DATA;
>> -       case 4:
>> -               mmc->caps |= MMC_CAP_4_BIT_DATA;
>> -       }
>> +       mmc_of_parse(mmc);
>>
>>         if (host->pdata->blk_settings) {
>>                 mmc->max_segs = host->pdata->blk_settings->max_segs;
>> @@ -2399,24 +2367,9 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>>                         return ERR_PTR(ret);
>>         }
>>
>> -       if (of_find_property(np, "keep-power-in-suspend", NULL))
>> -               pdata->pm_caps |= MMC_PM_KEEP_POWER;
>> -
>> -       if (of_find_property(np, "enable-sdio-wakeup", NULL))
>> -               pdata->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
>> -
>>         if (of_find_property(np, "supports-highspeed", NULL))
>>                 pdata->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
> 
> We should convert to the common bindings for highspeed modes as well,
> but that's outside this patch though.
It can be used "caps-sd-highspeed" and "caps-mmc-highspeed" instead of "support-highspeed".
I will send the other patch for this.

Thanks for your acked.

Best Regards,
Jaehoon Chung
> 
>>
>> -       if (of_find_property(np, "caps2-mmc-hs200-1_8v", NULL))
>> -               pdata->caps2 |= MMC_CAP2_HS200_1_8V_SDR;
>> -
>> -       if (of_find_property(np, "caps2-mmc-hs200-1_2v", NULL))
>> -               pdata->caps2 |= MMC_CAP2_HS200_1_2V_SDR;
>> -
>> -       if (of_get_property(np, "cd-inverted", NULL))
>> -               pdata->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
>> -
>>         return pdata;
>>  }
>>
>> --
>> 1.7.9.5
> 
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> 

