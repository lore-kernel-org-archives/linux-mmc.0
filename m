Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6642CC433ED
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Apr 2021 06:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 351F561166
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Apr 2021 06:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhDYGDF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 25 Apr 2021 02:03:05 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26809 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhDYGDE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Apr 2021 02:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619330545; x=1650866545;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QFcJ0x/yJ6dOOOaoLHEDCD4plD9rAdd2WtAJd+rmii8=;
  b=a1Fr6nQdvf9ALhgakFq0jQ2umq619RjKKywSHiKvLtRcFCw2l/0ZeXPU
   4leJqxGniCjqX0KRcMzpNmKZBRwfbzmBbW5DQ4eZIx+v5ue74mzHXSDi+
   c61Lw5JB0AGHcUq8Dxtf16Q2kDwzGi5kbnLj2pfbNdmfLnSjFAfZEnUso
   rYVuzk40F784Ul/eLm1+EyqvoJIIYTpLp1rjqv/OkDhJXj4iy4Vy0nc/2
   7OQ+OQcFI3tzvSCySWhHTycCDsK5ZV707AFgpmm0YVCt8DtNuIChtyXsY
   G/WTeemrG20vdEwEjVZ7095qYWVbeq77m/DNQFEobqRKz+jdASp7/XImw
   A==;
IronPort-SDR: oXQEKtzumh8aFBQ9cv2LKWL0ZdNRs81v4YLZE+dwkj6CvfRhd8hn2FHg9cyvjlEFMsU4QPBTe2
 pP+G+H2DIPLWOabj9brbZC+2ppRAv+CzGMRq2Zhhgmt/OWOJ8ecmwtRf7SDVjbdJjTWl1xfUQy
 2g6hpkb2mVJTwMuFEH/jpiIsZVfWiFFIDxiyRdtpgWPoy5kixytm2bLg1k6wO1VffURzL9Vbdu
 SsTbbL5ABgvy1Lf+4cdxiCDUiRiauL8hXY7veLS3Pz7bCGnuTK+1FIOCEX4DJw/yrOlWXCgR3y
 La4=
X-IronPort-AV: E=Sophos;i="5.82,249,1613404800"; 
   d="scan'208";a="165539924"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2021 14:02:25 +0800
IronPort-SDR: VDr20nykoOy2HJsEKKeUVecfd8vd/hkxTnS7FjeDpdenKiqlpnHiRS0bTZnCG/0TDV+XxG2k7D
 va4ph3OWnR1t6qkYHEIEOfXhjmFjTnHTYnoBu4u3eCf8kxUSUmcPJc4JY5/AWP6PjXR8NhsKVo
 +3zvR1VGFeN0Vb/jtk/wC9ashPZnEBFWjP954bI1Az6bAh+CQaj9vV33CaIvzHD/L8pJpySgcF
 WF5hzhasOcxiBp9p6ihJ0dUQForEN2cZA09tfU0DNMtHLtBMAdnPS/+LFWj3UbKdhqiE7hgG5a
 Sht33PSUfK0LkccFG7xx3uoX
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2021 22:42:54 -0700
IronPort-SDR: 1fIg2WOJDH1j1mTRicT/qqcsaBmAdCnni+FCJbE20CyNfmNEwx0sYJZ4nmkmEc8zu8//ItcraR
 0GGC9i4pLKl+4RPFwvMXeGgMETGPybaXWgM3v6to0k95DTj1cK+Adt3EIGUaoE7QMI7GzL6SlC
 GxlKqTN0e4zgxy/PSH6pc5L6uIbXFdjUAjdEzIXZBb/w/UHgKtWP4jae1+EB7Z8vmEkmtPbJm1
 HcVsLqAGHCVbklMjdSpz/qQvdviHkhd/zy6pN+kvFHTiZiXCOmsg7xy2FwI+8d5Y3et9IdWFqP
 O2A=
WDCIronportException: Internal
Received: from bxygm33.sdcorp.global.sandisk.com ([10.0.231.247])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Apr 2021 23:02:23 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v5 0/2] Do not flush cache when it is disabled
Date:   Sun, 25 Apr 2021 09:02:05 +0300
Message-Id: <20210425060207.2591-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

v4 -> v5
 - patche "Update ext_csd.cache_ctrl if it was written" accepted
 - Add one more patch: "Add cache_enabled bus ops"
 - Add Acked-by tag
 - another rebase

v3 -> v4
 - Attend Adrian's comments
 - Add Acked-by tag

v2 -> v3:
 - rebase onto recent cache changes

v1 -> v2:
 - Attend Adrian's comments

Cache is a temporary storage space in an eMMC device. Volatile by
nature, the cache should in typical case reduce the access time compared
to an access to the main nonvolatile storage.

Avri Altman (2):
  mmc: Add cache_enabled bus ops
  mmc: block: Issue flush only if allowed

 drivers/mmc/core/block.c   | 9 +++++++++
 drivers/mmc/core/core.h    | 7 +++++++
 drivers/mmc/core/mmc.c     | 7 +++++++
 drivers/mmc/core/mmc_ops.c | 4 +---
 4 files changed, 24 insertions(+), 3 deletions(-)

-- 
2.25.1

