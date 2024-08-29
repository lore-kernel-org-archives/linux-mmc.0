Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F10146D6B
	for <linux-mmc@vger.kernel.org>; Thu, 29 Aug 2024 06:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912322; cv=none; b=U/N9idQnUneNFBFxTka/uHBRAQiMHcb2qmxtHx4UFfY4KV8KwpbZ92iA54FbjNPClsDYJZMYF3qeX8eM1LbsNtosAk+LnWCxoOXRNNDwNSSv1IbFeHFQG86emhGCUUOOwq/vaboh7mo4RzKkbrvzNIn7VBRC1RrAUX4cX9aoyQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912322; c=relaxed/simple;
	bh=B5igwmVxT26gZJCM/XFa30ybfP+wv7/f5eHeCK9IXig=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=d/nIHiBbNxAW4OIfhT/Exd/B3cXiXl9V2JKHX3+A84OsqXgN6DvsRjSIyDl0RExyu4tgcOn0u+OzjSAjuzyBDwJvG2AzwISVWgstQdzaR7m0pFBfSL259E0mHTF5t+f1+c70W8vupFBS5l4dplnsBKh8K6cVoJ0uumJTQ54+rog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KWFDXO+X; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KWFDXO+X"
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240829061836epoutp0257c97bbd568683863875699d490a5252~wHpzKQ7q52383223832epoutp02j
	for <linux-mmc@vger.kernel.org>; Thu, 29 Aug 2024 06:18:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240829061836epoutp0257c97bbd568683863875699d490a5252~wHpzKQ7q52383223832epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724912316;
	bh=f3aZyQOzdwCUe2jYrERkEiVouCvT8uBAms8XHTyBERE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=KWFDXO+XdpUJEdYtRd7eARDa+QjosAmdGF/cltfGnFbYhzRJstC78BUdOvePUs5k5
	 4PCKn4mS6Dd7UFBZ1OV1xL0ps/1z7kD94k+OE1HKaJpM7i7LVJUgqM0SOQkie4h+9d
	 /d8nUI4nvfvpOspdpw3tYxj8kF8jhaKX1J29EB0E=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20240829061835epcas1p3a8b8c10f24ff9e7dd4dcff884d6c1ad5~wHpygsuZJ3110431104epcas1p3L;
	Thu, 29 Aug 2024 06:18:35 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.242]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4WvWLf6jB4z4x9Q6; Thu, 29 Aug
	2024 06:18:34 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	77.CA.19509.AB210D66; Thu, 29 Aug 2024 15:18:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240829061834epcas1p127b6ec517e904efbf1eba945fbfd4bb0~wHpxuiJBV1114911149epcas1p1U;
	Thu, 29 Aug 2024 06:18:34 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240829061834epsmtrp1c2ce1086fe65b5ea7482ccb8e61bf3fa~wHpxtsGAX0812908129epsmtrp1H;
	Thu, 29 Aug 2024 06:18:34 +0000 (GMT)
X-AuditID: b6c32a4c-17bc070000004c35-73-66d012bac836
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	C4.57.19367.AB210D66; Thu, 29 Aug 2024 15:18:34 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.171]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240829061834epsmtip220ba0e74fc2e27f657a4d087e2dc30ed~wHpxefwgd2307823078epsmtip2H;
	Thu, 29 Aug 2024 06:18:34 +0000 (GMT)
From: Seunghwan Baek <sh8267.baek@samsung.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	ulf.hansson@linaro.org, ritesh.list@gmail.com, quic_asutoshd@quicinc.com,
	adrian.hunter@intel.com
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, junwoo80.lee@samsung.com,
	dh0421.hwang@samsung.com, jangsub.yi@samsung.com, sh043.lee@samsung.com,
	cw9316.lee@samsung.com, sh8267.baek@samsung.com, wkon.kim@samsung.com
Subject: [PATCH v2 0/2] mmc: cqhci: Fix for check CQHCI_HALT state.
Date: Thu, 29 Aug 2024 15:18:21 +0900
Message-Id: <20240829061823.3718-1-sh8267.baek@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmnu4uoQtpBi+PGVucfLKGzWLGqTZW
	i33XTrJb/Pq7nt2iY+tkJosdz8+wW+z628xkcXnXHDaLI//7GS0WdsxlsTh4qoPdounPPhaL
	a2dOsFocXxtusfnSNxYHfo+ds+6yeyze85LJ4861PWweE/fUefRtWcXo8XmTXABbVLZNRmpi
	SmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtDFSgpliTmlQKGA
	xOJiJX07m6L80pJUhYz84hJbpdSClJwCswK94sTc4tK8dL281BIrQwMDI1OgwoTsjIf/vjIV
	/GaqOPK2hb2BcQlTFyMnh4SAicSX7TsZuxi5OIQE9jBKfP98lBnC+cQocWzpLjY4Z/PePriW
	9xPvQCV2MkqsfQZT9ZlRYv/WG2wgVWwCehKv2g+DJUQEFjFK7P1xB2wws8B9oKqDfxhBqoQF
	nCU+Xn3B0sXIwcEioCpx900IiMkrYC2x42UwxDZ5idUbDoC1Sgi8ZJc48/MoG0iNhICLxL7P
	AhA1whKvjm9hh7ClJF72t0HZxRILN05igehtYZS4vhxirYSAvURzazPYHGYBTYn1u/RBwswC
	fBLvvvawQoznlehoE4KoVpU4tWErVKe0xPXmBlYI20Niy8FuZhBbSCBWYmvrWrYJjDKzEIYu
	YGRcxSiVWlCcm56abFhgqJuXWg6PneT83E2M4NSn5bOD8fv6v3qHGJk4GA8xSnAwK4nwnjh+
	Nk2INyWxsiq1KD++qDQntfgQoykwlCYyS4km5wOTb15JvKGJpYGJmZGJhbGlsZmSOO+ZK2Wp
	QgLpiSWp2ampBalFMH1MHJxSDUzd6X/2GgX8UfYw7eIIDWOt/O8ib/G35oqNe+l09eCLZROU
	uiwef7yoflfwm5qf6fcnntbVamGaOfHV/6cfbw+u+3CBbceebLXc5Vz9/Rv/8Wa2qtvusHNn
	cwj/41bbXn+u9V79j0dbua4H7/wR5Cn34fIXrk2F86/u3uxuM+dKcfaiVgbJ6NmTF7z7bNpz
	vXNOys5pV1Q/VbQeEzu/cIETy63fzj3rv6r+2D75/vVVJ9dmOhn5aJ4UrfU/bm/qdG3lyZy0
	+d6Lq/nKtuTMeTc/Y4qWVrDB6+TTP9TkKh6/qDnXr9fu9+DGxP7TDucXeVTd14yW+ynx32Vz
	ReTSho6Ia35mixTvdFe/ZbM8U6/EUpyRaKjFXFScCABOwngYBgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSvO4uoQtpBtuuiFucfLKGzWLGqTZW
	i33XTrJb/Pq7nt2iY+tkJosdz8+wW+z628xkcXnXHDaLI//7GS0WdsxlsTh4qoPdounPPhaL
	a2dOsFocXxtusfnSNxYHfo+ds+6yeyze85LJ4861PWweE/fUefRtWcXo8XmTXABbFJdNSmpO
	Zllqkb5dAlfGw39fmQp+M1UcedvC3sC4hKmLkZNDQsBE4v3EO2xdjFwcQgLbGSW+tj1jh0hI
	Szw+8JKxi5EDyBaWOHy4GKLmI6PE9y/LwWrYBPQkXrUfBmsWEVjBKDFz+VRmkASzwGtGia4L
	ESC2sICzxMerL1hABrEIqErcfRMCYvIKWEvseBkMsUpeYvWGA8wTGHkWMDKsYhRNLSjOTc9N
	LjDUK07MLS7NS9dLzs/dxAgOSK2gHYzL1v/VO8TIxMF4iFGCg1lJhPfE8bNpQrwpiZVVqUX5
	8UWlOanFhxilOViUxHmVczpThATSE0tSs1NTC1KLYLJMHJxSDUyTzFb8Zq/KOOg3k8WemeGA
	lPKrM1M1nn3R3ql8rej+/PP/Lsz6us/2qPpb8+h9PTyWZ5NC8nft03ofM9votWHImznlmoek
	kvM8Fq2R3vPYcsMHUxNTH3mlbzeDv72Ld3omWxwbH//x8oV7bM++lPjn7vKuZJM689GkNyvK
	99tVPYvM0NUPrpetd1Kx0fGpS1+dnHxZcvpBrqi9AclCJcUPW+JCXluK/ePq+JC4g3tD8Cfn
	/FvFBmb8h5PEk2bysqWnq8n1rNc+cYBV/X/61if9FyZEVpz+LPS/WU039+mZijaZFfY3L125
	vzQ5Ivjczr818RNer+jsmF55vN9moV/L2uCL/lpXw334jHvtmZVYijMSDbWYi4oTAXvM9Nu3
	AgAA
X-CMS-MailID: 20240829061834epcas1p127b6ec517e904efbf1eba945fbfd4bb0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240829061834epcas1p127b6ec517e904efbf1eba945fbfd4bb0
References: <CGME20240829061834epcas1p127b6ec517e904efbf1eba945fbfd4bb0@epcas1p1.samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Code fix for check cqe halt state.

---
Changes in v2:
 - Modify and delete "Fixes" tag.
 - Change the subject of each commit.

---

Seunghwan Baek (2):
  mmc: cqhci: Fix checking of CQHCI_HALT state
  cqhci-core: Make use cqhci_halted() routine

 drivers/mmc/host/cqhci-core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
2.17.1

