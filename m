Return-Path: <SRS0=vd7C=2A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E69C00454
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 20:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA72C2077B
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 20:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BiS1cDh+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfLJUAe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:00:34 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44551 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfLJUAd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2019 15:00:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so21512019wrm.11;
        Tue, 10 Dec 2019 12:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+xeCGefpGQy2sjgNGOl+Y50d//RwjlVI7sRbqcHrAp4=;
        b=BiS1cDh+P9bCWW2ka7NcIQDHU99Kn5O7ZAiRBjLegvHkYyubb9sankMnNyOIadKGtj
         sipBJHj72DaqrBpuSGE2i1gnbMh+2SPZWmzWWn7kvwwtXAftCIp+/Dy0TFdbAPNB3nap
         uz0VMQlUU5KpSY0lSU8FRmcC9eL2PfqFKvV4GMf/TaUxKkF7km3Z/NqrhCLSVeittWVO
         C890+Y3XjK2L1aa5Lr40eSOdznCUEt7P4HhBWwNRcK/wziGaudjuvXmARbN6ukznGH3y
         9MjTcMUFVHBhu4uWmjeD0UgYLDKKM0txxMrfChn8EjPe5YgrrI+D1xsL6q4kmV95R0mT
         XQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+xeCGefpGQy2sjgNGOl+Y50d//RwjlVI7sRbqcHrAp4=;
        b=I1TNV5wFx7nHjzxdU85PMM8f1eH78WBrFkrfCUN9DEkiL+00jiete0QlwCio7LJerO
         8udowyHpZVC+Z4EWpZPTlBmbuaX2Gyod/8nyc20iaUt1pyU9H8MsaK68BeC8xUedLZUL
         pgLon5TliCh6k0rBlt3o0v/f0pZPKmEeq3Ycsrent/5BGS7CBKZQMU2ffQd2nqS/SyX6
         sn9C9XEk7HpoXrGG8bG6PeWEecHnRzjv4EQ5n1AO/ueTSNsRWIYJRqJspLM3BahYldOb
         BY/6PQeFqwNsss2TpJCvIIEndwRrVhOqHEXN7EzULPfjfUoJ/uqkRJUTaw1nAa0MjO6V
         lyug==
X-Gm-Message-State: APjAAAVu8gxpz//kpvKVJAYxmChiEatua0XORFuyYqiSLC0Eh3dAqySS
        MitMj+6kEFQ1q/lH5vGgkV0=
X-Google-Smtp-Source: APXvYqzpu8OOo+U+YwFj7SHZFDBR48BOqfZIl7wVK/FMuNySRzX9p5e7U6/uTahIjSPirfINT95Mrw==
X-Received: by 2002:adf:9c8f:: with SMTP id d15mr1530407wre.390.1576008031386;
        Tue, 10 Dec 2019 12:00:31 -0800 (PST)
Received: from localhost.localdomain (p200300F1371AD700428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371a:d700:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id t81sm4428610wmg.6.2019.12.10.12.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 12:00:30 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc:     robh+dt@kernel.org, jianxin.pan@amlogic.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lnykww@gmail.com, yinxin_1989@aliyun.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 0/2] Amlogic 32-bit Meson SoC SDHC MMC controller driver
Date:   Tue, 10 Dec 2019 21:00:20 +0100
Message-Id: <20191210200022.29696-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello,

this is the first non-RFC version of the driver for the Amlogic "SDHC"
MMC controller found on Meson6, Meson8, Meson8b and Meson8m2 SoCs.

The public S805 (Meson8b) datasheet has some documentation starting on
page 74: [0]

It's performance is still not as good as the driver from Amlogic's 3.10
kernel, but it does not corrupt data anymore (as RFC v1 did).

Special thanks to the people who supported me off-list - you are
amazing and deserve to be mentioned here:
- Xin Yin who helped me fix two more write corruption problems. I am
  hoping that he will reply with Reviewed-by, Tested-by and Bug-fixed-by
- Jianxin Pan for sharing some of the internal workings of this MMC
  controller with me
- Wei Wang for spotting the initial write corruption problem and helping
  test this driver on his board. I have his permission to add his
  Tested-by (off-list, he's Cc'ed so if there's any problem he can speak
  up)


Changes since v2 at [2]:
- rebased on top of v5.5-rc1
- added Rob's and Xin Yin's Reviewed-by and Tested-by (thank you!)
- (note: Kevin had v2 of this series in -next for a few days so the
   build test robots could play with it. I haven't received any negative
   feedback in that time)

Changes since RFC v1 at [1]:
- don't set MESON_SDHC_MISC_MANUAL_STOP to fix one of three write
  corruption problems. the out-of-tree 3.10 "reference" driver doesn't
  set it either
- check against data->flags instead of cmd->flags when testing for
  MMC_DATA_WRITE as spotted by Xin Yin (many thanks!). This fixes
  another write corruption problem
- clear the FIFOs after successfully transferring data as suggested by
  Xin Yin (many thanks!). This is what the 3.10 driver did and fixes yet
  another write corruption problem
- integrate the clock suggestions from Jianxin Pan so the driver is now
  able to set up the clocks correctly for all known cases. documentation
  is also added to the patch description. Thank you Jianxin for the
  help!
- set the correct max_busy_timeout as suggested by Jianxin Pan (thanks!)
- convert the dt-bindings to .yaml (which is why I didn't add Rob's
  Reviewed-by)
- switch to struct clk_parent_data as part of newer common clock
  framework APIs to simplify the clock setup
- dropped CMD23 support because it seems to hurt read and write
  performance by 10-20% in my tests. it's not clear why, but for now we
  can live without this.
- use devm_platform_ioremap_resource instead of open-coding it


[0] https://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf
[1] https://patchwork.kernel.org/cover/11035505/
[2] http://lists.infradead.org/pipermail/linux-amlogic/2019-November/014576.html


Martin Blumenstingl (2):
  dt-bindings: mmc: Document the Amlogic Meson SDHC MMC host controller
  mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host

 .../bindings/mmc/amlogic,meson-mx-sdhc.yaml   |   64 +
 drivers/mmc/host/Kconfig                      |   14 +
 drivers/mmc/host/Makefile                     |    1 +
 drivers/mmc/host/meson-mx-sdhc.c              | 1174 +++++++++++++++++
 4 files changed, 1253 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
 create mode 100644 drivers/mmc/host/meson-mx-sdhc.c

-- 
2.24.0

