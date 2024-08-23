Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3F613AD33
	for <linux-mmc@vger.kernel.org>; Fri, 23 Aug 2024 07:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724397053; cv=none; b=OSBxam4A2Vova5jjROX9WsMI1aC4aJ1SNRfzeD5EZJ3k2bQVn+M1o++WHEYUGtVXVrpLkAjmbrOHQ11g6jktprdFAA0cSdPPvJyR3nPhr+eqUgADo40zgeyJZw9bZC9fgNQs6wwSimB1MQ/rqv6yK2YD8kNdCT2jovZjZ5QwO/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724397053; c=relaxed/simple;
	bh=7bEY5BHshEOBuA2Gob1wOrXnh6efFOAaLeaZpC3zE84=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=M+Si3Zlk6NW9GJyu2ZrR3V+UWKtPD4KPLpVoYQcIKJuWvMQ4UNNJbqOQjm6D0+Z8uZNOFtbNtPhQDQs9V1R3P4vhGDpVNWTXyWBqAGSRrzgnvPS8O8M1Did7/bxFIASVnxI73QikVYOB86Kn8YapZFj0kv5RTV5EO1G6SZSMJvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZcX+COnS; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZcX+COnS"
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240823071042epoutp012ab5edb6e0fdd91f6114cb7e802fedd3~uSfltbiBh2966029660epoutp01F
	for <linux-mmc@vger.kernel.org>; Fri, 23 Aug 2024 07:10:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240823071042epoutp012ab5edb6e0fdd91f6114cb7e802fedd3~uSfltbiBh2966029660epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724397043;
	bh=9VWmLuxYaD6xmjyel1Q0vd8KxN5Mn29C49srXZRZDK8=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ZcX+COnSd4BZ6SNBTKCsYJXayIMmYnwUKqUUQlRUHlklHbf+kJQBsF+BNAbaQKllN
	 eDcwAFbOUN6IuysFJnFRkFPFtgGkiBeoI4zOm1QIWsNWgqBOTZG8t1kZ8JVQkJymwE
	 CqpRnjTw6wz8kqb+lkL6bknvaTdcbauPX+FulwJw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20240823071042epcas1p3a19abd3cf5b65a7e5518c12c797f5640~uSflC20pt0151101511epcas1p3p;
	Fri, 23 Aug 2024 07:10:42 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.224]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WqrnY5ddVz4x9Q1; Fri, 23 Aug
	2024 07:10:41 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	8D.02.10258.1F538C66; Fri, 23 Aug 2024 16:10:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240823071040epcas1p1309967537fb6286a9e67a38e598ce104~uSfjo3zRe1889818898epcas1p1M;
	Fri, 23 Aug 2024 07:10:40 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240823071040epsmtrp1f6c4e28d32a9482c80b32b73e6b8bb6e~uSfjn5UAL0940909409epsmtrp1r;
	Fri, 23 Aug 2024 07:10:40 +0000 (GMT)
X-AuditID: b6c32a38-9ebb870000002812-0a-66c835f1d65f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	5C.C9.19367.0F538C66; Fri, 23 Aug 2024 16:10:40 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.171]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240823071040epsmtip10cb7c3d17ec093d493801decbc092dee~uSfja-A3X3177631776epsmtip1c;
	Fri, 23 Aug 2024 07:10:40 +0000 (GMT)
From: Seunghwan Baek <sh8267.baek@samsung.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	ulf.hansson@linaro.org, ritesh.list@gmail.com
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, junwoo80.lee@samsung.com,
	dh0421.hwang@samsung.com, jangsub.yi@samsung.com, sh043.lee@samsung.com,
	cw9316.lee@samsung.com, sh8267.baek@samsung.com, wkon.kim@samsung.com
Subject: [PATCH] mmc : fix for check cqe halt.
Date: Fri, 23 Aug 2024 16:10:25 +0900
Message-Id: <20240823071025.15410-1-sh8267.baek@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7bCmvu5H0xNpBr8fqFvMONXGarHv2kl2
	i19/17NbdGydzGSx4/kZdotdf5uZLC7vmsNmceR/P6PFwVMd7BZNf/axWFw7c4LV4vjacIvN
	l76xOPB67Jx1l93jzrU9bB59W1YxenzeJBfAEpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9q
	ZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0npJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1
	ICWnwKxArzgxt7g0L10vL7XEytDAwMgUqDAhO2PZ0v1sBd1cFTPn/GdtYFzK0cXIySEhYCKx
	Y9V7li5GLg4hgR2MEpuO72KFcD4xSpxrP8AG58z+t40VpmXp+RYmiMRORoljL+9DVX1mlDj1
	+SU7SBWbgJ7Eq/bDbCC2iECOxI6njYwgRcwC9xkl9h/8wwiSEAYq2neggQXEZhFQldj4fgpY
	M6+AjUTfzPlsEOvkJVZvOMAMYZ9jl3i/Kg/CdpHYeqwZKi4s8er4FnYIW0riZX8blF0ssXDj
	JLDvJARaGCWuL4dYLCFgL9Hc2gy0gAPoIk2J9bv0QcLMAnwS7772sIKEJQR4JTrahCCqVSVO
	bdgK1Sktcb25ARoSHhIzLh0HO1NIIFZiReNMlgmMMrMQhi5gZFzFKJZaUJybnlpsWGACj5rk
	/NxNjOB0pmWxg3Hu2w96hxiZOBgPMUpwMCuJ8CbdO5omxJuSWFmVWpQfX1Sak1p8iNEUGEYT
	maVEk/OBCTWvJN7QxNLAxMzIxMLY0thMSZz3zJWyVCGB9MSS1OzU1ILUIpg+Jg5OqQYma4Gi
	YyE7ir6mxvz9s7z4/8U1rvF/U8+KBS14phj2amnhnjjhbs0rLkqGsbKnO48tkPDSvCmg8yFm
	ofTLU6pCnfvZt7Us82h3ZI44FvvmM/fFb1qBYRMn7+FekB8Y9aB+9YblPzauslU02Vqhpsj7
	8vUJ60P71rxl+32IZ//bE//XZi3NOztNemNft4HTJNUPztz8T5boLpIWYd75TTdrwr6dhZ1v
	vvw+LDtTcoXIxT/ygdc/P/Wbo1taJqCvbhzzdN3cZS8z7eVPJrO/3sH2JnvLuaC7b1OjTbdP
	37lUwqJpY1Lwmy5m7qv2kV6dZ+Lnlv3a97Ol9pTXmjOv9S5V3lvCv4NJzGrVbfP7osfkeZVY
	ijMSDbWYi4oTAbjU8yHwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprELMWRmVeSWpSXmKPExsWy7bCSnO4H0xNpBhs3aVjMONXGarHv2kl2
	i19/17NbdGydzGSx4/kZdotdf5uZLC7vmsNmceR/P6PFwVMd7BZNf/axWFw7c4LV4vjacIvN
	l76xOPB67Jx1l93jzrU9bB59W1YxenzeJBfAEsVlk5Kak1mWWqRvl8CVsWzpfraCbq6KmXP+
	szYwLuXoYuTkkBAwkVh6voWpi5GLQ0hgO6PEvT07WSAS0hKPD7xk7GLkALKFJQ4fLoao+cgo
	8fDhTmaQGjYBPYlX7YfZQGwRgQKJk3/msoLYzAKvGSW6LkSA2MJANfsONIDNZBFQldj4fgo7
	iM0rYCPRN3M+G8QueYnVGw4wT2DkWcDIsIpRNLWgODc9N7nAUK84Mbe4NC9dLzk/dxMjONi0
	gnYwLlv/V+8QIxMH4yFGCQ5mJRHepHtH04R4UxIrq1KL8uOLSnNSiw8xSnOwKInzKud0pggJ
	pCeWpGanphakFsFkmTg4pRqYMtYzeHbe7GLfUX76+aygu+bO+R58S6NMtndvF/+hFmNlscB6
	Sr/3xW1vHxskfwjvFLp85vb6tOtTQ83Xz258UhB754nChBKXWy4SJs3t07+U5m7krPre6NAf
	GftF5IIc4/HpQZpOrxXZe718/L/fZ9m7d0Wt9bQKK+2Tct++yAtlPLlzLlsus+aZ3LHM8Ia/
	lXyTetd9Nz+4rfzlrlkR9vltTzoZZgd+U+LYlTyl0FJkbXdadNcGCX5HyxPLtv3zS5zZV1tS
	sLDeR+CxevfCW0er6iN9D2/Q5Z7nkjjd5WT86xw1nqQzNyzLk84p2PzTFv7QeeUjr9E2lc1K
	XgF/p35nvXn3u9yCj7tmKaYosRRnJBpqMRcVJwIAuqcoVqUCAAA=
X-CMS-MailID: 20240823071040epcas1p1309967537fb6286a9e67a38e598ce104
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240823071040epcas1p1309967537fb6286a9e67a38e598ce104
References: <CGME20240823071040epcas1p1309967537fb6286a9e67a38e598ce104@epcas1p1.samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

To check if mmc cqe is in halt state, need to check
set/clear of CQHCI_HALT bit. At this time, we need to
check with &, not &&. Therefore, code to check whether
cqe is in halt state is modified to cqhci_halted,
which has already been implemented.

Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>
---
 drivers/mmc/host/cqhci-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index c14d7251d0bb..3d5bcb92c78e 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -282,7 +282,7 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
 
 	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
 
-	if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT)
+	if (cqhci_halted(cq_host))
 		cqhci_writel(cq_host, 0, CQHCI_CTL);
 
 	mmc->cqe_on = true;
@@ -617,7 +617,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		cqhci_writel(cq_host, 0, CQHCI_CTL);
 		mmc->cqe_on = true;
 		pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
-		if (cqhci_readl(cq_host, CQHCI_CTL) && CQHCI_HALT) {
+		if (cqhci_halted(cq_host)) {
 			pr_err("%s: cqhci: CQE failed to exit halt state\n",
 			       mmc_hostname(mmc));
 		}
-- 
2.17.1

