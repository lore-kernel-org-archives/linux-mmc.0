Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D924C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Dec 2021 11:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352540AbhLXLXO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Dec 2021 06:23:14 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:12635 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhLXLXM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Dec 2021 06:23:12 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20211224112309epoutp0240f5d9b3d21fb691e359085e1d442438~DrRPPVAxp3078830788epoutp02W
        for <linux-mmc@vger.kernel.org>; Fri, 24 Dec 2021 11:23:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20211224112309epoutp0240f5d9b3d21fb691e359085e1d442438~DrRPPVAxp3078830788epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1640344989;
        bh=hkh/XlsgeCam9OMvDkdVOY8mpz/4xo7z5/1K27PwIAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=czdqXHomKc6A4LTTHCDFzEel+pTvTG1Mw40jAu4DkhOcBuIoTh0Th0pqmrPX/G7wH
         kp9m8YJS0VTUTxsXB8KduGot5FiDmzlvJvmsgBvy9v3BcVv1PqtHs6I2i/95mRItQm
         bUggIIZniuq5umsVUknDZtJqfIkS8ubDWNKYoGvs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20211224112309epcas5p12a680b93a7a8df23a9e7bd9431d8c552~DrRO0drh61543015430epcas5p1s;
        Fri, 24 Dec 2021 11:23:09 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JL4Rq1YFTz4x9Ps; Fri, 24 Dec
        2021 11:23:03 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.44.06423.79DA5C16; Fri, 24 Dec 2021 20:23:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20211224112224epcas5p185573caf2548a464f9aac191c25d01f3~DrQk5RNA81400414004epcas5p1F;
        Fri, 24 Dec 2021 11:22:24 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211224112224epsmtrp2dda4c0b7b9d23fbaed9167abd5f317e0~DrQk4bKQZ3050230502epsmtrp2E;
        Fri, 24 Dec 2021 11:22:24 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-21-61c5ad97f388
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.98.08738.07DA5C16; Fri, 24 Dec 2021 20:22:24 +0900 (KST)
Received: from test.sa.corp.samsungelectronics.net (unknown [107.99.43.140])
        by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211224112222epsmtip27cfa8781c449628a8896737324e75afd~DrQi0CGov2343223432epsmtip2D;
        Fri, 24 Dec 2021 11:22:22 +0000 (GMT)
From:   Shankar Athanikar <shankar.ma@samsung.com>
To:     linux-mmc@vger.kernel.org, avri.altman@wdc.com, chris@printf.net
Cc:     puneet.5@samsung.com, sumeet.paul@samsung.com,
        mohanraj.v@samsung.com, Shankar Athanikar <shankar.ma@samsung.com>
Subject: [PATCH 2/2] Enhancement to do_status_get() function for detailed
 Response info
Date:   Fri, 24 Dec 2021 16:49:17 +0530
Message-Id: <20211224111917.707440-2-shankar.ma@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211224111917.707440-1-shankar.ma@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdlhTXXf62qOJBlO3Cli8/HmVzWLC5e2M
        Fkf+9wOJw62sFg8uvWGx2NSraHHk31Y2B3aPG68WMnn0bVnF6PF5k5xH+4FupgCWqGybjNTE
        lNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKADlBTKEnNKgUIB
        icXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGQ1zHzEX
        TBGvmLDlHFsD41GhLkZODgkBE4ktH1uYQWwhgd2MEpu320LYnxgl5t1m7GLkArI/M0qs7/nB
        AtPwc/FKJojELkaJ+cvms0M4jUwSe371M4JUsQkYSNyfcRKsQ0TAReLkwSdgNrNAucS3mU+B
        Gjg4hAUiJfqanUHCLAKqEr8v7GMDsXkFbCTaT8xihlgmLzHz0nd2EJtTwFZi0bo1rBA1ghIn
        Z8KMlJdo3jqbGeQGCYFr7BLv2/qgLnWRaFz/lB3CFpZ4dXwLlC0l8fndXjaIhnZGiY+TpkA5
        Exgl+r8sYYKospfom/mUCeRSZgFNifW79CHCshJTT61jgtjMJ9H7+wlUOa/EjnlPwMolBFQk
        5k6shdn159cVNoiwh8S2FyyQsALa9OjnP9YJjAqzkPwzC8k/sxAWL2BkXsUomVpQnJueWmxa
        YJiXWg6P4+T83E2M4CSp5bmD8e6DD3qHGJk4GA8xSnAwK4nweq46kijEm5JYWZValB9fVJqT
        WnyI0RQY4BOZpUST84FpOq8k3tDE0sDEzMzMxNLYzFBJnPd0+oZEIYH0xJLU7NTUgtQimD4m
        Dk6pBqaO19u5BVYyLOwpPTh/ju+1xIsL2mfJmMUvLn82ubz3poBbvp7crmm5u1VSN2ccZTP6
        e+2FF9OVrWHrFO+5rJnvv3K67afQpn6/7iiZHg8Vh9tv2W/OKLhwc92kpcVtPzrEky8tPDBj
        d1634rrbRzMy9/0y1Q7izlvKUFe+Q2f3x99eM9ROuhqHLtsvH7NtT+bmS1daS56d2qNb9s4v
        00jaqTo9PL6t12edMmuRqYaSyt2fM+6cm1shrcN2u2HWsrR/81dMVJOcoKI172vx88fVVV29
        Vfs963+eUKprPumoNWmDjGu0+plpx26+4c+KE1j7eGpY/h2Ghgub3+/80LbEovxX80+WXNcM
        xsIgDgUlluKMREMt5qLiRAByVTWYGwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWy7bCSvG7B2qOJBlenilu8/HmVzWLC5e2M
        Fkf+9wOJw62sFg8uvWGx2NSraHHk31Y2B3aPG68WMnn0bVnF6PF5k5xH+4FupgCWKC6blNSc
        zLLUIn27BK6MhrmPmAumiFdM2HKOrYHxqFAXIyeHhICJxM/FK5m6GLk4hAR2MEo0dcxihkhI
        SSzt+8oEYQtLrPz3nB3EFhL4zyjRc14fxGYTMJC4P+MkC4gtIuAhsW37fbBeZoFqiT1nOsHi
        wgLhErO3PQabwyKgKvH7wj42EJtXwEai/QTMLnmJmZe+g83nFLCVWLRuDSvELhuJE/O7WCDq
        BSVOznzCAjFfXqJ562zmCYwCs5CkZiFJLWBkWsUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpec
        n7uJERzIWlo7GPes+qB3iJGJg/EQowQHs5IIr+eqI4lCvCmJlVWpRfnxRaU5qcWHGKU5WJTE
        eS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MOkf+/B733xe6ycPQ74//vRvkrSDdq9zrLYfX6rD
        6g7Z5jqzO743DDqXvBHSrTmTdiD50/4y1z338svPFgbInDIodRH743Mz0uKqY7iykqbY1Tna
        Omm9AvvkBc5uu2S2aXLGY4aGreF/mNy/+z3PnLNzzQbZkKAy+ZOPe6PaFDIz/VLmNcYe55zU
        lvUwYHreDSX+uS6J9W1bdaNm3136R+XahCmnz3vJ7z3EvvfQ+ooNf1h+5C2oVXjjKfn71lWJ
        pw33Npz/c3/OfduWJ25Kt0rYde/lvBTl71+bmMNSN1lzd4OF4+EXl8JML+j+SRH657osaPcR
        MVbTunUf/TPWihiw+Siq66Q99PqjvHrpaiWW4oxEQy3mouJEAMJzT4LTAgAA
X-CMS-MailID: 20211224112224epcas5p185573caf2548a464f9aac191c25d01f3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211224112224epcas5p185573caf2548a464f9aac191c25d01f3
References: <20211224111917.707440-1-shankar.ma@samsung.com>
        <CGME20211224112224epcas5p185573caf2548a464f9aac191c25d01f3@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This enhancement covers detailed status register decoding with ERROR/STATUS information when host sends CMD13(with SQS=0)

Signed-off-by : shankar.ma@samsaung.com
Reviewed-by: mohanraj.v@samsung.com
---
 mmc_cmds.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 5e5e79e..f9f1d52 100644
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
@@ -869,7 +871,68 @@ int do_status_get(int nargs, char **argv)
 	}
 
 	printf("SEND_STATUS response: 0x%08x\n", response);
-
+	if((response >> 31) & 0x01) printf("ERROR: ADDRESS_OUT_OF_RANGE\n");
+	if((response >> 30) & 0x01) printf("ERROR: ADDRESS_MISALIGN\n");
+	if((response >> 29) & 0x01) printf("ERROR: BLOCK_LEN_ERROR\n");
+	if((response >> 28) & 0x01) printf("ERROR: ERASE_SEQ_ERROR\n");
+	if((response >> 27) & 0x01) printf("ERROR: ERASE_PARAM_ERROR\n");
+	if((response >> 26) & 0x01) printf("ERROR: WP_VOILATION\n");
+	if((response >> 25) & 0x01) printf("STATUS: DEVICE_IS_LOCKED\n");
+	if((response >> 24) & 0x01) printf("ERROR: LOCK_UNLOCK_IS_FAILED\n");
+	if((response >> 23) & 0x01) printf("ERROR: COM_CRC_ERROR\n");
+	if((response >> 22) & 0x01) printf("ERROR: ILLEGAL_COMMAND\n");
+	if((response >> 21) & 0x01) printf("ERROR: DEVICE_ECC_FAILED\n");
+	if((response >> 20) & 0x01) printf("ERROR: CC_ERROR\n");
+	if((response >> 19) & 0x01) printf("ERROR: ERROR\n");
+	if((response >> 16) & 0x01) printf("ERROR: CID/CSD OVERWRITE\n");
+	if((response >> 15) & 0x01) printf("ERROR: WP_ERASE_SKIP\n");
+	if((response >> 13) & 0x01) printf("ERROR: ERASE_RESET\n");
+	state = (response >> 9)& 0xF;
+	switch(state)
+	{
+		case 0:
+			str = "IDLE";
+			break;
+		case 1:
+			str = "READY";
+			break;
+		case 2:
+			str = "IDENT";
+			break;
+		case 3:
+			str = "STDBY";
+			break;
+		case 4:
+			str = "TRANS";
+			break;
+		case 5:
+			str = "DATA";
+			break;
+		case 6:
+			str = "RCV";
+			break;
+		case 7:
+			str = "PRG";
+			break;
+		case 8:
+			str = " DIS";
+			break;
+		case 9:
+			str = "BTST";
+			break;
+		case 10:
+			str = "SLP" ;
+			break;
+		default:
+			printf("Attention : Device state is INVALID: Kindly check the Response\n");
+			goto out_free;
+	}
+	printf("DEVICE STATE: %s\n",str);
+	if((response >> 8) & 0x01) printf("STATUS: READY_FOR_DATA\n");
+	if((response >> 7) & 0x01) printf("ERROR: SWITCH_ERROR\n");
+	if((response >> 6) & 0x01) printf("STATUS: EXCEPTION_EVENT\n");  /* Check EXCEPTION_EVENTS_STATUS field to understand what further actions are needed*/
+	if((response >> 5) & 0x01) printf("STATUS: APP_CMD\n");
+out_free:
 	close(fd);
 	return ret;
 }
-- 
2.25.1

