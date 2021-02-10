Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBD8C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Feb 2021 05:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00E5464E42
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Feb 2021 05:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhBJFM4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 Feb 2021 00:12:56 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:42057 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhBJFMz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Feb 2021 00:12:55 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210210051212epoutp0288db53544f91764954a373a3737ab4f1~iSt2nHVbC2306623066epoutp02B
        for <linux-mmc@vger.kernel.org>; Wed, 10 Feb 2021 05:12:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210210051212epoutp0288db53544f91764954a373a3737ab4f1~iSt2nHVbC2306623066epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612933932;
        bh=oP47j6cbk000qUHjDQAmspwF0pjOcz69OLciCLzVCRI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=BTFcv4Cx4OtdeEeNtyemwtOwcYfRcr5DDVNJ2vFvkU/ObGHPuf8ypUUwfXeQPuIrZ
         XS+B1UWwZcY4hfFb0o+bbEAxyBJZDOVyeT4U3ZZq3yrCIrIg2l/n58skIMIa5IpIh6
         Z4PKyRk2JLvlP0JEAnLKA214Q9B2Mk+rzYNB/Ozk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210210051210epcas1p37dbe4f611780debf3fbd7418ba17826d~iSt1NWOcI0819108191epcas1p32;
        Wed, 10 Feb 2021 05:12:10 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.166]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Db7D96ZBRz4x9Pv; Wed, 10 Feb
        2021 05:12:09 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.86.09577.92B63206; Wed, 10 Feb 2021 14:12:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210210051209epcas1p3e55c0cbab7313731bc6e425da6189bb4~iStzjAnRw0819108191epcas1p31;
        Wed, 10 Feb 2021 05:12:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210210051209epsmtrp191b652a8c61e6baabba0178dad56b6ae~iStziFBhS1772517725epsmtrp1X;
        Wed, 10 Feb 2021 05:12:09 +0000 (GMT)
X-AuditID: b6c32a39-bfdff70000002569-49-60236b29ff7b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.D8.13470.82B63206; Wed, 10 Feb 2021 14:12:08 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.101.61]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210210051208epsmtip1db842061126c935bc16411825ab658e7~iStzOKPyh3012530125epsmtip1V;
        Wed, 10 Feb 2021 05:12:08 +0000 (GMT)
From:   DooHyun Hwang <dh0421.hwang@samsung.com>
To:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, ebiggers@google.com,
        wsa+renesas@sang-engineering.com, satyat@google.com,
        ludovic.barre@st.com, linus.walleij@linaro.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        junwoo80.lee@samsung.com, jangsub.yi@samsung.com,
        sh043.lee@samsung.com, cw9316.lee@samsung.com,
        sh8267.baek@samsung.com, wkon.kim@samsung.com,
        DooHyun Hwang <dh0421.hwang@samsung.com>
Subject: [PATCH] mmc: core: add a power cycle when CMD11 fails
Date:   Wed, 10 Feb 2021 13:59:36 +0900
Message-Id: <20210210045936.7809-1-dh0421.hwang@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmnq5mtnKCwb/JBhYzTrWxWuy7dpLd
        4uLqFlaLX3/Xs1t0bJ3MZLHj+Rl2i11/m5kspvxZzmRxedccNosj//sZLY4ccLToX32XzaLp
        zz4Wi2tnTrBaHF8bbrH50jcWi75z7g6CHgs2lXrcubaHzaNvyypGj2cL17N4PP2xl9nj8ya5
        ALaoHJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoMuV
        FMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWGBgV6xYm5xaV56XrJ+blWhgYGRqZA
        lQk5GdterWUuWMJRcfLKbKYGxttsXYycHBICJhJnHsxn7WLk4hAS2MEoceDGdCYI5xOjxKQ5
        xxghnG+MEp9Xz2GGaTnxpokFIrGXUWLj55fMEM5nRonVK+6BDWYT0JPY07sKbLCIwGVGiYX3
        doI5zAIfgZxbr4GqODiEBewkJiwLB2lgEVCV+LSwhRHE5hWwkZjx9AfUOnmJP/d7mCHighIn
        Zz5hAbGZgeLNW2eDbZYQmMshcfbDcXaIBheJ3Wd/skLYwhKvjm+BiktJvOxvg7K7GSX6D9lB
        NE9glLh8vAcaHsYSnz5/ZgQ5jllAU2L9Ln2IsKLEzt9zGSEW80m8+9rDClIiIcAr0dEmBFGi
        JrH433egEnYgW0aikRsi6iEx78Z1sEYhgViJ6zt6GScwys9C8swsJM/MQli7gJF5FaNYakFx
        bnpqsWGBKXKsbmIEJ18tyx2M099+0DvEyMTBeIhRgoNZSYTXeaZSghBvSmJlVWpRfnxRaU5q
        8SFGU2DwTmSWEk3OB6b/vJJ4Q1MjY2NjCxMzczNTYyVx3iSDB/FCAumJJanZqakFqUUwfUwc
        nFINTDEH1/M33P7xJPRkae7/sjILZjWW5cZq61ZYMl8uKMrjybE8yX9v+5TVihOXxD+Ktqu3
        O1uRXlMTlbnodlYpk+eLJW9KLBhFX9c3Ck7W3fogbcqzQxGvlXTnXAm2WmeeJvXx9eTWtOab
        vBLP7ybuCSySezDzk1b2pjPvww65GK526c/actVNZ96uHZn7cp5bHX5/+cCqjp3Bt870Oj0w
        1tm+10Xxrtjcrvzk6kshjPeONOeeklzE2zXpaJjLlMJT3t1VoUfX1x52bGpa1b+hprP4VMe1
        8mIpm58+bpNUJzxfv+Zy76oMV85++f9bHwhFmkSH8dyauCV7/fRvkgwcdy4bKNdIFUxqXj7Z
        M8xDUYmlOCPRUIu5qDgRAEDUy79HBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWy7bCSnK5GtnKCwbUtlhYzTrWxWuy7dpLd
        4uLqFlaLX3/Xs1t0bJ3MZLHj+Rl2i11/m5kspvxZzmRxedccNosj//sZLY4ccLToX32XzaLp
        zz4Wi2tnTrBaHF8bbrH50jcWi75z7g6CHgs2lXrcubaHzaNvyypGj2cL17N4PP2xl9nj8ya5
        ALYoLpuU1JzMstQifbsEroxtr9YyFyzhqDh5ZTZTA+Ntti5GTg4JAROJE2+aWLoYuTiEBHYz
        SjRt/8AIkZCR6L6/l72LkQPIFpY4fLgYouYjo8S8RZPBatgE9CT29K5iBUmICNwGSly+wg7i
        MAv8ZpSY9KMZrFtYwE5iwrJwkAYWAVWJTwtbwJp5BWwkZjz9wQyxTF7iz/0eZoi4oMTJmU9Y
        QGxmoHjz1tnMExj5ZiFJzUKSWsDItIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzga
        tDR3MG5f9UHvECMTB+MhRgkOZiURXueZSglCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwX
        EkhPLEnNTk0tSC2CyTJxcEo1MG26ulibJa5gccSVpUzNhYuXbZHT/bn80fc62QXf9zltdvdv
        unJaofJ/xqEvV88oOC31ObdQUHKOYWbltMI1z6o+Wk5atvte3lyv4/yeD9QTdgV8+9T0ZsuT
        fNEtlUsMflmKuM2/6hiwfeuVuQ8dOadqes2wuu3QlrrUev/+i8lZVz/cWd4r5KyfmcVauPm+
        R2rj7WTrMJfJHxYJfW/fUlzbY3l3/o3rsqYPNCOzo6bdZzvvtf3Wy3Wrkp+YCCXt97bi2DPD
        PH+NZui6h9VvcmYVzu3ti9P/ffzn6cmq231vGbdpSPIKvY7lMbvkMp3jmeh25etCjxL7xB/N
        c2d4c+r2RovGswqe6e3rm/rPfGxTYinOSDTUYi4qTgQAt7NGzvUCAAA=
X-CMS-MailID: 20210210051209epcas1p3e55c0cbab7313731bc6e425da6189bb4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210210051209epcas1p3e55c0cbab7313731bc6e425da6189bb4
References: <CGME20210210051209epcas1p3e55c0cbab7313731bc6e425da6189bb4@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

A power cycle is required if CMD11 fails.
CMD11 failure should be handled as no response.

If there is a timeout error that means no response to the CMD11,
do not send the CMD11 again and the power cycle is required.
Any other errors for CMD11 are the same because CMD11 failed.

On some bad SD Card, CMD11 may fail but the card may have already
invoked the voltage switch sequence.
In this case, it is necessary to retry without voltage switching
after power cycle.

Signed-off-by: DooHyun Hwang <dh0421.hwang@samsung.com>
---
 drivers/mmc/core/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 1136b859ddd8..a6674df2a7bb 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1207,7 +1207,7 @@ int mmc_set_uhs_voltage(struct mmc_host *host, u32 ocr)
 
 	err = mmc_wait_for_cmd(host, &cmd, 0);
 	if (err)
-		return err;
+		goto power_cycle;
 
 	if (!mmc_host_is_spi(host) && (cmd.resp[0] & R1_ERROR))
 		return -EIO;
-- 
2.29.0

