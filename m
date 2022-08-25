Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73683ECAA2B
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Aug 2022 19:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241208AbiHYTw4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 25 Aug 2022 15:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240740AbiHYTwz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Aug 2022 15:52:55 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5951DA0268
        for <linux-mmc@vger.kernel.org>; Thu, 25 Aug 2022 12:52:54 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z2so27475490edc.1
        for <linux-mmc@vger.kernel.org>; Thu, 25 Aug 2022 12:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=YZ/i2GUAQi2cQp6QrxSxxAPIHVo7GpOuEoWXlrwJRxY=;
        b=OpnTNk5d2dPsoFZnsZOT1TqDoRjrlgAZCStMnSYVsRUqyrBBiT2dzSepu6hGOojLnV
         eg6y6uXBcMCTEqCQt15zltzYoNiuCG2ECefqLnjoSm1pfkjx/WF/ebrJr0Xl1KETflDR
         3vwN4N3GCbx1Gyr6vglwN3KwaUBpilXbgN7+iLaONCFORrjz41nf4t0Bgk+HBr8FjEdY
         vGi4Tny5/9QzH7FBrSQ6fuQkaVjUFOddkXrS5QGltgKS/uQZu9M+gGiPq3G42XAKstPt
         +t2y91Yk6koVd9hIpcbRmUTkjR8TG8eKKG/SDSRy5RjqaOKRP98OGsi3PfFp8wMwjcs9
         MdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=YZ/i2GUAQi2cQp6QrxSxxAPIHVo7GpOuEoWXlrwJRxY=;
        b=Hy8nc7bG3Hsqh4DGZqfe++IpB7L9Q0YRSDEs5ztYY7hjbE7urTL0l5cQCgai6BpspO
         e6yCplcJBuZ+LKY7TnyOhPGIjpI73iDtqQunstwXOaCWL5X4ZahdATkjnMLuhgq+Fm46
         8+rokH6RwXPxjG7Rbux3YkFmRUC5rZogxa6RrEjtKuXX5t0ViX1j3GEhbePYS8H1WAGM
         W/Pi0HzTSJa96RhRRohsbIw9a2X11IJTaiMVFc1weaW26K3C0nDUAt+K756p5FM5J1ns
         uhfQmKHertIK//Hn5lA7Tp49qKKP3WXAk4aemmiqWjP3j1I5zx4tsU2ZNEeXZNWD8iMi
         t+uw==
X-Gm-Message-State: ACgBeo2GWKpOkYt5+EIwkHoiIOTfs9eduqYsmH9KmRzc7Y7jXlg/jB+B
        MALWABE4oj2R6QlF9BIRvCs=
X-Google-Smtp-Source: AA6agR6tuGauKOsJtiyebBmulfuqN52pYGFT+djQK1Yv/m4LtmSjaFjTL6JXKp90u8V9lkuKrEJ0sg==
X-Received: by 2002:a05:6402:3711:b0:445:e264:beed with SMTP id ek17-20020a056402371100b00445e264beedmr4408738edb.136.1661457172856;
        Thu, 25 Aug 2022 12:52:52 -0700 (PDT)
Received: from ?IPV6:2a01:c22:72a6:5f00:b844:7c7d:e964:bb65? (dynamic-2a01-0c22-72a6-5f00-b844-7c7d-e964-bb65.c22.pool.telefonica.de. [2a01:c22:72a6:5f00:b844:7c7d:e964:bb65])
        by smtp.googlemail.com with ESMTPSA id p17-20020a50cd91000000b004479cec6496sm170461edi.75.2022.08.25.12.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 12:52:52 -0700 (PDT)
Message-ID: <72459a46-fd20-60d8-a7e7-076d8f321816@gmail.com>
Date:   Thu, 25 Aug 2022 21:52:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v3 0/2] mmc: meson-gx: add SDIO interrupt support
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add SDIO interrupt support. Successfully tested on a S905X4-based
system (V3 register layout) with a BRCM4334 SDIO wifi module
(brcmfmac driver).

v2:
- use new SDIO interrupt API
v3:
- don't duplicate checking mmc->sdio_irq_pending

Heiner Kallweit (2):
  mmc: meson: adjust and re-use constant IRQ_EN_MASK
  mmc: meson-gx: add SDIO interrupt support

 drivers/mmc/host/meson-gx-mmc.c | 84 +++++++++++++++++++++++++--------
 1 file changed, 65 insertions(+), 19 deletions(-)

-- 
2.37.2

