Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA490C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Feb 2021 05:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60BA464E28
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Feb 2021 05:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhBQFdU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Feb 2021 00:33:20 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:29183 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhBQFdT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Feb 2021 00:33:19 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210217053237epoutp037e1c02eca5e40eda375d0531aa8ca6fb~kcgrT4GEe2639526395epoutp03c
        for <linux-mmc@vger.kernel.org>; Wed, 17 Feb 2021 05:32:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210217053237epoutp037e1c02eca5e40eda375d0531aa8ca6fb~kcgrT4GEe2639526395epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613539957;
        bh=3WOerBjeKYYmhGSAUrnasDhEXSeMuaE6qtFqEDxJ1hw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=YwXUYNfAwxEI62X/QzcjS3Dz1yFDfTsPaIjmseWcHuz+irwo7ysP04V2D1SX+kNIb
         6Y6LP+MVFKtiQGTsN1/i7zEHscoqfHw93P35Qn2uXTROyLHscWCyFgPq9QXFJ82PGy
         VmjD5rK40tpuRtWrv6zL2F/gA3Kyi3xbHEr7BCkU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210217053235epcas1p238c43bc95e2860b4670605b5f0a87577~kcgp6yWTk1475914759epcas1p2_;
        Wed, 17 Feb 2021 05:32:35 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.166]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DgRLV5Zr6z4x9Pv; Wed, 17 Feb
        2021 05:32:34 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.B4.02418.27AAC206; Wed, 17 Feb 2021 14:32:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210217053233epcas1p3f6b8177e5f2d27a4f7dc4f136bdcfa48~kcgoD1kY11235212352epcas1p3q;
        Wed, 17 Feb 2021 05:32:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210217053233epsmtrp16bc9ddfd425969c5f472cc01b49acec2~kcgoCywPp1493814938epsmtrp1K;
        Wed, 17 Feb 2021 05:32:33 +0000 (GMT)
X-AuditID: b6c32a35-c0dff70000010972-62-602caa72964a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.CE.13470.17AAC206; Wed, 17 Feb 2021 14:32:33 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.101.61]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210217053233epsmtip12a46e791678ba1fb98ec598a0466bea8~kcgnyd-OO2816328163epsmtip1f;
        Wed, 17 Feb 2021 05:32:33 +0000 (GMT)
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
Subject: [PATCH 0/2] mmc: core: add a new property
Date:   Wed, 17 Feb 2021 14:19:37 +0900
Message-Id: <20210217051939.13695-1-dh0421.hwang@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0xTVxTefa99fTiKb6XqtTNSXtRRskILFq5OYMmaWdniyLbohtnKGzwB
        V9qur12m/wyHEixoRQ0iw/hzPwIoWaEbsrbLKgoljIRVu4yMuRC2yYggdGWMgqz0acZ/53zf
        d+53zrn3krjET8jIcqOVtRgZA02sEnx9U6FSWlqeL1J5exXIP9ZGoNYRB4FmKu/gqLG/Wogu
        9AwKkTfoF6Gh1iNCNL/YLkLzQw1CVOM6jaGuPwdEqHuxCkOB7mYC9Sw5ADrq6REhR+sIgT5Z
        8ApQcKBPiHqv7UUdP84KXpTqLjptuivucUwX+MGmc7YcI3S/BN2E7kRnC9CFnBsLRIWGHWUs
        U8Ja5Kyx2FRSbizNoV95Q/+SXpOlUivV21A2LTcyFWwOrX21QPlyuSE6Di3/kDHYolABw3F0
        eu4Oi8lmZeVlJs6aQ7PmEoNZrTKncUwFZzOWphWbKrarVaoMTVRZZCibrBnFzS7BR56f5vBK
        EMHsII6E1FbY0HsDt4NVpITqAvBu82fEMiGhZgC8MJbHE7MAPug/I3hScar7FuAJD4D9X0wK
        +CQEoPfhmGhZRVBp0H28RbhMSCk7BkcWfcRyglPTAF4anoiZJFIZsD5yNnaugNoML7vCsa7E
        VA4cvTP12C8JLtyrw3n8Geg/NxbD8She5fo01jmk3CRsC1zC+QItvPXllJCPE+FfvZ0iPpbB
        cUf147gWQIcvly8+CWCgt47giUw4EwpFpyOjDgrY3p3Ow8nwRuQ84I0T4GS4TrgsgZQY1lRL
        eMkWeOXRP1GJKBpvgIef5lEd/CZShfErfQeeGLouOAmSmlYM07RimKb/bS8CvAWsZc1cRSnL
        qc3qlbfqBLE3narpAvUPHqb5AEYCH4AkTkvFolBqkURcwhw8xFpMeovNwHI+oImutx6XrSk2
        RT+F0apXazIyMzPR1qzsLE0mvU78nuo3vYQqZazs+yxrZi1P6jAyTlaJPQuU9HSoMGNLXCJq
        jL+5ZiTpqDslN0XqV8upQL7H9fGky/la4aPjH2j3dcGfl6Zt393VuTbu87zQ5CoOaxKCzxW/
        2ZNsD71+1Tofv201/e3Au1mjDskeucm+dtdV/ea4w92yctXcLkf+btfe2fUQm+gzr9+fPLPa
        Olr6+6CzubYhNTGoBQf7/Z/v2T6xaeGI7W9l++l/d+bc359/THxmSqn3fzX3R+fA9Xs7mcGU
        a7hlUno++/uSpxS1oVF2nf32udQgTtZXa+qHg/PhcFvH4m2yI2LQpmR58uLfvq9Q5B7Y1Jac
        MPvWcIr6kMB79kDjlBL+GmQCfXmXN+zOXUofpwVcGaNOxS0c8x+OyxBMXAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSnG7hKp0Eg47duhYnn6xhs1h9t5/N
        4lPDFWaLGafaWC3mHznHarHv2kl2i4urW1gtfv1dz27x6+I0VouOrZOZLHY8P8NusetvM5PF
        5V1z2CyO/O9ntGjde4Tdon/1XTaLpj/7WCyunTnBanF8bbjF5kvfWBxEPBZsKvVYvOclk8fl
        s6Uem1Z1snncubaHzaNvyypGj8+b5ALYo7hsUlJzMstSi/TtErgy3nU8Yi7YylKx9/oP5gbG
        30xdjJwcEgImEpN2HWXsYuTiEBLYzSixofc3O0RCRqL7/l4gmwPIFpY4fLgYouYjo8TV2VPA
        atgE9CT29K5iBUmICMxgkjh0+Ak7iMMs8JtRYtKPZrAqYQEjiYm/p7OA2CwCqhKLtn4FW80r
        YCvx6Mp7Foht8hJ/7vcwQ8QFJU7OfAIWZwaKN2+dzTyBkW8WktQsJKkFjEyrGCVTC4pz03OL
        DQsM81LL9YoTc4tL89L1kvNzNzGCI0dLcwfj9lUf9A4xMnEwHmKU4GBWEuFl/6yVIMSbklhZ
        lVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAPTvisnzrCfMv1xIfHn
        mYzrbYf/HVtvtSeXXbfI1OVVjc+vyPx3i1imrtZvWb1ousriiqKgu1MmNaZzJ5mUCXWYxXtr
        5TuxPuF4nrpuevDDNI2WXf9VHKZ1mFl57Ct5KFiR+3GX6qz/ny6s9c/g5FI8VODJzvz2Z2ex
        9s3UhZdvJZ64b3PfzWnF0u9sJrM7Opb2zvvvElFz7Wuzh4DwwcqilSdn/39RpLrapC4vQMRc
        49as1XOW6jvozZhVfMrmO8vbL7IvyyMcpXKuzd//fpPX58gtnRlHLq+KT65uEZ6dz7RGJ2vb
        y5Jtbo7yyzw2r6ld+vrqtmdzLpjyu/g5zk/jKDi0UbDnJ8OPOpuzl84zKbEUZyQaajEXFScC
        AActtvcLAwAA
X-CMS-MailID: 20210217053233epcas1p3f6b8177e5f2d27a4f7dc4f136bdcfa48
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210217053233epcas1p3f6b8177e5f2d27a4f7dc4f136bdcfa48
References: <CGME20210217053233epcas1p3f6b8177e5f2d27a4f7dc4f136bdcfa48@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add an optional property to not retry multiple block read error
with several single block reads.

DooHyun Hwang (2):
  dt-bindings: mmc: Add no-single-read-retry property
  mmc: core: Add no single read retries

 Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 6 ++++++
 drivers/mmc/core/block.c                                  | 3 ++-
 drivers/mmc/core/host.c                                   | 6 ++++++
 include/linux/mmc/host.h                                  | 3 +++
 4 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.29.0

