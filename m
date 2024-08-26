Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90CA7406F
	for <linux-mmc@vger.kernel.org>; Mon, 26 Aug 2024 05:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724650769; cv=none; b=nLTcQrTCjaHvFwzmaDk64915W7vgq+q4SrLRUdfr3PmajoJiaJ5aIZfd0dAIPX2Wz1357pnj2/e75Eg++De56wFU/sH+dU5mJ08lz3ww3MTwpknWs0eT4T/S0IiPqizLXMUOIXiIAaOv6HVk92MI3Rj1QnwXBlK/EV3YUNxBU8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724650769; c=relaxed/simple;
	bh=SNlrrbSVj6eNiIiWrmFEHbNoLVcYmnMwXRIcNwy0STA=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=BSWlBiPrG/zKNjcXfAzet6SDht68kU1qA9BUjlk/B+Cexww7FMwlZuoKIh3Am7E+KUdqr63RaPxE3NAry8FALOcVmjbR/I1BhtUgLSNPUVc/NFz+JsJm0nzDDnbnC1jRRNuWBPiFYx4+W+3e1cIhWl4GTOmQ0P5pPpYzYlxy36s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=N8jJnG4r; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="N8jJnG4r"
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240826053919epoutp036a0259712d33bb0aa03e29994d8906fb~vMLpcJBxv1475614756epoutp03_
	for <linux-mmc@vger.kernel.org>; Mon, 26 Aug 2024 05:39:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240826053919epoutp036a0259712d33bb0aa03e29994d8906fb~vMLpcJBxv1475614756epoutp03_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724650759;
	bh=jOAO187RpWlY6Ucvl7eOIZ2HoNMJPQUfSR0bWLFBqNk=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=N8jJnG4rfuM4g/VqRuoeI4SzgbyAvQuGlFLDOJt+1z8givKbA/TZ8UEmVin5FKEV9
	 v6Jr+YKB+hdnOSutMgIncWOh/D0SiM113iz9Rn72LeyGGRmns14q7FBzJ4ZvKjYOai
	 En9m8GBZHSeZuCcdrHJFtmkMMN2hFaphmYy/FRQw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240826053918epcas1p2b5baf6b4b158766cbc2591ba3dd26dbc~vMLo78AzF2226222262epcas1p23;
	Mon, 26 Aug 2024 05:39:18 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.225]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Wsfck2lsfz4x9Q7; Mon, 26 Aug
	2024 05:39:18 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	55.60.10258.6051CC66; Mon, 26 Aug 2024 14:39:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240826053917epcas1p2637580b8f464a9edf23e4a0bb1a9fc2e~vMLoMpZ_d2223722237epcas1p2o;
	Mon, 26 Aug 2024 05:39:17 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240826053917epsmtrp13ae8c469426ed4c8cd7f908241892027~vMLoL1VuT2594525945epsmtrp1g;
	Mon, 26 Aug 2024 05:39:17 +0000 (GMT)
X-AuditID: b6c32a38-22f19a8000002812-b8-66cc15068d8d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	82.7B.07567.5051CC66; Mon, 26 Aug 2024 14:39:17 +0900 (KST)
Received: from sh8267baek02 (unknown [10.253.99.49]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240826053917epsmtip27aa1ad319d1e2acddfed328e3c03e06f~vMLn5nbc_1726217262epsmtip2e;
	Mon, 26 Aug 2024 05:39:17 +0000 (GMT)
From: "Seunghwan Baek" <sh8267.baek@samsung.com>
To: "'Ulf Hansson'" <ulf.hansson@linaro.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<ritesh.list@gmail.com>, <grant.jung@samsung.com>, <jt77.jang@samsung.com>,
	<junwoo80.lee@samsung.com>, <dh0421.hwang@samsung.com>,
	<jangsub.yi@samsung.com>, <sh043.lee@samsung.com>, <cw9316.lee@samsung.com>,
	<wkon.kim@samsung.com>
In-Reply-To: <CAPDyKFpSf8GZppkqJCs1r990QXDJMHWHAbVXS2XoffCLQdgSug@mail.gmail.com>
Subject: RE: [PATCH] mmc : fix for check cqe halt.
Date: Mon, 26 Aug 2024 14:39:17 +0900
Message-ID: <012401daf77a$4af8efb0$e0eacf10$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIJDDKk1Bc//6IjZCwYXRBIavO3iAGvlhefArQd3XCxub44cA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmvi6b6Jk0g6+bhSxmnGpjtdh37SS7
	xa+/69ktOrZOZrLY8fwMu8Wuv81MFpd3zWGzOPK/n9Hi4KkOdoumP/tYLI6vDbfYfOkbiwOP
	x85Zd9k97lzbw+bRt2UVo8fnTXIBLFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaW
	FuZKCnmJuam2Si4+AbpumTlAlykplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswK
	9IoTc4tL89L18lJLrAwNDIxMgQoTsjNO3l7AVNDNX9H+4jVrA2MjdxcjB4eEgIlEz+6wLkYu
	DiGBHYwSe95uZYRwPjFKPP/3lg3C+cYoMePAUyCHE6xjct9TFojEXkaJP/O/Q1W9ZJR48fMw
	K0gVm4CBRPOPg+wgtoiAjsSMN81gcWaBDUwS05pCQWxOgUCJnk+bGUFsYQEjiXcvnrCA2CwC
	qhKtT+8ygdi8ApYSF9cdYoOwBSVOzoSoYRbQlli28DUzxEUKEj+fLmOF2OUkMf/3DXaIGhGJ
	2Z1tzCDHSQjs4JA4efcKO0SDi8Sd00uZIGxhiVfHt0DFpSRe9rdB2cUSCzdOYoFobmGUuL78
	DyNEwl6iubWZDRR6zAKaEut36UMs45N497WHFRKovBIdbUIQ1aoSpzZsheqUlrje3MAKYXtI
	zLh0nG0Co+IsJK/NQvLaLCQvzEJYtoCRZRWjWGpBcW56arFhgQk8tpPzczcxglOtlsUOxrlv
	P+gdYmTiYDzEKMHBrCTCK3f5ZJoQb0piZVVqUX58UWlOavEhRlNgYE9klhJNzgcm+7ySeEMT
	SwMTMyMTC2NLYzMlcd4zV8pShQTSE0tSs1NTC1KLYPqYODilGpjaqhdum/fyZ/R+y1mOz9dz
	PZC6ztXOrSBTsHnZ81eTjO21D1veL7TQSeZ4t58rebtGUr2BYmTXNSnWvoZYxziXXxc0Yzwy
	ajdrWNyf8E+pJ/ZVThHn+2KOwOP7FvuKLBX2nlMuubUrrrtR4Jfla+dpF03vsa6ayjc/3/QH
	z3fbEx+PZ/1KCmS8LrYg7JKAykUPzsTUI4+EVifc3b9K578Ot/P/a+rzBM+Hn3usWFbw6qjR
	hJletybsqrqv/POg8u/LC1m2bu58I3f0isGTfRWsMZcOu8w99vp2k7BDxwoJu+lG6xnzcmTZ
	oiM9K9bqa62bXCESWqW86tjBw25qv1jWhB+V1XjzctqFzb6z7cuVWIozEg21mIuKEwHy8MLN
	PgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsWy7bCSvC6r6Jk0g89T9CxmnGpjtdh37SS7
	xa+/69ktOrZOZrLY8fwMu8Wuv81MFpd3zWGzOPK/n9Hi4KkOdoumP/tYLI6vDbfYfOkbiwOP
	x85Zd9k97lzbw+bRt2UVo8fnTXIBLFFcNimpOZllqUX6dglcGf+P/mAsuM9X8Wn6LtYGxptc
	XYycHBICJhKT+56ydDFycQgJ7GaUWHfyLRtEQlri8YGXjF2MHEC2sMThw8UQNc8ZJZp6tzOD
	1LAJGEg0/zjIDmKLCOhIzHjTzApSxCywh0lix/IGVpCEkMBlRon1//JAbE6BQImeT5sZQWxh
	ASOJdy+esIDYLAKqEq1P7zKB2LwClhIX1x1ig7AFJU7OhKhhFtCW6H3YyghjL1v4mhniUAWJ
	n0+XsUIc4SQx//cNdogaEYnZnW3MExiFZyEZNQvJqFlIRs1C0rKAkWUVo2RqQXFuem6yYYFh
	Xmq5XnFibnFpXrpecn7uJkZw1Glp7GC8N/+f3iFGJg7GQ4wSHMxKIrxyl0+mCfGmJFZWpRbl
	xxeV5qQWH2KU5mBREuc1nDE7RUggPbEkNTs1tSC1CCbLxMEp1cC0SMPpRJF5rUT7jBS1Vkfu
	nTxp6Ul8gWZdZQc85s0wk+Ku+XxOJ29lRY1z7JOCZb53r1rEGJ2z4/lkdtLhEJ//F6sk/QrV
	tSEJelEvFs0/3HhUSyTl1GMdEcm8Dr5gxT/LvN6u78pomaye5lu48+RB9tevmReJT3V+JRJ2
	w/PDKVPN5LrZx73SEi1W9s+ebVjYv9VZcemV05rTrk3R6eFv8095Jryom1FIZuv3+L+5T4R0
	7k4XlGQ8dunGjKZZJXqn0/eGzy6zl77/4tffxZ1m+Syi996w2InMnpd7/Ge15f008Ydhm09t
	XSHkqv5WPP3KgZnzL7Mtdri2ZGWqzfNU1fyQW/Jl6o90Mo2/liuxFGckGmoxFxUnAgDgsw//
	KQMAAA==
X-CMS-MailID: 20240826053917epcas1p2637580b8f464a9edf23e4a0bb1a9fc2e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240823071040epcas1p1309967537fb6286a9e67a38e598ce104
References: <CGME20240823071040epcas1p1309967537fb6286a9e67a38e598ce104@epcas1p1.samsung.com>
	<20240823071025.15410-1-sh8267.baek@samsung.com>
	<CAPDyKFpSf8GZppkqJCs1r990QXDJMHWHAbVXS2XoffCLQdgSug@mail.gmail.com>

> >
> > To check if mmc cqe is in halt state, need to check set/clear of
> > CQHCI_HALT bit. At this time, we need to check with &, not &&.
> > Therefore, code to check whether cqe is in halt state is modified to
> > cqhci_halted, which has already been implemented.
> >
> > Signed-off-by: Seunghwan Baek <sh8267.baek=40samsung.com>
>=20
> Hi Seunghwan,
>=20
> Please re-post to include some additional and needed maintainers.
> ./scripts/get_maintainer.pl drivers/mmc/host/cqhci-core.c should give you
> the needed information.
>=20
> Kind regards
> Uffe

Okay. I will send v2 patch.
Thanks.

>=20
> > ---
> >  drivers/mmc/host/cqhci-core.c =7C 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/cqhci-core.c
> > b/drivers/mmc/host/cqhci-core.c index c14d7251d0bb..3d5bcb92c78e
> > 100644
> > --- a/drivers/mmc/host/cqhci-core.c
> > +++ b/drivers/mmc/host/cqhci-core.c
> > =40=40 -282,7 +282,7 =40=40 static void __cqhci_enable(struct cqhci_hos=
t
> > *cq_host)
> >
> >         cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
> >
> > -       if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT)
> > +       if (cqhci_halted(cq_host))
> >                 cqhci_writel(cq_host, 0, CQHCI_CTL);
> >
> >         mmc->cqe_on =3D true;
> > =40=40 -617,7 +617,7 =40=40 static int cqhci_request(struct mmc_host *m=
mc,
> struct mmc_request *mrq)
> >                 cqhci_writel(cq_host, 0, CQHCI_CTL);
> >                 mmc->cqe_on =3D true;
> >                 pr_debug(=22%s: cqhci: CQE on=5Cn=22, mmc_hostname(mmc)=
);
> > -               if (cqhci_readl(cq_host, CQHCI_CTL) && CQHCI_HALT) =7B
> > +               if (cqhci_halted(cq_host)) =7B
> >                         pr_err(=22%s: cqhci: CQE failed to exit halt st=
ate=5Cn=22,
> >                                mmc_hostname(mmc));
> >                 =7D
> > --
> > 2.17.1
> >


