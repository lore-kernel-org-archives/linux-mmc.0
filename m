Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F6949625
	for <linux-mmc@vger.kernel.org>; Thu, 29 Aug 2024 02:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724899658; cv=none; b=KXP/YFgfTLj8dK+ZJfDi7N0sN59JqDnyrUALucnearGGdtdoYHYbcWcmFYkoMBD2tAYCmguCHXfZueL7G/rdT2KjS+NLtu+wBe5JQdCWQjj/XPZravUT5OqEkEyHIdC3MFjiW6YUxUZuBYFcceugbSE8MKBt5FUc9yaeeoUb4zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724899658; c=relaxed/simple;
	bh=LndmaSRPWycIjvvt+LguVgwZN8NSkYWRQ31yXZw1H7A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=bhsJD8iCsV735MUNgRLECjWLI9WgUviOHPFYi/XEPhOaJxduxCZHzPXqMohvHgjvLEUnqTlT69/Vn7LJJ6mqJGg1dY6x0gWjgoeNo5/6XLlzqszKjzZHoyKCdKtFAV5YZHe31dCxdOfVVLVhkeZetEazB9ggXreOmin+hJVZLac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=h4faPB96; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="h4faPB96"
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240829024730epoutp021af728899bb83271bfc4c37df6905105~wExfOOnHF1333413334epoutp02S
	for <linux-mmc@vger.kernel.org>; Thu, 29 Aug 2024 02:47:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240829024730epoutp021af728899bb83271bfc4c37df6905105~wExfOOnHF1333413334epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724899650;
	bh=iMi3K/yNmui2goGbKSjn3Vdv2kWOzw0CLNZZD1owKRQ=;
	h=From:To:Cc:Subject:Date:References:From;
	b=h4faPB96j41vfwgqO+K8k2wAA5i8IVYD+M6hLWNTGJKmsv/vIbHA0Mk7lknAttd5G
	 2IrScrDDpRSrA086l+nUYjbDaYBAGJ5h5ypLT9Ojp1DOckgTUxAafEjgR80zeR8tZO
	 o1coAB+WHywsa6chIytEVul2K5+szPeE6l04kyVA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240829024729epcas1p42e7fbcb57f245375f7ef5447a811e866~wExex786e2349523495epcas1p4A;
	Thu, 29 Aug 2024 02:47:29 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.225]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4WvQg52lN3z4x9Q5; Thu, 29 Aug
	2024 02:47:29 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	FC.58.09734.141EFC66; Thu, 29 Aug 2024 11:47:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240829024728epcas1p2847ea2802d1cc4edeb74559c67925622~wExdvNMoV3104631046epcas1p2H;
	Thu, 29 Aug 2024 02:47:28 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240829024728epsmtrp23964f6ca63463eb0379eaa623bb9d46e~wExdug9KA1411514115epsmtrp22;
	Thu, 29 Aug 2024 02:47:28 +0000 (GMT)
X-AuditID: b6c32a35-babff70000002606-fd-66cfe14120dc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	41.21.19367.041EFC66; Thu, 29 Aug 2024 11:47:28 +0900 (KST)
Received: from lee.. (unknown [10.253.100.232]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240829024728epsmtip233c2fb6f784f6a09bad26805cf1ff3e4~wExdjS5qh2770727707epsmtip2e;
	Thu, 29 Aug 2024 02:47:28 +0000 (GMT)
From: Chanwoo Lee <cw9316.lee@samsung.com>
To: ulf.hansson@linaro.org, ricardo@marliere.net, avri.altman@wdc.com,
	dsimic@manjaro.org, jonathan@raspberrypi.com, xiaokeqinhealth@126.com,
	linux-mmc@vger.kernel.org
Cc: Chanwoo Lee <cw9316.lee@samsung.com>
Subject: [PATCH] mmc:sd:Replace the argument of mmc_sd_switch with the
 already declared define
Date: Thu, 29 Aug 2024 11:47:09 +0900
Message-Id: <20240829024709.402285-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTT9fx4fk0gzN7uC1e/rzKZjHjVBur
	xYUtyhbdtxazWBz5389osfrhDFaL42vDLTrunWdx4PBYevMCi8eda3vYPBoOr2H0+P/7KJtH
	69FfLB59W1YxenzeJOfRfqCbKYAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLC
	XEkhLzE31VbJxSdA1y0zB+gwJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BWYFe
	cWJucWleul5eaomVoYGBkSlQYUJ2xoy/B9gLbslW/Hhi1cD4XbyLkZNDQsBE4sCli0xdjFwc
	QgI7GCVervwD5XxilPj46SQbSBWYc/OYMUzH16/7mSGKdjJKbH+0kwXCecIosertIvYuRg4O
	NgEtidvHvEHiIgKrGSXeXW9gAulmFtCQ+NN2EWyqsECCxMytL8DiLAKqErsWHAWzeQVsJA7N
	fs4GsU1eYv/Bs8wQcUGJkzOfsEDMkZdo3job7AoJgZfsEo+b26EaXCROHpvCCmELS7w6voUd
	wpaS+PxuLxtEQzOjxMI3x6G6JzBKfPl4G6rbXqK5tZkN5AVmAU2J9bv0IbbxSbz72sMKEpYQ
	4JXoaBOCqFaRmNN1jg1m/scbj6H2ekj8u38CGnSxEoc6W9gmMMrNQvLDLCQ/zEJYtoCReRWj
	WGpBcW56arFhgSE8JpPzczcxghOklukOxolvP+gdYmTiYDzEKMHBrCTCe+L42TQh3pTEyqrU
	ovz4otKc1OJDjKbAUJ3ILCWanA9M0Xkl8YYmlgYmZkYmFsaWxmZK4rxnrpSlCgmkJ5akZqem
	FqQWwfQxcXBKNTBdc1/J2HfO+oekXmfIuguR3Xn+7079s1pakFeeYlSpOTW5tk1YalLztorr
	6Sk6H7ZN31M1ya2/Sjuq99+DBrmc5+qHZs/+8O+k+o4Xez+f7+xbcl1P5v8qxgrVuZwblC/+
	lHvydnESy+/gJTdW7i9IWtmp/ea3+42zO99PTNP9OGFvYax4km3lhBtKPvaf5B0ynV+5vdvZ
	aupzNCd6/crWhrtTowQKrgbv4Du89mdP6MmjK2/PFHy69tFWTePO+fP7Z1wKURBd5ZjVd3yN
	4QfrDc/vu6q/F3RxkLjLLhX2wv7LP5XEqbPuzlBbocn67n+9/TFxl+mLT6Yu33ffKsrUQ2+P
	XsD97F9yPY+uxrYmKLEUZyQaajEXFScCABCvtTkZBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsWy7bCSvK7Dw/NpBr2bFC1e/rzKZjHjVBur
	xYUtyhbdtxazWBz5389osfrhDFaL42vDLTrunWdx4PBYevMCi8eda3vYPBoOr2H0+P/7KJtH
	69FfLB59W1YxenzeJOfRfqCbKYAjissmJTUnsyy1SN8ugStjxt8D7AW3ZCt+PLFqYPwu3sXI
	ySEhYCLx9et+5i5GLg4hge2MEn8P3mCBSEhJ7N5/nq2LkQPIFpY4fLgYouYRo8S8E+tYQeJs
	AloSt495g8RFBDYzSvz/OpUZpJdZQEPiT9tFsF5hgTiJqa2FIGEWAVWJXQuOMoHYvAI2Eodm
	P2eDWCUvsf/gWWaIuKDEyZlPWCDGyEs0b53NPIGRbxaS1CwkqQWMTKsYRVMLinPTc5MLDPWK
	E3OLS/PS9ZLzczcxgoNXK2gH47L1f/UOMTJxMB5ilOBgVhLhPXH8bJoQb0piZVVqUX58UWlO
	avEhRmkOFiVxXuWczhQhgfTEktTs1NSC1CKYLBMHp1QDU7p1woy1FQXPJ7wyZZoWIyofden/
	j/k+tUUvVYJP7AtmPKj2PKKib6X3hIj4f5Y7OffP7Xs1I1gnfYrqnTTtScdlfrKELn9Wae57
	L3tHc3n7+YPpbzvmpD829D54QXDh7+V8l/sdYip6rhbMOXTIPlm73vGKLbvAxl3nKoXC+rdF
	hH/6HMvAtyN2doRs3od1Zgcf7/nDmZpsIbFn13x1OwcO68pLR3cbJXfbR7OuOMDSdtv2ZsDN
	ril8Pp9eS+ZlftuwY8ZGlY4LW26ldvFuzNRYOSXqc6TXh0OSQQ9VT26fNKfwxKJ127MEljys
	nX7rlOPZfUY6lncnzN29+f4hy0VHTi/wneCXkD15u+ftwA9KLMUZiYZazEXFiQD9d4G3zQIA
	AA==
X-CMS-MailID: 20240829024728epcas1p2847ea2802d1cc4edeb74559c67925622
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240829024728epcas1p2847ea2802d1cc4edeb74559c67925622
References: <CGME20240829024728epcas1p2847ea2802d1cc4edeb74559c67925622@epcas1p2.samsung.com>

Replace with already defined values for readability.
And since the value of the 'mode' parameter is only used as 0 or 1,
I changed the data type from 'int' to 'bool'.

--------------------------------------------------
/sd.h
/*
 * SD_SWITCH argument format:
 *      [31] Check (0) or switch (1)
...

/*
 * SD_SWITCH mode
 */
  define SD_SWITCH_CHECK         0
  define SD_SWITCH_SET           1
-------------------------------------------------

Signed-off-by: Chanwoo Lee <cw9316.lee@samsung.com>
---
 drivers/mmc/core/sd.c     | 13 ++++++++-----
 drivers/mmc/core/sd_ops.c |  3 +--
 include/linux/mmc/host.h  |  3 ++-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index ee37ad14e79e..d7318c2647da 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -346,7 +346,7 @@ static int mmc_read_switch(struct mmc_card *card)
 	 * The argument does not matter, as the support bits do not
 	 * change with the arguments.
 	 */
-	err = mmc_sd_switch(card, 0, 0, 0, status);
+	err = mmc_sd_switch(card, SD_SWITCH_CHECK, 0, 0, status);
 	if (err) {
 		/*
 		 * If the host or the card can't do the switch,
@@ -402,7 +402,8 @@ int mmc_sd_switch_hs(struct mmc_card *card)
 	if (!status)
 		return -ENOMEM;
 
-	err = mmc_sd_switch(card, 1, 0, HIGH_SPEED_BUS_SPEED, status);
+	err = mmc_sd_switch(card, SD_SWITCH_SET, 0,
+			HIGH_SPEED_BUS_SPEED, status);
 	if (err)
 		goto out;
 
@@ -434,7 +435,8 @@ static int sd_select_driver_type(struct mmc_card *card, u8 *status)
 						   card_drv_type, &drv_type);
 
 	if (drive_strength) {
-		err = mmc_sd_switch(card, 1, 2, drive_strength, status);
+		err = mmc_sd_switch(card, SD_SWITCH_SET, 2,
+				drive_strength, status);
 		if (err)
 			return err;
 		if ((status[15] & 0xF) != drive_strength) {
@@ -514,7 +516,7 @@ static int sd_set_bus_speed_mode(struct mmc_card *card, u8 *status)
 		return 0;
 	}
 
-	err = mmc_sd_switch(card, 1, 0, card->sd_bus_speed, status);
+	err = mmc_sd_switch(card, SD_SWITCH_SET, 0, card->sd_bus_speed, status);
 	if (err)
 		return err;
 
@@ -605,7 +607,8 @@ static int sd_set_current_limit(struct mmc_card *card, u8 *status)
 		current_limit = SD_SET_CURRENT_LIMIT_200;
 
 	if (current_limit != SD_SET_CURRENT_NO_CHANGE) {
-		err = mmc_sd_switch(card, 1, 3, current_limit, status);
+		err = mmc_sd_switch(card, SD_SWITCH_SET, 3,
+				current_limit, status);
 		if (err)
 			return err;
 
diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 8b9b34286ef3..f93c392040ae 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -336,14 +336,13 @@ int mmc_app_send_scr(struct mmc_card *card)
 	return 0;
 }
 
-int mmc_sd_switch(struct mmc_card *card, int mode, int group,
+int mmc_sd_switch(struct mmc_card *card, bool mode, int group,
 	u8 value, u8 *resp)
 {
 	u32 cmd_args;
 
 	/* NOTE: caller guarantees resp is heap-allocated */
 
-	mode = !!mode;
 	value &= 0xF;
 	cmd_args = mode << 31 | 0x00FFFFFF;
 	cmd_args &= ~(0xF << (group * 4));
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 7140e1a7edb4..8fc2b328ec4d 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -649,7 +649,8 @@ static inline void mmc_debugfs_err_stats_inc(struct mmc_host *host,
 	host->err_stats[stat] += 1;
 }
 
-int mmc_sd_switch(struct mmc_card *card, int mode, int group, u8 value, u8 *resp);
+int mmc_sd_switch(struct mmc_card *card, bool mode, int group,
+		u8 value, u8 *resp);
 int mmc_send_status(struct mmc_card *card, u32 *status);
 int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
 int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
-- 
2.34.1

