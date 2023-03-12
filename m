Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD245C6FA99
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 17:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjCLR0N (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 13:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCLR0M (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 13:26:12 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA571BF6
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 10:26:11 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g17so12913655lfv.4
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 10:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678641969;
        h=subject:in-reply-to:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JtCwiValjsr2h1P8SRv71t+eIe5q6n+42gVTAnSj95M=;
        b=LVcozA24vPbLa7YPtRL0oCp1xqOCwEuPQbPBDrWYNRhH47Iy4ne+VUETTqBhOtVYeO
         8SMf1eyG9g2skIkkZzx7HFSBGAIduQhdPafgH0aJyYkqcM84AINKX2+B9J1kYEi79XAR
         s6EmN4ItP6gpOdX39rq9VGf4sFMP9H+51K5kkIeZsE9qjHXDIVd5j6tkt+0Y3Z/O5Ghq
         hLKPGef7gLZNMtZSEpIePXLSw+4Z0N2LRDUXFab93dkk0wDoZ5iXG6FSJnu6HPuzfRf0
         B/YeNIWFhAXxKflJnMIEZqPby/HTIOY9von2CxEL1gSo3X1//MFrVWBs9DJ2BcJNPbPp
         NkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678641969;
        h=subject:in-reply-to:cc:to:from:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JtCwiValjsr2h1P8SRv71t+eIe5q6n+42gVTAnSj95M=;
        b=Cdr7Ecw5soMH9SldKJRYI4oz0P0oLoc6m+QD+DG5BFXhlhL85SsGmuzmOU2MbZ2u9t
         tmeWV40yC4ZSp59Qsh23xDEvzFBre1pAM4NtOI5mhTBLirkjfYbRmOQEMg59uwsAPF9B
         Vth4Hv2P+hQPVOAS9R7pKu4HwKvUYp+TGDp4xrmZWEuAmY8gfH1DEJeY6aXiixPyuyOh
         eNxlUD/75ZGL92KoZA9ZgRVWcia01RL6/x/h3nNDIv1rzDGtcBEky5XtmSxm3KNBMMGm
         /QtptevnHgdPQ1fDZHL3BzuNuhNlPcy/oFeE38FbPKFGwdQxb9Q5phWe8jbtuM1ZV43R
         8elw==
X-Gm-Message-State: AO0yUKUluKXXIXuIYKbPXWvHYgZFInGaAufrHWOXNhGlM/iCIWnqNTb+
        VJadp9SbRTZNHDOgtklXC0Hrs0VHZquRT2lV
X-Google-Smtp-Source: AK7set88XksRMxMLN1s9qahkeU4RVknlpW6noGTptFyhNIOBV0iG+SXYkYwVWodI1A3r1uqQdkothQ==
X-Received: by 2002:ac2:5196:0:b0:4dc:807a:d144 with SMTP id u22-20020ac25196000000b004dc807ad144mr9906751lfi.39.1678641969308;
        Sun, 12 Mar 2023 10:26:09 -0700 (PDT)
Received: from letter7.txt (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id g27-20020ac2539b000000b004d37d647637sm705650lfh.64.2023.03.12.10.26.08
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 10:26:08 -0700 (PDT)
Message-ID: <640e0b30.c20a0220.2dc43.19b0@mx.google.com>
Date:   Sun, 12 Mar 2023 10:26:08 -0700 (PDT)
From:   Sergey Lisov <sleirsgoevy@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <f34ba6e5-4a8d-0812-c334-ea47de7b1d21@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: exynos-dw-mshc-common: add exynos78xx
 variants
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> Thanks for letting me know.
> 
> https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42

OK, at least its codified somewhere. Still, this results in the opposite
effect: DTBs written for one SoC, using compatibles from other SoCs just
because "they are the same anyway". And doing this properly, well, results
in essentially duplicate compatibles.

And "fallback compatibles" won't solve this case anyway, as there is no
common compatible that denotes "Exynos7 DW-MMC that has the bug".

>>> That's non-bisectable change (also breaking other users of DTS), so you
>>> need to explain in commit msg rationale - devices were never compatible
>>> and using exynos7 does not work in certain cases.

Probably it makes sense to put this patch after the actual implementation,
so that git bisect always gives a working setup.

> BTW, this rationale was only example - you need to come with something real.

Pretty much the only thing that is broken are SDIO cards, because they run
very short transfers (below the DMA threshold) over the data lines. That's
exactly what I stated.

