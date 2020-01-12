Return-Path: <SRS0=SKJ7=3B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A963C33CA7
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Jan 2020 00:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E642071A
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Jan 2020 00:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ArkxWsHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbgALAZX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 11 Jan 2020 19:25:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38597 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731728AbgALAZW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Jan 2020 19:25:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so5209443wrh.5;
        Sat, 11 Jan 2020 16:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wAWyALOSBn7tzzbJwWZbezVclSVN3Btt3DEixhDkQII=;
        b=ArkxWsHLmXqGxa1xxpcAewKDkopPwoqRQ7Sjvi4wr/dZmFyo6BGIZf+NkgvpfZsGpJ
         lwYzzi3Vq4uSIXp06HKX/2z+nzbEz/sVLzH99QYWZc0F7m83wAW+0SHvXQCrUevzYGIj
         Io8kio+2MSj/PkepGFUnLmhr91JIfkVLJ8+OiQIMPibdBRag7Rshnw06wBn1ZNvGawfT
         GIQLE6QHORS7QOl4/6HL6zGsWWH+QytT9ZZJ7zdoTM+y+gNcTxZjtlBF//Ld8TaVMdas
         K28Y5imMrNB2RQhUIGEBV+cxZCY2xhwL6bkKBMUEpgBQx0YOPrKsO/xWLCfgxA6LmFkJ
         ZyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wAWyALOSBn7tzzbJwWZbezVclSVN3Btt3DEixhDkQII=;
        b=kWkhcXrHkg233VwBc9NdYhKrV3JrzhzGWRs+8VTvakgYrWysZRAY400i56+iUBsCtA
         O53Da3r6rjqcvPLcuveb5gzK9UseIj3vuZREQa0fMq7/xvc2ox6UoNs/UdZXG77GhNL5
         I8xGYKC9D0yqlsGPd5JGe5awf8cTxqnBbtiIpFla0rLcoRRE9DQDCu51aGMJyI4L2/l0
         YFDbIZUw5YSKaPTGZM9JlsqZnZfxAYXh8lE4dv4PqhWdW6d8nTpCc0surq0c3E7hXlvm
         g44vwqfj0XVl7CcEOVGa/BfHLCxR76IvfPm24SUCiqCNWZGu8QPwEEd8udRv5HLhOUyP
         CPRQ==
X-Gm-Message-State: APjAAAXnb4WtPc+GyQEUjizBdTB62LrJP0HEQW6cT+MatFidAdEGk7xm
        OqbdE0hxg87WTff7lEz1avA=
X-Google-Smtp-Source: APXvYqyqzfmZato1T8Am2AwdE0KKjdA9VaLATr7JDYJTE28SkegxKFwsYTzvgGymCNZnpbtnOunttw==
X-Received: by 2002:a5d:5091:: with SMTP id a17mr10663002wrt.362.1578788719231;
        Sat, 11 Jan 2020 16:25:19 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id t5sm8407389wrr.35.2020.01.11.16.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2020 16:25:18 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        robh+dt@kernel.org
Cc:     jianxin.pan@amlogic.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lnykww@gmail.com, yinxin_1989@aliyun.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v4 0/3] Amlogic 32-bit Meson SoC SDHC MMC controller driver
Date:   Sun, 12 Jan 2020 01:24:56 +0100
Message-Id: <20200112002459.2124850-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello,

this is the patchset for a driver for the Amlogic "SDHC" MMC controller
found on Meson6, Meson8, Meson8b and Meson8m2 SoCs.

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


Changes since v3 at [3]:
- split the clock bits into a separate clock controller driver because
  of two reasons: 1) it keeps the MMC controller driver mostly clean of
  the clock bits 2) the pure clock controller can use
  devm_clk_hw_register() (instead of devm_clk_register(), which is
  deprecated) and the MMC controller can act as a pure clock consumer.
  This also affects the dt-bindings which is why I dropped Rob's
  Reviewed-by. Thanks to Ulf for the suggestions

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
[3] https://patchwork.kernel.org/cover/11283179/


Martin Blumenstingl (3):
  dt-bindings: mmc: Document the Amlogic Meson SDHC MMC host controller
  clk: meson: add a driver for the Meson8/8b/8m2 SDHC clock controller
  mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host

 .../bindings/mmc/amlogic,meson-mx-sdhc.yaml   |   83 ++
 drivers/clk/meson/Kconfig                     |    9 +
 drivers/clk/meson/Makefile                    |    1 +
 drivers/clk/meson/meson-mx-sdhc.c             |  212 ++++
 drivers/mmc/host/Kconfig                      |   14 +
 drivers/mmc/host/Makefile                     |    1 +
 drivers/mmc/host/meson-mx-sdhc.c              | 1064 +++++++++++++++++
 .../dt-bindings/clock/meson-mx-sdhc-clkc.h    |    8 +
 8 files changed, 1392 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
 create mode 100644 drivers/clk/meson/meson-mx-sdhc.c
 create mode 100644 drivers/mmc/host/meson-mx-sdhc.c
 create mode 100644 include/dt-bindings/clock/meson-mx-sdhc-clkc.h

-- 
2.24.1

