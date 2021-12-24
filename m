Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBE6C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Dec 2021 11:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhLXLXO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Dec 2021 06:23:14 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:55168 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344108AbhLXLXN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Dec 2021 06:23:13 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20211224112311epoutp03ef55233d5d5cf7b9464d32a349638e76~DrRQwLxyX2768527685epoutp03j
        for <linux-mmc@vger.kernel.org>; Fri, 24 Dec 2021 11:23:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20211224112311epoutp03ef55233d5d5cf7b9464d32a349638e76~DrRQwLxyX2768527685epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1640344991;
        bh=HtKhlqR/I6uF0b1Pun3RtmmxfFUX9p4Fn66RsbZ+FPc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=qne4Ea+mnkrxHdePCXuOgRvHikamwuJakUyEuTVLguY4CyshVw7u2u0nffky3GKs8
         ac+bDD+RTtQTokDEGgkHauFTh3C31ki0WVXlG1M3MFnXlE2KCqQdjyj9IlyHjVIAqG
         cOthnujPeLfO0DRkc5fjyEP6UZbQBoKYJYmUaXCA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20211224112311epcas5p1630a8ce32d83048b81186d61bfd13708~DrRQau2x01543015430epcas5p1v;
        Fri, 24 Dec 2021 11:23:11 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JL4Rv5Yh0z4x9Pp; Fri, 24 Dec
        2021 11:23:07 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.88.46822.B9DA5C16; Fri, 24 Dec 2021 20:23:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20211224112220epcas5p2491fcef539e793179fcfa14b983999db~DrQhEfRQ72662026620epcas5p2q;
        Fri, 24 Dec 2021 11:22:20 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211224112220epsmtrp2da3f3984d68023996a9842b5acf58afa~DrQhD2A3E3050230502epsmtrp2D;
        Fri, 24 Dec 2021 11:22:20 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-b9-61c5ad9b6f94
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.98.08738.C6DA5C16; Fri, 24 Dec 2021 20:22:20 +0900 (KST)
Received: from test.sa.corp.samsungelectronics.net (unknown [107.99.43.140])
        by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211224112219epsmtip27dc5e17af5b062f39c802b1e4c1ecee1~DrQf8NMH42343223432epsmtip2C;
        Fri, 24 Dec 2021 11:22:18 +0000 (GMT)
From:   Shankar Athanikar <shankar.ma@samsung.com>
To:     linux-mmc@vger.kernel.org, avri.altman@wdc.com, chris@printf.net
Cc:     puneet.5@samsung.com, sumeet.paul@samsung.com,
        mohanraj.v@samsung.com, Shankar Athanikar <shankar.ma@samsung.com>
Subject: [PATCH 1/2] Display BARRIER_CTRL Status when printing EXT_CSD
Date:   Fri, 24 Dec 2021 16:49:16 +0530
Message-Id: <20211224111917.707440-1-shankar.ma@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmlu7stUcTDR4f1bV4+fMqm8WEy9sZ
        LY787wcSh1tZLR5cesNisalX0eLIv61sDuweN14tZPLo27KK0ePzJjmP9gPdTAEsUdk2GamJ
        KalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUAHKCmUJeaUAoUC
        EouLlfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM072r2As
        +Mhacat9HnsD43WWLkZODgkBE4ldi1rZuhi5OIQEdjNKLDx1jhnC+cQo0fTvAyNIlZDAZ0aJ
        hstpMB2dsz5BFe1ilDh58jIThNPIJHFi8gYmkCo2AQOJ+zNOgu0QEXCROHnwCZjNLFAu8W3m
        U3YQW1jATeLF1LtgcRYBVYmPW+azgti8AjYSW/puMUNsk5eYeek7O0RcUOLkTJg58hLNW2eD
        XSEhsI9d4tfRN1ANLhKTrx5hg7CFJV4d38IOYUtJfH63lw2ioZ1R4uOkKVDOBEaJ/i9LmCCq
        7CX6Zj4FsjmAVmhKrN+lDxGWlZh6ah0TxGY+id7fT6DKeSV2zHsCVi4hoCIxd2ItzK4/v65A
        3eAh0Td7HzMkGGMljhz8zD6BUX4Wkn9mIflnFsLiBYzMqxglUwuKc9NTi00LjPJSy+Exm5yf
        u4kRnBC1vHYwPnzwQe8QIxMH4yFGCQ5mJRFez1VHEoV4UxIrq1KL8uOLSnNSiw8xmgIDeSKz
        lGhyPjAl55XEG5pYGpiYmZmZWBqbGSqJ855O35AoJJCeWJKanZpakFoE08fEwSnVwDRFqTOp
        s8/m9fUlASGdVpPl51yauOX1Zj/vI9KO8qLplQ/LTxZaKLPmTPpfb2Dr0BS7T/QO780Diw+Z
        XXGMeTlb6LSGiO835qaZBvdP1jbLOBwyfzXD+s9+Bg9Oqc2bA9Ubbs3JDgl9OS/db1L6qojF
        1nu2m/3dEKFQxiz8Q/WPcea/Kdnbg23PTQic3MIcyBCZmLhiPvu3m85XvML0iy69PX79T5hf
        jkHyp5LuF5NNchrPhLpEa/JMdji0oGfqdvvAQIWzEW9uHpsaEinFtK2R7dBJ+a8/mi98NPB/
        lph4SnD3yu4Ja0x8TmXe4eEoseO0k1qrHSOixKmWqDI5SETr0cS7l9Le13fs4SwRVmIpzkg0
        1GIuKk4EAMA+8NgRBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsWy7bCSvG7O2qOJBucvClm8/HmVzWLC5e2M
        Fkf+9wOJw62sFg8uvWGx2NSraHHk31Y2B3aPG68WMnn0bVnF6PF5k5xH+4FupgCWKC6blNSc
        zLLUIn27BK6Mk/0rGAs+slbcap/H3sB4naWLkZNDQsBEonPWJ+YuRi4OIYEdjBK72t4xQySk
        JJb2fWWCsIUlVv57zg5R9J9RYknvDkaQBJuAgcT9GSfBJokIeEhs234frJlZoFpiz5lOsLiw
        gJvEi6l3wWwWAVWJj1vms4LYvAI2Elv6bkEtk5eYeek7O0RcUOLkzCcsEHPkJZq3zmaewMg3
        C0lqFpLUAkamVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwaGppbWDcc+qD3qHGJk4
        GA8xSnAwK4nweq46kijEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKY
        LBMHp1QDE7OK1PcwD8aodV6b3uemdm/wEP240+nLlD++ZmpGJ632Loy5oXXvmdzlhXb7vCVE
        bxtY7aiu1rCPN1oicmfObfYsEXnGqfXNS25o/Hn9YkbS1fssN8v4b21d9t79RsCrSQ85ZOON
        M6qzw3MU1jjbi3mcN+y6xH1u2WUvtonzPn1eonZoL+f3ijsfLZ4VygkGpBqx/7DfOO9uVWZ9
        faH0O0GrKwfbnU6/5dk8UW2FQcK0F6ZLo0ouiCw8bOb1L0FEh/vPh53KFe7yL5j9VzY8n35l
        q5338Q/nD8xL6Mq/8CNdSH/WLiXdqbcnsNawVVYss2f7dzeeiyP+CWtDd+1Ft6QTj5f/7WH5
        bnKnJtolWImlOCPRUIu5qDgRANeyFOa8AgAA
X-CMS-MailID: 20211224112220epcas5p2491fcef539e793179fcfa14b983999db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211224112220epcas5p2491fcef539e793179fcfa14b983999db
References: <CGME20211224112220epcas5p2491fcef539e793179fcfa14b983999db@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The status of BARRIER_CTRL can be read from this byte: EXT_CSD[31](R/W)
Signed-off-by : shankar.ma@samsung.com
Reviewed-by : mohanraj.v@samsung.com
---
 mmc_cmds.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index c5eea65..5e5e79e 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1831,7 +1831,10 @@ int do_read_extcsd(int nargs, char **argv)
 		printf("Control to turn the Cache ON/OFF"
 			" [CACHE_CTRL]: 0x%02x\n", ext_csd[33]);
 		/* flush_cache ext_csd[32] not readable */
-		/*Reserved [31:0] */
+		printf("Control to turn the Cache Barrier ON/OFF"
+        		" [BARRIER_CTRL]: 0x%02x\n", ext_csd[31]);
+		/*Reserved [30:0] */
+
 	}
 
 	if (ext_csd_rev >= 7) {
-- 
2.25.1

