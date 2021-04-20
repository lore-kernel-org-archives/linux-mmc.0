Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC35C433B4
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Apr 2021 13:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC4B5610CC
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Apr 2021 13:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhDTNrU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Apr 2021 09:47:20 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:39268 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbhDTNrT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Apr 2021 09:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618926408; x=1650462408;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=28KmEltiF+hSxTmWmBPPQ1K7ffLWnavdXcRkNRJ4HwA=;
  b=JOLTcwWUeEKd49+pafYxbT/uO4RDrm315F75XePZM7cdU9EBNnixy4y8
   zvPSp20wPsJ/M4EgHI4hAv7sPN2WemJ3LjscJRtLZxyUUwQSfXmWh6psL
   UOUbc1je+zgTk54GozZOQs0r2puSxERKwH3W3cU7TJXUF9dDHQ3kGGiOj
   pBKUB8x4vnVOvUAel6IDU+MEDl5LxLHw6BQMG3dXMeCJrc2LiXhWnkcaa
   yr5ST4+WCclEWkso8HBM1gb9tDX31pGGWLEOk6CtVQbJz1eUaBLgbaETA
   4dqyyOpJsa+G9qW5VefvNSF3jCA1TtE1p6mz+gQajn2RQBt/N08Vz79Dy
   Q==;
IronPort-SDR: lmWk0cmW0NvZOH8FfPoWNwnLi+HuhUqOukcTM/ZMK7YhxxT3XLvrypj3EHo+zalE0R8jL66wE3
 UKYpqZ9AsPbMj7Sp3JB7dNaNV2FSgSojEBh6k0PGlGwHVsQAk7YGjtl70oRNlPu73xLPu0lwDK
 NU5jKejyqd6KKhjDdDykaAZJXyiv6noSzOa+olxxNMN43xfPGjTU8Vjc5AZcdafr3qgf1jur9s
 bY/bMvCLudF+rywdk3X4+212WnHRcd0CYVwtviJ3tC6p5xMhihSd+m8Sp2Z/Wfn7KGEctdRyDg
 wPY=
X-IronPort-AV: E=Sophos;i="5.82,237,1613404800"; 
   d="scan'208";a="165548005"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2021 21:46:47 +0800
IronPort-SDR: zb0dpCGshDpCWg8adLh/gmfLltdWaor/hd2r7y+7KoIhvAMI+nzWHEzMX4vmuVOGCLbEoADRDe
 /HqnyRCMCH8GaYWU/tsLk96NXiaHXFvVfhC1dLQ2tlP0T/0oCu9gks2liopOuxJ3iMUwJ2LvFU
 JSrxa8G2gbsj3OKBdSLxH9jTLcomBxR67hb9t/POQWMFXTQHsTIP+XS9mcA6OS2CEhRKMhv5Fe
 rhJUnyOYHhD0JqlcrPEYNyFIxMA82xUmGvbsNUmWGePAQo8OhJ7S2DpxHz1ng4zVTYypuiEGzP
 plIOcSfYd0p9/QFOuHh6jLLF
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 06:27:27 -0700
IronPort-SDR: KS6hdr/2wusYvxOcO+bUbaXSPh7xZ3l1zPK1pQ6s0m3lnrMNrV5uBekhd5oDJ0uvfE6YDorUwX
 gqTiwCS0Gl+USZvn0aY5jRekGxXR86EZw5/CBac5vQniVtZohy3VqpNvGPI24amgjdxMTG9V4F
 btFexERHfgkqc4iMPexEOgid7IsSwJir3s4tY6hvzeMApMH7GSniqXriSW+RyHwsLMuVly//n7
 M3w+UmsdT3eDzykVoMjzyOSPiSVnYXpyxnmm/awFF1v6RLV+Msd0XTb+4xyaZRiXEExOMPLQfo
 IUo=
WDCIronportException: Internal
Received: from bxygm33.sdcorp.global.sandisk.com ([10.0.231.247])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Apr 2021 06:46:47 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v4 0/2] Do not flush cache when it is disabled
Date:   Tue, 20 Apr 2021 16:46:39 +0300
Message-Id: <20210420134641.57343-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

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

The cache function can be turned ON and OFF. Once OFF, the host is not
expected to issue a flush-cache command to the device.

Avri Altman (2):
  mmc: block: Issue flush only if allowed
  mmc: block: Update ext_csd.cache_ctrl if it was written

 drivers/mmc/core/block.c   | 21 +++++++++++++++++++++
 drivers/mmc/core/mmc.c     |  2 +-
 drivers/mmc/core/mmc_ops.h |  5 +++++
 3 files changed, 27 insertions(+), 1 deletion(-)

-- 
2.25.1

