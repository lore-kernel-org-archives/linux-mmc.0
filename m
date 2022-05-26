Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B051C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 26 May 2022 19:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbiEZTLp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 May 2022 15:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiEZTLp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 May 2022 15:11:45 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17659CF52
        for <linux-mmc@vger.kernel.org>; Thu, 26 May 2022 12:11:43 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h11so2905287eda.8
        for <linux-mmc@vger.kernel.org>; Thu, 26 May 2022 12:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=CFWve15PbSFsWVgr5epdRnhsJ5bY7D++TYvTlUElYAc=;
        b=PJVO0IU5vln4ITKzRIkZc/Izb+u3fd0juCAWluMq7FyhhvCaKhEs3opvwyg2mOvPxP
         LmefHbuNiWAV+bccG9TFufgYXljb7CZhIiTZc/6zmn18mAYdokXkA4Nl/MOYzofbQuYQ
         WPSEUrtWgB4ouxp54EYPyjNRHPoCeKOcVBg+kbACQrscTrLxBHNqqn7YPpWkNHVK0H1M
         g30/JcVKh3uVi1TjCN9hnKo/jAZWy9S7Cx7kqQdPb/Wm/lbE8CpiPPB+RAlOTOcwvGc7
         McRoeEPVtqSc9sK4tdvMcEN7Swe0IZ4badHg1ua/aRIhxFbPfmKwApSrKOULQA+s+yA/
         iheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=CFWve15PbSFsWVgr5epdRnhsJ5bY7D++TYvTlUElYAc=;
        b=vSIHrWLVALwGtI74qt0F3xsbQTwy8yBOmocltOJK7HJgsXLI/7FCnA3NYe0DK7IscR
         OjUQP4DowKj5UHQHVlQ4pjEVYttTlATqkYlPAQmVRZVoRuVx/isRAjNn7TMjfStjaQ22
         RrXC3dgTJD9Zd1lTCezmtRvDleNBHjZmOHNMA8d4Dbm7ZChPwvwoN4Pj6Ej8Njw3cC4J
         nZIb2OSuAGc32RarEyzbhIiSkz1GREBhqPjhrmFmQZvU+SRJlFF2vr6xEktKTP4b5+Lj
         EzqrNNSzdQ7H3uVQiwllsZCD+ZOLaI/9WILpkUNdGBvlqi31sIQRE8pnYXylx/wKbSDt
         gcCw==
X-Gm-Message-State: AOAM530XJa43pYlz36TceWmEk27pAt0xFGq5P+9PCIe+Vp/uktVDTDMY
        wGZFwyBwmq2gxpC2u4jT6wuHEHthdN4L0bDO7G0=
X-Google-Smtp-Source: ABdhPJwju8DiGSClKyA4h2XUmzH4TmDlcglvGq/PJ1agf9nyzfgJ5DydTYWI5GvLnmMOU/iwcU3GNfWotTzivhyECxQ=
X-Received: by 2002:aa7:dc09:0:b0:42a:aadd:8e71 with SMTP id
 b9-20020aa7dc09000000b0042aaadd8e71mr41490554edu.41.1653592302574; Thu, 26
 May 2022 12:11:42 -0700 (PDT)
MIME-Version: 1.0
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 26 May 2022 16:11:34 -0300
Message-ID: <CAOMZO5DTUeuH_6izxbXOfwuN5w0ao-X6va1WXTkvXf1_zdAYtg@mail.gmail.com>
Subject: sdhci: queuing unknown CIS tuple
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On an imx7d based board, the following messages are seen
on the mmc2 interface, which is connected to an SDIO Wifi chip:

mmc2: queuing unknown CIS tuple 0x01 (3 bytes)
mmc2: queuing unknown CIS tuple 0x1a (5 bytes)
mmc2: queuing unknown CIS tuple 0x1b (8 bytes)
mmc2: queuing unknown CIS tuple 0x14 (0 bytes)
mmc2: queuing unknown CIS tuple 0x80 (1 bytes)
mmc2: queuing unknown CIS tuple 0x81 (1 bytes)
mmc2: queuing unknown CIS tuple 0x82 (1 bytes)

Is there a way to get rid of these  "queuing unknown CIS tuple" messages?

Thanks,

Fabio Estevam
