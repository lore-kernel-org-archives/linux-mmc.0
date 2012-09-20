From: Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 6/9] mmc: dw_mmc: add device tree support
Date: Thu, 20 Sep 2012 10:06:53 +0530
Message-ID: <CAJuYYwQOCLPsVjGYQFTnTaqDeWnaDONGMHPEF5TB3htYc5SsJA@mail.gmail.com>
References: <1347905803-22742-1-git-send-email-thomas.abraham@linaro.org>
 <1347905803-22742-7-git-send-email-thomas.abraham@linaro.org>
 <001301cd966c$3f99f0a0$becdd1e0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <001301cd966c$3f99f0a0$becdd1e0$%jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, will.newton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, girish.shivananjappa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 19 September 2012 19:09, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> On Tuesday, September 18, 2012, Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> +#ifdef CONFIG_OF
>> +/* given a slot id, find out the device node representing that slot */
>> +static struct device_node *dw_mci_of_find_slot_node(struct device *dev, u8 slot)
>> +{
>> +     struct device_node *np;
>> +     const __be32 *addr;
>> +     int len;
>> +
>> +     if (!dev || !dev->of_node)
>> +             return NULL;
>> +
>> +     for_each_child_of_node(dev->of_node, np) {
>> +             addr = of_get_property(np, "reg", &len);
>> +             if (!addr || (len < sizeof(int)))
>> +                     continue;
>> +             if (be32_to_cpup(addr) == slot)
>> +                     return np;
>> +     }
>> +     return NULL;
>> +}
>> +
>> +/* find out bus-width for a given slot */
>> +static u32 dw_mci_of_get_bus_wd(struct device *dev, u8 slot)
>> +{
>> +     struct device_node *np = dw_mci_of_find_slot_node(dev, slot);
>> +     u32 bus_wd = 1;
>> +
>> +     if (!np)
>> +             return 1;
>> +
>> +     if (of_property_read_u32(np, "bus-width", &bus_wd))
>> +             dev_err(dev, "bus-width property not found, assuming width"
>> +                            " as 1\n");
>> +     return bus_wd;
>> +}
>> +#else /* CONFIG_OF */
>> +static u32 dw_mci_of_get_bus_wd(struct device *dev, u8 slot)
>> +{
>> +     return 1;
>> +}
>> +static struct device_node *dw_mci_of_find_slot_node(struct device *dev, u8 slot)
>> +{
>> +     return NULL;
>> +}
>> +#endif /* CONFIG_OF */
>> +
>>  static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>>  {
>>       struct mmc_host *mmc;
>>       struct dw_mci_slot *slot;
>> +     u8 bus_width;
>>
>>       mmc = mmc_alloc_host(sizeof(struct dw_mci_slot), host->dev);
>>       if (!mmc)
>> @@ -1782,6 +1830,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>>       slot->id = id;
>>       slot->mmc = mmc;
>>       slot->host = host;
>> +     host->slot[id] = slot;
>>
>>       mmc->ops = &dw_mci_ops;
>>       mmc->f_min = DIV_ROUND_UP(host->bus_hz, 510);
>> @@ -1806,8 +1855,18 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>>               mmc->caps2 = host->pdata->caps2;
>>
>>       if (host->pdata->get_bus_wd)
>> -             if (host->pdata->get_bus_wd(slot->id) >= 4)
>> -                     mmc->caps |= MMC_CAP_4_BIT_DATA;
>> +             bus_width = host->pdata->get_bus_wd(slot->id);
>> +     else if (host->dev->of_node)
>> +             bus_width = dw_mci_of_get_bus_wd(host->dev, slot->id);
>> +     else
>> +             bus_width = 1;
>> +
>> +     switch (bus_width) {
>> +     case 8:
>> +             mmc->caps |= MMC_CAP_8_BIT_DATA;
>> +     case 4:
>> +             mmc->caps |= MMC_CAP_4_BIT_DATA;
>> +     }
>>
>>       if (host->pdata->quirks & DW_MCI_QUIRK_HIGHSPEED)
>>               mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
>> @@ -1852,7 +1911,6 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>>       else
>>               clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
>>
>> -     host->slot[id] = slot;
>>       mmc_add_host(mmc);
>>
>>  #if defined(CONFIG_DEBUG_FS)
>> @@ -1944,16 +2002,74 @@ static bool mci_wait_reset(struct device *dev, struct dw_mci *host)
>>       return false;
>>  }
>>
> The following CONFIG_OF block can be put together in upper CONFIG_OF .

The placement of device tree related code is considering the logical
structure and flow of the code. So maybe we can just retain the below
code here for now.

>
>> +#ifdef CONFIG_OF
>> +static struct dw_mci_of_quirks {
>> +     char *quirk;
>> +     int id;
>> +} of_quirks[] = {
>> +     {
>> +             .quirk  = "supports-highspeed",
>> +             .id     = DW_MCI_QUIRK_HIGHSPEED,
>> +     }, {
>> +             .quirk  = "broken-cd",
>> +             .id     = DW_MCI_QUIRK_BROKEN_CARD_DETECTION,
>> +     },
>> +};
>> +
>> +static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>> +{
>> +     struct dw_mci_board *pdata;
>> +     struct device *dev = host->dev;
>> +     struct device_node *np = dev->of_node;
>> +     int idx;
>> +
>> +     pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>> +     if (!pdata) {
>> +             dev_err(dev, "could not allocate memory for pdata\n");
>> +             return ERR_PTR(-ENOMEM);
>> +     }
>> +
>> +     /* find out number of slots supported */
>> +     if (of_property_read_u32(dev->of_node, "num-slots",
>> +                             &pdata->num_slots)) {
>> +             dev_info(dev, "num-slots property not found, "
>> +                             "assuming 1 slot is available\n");
>> +             pdata->num_slots = 1;
>> +     }
>> +
>> +     /* get quirks */
>> +     for (idx = 0; idx < ARRAY_SIZE(of_quirks); idx++)
>> +             if (of_get_property(np, of_quirks[idx].quirk, NULL))
>> +                     pdata->quirks |= of_quirks[idx].id;
>> +
>> +     if (of_property_read_u32(np, "fifo-depth", &pdata->fifo_depth))
>> +             dev_info(dev, "fifo-depth property not found, using "
>> +                             "value of FIFOTH register as default\n");
>> +
>> +     of_property_read_u32(np, "card-detect-delay", &pdata->detect_delay_ms);
>> +
>> +     return pdata;
>> +}
>> +
>> +#else /* CONFIG_OF */
>> +static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>> +{
>> +     return ERR_PTR(-EINVAL);
>> +}
>> +#endif /* CONFIG_OF */
>> +
>>  int dw_mci_probe(struct dw_mci *host)
>>  {
>>       int width, i, ret = 0;
>>       u32 fifo_size;
>>       int init_slots = 0;
>>
>> -     if (!host->pdata || !host->pdata->init) {
> "!host->pdata->init" is removed.
> Please check it.

I have checked again in mmc-next branch and "init" is still there.

Thanks,
Thomas.


>
> Thanks,
> Seungwon Jeon
>
>> -             dev_err(host->dev,
>> -                     "Platform data must supply init function\n");
>> -             return -ENODEV;
>> +     if (!host->pdata) {
>> +             host->pdata = dw_mci_parse_dt(host);
>> +             if (IS_ERR(host->pdata)) {
>> +                     dev_err(host->dev, "platform data not available\n");
>> +                     return -EINVAL;
>> +             }
>>       }
>>
>>       if (!host->pdata->select_slot && host->pdata->num_slots > 1) {
>> --
>> 1.6.6.rc2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

[...]
