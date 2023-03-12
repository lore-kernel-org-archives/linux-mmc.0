Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542ABC74A4B
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 11:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjCLL1H (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 07:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjCLL0w (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 07:26:52 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20EA3B649
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 04:26:44 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t11so12272765lfr.1
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 04:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678620402;
        h=subject:in-reply-to:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HEmUoydFZk8zGB/4kLGG/3XvXToT0AP+al834P9gqxo=;
        b=EmpKinIA+JMYBLpyFt530dXaRjgsK3VtvIpR1p4yG8pYdBNRB744sRmn5z4T0vroHq
         njoxrA4ogOn7PjvETt9cFHTmeu2UJAnmutPdM7jU9vj9l23j5cNTxNlHyC1GsvjR0IXm
         wnkfYzy+46SJH+BfJG6o4/58PvksMwslJypP6ojnoWP/mDo0SjjbZ6o6sx5/Y58/+V6+
         bQPQb7VtfSgt/cq4jN22B9TjQMsw8yyxvUzTujNvrMj8kKdTN5hRwEUP/ijBi+0vYM6y
         NIgI6f/73XchYU+PRMrsMLPZFSgN4UKkJMRsKeswMH2vFb0RTiUHko1j5OBjw2lmRfdp
         /BKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678620402;
        h=subject:in-reply-to:cc:to:from:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HEmUoydFZk8zGB/4kLGG/3XvXToT0AP+al834P9gqxo=;
        b=3DTOnv9AK6MjK3lLPDhVuhFNBOdMR2ybWB1SGf0UhFx2vI1WF1ZZJo/pNUW1k9Q2B0
         JeUpa9QWG+medISY3ePPrKhfBX0kfhZ4zCHP15rpZkeYVcfAgtqLoWMp1+5AmR0a1t9E
         L0e7GjfpJVppU+lpI/d171j03G8/raJ7I+nhEexRNArNv8H4GEIzkTSTWCxjC9St/E1Y
         ptIOnTAULOurzwen9pqWC7e1Yv96mhZq59/wSyvjS48u8zKao4n4t5317rrG2EsYQj8y
         B1A9VRBjGxABcpvzKSdS0otHRsA+kbqFKrFCzaWNti0Iqjid6TM74q1Oc73aH7uvpm2V
         ebrg==
X-Gm-Message-State: AO0yUKVXYjl3mpEKRRLAx71bjfma5YzQnK3C/1uyrkBG9FE+C6OImtRK
        Qi7hdkecMDI7hdEaiphBRG2vK1IIT9Wxfnd4
X-Google-Smtp-Source: AK7set8LTcnOj/V3hgC3oclVaB+gjp4uRnwm/4Nj0vEkQHbcI46sFvXvzbNuvlzjjIeLLIOpoZ0LDA==
X-Received: by 2002:ac2:53a8:0:b0:4dd:9a38:1b9c with SMTP id j8-20020ac253a8000000b004dd9a381b9cmr8092649lfh.20.1678620402497;
        Sun, 12 Mar 2023 04:26:42 -0700 (PDT)
Received: from letter4.txt (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id q13-20020ac25a0d000000b004db511ccae6sm617185lfn.294.2023.03.12.04.26.41
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 04:26:42 -0700 (PDT)
Message-ID: <640db6f2.c20a0220.3f148.1685@mx.google.com>
Date:   Sun, 12 Mar 2023 04:26:42 -0700 (PDT)
From:   Sergey Lisov <sleirsgoevy@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <98f28de3-20b6-dd57-0c95-69c31f8bb76c@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: synopsys-dw-mshc-common: add
 "fifo-access-32bit" property
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> There is no way this is board specific. This is SoC specific. I
> mentioned it last time.

The same compatible string ("samsung,exynos7-dw-mshc{,-smu}") is used by
several devices on different Exynos SoCs. And I was only able to find
a vendor kernel fork for one of them (exynos7885-jackpotlte, it has the
workaround, but it depends on a configuration option and I don't have the
config file for that device).

