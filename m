Return-Path: <SRS0=tofm=6M=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04240C8300B
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Apr 2020 21:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA4AD20731
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Apr 2020 21:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QDH3NZ0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgD1VCn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726355AbgD1VCm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Apr 2020 17:02:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE82C03C1AC;
        Tue, 28 Apr 2020 14:02:42 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v4so3295036wme.1;
        Tue, 28 Apr 2020 14:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yw7EK7N4yEtnhbsKdiWnKZJJkNUJXPPLmqusKcDlWn4=;
        b=QDH3NZ0F1YoTWBY73XIwUv7DlugjsyVaIs90L9yRNBD6az0cxNSSg46PWsxfVAlK3c
         wx60nQOKxuG792Dg6HygS/qzgQa2DYC5fzq9qmx7P83nRozHSg+AYT8Q8yyAQIU4Qr+p
         kq5vjJVEs81+0jOqmNnaLSw0kuUvKwcHXg42HqGxfwPMzt+FA6bUzpENA54jJzJV4zOB
         LJDPUvqaHOArrRO/pltmFSzMLYIPpVlnrVHu1XAvl8LGTJ3lj0h2i+ic1+g9KgQT+FVD
         fsdGLLmjv+Uf4e1/h7N1hLj7P2iMniQTr26TSQ/pllrHgfBzU0gs87KAy6P0/97N/Oig
         p7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yw7EK7N4yEtnhbsKdiWnKZJJkNUJXPPLmqusKcDlWn4=;
        b=UM0NHSNp3/ZMYc0kqhcEapvD8lnVyBDsRxZcNkcjzZ7+Cn9UQ1dXNQYjBvuGb2awHW
         4YTlOaNdNHC0jI4rVgUuWzagCAfxIvXWD1xXDYqO8HAqQTc3LJDOk/eIH/+znFnIxjoV
         lR4DD0ONd2vbCt+QnsjEHoQ4go9b7zqSK6BrppTBkbWMWJ6mlYNj3FAO0CsLmLZnjqu3
         fc0c+KXcQV5c1/jX+u6eK3+BXngcjcLML2CRcdvjwaOKaDiwrEle9/3ow/mlu8mCZHsI
         CpGw8jmBOY63AD0zsOAPpvmK/T3+9803r7jF5Bj0LMqelweExC/xDcsUJUehTQr0iGnp
         Y7og==
X-Gm-Message-State: AGi0PuYQuga6B+5RQ5VZ8vVMOl2MO2LRKurLwuFUsoQGGgxZ7ZoXziNx
        n8D9RuooMPg38FkrFs23RRc=
X-Google-Smtp-Source: APiQypID52osTOt/r+5vVSxSLHFg+GwS+r2Wh1XUO8jXqCNggdq8a97jXinVpVhbbc40v9q2qn+z4w==
X-Received: by 2002:a1c:dfc2:: with SMTP id w185mr6329402wmg.1.1588107760863;
        Tue, 28 Apr 2020 14:02:40 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id x18sm4709243wmi.29.2020.04.28.14.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 14:02:40 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        ulf.hansson@linaro.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        jianxin.pan@amlogic.com, linux-kernel@vger.kernel.org,
        yinxin_1989@aliyun.com, linux-arm-kernel@lists.infradead.org,
        lnykww@gmail.com, linux.amoon@gmail.com, jbrunet@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v6 0/2] Amlogic 32-bit Meson SoC SDHC MMC controller driver
Date:   Tue, 28 Apr 2020 23:02:27 +0200
Message-Id: <20200428210229.703309-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
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


Changes since v5 at [5] (thanks to Ulf and Jerome for the feedback):
- changed copyright year to 2020
- move register #defines to a separate header file
- drop unused include linux/clk-provider.h from meson-mx-sdhc.c
- used #defines for regmap_read_poll_timeout timeout/sleep values
- set MMC_CAP_WAIT_WHILE_BUSY
- move the clock controller code to mmc/host/meson-mx-sdhc-clkc.c and
  don't register a separate platform_device for it. This also means
  that the driver switched from clk_regmap to the standard
  clk_{divider,gate,mux}_ops
- dropped ".index = -1" for clk_parent_data with .fw_name
- use CLK_SET_RATE_PARENT on all leaf clocks and drop
  CLK_SET_RATE_GATE
- switch from parent_data.name to parent_hws
- use fallthrough; instead of fallthrough comment
- added Anand's Tested-by - thank you!
- I decided to keep all Tested-by and Reviewed-by because they were
  only for the MMC controller part and I have barely touched that with
  this update.
- Ulf asked if the timeout can be shortened. I believe it can but I
  have no documentation for it. Thus I need a test-case to see if my
  assumptions are correct - thus I have not addressed this in v6 yet

Changes since v4 at [4]:
- move the four clkin clock inputs to the start of the clock-names list
  as suggested by Rob, affects patch #1
- fixed #include statement in dt-bindings example in patch #1

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
[4] https://patchwork.kernel.org/cover/11329017/
[5] https://patchwork.kernel.org/cover/11463341/


Martin Blumenstingl (2):
  dt-bindings: mmc: Document the Amlogic Meson SDHC MMC host controller
  mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host

 .../bindings/mmc/amlogic,meson-mx-sdhc.yaml   |  83 ++
 drivers/mmc/host/Kconfig                      |  14 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/meson-mx-sdhc-clkc.c         | 188 ++++
 drivers/mmc/host/meson-mx-sdhc.c              | 916 ++++++++++++++++++
 drivers/mmc/host/meson-mx-sdhc.h              | 138 +++
 .../dt-bindings/clock/meson-mx-sdhc-clkc.h    |   8 +
 7 files changed, 1348 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
 create mode 100644 drivers/mmc/host/meson-mx-sdhc-clkc.c
 create mode 100644 drivers/mmc/host/meson-mx-sdhc.c
 create mode 100644 drivers/mmc/host/meson-mx-sdhc.h
 create mode 100644 include/dt-bindings/clock/meson-mx-sdhc-clkc.h

-- 
2.26.2

