Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C96C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Jun 2022 11:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbiFNLjS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Jun 2022 07:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbiFNLjR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jun 2022 07:39:17 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F67A419AC
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jun 2022 04:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1655206756; x=1686742756;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=237mk2BIhq96XF8iWZ0uz60HefNVAvHEb0ukDsIcCFM=;
  b=ZOBwCJLSapMzAf9msx0KO0A460/vY/h9ERQxIPKXXtvXgne/lMHgRM5I
   Kg+1cD50IeM4ChaDb9z1LMGKaOROgQlSp4JvNGsDtR8QuGqXvpvrOOmz3
   uI52dvR+ntScDlIcEvvfEQtY2gXYyHcf5zNDM5w7P248c4L6WeMuQZlsJ
   NjHWJBOF7x5hj0rLZbR9D7ur/uXpAfK7/dV6pwoRl65v9SYBmjEG58b8y
   AW0+NLuR60Caorf8q59RH3XdfMLBmWa7pNQarPIGzqLRodKvnjdbe6Vog
   WjNJfxy2xuI4Bs815TVJ5c9nomspGM8uCD+SFnJoBoNEjchokoQCWb6MI
   g==;
X-IronPort-AV: E=Sophos;i="5.91,300,1647298800"; 
   d="scan'208";a="24447611"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 14 Jun 2022 13:39:14 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 14 Jun 2022 13:39:14 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 14 Jun 2022 13:39:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1655206754; x=1686742754;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=237mk2BIhq96XF8iWZ0uz60HefNVAvHEb0ukDsIcCFM=;
  b=dQ5jSAwusgrabgAHIATY5EAIWXJlGt8vkjCTiWZDI9WwT2+QhvrKALIz
   62wfu0OReCFXzMRkUjzpi+XDe4UwixNWOGwgSmBTBXWwYBJ7MT9x2S8Pj
   2QO6dScSl3xjRdbc0gNjTO0BdqakxRPxC24Ji1UnJknc+J7BApwtHJVCs
   yTqXtdUmlgnBjrPCaXF+Ha+squIVVV/YHQyPbHN4jzBuJAEyUY/ADjJ9k
   a2mgXjlRqqe00oHZT2bSJAqCfNsmgfYiM+H671xUAWymDeHbtAMrqcStz
   MlHh/h10xV3ba3FnApvUAhAqIEUvZ3FyW9FCHIy7qNW0ZdKQ6HPVHlcST
   w==;
X-IronPort-AV: E=Sophos;i="5.91,300,1647298800"; 
   d="scan'208";a="24447610"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 14 Jun 2022 13:39:14 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 1AA8A280056;
        Tue, 14 Jun 2022 13:39:14 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 1/1] mmc: host: Do not evaluate HS400 capabilities if bus has no MMC capability
Date:   Tue, 14 Jun 2022 13:39:05 +0200
Message-Id: <20220614113905.1458715-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

If 'no-mmc' is set but 'no-mmc-hs400' is not, this warning is raised.
Specifying 'no-mmc' should be enough though.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/mmc/core/host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 2ed2b4d5e5a5..0fd91f749b3a 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -599,7 +599,7 @@ static int mmc_validate_host_caps(struct mmc_host *host)
 	}
 
 	if (caps2 & (MMC_CAP2_HS400_ES | MMC_CAP2_HS400) &&
-	    !(caps & MMC_CAP_8_BIT_DATA)) {
+	    !(caps & MMC_CAP_8_BIT_DATA) && !(caps2 & MMC_CAP2_NO_MMC)) {
 		dev_warn(dev, "drop HS400 support since no 8-bit bus\n");
 		host->caps2 = caps2 & ~MMC_CAP2_HS400_ES & ~MMC_CAP2_HS400;
 	}
-- 
2.25.1

