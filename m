Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EE4C6FD1F
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 11:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjCLLsi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 07:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjCLLsh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 07:48:37 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C82C24BDA
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 04:48:36 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d36so12279140lfv.8
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 04:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678621714;
        h=subject:in-reply-to:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iGGE51YjPiREb0P31xa6FciLF3LLNAYLO3pthF/8pcE=;
        b=iaSylqA7i0IR2cJxbEyyQ5U1GoYqkbZQC+/Vui1Fi6kxMLmFO1JsrSkToPk61cwEUl
         u6ijfhE7iNUzX6nCT4u3MGCw6wd84ldIiy5VuZsDIOkXkYDBVxElv5YR/MHNNUpV+gwq
         LmnznexXbTIojI1EhTdRxEXkZw6yYTiplKTsnEnRiXjsVY9xJ1nffZ7X9cYvCB/2MehH
         OJ8oiBpI9roySst0lNCwfV39oLXh0ncycQRtrySbzNGsl0S8DdkDObg56w1dspZ+yL04
         Ol4iAm/Wl9ZIIN1bsxmr3PvzFZyfwuzgPhMtqwlp7dAilgYacRqK4hfOAHZKaCErYJFl
         ULSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678621714;
        h=subject:in-reply-to:cc:to:from:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iGGE51YjPiREb0P31xa6FciLF3LLNAYLO3pthF/8pcE=;
        b=oWKR7EsMX4DmMGGdZB5uVSqJy17BPce+p/iY8oZXen7fPwYjYc03G9T2NmPMlEEA5h
         tJsUcnLnRpQjNutfS1hxGX5wW44EVRuuPiPW7M1/JirxH9ekxBMRAUPYHaYU0cYqGzxJ
         cOpXtbEhUJMiASgShzRryny+eQjwvEXO9ox1OF0ld38W19KohSKIT6BKSWspDZ+aQf5o
         3Wd8B3tdgmXUXHvTt71C2UfV0Qpxry7tXIn5Yb+LTsaA7OG6sFPCk3fWS7Bi9s0Tf2cQ
         Azc498w2aRLoiWwV4lnZBxBnvDELFT8BbDGlMoZMJLoWDPt29r458o8XRZL2TvCJ1v5E
         zfQw==
X-Gm-Message-State: AO0yUKVVNSwGm50RDG9+uEWZbwQX+O2Ewo33K4snIKeuaH4Mkl1I0akx
        8ufkzICnMRYpLTHpapcNjf1sBXGZHMnygKy2
X-Google-Smtp-Source: AK7set+5oLLKshvfLwAqVear3BgrrXkCVr2XDJRb9ilrw0lPfG7k6y+cFd5mmvgL6oVPZMpF0/0N9w==
X-Received: by 2002:ac2:54a6:0:b0:4dc:841e:55f with SMTP id w6-20020ac254a6000000b004dc841e055fmr8708884lfk.43.1678621714266;
        Sun, 12 Mar 2023 04:48:34 -0700 (PDT)
Received: from letter5.txt (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id z25-20020ac25df9000000b004d576298c89sm621596lfq.141.2023.03.12.04.48.33
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 04:48:33 -0700 (PDT)
Message-ID: <640dbc11.c20a0220.d7aba.1818@mx.google.com>
Date:   Sun, 12 Mar 2023 04:48:33 -0700 (PDT)
From:   Sergey Lisov <sleirsgoevy@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <951dec3a-1a3e-6d17-20fb-9e5915606c40@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: synopsys-dw-mshc-common: add
 "fifo-access-32bit" property
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> ... and should not be. It should come with a specific compatible
> followed by this fallback. The specific compatible then will define
> 32-bit access.

OK, I'll then make a new revision with this baked into a compatible
string.

