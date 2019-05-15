From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/3] mmc: meson-gx: add ddr-access-quirk
Date: Wed, 15 May 2019 14:45:38 +0200
Message-ID: <a54f7a4a-c280-6181-969f-4979dadb36b2@baylibre.com>
References: <20190513091548.16674-1-narmstrong@baylibre.com>
 <20190513091548.16674-3-narmstrong@baylibre.com>
 <CAFBinCAMoNDnxoQA9XHKy0Xo9MduxD1CvQXOeLZQ3zZ4ViWm7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAFBinCAMoNDnxoQA9XHKy0Xo9MduxD1CvQXOeLZQ3zZ4ViWm7A@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: ulf.hansson@linaro.org, baylibre-upstreaming@groups.io, khilman@baylibre.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 14/05/2019 19:58, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Mon, May 13, 2019 at 11:16 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> [...]
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
> I'm curious: why do you need to set bounce_dma_addr in this case?

We still need the physical bounce buffer address since we write in the registers,
and we need the logical address to memcpy() in the buffer.

> 
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
> if host->descs cannot be allocated then you need to conditionally skip
> dma_free_coherent for the bounce buffer in the goto err_bounce_buf
> case a few lines below (just like you did in meson_mmc_remove)

It can be allocated, it's only useless. I can skip it but I don't want
to break any logic in the driver.

> 
> 
> Martin
> 
