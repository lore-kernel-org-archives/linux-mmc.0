Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6818C6FA99
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 10:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCLKtT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 06:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjCLKtS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 06:49:18 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D09D41B55
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 03:49:17 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id i20so9781239lja.11
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 03:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678618155;
        h=subject:in-reply-to:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GXEKhZDtuayyLnwYmi1ZaNEFCsCEA/0Tnk/LxoHckJU=;
        b=BZxpb6N1XyvUS8hasD5Cc1a3dR6P4EBNIxNIRAb2y1VxW2AYtmcvZ7860WBNjIxtM/
         O5lFwSFctBPrVWvHExIu0oHXy/KxMacJQ9+1YBqjRilA7MmbecyrxoXN2jn5NaQ6BvKy
         72Cm8JQnnlQgraohcrAPNX6ac3cunh3BYwqDHLYJWNByFC7OOwSP9IyFBJXa5XJMErVx
         5D91vevAdFtHddGT7cD5jaK+R4+xQpVrs5mY6DJf+n4mDUvwK+aJID0z4bMAKQEgh6sm
         kXjIotjZPBUVlkDxG27MylbHMOF34UY/r6/K+o32/EKozNnsZ0117AcFB747aEtuiYvh
         xkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678618155;
        h=subject:in-reply-to:cc:to:from:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GXEKhZDtuayyLnwYmi1ZaNEFCsCEA/0Tnk/LxoHckJU=;
        b=k6HiJXZHnwmBFgrV26bNlLAf8aMjnVGDmchwbPxtxtI/yH/9QuxHEq5n/Gky9Z5llf
         h9IZMJPhkcm/f/0wEK0aFUYjD9kyg2NrH9dUkZG1/yLw3zieFPHj4fDd5PQOAyAWLeS7
         uWUBqdWlZikPmDlBNVldItp5pWspW3i7Ix/isUKyJZLCId6iz0hogCjs0qxyUyKrvjbM
         kJcS3ANNyWW63tnaNmqxpEWreaR+imu1h1CofOXE2BucsU2dVraG4Ew19kZmTWZCdSRI
         xGANRlDD8aGGii5xxPY2x+99SB9cbLhZdt3PRkz+8OPZ/yYi0xZXdqVg0ER5wfpeskmO
         sIUQ==
X-Gm-Message-State: AO0yUKVYBhapTo9LD8PsJL/QFu+9t03Bd9K7UkCip26CUQi1wmT2IHj5
        m3EBkeiQeTPyjVgj0N6PsEF5zC5913l69SPA
X-Google-Smtp-Source: AK7set+Z4ARUn5+Xf3V0j98qMm/VvTZ966oe/wFcUsFT8+etk8i1crAEOSqfTU1YluM9QM78AuZPuw==
X-Received: by 2002:a2e:9243:0:b0:295:aa1f:3d6e with SMTP id v3-20020a2e9243000000b00295aa1f3d6emr8788245ljg.38.1678618155311;
        Sun, 12 Mar 2023 03:49:15 -0700 (PDT)
Received: from letter3.txt (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id a9-20020a2eb549000000b002934d555783sm621484ljn.6.2023.03.12.03.49.14
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 03:49:14 -0700 (PDT)
Message-ID: <640dae2a.2e0a0220.bf40b.1552@mx.google.com>
Date:   Sun, 12 Mar 2023 03:49:14 -0700 (PDT)
From:   Sergey Lisov <sleirsgoevy@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <2edea81f-9ea1-5ede-8539-6aac88621670@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: synopsys-dw-mshc-common: add
 "fifo-access-32bit" property
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> 
> Missing changelog (I did not get cover letter, so no changelog there
> either).
> 

Got it, will fix in the next revision.

> 
> Anyway, I said last time this looks compatible-specific, so I don't
> think we need another property.
> 
> Best regards,
> Krzysztof

I agree, but I'm afraid of introducing regressions by enabling this
workaround on systems that don't actually need it.

