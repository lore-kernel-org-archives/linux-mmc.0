Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F2DE732FD
	for <linux-mmc@archiver.kernel.org>; Thu, 28 Sep 2023 18:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjI1SI3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 Sep 2023 14:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjI1SI3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Sep 2023 14:08:29 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269BBDD
        for <linux-mmc@vger.kernel.org>; Thu, 28 Sep 2023 11:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695924508; x=1727460508;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kCGkFZgI4U6pqu4tCJHjG+4/lAp3UEMx8CDF/H32QHk=;
  b=M0l3ZbX9A4XBoDRZn3EZYvhrVfn9N95PfISCHua8waqr+XWFXwAYuWba
   W06cNdeKBL7M4aPq5NNabrKx1hu9d45R3RAXwceDMFiQdgSUJ0uXoG6nv
   cgx0OGigPlJhXr7FZBSl/kf4gKX/7JG68+sMPPsg8T+tDFCtmgwFATAyG
   WWAB7hsMnJ2IF2JQIwRBNBvmm3baN+pl0yKKck+nPt8mF+xH4vLXHUkfZ
   7cPDv8CYPlJj7E8HSFs5w/oszmXwPrCD1FmxpuxSNyKRuoB7HWnKTxBDu
   YteYGSjlui4yHv6nNYao3t7qOzv7zuwOevxL6IhC3bHzSeEIMrNdMIaYj
   A==;
X-CSE-ConnectionGUID: BiIkHYXuQFK9aOPro8kG4g==
X-CSE-MsgGUID: FUI1XE5ZQsWVhE0HciM3yQ==
X-IronPort-AV: E=Sophos;i="6.03,184,1694707200"; 
   d="scan'208";a="245206848"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2023 02:08:28 +0800
IronPort-SDR: Djza9KLHqk7PXFpU0wZ3YSXS1gqQVGwUwqyS0haERTQNaDnKyfAx4BlCyZMafxhYnP70jJB+UG
 ad9+HQhtBCeaCBmRjpSJFBhXeETEC4l5XbDlCGDPpw5UlCbdploUFhivicz5IspTTBPoPstwtK
 fQP27pnjwY2LVcU03tq7fJy1vxoVcCsbKi3F7KweOkxgWcKq4FhV98FQ+g//tc114D56r06Rgt
 TbRmtzHygEpnqdRHgu3xNn6AKLWHu9vmMlIv8NP+eZv7CEgljbkTswcFHt0Ziw6SbLs8uZK9/h
 Wvo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2023 10:20:53 -0700
IronPort-SDR: aaPeNQIBMO/slHtSVKc+Gazm1WL1t8ycQDu0AlS+2Sa3y7OfpUXJ0sjdIeGNNo1/xIdEIIsNq5
 Ax4RKQAsYvF2Q+UpsQRdky6wPEhK3K6aVo+l1VhukivNcNFBFihJFI2R6FcwAVJP2TrA85gZrG
 KfVqDx2OqFE488DfQeps9qPW4fnEc3BNEgcBzhwB2+fP5b3ss9uTlxaW0rz4SV9Q2tSn5sI/CN
 AQh0mmLRytcJn9uVSKd9YFvWG6JxxhVuylscmNQau/xzTsiuMgDWkoPVshL3iQ41J5recA1blf
 cxk=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Sep 2023 11:08:25 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 0/4] mmc-utils: Revamp CSD register parsing
Date:   Thu, 28 Sep 2023 21:06:54 +0300
Message-Id: <20230928180658.1795491-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Dust-up this old code that practically left untouched since lsmmc got
merged into mmc-utils.

The first 3 patches are mostly cleanups, where the 4th is fixing a
capacity calculation bug.

v3:
 - Add Avri as co-author to the 4th patch with Gang
 
v2:
 - remove the first patch from the original series that got accepted
 - Fix an ARM64 compilation warning

Avri Altman (4):
  mmc-utils: lsmmc: Simplify prinitng manufacturer name
  mmc-utils: lsmmc: Simplify interface processing functions
  mmc-utils: lsmmc: Disintegrade print_mmc_csd
  mmc-utils: lsmmc: Fix emmc capacity calculation

 lsmmc.c | 1554 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 725 insertions(+), 829 deletions(-)

-- 
2.42.0

