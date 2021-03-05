Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AC8C433E0
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Mar 2021 02:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C7564F51
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Mar 2021 02:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhCECpS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Mar 2021 21:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhCECpS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Mar 2021 21:45:18 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7351C061574;
        Thu,  4 Mar 2021 18:45:17 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id x29so345797pgk.6;
        Thu, 04 Mar 2021 18:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=g8rt34v65SckAVlod9EbZTGyuMV5+kTvsDcnd8tRjgU=;
        b=tOemYn6Yb4bld6DjuW0vMzlqxYaUizndWbIcYBb/i9wtLz22AMCFPMi6VASNcCbTLT
         djhSjuYkK6SxyUAOlakqOcGyr/Y4uuUXtwHjuAFryWoBPLZtuYGSQSLpy36zFrIT62qi
         d9UKcGPKe37PjLI5O/tT6qOfmfIhUD7q00Cc3u4/kboGzWxQo1ZCt3r3X1Kaiwe/A+Pj
         daIeO5erPaKyD9pB2hrBhnPl0fUiZUYGuLa7s4+Q4x7c2g/QK4/wE225pfOX7ot7dvlG
         S/onVoVwDswsVvU1xXi/tom1RU27CMw94gntedyodgPLk+e/lw1v5aDVJYT9H9tCGbRa
         uinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=g8rt34v65SckAVlod9EbZTGyuMV5+kTvsDcnd8tRjgU=;
        b=UqjRrFC62mZlfws1mHKrmTn4J8SHZ8L1MEeZ+4eGCTkPJ4NVsbCcMfjQiR3VZaaUPb
         WTJ6JTeysHM0clYA+34VV8ckjBm39LJX3JaMXnTkwrt3YMwUBJ/kxxx/I/Zltit3Lpv3
         4zULyIPp/BXegfIArkqVhvW+26iAR7GeWi3b6vpJBGaGJEodA9OLQYZpcoIDZfq/UJlz
         h3eG+ZHwakyXPsE1gAxpuFC+tLPAq/EHfmv2rjhajtHxK0TjGLL+XKjrXub3YeK9g3Zv
         p8+gz0j8GM7q8MPoyYPTOedYQaQ80ENWL30DsjsIh5hsqVMSBrADUu2UK3I3965oSD6E
         0rbQ==
X-Gm-Message-State: AOAM533XfQwqQd/M8SdgXdvOSbR5frgnzEuQPsHqPhrUaukjZ5VMg21b
        sRDC9XcM7AS4ht+pTYLURYEaVTgQipLRlg==
X-Google-Smtp-Source: ABdhPJyzuSiepiyrAihIqm11oXX8OfcNt4IGL8LC8G8ZjylM0HbjejgsrEC4Df0WrYmJcjDUwB0C2Q==
X-Received: by 2002:a63:4a1a:: with SMTP id x26mr6692573pga.260.1614912316994;
        Thu, 04 Mar 2021 18:45:16 -0800 (PST)
Received: from [10.69.0.62] ([45.135.186.129])
        by smtp.gmail.com with ESMTPSA id h6sm616095pfv.84.2021.03.04.18.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 18:45:16 -0800 (PST)
To:     maximlevitsky@gmail.com, oakad@yahoo.com, ulf.hansson@linaro.org,
        trix@redhat.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] memstick: core: missing error return code in msb_resume()
Message-ID: <473ecf21-f0d3-9024-161e-72093004971f@gmail.com>
Date:   Fri, 5 Mar 2021 10:45:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

My static analysis tool reports that no error return code is assigned in 
error handling code of msb_resume().
However, many other drivers assign error return code in xxx_resume(), 
such as sky2_resume() and e1000_resume().
I wonder whether this is intentional?


Best wishes,
Jia-Ju Bai
