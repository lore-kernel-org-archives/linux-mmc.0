Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2C6C4321E
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Nov 2021 18:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbhKXStY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhKXStW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Nov 2021 13:49:22 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F208DC061574;
        Wed, 24 Nov 2021 10:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=xdJhRT8gHwOG2GAHSWsFdaRNgcw78JPzju2JYRuISc4=; b=5C
        vNWud1YX5zuJYO41GAoZePSVD0hBMY66VLiNR/FufOmli/Yd6lpBGHYlZVV/XRy5JEkJku/r/uQLJ
        GOLtb8KunPQ8wzsSaSEAKkMgObUhQTxqoOZ0oLNhhwIKMj3AMCNiks0i+5bjzxRy3iv91OZl7MUEO
        52qxgoJMOZNxo1xPpI7Zp3grW/zUPonyfU7ZZgUJDLoNo3l9IiBIyNUB2oXBO7YFMzO4Spy9Hf+24
        U1PgLEFN13nYo53f1PvjzXtAm8F8gC4Yjb2YTJMyo05i8k6HY0bikZyN5SbGmR9UycZYfITHfv0E1
        PVmL7qQXwIpMJ7Y9UTPVH0TholPkJdkA==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mpxHU-00007s-C6; Wed, 24 Nov 2021 18:46:08 +0000
From:   John Keeping <john@metanate.com>
To:     linux-mmc@vger.kernel.org
Cc:     John Keeping <john@metanate.com>, Heiko Stuebner <heiko@sntech.de>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/4] mmc: dw_mmc: start deprecating mshcN aliases
Date:   Wed, 24 Nov 2021 18:45:58 +0000
Message-Id: <20211124184603.3897245-1-john@metanate.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This series is prompted by discussion on a previous patch set [1] but is
a totally different approach and only a partial solution.

With these patches, the dependency on the mshcN alias is totally removed
from dw_mmc-hi3798cv200 and dw_mmc-rockchip and dw_mmc-exynos moves
towards being able to consider the mshcN aliases deprecated.

I haven't changed dw_mci_hi6220_caps here, although it looks like it's
possible to apply MMC_CAP_CMD23 to all controllers there with no change
in behaviour as the final entry is SDIO for which CMD23 is not
applicable IIUC.  But I'm not familiar with that hardware and don't feel
confident making that change.

[1] https://lore.kernel.org/all/20211116190244.1417591-1-john@metanate.com/

John Keeping (4):
  mmc: dw_mmc: add common capabilities to replace caps
  mmc: dw_mmc: hi3798cv200: use common_caps
  mmc: dw_mmc: rockchip: use common_caps
  mmc: dw_mmc: exynos: use common_caps

 drivers/mmc/host/dw_mmc-exynos.c      |  9 +++++----
 drivers/mmc/host/dw_mmc-hi3798cv200.c |  9 +--------
 drivers/mmc/host/dw_mmc-rockchip.c    | 11 +----------
 drivers/mmc/host/dw_mmc.c             |  3 +++
 drivers/mmc/host/dw_mmc.h             |  3 +++
 5 files changed, 13 insertions(+), 22 deletions(-)

-- 
2.34.0

