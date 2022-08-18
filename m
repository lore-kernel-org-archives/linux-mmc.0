Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10328C00140
	for <linux-mmc@archiver.kernel.org>; Thu, 18 Aug 2022 05:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242733AbiHRFyT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 18 Aug 2022 01:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240278AbiHRFyS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Aug 2022 01:54:18 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB1C70E57
        for <linux-mmc@vger.kernel.org>; Wed, 17 Aug 2022 22:54:16 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dc19so1285962ejb.12
        for <linux-mmc@vger.kernel.org>; Wed, 17 Aug 2022 22:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc;
        bh=QAv3rLn5bLt/fWxgAqcMN5YqYdzhNtYErcOJxTXB1wk=;
        b=YXJHZCJLTldxtnwTgFApWl5em9QGjb6cjLo7ipDDAmNU70f/ztjqYR0wOiD6fkMiFf
         HjQOy1EPOF1/VPwpLx9wZXs1m+iGQrlIbx6nf8j0ss5BgX5y6MHt429VLmIbpZ5Ls8/+
         Q5yBuSobeTIzrnhsB+6a30yyv8+XnlNFQTOxqFF6FWFRWARHcM5aN1xbKtaJ9v29X9P0
         9frGHmcFleQGWLH9E/KI+Y5QT2Wt3xyNaL8ZHz1SLMKdL7vjDMCChhED+V0rGyquS4H1
         r1ri2CejNPjyzLFLD4M5aI7Xr659bVAU7ISOoOzp68+w8wCPEqzbdQA2ghsBtIPkrNgu
         HkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=QAv3rLn5bLt/fWxgAqcMN5YqYdzhNtYErcOJxTXB1wk=;
        b=LLRTEtRtRKzKsuSg3pXeezZ4lRc51MmxePUUd5+0chgIUQMVK5QIitOGl4UcKo4Ruu
         trxX8OxcWvVIVg84KJqtwkAS/b4fm9sXZMeu/0LPNYnyZQMinzhE2btszwtt5LQPgk2H
         2Tr95yCj1S+E/DOb7xhXPpaiOuS9v2/jy5Pz+E46mgkbC7xklxasDrvoDPzt5KQFv86M
         mvKap7GFMm65de9VHWrc40R54yCRHzwNgG/Sr1E8LZ8kmi8tKMbnMXMSK57++dwmfgCu
         5r/ynsbeYUrKZ0nTzJDg3R0rWvzFP7vVuRzLhAc4JgwhvMm0zH6IpxFJBLTt0/aEYj3r
         TKvQ==
X-Gm-Message-State: ACgBeo2Bux9X82q6WS4utcQaUnn44sm78F72Gnq10tkwcqSLECmk7qJO
        27dHb9LJNmVo31GotpsxttE=
X-Google-Smtp-Source: AA6agR6tmkRbmUUxJBHemc7tmef2wlNa/hC363RS4IryW+nPyp07x0jQJf2vMZH6fmeN/A0/xTgGmg==
X-Received: by 2002:a17:907:738a:b0:730:7537:848c with SMTP id er10-20020a170907738a00b007307537848cmr895158ejc.488.1660802055414;
        Wed, 17 Aug 2022 22:54:15 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bdc7:a00:a1fc:6cca:3686:2302? (dynamic-2a01-0c23-bdc7-0a00-a1fc-6cca-3686-2302.c23.pool.telefonica.de. [2a01:c23:bdc7:a00:a1fc:6cca:3686:2302])
        by smtp.googlemail.com with ESMTPSA id o26-20020a170906289a00b0071cbc7487e1sm330077ejd.69.2022.08.17.22.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 22:54:14 -0700 (PDT)
Message-ID: <5030c495-e027-e900-0f79-e5343aa5777c@gmail.com>
Date:   Thu, 18 Aug 2022 07:54:09 +0200
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

I switched to the new API and it works for me, will submit a v2.

Just one question regarding core code:
The core defines sdio_irq_work as delayed work, but no caller sets a delay.
Then why not use a simple workqueue and schedule_work() instead of
queue_delayed_work()?

> [...]
> 
> Kind regards
> Uffe

