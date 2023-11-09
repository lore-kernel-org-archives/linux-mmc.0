Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64740C4167B
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Nov 2023 19:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjKITXj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Nov 2023 14:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjKITXi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Nov 2023 14:23:38 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD043C14
        for <linux-mmc@vger.kernel.org>; Thu,  9 Nov 2023 11:23:36 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-586ae6edf77so625670eaf.1
        for <linux-mmc@vger.kernel.org>; Thu, 09 Nov 2023 11:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699557815; x=1700162615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sRAqYuB0dg8aj3hzHIpJepiAoEm2PXVbN9qEZ/M71EI=;
        b=hbr5jFeZMz7F5npMFQXrn9L5wmB6WDnE9zp06lFKPQxgOWBNv2tBbgqcL1nbq+3SQH
         6cLEveWTTrVzaW+n1qPrk1A+Qi4I4KYXJzDVuTX7bLbvzRq2e6DHrZB7Do/VCT9Mo7mC
         A03oV82r769lxEyB2CpY1vzhfUr16D6Sma5Yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699557815; x=1700162615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sRAqYuB0dg8aj3hzHIpJepiAoEm2PXVbN9qEZ/M71EI=;
        b=ieo2YF55oJlJkgzXAVWLPh1j5hemKnHeALB251UYIdQMp+y6jYtdyzJ5/WQ+UorueC
         i7ETevFNbIng/JNN2yYIt/hdbuRJ5nYSqWG1NR9Zdo0hjGFOi3dav6erZTA3MDQYHTqe
         rOA0SnCd3XuHJ8IWThTgEofLpBMHTSjjDNRZk9pF5Om3GfKN5Sg1Mz3fz1NnLbqdSJqT
         F0a77108exHcX2lV3oI5JqXPYt/TGe+kopA6ad9oRb3YVjgwp8PV7zY2n5+fCu739i9I
         rrSRGwa0nHP6Zc6VDASpF/b1nLGbCIZgCaJTOH7U1mAgpILA/EZSwr/ihzMxTBIQJsN+
         szyg==
X-Gm-Message-State: AOJu0YxA2A25btaTYlxzhwHfBxLM94Nmr91wZHoQ68tJ179L0GvFViud
        Odk4gcKe2PmKKoc106i+xFQiUpZMwbaKsfil0SEa4g==
X-Google-Smtp-Source: AGHT+IElWKoMKHdAlMoMtEggmOnAEElUpDh1SA3LH7KO/ccsuakHXzsbTWI4PgviyHpL9Uc/hBfRqd53PH0BSNOKegU=
X-Received: by 2002:a4a:e1af:0:b0:581:f6b9:30d9 with SMTP id
 15-20020a4ae1af000000b00581f6b930d9mr5515579ooy.8.1699557815445; Thu, 09 Nov
 2023 11:23:35 -0800 (PST)
MIME-Version: 1.0
References: <20231109111934.4172565-1-korneld@chromium.org>
In-Reply-To: <20231109111934.4172565-1-korneld@chromium.org>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Thu, 9 Nov 2023 14:23:24 -0500
Message-ID: <CAG-rBijDzoCvNTVMTBP5hwSk6sZ4rZ0QKDzHL-jq-GtP1zr8Eg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Disable LPM during initialization
To:     =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jason Lai <jasonlai.genesyslogic@gmail.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <skardach@google.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Copypasta issue, I really meant to write:

+ /* Bring to consistent runtime suspended state with LPM negotiation enabled */
+ gl9763e_set_low_power_negotiation(slot, true);
+ pm_runtime_set_suspended(dev);
