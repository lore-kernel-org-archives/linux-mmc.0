Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E6333EA
	for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2024 00:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733790841; cv=none; b=tufjryJVRJnCrlpCh8NjLzovmzVwbfzoPszV5rm15JyYSSoZPgEJOL7vIkO+7YNe7gvggyECVfJ3XzFDBnnIXabC3YIYVNdVZrcJISaXSFy6IhvXDMvD3oC1CzBMcotwnC8dZL01XhobsP1Z1uOvLCuO9xPtfLq/9qJ50YGNDI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733790841; c=relaxed/simple;
	bh=QHDJI8gdZp24CySv5qrmFNX0OhfRZ9NJ4VIR1pslovk=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:Content-Type:
	 References; b=udeGDFoCFhWF70WgWIP/qZ196Eqm7WkzhmLqWPdKDXEFBZaY1aKU1IVnH6zSzAOOrRc/g1k9irEoToa/m4gbeagpFtOfHZxUQqHienRsQ1aFrSQjobl4B/jhCfFQH+bg6TbDmSiGHfq7hC+leNYeDMEXvpcECrlXx45+yCIfPvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QnNZOgZU; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QnNZOgZU"
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241210003350epoutp0332fe487bf0fd4571cb78c8e6be497f06~PqZL_Jk1p1685116851epoutp03y
	for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2024 00:33:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241210003350epoutp0332fe487bf0fd4571cb78c8e6be497f06~PqZL_Jk1p1685116851epoutp03y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733790830;
	bh=UfUjOYZCSgBi8NRaeJjylshmPJeF0tB5GjDkTujFBSE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=QnNZOgZUmaEfROt+Kn1WxxArmpIjt+P0VcuWauYMXkIZBi73yPyMwsvl7jUnS3QBK
	 42LO30M2GBuwPfZgMKtiranGbljEklbuZO+ho5CdJoqaoQVT6J4GIJcV3MZeaZt6fw
	 Heh4VDm+V13W8f6/UoNl0iy+SsWMzr/atW2EJSp4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20241210003349epcas1p38794e0b4550e4aa8a79a4062db1e9236~PqZLjktGB0579305793epcas1p34;
	Tue, 10 Dec 2024 00:33:49 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.133]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Y6fqK0jZDz4x9QC; Tue, 10 Dec
	2024 00:33:49 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	9B.A5.24218.B6C87576; Tue, 10 Dec 2024 09:33:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241210003347epcas1p1c58d98e315c5aef4b8aac6219adb9270~PqZI-JxBN0345703457epcas1p1R;
	Tue, 10 Dec 2024 00:33:47 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241210003347epsmtrp289d801d6a3b9684b8c14211c0a164565~PqZI_Z4900444904449epsmtrp2K;
	Tue, 10 Dec 2024 00:33:47 +0000 (GMT)
X-AuditID: b6c32a38-580dc70000005e9a-c7-67578c6b6066
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A1.8A.18949.B6C87576; Tue, 10 Dec 2024 09:33:47 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241210003346epsmtip24fa55e7610d5bb1545a95498efc3006e~PqZI0MVDg2325623256epsmtip2l;
	Tue, 10 Dec 2024 00:33:46 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Adrian Hunter'" <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>
Cc: <ulf.hansson@linaro.org>
In-Reply-To: <fe7d3b1e-1e87-49f2-806b-513bd214c854@intel.com>
Subject: RE: [PATCH] mmc: sdhci-of_dwcmshc: Change to dwcmshc_phy_init for
 reusing codes
Date: Tue, 10 Dec 2024 09:33:46 +0900
Message-ID: <0a4b01db4a9b$2cc66f30$86534d90$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKKokFll6i+VyC82vRnqomB67d7lgMmjEaJArFrSVYBwfrDiAF6RTfqsTdNo2A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKKsWRmVeSWpSXmKPExsWy7bCmvm52T3i6wfV5KhYnn6xhszjyv5/R
	4vjacAdmj8V7XjJ53Lm2h83j8ya5AOaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11D
	SwtzJYW8xNxUWyUXnwBdt8wcoD1KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALT
	Ar3ixNzi0rx0vbzUEitDAwMjU6DChOyM7S9OshdsdKnYvXsOcwPjBosuRk4OCQETia/37jB2
	MXJxCAnsYJSY9OsgO0hCSOATo8TG+a4QiW+MEt+/r2OC6Xi8YxczRNFeRondT6Dsl4wSJ04V
	g9hsAnoS/xctBIuLCPhI3OhbzgJiMwvISMz8spYVxOYUsJW4e2wz2DJhgSiJtkdzGUFsFgFV
	iX1vX7CB2LwClhIXV0PskhBQkPj5dBkrxEw/ids9TYwQM0UkZne2MYMcKiGwi13ixtPTUA0u
	Ep8WrYQ6Wlji1fEt7BC2lMTnd3vZIBqaGSWWLjnICuH0MEr8a7jOBlFlLLF/6WSgbg6gFZoS
	63fpQ2zjk3j3tYcVJCwhwCvR0SYEUa0icen1SyaY+Xef/GeFsD0kmlevZYeE4jImibenbzNP
	YJSfheTwWQgbFjAyrWIUSy0ozk1PLTYsMIHHZHJ+7iZGcPrSstjBOPftB71DjEwcjIcYJTiY
	lUR4ObxD04V4UxIrq1KL8uOLSnNSiw8xmgKDciKzlGhyPjCB5pXEG5pYGpiYGRmbWBiaGSqJ
	8565UpYqJJCeWJKanZpakFoE08fEwSnVwDShMMrmxi7xl60HFr8S/W8Yc8FmTfuJF3esHt40
	DGt8/ijao8TQN6T/9toNk3z5QhPMnis5pqumeaz9FFveamH2iCXfbMrupUvtU3MuN9Wf97X6
	+edL47TzsocDHymvumnn2J/yYV5IQlZjxCLuY5oeZ2y6dEJu5kRaHSnd/kYpwmpxqpcEw/MT
	S47cm/8sXuyH7R1RLan7T+cseX2ueX0rv7db/wG5CS6i+4T3TA7w4VVUvjl7ZQFT9lrJ7ojl
	t6QlPgQqM+b81FrSvG6DC+ffPpFz15PcIvpjhTjrjvd7SXTIql59e2nrzw6jNQfuzdEReybB
	PyVg0lZG3l6vVMEey0MHIwMO8ZieCH3GqMRSnJFoqMVcVJwIAFoDe4foAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsWy7bCSvG52T3i6weGdLBYnn6xhszjyv5/R
	4vjacAdmj8V7XjJ53Lm2h83j8ya5AOYoLpuU1JzMstQifbsEroztL06yF2x0qdi9ew5zA+MG
	iy5GTg4JAROJxzt2MXcxcnEICexmlPj6djErREJK4vPTqWxdjBxAtrDE4cPFEDXPGSVWzD3F
	BFLDJqAn8X/RQmYQW0TAT+LD199gNrOAjMTML2vB5ggJzGOS+LOHE8TmFLCVuHtsMzuILSwQ
	IdGxvYEFxGYRUJXY9/YFG4jNK2ApcXH1LmaIGxQkfj5dxgoz/3ZPEyPEfBGJ2Z1tzBMYBWYh
	cRcwMq5ilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAgOPy2tHYx7Vn3QO8TIxMF4iFGC
	g1lJhJfDOzRdiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+3170pQgLpiSWp2ampBalFMFkmDk6p
	BqYFlrkBwuIruPzPGK3NmqEdbKUtrRESp76glil53g51p0+1n67aSBlsOB+75MSbPy2PogVU
	vEsOiq7fbOw2q0/2YeV0oZNXNOJuFq1ftXjjhJXq6Uu8w6sDckwbop5k+/NIdP1l8TRK8sqo
	FKpiafawWrdt8abz+h7uL7jyXK3ynJTe/k+ROdL+cdr0t3YqK6uPfNm4Uyzlv3HHTuWdqcvK
	pzit56+vqllwr11mj6bAwzMZhtuvyk/0v8n4WOq8oc+dgKN5+w+/l9Gfs07uio/LJs+5V23v
	drWvqn+V+L3wUlLNZMm9wjeeXwz63BzlxbHmnsLCq7eKm14/X7uhtq5qis3kxMKgjMfp03//
	KFViKc5INNRiLipOBAAK6ecmrgIAAA==
X-CMS-MailID: 20241210003347epcas1p1c58d98e315c5aef4b8aac6219adb9270
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241204100508epcas1p2cc54ed287df5a361536b68971bca48f6
References: <CGME20241204100508epcas1p2cc54ed287df5a361536b68971bca48f6@epcas1p2.samsung.com>
	<20241204100507.330025-1-jh80.chung@samsung.com>
	<36d8b897-e8d0-4262-b60b-a5510e93c6ff@intel.com>
	<052501db476a$1c1d0150$545703f0$@samsung.com>
	<fe7d3b1e-1e87-49f2-806b-513bd214c854@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Hi Adrian,

> -----Original Message-----
> From: Adrian Hunter <adrian.hunter@intel.com>
> Sent: Monday, December 9, 2024 5:14 PM
> To: Jaehoon Chung <jh80.chung@samsung.com>; linux-mmc@vger.kernel.org
> Cc: ulf.hansson@linaro.org
> Subject: Re: [PATCH] mmc: sdhci-of_dwcmshc: Change to dwcmshc_phy_init for reusing codes
>
> On 6/12/24 01:05, Jaehoon Chung wrote:
> >
> >
> >> -----Original Message-----
> >> From: Adrian Hunter <adrian.hunter@intel.com>
> >> Sent: Thursday, December 5, 2024 10:17 PM
> >>
> >> On 4/12/24 12:05, Jaehoon Chung wrote:
> >>> dwcmshc_phy_1_8v_init and dwcmshc_phy_3_3v_init differ only by a few
> >>> lines of code. This allow us to reuse code depending on voltage.
> >>>
> >>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> >>> ---
> >>>  drivers/mmc/host/sdhci-of-dwcmshc.c | 69 +++++------------------------
> >>>  1 file changed, 12 insertions(+), 57 deletions(-)
> >>>
> >>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> >>> index 7ea3da45db32..87bc32d13cc0 100644
> >>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> >>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> >>> @@ -328,11 +328,15 @@ static void dwcmshc_request(struct mmc_host *mmc, struct mmc_request *mrq)
> >>>  	sdhci_request(mmc, mrq);
> >>>  }
> >>>
> >>> -static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
> >>> +static void dwcmshc_phy_init(struct sdhci_host *host)
> >>>  {
> >>>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >>>  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> >>>  	u32 val;
> >>> +	u32 rxsel = PHY_PAD_RXSEL_3V3;
> >>
> >> Nicer to order local variables by descending line length when
> >> possible i.e.
> >>
> >> 	u32 rxsel = PHY_PAD_RXSEL_3V3;
> >> 	u32 val;
> >>
> >>> +
> >>> +	if (host->flags & SDHCI_SIGNALING_180 || priv->flags & FLAG_IO_FIXED_1V8)
> >>
> >> 'host->flags & SDHCI_SIGNALING_180' only means 1.8V signaling
> >> is supported, so this looks strange. Can you clarify this?
> >
> > AFAIK, SDHCI_SIGNALING_180 is to check if its IP(Host controller) supports 1.8V as you mentioned.
> > The previous function (dwcmshc_phy_1_8v_init) is called in sdhci.c. through host->ops-
> >voltage_switch().
> > I couldn't find any other place where its function is called.
> >
> > When ios->signal_voltage is set to MMC_SIGNAL_VOLTAGE_180, dwcmshc_pyh_1_8v_init is called.
> >
> > In the switch statement, if '(!(host->flags & SDHCI_SIGNALING_180))' evaluates to true, it returns -
> EINVAL.
> >
> > So I think that there are only two possible scenarios involving "SDHCI_SIGNALING_180 or
> FLAG_IO_FIXED_1V8".
>
> A third possibility is host->flags has both MMC_SIGNAL_VOLTAGE_180
> and SDHCI_SIGNALING_330, and FLAG_IO_FIXED_1V8 is false.
> What should it do then?

Ah, got it. I didn't consider about called from sdhci_set_uhs_signaling().

How about checking below?

+       if (host->flags & FLAG_IO_FIXED_1V8 ||
+                       (host->mmc->ios.timing & MMC_SIGNAL_VOLTAGE_180 && host->flags & SDHCI_SIGNALING_180))

I think that it's clarifying about other cases.

Best Regards,
Jaehoon Chung

>
> >
> > To clarify this, I will change to if (!!(host->flags & SDHCI_SIGNALING_180) || priv->flags &
> FLAG_IO_FIXED_1V8).
> >
> > And if my understanding is something wrong, let me know, plz.
> >
> > Additionally, I have tested on LicheePi4A.
> >
> >>
> >>> +		rxsel = PHY_PAD_RXSEL_1V8;
> >>>
> >>>  	/* deassert phy reset & set tx drive strength */
> >>>  	val = PHY_CNFG_RSTN_DEASSERT;
> >>> @@ -353,7 +357,7 @@ static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
> >>>  	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
> >>>
> >>>  	/* configure phy pads */
> >>> -	val = PHY_PAD_RXSEL_1V8;
> >>> +	val = rxsel;
> >>>  	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
> >>>  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
> >>>  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> >>> @@ -365,65 +369,20 @@ static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
> >>>  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> >>>  	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
> >>>
> >>> -	val = PHY_PAD_RXSEL_1V8;
> >>> +	val = rxsel;
> >>>  	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLDOWN);
> >>>  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
> >>>  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> >>>  	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
> >>>
> >>>  	/* enable data strobe mode */
> >>> -	sdhci_writeb(host, FIELD_PREP(PHY_DLLDL_CNFG_SLV_INPSEL_MASK, PHY_DLLDL_CNFG_SLV_INPSEL),
> >>> -		     PHY_DLLDL_CNFG_R);
> >>> +	if (host->flags & SDHCI_SIGNALING_180 || priv->flags & FLAG_IO_FIXED_1V8)
> >>> +		sdhci_writeb(host, FIELD_PREP(PHY_DLLDL_CNFG_SLV_INPSEL_MASK,
> >>> +					PHY_DLLDL_CNFG_SLV_INPSEL), PHY_DLLDL_CNFG_R);
> >>
> >> Perhaps slightly more readable to use a variable e.g.
> >
> > Okay. I will update. It was kept the previous code.
> >
> > Best Regards,
> > Jaehoon Chung
> >
> >>
> >> 	/* enable data strobe mode */
> >> 	if (???) {
> >> 		u8 sel = FIELD_PREP(PHY_DLLDL_CNFG_SLV_INPSEL_MASK, PHY_DLLDL_CNFG_SLV_INPSEL);
> >>
> >> 		sdhci_writeb(host, sel, PHY_DLLDL_CNFG_R);
> >> 	}
> >>
> >>>
> >>>  	/* enable phy dll */
> >>>  	sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
> >>> -}
> >>> -
> >>> -static void dwcmshc_phy_3_3v_init(struct sdhci_host *host)
> >>> -{
> >>> -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >>> -	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> >>> -	u32 val;
> >>> -
> >>> -	/* deassert phy reset & set tx drive strength */
> >>> -	val = PHY_CNFG_RSTN_DEASSERT;
> >>> -	val |= FIELD_PREP(PHY_CNFG_PAD_SP_MASK, PHY_CNFG_PAD_SP);
> >>> -	val |= FIELD_PREP(PHY_CNFG_PAD_SN_MASK, PHY_CNFG_PAD_SN);
> >>> -	sdhci_writel(host, val, PHY_CNFG_R);
> >>> -
> >>> -	/* disable delay line */
> >>> -	sdhci_writeb(host, PHY_SDCLKDL_CNFG_UPDATE, PHY_SDCLKDL_CNFG_R);
> >>> -
> >>> -	/* set delay line */
> >>> -	sdhci_writeb(host, priv->delay_line, PHY_SDCLKDL_DC_R);
> >>> -	sdhci_writeb(host, PHY_DLL_CNFG2_JUMPSTEP, PHY_DLL_CNFG2_R);
> >>> -
> >>> -	/* enable delay lane */
> >>> -	val = sdhci_readb(host, PHY_SDCLKDL_CNFG_R);
> >>> -	val &= ~(PHY_SDCLKDL_CNFG_UPDATE);
> >>> -	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
> >>> -
> >>> -	/* configure phy pads */
> >>> -	val = PHY_PAD_RXSEL_3V3;
> >>> -	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
> >>> -	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
> >>> -	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> >>> -	sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
> >>> -	sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
> >>> -	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
> >>> -
> >>> -	val = FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
> >>> -	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> >>> -	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
> >>> -
> >>> -	val = PHY_PAD_RXSEL_3V3;
> >>> -	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLDOWN);
> >>> -	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
> >>> -	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> >>> -	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
> >>>
> >>> -	/* enable phy dll */
> >>> -	sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
> >>>  }
> >>>
> >>>  static void th1520_sdhci_set_phy(struct sdhci_host *host)
> >>> @@ -433,11 +392,7 @@ static void th1520_sdhci_set_phy(struct sdhci_host *host)
> >>>  	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
> >>>  	u16 emmc_ctrl;
> >>>
> >>> -	/* Before power on, set PHY configs */
> >>> -	if (priv->flags & FLAG_IO_FIXED_1V8)
> >>> -		dwcmshc_phy_1_8v_init(host);
> >>> -	else
> >>> -		dwcmshc_phy_3_3v_init(host);
> >>> +	dwcmshc_phy_init(host);
> >>>
> >>>  	if ((host->mmc->caps2 & emmc_caps) == emmc_caps) {
> >>>  		emmc_ctrl = sdhci_readw(host, priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
> >>> @@ -1163,7 +1118,7 @@ static const struct sdhci_ops sdhci_dwcmshc_th1520_ops = {
> >>>  	.get_max_clock		= dwcmshc_get_max_clock,
> >>>  	.reset			= th1520_sdhci_reset,
> >>>  	.adma_write_desc	= dwcmshc_adma_write_desc,
> >>> -	.voltage_switch		= dwcmshc_phy_1_8v_init,
> >>> +	.voltage_switch		= dwcmshc_phy_init,
> >>>  	.platform_execute_tuning = th1520_execute_tuning,
> >>>  };
> >>>
> >
> >
> >



