Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525DDC433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jul 2022 03:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiGMDE6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Jul 2022 23:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbiGMDE3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2022 23:04:29 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FB357215
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 20:04:24 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220713030419epoutp03287cd965b3fae3a057080f2e86b33efc~BRIETaO002028120281epoutp03Z
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jul 2022 03:04:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220713030419epoutp03287cd965b3fae3a057080f2e86b33efc~BRIETaO002028120281epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657681459;
        bh=HYzVJDqez6I+TXazHS58TQY1IFa+m54F3SecZN7oQlE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=j/phSEVev81NE5gbJKdNrV+5/AJQKX3yAejvHF8AVoqdK4VcklieZu+mGwT7gorlu
         RUZenajz+PbLf2LQFdslgu2+eV19R+PgzsblzCPurxLIRNXX2RdshlwiuW/sTxWU6i
         P5e7Kscc/vO+vK7A8ZdRT1PkQVTvs0hP8xv/Ng08=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220713030418epcas1p28a1d74fc9c99902805b5ace92993b18a~BRIEAm6ol1932219322epcas1p2O;
        Wed, 13 Jul 2022 03:04:18 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.248]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LjMsZ4MsDz4x9Q3; Wed, 13 Jul
        2022 03:04:18 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.10.09657.2363EC26; Wed, 13 Jul 2022 12:04:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220713030417epcas1p4645d69539b295df914057b57d1c09c86~BRIDWh4YJ3162931629epcas1p4I;
        Wed, 13 Jul 2022 03:04:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220713030417epsmtrp136d01a363213b608cbfc6cf98d740d2a~BRIDV7vRw0204302043epsmtrp1y;
        Wed, 13 Jul 2022 03:04:17 +0000 (GMT)
X-AuditID: b6c32a35-71dff700000025b9-61-62ce3632c31b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.2E.08905.1363EC26; Wed, 13 Jul 2022 12:04:17 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.101.71]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220713030417epsmtip1c6b5332ac51e029325933bddd470ad40~BRIDJKGeB2344123441epsmtip1s;
        Wed, 13 Jul 2022 03:04:17 +0000 (GMT)
From:   Seunghui Lee <sh043.lee@samsung.com>
To:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc:     Seunghui Lee <sh043.lee@samsung.com>
Subject: [PATCH v2 0/2] mmc: use mmc_card_* macro and add it for sd_combo
Date:   Wed, 13 Jul 2022 12:36:33 +0900
Message-Id: <20220713033635.28432-1-sh043.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7bCmvq6R2bkkg2UzeC2O/O9ntGj6s4/F
        4vjacAdmjzvX9rB59G1ZxejxeZNcAHNUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6h
        pYW5kkJeYm6qrZKLT4CuW2YO0B4lhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFZ
        gV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG0oN6BdPYKpq3zGJpYPzN0sXIySEhYCLR92AbWxcj
        F4eQwA5GiXnnTkA5nxgljvSdZIdwvjFKLJz+ix2m5evC8ywQib2MEs/2nmCFcD4zSnyZ1cMI
        UsUmoCUxfdMWJhBbRMBUomV3I1icWUBD4mXDBKAdHBzCAp4S6w5Yg4RZBFQlnrwGCXNy8ApY
        Sdzcv48RYpm8xJ/7PcwQcUGJkzOfsECMkZdo3jqbGWSvhMA8dol3828xQTS4SFzY0wJ1qbDE
        q+NboGwpiZf9bVB2sUTbv3/MEHaFxMG+L1C2scSnz58ZQW5jFtCUWL9LHyKsKLHz91yo8/kk
        3n3tYQUpkRDglehoE4IoUZZ4+WgZ1AWSEkvabzFDlHhIHHslARIWEoiVWL7/F8sERvlZSJ6Z
        heSZWQh7FzAyr2IUSy0ozk1PLTYsMIRHaXJ+7iZGcELTMt3BOPHtB71DjEwcjIcYJTiYlUR4
        /5w9lSTEm5JYWZValB9fVJqTWnyI0RQYvBOZpUST84EpNa8k3tDE0sDEzMjEwtjS2ExJnHfV
        tNOJQgLpiSWp2ampBalFMH1MHJxSDUzm4mETLjz/b6Sdwl7XGH8xYG91zrSjHuEOs3YscDtT
        O0dY74EGZ3Bc3tJD7Ht+crx1mPo6euWPg4e2KZj92MF8b+Ftn08JkhFcPdO4r7LVf42/+fP8
        7LTQvY7d54+mtT37/GlNjrGNUWTmtvbyFyHW9v73lgYVNhpP3pHXOrE+QHrGXiHtBMEnjJlK
        JRVClw3zJpjxmN34qV5mFrg095CVX+si6ef2y8vvqfxy+3w16rq2xLF+det0rSjWXmUx1uff
        Nr5forhM/GVqgKm6jkS7xkJ78VVibwSira4qZmz7lW3SqTFrQveWi+5PL7+aEnJcrTu57b2R
        1ZKKHWaim/5zO3z/5GxYu2jLdkfD70osxRmJhlrMRcWJAI0ISyvxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplluLIzCtJLcpLzFFi42LZdlhJTtfQ7FySwfpGM4sj//sZLZr+7GOx
        OL423IHZ4861PWwefVtWMXp83iQXwBzFZZOSmpNZllqkb5fAlbH0oF7BNLaK5i2zWBoYf7N0
        MXJySAiYSHxdeB7I5uIQEtjNKPFh4jpmiISkxOJHD9m6GDmAbGGJw4eLIWo+MkosOHCEFaSG
        TUBLYvqmLUwgtoiAucTDZS1gvcwCGhIvGyaA9QoLeEqsO2ANEmYRUJV48hokzMnBK2AlcXP/
        PkaIVfISf+73MEPEBSVOznzCAjFGXqJ562zmCYx8s5CkZiFJLWBkWsUomVpQnJueW2xYYJiX
        Wq5XnJhbXJqXrpecn7uJERxiWpo7GLev+qB3iJGJg/EQowQHs5II75+zp5KEeFMSK6tSi/Lj
        i0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYJIrULRxMMr8IbnobZp0Z3NV
        d8HV5duffNVJDhSYcb/98kl535Q9iSpeLQelM4/dWJe/Z/WHYC3xHYZH+oJ0n/V/nbf2jdT7
        NcqJ1S1XH8tn2b+WWZt6tdD3wtrJDN+3zz659gqve5XLRfcd82P6phwzkVscxCNzt9a8/Z/R
        bzHVzPam8oxbexZG5jzS3ePbbZ9ewjudW1XM+OXR7U/ddhk8LVEqFfh1egmrJss8i2/RZm1a
        T0qiV3Q/DvgokJzO71Vw50iG6+ElS2JcDhzZpxTeLfF62yxhDubK+NXxEpcV0rkNlGbKlCi9
        Pv9qmrT2iveB/iYtU3Sz/HJZr6+y5vOtUc7dMit57al+bp+pSizFGYmGWsxFxYkAVqz17aAC
        AAA=
X-CMS-MailID: 20220713030417epcas1p4645d69539b295df914057b57d1c09c86
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220713030417epcas1p4645d69539b295df914057b57d1c09c86
References: <CGME20220713030417epcas1p4645d69539b295df914057b57d1c09c86@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

add mmc_card_sd_combo() macro for sd combo type card and
use mmc_card_* macro to simplify instead of comparing card->type

Changes compared to v1:
- Reviewed v1 by Uffe.
- Split into two. One for the core and one for the mxcmmc driver.

* previous discussion
https://patchwork.kernel.org/project/linux-mmc/patch/20220705015729.14455-1-sh043.lee@samsung.com/

Seunghui Lee (2):
  mmc: core: use mmc_card_* macro and add it for sd_combo
  mmc: host: use mmc_card_sdio macro

 drivers/mmc/core/block.c  |  4 ++--
 drivers/mmc/core/bus.c    |  4 ++--
 drivers/mmc/core/sd.c     |  2 +-
 drivers/mmc/core/sdio.c   | 16 ++++++++--------
 drivers/mmc/host/mxcmmc.c |  2 +-
 include/linux/mmc/card.h  |  1 +
 6 files changed, 15 insertions(+), 14 deletions(-)

-- 
2.29.0

