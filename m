Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91683C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Oct 2021 08:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 709C960FD8
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Oct 2021 08:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhJVIW5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Oct 2021 04:22:57 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:23773 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhJVIW5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Oct 2021 04:22:57 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20211022082038epoutp0318dd6508c75fcad70eeb03b3b8a82576~wTI5AZrPM2988729887epoutp03u
        for <linux-mmc@vger.kernel.org>; Fri, 22 Oct 2021 08:20:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20211022082038epoutp0318dd6508c75fcad70eeb03b3b8a82576~wTI5AZrPM2988729887epoutp03u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1634890838;
        bh=1we9EEn+idZLxJ70UhC1LMIGoD4K0pVXY55Bwo10eWE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=FgyOek8vEu39UGxblToHh5918jhfPueX/ilYHfS4h4i7pRdPNOT4pxFb9kp36rv3C
         lJg95H4fAy7bNwEZXr+7SL1o3jyLmEWtNZcNUxC+XVlYc2VFXML2I81zR+2pACrbrY
         J2Xe9R7DMzV/My8JK93G/xwuXFdy8q08pk5XWd6w=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20211022082038epcas1p2396bd668db02ac5363e281d8a459a57c~wTI4xSymd3175131751epcas1p2o;
        Fri, 22 Oct 2021 08:20:38 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.236]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4HbHNF6ng0z4x9QF; Fri, 22 Oct
        2021 08:20:29 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.4B.09577.94472716; Fri, 22 Oct 2021 17:20:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20211022082025epcas1p3a4f5908ec149414ff985d7d3ec414910~wTItAiv3a0662406624epcas1p3w;
        Fri, 22 Oct 2021 08:20:25 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211022082025epsmtrp125df70d8a7b7aeb050e0b2b564d71159~wTIs-574W0076700767epsmtrp18;
        Fri, 22 Oct 2021 08:20:25 +0000 (GMT)
X-AuditID: b6c32a36-f4bff70000002569-e4-61727449def0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9E.C7.08738.94472716; Fri, 22 Oct 2021 17:20:25 +0900 (KST)
Received: from jaehoon-DeskTop.10.32.193.11 (unknown [10.113.113.235]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211022082025epsmtip192ce418badde662dda230c304a2be417~wTIszN57v1609416094epsmtip1a;
        Fri, 22 Oct 2021 08:20:25 +0000 (GMT)
From:   Jaehoon Chung <jh80.chung@samsung.com>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, krzysztof.kozlowski@canonical.com,
        christianshewitt@gmail.com, mihailescu2m@gmail.com,
        m.szyprowski@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH V2] mmc: dw_mmc: exynos: fix the finding clock sample value
Date:   Fri, 22 Oct 2021 17:21:06 +0900
Message-Id: <20211022082106.1557-1-jh80.chung@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmrq5nSVGiwYOvZhavbk1mtrjxq43V
        YuPbH0wWR/73M1qsPXKX3WL9tJ+sFsfXhjuwe8xq6GXz2DnrLrvHnWt72Dz6tqxi9Pi8SS6A
        NSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoCiWF
        ssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgWmBXnFibnFpXrpeXmqJlaGBgZEpUGFC
        dkbP7gtsBX+5KjZ9OsTWwHiTo4uRk0NCwERix6Euxi5GLg4hgR2MEnvn72SBcD4xSmy8eZoN
        wvnMKNFzZg0rXMvW6awQiV2MEo/fXWEBSQgJ/GaU+LxQF8RmE9CR2P7tOBOILSIgK/HzzwWw
        ScwC2xklvuxbzAySEBbwlnj4oA8owcHBIqAq8WhHJEiYV8BKYvfCwywQy+Ql/tzvYYaIC0qc
        nPkELM4MFG/eOpsZZKaEwDl2iSMznzJCNLhI9Fw8zgZhC0u8Or6FHcKWknjZ3wZlV0vsaj4D
        1dzBKHFrWxMTRMJYYv/SyUwgBzELaEqs36UPEVaU2Pl7LiPEYj6Jd197WEFKJAR4JTrahCBK
        VCQuvX7JBLPq7pP/0MDykHgzfQE0fGIl/t1fwjyBUX4WkndmIXlnFsLiBYzMqxjFUguKc9NT
        iw0LjOCxmpyfu4kRnBK1zHYwTnr7Qe8QIxMH4yFGCQ5mJRHe3RX5iUK8KYmVValF+fFFpTmp
        xYcYTYHhO5FZSjQ5H5iU80riDU0sDUzMjIxNLAzNDJXEeT/LFSYKCaQnlqRmp6YWpBbB9DFx
        cEo1MAWL7Kux7N8aNM3z9KzLL2fdKtkokq153T395LvrX8KvHjkxafHvaV9C/WP5Xu71vpyR
        kVX4IbqgLnyP/iXmBTPa+sJvXlxgUWLJ9O1g5iZd/up9kvnn5DccPFt74DejbsTNsvffvq/W
        U8zL6tzl4FTFnrT0sdjBRbqh0ea+opI1r1iWxE1ec0Dm8LddJTtO9WxfXtQ5gdl52YxTsnXH
        fgUfYeNgUj71+8AhlUfHbIK04i5v/LJ2Pp++6fbmKRuWB0+PFU7+v9i99U3pWY9bGrP/ONrN
        um37QVV/9e/6yJ/HuC0EFq5srPptIV7ieXrtUWGG5lrTKS/iJkwvj8hzZLvTIcmmJqG7bsup
        I++Lwr8osRRnJBpqMRcVJwIAfqnjtxIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsWy7bCSnK5nSVGiQdcLFYtXtyYzW9z41cZq
        sfHtDyaLI//7GS3WHrnLbrF+2k9Wi+Nrwx3YPWY19LJ57Jx1l93jzrU9bB59W1YxenzeJBfA
        GsVlk5Kak1mWWqRvl8CV0bP7AlvBX66KTZ8OsTUw3uToYuTkkBAwkdixdTprFyMXh5DADkaJ
        /vczWSASUhKfn05l62LkALKFJQ4fLoao+cko8aHxFCNIDZuAjsT2b8eZQGwRAVmJn38usIEU
        MQvsZZT49fM9WJGwgLfEwwd9YINYBFQlHu2IBAnzClhJ7F54GGqXvMSf+z3MEHFBiZMzn4DF
        mYHizVtnM09g5JuFJDULSWoBI9MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgENXS
        2sG4Z9UHvUOMTByMhxglOJiVRHh3V+QnCvGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkgg
        PbEkNTs1tSC1CCbLxMEp1cB0/NMs50l67/9M8e587B3aI8i0l+lj3S7ztddb3Ze8Mk3ccL+r
        +e6p88L3bn0LYg2ZtmFzXsj0jE7VtpkNh4OqHSQfCOzxkmm53WnwTnVGyqGo5Lcfl/A332K6
        zLk8f4avEi93N1Nv/M5ndSUHawsOGol5GPu/C24MFmYUbTdpPLVP862nZuMxm7za8p+P/txt
        2ssmVqQUOu/pVKUX8pZrOO6xVRfuCLut9vd3q/cfre9iMy4JLw3YujVZj2v552sfPX4EhjaX
        79p/daPZvBiDpl+ZLRsWPvHZFlIi8Pr+x58K19gWSm2rlu3UWfaMIVk2JXd7UWx+WLWUH4ft
        djPPp+45u6c4LH/Kx5S3SV2JpTgj0VCLuag4EQD0sPYIwAIAAA==
X-CMS-MailID: 20211022082025epcas1p3a4f5908ec149414ff985d7d3ec414910
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211022082025epcas1p3a4f5908ec149414ff985d7d3ec414910
References: <CGME20211022082025epcas1p3a4f5908ec149414ff985d7d3ec414910@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Even though there are candiates value if can't find best value, it's
returned -EIO. It's not proper behavior.
If there is not best value, use a first candiate value to work eMMC.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
Changelog V2:
- Add Marek's Tested-by tag
- Remove unnecessary code

 drivers/mmc/host/dw_mmc-exynos.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 0c75810812a0..1f8a3c0ddfe1 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -464,6 +464,18 @@ static s8 dw_mci_exynos_get_best_clksmpl(u8 candiates)
 		}
 	}
 
+	/*
+	 * If there is no cadiates value, then it needs to return -EIO.
+	 * If there are candiates values and don't find bset clk sample value,
+	 * then use a first candiates clock sample value.
+	 */
+	for (i = 0; i < iter; i++) {
+		__c = ror8(candiates, i);
+		if ((__c & 0x1) == 0x1) {
+			loc = i;
+			goto out;
+		}
+	}
 out:
 	return loc;
 }
@@ -494,6 +506,8 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 		priv->tuned_sample = found;
 	} else {
 		ret = -EIO;
+		dev_warn(&mmc->class_dev,
+			"There is no candiates value about clksmpl!\n");
 	}
 
 	return ret;
-- 
2.29.0

