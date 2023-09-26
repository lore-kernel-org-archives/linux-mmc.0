Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D0AE7D273
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Sep 2023 10:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjIZKBg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Sep 2023 06:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjIZKBe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Sep 2023 06:01:34 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138AB97
        for <linux-mmc@vger.kernel.org>; Tue, 26 Sep 2023 03:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695722488; x=1727258488;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DX85ddMRw2BOVECfXw4MNxkJe8I9JIe9xRnZOdFKlek=;
  b=UKwNcJN5GeU0CAyKWDhxTisWVhMHis1ZIHPUktpqj38byioPxSmS7wRm
   0LKtH3Hh0I1qAI9WfzQBhlT/6AyUmH+kyp66XVXuciAVH3adLijUAl3uZ
   U/4NFySdLj52/Qi5+D/J7gOrSjUOFbymwKkwJrcZwZJzT2ksKg8vtb/QF
   HpBCY/KdnH4zOBnm0RkisO4vJ8AVDCGoUiYMJp0yv1qwYVaNYs+VdrNay
   Gd4Ojl1jsMw06SO+wu3Ybgv/F/NFQtbiChsYsv275egcH0EBOfC+3b/4X
   clwNHsjL63CEk19FqmoBKHeDSee5BY4vJ7K9xzN3OXdADxz+D+t0q8CVf
   A==;
X-CSE-ConnectionGUID: 407czrcuR02wfww+poHrtQ==
X-CSE-MsgGUID: h74W+YBlRaGBLf5ookyDFQ==
X-IronPort-AV: E=Sophos;i="6.03,177,1694707200"; 
   d="scan'208";a="249466672"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2023 18:01:27 +0800
IronPort-SDR: v8XBAqXZeTLyxJeuowcDnaKg4wyljkKC1rXlp7EQgnjqrbspxyZkac4TX8ACB/S49e2tW9SG4Y
 aZ/MaP6LKoy5s/THaT9nTPzqcO8BVOtgQTx608JflE+4vgxz8MHVsL7ZhydlgvwjwljmUcdUIl
 3Rwhucs+XXLwgNKRuxDzNQVL7Hwk3TISmcJQhKF9kk2sYDYTfyWKOGI2D23X21gC3w0oPCaf54
 XsQ/FzChWZV1oslkYgin5soPMX5UfAkHN98DUJH89XMMiLprfCacYkmf0nRhW7kLevXMaw5lFE
 HDM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2023 02:08:14 -0700
IronPort-SDR: jllmZEJHbbH+GrfiLeGMjmw7YCWpM5i/xKVJ+uRc9XQNyg/V5uxt5bb5Xq6NPUDeRDUJFzAj9O
 C+9r4KnrZ9e/Jvsndvbj6ybgMP+7UBuIwA3WIF9bYCB1XccPlj2KuA/RrMYkhaL0DkUaIEE3PA
 itr7YzkKDEfpZvCGYW+GQTlTgSd2JHdQfw4cQnTsiqUyn6QOA7a5Ki8SfHZcokWk2IX3pO9eEy
 vmds6keK0eyd7ozgDGljgFSUYhaRRudY31f319rzov6Gdsbym/x2bCd61ljtFM8H1XW0Vijy2f
 n0U=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Sep 2023 03:01:27 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 0/5] Revamp CSD register parsing
Date:   Tue, 26 Sep 2023 13:00:01 +0300
Message-Id: <20230926100006.1789276-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Dust-up this old code that practically left untouched since lsmmc got
merged into mmc-utils.

The first 4 patches are mostly cleanups, where the 5fth is fixing a
capacity calculation bug.

Avri Altman (4):
  mmc-utils: lsmmc: Reuse do_read_reg
  mmc-utils: lsmmc: Simplify prinitng manufacturer name
  mmc-utils: lsmmc: Simplify interface processing functions
  mmc-utils: lsmmc: Disintegrade print_mmc_csd

wanggang26 (1):
  mmc-utils: lsmmc: Fix emmc capacity calculation

 lsmmc.c | 1585 +++++++++++++++++++++++++------------------------------
 1 file changed, 727 insertions(+), 858 deletions(-)

-- 
2.42.0

