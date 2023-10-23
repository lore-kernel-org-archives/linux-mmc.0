Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D8BCDB474
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Oct 2023 13:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjJWNZR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Oct 2023 09:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjJWNZB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Oct 2023 09:25:01 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351F1269F
        for <linux-mmc@vger.kernel.org>; Mon, 23 Oct 2023 06:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1698067387; x=1729603387;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lZlVBXf8PHqZNRSdkiV4MN9OZKd3ctxHutCkpnNXOxk=;
  b=W0S6b3lNDgb7em9DoEnhX78Z8e5ggmiwkLyeShhzP27d7tmk2Hst/pWo
   5Uj9PJK3HctsnmR3lrlF43+471hPk9StIlOCJLneT4ZnfLLdJcS0IL9Xr
   8o5c5ZIZPDWmhsDG7x75KKEh8yz6QoAwdFeV5cGYoJzbdl9ToSA+xO3v8
   A3Vw4mBIkmOwQcdnOlTyHe6mcJGXOz27/I3N45amYHssoronLKIoZ617h
   g3mwYog2fyiIK3HZlc8Wf5tFGdmRPvG5t1OI5pzbymPbWzQEUjOeTv2bQ
   ftndkQCS7YCwZj5OVzyJEO62Ego3+9sFCXWgZ9qWTbrui5Pn21SVXjaVj
   A==;
X-CSE-ConnectionGUID: yEINwuDAQxSWdhdDlYWz9Q==
X-CSE-MsgGUID: Jw2cMA2ET16CclGhWpqtvg==
X-IronPort-AV: E=Sophos;i="6.03,244,1694707200"; 
   d="scan'208";a="413914"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2023 21:23:07 +0800
IronPort-SDR: MKFbuG4a/0cchpTMt2G7CO31pt251CS0BZwyOZwSVYS4Zym9IChYg6B5HHrPICXavrQtgFUG+C
 BiC4FN70X9hHSBntZS/R5nU5XJOKqiTq1oOdOlD+vt0kR+0Bedwgyw14zWD0OXR7drmJSbKp6W
 BBEHCghFs5JaqexkQV4ym0N5UNbIpbS+4DWwVnDbA/f6Z2qHxqdOYjDqQHG2e4+iE6GaXqpVWt
 yNE4ZTTxhFnVhY/uZJwGo92O0BfYoXCPMIwuo/nh2z95zotwTenS96G35BKFE3fDyaGVrwK+Dm
 JKI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2023 05:29:20 -0700
IronPort-SDR: 50bkOdP6rGHmQAvKW7dpx3UwA6hR6OdjQVfzO76yqsxv15xJE1IgQlZBvdLikKqTmY6lTsB+x6
 FVEAAi0eoGP++5EJttzuQM9QgLklhW2B57qayDV4U3zYrZ+j+/j/Fbl5S+9cMUkjsBYXLV+3/8
 KIqkmNuL4yhxNz2nPq8TNHZjQfJZXeoZvcB46qXs9GVPBJdRhTh2icKIhKo912DBCgP2EpvYIe
 /relmbtol+IjntykB857XbjLUVYpmnHHj2Y3XVHV+Mj+nBWjhMyNHV9OetuTqQIU45CqiT0eMw
 J/k=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2023 06:23:04 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Daniil Lunev <dlunev@google.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 0/2] mmc: host: Disable auto-cmd12 during ffu
Date:   Mon, 23 Oct 2023 16:21:26 +0300
Message-Id: <20231023132128.1871269-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Field Firmware Update (ffu) may use close-ended or open ended sequence.
Each such sequence is comprised of a write commands enclosed between 2
switch commands - to and from ffu mode.

Some platforms generate auto command error interrupt when it shouldn't,
e.g. auto-cmd12 while in close-ended ffu sequence.  I encountered  this
issue while testing fwupd (github.com/fwupd/fwupd) on HP Chromebook x2,
a qualcomm based QC-7c, code name - strongbad. Instead of a quirk, make
sure it disable auto-cmd12 while close-ended ffu is in progress.

v1->v2:
 - Attend Adrian's suggestions

Avri Altman (2):
  mmc: core: Mark close-ended ffu in progress
  mmc: host: msm: Disable auto-cmd12 during ffu

 drivers/mmc/core/block.c     | 34 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-msm.c | 26 ++++++++++++++++++++++++++
 include/linux/mmc/host.h     |  1 +
 include/linux/mmc/mmc.h      |  1 +
 4 files changed, 62 insertions(+)

-- 
2.42.0

