Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D753C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Oct 2022 11:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJQLc2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Oct 2022 07:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiJQLcM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2022 07:32:12 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655B1FCC
        for <linux-mmc@vger.kernel.org>; Mon, 17 Oct 2022 04:32:11 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c24so10481560pls.9
        for <linux-mmc@vger.kernel.org>; Mon, 17 Oct 2022 04:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A+DqsVsSZrwGiPK8Q8THaG2zSj86jXl6NIBsYIk40YE=;
        b=URgmXOm5FC+6Mrnz3vxmTVUGBDFZRGHJvY6R+7B6fr1cXLop7vkyhRjhJdlnQPmQ0Y
         akIQE1g4xHhpBnkUdqtKnFwEfB+ceU9K9JGvHhIK2AcXBk2acFlCf/+2/i3AEZFocpD0
         LGFQGi4TNkB8rhrvaxQaiMq+zZty/yEjbKfm0cbKAJn5ozmEP0C8On6GVocBJ++NRZfJ
         myAb51XVai67ZbwCYiYWgsuo5hdAsNEwLu40zJrk6g2aZeh/jdWVTP31QLHG0OHentyj
         CmjXJ90fNILGmXYApdAaDk/Ab6KElYPicnJU+HDbQlQT1taDQFZtVinJIkdAd/NoH8ia
         6k2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+DqsVsSZrwGiPK8Q8THaG2zSj86jXl6NIBsYIk40YE=;
        b=yR6nfuLpaBkf19Z0kKYy1vlX+R8Wdx6rXltlxomFEHM64oRyPTQmdjThEXUlgbK7Os
         kzE/ArCZmNaVwFrlZzwKQs4DjsNtV1ln5aOGi/hC1VjnIRy405a4vQYrkDQGiVRTYtzS
         k47zo9CCHWbniBbkMxobEXlg5tHuv/6QKnZPYq+FEsQFGfVI06EAgA+Tdu2FBzLjt00R
         6X8A13eELKpezqOBK9HYg7MRaXysKHQcrisV0slRq5a7zFzG78pQlo+guya1thNO9vXi
         RTKg31MaEYFnqhf0pTYMSliWtDwltlu6ghslvZFESzIvNjzRHeEXB7NzSqT5199r/bNX
         wXFg==
X-Gm-Message-State: ACrzQf0+I2SVj8DDHMai5jiK0tNx6a1ICtk4qaF88/V4T10qLu7PN7GK
        Dx7wzBusR9aHbbQzDitGdHn/pLZaEN45hi4cyP0Gsw==
X-Google-Smtp-Source: AMsMyM4NHP2fiS/biJxWwM6ZSFpdw17ng4fjn9CGlQQ+77X63DlCAKVeXrQwju9xe+DOhH7ZEaWc8gkwVHCGaa9O+KI=
X-Received: by 2002:a17:90a:7b8c:b0:20b:1f3b:f6fd with SMTP id
 z12-20020a17090a7b8c00b0020b1f3bf6fdmr13088890pjc.202.1666006330858; Mon, 17
 Oct 2022 04:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221014114601.15594-1-victor.shih@genesyslogic.com.tw>
In-Reply-To: <20221014114601.15594-1-victor.shih@genesyslogic.com.tw>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Oct 2022 13:31:33 +0200
Message-ID: <CAPDyKFr4je2WhF8oQW1CpQD+2dRZhn+5JB0bLqHjLDTOiao58g@mail.gmail.com>
Subject: Re: [PATCH V5 00/26] Add support UHS-II for GL9755
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Victor,

On Fri, 14 Oct 2022 at 13:47, Victor Shih <victorshihgli@gmail.com> wrote:
>
> Summary
> =======
> These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
>
> About UHS-II, roughly deal with the following three parts:
> 1) A UHS-II detection and initialization:
> - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Sequence
>   [2]).
> - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence[2]).
> - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include Section
>   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting Register
>   Setup Sequence.
>
> 2) Send Legacy SD command through SD-TRAN
> - Encapsulated SD packets are defined in SD-TRAN in order to ensure Legacy SD
>   compatibility and preserve Legacy SD infrastructures (Section 7.1.1 Packet
>   Types and Format Overview[3]).
> - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-II
>   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2]).
>
> 3) UHS-II Interrupt
> - Except for UHS-II error interrupts, most interrupts share the original
>   interrupt registers.
>
> Patch structure
> ===============
> patch#1-#6:  for core
> patch#7-#25: for sdhci
> patch#26:    for GL9755
>
> Changes in v5 (Oct. 14, 2022)
> * rebased to linux-v6.0.

You sent a v5 on Oct 14 and then this one (v5 again) today. Why? What
is the difference?

Moreover, as v6.1-rc1 is now available, my next branch will be based
on that. Can you please rebase the series on top of my next branch -
or at least use the latest available "rc", when you test and submit?

> * according to the guidance and overall architecture provided
>   by Ulf Hansson, Ben Chuang and Jason Lai to implement the
>   UHS-2 Core function based on the patches of the [V4,0/6]
>   Preparations to support SD UHS-II cards[5].
> * according to the guidance and comments provided by
>   Adrian Hunter, Ben Chuang and AKASHI Takahiro to implement
>   the UHS-2 Host function based on the patches of the
>   [RFC,v3.1,00/27] Add support UHS-II for GL9755[4].
> * implement the necessary function to let the UHS-2 Core/Host
>   work properly.
> * fix most of checkpatch warnings/errors
>
> Reference
> =========
> [1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
> [2] SD Host Controller Simplified Specification 4.20
> [3] UHS-II Simplified Addendum 1.02
> [4] https://patchwork.kernel.org/project/linux-mmc/cover/20201106022726.19831-1-takahiro.akashi@linaro.org/
> [5] https://patchwork.kernel.org/project/linux-mmc/cover/20220418115833.10738-1-jasonlai.genesyslogic@gmail.com/

Another general question, I assume you intend to move this forward
instead of Jason Lai, right?

Kind regards
Uffe
