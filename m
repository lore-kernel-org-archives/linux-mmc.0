Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD17C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Oct 2021 04:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C19460FC1
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Oct 2021 04:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhJVECZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Oct 2021 00:02:25 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:48955 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhJVECY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Oct 2021 00:02:24 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20211022040006epoutp043465192c5ade11b913069a1c15ef4c4f~wPlaDI5wl3118331183epoutp04e
        for <linux-mmc@vger.kernel.org>; Fri, 22 Oct 2021 04:00:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20211022040006epoutp043465192c5ade11b913069a1c15ef4c4f~wPlaDI5wl3118331183epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1634875206;
        bh=4UyZVhI9cR2FpwOUUAJ4Gp7aJ9JMilV9jF0YMU1JarU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=qw/ZHpfAdyYaEEds83JLkUu6l1LjEvowyKzUI10A7LarHehEuxQxbAMZxhfbgIR6I
         oYrQUxEHnhVYd+NuFqioqjcgKhXUeUPArhI2etDcd3hL6IqSC7q3Xe84nfmwQvoHLj
         b5k2fMnHxEf/e57/2Dljf94p6N47+R7bo2RomFOA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211022040005epcas1p16e23f29510cb084d60fe9610d65331e8~wPlZw3v6K0917809178epcas1p1Y;
        Fri, 22 Oct 2021 04:00:05 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.233]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Hb9bh2zDsz4x9QB; Fri, 22 Oct
        2021 04:00:00 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.75.09592.04732716; Fri, 22 Oct 2021 13:00:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20211022035959epcas1p40ccc67175d6a4a22943e5836609fb834~wPlUGZXqy0365503655epcas1p4H;
        Fri, 22 Oct 2021 03:59:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211022035959epsmtrp26d1ab7ded64e4c78c4fae1067f98717d~wPlUFVAeQ3130231302epsmtrp2K;
        Fri, 22 Oct 2021 03:59:59 +0000 (GMT)
X-AuditID: b6c32a39-3bdff70000002578-8f-617237402066
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.CE.08902.F3732716; Fri, 22 Oct 2021 12:59:59 +0900 (KST)
Received: from jaehoon-DeskTop.10.32.193.11 (unknown [10.113.113.235]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211022035959epsmtip23ec042994b7ee177b905ed65de96c533~wPlTz0hrC2292322923epsmtip2Y;
        Fri, 22 Oct 2021 03:59:59 +0000 (GMT)
From:   Jaehoon Chung <jh80.chung@samsung.com>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, krzysztof.kozlowski@canonical.com,
        christianshewitt@gmail.com, mihailescu2m@gmail.com,
        m.szyprowski@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: dw_mmc: exynos: fix the finding clock sample value
Date:   Fri, 22 Oct 2021 13:00:41 +0900
Message-Id: <20211022040041.23156-1-jh80.chung@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmga6DeVGiwexWEYtXtyYzW9z41cZq
        sfHtDyaLI//7GS3WHrnLbrF+2k9Wi+Nrwx3YPWY19LJ57Jx1l93jzrU9bB59W1YxenzeJBfA
        GpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0hZJC
        WWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLRArzgxt7g0L10vL7XEytDAwMgUqDAh
        O+PauUeMBZP5Ko7/Ws3WwDiFu4uRk0NCwESi50cvWxcjF4eQwA5GiYZFP9lBEkICnxglrtyI
        hUh8Y5ToefOPGaajd9VmqI69jBI33x9ghXB+M0pc+nWXBaSKTUBHYvu340wgtoiArMTPPxfA
        OpgFtjNKfNm3GGyUsICHxIW7Kxi7GDk4WARUJdbO9AExeQWsJSY1pUEsk5f4c78HrJpXQFDi
        5MwnYOOZgeLNW2czg4yUELjELrH+xEUWiAYXie7NK9khbGGJV8e3QNlSEp/f7WWDsKsldjWf
        gWruYJS4ta2JCSJhLLF/6WQmkCOYBTQl1u/ShwgrSuz8PZcRYjGfxLuvPawgJRICvBIdbUIQ
        JSoSl16/ZIJZdffJf1YI20PianczCyREYyX+/utkmsAoPwvJO7OQvDMLYfECRuZVjGKpBcW5
        6anFhgWm8EhNzs/dxAhOiFqWOxinv/2gd4iRiYPxEKMEB7OSCO/uivxEId6UxMqq1KL8+KLS
        nNTiQ4ymwOCdyCwlmpwPTMl5JfGGJpYGJmZGxiYWhmaGSuK8X+QKE4UE0hNLUrNTUwtSi2D6
        mDg4pRqYuKc5m5RN+ycUL+9fEHmoU0V+6kE/x+AXOx5pXvZLWHOWq78lc+/vR9kvRLj3z+WO
        cLq8MH/hmvIP23bECM7gquVflXb1VWJugZeBdIWQaxNb9DkW65dNN8Siq4I93zYxVnmYXZr1
        5rTGjMmndi2dopw4/dd/xaPOWjuTMyeHyHBMfdgfOfV6ObOxLr9CsrBekF3dX/MGtr5vW9Zx
        Gr3P/fqGe/rOntnxytWJ01SFd8Q8Zf9cZ3fZ27z0rKR9lh0X82L/1gbdO3ZJi26LO798G5ny
        1cZR7sQ+o18LVml+Myhdcuf1yqK4f1LRB3P0StfznJQ5sebT1q9RPjPTYl5zTJzy4DpLAlvx
        +ve2y14psRRnJBpqMRcVJwIAwamMiBEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsWy7bCSvK69eVGiwemZMhavbk1mtrjxq43V
        YuPbH0wWR/73M1qsPXKX3WL9tJ+sFsfXhjuwe8xq6GXz2DnrLrvHnWt72Dz6tqxi9Pi8SS6A
        NYrLJiU1J7MstUjfLoEr49q5R4wFk/kqjv9azdbAOIW7i5GTQ0LARKJ31Wa2LkYuDiGB3YwS
        /068ZYFISEl8fjoVKMEBZAtLHD5cDFHzk1Hi/LLXbCA1bAI6Etu/HWcCsUUEZCV+/rkANohZ
        YC+jxK+f7xlBEsICHhIX7q5gBBnEIqAqsXamD4jJK2AtMakpDWKVvMSf+z3MIDavgKDEyZlP
        wE5gBoo3b53NPIGRbxaS1CwkqQWMTKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYID
        VEtzB+P2VR/0DjEycTAeYpTgYFYS4d1dkZ8oxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4
        IYH0xJLU7NTUgtQimCwTB6dUA9PRD73lK81+/Hfe/ehgzOHVvt4W/k39FSs4/x7V8tlecfpJ
        reuV8EmNH45NS/xsfqLGasXJlz1qLi4VezVOLDPl/BWVujgxSd7WW15Svodj0ffWhP6z8a+8
        LWVeNwS6qe4QvTvxxeqTx5aZPFlklLbDfHL6tJXV193PV3aKMWpY+Umt3qBsqBo6Z+U/yTde
        Kb+f7WX7f1vPbq3CW313+dPCYbNFV7a9sp3/JHue0IvAyxMj1fVvZu175ntV+8PvXbOue7u+
        yU9TW3vd48Cq2I+R65W1hEX26BmUn/4aH/ijpjdjw2WTvNcn7AJjzs3lO3Pw+LyeA8ZtrT2d
        4c2hlR+NFH00vKJOaki94drhx6fEUpyRaKjFXFScCADkmigFvwIAAA==
X-CMS-MailID: 20211022035959epcas1p40ccc67175d6a4a22943e5836609fb834
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211022035959epcas1p40ccc67175d6a4a22943e5836609fb834
References: <CGME20211022035959epcas1p40ccc67175d6a4a22943e5836609fb834@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Even though there are candiates value if can't find best value, it's
returned -EIO. It's not proper behavior.
If there is not best value, use a first candiate value to work eMMC.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc-exynos.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 0c75810812a0..a475c249c430 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -431,6 +431,7 @@ static inline u8 dw_mci_exynos_move_next_clksmpl(struct dw_mci *host)
 		clksel = mci_readl(host, CLKSEL);
 
 	sample = (clksel + 1) & 0x7;
+
 	clksel = SDMMC_CLKSEL_UP_SAMPLE(clksel, sample);
 
 	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
@@ -464,6 +465,14 @@ static s8 dw_mci_exynos_get_best_clksmpl(u8 candiates)
 		}
 	}
 
+	/* Return a first candiates value, if there is some candiates */
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
@@ -493,7 +502,18 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 		dw_mci_exynos_set_clksmpl(host, found);
 		priv->tuned_sample = found;
 	} else {
-		ret = -EIO;
+		/*
+		 * If there is no cadiates value, then it needs to return -EIO.
+		 * If there are candiates values and don't find bset clk sample value,
+		 * then use a first candiates clock sample value.
+		 */
+		if (candiates == 0) {
+			ret = -EIO;
+			dev_warn(&mmc->class_dev,
+				"There is no candiates value about clksmpl!\n");
+		} else {
+			priv->tuned_sample = dw_mci_exynos_get_clksmpl(host);
+		}
 	}
 
 	return ret;
-- 
2.29.0

