Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DDAC00140
	for <linux-mmc@archiver.kernel.org>; Thu, 18 Aug 2022 06:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243614AbiHRGU4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 18 Aug 2022 02:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243624AbiHRGUx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Aug 2022 02:20:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B09BA285D
        for <linux-mmc@vger.kernel.org>; Wed, 17 Aug 2022 23:20:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id j8so1398056ejx.9
        for <linux-mmc@vger.kernel.org>; Wed, 17 Aug 2022 23:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc;
        bh=cE40KzOAHgSsI3+yA6l4Fbr52ebb6r45dUqZKpm5LLw=;
        b=drWEerl4127r+Ht3QRFCKOsppxqYE139Q+6U3XMYkgO0HjWQDgW+xcyEZKECC1Umsf
         +n7yrVzExv6BST+ZK27Luoho33R5fDy7wD0u6Ptr8JToK/LGRScrrjqxRXMrGdGSbBqa
         iSHSiGUZCzSR5SbN3BzDIqMaVJceOtnYdiVH5Mxel62afJedDhS5iIvjMdsuWXrLheb8
         TwyBbzXFCCcrcqL9IukaqNTFK/g2pUYu7fUBXf0IJuG9KhWspNh6AJi70UNG3XYGOZxX
         3E+plkYWJ4e3+lWFC084EkEdPTaPDCufKhc6BdbU9hKMdhIKnph3Vp3PcDOaDYYPzw+j
         GNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=cE40KzOAHgSsI3+yA6l4Fbr52ebb6r45dUqZKpm5LLw=;
        b=QdxbusJLwzCTdDwnqkk8g+9djNhMS27jf1k+r6UesxNcRvGriUA5zY92dKHRlVke+e
         CJ1BQ7BX37J7dMsm3ykSjOTDH+AJPmJUdt/I7YFXXo+B+nuOqGpvrJSggB1y1DEcX755
         V6chhYgUXns/Yey0uAvEIL7Df7lhM+wAZQ+n+TOemlKO/6HGCxha5OOp1b738saioovL
         l+oOYATnqTaRHy+unfm5GEC8yQtGZH784UmX6o7snSVaSQGaLDMLQi7ty9s8es4Hgq/B
         jiaEkVH0cYuYThgxbDvKVvnLkk1kW2r9Qf3lplTUAbVWrsGBvCpJ5T3AW/T4nu4P0YE5
         A88Q==
X-Gm-Message-State: ACgBeo2IK3KtsHXDcIbljrvaAw6DPlItJ/j8ZNdu5V5gazJkP/lhShYb
        NsRJ0N3PF9AS6uO8mDRgugI=
X-Google-Smtp-Source: AA6agR5SM1kCR6ZA2xPD4obyZAHIbd6m040hxAO9SVHTySXbjP5sn43H3Itv6iCHvcRMyP4/1SxbAg==
X-Received: by 2002:a17:907:1c89:b0:734:d05c:582e with SMTP id nb9-20020a1709071c8900b00734d05c582emr988364ejc.282.1660803650447;
        Wed, 17 Aug 2022 23:20:50 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bdc7:a00:a1fc:6cca:3686:2302? (dynamic-2a01-0c23-bdc7-0a00-a1fc-6cca-3686-2302.c23.pool.telefonica.de. [2a01:c23:bdc7:a00:a1fc:6cca:3686:2302])
        by smtp.googlemail.com with ESMTPSA id x19-20020aa7d6d3000000b00445e037345csm534784edr.14.2022.08.17.23.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 23:20:49 -0700 (PDT)
Message-ID: <af405e40-ea58-075a-e364-b3c1c4b1cc1a@gmail.com>
Date:   Thu, 18 Aug 2022 08:20:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
References: <ecc229ad-c15a-2092-6568-f92e4507553e@gmail.com>
 <CAPDyKFoi70K9SBJbdvLZbseNpO2J4s-gZt-zpHMf-40wEyecYA@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: add SDIO interrupt support
In-Reply-To: <CAPDyKFoi70K9SBJbdvLZbseNpO2J4s-gZt-zpHMf-40wEyecYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15.08.2022 20:20, Ulf Hansson wrote:
> On Sun, 14 Aug 2022 at 23:44, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> This adds SDIO interrupt support.
>> Successfully tested on a S905X4-based system with a BRCM4334
>> SDIO wifi module (brcmfmac driver).
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/mmc/host/meson-gx-mmc.c | 45 +++++++++++++++++++++++++--------
>>  1 file changed, 34 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> index 2f08d442e..e8d53fcdd 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -41,14 +41,17 @@
>>  #define   CLK_V2_TX_DELAY_MASK GENMASK(19, 16)
>>  #define   CLK_V2_RX_DELAY_MASK GENMASK(23, 20)
>>  #define   CLK_V2_ALWAYS_ON BIT(24)
>> +#define   CLK_V2_IRQ_SDIO_SLEEP BIT(29)
>>
>>  #define   CLK_V3_TX_DELAY_MASK GENMASK(21, 16)
>>  #define   CLK_V3_RX_DELAY_MASK GENMASK(27, 22)
>>  #define   CLK_V3_ALWAYS_ON BIT(28)
>> +#define   CLK_V3_IRQ_SDIO_SLEEP BIT(29)
>>
>>  #define   CLK_TX_DELAY_MASK(h)         (h->data->tx_delay_mask)
>>  #define   CLK_RX_DELAY_MASK(h)         (h->data->rx_delay_mask)
>>  #define   CLK_ALWAYS_ON(h)             (h->data->always_on)
>> +#define   CLK_IRQ_SDIO_SLEEP(h)                (h->data->irq_sdio_sleep)
>>
>>  #define SD_EMMC_DELAY 0x4
>>  #define SD_EMMC_ADJUST 0x8
>> @@ -100,9 +103,6 @@
>>  #define   IRQ_END_OF_CHAIN BIT(13)
>>  #define   IRQ_RESP_STATUS BIT(14)
>>  #define   IRQ_SDIO BIT(15)
>> -#define   IRQ_EN_MASK \
>> -       (IRQ_CRC_ERR | IRQ_TIMEOUTS | IRQ_END_OF_CHAIN | IRQ_RESP_STATUS |\
>> -        IRQ_SDIO)
>>
>>  #define SD_EMMC_CMD_CFG 0x50
>>  #define SD_EMMC_CMD_ARG 0x54
>> @@ -136,6 +136,7 @@ struct meson_mmc_data {
>>         unsigned int rx_delay_mask;
>>         unsigned int always_on;
>>         unsigned int adjust;
>> +       unsigned int irq_sdio_sleep;
>>  };
>>
>>  struct sd_emmc_desc {
>> @@ -431,6 +432,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
>>         clk_reg |= FIELD_PREP(CLK_CORE_PHASE_MASK, CLK_PHASE_180);
>>         clk_reg |= FIELD_PREP(CLK_TX_PHASE_MASK, CLK_PHASE_0);
>>         clk_reg |= FIELD_PREP(CLK_RX_PHASE_MASK, CLK_PHASE_0);
>> +       clk_reg |= CLK_IRQ_SDIO_SLEEP(host);
>>         writel(clk_reg, host->regs + SD_EMMC_CLOCK);
>>
>>         /* get the mux parents */
>> @@ -933,7 +935,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>>  {
>>         struct meson_host *host = dev_id;
>>         struct mmc_command *cmd;
>> -       struct mmc_data *data;
>>         u32 irq_en, status, raw_status;
>>         irqreturn_t ret = IRQ_NONE;
>>
>> @@ -948,14 +949,24 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>>                 return IRQ_NONE;
>>         }
>>
>> -       if (WARN_ON(!host) || WARN_ON(!host->cmd))
>> +       if (WARN_ON(!host))
>>                 return IRQ_NONE;
>>
>>         /* ack all raised interrupts */
>>         writel(status, host->regs + SD_EMMC_STATUS);
>>
>>         cmd = host->cmd;
>> -       data = cmd->data;
>> +
>> +       if (status & IRQ_SDIO) {
>> +               mmc_signal_sdio_irq(host->mmc);
> 
> This is the legacy interface for supporting SDIO irqs. I am planning
> to remove it, sooner or later.
> 
> Please convert into using sdio_signal_irq() instead. Note that, using
> sdio_signal_irq() means you need to implement support for
> MMC_CAP2_SDIO_IRQ_NOTHREAD, which also includes to implement the
> ->ack_sdio_irq() callback.
> 
> There are other host drivers to be inspired from, but don't hesitate
> to ask if there is something unclear.
> 

One more question came to my mind:

Typically host drivers disable the SDIO interrupt source before calling
sdio_signal_irq(), and re-enable it in ->ack_sdio_irq().

In sdio_run_irqs() we have the following:

if (!host->sdio_irq_pending)
	host->ops->ack_sdio_irq(host);

In the middle of this code the host can't actively trigger a SDIO interrupt
because the interrupt source is still disabled. But some other host interrupt
could fire with also the SDIO interrupt source bit set.
Then the hard irq handler would disable the SDIO interrupt source, and directly
after this ->ack_sdio_irq() would re-enable it.
This looks racy to me and we may need some protection.
Do you share this view or do I miss something?

> [...]
> 
> Kind regards
> Uffe

