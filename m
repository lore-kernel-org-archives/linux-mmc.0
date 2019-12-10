Return-Path: <SRS0=vd7C=2A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B741C43603
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 14:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539AC20838
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 14:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arH933MR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfLJOcU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:32:20 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34515 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfLJOcU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2019 09:32:20 -0500
Received: by mail-lj1-f196.google.com with SMTP id m6so20161342ljc.1;
        Tue, 10 Dec 2019 06:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NtQLIixJvWLdOmT9WjBNSoTnwbz5rbhUufNkRo6kvMI=;
        b=arH933MRe09aXDaXrf09Pixv4TtIu/KOyaICoCwJEjVF+jnr4jWbZNkD20PhNLy4bl
         pyJWbh+mnbPUqUpRGtOocGeS+riWJaJvsi+TnMPrHUa9tl+Qna40PAmFw6DHyPxhwbBO
         3RZSHOZLDzlMAWhajHBz0TwDjoMbEVGIvo3oa3wLSQKK2yQYK6CIFUzBpf5DJE4DRpI0
         FO63VmtDLOJfsE6K0iynemMw+wqZzn533VYmd6FM1WBwtWSSTNKNnBiM4vTd7u2UxJdB
         NfxALL3qe3MpOC5bkjM8Ky0pIbaZXxIaC0sdVljy9mA4ysKYPWcexSy6a/81kHiAsf+y
         gtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NtQLIixJvWLdOmT9WjBNSoTnwbz5rbhUufNkRo6kvMI=;
        b=nCfTU+amy8EgI1XM1gfJRFREsbj1ziHbS0vslTI+HRWAYAlkToVJBCVVihZ0FQVMkP
         SeB2xKm4EAHz47qmFCgwPY8Vh53FUUq2DpXzo8KAGN3BPPx7B26A9/8h4O1nx/KAGtRR
         N1PiUqbfFVYGNvtG127ERPbpI3W0o80QDHAWVpUygjYm2SmZ2VWsGfsZJGPG0HtuzjwJ
         lp3ZLlGqDTw6yAkMLqXp5y6+F7b0rg4EW7OrLUTVntgheiwNIyFXx8LdbP0PIS8XYTo6
         /Htg8gwkj46bjrpdsF4vDu2z3JW98nsMffNuvvtY3ZKjubDsDsJeEmi7tTX/2PdKmQH1
         Tb8A==
X-Gm-Message-State: APjAAAXgBEA0oj8x7uGme3DfyEt9p4CDMV0oUBP3XNo/L1YoY4oBooq3
        uhecBjzVRqxl+/LxL608HruEgfie
X-Google-Smtp-Source: APXvYqx8TeNe2BV8pHNQaaDHPaPYKKw7a50n8BOjI/SGqtlX0JK4+XeQcN4XjcJY6Uw6VLffz7JKEQ==
X-Received: by 2002:a2e:93c9:: with SMTP id p9mr14285548ljh.136.1575988337287;
        Tue, 10 Dec 2019 06:32:17 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id m15sm2010376ljg.4.2019.12.10.06.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 06:32:16 -0800 (PST)
Subject: Re: [PATCH v1] sdhci: tegra: Add workaround for Broadcom WiFi
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191210014011.21987-1-digetx@gmail.com>
 <20191210125208.GD2703785@ulmo>
 <61b7a865-6a6f-5edf-7463-cfdd6b20f687@gmail.com>
Message-ID: <bc0ebcd6-082a-7b2f-0dc7-c1dc04db12b0@gmail.com>
Date:   Tue, 10 Dec 2019 17:32:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <61b7a865-6a6f-5edf-7463-cfdd6b20f687@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

10.12.2019 17:15, Dmitry Osipenko пишет:
> 10.12.2019 15:52, Thierry Reding пишет:
>> On Tue, Dec 10, 2019 at 04:40:11AM +0300, Dmitry Osipenko wrote:
>>> All Tegra20 boards that have embedded Broadcom WiFi SDIO chip are affected
>>> by a problem where WiFi chip reports CCCR v1.10, while it should v1.20.
>>> In a result high-speed mode isn't enabled for the WiFi card and this
>>> results in a malfunctioning SDIO communication.
>>>
>>>  brcmfmac: brcmf_sdio_readframes: read 304 bytes from channel 1 failed: -84
>>>  brcmfmac: brcmf_sdio_rxfail: abort command, terminate frame, send NAK
>>>
>>> Downstream kernels are overriding card's CCCR info in SDHCI driver to fix
>>> the problem, let's do the same in upstream.
>>>
>>> The change is inspired by omap_hsmmc_init_card() of OMAP's HSMMC driver,
>>> which overrides card's info for the TI wl1251 WiFi.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/mmc/host/sdhci-tegra.c | 28 ++++++++++++++++++++++++++++
>>>  1 file changed, 28 insertions(+)
>>
>> This seems like the wrong place to do this. If this is specific to this
>> WiFi SDIO chip this should be handled at the SDIO card or function
>> level. It seems like the SDIO infrastructure doesn't currently allow
>> this because the OF nodes are attached to the card after
>> mmc_sdio_init_card(), whereas it seems like the quirk is already needed
>> during mmc_sdio_init_card().
>>
>> That said, I think we could have some common code that's executed as
>> part of mmc_attach_sdio() (and before mmc_sdio_init_card()).
>>
>> Actually, it looks like we already have something like that.
>> mmc_sdio_init_card() calls mmc_fixup_device() with sdio_fixup_methods
>> after doing some very basic initialization. Do you know if things start
>> to go wrong before or after that point? It might be worth looking at
>> that SDIO fixup array and add something that would override the CCCR
>> support. That would fix things in a more generic way rather than
>> requiring every host controller driver to duplicate this quirk.
> 
> Hello Thierry,
> 
> Thank you very much for the suggestion, looks like indeed it is possible
> to make workaround in a generic way.
> 
> Ulf / Adrian, will something like this be acceptable:
> 
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index 7bd392d55cfa..a6001f210b9e 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -150,6 +150,12 @@ static inline void __maybe_unused
> add_limit_rate_quirk(struct mmc_card *card,
>  	card->quirk_max_rate = data;
>  }
> 
> +static inline void __maybe_unused add_high_speed_quirk(struct mmc_card
> *card,
> +						       int data)
> +{
> +	card->cccr.high_speed = data;
> +}
> +
>  /*
>   * Quirk add/remove for MMC products.
>   */
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index 3dba15bccce2..a824c0caa7fb 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -142,6 +142,9 @@ static const struct mmc_fixup sdio_fixup_methods[] = {
>  	SDIO_FIXUP(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8887WLAN,
>  		   add_limit_rate_quirk, 150000000),
> 
> +	SDIO_FIXUP(SDIO_VENDOR_ID_BROADCOM, SDIO_DEVICE_ID_BROADCOM_4329,
> +		   add_high_speed_quirk, 1),
> +
>  	END_FIXUP
>  };
> 
> [snip]

On second thought, perhaps it's not very universal to change card's CCCR
and this should be a better variant:

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index 7bd392d55cfa..b5e44fcda7fb 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -222,4 +222,9 @@ static inline int mmc_card_broken_hpi(const struct
mmc_card *c)
 	return c->quirks & MMC_QUIRK_BROKEN_HPI;
 }

+static inline int mmc_card_need_high_speed_toggle(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_HIGH_SPEED_CARD;
+}
+
 #endif
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 3dba15bccce2..c9af62a1d44b 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -142,6 +142,9 @@ static const struct mmc_fixup sdio_fixup_methods[] = {
 	SDIO_FIXUP(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8887WLAN,
 		   add_limit_rate_quirk, 150000000),

+	SDIO_FIXUP(SDIO_VENDOR_ID_BROADCOM, SDIO_DEVICE_ID_BROADCOM_4329,
+		   add_quirk, MMC_QUIRK_HIGH_SPEED_CARD),
+
 	END_FIXUP
 };

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index ebb387aa5158..ac12c7631ec5 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -323,7 +323,7 @@ static int mmc_sdio_switch_hs(struct mmc_card *card,
int enable)
 	if (!(card->host->caps & MMC_CAP_SD_HIGHSPEED))
 		return 0;

-	if (!card->cccr.high_speed)
+	if (!mmc_card_need_high_speed_toggle(card) && !card->cccr.high_speed)
 		return 0;

 	ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_SPEED, 0, &speed);
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index cf3780a6ccc4..06f697e6d002 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -269,6 +269,7 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_IRQ_POLLING	(1<<11)	/* Polling SDIO_CCCR_INTx
could create a fake interrupt */
 #define MMC_QUIRK_TRIM_BROKEN	(1<<12)		/* Skip trim */
 #define MMC_QUIRK_BROKEN_HPI	(1<<13)		/* Disable broken HPI support */
+#define MMC_QUIRK_HIGH_SPEED_CARD	(1<<14)	/* Card is high-speed capable */

 	bool			reenable_cmdq;	/* Re-enable Command Queue */

