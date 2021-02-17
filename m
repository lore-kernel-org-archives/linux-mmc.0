Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CA8C4332B
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Feb 2021 05:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2CB264E2E
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Feb 2021 05:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhBQFdc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Feb 2021 00:33:32 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:34780 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhBQFda (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Feb 2021 00:33:30 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210217053244epoutp013eeede90ac3e7ed7f6683ee3a8f64267~kcgyOjaPv2179421794epoutp01Y
        for <linux-mmc@vger.kernel.org>; Wed, 17 Feb 2021 05:32:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210217053244epoutp013eeede90ac3e7ed7f6683ee3a8f64267~kcgyOjaPv2179421794epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613539964;
        bh=0Qu3UhubXL/3n9cgBIbiKKoOt4KQtprWcRcKbSHb1jI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hgKfiKYMnwo3/UC28Fxk0MzRWwxV4NeCxaOQa5oGoHH9TbBfitRPPu/IpmJ/Fnauy
         JQIWXtLlkFGgC9frnYOevBuUqS6RySg+gPkyBQcJdSDcewilwa6CaiTs6SFAaGK+Bm
         4YOPzJDbuU5Z2t3rODRCc/6UqVwxQ8kt2Nugt3jQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210217053242epcas1p2a7689ccd45d862292fc43cffe78c255a~kcgwj37nk1434914349epcas1p2X;
        Wed, 17 Feb 2021 05:32:42 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.165]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DgRLf0FCHz4x9Q3; Wed, 17 Feb
        2021 05:32:42 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.07.63458.97AAC206; Wed, 17 Feb 2021 14:32:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210217053240epcas1p44ae9b8ae5bd4fe792317cfe0fe683f98~kcguTxZcL1846318463epcas1p41;
        Wed, 17 Feb 2021 05:32:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210217053240epsmtrp1b2ac8637474f4277dc0e36812ec0b610~kcguS0I5e1493814938epsmtrp1Q;
        Wed, 17 Feb 2021 05:32:40 +0000 (GMT)
X-AuditID: b6c32a36-6c9ff7000000f7e2-a5-602caa79f245
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.CE.13470.87AAC206; Wed, 17 Feb 2021 14:32:40 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.101.61]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210217053240epsmtip17445ec263eea634ae539914a3945029e~kcguBCnJl2769427694epsmtip1P;
        Wed, 17 Feb 2021 05:32:40 +0000 (GMT)
From:   DooHyun Hwang <dh0421.hwang@samsung.com>
To:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ulf.hansson@linaro.org,
        robh+dt@kernel.org, axboe@kernel.dk, adrian.hunter@intel.com,
        satyat@google.com, baolin.wang@linaro.org, ebiggers@google.com,
        gustavoars@kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        junwoo80.lee@samsung.com, jangsub.yi@samsung.com,
        sh043.lee@samsung.com, cw9316.lee@samsung.com,
        sh8267.baek@samsung.com, wkon.kim@samsung.com,
        DooHyun Hwang <dh0421.hwang@samsung.com>
Subject: [PATCH 1/2] dt-bindings: mmc: Add no-single-read-retry property
Date:   Wed, 17 Feb 2021 14:19:38 +0900
Message-Id: <20210217051939.13695-2-dh0421.hwang@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210217051939.13695-1-dh0421.hwang@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCJsWRmVeSWpSXmKPExsWy7bCmgW7lKp0Eg7bZFhYnn6xhs1h9t5/N
        4lPDFWaLGafaWC3mHznHarHv2kl2i4urW1gtfv1dz27x6+I0VouOrZOZLHY8P8NusetvM5PF
        5V1z2CyO/O9ntGjde4Tdon/1XTaLpj/7WCyunTnBanF8bbjF5kvfWBxEPBZsKvVYvOclk8fl
        s6Uem1Z1snncubaHzaNvyypGj8+b5ALYo3JsMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1
        DS0tzJUU8hJzU22VXHwCdN0yc4DeUVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQU
        GBoU6BUn5haX5qXrJefnWhkaGBiZAlUm5GTM2T+LqeADR8WSXfuZGxjXsHcxcnJICJhIzLy9
        lbmLkYtDSGAHo8S69R/ZIZxPjBI9f5azQDjfGCV2/ZrFAtMyvfEAG0RiL6PEss//GCGcz4wS
        T07PZwSpYhPQk9jTu4oVJCEi0MUkcffvIbAWZoGPjBILb71mA6kSFvCQWPlkKyuIzSKgKrH0
        9AGws3gFbCXur9jLBrFPXuLP/R5mEJtTwE6i9/NbVogaQYmTM5+A3cQMVNO8dTYzRP0NDol9
        dwu7GDmAbBeJty1OEGFhiVfHt0B9LSXxsr8Nyu5mlOg/ZAdym4TABEaJy8d7oPYaS3z6/JkR
        ZA6zgKbE+l36EGFFiZ2/5zJCrOWTePe1hxViFa9ER5sQRImaxOJ/34FK2IFsGYlGbogCD4kH
        +/ghITWRUeL8k5WMExgVZiF5ZRaSV2YhrF3AyLyKUSy1oDg3PbXYsMAIOYI3MYKTt5bZDsZJ
        bz/oHWJk4mA8xCjBwawkwsv+WStBiDclsbIqtSg/vqg0J7X4EKMpMKAnMkuJJucD80deSbyh
        qZGxsbGFiZm5mamxkjhvosGDeCGB9MSS1OzU1ILUIpg+Jg5OqQam0KvnStVZ7tgf5ApiV6nn
        3+605PWCNYcm9jYr2HAvv3b9NdODo6GP+qwdNb9WvlOtMdKefKfc+9llfYV14Wfuut/f9DVv
        Hu/cU4anf9i//z71oufmk7INwiFb2zJnczQwhLRwcTFViMzhVJBpVOD74rFygbjRlEyFSZvm
        MKzcpn9uivGex2F+5zb8Nr3v1RFps/PN/PVHmfJlmm6tbF4iy9n7LJL5/z+u4NkdgdKX4tTP
        PLPqEnu4+O+Ti3MSLq0I61iY16stnpYjYtK101xd5P671amMQee1V3y78GrNoeM7/SX1Cptu
        Bt71Ffvy8wyX9JKsFXWtEev4L9xc9fZz0Hn5nB0LlXNLVSouMez/r8RSnJFoqMVcVJwIAHl9
        KBFnBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJTrdilU6CQWuTtMXJJ2vYLFbf7Wez
        +NRwhdlixqk2Vov5R86xWuy7dpLd4uLqFlaLX3/Xs1v8ujiN1aJj62Qmix3Pz7Bb7PrbzGRx
        edccNosj//sZLVr3HmG36F99l82i6c8+FotrZ06wWhxfG26x+dI3FgcRjwWbSj0W73nJ5HH5
        bKnHplWdbB53ru1h8+jbsorR4/MmuQD2KC6blNSczLLUIn27BK6MOftnMRV84KhYsms/cwPj
        GvYuRk4OCQETiemNB9i6GLk4hAR2M0q8m7GLDSIhI9F9fy9QEQeQLSxx+HAxSFhI4COjxLU7
        diA2m4CexJ7eVawgvSICM5gkDh1+wg7iMAv8ZpSY9KMZbIOwgIfEyidbWUFsFgFViaWnD4DF
        eQVsJe6v2Au1TF7iz/0eZhCbU8BOovfzW1aIbbYSZ+d/ZIGoF5Q4OfMJmM0MVN+8dTbzBEaB
        WUhSs5CkFjAyrWKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI4zLc0djNtXfdA7xMjE
        wXiIUYKDWUmEl/2zVoIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotg
        skwcnFINTMv2yAv7+mj0ajxaHrzi2Em/uB97fn+IeuAbwLNXtS2Fe8qRmG1nV6Qu6ha6Kbh6
        f2PbvlURzI8q445sPP/i+9XIv0vXTP+pIyYUtWnLzXeGbiJT7q/8mmwae+T5r/8p854t0zt3
        hdm6/d8KO7dYC46A2iO3ePX/Wjz5M63EY/tPxT9PIqzYLdV5k6tXvhCK3FHyNlA1PHZX7K16
        9X97Vs85zXfMuyIiNT0hhKNEcD/LnSXaN/+KGk67UhMdFCDnvz19itzJvbWris1YXmyTOvCo
        hZdj3vS1C/udpDbt0AyayJ2ZVfHU4LNz8Cq35XXmVvsu7jE+w7xC/0L5E6dlPQVWlQ+0Kg8E
        q7DEZDeXPlRiKc5INNRiLipOBAAH+pMWIgMAAA==
X-CMS-MailID: 20210217053240epcas1p44ae9b8ae5bd4fe792317cfe0fe683f98
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210217053240epcas1p44ae9b8ae5bd4fe792317cfe0fe683f98
References: <20210217051939.13695-1-dh0421.hwang@samsung.com>
        <CGME20210217053240epcas1p44ae9b8ae5bd4fe792317cfe0fe683f98@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add an optional property to not retry multiple block read error
with several single block reads.

This property makes to handle read errors faster by not retrying
multiple block read errors with single block reads.

Signed-off-by: DooHyun Hwang <dh0421.hwang@samsung.com>
---
 Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index e141330c1114..1eb3b73a164a 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -245,6 +245,12 @@ properties:
       Controller is limited to send MMC commands during
       initialization.
 
+  no-single-read-retry:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Single block read retrying is not supported
+      when multiple block read fails.
+
   fixed-emmc-driver-type:
     description:
       For non-removable eMMC, enforce this driver type. The value is
-- 
2.29.0

