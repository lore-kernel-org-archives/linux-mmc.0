Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81EFC04AA5
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Aug 2022 07:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbiHYHkN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 25 Aug 2022 03:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbiHYHkL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Aug 2022 03:40:11 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A87979F2
        for <linux-mmc@vger.kernel.org>; Thu, 25 Aug 2022 00:40:10 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id h22so27615771ejk.4
        for <linux-mmc@vger.kernel.org>; Thu, 25 Aug 2022 00:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=GWE49z/WE2m8uFeErgnRZNtxcULt9qQRtlyy1SEYrZU=;
        b=EwI9vKm0FCiRLUcTrnQje1+h4VQ3WsRUo0D+zJVXtz0XEzE8p2PIPZ3LgHy6UyQcvE
         F92CGHHS0BRvjrpCI0TZFLrvJN6DjwdbR77OQiE4K7QSexxQjDIzgX6H63zkPlh0IYkc
         VfyG5ffOKyE071b38g/y9ECqKhIiSatZMgdlMPajG/tqBDoSVfqOZTeaIgIJ89pp1rkU
         VeTv3A+GRgUcrWdK63nF8/D+hsa3EgwcIdjR+VIDyWhZnOAiYxONJrCvtwiOXiKVS7jL
         fzQ6KS76HQ8dl8wmM6JGO9eC91Wla8d53SaM/lYwSs++S/SBCdzTrbi51k4/gWE0s9gA
         21TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=GWE49z/WE2m8uFeErgnRZNtxcULt9qQRtlyy1SEYrZU=;
        b=sRyZ70Zusub8wI8oSKeRWRbD0EmzJD+FLFtAyijJFuAcYm0tbfN6m9AzkhadRjERde
         FzeLCzUG248PDjEOhVHm0zIpMl+WVTmEgnSL/49dINg2/OEhbGEZVCSxkx+hYGbgQTbY
         MAdsPUeZ/Ii5zJ2crRjzNyaLZXSQqqXq5Tf4pta8AzLU5YOOE5GDACsw8cTjWvCZ6NnX
         mt6SCFDjSWyz5zI3EI2Y8A0I/OTz+BVnIqItq9ODTDBerHquSdIbktIt9Wu3HMi6iYHm
         0RRlDVPzzuVqhMBvERvevWRvLhqpRD6U44b4+yTttw3zmUO42kDnHwDBEg7NI3su9uzX
         VupA==
X-Gm-Message-State: ACgBeo2xUQVSSEDV+xp9CaWLRVV/MkPttaJYPt6t1BvM0YM3qMjFeE8w
        8d4qym6WC2xQOvoCbJkYK9iSWDpoB34zpg==
X-Google-Smtp-Source: AA6agR6tgnCjFyoSolGa8npy8fJk1yscCfKk/1ZkI0zth4Lp146HcXxBC+91BVQbOvDpWiCykLbDRA==
X-Received: by 2002:a17:907:7b8e:b0:73d:7c69:4d67 with SMTP id ne14-20020a1709077b8e00b0073d7c694d67mr1539619ejc.609.1661413209458;
        Thu, 25 Aug 2022 00:40:09 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:142d:a900:eab:b5b1:a064:1d0d])
        by smtp.gmail.com with ESMTPSA id jg31-20020a170907971f00b0072b3406e9c2sm2106267ejc.95.2022.08.25.00.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 00:40:09 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Subject: [PATCH 0/2] mmc: Fix dma_map_sg error check
Date:   Thu, 25 Aug 2022 09:40:06 +0200
Message-Id: <20220825074008.33349-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi, all,

While working on a bugfix on RTRS[1], I noticed there are quite a few other
drivers have the same problem, due to the fact dma_map_sg return 0 on error,
not like most of the cases, return negative value for error.

I "grep -A 5 dma_map_sg' in kernel tree, and audit/fix the one I feel is buggy,
hence this patchset. As suggested by Christoph Hellwig, I now send the patches per
subsystem, this is for mmc subsystem.

Thanks!

[1] https://lore.kernel.org/linux-rdma/20220818105355.110344-1-haris.iqbal@ionos.com/T/#t

Jack Wang (2):
  mmc: meson-mx-sdhc: Fix error check for dma_map_sg
  mmc: jz4740_mmc: Fix error check for dma_map_sg

 drivers/mmc/host/jz4740_mmc.c        | 4 ++--
 drivers/mmc/host/meson-mx-sdhc-mmc.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.34.1

