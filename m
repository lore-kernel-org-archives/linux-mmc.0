Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCEFEC875C
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Sep 2023 19:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjIGTb3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Sep 2023 15:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243094AbjIGRRu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Sep 2023 13:17:50 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8611FFE;
        Thu,  7 Sep 2023 10:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WtCoctKqrOuNL7YPM9mYObCf6Hdm7ApMb7s6UV96VRg=;
  b=HPx166wijMpi0SuqjYCYznd1XBpiCUbrQLc/PO/UMyEq3ZEUYTobIRDo
   3Rqqz8tTf3ziWlg9eiO0gtAOEfHBNxrgu+g1iTCYRdavySvFpyxmeL4HB
   GFAsE9lOiSmMbIKRRI/H8INxUF7Ej0oMCIoW7c5cwML7MMfndJw9rsVW5
   k=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.02,234,1688421600"; 
   d="scan'208";a="65324651"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 11:55:29 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-mmc@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-media@vger.kernel.org
Subject: [PATCH 00/11] add missing of_node_put
Date:   Thu,  7 Sep 2023 11:55:10 +0200
Message-Id: <20230907095521.14053-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add of_node_put on a break out of an of_node loop.

---

 arch/powerpc/kexec/file_load_64.c                    |    8 ++++++--
 arch/powerpc/platforms/powermac/low_i2c.c            |    4 +++-
 arch/powerpc/platforms/powermac/smp.c                |    4 +++-
 drivers/bus/arm-cci.c                                |    4 +++-
 drivers/genpd/ti/ti_sci_pm_domains.c                 |    8 ++++++--
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c      |    4 +++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c               |    4 +++-
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c |    1 +
 drivers/mmc/host/atmel-mci.c                         |    8 ++++++--
 drivers/net/ethernet/broadcom/asp2/bcmasp.c          |    1 +
 drivers/soc/dove/pmu.c                               |    5 ++++-
 drivers/thermal/thermal_of.c                         |    8 ++++++--
 sound/soc/sh/rcar/core.c                             |    1 +
 13 files changed, 46 insertions(+), 14 deletions(-)
