Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC785C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Nov 2021 19:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EE0563214
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Nov 2021 19:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239710AbhKPTFw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 16 Nov 2021 14:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239514AbhKPTFv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Nov 2021 14:05:51 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB76C061746;
        Tue, 16 Nov 2021 11:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=VW9GTwB+iETakZ3o6Q7V7MbkzHules4LElZukt4Uz8o=; b=yq
        GgxFcqp/t3QC7w0DnW3E0Qxx2K27FuWe+Nu/1qEKfOI9MWl9VMAA5MQxCd3nGyv0WxRMD8TAM/A8Z
        GqFPGGKcSD+aV2aAygTh2JGhj1IAPFnCma1kNjmF6NXNGx7c8fX3Rr+Jk+qaxLqCyf4XxPN0A9tLU
        w28+u+PRMqCgJsV6Cj4L09WpCFvbfTCw/zXU3hggwWbcWe0TqKoOCDyVBxSGWsoYLIyS771CWFbDG
        XfSFf3dXXsN6fbl1KxVSW9rxuvWmYkt0/8/hCQsuNX8kkcKga5n+09nI4C8DGI/Iw/KiLC1IG5y5r
        UWuFDtuka/uiHJf/yTtzHhMyN+/K9D3A==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mn3jG-00031A-Bn; Tue, 16 Nov 2021 19:02:50 +0000
From:   John Keeping <john@metanate.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        John Keeping <john@metanate.com>
Subject: [PATCH 0/2] mmc: dw_mmc: use standard "mmc" alias stem
Date:   Tue, 16 Nov 2021 19:02:42 +0000
Message-Id: <20211116190244.1417591-1-john@metanate.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

dw_mmc uses the device index internally and currently derives this from
a "mshcN" DT alias.  But the standard DT alias used by the MMC core to
assign the device index is "mmcN".

The first patch here creates a function to replace the two sites that do
this mapping so that the second patch can switch to using "mmcN" if
available (falling back to "mshcN" for compatibility if required).

John Keeping (2):
  mmc: dw_mmc: extract ctrl_id lookup to a function
  mmc: dw_mmc: use standard "mmc" alias stem

 drivers/mmc/host/dw_mmc-k3.c |  4 +---
 drivers/mmc/host/dw_mmc.c    | 28 ++++++++++++++++++++++------
 drivers/mmc/host/dw_mmc.h    |  2 ++
 3 files changed, 25 insertions(+), 9 deletions(-)

-- 
2.34.0

