Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20D91D9A5F
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jan 2025 22:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736808545; cv=none; b=mXh52HErBkFIJx13jQGswgocIRAiiwUETc/Hp/6GnEXylukt4xz6wA6pZcZsFYyGCab9k+VXQTMn4+d1o82+4R9tQgEswV6HqUAUALsJEBWVkvUNSk2HGcp3phFZVS1b2K2v5f4i18jSt8+EZSWGInMxJfm+hb99CdiGx+7RISk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736808545; c=relaxed/simple;
	bh=pbj7sY4PDTF3X0f8gzRKSf5+Zi8wNnnWxU9AAH1vcsc=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:Content-Type:
	 References; b=B7KA7+Vhp+Y8PffXVrY9Id2/p7pXBiALsnJmt6ioWwFrRkXGLmqy4+rl7BgALcX2FI+KDupNkexL3K9pAZi3Ye2qGUs4UCW8zpMxkF4YxTFdXFC0gowwlJK1WR4uCWKlN9lDitNZNrCnyv+mTEbgnUPkQbZN5GDAuzKI058ESYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fdT84Jw9; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fdT84Jw9"
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250113224858epoutp04832dd7c29b60c095c990aea46104b968~aYin1hOih2605026050epoutp04M
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jan 2025 22:48:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250113224858epoutp04832dd7c29b60c095c990aea46104b968~aYin1hOih2605026050epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1736808538;
	bh=YHt0I/jz2uydrz89il7chSZoi/4xIfN/jkfyTMOyWUE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=fdT84Jw9MG3SxHM0HBiYfUb0DCg00StJX3OQr5V3pDYk/sjV74NQiK9It9sgb4qwt
	 vK0JWAzt6mk5K3IiHxxsa3co9kCt34SnavWRZy4D9Wq2kL1lXC6Z54XcXzZyY3Ph8w
	 WlWRlcOYFzeLamLxeqIR8e4pAIj2iGKsh+c5Jtfo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250113224858epcas1p19ac9b967ec1475d379d0cbdf5810b316~aYinfD5_41986419864epcas1p1L;
	Mon, 13 Jan 2025 22:48:58 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.136]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4YX6r92jwHz4x9Pt; Mon, 13 Jan
	2025 22:48:57 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	96.6C.23253.95895876; Tue, 14 Jan 2025 07:48:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250113224856epcas1p1857691207971ac12ca0474509624735d~aYimJrZ3W1986419864epcas1p1H;
	Mon, 13 Jan 2025 22:48:56 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250113224856epsmtrp2d255ec2aba28f0f2d8deb4aca2583cb1~aYimJEeQz0763507635epsmtrp2E;
	Mon, 13 Jan 2025 22:48:56 +0000 (GMT)
X-AuditID: b6c32a33-5b18370000005ad5-86-6785985975df
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4E.BC.18949.85895876; Tue, 14 Jan 2025 07:48:56 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250113224856epsmtip135d41f5e70b74acce7c70a354fae12bb~aYil9Wc9M1821418214epsmtip1c;
	Mon, 13 Jan 2025 22:48:56 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Adrian Hunter'" <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>
Cc: <ulf.hansson@linaro.org>
In-Reply-To: <9e244402-7e1a-4799-a159-b940547b4085@intel.com>
Subject: RE: [PATCH V2] mmc: sdhci-of_dwcmshc: Change to dwcmshc_phy_init
 for reusing codes
Date: Tue, 14 Jan 2025 07:48:56 +0900
Message-ID: <000001db660d$53f08040$fbd180c0$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFs+q24CbmZ+c95YhST3My9s2dfQwJOvGKGAeJ4rK6z0Js4cA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKKsWRmVeSWpSXmKPExsWy7bCmvm7kjNZ0g6PdAhYnn6xhszjyv5/R
	4vjacAdmj8V7XjJ53Lm2h83j8ya5AOaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11D
	SwtzJYW8xNxUWyUXnwBdt8wcoD1KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALT
	Ar3ixNzi0rx0vbzUEitDAwMjU6DChOyMPa+usRZsM6m41zSLpYFxpnYXIyeHhICJRFvfHEYQ
	W0hgB6PE0a8pXYxcQPYnRolD5++wQjjfGCWuvN/CBtNx790PdojEXkaJxz8XQrW/ZJTYNNsJ
	xGYT0JP4v2ghM4gtIuAjcaNvOQuIzSwgIzHzy1pWEJtTwFbi+/5vTCC2sECsxMXNX8EWsAio
	Smzb+husnlfAUuLS4S3sEIsVJH4+XcYKMdNJ4tShM1AzRSRmd7YxgxwkIbCNXeJR8ztmiAYX
	iTXt36CuFpZ4dRxmkJTE53d72SAamhklli45yArh9DBK/Gu4DtVhLLF/6WSg8ziAVmhKrN+l
	D7GNT+Ld1x5WkLCEAK9ER5sQRLWKxKXXL5lg5t998h+qxEPi6c9USGAdYZTo2dHAMoFRfhaS
	u2chLFjAyLSKUSy1oDg3PTXZsMAQHpPJ+bmbGMHpS8t4B+Pl+f/0DjEycTAeYpTgYFYS4V3C
	1pouxJuSWFmVWpQfX1Sak1p8iNEUGJITmaVEk/OBCTSvJN7QxNLAxMzI2MTC0MxQSZz3wraW
	dCGB9MSS1OzU1ILUIpg+Jg5OqQYm1eDN2sE5Em0Pazd5eZ7k3ivu2Ge9zzPHLsT1w9RFGzvU
	D3HpCXOc9/5dIRfx7cM5jmO+2trmEfND1i8sNrPxFzW3qj8k1mK+7fq0Wu1rq8Ud1YN1mrLS
	HsuurXhp0+e4akI/yywl9aPrwlUMVf6t3tX0Tl1IzIbl3pUHy06dZdrUMNNyzksxhjUfza+t
	Xf9KNy0psVTpn7Oh/N6Y5G9TC09FL/s46fiG5jC/g4vmWFx3XP2q3e2SfO/b35ycqRmc2lVP
	P1SyK9u1z73y589ELtk/0wI4L2isNG+4ySPkc/Xlf0413ptHY3we+25W+rhZ5l5lkePsYwes
	3UO9uA/dyJTTuPu2fHJP+MHiv2+VWIozEg21mIuKEwHOCQC/6AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDLMWRmVeSWpSXmKPExsWy7bCSnG7EjNZ0g4cduhYnn6xhszjyv5/R
	4vjacAdmj8V7XjJ53Lm2h83j8ya5AOYoLpuU1JzMstQifbsErow9r66xFmwzqbjXNIulgXGm
	dhcjJ4eEgInEvXc/2LsYuTiEBHYzSjTfWMIEkZCS+Px0KlsXIweQLSxx+HAxRM1zRomVz/6w
	gtSwCehJ/F+0kBnEFhHwk/jw9TeYzSwgIzHzy1pWiIYDjBJnH09iAUlwCthKfN//DWyBsEC0
	xPLF08EaWARUJbZt/Q1WwytgKXHp8BZ2iCMUJH4+XcYKscBJ4tShMywQC0QkZne2MU9gFJiF
	xF3AyLiKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4ALW0djDuWfVB7xAjEwfjIUYJ
	DmYlEd4lbK3pQrwpiZVVqUX58UWlOanFhxilOViUxHm/ve5NERJITyxJzU5NLUgtgskycXBK
	NTC1CaxgFIyWUrY/Wt7AsjUi2PHBEt8Y0ylpG9bG5fu+1pGY8zbLO7Qgc57xd149IwYfmQ1e
	Ab7vpHaITFhtZHXxz4nWG+/1Dl3rKbnuLDEn/5baU6NT7RNNHC5UvwvI5L+65IPQV71jrkc/
	r/peunilQWSvj5J9y9OLsj873wZonc8PXfw68NKmx4yCeh/jGbj1TjaUbDh894iwh4Dzq0re
	/lZGAQEv1UDLdQWdrBU6n316/9huuGdxndM169F3pnob7/Z36ewTJSSaxbh99zQ/XXwgt0RY
	fDO/+u9WJknXBWbye+czTfCQcTbqsfh914lxl1tJ8pLSmRv2d5x/NP1O52uN5kKPl6dF/+gI
	KrEUZyQaajEXFScCAK8SwkGvAgAA
X-CMS-MailID: 20250113224856epcas1p1857691207971ac12ca0474509624735d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241216105129epcas1p4f1ffe80586e9f7d4e4b5f7653dfde883
References: <CGME20241216105129epcas1p4f1ffe80586e9f7d4e4b5f7653dfde883@epcas1p4.samsung.com>
	<20241216105127.2180403-1-jh80.chung@samsung.com>
	<9e244402-7e1a-4799-a159-b940547b4085@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>



> -----Original Message-----
> From: Adrian Hunter <adrian.hunter@intel.com>
> Sent: Wednesday, January 8, 2025 10:52 PM
>
> On 16/12/24 12:51, Jaehoon Chung wrote:
> > dwcmshc_phy_1_8v_init and dwcmshc_phy_3_3v_init differ only by a few
> > lines of code. This allow us to reuse code depending on voltage.
> >
> > Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> > ---
> > Changelog V2:
> > - Add more conditions to clarify if it's MMC_SIGNAL_VOLTAGE_180
> > - Order the local variable according to Adrian's comment
> > - Use local variable to make more readable
> > ---
> >  drivers/mmc/host/sdhci-of-dwcmshc.c | 75 +++++++----------------------
> >  1 file changed, 18 insertions(+), 57 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > index 7ea3da45db32..08a9b963fb1a 100644
> > --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> > +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > @@ -328,12 +328,18 @@ static void dwcmshc_request(struct mmc_host *mmc, struct mmc_request *mrq)
> >  	sdhci_request(mmc, mrq);
> >  }
> >
> > -static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
> > +static void dwcmshc_phy_init(struct sdhci_host *host)
> >  {
> >  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> > +	u32 rxsel = PHY_PAD_RXSEL_3V3;
> >  	u32 val;
> >
> > +	if (priv->flags & FLAG_IO_FIXED_1V8 ||
> > +		(host->mmc->ios.timing & MMC_SIGNAL_VOLTAGE_180 &&
> > +		 host->flags & SDHCI_SIGNALING_180))
>
> Thanks for making the changes.  It looks like
> "&& host->flags & SDHCI_SIGNALING_180" is not needed

Will check after changing your suggestion.

>
> > +		rxsel = PHY_PAD_RXSEL_1V8;
> > +
> >  	/* deassert phy reset & set tx drive strength */
> >  	val = PHY_CNFG_RSTN_DEASSERT;
> >  	val |= FIELD_PREP(PHY_CNFG_PAD_SP_MASK, PHY_CNFG_PAD_SP);
> > @@ -353,7 +359,7 @@ static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
> >  	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
> >
> >  	/* configure phy pads */
> > -	val = PHY_PAD_RXSEL_1V8;
> > +	val = rxsel;
> >  	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
> >  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
> >  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> > @@ -365,65 +371,24 @@ static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
> >  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> >  	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
> >
> > -	val = PHY_PAD_RXSEL_1V8;
> > +	val = rxsel;
> >  	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLDOWN);
> >  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
> >  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> >  	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
> >
> >  	/* enable data strobe mode */
> > -	sdhci_writeb(host, FIELD_PREP(PHY_DLLDL_CNFG_SLV_INPSEL_MASK, PHY_DLLDL_CNFG_SLV_INPSEL),
> > -		     PHY_DLLDL_CNFG_R);
> > -
> > -	/* enable phy dll */
> > -	sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
> > -}
> > -
> > -static void dwcmshc_phy_3_3v_init(struct sdhci_host *host)
> > -{
> > -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > -	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> > -	u32 val;
> > -
> > -	/* deassert phy reset & set tx drive strength */
> > -	val = PHY_CNFG_RSTN_DEASSERT;
> > -	val |= FIELD_PREP(PHY_CNFG_PAD_SP_MASK, PHY_CNFG_PAD_SP);
> > -	val |= FIELD_PREP(PHY_CNFG_PAD_SN_MASK, PHY_CNFG_PAD_SN);
> > -	sdhci_writel(host, val, PHY_CNFG_R);
> > -
> > -	/* disable delay line */
> > -	sdhci_writeb(host, PHY_SDCLKDL_CNFG_UPDATE, PHY_SDCLKDL_CNFG_R);
> > -
> > -	/* set delay line */
> > -	sdhci_writeb(host, priv->delay_line, PHY_SDCLKDL_DC_R);
> > -	sdhci_writeb(host, PHY_DLL_CNFG2_JUMPSTEP, PHY_DLL_CNFG2_R);
> > -
> > -	/* enable delay lane */
> > -	val = sdhci_readb(host, PHY_SDCLKDL_CNFG_R);
> > -	val &= ~(PHY_SDCLKDL_CNFG_UPDATE);
> > -	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
> > +	if (priv->flags & FLAG_IO_FIXED_1V8 ||
> > +		(host->mmc->ios.timing & MMC_SIGNAL_VOLTAGE_180 &&
> > +		 host->flags & SDHCI_SIGNALING_180)) {
>
> Probably neater to check rxsel e.g.
>
> 	if (rxcel == PHY_PAD_RXSEL_1V8) {

Got it. Thanks!

Best Regards,
Jaehoon Chung

>
> > +		u8 sel = FIELD_PREP(PHY_DLLDL_CNFG_SLV_INPSEL_MASK, PHY_DLLDL_CNFG_SLV_INPSEL);
> >
> > -	/* configure phy pads */
> > -	val = PHY_PAD_RXSEL_3V3;
> > -	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
> > -	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
> > -	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> > -	sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
> > -	sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
> > -	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
> > -
> > -	val = FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
> > -	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> > -	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
> > -
> > -	val = PHY_PAD_RXSEL_3V3;
> > -	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLDOWN);
> > -	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
> > -	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> > -	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
> > +		sdhci_writeb(host, sel, PHY_DLLDL_CNFG_R);
> > +	}
> >
> >  	/* enable phy dll */
> >  	sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
> > +
> >  }
> >
> >  static void th1520_sdhci_set_phy(struct sdhci_host *host)
> > @@ -433,11 +398,7 @@ static void th1520_sdhci_set_phy(struct sdhci_host *host)
> >  	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
> >  	u16 emmc_ctrl;
> >
> > -	/* Before power on, set PHY configs */
> > -	if (priv->flags & FLAG_IO_FIXED_1V8)
> > -		dwcmshc_phy_1_8v_init(host);
> > -	else
> > -		dwcmshc_phy_3_3v_init(host);
> > +	dwcmshc_phy_init(host);
> >
> >  	if ((host->mmc->caps2 & emmc_caps) == emmc_caps) {
> >  		emmc_ctrl = sdhci_readw(host, priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
> > @@ -1163,7 +1124,7 @@ static const struct sdhci_ops sdhci_dwcmshc_th1520_ops = {
> >  	.get_max_clock		= dwcmshc_get_max_clock,
> >  	.reset			= th1520_sdhci_reset,
> >  	.adma_write_desc	= dwcmshc_adma_write_desc,
> > -	.voltage_switch		= dwcmshc_phy_1_8v_init,
> > +	.voltage_switch		= dwcmshc_phy_init,
> >  	.platform_execute_tuning = th1520_execute_tuning,
> >  };
> >
>



