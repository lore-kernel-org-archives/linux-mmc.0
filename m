Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4555AC433EF
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Nov 2021 06:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B2AF61050
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Nov 2021 06:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhKDGf2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Nov 2021 02:35:28 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:27910 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhKDGfZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Nov 2021 02:35:25 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20211104063246epoutp015ed7dbf2b3277701ae44849f4499d74c~0RDbCNCVr2260022600epoutp01Y
        for <linux-mmc@vger.kernel.org>; Thu,  4 Nov 2021 06:32:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20211104063246epoutp015ed7dbf2b3277701ae44849f4499d74c~0RDbCNCVr2260022600epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1636007566;
        bh=XQ82X6xPFxlA23GhyUFqTKX41dSNvOuOx32KdybUn1c=;
        h=From:To:Cc:Subject:Date:References:From;
        b=F/ZTwDYaIr2OtIw3fHPNqVmTyeREQFjC/SE1LU5Z5BoKm5uZWWHHTEx+QnM+pFDqQ
         uGf5qJvPGFGuKlXF5B+MrRm6/1uXc9XGioAbLsR7d92kjeAZTaEYHtzybqnIc35KJO
         Vn+MgvlFgiK4AEpDzeC3iJdW0xIboCVbpd6wh7m4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20211104063246epcas1p3b6855d69870811311cf5e3649731bfd3~0RDawkgZ-0545405454epcas1p31;
        Thu,  4 Nov 2021 06:32:46 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.247]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4HlDMw2wgKz4x9Q8; Thu,  4 Nov
        2021 06:32:44 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.D8.64085.C8E73816; Thu,  4 Nov 2021 15:32:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20211104063243epcas1p4526b49feac019f3eadb33a23dc132976~0RDYjQpBR2528025280epcas1p4x;
        Thu,  4 Nov 2021 06:32:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211104063243epsmtrp2af96d8ca02daefd99b095a730c64a2ee~0RDYilWqk2025420254epsmtrp2e;
        Thu,  4 Nov 2021 06:32:43 +0000 (GMT)
X-AuditID: b6c32a35-9c3ff7000000fa55-5c-61837e8c9c8f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.19.29871.B8E73816; Thu,  4 Nov 2021 15:32:43 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.98.193]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211104063243epsmtip22d1d87717fd7119effbcf8082bd3396f~0RDYaryWr1646816468epsmtip2j;
        Thu,  4 Nov 2021 06:32:43 +0000 (GMT)
From:   Huijin Park <huijin.park@samsung.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huijin Park <bbanghj.park@gmail.com>,
        Huijin Park <huijin.park@samsung.com>
Subject: [PATCH v2 0/2] mmc: core: adjust polling interval for CMD1
Date:   Thu,  4 Nov 2021 15:32:29 +0900
Message-Id: <20211104063231.2115-1-huijin.park@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmvm5PXXOiwestEhYv9x5itui46GJx
        edccNosj//sZLY6vDXdg9dg56y67x51re9g8+rasYvT4vEkugCUq2yYjNTEltUghNS85PyUz
        L91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKuSQlliTilQKCCxuFhJ386mKL+0
        JFUhI7+4xFYptSAlp8CsQK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj5K3l7AUXWCt63j5ibWA8
        ztLFyMkhIWAi8XnFHSCbi0NIYAejROumo2wQzidGiY+dV1ghnG+MEtsP/4ZrOT9/M5gtJLCX
        UWL5yWQIG6hj+U49EJtNQFvi+tqtjCC2iICGxJ6H51lBbGaBLkaJm7ccQGxhAWeJb1u2AcU5
        OFgEVCV+rJIDCfMKWEvsfLaGHWKVvMTMS9/ZIeKCEidnPmGBGCMv0bx1NjPIbRIC29glvj65
        ygwyR0LARWLhciuIXmGJV8e3QM2Rkvj8bi8bhF0usWvCVajeBkaJvrXfWSESxhLv3q4Fm8Ms
        oCmxfpc+RFhRYufvuYwQe/kk3n3tYYVYxSvR0SYEUaIqsfjqR6gp0hKHHtxlhLA9JBZtPgVW
        LiQQK/HhS+kERvlZSJ6ZheSZWQh7FzAyr2IUSy0ozk1PLTYsMITHaHJ+7iZGcKrTMt3BOPHt
        B71DjEwcjIcYJTiYlUR4n29oShTiTUmsrEotyo8vKs1JLT7EaAoM3YnMUqLJ+cBkm1cSb2hi
        aWBiZmRiYWxpbKYkzvtZrjBRSCA9sSQ1OzW1ILUIpo+Jg1OqgSmA/8nCbTMOa2wL/Lq4vU+s
        Ju7NsROsL7ytL/lFRTMU9Fnc+PBi8YYDC/Lrjxo8WOly87/hsYOzZrVlWU532mET0xDcd5c3
        M0vmn7BvBq//rClrl70xEjdQ2flc4Yvk1ieX31eV78vI3VeX8sEluWKt/Lpp6v1zXYubt6xN
        0PYT/13VPI/Ha2ffdO2l+i3vm3sZCydd9A0//OqSocWWjbERTO08XR2LzlmfXfVEbravbxJf
        ru2n9T2at59dOcpge2nZea37ohnbLHZ4/Vhw8IzPmfdPVPJt67zc/jLNzvDi3MSvy+f6YdZS
        Ts6DC2/NWzr/6bLElIXuz5c4r++4v4m9bbFUw3Nd+f1Bef/59M4osRRnJBpqMRcVJwIANQO8
        L/4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDLMWRmVeSWpSXmKPExsWy7bCSvG53XXOiQdt/M4uXew8xW3RcdLG4
        vGsOm8WR//2MFsfXhjuweuycdZfd4861PWwefVtWMXp83iQXwBLFZZOSmpNZllqkb5fAlXHy
        1nL2ggusFT1vH7E2MB5n6WLk5JAQMJE4P38zkM3FISSwm1Fix4ZT7BAJaYl3O6+zdjFyANnC
        EocPF0PUfGCUeNrxHayGTUBb4vrarYwgtoiAhsSeh+dZQWxmgT5Gic5fWSC2sICzxLct28Dm
        sAioSvxYJQcS5hWwltj5bA3UKnmJmZcgRvIKCEqcnPmEBWKMvETz1tnMExj5ZiFJzUKSWsDI
        tIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzgAtTR3MG5f9UHvECMTB+MhRgkOZiUR
        3ucbmhKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYPIu
        9jR0/Ldb9CNnaHPapC070+5PPlRbGVxxR6hlwd/nuWqHW5WzrOfGpbPcL31X9GOHQ3BVgOws
        Va33j1lPKfzYJv7AU6/s3bSjp56+3bD0+v8X5lXB9c9unT4Skyn96MyXoAMLqteZavy/VL7n
        T03WmxUH+q9OTJPTPtYw499Mtmx1Z4U9YtnNjyK+/dBucFC31Vc1K1tsUWJlNUHG2nRveXg1
        r0tFidu3bucbWrPi753bHThrw0+PqT5LX9/yX8i8/TAbS+qUnv1CD76ecKjlZVdwD/p54nRb
        xp3GffmXnWdPbd0jd36CgtKDgLwLGlzJkl+b5lpWFdzcvNRrWZFz6JFgttTz0td/a1e2+Sqx
        FGckGmoxFxUnAgBmCLlzrwIAAA==
X-CMS-MailID: 20211104063243epcas1p4526b49feac019f3eadb33a23dc132976
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211104063243epcas1p4526b49feac019f3eadb33a23dc132976
References: <CGME20211104063243epcas1p4526b49feac019f3eadb33a23dc132976@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This series is for adjusting polling interval for CMD1 using
__mmc_poll_for_busy() common function which provides a stricter
timeout checking and a throttling mechanism.

v1...v2:
 - Change __mmc_poll_for_busy() first parameter type to 'mmc_host*'.
 - Use __mmc_poll_for_busy() common function.

Huijin Park (2):
  mmc: core: change __mmc_poll_for_busy() parameter type
  mmc: core: adjust polling interval for CMD1

 drivers/mmc/core/block.c   |  4 +-
 drivers/mmc/core/mmc.c     |  2 +-
 drivers/mmc/core/mmc_ops.c | 89 ++++++++++++++++++++++++--------------
 drivers/mmc/core/mmc_ops.h |  2 +-
 drivers/mmc/core/sd.c      |  2 +-
 5 files changed, 62 insertions(+), 37 deletions(-)

-- 
2.17.1

