Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D427DC433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 22 Feb 2022 03:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbiBVDkK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 21 Feb 2022 22:40:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiBVDkJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Feb 2022 22:40:09 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8367C240B8
        for <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2022 19:39:44 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id q8-20020a17090a178800b001bc299b8de1so1188649pja.1
        for <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2022 19:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5LCsouhYwXYMZRgVmQxTSbrYoJrn+h7DhITJVlJqQYQ=;
        b=dvfh0IQvSVRt+fr4Ot2xQ6hp3beItgq4POBs6lOUTQF+imun59mCLMXhyRXQ8mg4+c
         EHFd8nNqKg/PtfLYXI4qnFE5fB8OaLd5kaddwIeVkryus6js+i8K4A+nKLtBCTDFyDk8
         qBzWGG0E6TraJOPSAv9IvwcmJ12ixGwnEgyRxl3bc/QjUI/r18rQcnb5RJ5zo2M8skw9
         t3Gb85m0l4cz1tk3h/JKNAkQjKigOz0CrPTzXVxWwz9+w3Df8yYgANKVaKJWA/7s7pja
         2NbHd8cR/270VhM9f1gJnTOUqwnQgF71FvoFcNp4eStwd9UCWmDUE761ZeV3Jv39wtLi
         d00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5LCsouhYwXYMZRgVmQxTSbrYoJrn+h7DhITJVlJqQYQ=;
        b=eBhbdaBv2WXVAUdRQ0nrSP+iW+Qz4+Xx22E7unVNBegeq7XNSkMNv8kUKZ2IWQ3l8E
         qG1WVre73mxI1RWKCfqFJnqO2UWFoM7PRO2EOO1ZNqKk68/FBvfMZ82zDPrt+UF2xawf
         0OnZpvgw8wNLYkk1NHL345qK5NzUvRJ4pG30yh/fuSDvz0imAvOOHU2+tSC2VOaSRJuW
         VVNJmKO8qDKr+xTVho/Zw+BLqcf8daz7/o7BWGBbugOooWH+cI4DO/fyyFt+/Rsh5Dkj
         YcGQuSb02iEJMYsP0WrbaP6JHGP9a3lhPdGnVbSF74WUK1a9WvNEIIBN70AU+CmTRF45
         62GQ==
X-Gm-Message-State: AOAM532oeUT8JoLCsIN+XZTKu3AVMLdU9s1rUJvZZEtelRMUXPQXhlxn
        6tivpvgsJXYhkuiTo2+8tSI=
X-Google-Smtp-Source: ABdhPJyfRTO0nAxb4SQkkiyJmsVEf6TuuEDSMMkxtdzBhIgON/90hHVOleM0XgdldhGURmugS1k/Sg==
X-Received: by 2002:a17:90a:bb0e:b0:1b9:fffa:f030 with SMTP id u14-20020a17090abb0e00b001b9fffaf030mr2062569pjr.206.1645501183948;
        Mon, 21 Feb 2022 19:39:43 -0800 (PST)
Received: from localhost.localdomain (220-128-190-163.hinet-ip.hinet.net. [220.128.190.163])
        by smtp.gmail.com with ESMTPSA id ng16sm703542pjb.12.2022.02.21.19.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 19:39:43 -0800 (PST)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, takahiro.akashi@linaro.org,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, dlunev@chromium.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogic.com.tw, otis.wu@genesyslogic.com.tw,
        jasonlai.genesyslogic@gmail.com
Subject: [PATCH V3 0/7] Preparations to support SD UHS-II cards
Date:   Tue, 22 Feb 2022 11:39:24 +0800
Message-Id: <20220222033931.237638-1-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Jason Lai <jason.lai@genesyslogic.com.tw>

Series [1] that has been posted by Ulf Hansson which provided some guidance
and an overall structure.

Series [2] focused on UHS-II card control side to address Ulf's intention
regarding to "modularising" sd_uhs2.c.

Series [3] is based on series [2] and adopt most of Ulf's comments.

This series is the successor version of post [3], which is base on Ulf's "next" branch 2022/02/14):
1. Modify settings in uhs2_config_write().
2. Fix some compilation errors.
3. Fix some warnings and errors when executing checkpatch.pl.

Kind regards
Jason Lai

[1]
https://patchwork.kernel.org/project/linux-mmc/list/?series=438509

[2]
https://patchwork.kernel.org/project/linux-mmc/list/?series=589827

[3]
https://patchwork.kernel.org/project/linux-mmc/list/?series=606241

Jason Lai (3):
  mmc: add UHS-II related definitions in headers
  mmc: Implement content of UHS-II card initialization functions
  mmc: core: Support UHS-II card access

Ulf Hansson (4):
  mmc: core: Cleanup printing of speed mode at card insertion
  mmc: core: Prepare to support SD UHS-II cards
  mmc: core: Announce successful insertion of an SD UHS-II card
  mmc: core: Extend support for mmc regulators with a vqmmc2

 drivers/mmc/core/Makefile    |    2 +-
 drivers/mmc/core/bus.c       |   38 +-
 drivers/mmc/core/core.c      |   43 +-
 drivers/mmc/core/core.h      |    1 +
 drivers/mmc/core/host.h      |    4 +
 drivers/mmc/core/regulator.c |   34 ++
 drivers/mmc/core/sd_uhs2.c   | 1088 ++++++++++++++++++++++++++++++++++
 drivers/mmc/core/sd_uhs2.h   |   16 +
 include/linux/mmc/card.h     |   35 ++
 include/linux/mmc/core.h     |    6 +
 include/linux/mmc/host.h     |   69 +++
 include/linux/mmc/sd_uhs2.h  |  198 +++++++
 12 files changed, 1514 insertions(+), 20 deletions(-)
 create mode 100644 drivers/mmc/core/sd_uhs2.c
 create mode 100644 drivers/mmc/core/sd_uhs2.h
 create mode 100644 include/linux/mmc/sd_uhs2.h

-- 
2.35.1

