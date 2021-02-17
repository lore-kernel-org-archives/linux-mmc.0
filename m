Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A157C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Feb 2021 05:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDF0264DFF
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Feb 2021 05:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhBQFgH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Feb 2021 00:36:07 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:37622 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhBQFgD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Feb 2021 00:36:03 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210217053522epoutp01e6f3712f546647066956888a8ca14ce4~kcjE5VbeB2344823448epoutp01R
        for <linux-mmc@vger.kernel.org>; Wed, 17 Feb 2021 05:35:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210217053522epoutp01e6f3712f546647066956888a8ca14ce4~kcjE5VbeB2344823448epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613540122;
        bh=3WOerBjeKYYmhGSAUrnasDhEXSeMuaE6qtFqEDxJ1hw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ka4kcr306i08khOz9N9g4NLKxKwinJHwYCWv927HWPyOL/pkgEZJgRO2TT4v7QM2U
         u/lpU8+4JVzjWRdnrkxmOQj8cU82Xp8KIWr2TllQ6aQPrFdIO1P5ns3sR/bjVHDsct
         UG1148E/nA0XxHEPKtpeX2POn0HtyYoeqgCf82uo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210217053521epcas1p16dd9f3861bb999206e0d59d1a0cf6605~kcjEP1ywl2401624016epcas1p1v;
        Wed, 17 Feb 2021 05:35:21 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.164]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DgRPh3Xdtz4x9QM; Wed, 17 Feb
        2021 05:35:20 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A1.F7.63458.81BAC206; Wed, 17 Feb 2021 14:35:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210217053519epcas1p4204253d3af8e1c6d2a5c3acb73eb877f~kcjCk7FTd2138621386epcas1p4F;
        Wed, 17 Feb 2021 05:35:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210217053519epsmtrp2453ca2114d1778a111ce8e9a05fc5f47~kcjCjtIX_2012920129epsmtrp27;
        Wed, 17 Feb 2021 05:35:19 +0000 (GMT)
X-AuditID: b6c32a36-6c9ff7000000f7e2-60-602cab18dc9f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        10.2F.13470.71BAC206; Wed, 17 Feb 2021 14:35:19 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.101.61]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210217053519epsmtip23c19207efe25831f08c25297409f5d74~kcjCPjJs13127531275epsmtip2e;
        Wed, 17 Feb 2021 05:35:19 +0000 (GMT)
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
Subject: [PATCH 0/2] mmc: core: add a new property
Date:   Wed, 17 Feb 2021 14:22:37 +0900
Message-Id: <20210217052239.13780-1-dh0421.hwang@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmga7Eap0Eg45VEhYnn6xhs1h9t5/N
        YsapNlaL+UfOsVrsu3aS3eLi6hZWi19/17Nb/Lo4jdWiY+tkJosdz8+wW+z628xkcXnXHDaL
        I//7GS1a9x5ht+hffZfNounPPhaLa2dOsFocXxtusfnSNxYHYY8Fm0o9Fu95yeRx+Wypx6ZV
        nWwed67tYfPo27KK0ePzJrkA9qgcm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3Ml
        hbzE3FRbJRefAF23zBygT5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BYYGBXrF
        ibnFpXnpesn5uVaGBgZGpkCVCTkZ7zoeMRdsZanYe/0HcwPjb6YuRk4OCQETiclzzrN2MXJx
        CAnsYJSYM2MuI4TziVFi3ZTDTBDON0aJvo+bWWBaVky7B5XYyyjR8WAaVP9nRok1T1vZQarY
        BPQk9vSuAkuIgMzac2s/O4jDLPCRUWLhrddsIFXCAkYSE39PB5vLIqAqMeHOQjCbV8BW4uip
        N+wQ++Ql/tzvYYaIC0qcnPkErIYZKN68dTYzyFAJgS0cEvden4D6yUXiwpJNUMcKS7w6vgVq
        kJTE53d72SDsbkaJ/kN2EM0TGCUuH++BShhLfPr8GRgGHEAbNCXW79KHCCtK7PwNChqQxXwS
        7772sIKUSAjwSnS0CUGUqEks/vcdqIQdyJaRaOSGiHpIXF79C+wYIYFYiamb9jNNYJSfheSZ
        WUiemYWwdgEj8ypGsdSC4tz01GLDAiPkaN3ECE7PWmY7GCe9/aB3iJGJg/EQowQHs5IIL/tn
        rQQh3pTEyqrUovz4otKc1OJDjKbA4J3ILCWanA/MEHkl8YamRsbGxhYmZuZmpsZK4ryJBg/i
        hQTSE0tSs1NTC1KLYPqYODilGpjmcy1mD9zdtzNZ/cCLU44zTNqe+7H/q7Ba+EwvfZ0r69XH
        u9O//Mw8dG2OaFlSicG/gtMi2/i+XPFdMuOVlu9B7jcTbk91T+EL4DlsN1v4nqHY/MM6jjuE
        +24eTDxmG+O045vUHXNOvyxN/txy4czDKbNjyj5Ynm9dJrVN51OPd8iKQw0nFT+LzM2uyFGI
        nlAsb3i2j49xglnwiq9bqjYeMmD6k1I1UWCPNeO/I9/TOFRVO++ufnJR1uTuM5eYbvd/372v
        un77lzYxT7CecVmNnWoSi4Xp5X+yrh9zuCMueqqv26zyPUq/VqT9u2Sx34dlpqyN8nIKL961
        eZyfs+FxhktHqJKp8pKqV/0ftyixFGckGmoxFxUnAgALq0MyWAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSvK74ap0Eg669yhYnn6xhs1h9t5/N
        YsapNlaL+UfOsVrsu3aS3eLi6hZWi19/17Nb/Lo4jdWiY+tkJosdz8+wW+z628xkcXnXHDaL
        I//7GS1a9x5ht+hffZfNounPPhaLa2dOsFocXxtusfnSNxYHYY8Fm0o9Fu95yeRx+Wypx6ZV
        nWwed67tYfPo27KK0ePzJrkA9igum5TUnMyy1CJ9uwSujHcdj5gLtrJU7L3+g7mB8TdTFyMn
        h4SAicSKafeAbC4OIYHdjBLN2xoYIRIyEt3397J3MXIA2cIShw8XQ9R8ZJR4Nm0JM0gNm4Ce
        xJ7eVawgCRGBf4wSnbM3sYE4zAK/GSUm/WhmB6kSFjCSmPh7OguIzSKgKjHhzkIwm1fAVuLo
        qTfsENvkJf7c72GGiAtKnJz5BKyGGSjevHU28wRGvllIUrOQpBYwMq1ilEwtKM5Nzy02LDDM
        Sy3XK07MLS7NS9dLzs/dxAiOFy3NHYzbV33QO8TIxMF4iFGCg1lJhJf9s1aCEG9KYmVValF+
        fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUwLvzGwxfmpb3zkfYn9Qezk
        Bw8f3BPw+jXXws77vrZCYM8M4U+JVxo15dun7vhWNSUy7LK0LsOEUkZ/3dpa1ul8Ntqm9zRN
        NlkH72oLKRG1Kyrv57pbrfT/9ueLi3+vc6p580kugWlz00GGOQqC/Ax2vUcmiymG6qcId/6X
        a9D0z/E6Y1arLLp/VtccxuPtLD/PWAdoGvjsWB9k9VNN9JmohcS5tzc10mX3bWH/xHojSmup
        2MxJgacOHJIsybrOeVBC0j7rbUpP5tPgdS1LXxcfZo1OD+V0Pf9Q4x1PWXTsfpd7+37Pu5L1
        yPnBVYN1+123GKfsj950/smTYwejeDQNG7Xn75/fweN0qeDmFSWW4oxEQy3mouJEAIuQdzcG
        AwAA
X-CMS-MailID: 20210217053519epcas1p4204253d3af8e1c6d2a5c3acb73eb877f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210217053519epcas1p4204253d3af8e1c6d2a5c3acb73eb877f
References: <CGME20210217053519epcas1p4204253d3af8e1c6d2a5c3acb73eb877f@epcas1p4.samsung.com>
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

