Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFC1C433B4
	for <linux-mmc@archiver.kernel.org>; Thu, 13 May 2021 02:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9AAA613FE
	for <linux-mmc@archiver.kernel.org>; Thu, 13 May 2021 02:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhEMCjB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 12 May 2021 22:39:01 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:22978 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhEMCjA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 May 2021 22:39:00 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210513023750epoutp04ab32f82d8d852dd4bedc502526ef188d~_f9VcUJ2e0168201682epoutp04k
        for <linux-mmc@vger.kernel.org>; Thu, 13 May 2021 02:37:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210513023750epoutp04ab32f82d8d852dd4bedc502526ef188d~_f9VcUJ2e0168201682epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1620873470;
        bh=YwYqzf4migoNc3CLffZtdmBl6XUsE0z40O9rpgKoT8k=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Gpbk0fa9WRLiKzoO5e4MR6Cm1o7v0aou9ClfQePPV6YAUAhq4iEwRF64Nb0cZVjz0
         ybGFUkPkgCGMYJU6cvkv+yDW0nu+uiIvWvty4gYU2JupwGpfLsqdFQyM3fZNqfwTIa
         SRXSuNilDBH4n0mYZ3lE/9az3kOjRfM85H5Q91Lg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210513023749epcas1p46be1e76873d0804f5ddac25b97d08461~_f9UV-1kl1954819548epcas1p4H;
        Thu, 13 May 2021 02:37:49 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.163]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4FgbRb4z2fz4x9Q0; Thu, 13 May
        2021 02:37:47 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.E5.10258.BF09C906; Thu, 13 May 2021 11:37:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210513023747epcas1p23502f390781d1a5a8f6512982af1fd65~_f9Sbcz9s2434224342epcas1p2H;
        Thu, 13 May 2021 02:37:47 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210513023747epsmtrp151e4711383e4cc6bee433bdb75095065~_f9San5XD0351503515epsmtrp1t;
        Thu, 13 May 2021 02:37:47 +0000 (GMT)
X-AuditID: b6c32a38-42fff70000002812-3a-609c90fb4ba8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.5E.08163.AF09C906; Thu, 13 May 2021 11:37:46 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210513023746epsmtip27f714062765237453d4d854d326f237b~_f9SK5uV02662926629epsmtip2t;
        Thu, 13 May 2021 02:37:46 +0000 (GMT)
From:   Chanwoo Lee <cw9316.lee@samsung.com>
To:     adrian.hunter@intel.com, riteshh@codeaurora.org,
        asutoshd@codeaurora.org, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, sh043.lee@samsung.com,
        cw9316.lee@samsung.com
Subject: [PATCH] Unnecessary code change in spin_lock section.
Date:   Thu, 13 May 2021 11:33:07 +0900
Message-Id: <20210513023307.12435-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmvu7vCXMSDG59UbY4+WQNm8XethPs
        FjNOtbFa7Lt2kt3i19/17BY7np9ht7i8aw6bxZH//YwW+19fYLVo+rOPxeL42nAHbo/Lfb1M
        Hov3vGTyuHNtD5tH35ZVjB6fN8kFsEbl2GSkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpa
        WpgrKeQl5qbaKrn4BOi6ZeYAXaakUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTA0
        KNArTswtLs1L10vOz7UyNDAwMgWqTMjJ+NV+jrngGFvFgmvr2RoYD7N2MXJySAiYSGxc1MPS
        xcjFISSwg1Fi39z1zBDOJ0aJ9s1T2SCcz4wSH9acZ4Rp2ftrGlRiF6PE/LWnwRJCAl8YJd5O
        0Oti5OBgE9CSuH3MG6RGRGAho8TynhlsIDXMAjUS8xZ8ZwaxhQXsJG4f3s4EYrMIqEosavsM
        NodXwFpi+84l7BDL5CX+3O9hhogLSpyc+YQFYo68RPPW2WCnSgh8ZJdYsekpM0SDi8Sm1ceY
        IGxhiVfHt0ANkpJ42d/GDtHQzChxavY5KKeFUeL1lRtQVcYSnz6DnMEBtEJTYv0ufYiwosTO
        33MZITbzSbz72sMKUiIhwCvR0SYEUaIiMafrHBvMro83HkMD2ENiRtcFVkgAxUrs7F7KMoFR
        fhaSf2Yh+WcWwuIFjMyrGMVSC4pz01OLDQtMkKN1EyM4fWpZ7GCc+/aD3iFGJg7GQ4wSHMxK
        IrxiSbMThHhTEiurUovy44tKc1KLDzGaAkN4IrOUaHI+MIHnlcQbmhoZGxtbmJiZm5kaK4nz
        pjtXJwgJpCeWpGanphakFsH0MXFwSjUwZTBuPFp36X76ktqle158f8F4ODPd/sSlsrzwd4an
        V/r7NJ2S8Hgu53OSt6Ao9cyO39Wvp4gc2S0RbD7j7czY5O+M1ez/zt37dWBGa9fC6x9T5j9d
        L62dOX0q70WmWTbnapY7HQy9oLDLbv+MmrmbUrK+zLh/t+ibmLrUxSVOzYx3e0JUV91/F+9T
        ttQ+LS14dX+hXt6GSJ9tXDYnVZxu/2JWPaD7YrNZaOTbgvvuIam3C19KN+pNFK+W9F0mmCKx
        a+UnKe9ioxVFXz1P/+814ppuw7BWN7z5fHfPN12mDxoGQrd9/nYxXHx1eNOrxVMyWqV0goUX
        czZcvvZqVYx4leGkXXKzl/58P/8p8wu3HUosxRmJhlrMRcWJABUXuqcoBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsWy7bCSvO6vCXMSDCbMM7M4+WQNm8XethPs
        FjNOtbFa7Lt2kt3i19/17BY7np9ht7i8aw6bxZH//YwW+19fYLVo+rOPxeL42nAHbo/Lfb1M
        Hov3vGTyuHNtD5tH35ZVjB6fN8kFsEZx2aSk5mSWpRbp2yVwZfxqP8dccIytYsG19WwNjIdZ
        uxg5OSQETCT2/prG1sXIxSEksINRYs/PKYwQCSmJ3fvPAyU4gGxhicOHiyFqPjFKrH66lhEk
        ziagJXH7mDdIXERgOaPEr+07mUEcZoEmRomjBzrANggL2EncPrydCcRmEVCVWNT2GWwBr4C1
        xPadS9ghlslL/LnfwwwRF5Q4OfMJC4jNDBRv3jqbeQIj3ywkqVlIUgsYmVYxSqYWFOem5xYb
        FhjlpZbrFSfmFpfmpesl5+duYgQHs5bWDsY9qz7oHWJk4mA8xCjBwawkwiuWNDtBiDclsbIq
        tSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqbzBzvurb2Z4OPALvL8
        S9uMO7fWM7maZRwTWphzL6Q+s/DFhl3XF7jtdjFIdMxW9j7/8Ugi17KHz64wRnH+vnf18oGJ
        e61Fnhae1TQse1Z2cEnK8/W7FeLZ63M/zJl797NAwXfljZw+PvkOvRn/Nu5UFpWp/Ot5XLrz
        zIJtTA8nyjL3nzf/4cGpeXCD9JMNRgfXCO9u5JzpYaJ+Z721/feH1+sSnPgd6rZd6Go5+/gu
        l03Cn++yui1dcYdmSpUmSn/Mq3dXKNqlOHFq6bx21l8eO3md93Eb6P6uv/Lyq43zZ7bIfUq6
        fNXJ7Ouitv7nkq03PJF7+uOVa3xG20Q6LTTuWBU673193dGyf95hJz8lluKMREMt5qLiRABp
        f4lV1QIAAA==
X-CMS-MailID: 20210513023747epcas1p23502f390781d1a5a8f6512982af1fd65
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210513023747epcas1p23502f390781d1a5a8f6512982af1fd65
References: <CGME20210513023747epcas1p23502f390781d1a5a8f6512982af1fd65@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: ChanWoo Lee <cw9316.lee@samsung.com>

This is the spin_lock section for cq_host, and mmc setting is unnecessary.

Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
---
 drivers/mmc/host/cqhci-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index 93b0432bb601..4d76c858d45f 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -1090,8 +1090,8 @@ static void cqhci_recovery_finish(struct mmc_host *mmc)
 	spin_lock_irqsave(&cq_host->lock, flags);
 	cq_host->qcnt = 0;
 	cq_host->recovery_halt = false;
-	mmc->cqe_on = false;
 	spin_unlock_irqrestore(&cq_host->lock, flags);
+	mmc->cqe_on = false;
 
 	/* Ensure all writes are done before interrupts are re-enabled */
 	wmb();
-- 
2.29.0

