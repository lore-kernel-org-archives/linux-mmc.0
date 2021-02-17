Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8B5C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Feb 2021 05:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C255064DEC
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Feb 2021 05:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhBQFgJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Feb 2021 00:36:09 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:22220 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbhBQFgF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Feb 2021 00:36:05 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210217053523epoutp04b4a33f0dcf29edff67f1ea99640aba0d~kcjGAerCJ0917209172epoutp04k
        for <linux-mmc@vger.kernel.org>; Wed, 17 Feb 2021 05:35:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210217053523epoutp04b4a33f0dcf29edff67f1ea99640aba0d~kcjGAerCJ0917209172epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613540123;
        bh=0Qu3UhubXL/3n9cgBIbiKKoOt4KQtprWcRcKbSHb1jI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i9XpEqRpf4SC7y680AvtKcTyU9FFX8FytUEMF/268+MjlQYgJT7XNtWjgk2Ta3pEg
         vQgsjPErJ0uyFhOTFLCgBng5mNgsxoX6LdiHgj5lgMkzvO7dVBxSRaTtaW1kedtbyw
         4NHZgin0niXpL8Jja9fowb03GVsLOAssVaQXdvxs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210217053522epcas1p2277b4987d186a818db68e9032f23c1f0~kcjFYxbyy1063410634epcas1p2i;
        Wed, 17 Feb 2021 05:35:22 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.162]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DgRPj4ktjz4x9QH; Wed, 17 Feb
        2021 05:35:21 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.47.09582.91BAC206; Wed, 17 Feb 2021 14:35:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210217053520epcas1p1af462836bd9fc690d99baed0b122d6fd~kcjDslF_B2540325403epcas1p1H;
        Wed, 17 Feb 2021 05:35:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210217053520epsmtrp283b15164a3d8c9dfad119b554063689e~kcjDrjTlA2012920129epsmtrp2A;
        Wed, 17 Feb 2021 05:35:20 +0000 (GMT)
X-AuditID: b6c32a37-899ff7000000256e-0e-602cab1921b6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.2F.13470.81BAC206; Wed, 17 Feb 2021 14:35:20 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.101.61]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210217053520epsmtip2cb7aa129699810c62c57865eb1afb45d~kcjDXHSFu3250732507epsmtip2c;
        Wed, 17 Feb 2021 05:35:20 +0000 (GMT)
From:   DooHyun Hwang <dh0421.hwang@samsung.com>
To:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ulf.hansson@linaro.org,
        robh+dt@kernel.org, axboe@kernel.dk, adrian.hunter@intel.com,
        satyat@google.com, ebiggers@google.com, gustavoars@kernel.org
Cc:     grant.jung@samsung.com, jt77.jang@samsung.com,
        junwoo80.lee@samsung.com, jangsub.yi@samsung.com,
        sh043.lee@samsung.com, cw9316.lee@samsung.com,
        sh8267.baek@samsung.com, wkon.kim@samsung.com,
        DooHyun Hwang <dh0421.hwang@samsung.com>
Subject: [PATCH 1/2] dt-bindings: mmc: Add no-single-read-retry property
Date:   Wed, 17 Feb 2021 14:22:38 +0900
Message-Id: <20210217052239.13780-2-dh0421.hwang@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210217052239.13780-1-dh0421.hwang@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxbVRjO6W1vL2jNtaAeOsTuLrAMhbVrC2duJUtEvdG5YPyBmTPlSu8o
        rrS1lxI3/cHHBpMBZSxuo0OZsC3ajmCAYoGyRmADNoYDIiZVtqkQogsMaUDlY3jLZZF/78fz
        nOd93nMOgcnv4Aoi15LP2i2MmcIjxe29O5KTYjwvZan89yk0OHkVR54JJ47O3yyVoPq+YQm6
        Nj4oRSOe4xK0tNosRUsjZyXopPeMCPmmh6Soc7VEhMY663DUt+YE6ER3nxQ5PRM4Kl65Jkbj
        QwMS1N+UiVpHF8X7ouiLLQ660f+HiB677aBb3J/h9C/jfpyuanMDOtQSlyE9aN5rYhkja1ey
        lmyrMdeSo6fefMfwikGXolInqXejVEppYfJYPZW+PyPptVwz74RSFjBmB1/KYDiO2pm21251
        5LNKk5XL11OszWi2qVW2ZI7J4xyWnORsa97LapVql45HZplNdQGXyDZHfHypM4AVgqvSchBB
        QFILz9Uu8HEkISd9AM4OlGwk8wCeu/MlLiSLAPYWfS1+TFnyl4mERjeAweEKSbghJ0MAXm/f
        Fo5xMhn6K92SMCg6fJQ/GFg/FyP/AvCr4AM8jIoiafjNpHedLSbj4UDRwvpUMlIPB1vrcUHu
        BbhyrwILxxFkGnw46sQEzNNwsHZyfSSMx5R4L2BhAUgOEXC4/juJQE6HD5xVG3NHwT/72zZs
        K2BotntD4BSAzp40gVwN4Fh/xUZDA+dDIVAOCF5hB2zu3CmUt8KO5S+AIPwUnF0I2yf4ugye
        LJULkATY+OhvHiLl41hY9IRQpeHKYjsQdnUawKkrr1YDpWuTGdcmM67/ZS8CzA2eZW1cXg7L
        qW2azTfcAtafdmKqD5ydmUvuASIC9ABIYFS0TBpKzJLLjMzRY6zdarA7zCzXA3T8qk9jimey
        rfzfsOQb1LpdGo0GaVNSU3Qa6jnZB6r7BjmZw+SzR1jWxtof80REhKJQpByvzIzRDHmfT5ij
        Jvy3GuN+rj1zd/ZS1uXCpbrfZlfjc/OOXXgx/RP7zcLrXTfKO1xTJ5Lqimu6Pk2N/almHwwo
        3m9MuBE3n7in93vi6LJa6yutwSuNTdr2eEM/dsS7ZbdesRakZ6z69P30lN6z2hXpo8zHA97D
        W4xaXUFz/dTn2w8RDXRrx/RAtlQnG3nDVfBDbHTKzFuV9duCCaduLz6ajswc3XPlX6rpgLbK
        eygYqO6o+fXJweF7r3PFXR+Zck135xuWO9Y8Q7+rxe89PNxw3hDVybRVHUxhL1dF/LN9NK7u
        24p3t5YdKGUp+GOTedxgb+wvehu5y5p90zHuWx9SYs7EqBMxO8f8B0Xa5RtjBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJXlditU6CwdxL+hYnn6xhs1h9t5/N
        YsapNlaL+UfOsVrsu3aS3eLi6hZWi19/17Nb/Lo4jdWiY+tkJosdz8+wW+z628xkcXnXHDaL
        I//7GS1a9x5ht+hffZfNounPPhaLa2dOsFocXxtusfnSNxYHYY8Fm0o9Fu95yeRx+Wypx6ZV
        nWwed67tYfPo27KK0ePzJrkA9igum5TUnMyy1CJ9uwSujDn7ZzEVfOCoWLJrP3MD4xr2LkZO
        DgkBE4lfe9qZuhi5OIQEdjNKbN3dywiRkJHovr8XqIgDyBaWOHy4GKLmI6PEu4nnWEFq2AT0
        JPb0rmIFSYgI/GOU6Jy9iQ3EYRb4zSgx6Ucz2AphAQ+JlU+2gnWwCKhKnGj8ChbnFbCVOLl5
        PhvENnmJP/d7mEFsTgE7ifeX+sFsIaCa2cd+MEHUC0qcnPmEBcRmBqpv3jqbeQKjwCwkqVlI
        UgsYmVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgTHl5bmDsbtqz7oHWJk4mA8xCjB
        wawkwsv+WStBiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6p
        BqbL87rXPGI7/nNBUCbbtcMlc+f2NIg0Pn/F+jpoWmuXuv9sNyZXVvmibF+TxtcnXNZ/+J3h
        c9nJrWuX2q9kLdZbk/9nME5/P3tvu/Jn9q4j/C7nPuj/cD694cIt164Gb0OG4r1B3F86934W
        nhAiGPy360/FNIkraZcCeizuzF9uHHo1rlhq27IjDO5iG59y/GMQ87DT+aDt+13wefBRk7OT
        pCot1D+l/XsTp3sntCcy15In9YXv34NCUxofyt0QVjo9q9anvbXK8uUBVrm2vCq5qvRZNy3E
        8qQVz53V+fXdo/tFxI8as4PzeRbeviyskt/4VIdlYldD6vUzHuUexyWDpy2fFhM+859ia6rC
        bSWW4oxEQy3mouJEAEBwYo8eAwAA
X-CMS-MailID: 20210217053520epcas1p1af462836bd9fc690d99baed0b122d6fd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210217053520epcas1p1af462836bd9fc690d99baed0b122d6fd
References: <20210217052239.13780-1-dh0421.hwang@samsung.com>
        <CGME20210217053520epcas1p1af462836bd9fc690d99baed0b122d6fd@epcas1p1.samsung.com>
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

