Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5D8C4338F
	for <linux-mmc@archiver.kernel.org>; Sat, 31 Jul 2021 06:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9476A60FE7
	for <linux-mmc@archiver.kernel.org>; Sat, 31 Jul 2021 06:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhGaGg7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 31 Jul 2021 02:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhGaGg7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 31 Jul 2021 02:36:59 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0E5C06175F;
        Fri, 30 Jul 2021 23:36:52 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t21so13625632plr.13;
        Fri, 30 Jul 2021 23:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=wgaZg1d2VQvo5M33uwm7icAweaDqnNdVOHZDjGVcFWg=;
        b=bLU5TlUe+SxHZIB1E4/5xntNAT7SXemPH3hFQiUB99Yfk1RcA8tc7Ri2PfEUTiBTVb
         8seQXyOEXqnccwB/tyb2V8G4cF4/u7GrQZZ/aC0qIxLp2zWPczyb+s5qrkcAAMj8EtiC
         i3FUFJpKUVHXknfaMj7FzOas11u8/kYynKyNAljg7kn8rhnGAuvV86PSBRjIWKKv7cvb
         ZS5TS+URuXa+tcLFSzhTUXzYxrrPKC0tCLt3Sp8Tw44PRlVkVaZ4vnthMTFVaIjmeuCY
         eYZNMYyGtOKwKGeG+lnK2XU17H3uytSu6s05xvy6OAUiu/l9tjTU4ZvzDHAleV3Z2bkG
         0WEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=wgaZg1d2VQvo5M33uwm7icAweaDqnNdVOHZDjGVcFWg=;
        b=AOki4Bei9OiiC93Ke0yhPZpJ/KsZ/ip8O1BEOwDH38C4JRSudb4nS9AlQO+8XpwAAq
         GZ7QBlSZqQfTfshyXcZLKO0bBCPvWgOzMjS7KnZE8R5ghaSnYNDKG37kWZR8SD4ee6uR
         AVDbObeedblZhZbCQbbEY2Bz7pMGQE8EwBzxYavx9j4yRhahGgwKpABJ4e5zwjbah4l9
         mzz0R9b/dHTvndYaDx+aC2qKjy8LDk2dl0GXm6WZ8qxs44r7LXIRGHbHkXommSoV/Id9
         8NRiPkDW32rIpqNAX7JuEPga8MJNq3NPBcAuE8iIiifQEGSrsJpRhu1Jx9meFtsM/PfY
         03Qg==
X-Gm-Message-State: AOAM532u18DtmynCj62YPmwhqf2b1OY695h9hgfMIGhbq8EM6q1fcoWP
        X/34QeLNm9q5JT0nb8jiVPs=
X-Google-Smtp-Source: ABdhPJxteRUzb8j5qAls+d9s8OqzChOXHSAPPYdi4k6gUsE/sDDi0yKE2AOYV+suGMSa74P7zjUXqA==
X-Received: by 2002:a63:da14:: with SMTP id c20mr1854498pgh.155.1627713412165;
        Fri, 30 Jul 2021 23:36:52 -0700 (PDT)
Received: from [10.106.0.50] ([45.135.186.29])
        by smtp.gmail.com with ESMTPSA id n123sm5172962pga.69.2021.07.30.23.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 23:36:51 -0700 (PDT)
To:     maximlevitsky@gmail.com, oakad@yahoo.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com
From:   Li Tuo <islituo@gmail.com>
Subject: [BUG] memstick: rtsx_usb_ms: possible uninitialized-variable access
 in rtsx_usb_ms_issue_cmd()
Message-ID: <e49e0ad5-d09d-4fa7-12a9-0608d9c9d800@gmail.com>
Date:   Sat, 31 Jul 2021 14:36:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello,

Our static analysis tool finds a possible uninitialized-variable access 
in the memstick driver in Linux 5.14.0-rc3:

At the beginning of the function rtsx_usb_ms_issue_cmd(), the variable 
int_reg is not initialized.
If the following condition is true, it remains uninitialized.
469:    if (req->long_data)

However, it is accessed in some statements such as:
491:    if (int_reg & MS_INT_CMDNK)

I am not quite sure whether this possible uninitialized-variable access 
is real and how to fix it if it is real.
Any feedback would be appreciated, thanks!

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>

Best wishes,
Tuo Li
