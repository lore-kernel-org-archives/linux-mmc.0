From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/3] mmc: meson-gx: add ddr-access-quirk
Date: Wed, 15 May 2019 14:51:35 +0200
Message-ID: <610fa8f2-29ec-96c6-b238-a1f444ad1c5b@baylibre.com>
References: <20190513091548.16674-1-narmstrong@baylibre.com>
 <20190513091548.16674-3-narmstrong@baylibre.com>
 <CAPDyKFp-mU-pCcwGUkL8B5YfhXamHtTcRHe8eX9SNupMxr-kgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFp-mU-pCcwGUkL8B5YfhXamHtTcRHe8eX9SNupMxr-kgg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>, baylibre-upstreaming@groups.io, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 15/05/2019 13:34, Ulf Hansson wrote:
> On Mon, 13 May 2019 at 11:16, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> On the Amlogic G12A SoC family, (only) the SDIO controller fails to access
>> the data from DDR, leading to a broken controller.
> 
> Could you possibly make it more clear that this is about the internal
> DMA support in the controller that is broken?
> 
> Did you consider to use the controller without using the DMA mode? Is
> that possible?

No we can only use the DMA, in block mode (using our bounce buffer mode)
or in descriptor mode.

> 
>>
>> But each MMC controller has 1,5KiB of SRAM after the registers, that can
>> be used as bounce buffer to avoid direct DDR access from the integrated
>> DMAs (this SRAM may be used by the boot ROM when DDR is not yet initialized).
> 
> I think "DDR" is a confusing terminology, that goes for the DT binding
> as well. What about using "DRAM" instead?

Seems better, I'll wait on Rob's feedback on this a few more days.

> 
> In any case, using the SRAM seems like it could work. However, just so
> I get this right, it solely dedicated to the SDIO controller or may
> someone else also try to use it?

This SRAM is dedicated to *each* MMC controller. Not sure if other masters
could access it, but it would be unfortunate.

I'll add these details in the commit log.

> 
>>
>> The quirk is to disable the chained descriptor for this controller, and
>> use this SRAM memory zone as buffer for the bounce buffer fallback mode.
>>
>> The performance hit hasn't been evaluated, but the fix has been tested
>> using a WiFi AP6398S SDIO module, and the iperf3 Bandwidth measurement gave
>> 55.2 Mbits/sec over a 63 Hours long test, with the SDIO ios set as High-Speed
>> at 50MHz clock. It gave 170 Mbits/sec as SDR104 and 200MHz clock.
> 
> If possible to not use DMA, it would be interesting to compare numbers. :-)

I could activate this quirk on a MMC or SDcard dedicated controller and
compare, but SDIO and MMC/SDcard transactions are really different.

We compared it on the AXG platform with the same MMC controller revision,
CPU freq, DRAM technology, kernel revision and the peak WiFi "speed" was
equivalent, but with a slighly superior CPU usage.

> 
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/mmc/host/meson-gx-mmc.c | 65 ++++++++++++++++++++++++++-------
>>  1 file changed, 52 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> index c5a8af4ca76b..6ef465304052 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -129,6 +129,9 @@
>>  #define SD_EMMC_TXD 0x94
>>  #define SD_EMMC_LAST_REG SD_EMMC_TXD
>>
>> +#define SD_EMMC_SRAM_DATA_BUF_LEN 1536
>> +#define SD_EMMC_SRAM_DATA_BUF_OFF 0x200
>> +
>>  #define SD_EMMC_CFG_BLK_SIZE 512 /* internal buffer max: 512 bytes */
>>  #define SD_EMMC_CFG_RESP_TIMEOUT 256 /* in clock cycles */
>>  #define SD_EMMC_CMD_TIMEOUT 1024 /* in ms */
>> @@ -168,6 +171,8 @@ struct meson_host {
>>         unsigned long req_rate;
>>         bool ddr;
>>
>> +       bool ddr_access_quirk;
>> +
>>         struct pinctrl *pinctrl;
>>         struct pinctrl_state *pins_default;
>>         struct pinctrl_state *pins_clk_gate;
>> @@ -232,11 +237,20 @@ static struct mmc_command *meson_mmc_get_next_command(struct mmc_command *cmd)
>>  static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
>>                                         struct mmc_request *mrq)
>>  {
>> +       struct meson_host *host = mmc_priv(mmc);
>>         struct mmc_data *data = mrq->data;
>>         struct scatterlist *sg;
>>         int i;
>>         bool use_desc_chain_mode = true;
>>
>> +       /*
>> +        * When Controller DMA cannot directly access DDR memory, disable
>> +        * support for Chain Mode to directly use the internal SRAM using
>> +        * the bounce buffer mode.
>> +        */
>> +       if (host->ddr_access_quirk)
>> +               return;
>> +
>>         /*
>>          * Broken SDIO with AP6255-based WiFi on Khadas VIM Pro has been
>>          * reported. For some strange reason this occurs in descriptor
>> @@ -1049,6 +1063,10 @@ static int meson_mmc_probe(struct platform_device *pdev)
>>         host->dev = &pdev->dev;
>>         dev_set_drvdata(&pdev->dev, host);
>>
>> +       /* The G12A SDIO Controller needs an SRAM bounce buffer */
>> +       host->ddr_access_quirk = device_property_read_bool(&pdev->dev,
>> +                                       "amlogic,ddr-access-quirk");
>> +
>>         /* Get regulators and the supported OCR mask */
>>         host->vqmmc_enabled = false;
>>         ret = mmc_regulator_get_supply(mmc);
>> @@ -1146,9 +1164,16 @@ static int meson_mmc_probe(struct platform_device *pdev)
>>                 goto err_init_clk;
>>
>>         mmc->caps |= MMC_CAP_CMD23;
>> -       mmc->max_blk_count = CMD_CFG_LENGTH_MASK;
>> +       if (host->ddr_access_quirk) {
>> +               /* Limit to the available sram memory */
>> +               mmc->max_segs = SD_EMMC_SRAM_DATA_BUF_LEN / mmc->max_blk_size;
>> +               mmc->max_blk_count = mmc->max_segs;
>> +       } else {
>> +               mmc->max_blk_count = CMD_CFG_LENGTH_MASK;
>> +               mmc->max_segs = SD_EMMC_DESC_BUF_LEN /
>> +                               sizeof(struct sd_emmc_desc);
>> +       }
>>         mmc->max_req_size = mmc->max_blk_count * mmc->max_blk_size;
>> -       mmc->max_segs = SD_EMMC_DESC_BUF_LEN / sizeof(struct sd_emmc_desc);
>>         mmc->max_seg_size = mmc->max_req_size;
>>
>>         /*
>> @@ -1158,15 +1183,27 @@ static int meson_mmc_probe(struct platform_device *pdev)
>>          */
>>         mmc->caps2 &= ~MMC_CAP2_HS400;
>>
>> -       /* data bounce buffer */
>> -       host->bounce_buf_size = mmc->max_req_size;
>> -       host->bounce_buf =
>> -               dma_alloc_coherent(host->dev, host->bounce_buf_size,
>> -                                  &host->bounce_dma_addr, GFP_KERNEL);
>> -       if (host->bounce_buf == NULL) {
>> -               dev_err(host->dev, "Unable to map allocate DMA bounce buffer.\n");
>> -               ret = -ENOMEM;
>> -               goto err_free_irq;
>> +       if (host->ddr_access_quirk) {
>> +               /*
>> +                * The MMC Controller embeds 1,5KiB of internal SRAM
>> +                * that can be used to be used as bounce buffer.
>> +                * In the case of the G12A SDIO controller, use these
>> +                * instead of the DDR memory
>> +                */
>> +               host->bounce_buf_size = SD_EMMC_SRAM_DATA_BUF_LEN;
>> +               host->bounce_buf = host->regs + SD_EMMC_SRAM_DATA_BUF_OFF;
>> +               host->bounce_dma_addr = res->start + SD_EMMC_SRAM_DATA_BUF_OFF;
>> +       } else {
>> +               /* data bounce buffer */
>> +               host->bounce_buf_size = mmc->max_req_size;
>> +               host->bounce_buf =
>> +                       dma_alloc_coherent(host->dev, host->bounce_buf_size,
>> +                                          &host->bounce_dma_addr, GFP_KERNEL);
>> +               if (host->bounce_buf == NULL) {
>> +                       dev_err(host->dev, "Unable to map allocate DMA bounce buffer.\n");
>> +                       ret = -ENOMEM;
>> +                       goto err_free_irq;
>> +               }
>>         }
>>
>>         host->descs = dma_alloc_coherent(host->dev, SD_EMMC_DESC_BUF_LEN,
>> @@ -1208,8 +1245,10 @@ static int meson_mmc_remove(struct platform_device *pdev)
>>
>>         dma_free_coherent(host->dev, SD_EMMC_DESC_BUF_LEN,
>>                           host->descs, host->descs_dma_addr);
>> -       dma_free_coherent(host->dev, host->bounce_buf_size,
>> -                         host->bounce_buf, host->bounce_dma_addr);
>> +
>> +       if (!host->ddr_access_quirk)
>> +               dma_free_coherent(host->dev, host->bounce_buf_size,
>> +                                 host->bounce_buf, host->bounce_dma_addr);
>>
>>         clk_disable_unprepare(host->mmc_clk);
>>         clk_disable_unprepare(host->core_clk);
>> --
>> 2.21.0
>>

Thanks for reviewing,

> 
> Kind regards
> Uffe
> 
