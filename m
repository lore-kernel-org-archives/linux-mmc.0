Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13B3C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 13:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCED06121F
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 13:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241222AbhIWNQZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Sep 2021 09:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241208AbhIWNQY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2021 09:16:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37C1C061574
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2021 06:14:52 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t7so16976181wrw.13
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2021 06:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=80UxY1enuCFe58nmKjLrfwQyDKpTWbHut+n/Ngi6cTA=;
        b=rYYCki9whbjCiL3yMJdKiPtl2Tf04x+/AvhUX/HlXc/ADHeJ32ZjXZ23HMcsPFa4lC
         jNcDVfN5BGolzIBXUgHnSx0cb1rM+4MAhuL1WSmg/GvCc8xZ1f6ryVYfeD/mKextRhW9
         H8VRg/MSUZXq0XBMf3PAASiY8/5R9DivW58esMuPlzoFcPCnlHLc0HamLOKCV/vJ31Bh
         OtUWQGWM8GpFhoLb5vYP2B6JrtyGxWIuZsKgZ1/ttp3joGPUFJOUB4jDt5U3jpqbg4A2
         YGWW3PCqAXknOEmLrTVvhFxYq/u/DV4jBzFqvmyCcIK4TyetiQj5Eksfvj/yOF/buRRO
         CaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=80UxY1enuCFe58nmKjLrfwQyDKpTWbHut+n/Ngi6cTA=;
        b=kiCMwugls7DWUHdzaG+bywDlN8gI//FVBEwthH1wR+ezq7W0FBbVtYN9yiRjntPfvW
         /uSN7gTOCvN9CXQud58K7H0ZV8+pdZuWpASkzevTiVLrP6IIEbmGR9wC8h7KImfTdg5b
         Fx5TtqHtje9XWv68UvHl8LFnm6/NAX7O+J+An0ZEblB1hmXPDgpREZuwN5tJcKlrcL5s
         kf9kpKqOhpw7gvXJBgwjSVhMIXpjpoJqn7S6njG4eEyTqlnm5I5vwrBh9fAT7m7uGeWO
         HQHxU1ThVnnllgsONEMaMzJBLRPRja3g4kPJhtRsVmeBjnxVeuDlipOf6wTSp4nRcWPv
         QtMw==
X-Gm-Message-State: AOAM530ehG0u4GRmZTGXbzmoNcith3Z0S+ONjQkzE9NbYlaxTFrRebVb
        lugWX5W4QrfqYmmo/z/Nr884dA==
X-Google-Smtp-Source: ABdhPJxYzpndfvjHaLbcMucSA4gcaPJqZy2NFTf+HQ5ihXpmilx7qhJrkNW6Sv5zfFrrzrIQ3Naqbg==
X-Received: by 2002:a7b:c405:: with SMTP id k5mr4442195wmi.24.1632402891108;
        Thu, 23 Sep 2021 06:14:51 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:74cf:b054:76f4:7692? ([2001:861:44c0:66c0:74cf:b054:76f4:7692])
        by smtp.gmail.com with ESMTPSA id u29sm5503073wru.34.2021.09.23.06.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 06:14:50 -0700 (PDT)
Subject: Re: [PATCH] mmc: meson-gx: do not use memcpy_to/fromio for
 dram-access-quirk
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20210913080504.832521-1-narmstrong@baylibre.com>
 <CAPDyKFqLvnAOAmk3PeNiBzwXTgwvG+zEO1b_pJNzSuUZ3Zamxg@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <07dcfe81-c7cd-69d6-3f22-9f58cc2e1fb0@baylibre.com>
Date:   Thu, 23 Sep 2021 15:14:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqLvnAOAmk3PeNiBzwXTgwvG+zEO1b_pJNzSuUZ3Zamxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On 23/09/2021 12:51, Ulf Hansson wrote:
> On Mon, 13 Sept 2021 at 10:05, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> The memory at the end of the controller only accepts 32bit read/write
>> accesses, but the arm64 memcpy_to/fromio implementation only uses 64bit
>> (which will be split into two 32bit access) and 8bit leading to incomplete
>> copies to/from this memory when the buffer is not multiple of 8bytes.
>>
>> Add a local copy using writel/readl accesses to make sure we use the right
>> memory access width.
>>
>> The switch to memcpy_to/fromio was done because of 285133040e6c
>> ("arm64: Import latest memcpy()/memmove() implementation"), but using memcpy
>> worked before since it mainly used 32bit memory acceses.
>>
>> Fixes: 103a5348c22c ("mmc: meson-gx: use memcpy_to/fromio for dram-access-quirk")
>> Reported-by: Christian Hewitt <christianshewitt@gmail.com>
>> Suggested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/mmc/host/meson-gx-mmc.c | 49 +++++++++++++++++++++++----------
>>  1 file changed, 35 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> index 3f28eb4d17fe..08c0ff0bfa8b 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -746,7 +746,7 @@ static void meson_mmc_desc_chain_transfer(struct mmc_host *mmc, u32 cmd_cfg)
>>         writel(start, host->regs + SD_EMMC_START);
>>  }
>>
>> -/* local sg copy to buffer version with _to/fromio usage for dram_access_quirk */
>> +/* local sg copy for dram_access_quirk */
>>  static void meson_mmc_copy_buffer(struct meson_host *host, struct mmc_data *data,
>>                                   size_t buflen, bool to_buffer)
>>  {
>> @@ -764,21 +764,34 @@ static void meson_mmc_copy_buffer(struct meson_host *host, struct mmc_data *data
>>         sg_miter_start(&miter, sgl, nents, sg_flags);
>>
>>         while ((offset < buflen) && sg_miter_next(&miter)) {
>> -               unsigned int len;
>> +               unsigned int buf_offset = 0;
>> +               unsigned int len, left;
>> +               u32 *buf = miter.addr;
>> +
>> +               if (((unsigned long int)miter.addr % 4))
>> +                       dev_err(host->dev, "non word aligned sg");
> 
> This looks weird. You print an error message, but continue to process
> data? If this is a case you can't handle, perhaps you should propagate
> an error code instead?
> 
> Additionally, you may want to use the IS_ALIGNED() macro.
> 
>>
>>                 len = min(miter.length, buflen - offset);
>>
>> -               /* When dram_access_quirk, the bounce buffer is a iomem mapping */
>> -               if (host->dram_access_quirk) {
>> -                       if (to_buffer)
>> -                               memcpy_toio(host->bounce_iomem_buf + offset, miter.addr, len);
>> -                       else
>> -                               memcpy_fromio(miter.addr, host->bounce_iomem_buf + offset, len);
>> +               if ((len % 4))
>> +                       dev_err(host->dev, "non word multiple sg");
> 
> Again, a dev_err() doesn't seem like the right thing to do. If you
> can't handle this, please return an error code instead.
> 
> Perhaps returning an error code isn't convenient at this point. An
> option could then be to pre-validate the sglist at the time of
> starting the request. We have other host drivers doing this, have a
> look at drivers/mmc/host/mmci*, for example.

Yep pre-validating the data at the request callback seems the best solution,

Thanks,
Neil

> 
>> +
>> +               left = len;
>> +
>> +               if (to_buffer) {
>> +                       do {
>> +                               writel(*buf++, host->bounce_iomem_buf + offset + buf_offset);
>> +
>> +                               buf_offset += 4;
>> +                               left -= 4;
>> +                       } while (left);
>>                 } else {
>> -                       if (to_buffer)
>> -                               memcpy(host->bounce_buf + offset, miter.addr, len);
>> -                       else
>> -                               memcpy(miter.addr, host->bounce_buf + offset, len);
>> +                       do {
>> +                               *buf++ = readl(host->bounce_iomem_buf + offset + buf_offset);
>> +
>> +                               buf_offset += 4;
>> +                               left -= 4;
>> +                       } while (left);
>>                 }
>>
>>                 offset += len;
>> @@ -830,7 +843,11 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>>                 if (data->flags & MMC_DATA_WRITE) {
>>                         cmd_cfg |= CMD_CFG_DATA_WR;
>>                         WARN_ON(xfer_bytes > host->bounce_buf_size);
>> -                       meson_mmc_copy_buffer(host, data, xfer_bytes, true);
>> +                       if (host->dram_access_quirk)
>> +                               meson_mmc_copy_buffer(host, data, xfer_bytes, true);
>> +                       else
>> +                               sg_copy_to_buffer(data->sg, data->sg_len,
>> +                                                 host->bounce_buf, xfer_bytes);
>>                         dma_wmb();
>>                 }
>>
>> @@ -999,7 +1016,11 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
>>         if (meson_mmc_bounce_buf_read(data)) {
>>                 xfer_bytes = data->blksz * data->blocks;
>>                 WARN_ON(xfer_bytes > host->bounce_buf_size);
>> -               meson_mmc_copy_buffer(host, data, xfer_bytes, false);
>> +               if (host->dram_access_quirk)
>> +                       meson_mmc_copy_buffer(host, data, xfer_bytes, false);
>> +               else
>> +                       sg_copy_from_buffer(data->sg, data->sg_len,
>> +                                           host->bounce_buf, xfer_bytes);
>>         }
>>
>>         next_cmd = meson_mmc_get_next_command(cmd);
>> --
>> 2.25.1
>>
> 
> Kind regards
> Uffe
> 

