From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 13/13] mmc: mmci: Add Qcom specific pio_read function.
Date: Fri, 30 May 2014 17:20:51 +0100
Message-ID: <5388AFE3.4@linaro.org>
References: <1401284608-16428-1-git-send-email-srinivas.kandagatla@linaro.org>	<1401284886-16978-1-git-send-email-srinivas.kandagatla@linaro.org> <CAPDyKFpto10x7ZFbozkmnPhmTH3dkENEJetD_c08bgzytKa_xw@mail.gmail.com> <53886F25.8060509@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:46381 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933646AbaE3QU6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 May 2014 12:20:58 -0400
Received: by mail-we0-f179.google.com with SMTP id q59so2208462wes.24
        for <linux-mmc@vger.kernel.org>; Fri, 30 May 2014 09:20:56 -0700 (PDT)
In-Reply-To: <53886F25.8060509@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>

Hi Ulf,

Managed to reuse the existing mmci_pio_read function with some minor 
modifications, Issue was with reading full fifo sizes which was creating 
the issue.

On 30/05/14 12:44, Srinivas Kandagatla wrote:
> That sounds sensible.. I will try it.
>>
>>> +                       *ptr = readl(host->base + MMCIFIFO + (count %
>>> fsize));
>>
>> This looks strange. :-) Depending on the count you will read an offset
>> into the FIFO? Seems like a very awkward implementation of a FIFO in
>> the HW. :-)
>>
> I got into weird issues when I tried using the mmci_pio_read, the fifo
> implementation seems to be different. I dont have full details on the
> fifo behaviour.
>
> Most of this logic is inherited from 3.4 qcom andriod kernel.
>
>> BTW, what does "MCI_RXDATAAVLBL" actually mean for the Qcom variant?
>
> It means, At least 1 word in the RX FIFO. SW can read 1 word only from
> the FIFO.
>
>> How much data could you expect in the FIFO when this status is
>> triggered?
>
>> Are there no option of reading a number of words, depending on what
>> type FIFO IRQ that was raised?
> There are RXFIFO_HALF_FULL and RXFIFO_FULL bits in status register, but
> I never tried to use them. Might be worth a try before I send next
> version patches.
>
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -73,6 +73,7 @@ static unsigned int fmax = 515633;
   * @busy_detect: true if busy detection on dat0 is supported
   * @pwrreg_nopower: bits in MMCIPOWER don't controls ext. power supply
   * @explicit_mclk_control: enable explicit mclk control in driver.
+ * @qcom_fifo: enables qcom specific fifo pio read logic.
   */
  struct variant_data {
         unsigned int            clkreg;
@@ -95,6 +96,7 @@ struct variant_data {
         bool                    busy_detect;
         bool                    pwrreg_nopower;
         bool                    explicit_mclk_control;
+       bool                    qcom_fifo;
  };

  static struct variant_data variant_arm = {
@@ -990,15 +992,33 @@ mmci_cmd_irq(struct mmci_host *host, struct 
mmc_command *cmd,
         }
  }

+static int mmci_get_rx_fifocnt(struct mmci_host *host, u32 status, int 
remain)
+{
+       return remain - (readl(host->base + MMCIFIFOCNT) << 2);
+}
+
+static int mmci_qcom_get_rx_fifocnt(struct mmci_host *host, u32 status, 
int r)
+{
+       /*
+        * on qcom SDCC4 only 8 words are used in each burst so only 8 
addresses
+        * from the fifo range should be used
+        */
+       if (status & MCI_RXFIFOHALFFULL)
+               return host->variant->fifohalfsize;
+       else
+               return 4;
+}
+
  static int mmci_pio_read(struct mmci_host *host, char *buffer, 
unsigned int remain)
  {
         void __iomem *base = host->base;
         char *ptr = buffer;
-       u32 status;
+       int hf = host->variant->fifohalfsize;
         int host_remain = host->size;
+       u32 status = readl(host->base + MMCISTATUS);

         do {
-               int count = host_remain - (readl(base + MMCIFIFOCNT) << 2);
+               int count = host->get_rx_fifocnt(host, status, host_remain);

                 if (count > remain)
                         count = remain;
@@ -1488,6 +1508,11 @@ static int mmci_probe(struct amba_device *dev,
         if (ret)
                 goto host_free;

+       if (variant->qcom_fifo)
+               host->get_rx_fifocnt = mmci_qcom_get_rx_fifocnt;
+       else
+               host->get_rx_fifocnt = mmci_get_rx_fifocnt;
+
         host->plat = plat;
         host->variant = variant;
         host->mclk = clk_get_rate(host->clk);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index b5f0810..5f76670 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -229,6 +229,7 @@ struct mmci_host {
         /* pio stuff */
         struct sg_mapping_iter  sg_miter;
         unsigned int            size;
+       int (*get_rx_fifocnt)(struct mmci_host *h, u32 status, int remain);

  #ifdef CONFIG_DMA_ENGINE
