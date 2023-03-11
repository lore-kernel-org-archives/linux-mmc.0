Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4D2C74A44
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Mar 2023 18:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjCKSGg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 11 Mar 2023 13:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCKSGf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Mar 2023 13:06:35 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB26559E2
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 10:06:32 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m6so10736832lfq.5
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 10:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678557991;
        h=subject:cc:to:from:user-agent:mime-version:date:in-reply-to
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0M0jtqvAdY5YLi17aN4+4DCugAJ4kvRlpg9cOQFT1qw=;
        b=Rq/wBpJSHEj0UeMCW1YySuCCWqOCUNhkzN4don2ySzHQI+2wLpq5xHotGsCU5PDxbH
         lPOUxMAR6EnYrY/XK1DSs1Ls1RaUCdc/s9ASOXpaeeX14QRN4GfQpnew53apmkHfW/SU
         j2rLljaxV+UM6gOkWRBn5qxP/X4ivsGxBqRWdYWM8fJlNuDYh2K0zH5+t0tk8XcJTun1
         y+KSkA8AHibO/3AovJ4ldpxp3K5x/uyP53sc013OmrgPWcrFZbszkBS+ZCwwLMOcJLxw
         y2zam2zsVK6SWk+Mq49MrLhhYv0VX8+ho9vUj17nLbbm3dUcTn+Y4AM7cHAWctqlS91l
         HB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678557991;
        h=subject:cc:to:from:user-agent:mime-version:date:in-reply-to
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0M0jtqvAdY5YLi17aN4+4DCugAJ4kvRlpg9cOQFT1qw=;
        b=uyzEJkL8TAFIYfk5omWapP5b3k+NLhgoDf4ULCxMDOlNS/zTtqu9W7Bl4zu1ktHOIk
         UktUGvKyHV5GWN/PTmoTuXFK03OhK/VgSFEVzp0b0t4Yq/chjzGTDf4zc3CyLLgQrVBo
         uwIsDDtlXlO13koa/skhBCduWhymzIVciM2ndsdSeHpUoc0kQ/52He5stYg5uQmW8JmT
         1VMNSlgmo0+ON/Slv9anV+iMH3i04XA3OGkVOSA9lNvngO9chvTrxwDADl45uG014l5G
         LK5kZ+G967mBu/wPKgYqc206fzFnkb8StvIFgEq1BrOHL4rCTVCtKMHnlw79hK+VQtLk
         m/qg==
X-Gm-Message-State: AO0yUKWjTwfwmkuUTljkUK/Cs3B36orrU9AgdT15MJMZT+Em/o27kWZ5
        BqVXnZ2ObnndAo6XsvgRybwxiKkUPNSk2JgrdrI=
X-Google-Smtp-Source: AK7set+uLnZf8IcSQjtMhXkORuIef9YhmqHrye+1DzwnUQpUGK2RPQU3Bzfw2OUvdcedHKJxTDgaLw==
X-Received: by 2002:a19:5514:0:b0:4dd:a66c:6854 with SMTP id n20-20020a195514000000b004dda66c6854mr8513795lfe.25.1678557990977;
        Sat, 11 Mar 2023 10:06:30 -0800 (PST)
Received: from letter2.txt (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id g27-20020ac2539b000000b004d37d647637sm384267lfh.64.2023.03.11.10.06.30
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 10:06:30 -0800 (PST)
Message-ID: <640cc326.c20a0220.2dc43.0e1a@mx.google.com>
In-Reply-To: <4de11c0b-8e09-c3ef-4180-585662386859@linaro.org>
Date:   Sat, 11 Mar 2023 18:57:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Sergey Lisov <sleirsgoevy@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] devicetree: synopsys-dw-mshc-common: add "fifo-access-32bit" property
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> Why did you remove the subject? Please keep the mailing process matching
> mailing lists. It messes with mailboxes, filters and reading process.

Sorry about this, I just wanted to get rid of those X-Something headers and
accidentially deleted this one.

> Yeah, Rob acked it so I will let him to judge this. To me it looks like
> unnecessary fragmentation - this looks like compatible specific, not
> board. Anyway you need to resend to fix all the mailing mess.
> 
> Best regards,
> Krzysztof

Should I resend the whole patchset from scratch, as if nothing happened?
