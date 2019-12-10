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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50210C2D0BF
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 14:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2138320828
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 14:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laoAr8Cs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfLJOQC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:16:02 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41259 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbfLJOQC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2019 09:16:02 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so20044950ljc.8;
        Tue, 10 Dec 2019 06:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jD+WtoffrchcEdWN7/kMz52aEW8U9ECt9MIhf+NIRt8=;
        b=laoAr8CsHFTCAMbrW53NWJOiRysmj/Tw3iUdtbteH/C1jXBWCqxzLqBqZop+YNW0xn
         ngJTfifBTbUxg3TdRFG6SXG4wIxijNGunKGJp8crNWtA+Eq6WZjuyLFIkGGoEFtpwaVO
         WsNIyitIXpOlZNt8sRajfUQg6QCJm45rBpMUOU8ENx47puUbTwvZXJQ1oTw812UKeIOn
         R5y7x34rZzRdBdahDx9y9FrRMtihTLp9HZxUqfUWtmwXwnuooHkGaydEfrw9IYkJHYuz
         aq0cUMDj7XvDuAv4/Df+MqVT5zM3lNPR5UYcZxhRZNkHd7vFAunbZ7fM6SXZ272s8+CV
         vC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jD+WtoffrchcEdWN7/kMz52aEW8U9ECt9MIhf+NIRt8=;
        b=CtElbGrrXuuVP25K16xfoWGewVmDp+Df3QtzhOouSqOqTrHApZukZlJXVQBzTg89Pg
         ooI3Cw/pTRXwAtR9P8MtV1Oe2wwFwllRg+2HrC/XdfaVRu0LpGWyUJMbdmhuABY9++M7
         kH+h+c4pWdEcvaxRgGZmnZ3WWUtNy6YSe+bGaCEzsuhsfQXG2V2ESf3bhVAYDixOocST
         ECBBR3tCmwTWcdg7PbZVMw/Qmqyt5728Ca3bPRNS46PeTq1nkFlD62h8NTzZhZgIPHTD
         soQC2pyGnFS9TUDZBjrtQp49gRQCGvyMK276a4w+XZ1XMLThE2hgRGhjvNf49RrgjAlT
         e7pw==
X-Gm-Message-State: APjAAAXLtMXRWDYParB/utPNQNO61Li+vc3B0PjqqxQahGlEFk9dplmO
        ZMcA7DR/F46KIqyf+uuh00Q0qJWn
X-Google-Smtp-Source: APXvYqzuJICIEMYqEq4hgKpvqtsHTLgg/v7d6kKGG3DNPNP6pIxTUHhXp04kW61Z/4BccLTl5EsbtA==
X-Received: by 2002:a05:651c:102c:: with SMTP id w12mr20347892ljm.53.1575987359949;
        Tue, 10 Dec 2019 06:15:59 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id c23sm1819382ljj.78.2019.12.10.06.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 06:15:59 -0800 (PST)
Subject: Re: [PATCH v1] sdhci: tegra: Add workaround for Broadcom WiFi
To:     Thierry Reding <thierry.reding@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191210014011.21987-1-digetx@gmail.com>
 <20191210125208.GD2703785@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <61b7a865-6a6f-5edf-7463-cfdd6b20f687@gmail.com>
Date:   Tue, 10 Dec 2019 17:15:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191210125208.GD2703785@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

10.12.2019 15:52, Thierry Reding пишет:
> On Tue, Dec 10, 2019 at 04:40:11AM +0300, Dmitry Osipenko wrote:
>> All Tegra20 boards that have embedded Broadcom WiFi SDIO chip are affected
>> by a problem where WiFi chip reports CCCR v1.10, while it should v1.20.
>> In a result high-speed mode isn't enabled for the WiFi card and this
>> results in a malfunctioning SDIO communication.
>>
>>  brcmfmac: brcmf_sdio_readframes: read 304 bytes from channel 1 failed: -84
>>  brcmfmac: brcmf_sdio_rxfail: abort command, terminate frame, send NAK
>>
>> Downstream kernels are overriding card's CCCR info in SDHCI driver to fix
>> the problem, let's do the same in upstream.
>>
>> The change is inspired by omap_hsmmc_init_card() of OMAP's HSMMC driver,
>> which overrides card's info for the TI wl1251 WiFi.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/mmc/host/sdhci-tegra.c | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
> 
> This seems like the wrong place to do this. If this is specific to this
> WiFi SDIO chip this should be handled at the SDIO card or function
> level. It seems like the SDIO infrastructure doesn't currently allow
> this because the OF nodes are attached to the card after
> mmc_sdio_init_card(), whereas it seems like the quirk is already needed
> during mmc_sdio_init_card().
> 
> That said, I think we could have some common code that's executed as
> part of mmc_attach_sdio() (and before mmc_sdio_init_card()).
> 
> Actually, it looks like we already have something like that.
> mmc_sdio_init_card() calls mmc_fixup_device() with sdio_fixup_methods
> after doing some very basic initialization. Do you know if things start
> to go wrong before or after that point? It might be worth looking at
> that SDIO fixup array and add something that would override the CCCR
> support. That would fix things in a more generic way rather than
> requiring every host controller driver to duplicate this quirk.

Hello Thierry,

Thank you very much for the suggestion, looks like indeed it is possible
to make workaround in a generic way.

Ulf / Adrian, will something like this be acceptable:

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index 7bd392d55cfa..a6001f210b9e 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -150,6 +150,12 @@ static inline void __maybe_unused
add_limit_rate_quirk(struct mmc_card *card,
 	card->quirk_max_rate = data;
 }

+static inline void __maybe_unused add_high_speed_quirk(struct mmc_card
*card,
+						       int data)
+{
+	card->cccr.high_speed = data;
+}
+
 /*
  * Quirk add/remove for MMC products.
  */
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 3dba15bccce2..a824c0caa7fb 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -142,6 +142,9 @@ static const struct mmc_fixup sdio_fixup_methods[] = {
 	SDIO_FIXUP(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8887WLAN,
 		   add_limit_rate_quirk, 150000000),

+	SDIO_FIXUP(SDIO_VENDOR_ID_BROADCOM, SDIO_DEVICE_ID_BROADCOM_4329,
+		   add_high_speed_quirk, 1),
+
 	END_FIXUP
 };

[snip]
