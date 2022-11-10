Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC267C4321E
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Nov 2022 15:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiKJPIo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Nov 2022 10:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiKJPIm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Nov 2022 10:08:42 -0500
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Nov 2022 07:08:39 PST
Received: from mx.msync.work (mx.msync.work [185.250.0.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F02122B35;
        Thu, 10 Nov 2022 07:08:38 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 990931231BE;
        Thu, 10 Nov 2022 15:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1668092467; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding; bh=OTEcSrKbeEwGEfVJ7rDTBCJPtPYB3owKDL9ENQiVtws=;
        b=r/vrCUS6kd2GZejTmbFjVRuqxeY+xmENmIllYtzTlrrpwlYS+FSTKH4+ZDcETN4KgJdwg5
        pX47Cb4mQ4XvzAd8lmVJWw9xHd/sFGRZ/OBmS5aTUxPPpbIp3/JryjxXB5dEcKTLeyRseG
        rqL/FX0NUI6ZGxSoezA17RxFnHI5AoYMqtr+5s8/w/FpVdb9ECdFP63lwBn6VbhKFPQoX5
        iMBLrmPJLpr/L1S0ZnEHaLF/fcpHfHGpn3HlVf203H4rv8O/BEIQzDoIWjlcB3XWi30EgP
        34m027fzMNaEIyZVWDROYiUS9ZvfJZEEzwIZHCkke6EIB/MPxzOD9dhKabUmeA==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] arm64: amlogic: mmc: meson-gx: Add core, tx, rx
Date:   Thu, 10 Nov 2022 18:00:31 +0300
Message-Id: <20221110150035.2824580-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The mmc driver use the same phase values (core - 180, tx/rx - 0) for all
meson64 platforms. However, some platforms (and even some boards) require
different values (axg for example use 270 degree for core clock). This patch
transfers the values from the code to the variables in the device-tree files.
If not set in dts, use old default values.

Vyacheslav Bocharov (4):
  arm64: amlogic: mmc: meson-gx: Add core, tx, rx eMMC/SD/SDIO phase
    clock settings from devicetree data
  arm64: amlogic: mmc: meson-gx: Add dts binding include for core, tx,
    rx eMMC/SD/SDIO phase clock settings from devicetree data
  arm64: amlogic: dts: meson: update meson-axg device-tree for new core,
    tx, rx phase clock settings.
  arm64: dts: docs: Update mmc meson-gx documentation for new config
    option amlogic,mmc-phase

 .../bindings/mmc/amlogic,meson-gx.txt         |  7 ++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |  3 ++
 drivers/mmc/host/meson-gx-mmc.c               | 18 +++++++---
 include/dt-bindings/mmc/meson-gx-mmc.h        | 35 +++++++++++++++++++
 4 files changed, 58 insertions(+), 5 deletions(-)
 create mode 100644 include/dt-bindings/mmc/meson-gx-mmc.h

-- 
2.30.2

