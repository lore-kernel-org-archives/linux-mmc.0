Return-Path: <SRS0=92ZL=3Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8BEC2D0B1
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6F721744
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 08:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sO1kZFmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgBDIzJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Feb 2020 03:55:09 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:42593 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgBDIzI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Feb 2020 03:55:08 -0500
Received: by mail-lj1-f178.google.com with SMTP id d10so17652781ljl.9
        for <linux-mmc@vger.kernel.org>; Tue, 04 Feb 2020 00:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y2N8JVgylePVorUFC9TPMnWSgeFKeUnkL2yRNJBh1UY=;
        b=sO1kZFmViA4D6F0bnh91onpkyvI7idKixOSd9TTma45hG6Hprh+JxZVPFMYr6IZ+lv
         44Q9XY2sFOyBx48WhdeJ7KLHr8CFAno2OQC9006OZlTlb3OBFgOfHwjQDts/DSOUO1bW
         nbFE1xZHMYgFtirP5fqFJLuaZjtISOSFeVYo6F/JBniNu7R/fPKNGeXteD8wCK1mbdQY
         yum5/svuqS6Mazkss2M4XHIeLd5QsVqcPXCoxtaQqfTrbBRQj3pgAKfNAQWb0pqXIP6j
         VqJNAS4Ag3vMK47VAWfjQHiBPaW50CBo4wDanBKoN/RoTRHBv5ikX6AkUURqiaeljhsw
         Fxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y2N8JVgylePVorUFC9TPMnWSgeFKeUnkL2yRNJBh1UY=;
        b=FwSyrdR4f4gJ7L1rDZCEHhrxa310ihPtwzDprXFi0HIRUyvSU3pKHj+xvAnxmcv/yo
         2s0O1dNjI+KXPZ+ef44FNoeDEQP5NnYegscHJ8J3geJIS840p8b0/ck8ilBwqFu8VRCs
         BY4EfNPG/lEifrLmB4neJ7EIfmdk2o36HLWzHAx2ToS5Q2z46JNxSFrH+CMc5sV5Huql
         2Vl7haPBFOXVoyyUa93uxrkwwhwfF0zI3MpWqhDHb5XPhJJYulGy3Vfm2tMW3gGE5+8T
         GoMjwvJpZKeeScnVV6nproawc2k5re0Pc9eferoU2U0DZwlimBmBmbQssK77yWjQMTxH
         XThg==
X-Gm-Message-State: APjAAAULcc9aa6Pg2ZyR8rHT7OYysmll6nXL86cCX47aRdmkYKxdhM5O
        ZLgvZRAQd/gfjNDGB/NmLE7KvO5SMFg=
X-Google-Smtp-Source: APXvYqwW2HAosr8IZgG1ml4U7boi5Cj9pUyAJeTegrmkpGf64PVkr5AQMKlY9skrePTQ2tgCRQa67A==
X-Received: by 2002:a2e:808a:: with SMTP id i10mr16668342ljg.151.1580806506609;
        Tue, 04 Feb 2020 00:55:06 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id n2sm11156283ljj.1.2020.02.04.00.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 00:55:05 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, mirq-linux@rere.qmqm.pl
Subject: [PATCH 00/12] mmc: core: Improve code for polling and HW busy detect
Date:   Tue,  4 Feb 2020 09:54:37 +0100
Message-Id: <20200204085449.32585-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

There exists several separate variants of polling loops, used to detect when
the card stop signals busy for various operations, in the mmc core. All of them
have different issues that needs to be fixed.

The intent with this series, is to address some of these problems, via first
improving the mmc_poll_for_busy() function, then consolidate code by moving
more users to it.

While I was working on this, I stumbled over some code here and there, that
deserved some cleanup, hence I also folded in a couple of patches for this.

So far, I have only managed to extensively test the updated mmc_poll_for_busy()
function for CMD6 commands. Some tests for erase/trim/discard and for
HPI+sanitize are needed.

Note that, there are still separate polling loops in the mmc block layer, but
moving that to mmc_poll_for_busy() involves some additional work. I am looking
into that as a next step.

Please help review and test!

Kind regards
Ulf Hansson


Ulf Hansson (12):
  mmc: core: Throttle polling rate for CMD6
  mmc: core: Drop unused define
  mmc: core: Extend mmc_switch_status() to rid of __mmc_switch_status()
  mmc: core: Drop redundant in-parameter to __mmc_switch()
  mmc: core: Split up mmc_poll_for_busy()
  mmc: core: Enable re-use of mmc_blk_in_tran_state()
  mmc: core: Update CMD13 busy check for CMD6 commands
  mmc: core: Convert to mmc_poll_for_busy() for erase/trim/discard
  mmc: core: Drop redundant out-parameter to mmc_send_hpi_cmd()
  mmc: core: Convert to mmc_poll_for_busy() for HPI commands
  mmc: core: Fixup support for HW busy detection for HPI commands
  mmc: core: Re-work the error path for the eMMC sanitize command

 drivers/mmc/core/block.c   |  55 +++++--------
 drivers/mmc/core/core.c    |  53 +------------
 drivers/mmc/core/mmc.c     |  38 ++++-----
 drivers/mmc/core/mmc_ops.c | 159 ++++++++++++++++++++++---------------
 drivers/mmc/core/mmc_ops.h |  13 ++-
 include/linux/mmc/core.h   |   3 -
 include/linux/mmc/mmc.h    |  10 +++
 7 files changed, 157 insertions(+), 174 deletions(-)

-- 
2.17.1

