Return-Path: <SRS0=vSIZ=ZY=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694A7C432C0
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Dec 2019 14:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399432071F
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Dec 2019 14:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xn4dZyq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfLBOlV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Dec 2019 09:41:21 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44956 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfLBOlV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Dec 2019 09:41:21 -0500
Received: by mail-pg1-f196.google.com with SMTP id x7so1735640pgl.11
        for <linux-mmc@vger.kernel.org>; Mon, 02 Dec 2019 06:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id;
        bh=TNhD8atgj/3Edq1g1SWJD+ZVY5NkG6QqjOLea18kW3w=;
        b=xn4dZyq0lz2uU6WQdc9kh7YocJVlWZ54xp2FV+iMXab2f29mIjlvRAk74hdcCRtQTN
         1s3fdUAB/oTZ9TJ3FCxOqnSfMSqBtlE4cTiKIjWoK4bQnMrYAd6357qG8WF/1erl0Eh1
         3ud3cyjuSq3q5E0oj/L1Va3kMEhJLSw368MrKyaz+o0zFFUPrmjIQWSGFJ5T2tqegQcw
         RpofaA3S3N6eSqSA0ppvNc064MCOOvtZ6yItvcCjS5qQH72okf5ZlQ35fq881JsTYPW6
         Q/i3NKrzjlHCIrkR2utpXGbruv1g4+3MkfZaH5Gm9GWjb8USxupkl4OVTCEI6LkenCr8
         pZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=TNhD8atgj/3Edq1g1SWJD+ZVY5NkG6QqjOLea18kW3w=;
        b=uB3x3jzcJ3Mo1eOAuguzDcY/Fpl++JFvka+JKsWZIdhGH2/4vVLVan8K1HM87sD2wS
         D5NlddiZJFhEIvQlWCTaLzTvwGPMpvVBRczCXPIXujgLZFiP8YIzRdm50H6bVikDxe62
         za7L3fi0vsmKHrkxXDczeFrQLhrTQoWxN81GW45Zqrt24RFzEEZBnA7xlZKcSphme9Ts
         1B41vYxe2UC79wJGjmTw46tQGIePoNcTiFZoY1MN8ZnRA0b4WwsCTmNg74+yNHaG3wKX
         /0dazqOSUf5Wqn07kjbu569cCr5S+xc6DhD8MPFXvu35Gd40rWQElWYI987UrmX56Zhb
         U1wg==
X-Gm-Message-State: APjAAAUaKyvoLs2TDOB8/pZcNMRoEAw9GIb/PfVllFeg0VjWwfRIRAL2
        5GUIKe4S5ZgZz0DwGoNicNkydw==
X-Google-Smtp-Source: APXvYqz5QA1SO4aFSTLxMYWgKXjhXFL5hV4dRyluz7IVhs2NfUHKb5LCcuFYbJw2Rk3zyhxUmN2dxA==
X-Received: by 2002:a63:4287:: with SMTP id p129mr11089174pga.122.1575297680931;
        Mon, 02 Dec 2019 06:41:20 -0800 (PST)
Received: from localhost.localdomain (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id f30sm33985090pga.20.2019.12.02.06.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 06:41:20 -0800 (PST)
From:   Jun Nie <jun.nie@linaro.org>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/4] mmc: Add sdhci workaround stability enhencement
Date:   Mon,  2 Dec 2019 22:41:00 +0800
Message-Id: <20191202144104.5069-1-jun.nie@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch set made three changes:
 1. set enhence full power cycle stability.
 2. Add dt property to support DMA memory address boundary workaround.
 3. Add dt property to non-standard HS400 mode value in ctrl register.


Jun Nie (4):
  mmc: sdhci: Add delay after power off
  mmc: sdhci: dt: Add DMA boundary and HS400 properties
  mmc: sdhci: Set ctrl_hs400 value in dts
  mmc: sdhci: Add DMA memory boundary workaround

 .../devicetree/bindings/mmc/sdhci.txt         |  8 +++++
 drivers/mmc/host/sdhci.c                      | 36 +++++++++++++++++--
 drivers/mmc/host/sdhci.h                      |  9 ++++-
 3 files changed, 50 insertions(+), 3 deletions(-)

-- 
2.17.1

