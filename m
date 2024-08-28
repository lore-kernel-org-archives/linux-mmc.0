Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABFD14B945
	for <linux-mmc@vger.kernel.org>; Wed, 28 Aug 2024 06:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825245; cv=none; b=MaS9ia3dFnLjViam7CRYsQH0Du9FQghmbE22uPmJLfC7POY7gLo32f5B701cyuM+R5xfDvROiwqHvpX8bvJONPU/b2UlDLbOo1r/8GMLErPZjVRb89tiAV8j2ZwZR3FHbKoAql86oM/xJOGcAniuy8VMehfE7dqkx71lZYkeL3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825245; c=relaxed/simple;
	bh=fcEodSy0TjEbdvSJs/d/MvMuD1g2v7TaY9sL8tjpaDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=ahBSEh+Ric25kBp0o3lOgMAn+REitLh0g+ulT4rtIcqFO9FNJ9KYC6eU+5DPGoW9tcXe21eDQzibwe8vRbHdLyy1dNI0gFIE8dCwDC1TNkLnLUwYeFA8idVD2Alf0D0NJENM7fnHUpVPLlSLFfzEYIZIYs4ZOA4mCBiorSFAfnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UQ5LkAaK; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UQ5LkAaK"
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240828060714epoutp04ad24845f403d09038f92940169c4c49d~vz2meWggS3100131001epoutp04V
	for <linux-mmc@vger.kernel.org>; Wed, 28 Aug 2024 06:07:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240828060714epoutp04ad24845f403d09038f92940169c4c49d~vz2meWggS3100131001epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724825234;
	bh=Q5KRJpV/+Wu0orUI+p+Nc2R0NSxvbe7jBlAEVQTUhQw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=UQ5LkAaKB53p7Uv5B5vDofYwWxeJ6Io0Z24+R13RTCkV6bYfl1SUspUaMLRou1PUo
	 7HzQzJAF4+NWBCQDsKJn2GEDt3F1TMgCissRdcOSi3I6stzhXocdSPiXlRmpsVJou1
	 JX+85p7EVFfqu4f/xSQd4EJWR8gGWHmU+6C5eoEc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240828060714epcas1p4e1c2dcd122e01b6aae0e484646bd373e~vz2lsc8wg3141131411epcas1p4A;
	Wed, 28 Aug 2024 06:07:14 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.225]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Wtv814Qlxz4x9Pw; Wed, 28 Aug
	2024 06:07:13 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	7E.80.09725.19EBEC66; Wed, 28 Aug 2024 15:07:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240828060713epcas1p4ff8b4f345747eeb7e581385a62d07879~vz2k9nRKo2831028310epcas1p4n;
	Wed, 28 Aug 2024 06:07:13 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240828060713epsmtrp1144a6d6e8a18aa0477e56e148d01b0f4~vz2k8wc-d2568125681epsmtrp1V;
	Wed, 28 Aug 2024 06:07:13 +0000 (GMT)
X-AuditID: b6c32a37-a8ce5a80000025fd-3f-66cebe915d03
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A7.39.08456.09EBEC66; Wed, 28 Aug 2024 15:07:13 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.171]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240828060712epsmtip2f099b6e35db06efdd56767e3255d2ad2~vz2ksGEaW1504715047epsmtip2L;
	Wed, 28 Aug 2024 06:07:12 +0000 (GMT)
From: Seunghwan Baek <sh8267.baek@samsung.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	ulf.hansson@linaro.org, ritesh.list@gmail.com, quic_asutoshd@quicinc.com,
	adrian.hunter@intel.com
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, junwoo80.lee@samsung.com,
	dh0421.hwang@samsung.com, jangsub.yi@samsung.com, sh043.lee@samsung.com,
	cw9316.lee@samsung.com, sh8267.baek@samsung.com, wkon.kim@samsung.com
Subject: [PATCH 2/2] mmc : fix for check cqe halt.
Date: Wed, 28 Aug 2024 15:07:08 +0900
Message-Id: <20240828060708.20807-1-sh8267.baek@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7bCmge7EfefSDF7uVrQ4+WQNm8WMU22s
	FvuunWS3+PV3PbtFx9bJTBY7np9ht9j1t5nJ4vKuOWwWR/73M1os7JjLYnHwVAe7RdOffSwW
	186cYLU4vjbcYvOlbywO/B47Z91l91i85yWTx51re9g8Ju6p8+jbsorR4/MmuQC2qGybjNTE
	lNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKCLlRTKEnNKgUIB
	icXFSvp2NkX5pSWpChn5xSW2SqkFKTkFZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGd+2TWMr
	6OGvePnsJ3MD4z6eLkZODgkBE4kDv18zdzFycQgJ7GCUWPj2MhtIQkjgE6PEvu0REIlvjBJv
	brQwwnTMv7OcESKxl1Fi5tNzUO2fGSV+bP/FDFLFJqAn8ar9MBtIQkRgEaPE3h93wKqYBe4z
	Suw/+AdslrCAkcSp9ffBbBYBVYk1ffvZQWxeARuJo5MnsUHsk5dYveEAWLOEwFd2ifNHnkIl
	XCReHd3OCmELS7w6voUdwpaSeNnfBmUXSyzcOIkFormFUeL68j9QX9hLNLc2Aw3iADpJU2L9
	Ln2QMLMAn8S7rz2sIGEJAV6JjjYhiGpViVMbtkJ1Sktcb26AWush8bT7OzTAYiXutb9mncAo
	Mwth6AJGxlWMYqkFxbnpqcWGBcbwuEnOz93ECE57WuY7GKe9/aB3iJGJg/EQowQHs5II74nj
	Z9OEeFMSK6tSi/Lji0pzUosPMZoCA2kis5Rocj4w8eaVxBuaWBqYmBmZWBhbGpspifOeuVKW
	KiSQnliSmp2aWpBaBNPHxMEp1cCUaiBQ6na0vMj68pubTm06t0Nj3RYzMgQsubK99r3NQ61b
	n06ICu59O/3WXJFT35MXu7buP718ku/9g6t+nVSuX7prrcDGCs+YrZqtftestvpPnJ63blbr
	dM4Jv5hy16SZ2Dw17pVgvnk9QpdhVtGvDR7964uuHmE+aV+6+ogi9/zni4SieWwv3bLef/F9
	drSd1AU7iQuf3t48sszjx6qHjQf36f+5sb4z4LeN72KDDAPZjX4TWbxi59edPRu76j/LS2fh
	+HUcnx8HpfR+7Pune3eNuVjgz+WlDy2k5XV+Gcyf1rI44lUQ74Tt5/tXR7XMM4/vdmqo5u/R
	SecLWv6xTFzo2cTnGplTpunfTq3UV2Ipzkg01GIuKk4EAHRxvgIEBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsWy7bCSvO7EfefSDK6/Z7I4+WQNm8WMU22s
	FvuunWS3+PV3PbtFx9bJTBY7np9ht9j1t5nJ4vKuOWwWR/73M1os7JjLYnHwVAe7RdOffSwW
	186cYLU4vjbcYvOlbywO/B47Z91l91i85yWTx51re9g8Ju6p8+jbsorR4/MmuQC2KC6blNSc
	zLLUIn27BK6Mb9umsRX08Fe8fPaTuYFxH08XIyeHhICJxPw7yxm7GLk4hAR2M0p0/XzOApGQ
	lnh84CVQggPIFpY4fLgYJCwk8JFRYuJrHxCbTUBP4lX7YTaQXhGBFYwSM5dPZQZJMAu8Bhp0
	IQLEFhYwkji1/j4jiM0ioCqxpm8/O4jNK2AjcXTyJDaIXfISqzccYJ7AyLOAkWEVo2RqQXFu
	em6xYYFRXmq5XnFibnFpXrpecn7uJkZwaGpp7WDcs+qD3iFGJg7GQ4wSHMxKIrwnjp9NE+JN
	SaysSi3Kjy8qzUktPsQozcGiJM777XVvipBAemJJanZqakFqEUyWiYNTqoFJcrtHovLaM1XO
	L+7sMCrzOR767fQUkQNl2fGbAt6qeXIz7d4YnWG3q1ChIYlBYduvJTmMC5I+R9d9PNS4WkPa
	9M7Ss7p51gvZmvVtm26LmGSLxqzNeXBq0c7Y3tMzkw6oFu0Rlch9fiTduei/R5qKwzXbPwq/
	POesXxJ62qJco4WB9XNCmf6xdx5vzDn3d+wUY5gRL3JFadXUlXbaZi29m0Nepxx7cX9z0jKm
	e91/F67U/udqe0Dn2p/f3SEZW8J8pZnvzbt29XnPkal2xy4sfSgVcOiEiRlTPn/prVd5rUfW
	X1Tl1p5ha98/f3rRy2sn/2b53Y5/N8l864Ebc47svMN6+8VP7Tde3Hovkr7GK7EUZyQaajEX
	FScCABQWmxW8AgAA
X-CMS-MailID: 20240828060713epcas1p4ff8b4f345747eeb7e581385a62d07879
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240828060713epcas1p4ff8b4f345747eeb7e581385a62d07879
References: <CGME20240828060713epcas1p4ff8b4f345747eeb7e581385a62d07879@epcas1p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Code to check whether cqe is in halt state is modified to cqhci_halted,
which has already been implemented.

Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
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

