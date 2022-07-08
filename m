Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F34C433EF
	for <linux-mmc@archiver.kernel.org>; Fri,  8 Jul 2022 07:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbiGHHHv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 Jul 2022 03:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237225AbiGHHHt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Jul 2022 03:07:49 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD7074DD0
        for <linux-mmc@vger.kernel.org>; Fri,  8 Jul 2022 00:07:47 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220708070741epoutp026867c9595d65349e4ffb75e7bea38e8e~-yOImbhCD3048030480epoutp02P
        for <linux-mmc@vger.kernel.org>; Fri,  8 Jul 2022 07:07:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220708070741epoutp026867c9595d65349e4ffb75e7bea38e8e~-yOImbhCD3048030480epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657264061;
        bh=3sAUnCPgzNJbIiKchzsuPOVicgg3yR+kx/g7PcPbcDY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=TZ8nxvt076GJloTwBI8RI0QxQ9kin/rBMmFyxNIALqqaNHzHlVCfi5kHbzlKEcrgB
         xfQ2O6IRXcUCw86Z7vCJPUxojeLUENqAe3gky+kPcYaQkTcwNqluH8o6955uvS6FSN
         lhij8F5oIPAM1B5FYgsL7EmHAhINOTkNFuSvfwfk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220708070741epcas1p3c43a5548f3548d40106306eb0aa9e2b0~-yOIOIH5W2311323113epcas1p3V;
        Fri,  8 Jul 2022 07:07:41 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.224]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LfPVh5km9z4x9QG; Fri,  8 Jul
        2022 07:07:40 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        C6.30.09661.BB7D7C26; Fri,  8 Jul 2022 16:07:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220708070739epcas1p1332ce8a480181e094082b20da290f8fc~-yOGhTLTx1207612076epcas1p1W;
        Fri,  8 Jul 2022 07:07:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220708070739epsmtrp2e5a961a75bd036a835eeb5d7c95024e8~-yOGgoove3080530805epsmtrp2v;
        Fri,  8 Jul 2022 07:07:39 +0000 (GMT)
X-AuditID: b6c32a37-2b9ff700000025bd-df-62c7d7bb921f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.32.08905.BB7D7C26; Fri,  8 Jul 2022 16:07:39 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220708070739epsmtip2fad69196524cd4d0b0b29b238adc48af~-yOGXQXym1658216582epsmtip2v;
        Fri,  8 Jul 2022 07:07:39 +0000 (GMT)
From:   Chanwoo Lee <cw9316.lee@samsung.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     ChanWoo Lee <cw9316.lee@samsung.com>
Subject: [PATCH] Fix potential NULL pointer error in sdhci_calc_sw_timeout
Date:   Fri,  8 Jul 2022 16:03:53 +0900
Message-Id: <20220708070353.32624-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsWy7bCmru7u68eTDB48U7Q4+WQNm8WMU22s
        Fkf+9zNaHF8b7sDisXjPSyaPO9f2sHn0bVnF6PF5k1wAS1S2TUZqYkpqkUJqXnJ+SmZeuq2S
        d3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QRiWFssScUqBQQGJxsZK+nU1RfmlJqkJG
        fnGJrVJqQUpOgVmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsbFw1MZCz7xVEy9JNTAeIqri5GT
        Q0LARGLOn4+sXYxcHEICOxgl/k3qZodwPjFK7GpqhnK+MUo8uvuUDaZl9701TBCJvYwSd7rP
        M4EkhAS+MEpc7vTsYuTgYBPQkrh9zBskLCIQIPFqZT8LiM0soCFxctYTdhBbWMBL4u26JYwg
        NouAqsTJZ6fBxvAKWEtcvDePHWKXvMSf+z3MEHFBiZMzn0DNkZdo3jqbGeQGCYFN7BLHl3az
        QjS4SJzqWMMCYQtLvDq+BWqQlMTnd3vZIBqaGSW2fb3EBOF0MEpsbH3BCFFlLPHp82dGkA+Y
        BTQl1u/ShwgrSuz8PZcRYjOfxLuvPawgJRICvBIdbUIQJSoSc7rOscHs+njjMdQ9HhJrZzUz
        QsInVuLFrLfMExjlZyH5ZxaSf2YhLF7AyLyKUSy1oDg3PbXYsMAYHqnJ+bmbGMGJTst8B+O0
        tx/0DjEycTAeYpTgYFYS4Y1XPp4kxJuSWFmVWpQfX1Sak1p8iNEUGMITmaVEk/OBqTavJN7Q
        xNLAxMzIxMLY0thMSZx31bTTiUIC6YklqdmpqQWpRTB9TBycUg1Mgl/zpwmdiHO+ZfxnbleW
        q+1f/en2y/W/t3VKtZfMCG2/w3XR5fj3492//f7zOVWuzjsp7xuZ49vAdO6gRN6end7d55/u
        WByUL/pM1ljuT7LWy21KbTL5bnUV1yV3s7vxH289cuTPFJcHE5VqZfoua389532l1cyqPsHw
        b/HW4tP3qs1yPmrct2rgmxeukG33b2VuQsAyD/Yj+T951P4VLPnHYxHVNFklcUvQyiPr7nbO
        nBug+Ob3/aZcrYt+fzvlC8V2Kv898miZOvdT95cHp50pUzp7MC1Qfn/bbY9Cu/TGmxqKZY/l
        leS4H//4nBiqLZ3Fvl5IW9R2Z3Sph8reObwKe91VOERmpcyasEiJpTgj0VCLuag4EQBiHsYv
        /QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOLMWRmVeSWpSXmKPExsWy7bCSvO7u68eTDI6d4bE4+WQNm8WMU22s
        Fkf+9zNaHF8b7sDisXjPSyaPO9f2sHn0bVnF6PF5k1wASxSXTUpqTmZZapG+XQJXxsXDUxkL
        PvFUTL0k1MB4iquLkZNDQsBEYve9NUxdjFwcQgK7GSWmbdnEDJGQkti9/zxbFyMHkC0scfhw
        MUTNJ5Cap6wgcTYBLYnbx7xBykUEgiTWPz/HBmIzC2hInJz1hB3EFhbwkni7bgkjiM0ioCpx
        8tlpJhCbV8Ba4uK9eewQq+Ql/tzvYYaIC0qcnPmEBWKOvETz1tnMExj5ZiFJzUKSWsDItIpR
        MrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzjstDR3MG5f9UHvECMTB+MhRgkOZiUR3njl
        40lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MCn+0lOf
        lzOrfVJi6zWxxy+yTJ3mpzZ/jPjHf2Xpz3n7vh28yPecfd6umhMXpCsbJwVvubU5ffNzswZe
        lo9rCyXf6v8XmXp53e951wofzopS1LrIP+mzazVL3NfY4MVn+q3eWb/7O1tio3XXUZ7nma2J
        9mlfqiclLdGrPi52Zsqppz/STlqpPLjx55Xg+38cV1njfMyk5y8Ldtuxe9b3ncyxysqTptwQ
        Whslm+ZySzHde8PvrRPDi/uPRq3KdDfQcbT887NNUi6zL7Vth5XHSUMLLoVJC1c0HO5ao8Up
        XXNI+GOB1yGbTGvnfavWScbbBzTMsrkWHR566YBUn8yJJdJXgntXf/zzYvO1pCBPTWYlluKM
        REMt5qLiRACVfQK7qgIAAA==
X-CMS-MailID: 20220708070739epcas1p1332ce8a480181e094082b20da290f8fc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220708070739epcas1p1332ce8a480181e094082b20da290f8fc
References: <CGME20220708070739epcas1p1332ce8a480181e094082b20da290f8fc@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: ChanWoo Lee <cw9316.lee@samsung.com>

In sdhci_cqe_enable(), a NULL value is used as an argument.

* sdhci_set_timeout(host, NULL);
 -> __sdhci_set_timeout(host, cmd);
    -> sdhci_calc_sw_timeout(host,cmd)

The current code doesn't have any problems with the 'too_big' variable.
-------------------------------------------------------------------------
void __sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
{
        bool too_big = false;
        u8 count = sdhci_calc_timeout(host, cmd, &too_big);

        if (too_big &&
            host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT) {
                sdhci_calc_sw_timeout(host, cmd);
}
------------------------------------------------------------------------

However, if the code related to the 'too_big' variable changes
a null value may be used in the sdhci_calc_sw_timeout function.

To remove this dependency, add code to check 'cmd' once more.

Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
---
 drivers/mmc/host/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7689ffec5ad1..e5a840097308 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1029,7 +1029,7 @@ void __sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 	bool too_big = false;
 	u8 count = sdhci_calc_timeout(host, cmd, &too_big);
 
-	if (too_big &&
+	if (too_big && cmd &&
 	    host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT) {
 		sdhci_calc_sw_timeout(host, cmd);
 		sdhci_set_data_timeout_irq(host, false);
-- 
2.29.0

