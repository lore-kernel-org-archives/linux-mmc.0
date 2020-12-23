Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CB7C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Dec 2020 09:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46449207CD
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Dec 2020 09:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgLWJNz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Dec 2020 04:13:55 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.25]:11778 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbgLWJNz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Dec 2020 04:13:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1608714603;
        s=strato-dkim-0002; d=goldelico.com;
        h=Message-Id:Date:Subject:Cc:To:From:From:Subject:Sender;
        bh=/7waLQuVIPjLSu88Jl0tYw8XTevZYh4mXe3kIEp/qeY=;
        b=HBc1lk5pp/Gj9qkGz74XkJZBSw08C+GHw1RsC8KBfsiaHgmRWC6rBiyjZ+pZPBq1vy
        OcCiGWBDK0P3Y4ZDM3GnqJgKR5tMFlhJDPE4i2hI9iUY4erKp4TikO4dQdXWp/kQMPkm
        kJygucm0CVOjgeauzffiHaVb2x7WlyouZXANeJEUoXPvSM5YNR9EvAW9ZKBmCSHuYxE6
        tlVg++j0HXIHaHwS+IIR5Lrx1BUaGkQ+iijLBb5XO6tyFi1aws/ojnMLizitvnNi0Txs
        c5Bl8wUovEE7y3+1xhAtSYlK5KyuOaABvVjrXe//HMRzHy0FLTHshoq8ZRjfpR3z8X2q
        cjQw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXH7FjJ5/fxd"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 47.10.6 DYNA|AUTH)
        with ESMTPSA id U05a81wBN91p1Lt
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 23 Dec 2020 10:01:51 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org
Subject: [PATCH 0/2] mmc: remove unused struct component card_detect_irq
Date:   Wed, 23 Dec 2020 10:01:49 +0100
Message-Id: <cover.1608714110.git.hns@goldelico.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

card_detect_irq is not used anymore since v4.1.
Remove it.

H. Nikolaus Schaller (2):
  mmc: jz4740: remove unused struct component card_detect_irq
  mmc: omap: remove unused struct component card_detect_irq

 drivers/mmc/host/jz4740_mmc.c          | 1 -
 include/linux/platform_data/mmc-omap.h | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

-- 
2.26.2

