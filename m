Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948FBC433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Feb 2022 14:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbiBKOA1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Feb 2022 09:00:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240055AbiBKOA0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Feb 2022 09:00:26 -0500
X-Greylist: delayed 390 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 06:00:24 PST
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3DB383
        for <linux-mmc@vger.kernel.org>; Fri, 11 Feb 2022 06:00:24 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220211135351epoutp01cd5dad2d6a41caf2183a3d2fd495f7de~Sv7zdc_3_2941629416epoutp01I
        for <linux-mmc@vger.kernel.org>; Fri, 11 Feb 2022 13:53:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220211135351epoutp01cd5dad2d6a41caf2183a3d2fd495f7de~Sv7zdc_3_2941629416epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644587631;
        bh=8cezIy141LnAGTrEqGD5hiu4yfKYG/XvPkNi2khhjNI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=TeqGcYUpswZNmVmi8eGNLCp4pvg3hSa8UbUoQxP9Wp0aKyI3pqU2UIl8MEYchtWQQ
         QDucs7l0KRHhYFVTIeOViVOon9hUJRriHvZLjIa2rgZZtdQlZohAHtPlqd2oagd9F9
         RGvcU3nKOGi+hBlQ4Kd0f1spUQH8rz3cVYc/tCLs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220211135350epcas5p1559205421221cbff47cf2d761d2e1234~Sv7yghy_H0404204042epcas5p1-;
        Fri, 11 Feb 2022 13:53:50 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JwFT56x2Jz4x9Pp; Fri, 11 Feb
        2022 13:53:45 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.85.05590.C5A66026; Fri, 11 Feb 2022 22:53:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220211120808epcas5p31f6a3bf93945f34d23840ed9e455f8ab~SuffrMyv81161911619epcas5p34;
        Fri, 11 Feb 2022 12:08:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220211120808epsmtrp1bd207e6797a7eb578a39b128302979ed~SuffqSB-T2966329663epsmtrp1d;
        Fri, 11 Feb 2022 12:08:08 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-0f-62066a5c76e3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.26.29871.8A156026; Fri, 11 Feb 2022 21:08:08 +0900 (KST)
Received: from test.sa.corp.samsungelectronics.net (unknown [107.99.43.140])
        by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220211120806epsmtip18f6c412ac4af2453d6b4e1134ffc57ea~SufeU6Vph0541405414epsmtip1M;
        Fri, 11 Feb 2022 12:08:06 +0000 (GMT)
From:   Shankar Athanikar <shankar.ma@samsung.com>
To:     linux-mmc@vger.kernel.org, avri.altman@wdc.com, chris@printf.net,
        ulf.hansson@linaro.org
Cc:     puneet.5@samsung.com, sumeet.paul@samsung.com,
        akhilesh.j@samsung.com, Shankar Athanikar <shankar.ma@samsung.com>,
        Mohan Raj Veerasamy <mohanraj.v@samsung.com>
Subject: [PATCH v2] Enhancement to do_status_get() function for detailed
 Response info
Date:   Fri, 11 Feb 2022 17:34:49 +0530
Message-Id: <20220211120449.195052-1-shankar.ma@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdlhTXTcmiy3JoGW/qcXj5v3sFi9/XmWz
        mHB5O6PFkf/9QOJwK6vFg0tvWCw29SpaHPm3lc3i+NpwB06PO9f2sHnceLWQyaNvyypGj8+b
        5DzaD3QzBbBGZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+ATo
        umXmAJ2jpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEy
        NDAwMgUqTMjOuDz7BlNBg1rF/2mODYwXZLoYOTkkBEwkTh45xd7FyMUhJLCbUWLJ/n8sEM4n
        RolJ11qhnG+MEl+737LDtDRfusIIYgsJ7AWqegLV3sgksfLYUWaQBJuAgcT9GSeBujk4RATi
        JM69ygWpYRZYziixfUkHWI2wQITEna2PmUBsFgFVia27Z4DFeQVsJOZeOsUCsUxeYual7+wQ
        cUGJkzOfgMWZgeLNW2czgwyVELjGLjF31TSo61wk7k1exAxhC0u8Or4FKi4l8bK/jR2ioZ1R
        4uOkKWwQzgRGif4vS5ggquwl+mY+ZQI5m1lAU2L9Ln2IsKzE1FPrmCA280n0/n4CVc4rsWPe
        E7ByCQEVibkTa2F2/fl1hQ3C9pDYd/kKCyS0YiX+HX3APIFRfhaSf2Yh+WcWwuIFjMyrGCVT
        C4pz01OLTQuM81LL4RGbnJ+7iRGcKrW8dzA+evBB7xAjEwfjIUYJDmYlEd4VN1iThHhTEiur
        Uovy44tKc1KLDzGaAgN5IrOUaHI+MFnnlcQbmlgamJiZmZlYGpsZKonznkrfkCgkkJ5Ykpqd
        mlqQWgTTx8TBKdXA5Dwpo0zkqk3LtvPPoq6UXQqaW5Zgd5ptae/aycdmR/pcvSOboP675Bav
        cir/DAudACHhkzPlOzjdj258KHKnfEmY45PIfKcNXg+OBbTWTI4PNzhxPCbjXcqjK1OWxb36
        90nio9LB6Oo7fnYmx487MhbtkdM0+L5KYsmXHftf7+HY9/Z201Ld2B3i2sXrrrubxD7d+cNo
        fY70tB9T+v6tuuL56bnOVO3PBrcNfkSlngncdufitJg/nNuPnP/50CjT+9ClJPtSucXq5kxR
        ulc9i+/YyXGkHt41c0r69rOOje2Ba92r/R2XKs76oVHNJia3O33uyYCdYZfzZikHL7MLZoyb
        lbFpvfRmiVud895cl1ZiKc5INNRiLipOBABAmwBKHgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSnO6KQLYkgy3buSweN+9nt3j58yqb
        xYTL2xktjvzvBxKHW1ktHlx6w2KxqVfR4si/rWwWx9eGO3B63Lm2h83jxquFTB59W1Yxenze
        JOfRfqCbKYA1issmJTUnsyy1SN8ugSvj8uwbTAUNahX/pzk2MF6Q6WLk5JAQMJFovnSFEcQW
        EtjNKHH0VgREXEpiad9XJghbWGLlv+fsXYxcQDX/GSU2dbWzgCTYBAwk7s84CWaLCCRJTLje
        xARSxCywmlGi+/F9NpCEsECYxM0z88AmsQioSmzdPYMZxOYVsJGYe+kUC8QGeYmZl76zQ8QF
        JU7OfAIWZwaKN2+dzTyBkW8WktQsJKkFjEyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNz
        NzGCg1ZLcwfj9lUf9A4xMnEwHmKU4GBWEuFdcYM1SYg3JbGyKrUoP76oNCe1+BCjNAeLkjjv
        ha6T8UIC6YklqdmpqQWpRTBZJg5OqQYmozv+wusLN4b1aV85eTjTc9dlw012fhvLl3h1f7Vf
        y6IdE20YW934vCCvdc6ZyZo3b8/0TOn7sXH9z+88HMciWhZ5xG31bjhaNFHPZfvtvV3Zqr/n
        NBXoyHje/mKVvX65xvY5U1MPWL7vPeE9byJz0zXf2UKCeo8aftdempqnUcTD6LE8/XXmz3PL
        HJ6XWN1/uzK1+5PFupM8P2VDZEODVBRfe1/8lJ2TtX2RwuNDyR6mr1btKEt8m881+82VDz/3
        c/Gn37+Zx1B9dH55ou+p30yBp/pjbj3+P8ltwfKFP/b9PnmF7e2fy4+Md+tkFT0M2L9Et4Lr
        59aX6vnLZVRVpzrZFj1MC1jgae6asa4iUomlOCPRUIu5qDgRALgArqLJAgAA
X-CMS-MailID: 20220211120808epcas5p31f6a3bf93945f34d23840ed9e455f8ab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220211120808epcas5p31f6a3bf93945f34d23840ed9e455f8ab
References: <CGME20220211120808epcas5p31f6a3bf93945f34d23840ed9e455f8ab@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This enhancement covers detailed status register decoding with 
ERROR/STATUS information when host sends CMD13(with SQS=0)

Signed-off-by: Shankar Athanikar <shankar.ma@samsung.com>
Reviewed-by: Mohan Raj Veerasamy <mohanraj.v@samsung.com>
---
change log V1 -> V2

1. Added #defines for R1 Response device status fields.
2. Code cleanup and addressed Review comments from Ulf
Hansson<ulf.hansson@linaro.org>.
---
 mmc.h      | 22 ++++++++++++++
 mmc_cmds.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/mmc.h b/mmc.h
index e9766d7..193dfee 100644
--- a/mmc.h
+++ b/mmc.h
@@ -44,6 +44,28 @@
 					      [1] Discard Enable
 					      [0] Identify Write Blocks for
 					      Erase (or TRIM Enable)  R1b */
+
+#define R1_OUT_OF_RANGE         (1 << 31)       /* er, c */
+#define R1_ADDRESS_ERROR        (1 << 30)       /* erx, c */
+#define R1_BLOCK_LEN_ERROR      (1 << 29)       /* er, c */
+#define R1_ERASE_SEQ_ERROR      (1 << 28)       /* er, c */
+#define R1_ERASE_PARAM          (1 << 27)       /* ex, c */
+#define R1_WP_VIOLATION         (1 << 26)       /* erx, c */
+#define R1_CARD_IS_LOCKED       (1 << 25)       /* sx, a */
+#define R1_LOCK_UNLOCK_FAILED   (1 << 24)       /* erx, c */
+#define R1_COM_CRC_ERROR        (1 << 23)       /* er, b */
+#define R1_ILLEGAL_COMMAND      (1 << 22)       /* er, b */
+#define R1_CARD_ECC_FAILED      (1 << 21)       /* ex, c */
+#define R1_CC_ERROR             (1 << 20)       /* erx, c */
+#define R1_ERROR                (1 << 19)       /* erx, c */
+#define R1_CID_CSD_OVERWRITE    (1 << 16)       /* erx, c, CID/CSD overwrite */
+#define R1_WP_ERASE_SKIP        (1 << 15)       /* sx, c */
+#define R1_CARD_ECC_DISABLED    (1 << 14)       /* sx, a */
+#define R1_ERASE_RESET          (1 << 13)       /* sr, c */
+#define R1_READY_FOR_DATA       (1 << 8)        /* sx, a */
+#define R1_EXCEPTION_EVENT      (1 << 6)        /* sr, a */
+#define R1_APP_CMD              (1 << 5)        /* sr, c */
+
 /*
  * EXT_CSD fields
  */
diff --git a/mmc_cmds.c b/mmc_cmds.c
index f024079..94916d2 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -848,6 +848,8 @@ int do_status_get(int nargs, char **argv)
 	__u32 response;
 	int fd, ret;
 	char *device;
+	const char *str;
+	__u8 state;
 
 	if (nargs != 2) {
 		fprintf(stderr, "Usage: mmc status get </path/to/mmcblkX>\n");
@@ -869,7 +871,90 @@ int do_status_get(int nargs, char **argv)
 	}
 
 	printf("SEND_STATUS response: 0x%08x\n", response);
 
+	if (response & R1_OUT_OF_RANGE)
+		printf("ERROR: ADDRESS_OUT_OF_RANGE\n");
+	if (response & R1_ADDRESS_ERROR)
+		printf("ERROR: ADDRESS_MISALIGN\n");
+	if (response & R1_BLOCK_LEN_ERROR)
+		printf("ERROR: BLOCK_LEN_ERROR\n");
+	if (response & R1_ERASE_SEQ_ERROR)
+		printf("ERROR: ERASE_SEQ_ERROR\n");
+	if (response & R1_ERASE_PARAM)
+		printf("ERROR: ERASE_PARAM_ERROR\n");
+	if (response & R1_WP_VIOLATION)
+		printf("ERROR: WP_VOILATION\n");
+	if (response & R1_CARD_IS_LOCKED)
+		printf("STATUS: DEVICE_IS_LOCKED\n");
+	if (response & R1_LOCK_UNLOCK_FAILED)
+		printf("ERROR: LOCK_UNLOCK_IS_FAILED\n");
+	if (response & R1_COM_CRC_ERROR)
+		printf("ERROR: COM_CRC_ERROR\n");
+	if (response & R1_ILLEGAL_COMMAND)
+		printf("ERROR: ILLEGAL_COMMAND\n");
+	if (response & R1_CARD_ECC_FAILED)
+		printf("ERROR: DEVICE_ECC_FAILED\n");
+	if (response & R1_CC_ERROR)
+		printf("ERROR: CC_ERROR\n");
+	if (response & R1_ERROR)
+		printf("ERROR: ERROR\n");
+	if (response & R1_CID_CSD_OVERWRITE)
+		printf("ERROR: CID/CSD OVERWRITE\n");
+	if (response & R1_WP_ERASE_SKIP)
+		printf("ERROR: WP_ERASE_SKIP\n");
+	if (response & R1_ERASE_RESET)
+		printf("ERROR: ERASE_RESET\n");
+
+	state = (response >> 9) & 0xF;
+	switch (state) {
+	case 0:
+		str = "IDLE";
+		break;
+	case 1:
+		str = "READY";
+		break;
+	case 2:
+		str = "IDENT";
+		break;
+	case 3:
+		str = "STDBY";
+		break;
+	case 4:
+		str = "TRANS";
+		break;
+	case 5:
+		str = "DATA";
+		break;
+	case 6:
+		str = "RCV";
+		break;
+	case 7:
+		str = "PRG";
+		break;
+	case 8:
+		str = "DIS";
+		break;
+	case 9:
+		str = "BTST";
+		break;
+	case 10:
+		str = "SLP";
+		break;
+	default:
+		printf("Attention : Device state is INVALID: Kindly check the Response\n");
+		goto out_free;
+	}
+
+	printf("DEVICE STATE: %s\n", str);
+	if (response & R1_READY_FOR_DATA)
+		printf("STATUS: READY_FOR_DATA\n");
+	if (response & R1_SWITCH_ERROR)
+		printf("ERROR: SWITCH_ERROR\n");
+	if (response & R1_EXCEPTION_EVENT)
+		printf("STATUS: EXCEPTION_EVENT\n");  /* Check EXCEPTION_EVENTS_STATUS fields for further actions */
+	if (response & R1_APP_CMD)
+		printf("STATUS: APP_CMD\n");
+out_free:
 	close(fd);
 	return ret;
 }

-- 
2.25.1
