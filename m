Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCE015B0E4
	for <linux-mmc@vger.kernel.org>; Thu, 29 Aug 2024 06:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912333; cv=none; b=lqfWYNuy9byFjxq3xOBtnWiobb97rGI1dZu97v4TTm1V2z09EG2yLsTQ7W8m+gXDmJnew4+WU0/Qna5rKBrWKg6ayF892aNiAlbTyTNvRGVwWyjHF11H4jU9oMKROa1wp+7zwcE0eIhZ//rNQOqKXlC9lcYA07nazZ6U1Fd9DNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912333; c=relaxed/simple;
	bh=FqSYeuLZIBhiTp2ZRKzZa7zmTuIUAt4v6EvyDsXyqkk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=KuP9xMGFHEDUGTQFMqM/api0L3rEqNo3QRBXQ/1OdW4YQLSqC/t8MXIBL39WAq7MVhhro/kQ2XRw/H6c1wCVoVtaMNuux/bCUGiGo+zs2BiMdm4l4l36YZsdqkpB8D6b3DIvGmNV74wXc0bb/vNjqVl6XhAhGBgM7tSTDxlQ0LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jJ2FeHHS; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jJ2FeHHS"
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240829061844epoutp04bf28aa32ca47677ee5ef5bcfd8d350a8~wHp6mGtma2281222812epoutp04n
	for <linux-mmc@vger.kernel.org>; Thu, 29 Aug 2024 06:18:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240829061844epoutp04bf28aa32ca47677ee5ef5bcfd8d350a8~wHp6mGtma2281222812epoutp04n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724912324;
	bh=05HK0zcy0FyN3BaTxiMDVVrkR8ylzfzdyy7lQoAPCSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jJ2FeHHSeTM2Oajyh3oattUIs2TxU9vQgSx6Hr5+2Dksw4ykAl9uIPh8tctnX1LC+
	 rBqNaI05f7QLI/RLwiWX5tCpAbUClUzPUhifeNHo1ptXrxU6tzmhOCbgYjRQwiK7O3
	 Uh6fT6EEeBc1YjeQvTGMsIA3pPbJ1ODul9H84XiU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240829061843epcas1p40df225e595c277836b5bd765925b5b24~wHp514kuF1419814198epcas1p4v;
	Thu, 29 Aug 2024 06:18:43 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.225]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WvWLp61Twz4x9Q7; Thu, 29 Aug
	2024 06:18:42 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
	60.90.09734.2C210D66; Thu, 29 Aug 2024 15:18:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240829061842epcas1p25b97a685d0946c360338adf716bfaf2b~wHp5GGgvL2336223362epcas1p2d;
	Thu, 29 Aug 2024 06:18:42 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240829061842epsmtrp24e90446c4207b3d0c24951b8787742ae~wHp5FPud70481804818epsmtrp2j;
	Thu, 29 Aug 2024 06:18:42 +0000 (GMT)
X-AuditID: b6c32a39-b5dfa70000002606-6a-66d012c2d982
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	8A.57.19367.2C210D66; Thu, 29 Aug 2024 15:18:42 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.171]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240829061842epsmtip22fd3ded2f32e288805936a346745ee98~wHp41_HE62307423074epsmtip2P;
	Thu, 29 Aug 2024 06:18:42 +0000 (GMT)
From: Seunghwan Baek <sh8267.baek@samsung.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	ulf.hansson@linaro.org, ritesh.list@gmail.com, quic_asutoshd@quicinc.com,
	adrian.hunter@intel.com
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, junwoo80.lee@samsung.com,
	dh0421.hwang@samsung.com, jangsub.yi@samsung.com, sh043.lee@samsung.com,
	cw9316.lee@samsung.com, sh8267.baek@samsung.com, wkon.kim@samsung.com
Subject: [PATCH v2 2/2] cqhci-core: Make use cqhci_halted() routine
Date: Thu, 29 Aug 2024 15:18:23 +0900
Message-Id: <20240829061823.3718-3-sh8267.baek@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240829061823.3718-1-sh8267.baek@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmnu4hoQtpBs0/dS1OPlnDZjHjVBur
	xb5rJ9ktfv1dz27RsXUyk8WO52fYLXb9bWayuLxrDpvFkf/9jBYLO+ayWBw81cFu0fRnH4vF
	tTMnWC2Orw232HzpG4sDv8fOWXfZPRbvecnkcefaHjaPiXvqPPq2rGL0+LxJLoAtKtsmIzUx
	JbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hiJYWyxJxSoFBA
	YnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BWYFecWJucWleul5eaomVoYGBkSlQYUJ2xuKN/SwF
	B/gqWn7eYmxg/MvdxcjJISFgIrHgznKWLkYuDiGBHYwSS3peMUM4nxgl+jacZ4Nz7k9dxgLT
	8uJfFyNEYiejxLTmTiaQhJDAZ0aJXTuqQGw2AT2JV+2HwbpFBBYxSuz9cQdsLrPAfUaJ/Qf/
	MIJUCQs4S7y9cpsdxGYRUJVoab0CZvMKWEssO3iDCWKdvMTqDQeYQWxOARuJhtZmsKkSAq0c
	Eu8X3WSEKHKRmNRwBKpBWOLV8S3sELaUxOd3e9kg7GKJhRsnsUA0tzBKXF/+B6rZXqIZbCoH
	0HmaEut36YOEmQX4JN597WEFCUsI8Ep0tAlBVKtKnNqwFapTWuJ6cwMrhO0h8fDDYiZIsPQz
	Sqw9eoxtAqPsLISpCxgZVzGKpRYU56anFhsWmMIjKjk/dxMjOCFqWe5gnP72g94hRiYOxkOM
	EhzMSiK8J46fTRPiTUmsrEotyo8vKs1JLT7EaAoMsYnMUqLJ+cCUnFcSb2hiaWBiZmRiYWxp
	bKYkznvmSlmqkEB6YklqdmpqQWoRTB8TB6dUA1OR8ZLaU0uDpcyWT1zXzud09sirljKPwqz0
	Sb160vavWF5xJC5Sm/Bdzm4O+5Rip6KJAqITdO26tKS1TdZc0Pxz8H8CR1r+YbMjGi9Oc/lf
	PHH2Xn/i3+3rJyzZ57q4pEezdMnFOHZrHpspy7eU8/hxNl/91SV1qWrf7Q8S52R0Hsuc13r9
	NujTIf9Ht27cmu1fLZn6c3vqmw3uCQ8uMieoqyssWL/klrPjqnkP/3ZkqoXPO72z2Gt23vy/
	t8M3vYqZludlemGjrrzYZLdDZ3QLGucUHXp5+YrYvvK9PAdLk0wXmqws1+4JMWhPU+hJfH1f
	blW112tWJZ5Jgh8Fj4ne+G8+SWeX7qpXh94/qIpVYinOSDTUYi4qTgQAf7LbkhEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsWy7bCSvO4hoQtpBic7BCxOPlnDZjHjVBur
	xb5rJ9ktfv1dz27RsXUyk8WO52fYLXb9bWayuLxrDpvFkf/9jBYLO+ayWBw81cFu0fRnH4vF
	tTMnWC2Orw232HzpG4sDv8fOWXfZPRbvecnkcefaHjaPiXvqPPq2rGL0+LxJLoAtissmJTUn
	syy1SN8ugStj8cZ+loIDfBUtP28xNjD+5e5i5OSQEDCRePGvi7GLkYtDSGA7o8TiGYtYIRLS
	Eo8PvARKcADZwhKHDxdD1HxklLi1cCEjSA2bgJ7Eq/bDbCAJEYEVjBIzl09lBkkwC7xmlOi6
	EAFiCws4S7y9cpsdxGYRUJVoab0CZvMKWEssO3iDCWKZvMTqDQfAejkFbCQaWpvZQGwhoJpP
	K06yT2DkW8DIsIpRNLWgODc9N7nAUK84Mbe4NC9dLzk/dxMjOIi1gnYwLlv/V+8QIxMH4yFG
	CQ5mJRHeE8fPpgnxpiRWVqUW5ccXleakFh9ilOZgURLnVc7pTBESSE8sSc1OTS1ILYLJMnFw
	SjUw2e9WerTPw+JerHXvq9O8GSkL4+arsfIxsk39smPu5dIVdSrLusPPLOXa85+V0W/bBhuR
	puRPzQfP9Os3rlS7l2R2eYVMjePHVO2jU+/Hz9L+nXiv8mVKzc4qp52C5ufdghf5HC0Tdpgd
	dWGv7IV9VcLMfi9uawuuVl+2qFfmc+jeKzzfl+WWrnkQZLWi59iqiy28e6XLDm+3/zExZEun
	rIZwV7fYH9ny3cpTLVd+XvT4YbrkekvHrHlHzUUX7unZrf045Nu9V0wKAqsP7eZwc7SeEJa7
	Ss7S6+xz5br4Ha1H8ifsn/zrxOXJfayfX9u2hqraZ7yJOmF/9+i6sGWmIqf2P6+5fCB3ilqJ
	qtRpLiWW4oxEQy3mouJEAPswO0HRAgAA
X-CMS-MailID: 20240829061842epcas1p25b97a685d0946c360338adf716bfaf2b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240829061842epcas1p25b97a685d0946c360338adf716bfaf2b
References: <20240829061823.3718-1-sh8267.baek@samsung.com>
	<CGME20240829061842epcas1p25b97a685d0946c360338adf716bfaf2b@epcas1p2.samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Code to check whether cqe is in halt state is modified to cqhci_halted,
which has already been implemented.

Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>
---
 drivers/mmc/host/cqhci-core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index a02da26a1efd..178277d90c31 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -33,6 +33,11 @@ struct cqhci_slot {
 #define CQHCI_HOST_OTHER	BIT(4)
 };
 
+static bool cqhci_halted(struct cqhci_host *cq_host)
+{
+	return cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT;
+}
+
 static inline u8 *get_desc(struct cqhci_host *cq_host, u8 tag)
 {
 	return cq_host->desc_base + (tag * cq_host->slot_sz);
@@ -282,7 +287,7 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
 
 	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
 
-	if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT)
+	if (cqhci_halted(cq_host))
 		cqhci_writel(cq_host, 0, CQHCI_CTL);
 
 	mmc->cqe_on = true;
@@ -617,7 +622,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		cqhci_writel(cq_host, 0, CQHCI_CTL);
 		mmc->cqe_on = true;
 		pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
-		if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT) {
+		if (cqhci_halted(cq_host)) {
 			pr_err("%s: cqhci: CQE failed to exit halt state\n",
 			       mmc_hostname(mmc));
 		}
@@ -953,11 +958,6 @@ static bool cqhci_clear_all_tasks(struct mmc_host *mmc, unsigned int timeout)
 	return ret;
 }
 
-static bool cqhci_halted(struct cqhci_host *cq_host)
-{
-	return cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT;
-}
-
 static bool cqhci_halt(struct mmc_host *mmc, unsigned int timeout)
 {
 	struct cqhci_host *cq_host = mmc->cqe_private;
-- 
2.17.1

