Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17BCC636D7
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Feb 2023 20:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBOUOL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Feb 2023 15:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBOUOL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2023 15:14:11 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286732597E
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 12:14:10 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id k3so12743476wrv.5
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 12:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=odieurvf10mcga9adT6YskNMFIVGrQrZFzWT8sMLM8Q=;
        b=gXdI45qWNupQUBNzpcj6HxFh5+saTgX+qIGVfCUiuvmwf06SywKEb7UhUw75y2AU1+
         xeWlliz7Hz32F/q19VUJm16oviUJoCy0xjfN1rzjttKvR+PjUbvDG/YkSeiAwdP6VUFN
         MxbSwRn5BdIzZLTHFy2exEs93NJRDX5R7XyWllSiPr5izHelmGkSpnFsr1HebHxZc0FR
         iGL6PIsZ1So+GgR8UjIOdPggoB4e7Pp4C1zYgnNq+c3CrnvV52EH1YGic7rF2Inssdf4
         +OqYJBJpICNUMF0e7uPY2HkTmx4Gk1ukQdgBkavOjQDJNasaGOIcfTXXpbcoMFCQ9tMf
         oMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=odieurvf10mcga9adT6YskNMFIVGrQrZFzWT8sMLM8Q=;
        b=L4MXlutfcr1dsPH3oXBLPFjDPvnwOhkWBPuAl33afqbfOuOD/IQNRnK6Jl7BULb6CD
         N+GPugW98KRG6Vw7ScvtgDOvpr1X5mMYjWaVEFgksODn3zTqcU5zYDpXg8hqsyEt7H8X
         WBYaDHM3ZXNt7v7mZjhOcnYLeA9haGvqyllShf4T1reMXY6d4HlTCV8ziIlRrWcUQIKp
         ZKfn3mOLqhzUmfiSg9LbwaFEcJfXaM9m86O1Wklrxb5uROkimVVGVEW/0LwmE0U1gcde
         FKWh2aWs0sJ9vcx8H/2VcWXNmAZO2MhBMyoR0UnkT+KfStEDLSbgpRC9vY5GCVtVgEnB
         5u/g==
X-Gm-Message-State: AO0yUKUY/1U2iHUt0j/NFzTPcyQn+/F/vYg9lVtvjf1duE1RTTpzpbNu
        9QqksjgNLveFasf0NgTni9zYO+wFPM0=
X-Google-Smtp-Source: AK7set8dQBdSzKt2yrFiXjGeTL210Xgi5w+tHPueRFWmSyOG7plYKPAt7DqVSI4GYCGJidNrhi2Ixw==
X-Received: by 2002:a05:6000:1e1d:b0:2c3:be89:7c1e with SMTP id bj29-20020a0560001e1d00b002c3be897c1emr397247wrb.1.1676492048522;
        Wed, 15 Feb 2023 12:14:08 -0800 (PST)
Received: from ?IPV6:2a01:c23:b9d5:9700:ccee:9a0d:2992:c73? (dynamic-2a01-0c23-b9d5-9700-ccee-9a0d-2992-0c73.c23.pool.telefonica.de. [2a01:c23:b9d5:9700:ccee:9a0d:2992:c73])
        by smtp.googlemail.com with ESMTPSA id k6-20020adfe8c6000000b002c55551e6e9sm9448525wrn.108.2023.02.15.12.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 12:14:08 -0800 (PST)
Message-ID: <b6e4011c-1f87-2329-d043-92df760fc854@gmail.com>
Date:   Wed, 15 Feb 2023 21:13:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: [PATCH 2/2] mmc: meson-gx: use new helpers
 mmc_regulator_set_ocr_vmmc_off/up
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <02b46550-e0b5-4251-8156-56eb0f690d89@gmail.com>
In-Reply-To: <02b46550-e0b5-4251-8156-56eb0f690d89@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Make use of the new helpers to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 641ea4292..740973d35 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -604,8 +604,7 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	 */
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
-		if (!IS_ERR(mmc->supply.vmmc))
-			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+		mmc_regulator_set_ocr_vmmc_off(mmc);
 
 		if (!IS_ERR(mmc->supply.vqmmc) && host->vqmmc_enabled) {
 			regulator_disable(mmc->supply.vqmmc);
@@ -615,8 +614,7 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 
 	case MMC_POWER_UP:
-		if (!IS_ERR(mmc->supply.vmmc))
-			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
+		mmc_regulator_set_ocr_vmmc_up(mmc, ios);
 
 		break;
 
-- 
2.39.1


