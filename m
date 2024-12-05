Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723F22391AE
	for <linux-mmc@vger.kernel.org>; Thu,  5 Dec 2024 23:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733439907; cv=none; b=u80s0/GgIWyYXOLTvtavjTaMU3X1XPsta7mSw2iLHFn6zq4K7Yukx7jag6ljxXHcHxwN5vLpYydVb8/oeRVPvwrIjcA2pOG7pXaoz8N9zS7OeA8dJ/NmIpbPLNCW08fSPVxJtWa6g0lcBf7CXynQJu0180mZpOHE152h3kwxTrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733439907; c=relaxed/simple;
	bh=HBQ8jiNG2bHSURUBmuRM8mBR0QGvrliWIbU6lgcuzZM=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:Content-Type:
	 References; b=dJdasjzdoHoYmUnOyYGJW5RQHEl6hjdeHtcY+SJIqcFIIofOAAHVbhbyDC5tT7GnSvuOfyoi8iJWGN4Je5u8lSZMnejn2dO6JSQDNHHa7zaiZnc2wXkLes1pkG3FE6dxibEb2RgAwI5tzrF9yxAffYFQD50mUWkft7G2MipUP18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=eMuiGWNA; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eMuiGWNA"
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241205230502epoutp02d2f216a222d4c084d860c0a6d0555b13~OamgmK9hr0205602056epoutp02E
	for <linux-mmc@vger.kernel.org>; Thu,  5 Dec 2024 23:05:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241205230502epoutp02d2f216a222d4c084d860c0a6d0555b13~OamgmK9hr0205602056epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733439902;
	bh=xWpfRyQVzrMlZiO6jmo0JWHivdC2kg71gbS23vZUdq8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=eMuiGWNAo3JHxOk1YxetJXMTcwIALCUq9rjgKRGahiJaxWkqeN1gli9bpluN1JBKs
	 8W3CyHFGwq9E7wzSgxLKbOrpxgH/xJEIS9CjOWw2BvFRmA4Unoacm1rFjUGuxdExPM
	 4cJO5Ex0PgZfl4VGNgLbyeq0FtmQZkoTUPq9fyQE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20241205230501epcas1p3234d0d7e2c3fce7676de813d99bbf260~OamgUwy-Z2487624876epcas1p3D;
	Thu,  5 Dec 2024 23:05:01 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.144]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Y492h5j3qz4x9Q1; Thu,  5 Dec
	2024 23:05:00 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
	60.3C.23425.C9132576; Fri,  6 Dec 2024 08:05:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241205230500epcas1p19eb7f1db8ce7282ef8913b66fbdbc7b7~OamfA-h2G1538015380epcas1p1E;
	Thu,  5 Dec 2024 23:05:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241205230500epsmtrp268c7959e6a5ec4ffb5728442598d431e~Oame9uOTy2904529045epsmtrp2T;
	Thu,  5 Dec 2024 23:05:00 +0000 (GMT)
X-AuditID: b6c32a39-967e870000005b81-57-6752319c96ab
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	04.EB.18729.C9132576; Fri,  6 Dec 2024 08:05:00 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241205230500epsmtip2a5f0380dcee6ee6efe5797d6faab8d14~Oame1Muwv1068410684epsmtip2K;
	Thu,  5 Dec 2024 23:05:00 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Adrian Hunter'" <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>
Cc: <ulf.hansson@linaro.org>
In-Reply-To: <36d8b897-e8d0-4262-b60b-a5510e93c6ff@intel.com>
Subject: RE: [PATCH] mmc: sdhci-of_dwcmshc: Change to dwcmshc_phy_init for
 reusing codes
Date: Fri, 6 Dec 2024 08:05:00 +0900
Message-ID: <052501db476a$1c1d0150$545703f0$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKKokFll6i+VyC82vRnqomB67d7lgMmjEaJArFrSVaxSreXgA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGKsWRmVeSWpSXmKPExsWy7bCmvu4cw6B0g8Mr9CxOPlnDZnHkfz+j
	xfG14Q7MHov3vGTyuHNtD5vH501yAcxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqG
	lhbmSgp5ibmptkouPgG6bpk5QHuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWm
	BXrFibnFpXnpenmpJVaGBgZGpkCFCdkZ33bvZyl4bVkxZ+F6xgbGd/pdjJwcEgImEgcf3GPr
	YuTiEBLYwSgxe+kUJgjnE6NEx/RDrBDON0aJZT39jF2MHGAtLc3REPG9jBKf/yyCan/JKNH/
	6zU7yFw2AT2J/4sWMoPYIgI+Ejf6lrOA2MwCMhIzv6xlBbE5BWwlOjoawGqEBaIk2h7NBVvA
	IqAicXeTBEiYV8BSYvH3o0wQpypI/Hy6jBVipJPE9J7PUCNFJGZ3tjGD3CAhsItdYv2xS6wQ
	DS4SD6Y2sEPYwhKvjm+BsqUkPr/bywbR0MwosXTJQVYIp4dR4l/DdTaIKmOJ/UsnM4FcxCyg
	KbF+lz7ENj6Jd197WCEhwSvR0SYEUa0icen1SyaY+Xef/Ie6wUOiefVadkgAHWaUeN19lGkC
	o/wsJIfPQtiwgJFpFaNYakFxbnpqsWGBKTwqk/NzNzGCE5iW5Q7G6W8/6B1iZOJgPMQowcGs
	JMJbGRaYLsSbklhZlVqUH19UmpNafIjRFBiSE5mlRJPzgSk0ryTe0MTSwMTMyNjEwtDMUEmc
	98yVslQhgfTEktTs1NSC1CKYPiYOTqkGpgOTGIOy2x6eXDT1z+WPz5+6XGKrzGYxEmqo8S3g
	nl1+VO/hPt83LuyOU+9s0Lpu94u7d+Jq1nN/f3ScXOvhxS/jvFhJfgWDQZvyGtv0qF9ftFxe
	hIYpt1X9kb2sbBbGs97rypb/U67qFerkzppabMVhZp5acTfO9JvFOZdDtpu9+Ban+1dzrI2Z
	vcd4277AShHvfZMPnnx4u9D7W5N9bUP1MeX9c/YoCEuLMZrp7SsRX3bqtfaf+pDWvv6oHdN9
	rth929LJt+qnZd6h8iy1Y1f/6R6K2qZ9abNj7Ks0zbi4+D6DFz5Kc9i679QvlPTIMwm90HH8
	/KbF14yN7isLyRcnLJcKfGiswtS3KyddiaU4I9FQi7moOBEAO8lmjukDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFLMWRmVeSWpSXmKPExsWy7bCSvO4cw6B0g87DIhYnn6xhszjyv5/R
	4vjacAdmj8V7XjJ53Lm2h83j8ya5AOYoLpuU1JzMstQifbsEroxvu/ezFLy2rJizcD1jA+M7
	/S5GDg4JAROJluboLkYuDiGB3YwSj95sYexi5ASKS0l8fjqVDaJGWOLw4WKImueMEh8/f2QH
	qWET0JP4v2ghM4gtIuAn8eHrbzCbWUBGYuaXtawQDfsZJX7fOccCkuAUsJXo6GgAKxIWiJDo
	2N7AArKARUBF4u4mCZAwr4ClxOLvR5kgblCQ+Pl0GSvEfCeJ6T2fWSDmi0jM7mxjnsAoMAuJ
	u4CRcRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnDwaWnuYNy+6oPeIUYmDsZDjBIc
	zEoivJVhgelCvCmJlVWpRfnxRaU5qcWHGKU5WJTEecVf9KYICaQnlqRmp6YWpBbBZJk4OKUa
	mPo2nRUvMzlnruPQ4WOgoBx3n1v2Ad/rYnHFmbM3Lp7y5AXHeZ0t65T6q3wvfGHxbjDdOC3z
	xnu5TO93az8tti3+4BZ6onxq9iwBTYP1q+qr0z/dqpt/1bTTWGvqo83cPgzv0niXMehfK2jL
	u7Uyumtfyl/pvL1fa7/OiK3JlLMWuRX18cK5CXfsZdZk6mxeeE1Zc/X15k8LVA+vj2mb52i2
	fMXU/8VXJ/7IDj+4PKxhgi9TovzuAo2X55f6H4mzvuE888ntlbbsMhdM+1o1TpvyhkfvEV48
	ddZBtlluafYZD2f6L79vOU9k4fZurRlCiz+UnPUTybokt2tqcNmXRze231lx/8YSbjtGGVux
	y8VKLMUZiYZazEXFiQBp5jlyrQIAAA==
X-CMS-MailID: 20241205230500epcas1p19eb7f1db8ce7282ef8913b66fbdbc7b7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241204100508epcas1p2cc54ed287df5a361536b68971bca48f6
References: <CGME20241204100508epcas1p2cc54ed287df5a361536b68971bca48f6@epcas1p2.samsung.com>
	<20241204100507.330025-1-jh80.chung@samsung.com>
	<36d8b897-e8d0-4262-b60b-a5510e93c6ff@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>



> -----Original Message-----
> From: Adrian Hunter <adrian.hunter@intel.com>
> Sent: Thursday, December 5, 2024 10:17 PM
>
> On 4/12/24 12:05, Jaehoon Chung wrote:
> > dwcmshc_phy_1_8v_init and dwcmshc_phy_3_3v_init differ only by a few
> > lines of code. This allow us to reuse code depending on voltage.
> >
> > Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> > ---
> >  drivers/mmc/host/sdhci-of-dwcmshc.c | 69 +++++------------------------
> >  1 file changed, 12 insertions(+), 57 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > index 7ea3da45db32..87bc32d13cc0 100644
> > --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> > +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > @@ -328,11 +328,15 @@ static void dwcmshc_request(struct mmc_host *mmc, struct mmc_request *mrq)
> >  	sdhci_request(mmc, mrq);
> >  }
> >
> > -static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
> > +static void dwcmshc_phy_init(struct sdhci_host *host)
> >  {
> >  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> >  	u32 val;
> > +	u32 rxsel = PHY_PAD_RXSEL_3V3;
>
> Nicer to order local variables by descending line length when
> possible i.e.
>
> 	u32 rxsel = PHY_PAD_RXSEL_3V3;
> 	u32 val;
>
> > +
> > +	if (host->flags & SDHCI_SIGNALING_180 || priv->flags & FLAG_IO_FIXED_1V8)
>
> 'host->flags & SDHCI_SIGNALING_180' only means 1.8V signaling
> is supported, so this looks strange. Can you clarify this?

AFAIK, SDHCI_SIGNALING_180 is to check if its IP(Host controller) supports 1.8V as you mentioned.
The previous function (dwcmshc_phy_1_8v_init) is called in sdhci.c. through host->ops->voltage_switch().
I couldn't find any other place where its function is called.

When ios->signal_voltage is set to MMC_SIGNAL_VOLTAGE_180, dwcmshc_pyh_1_8v_init is called.

In the switch statement, if '(!(host->flags & SDHCI_SIGNALING_180))' evaluates to true, it returns -EINVAL.

So I think that there are only two possible scenarios involving "SDHCI_SIGNALING_180 or FLAG_IO_FIXED_1V8".

To clarify this, I will change to if (!!(host->flags & SDHCI_SIGNALING_180) || priv->flags & FLAG_IO_FIXED_1V8).

And if my understanding is something wrong, let me know, plz.

Additionally, I have tested on LicheePi4A.

>
> > +		rxsel = PHY_PAD_RXSEL_1V8;
> >
> >  	/* deassert phy reset & set tx drive strength */
> >  	val = PHY_CNFG_RSTN_DEASSERT;
> > @@ -353,7 +357,7 @@ static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
> >  	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
> >
> >  	/* configure phy pads */
> > -	val = PHY_PAD_RXSEL_1V8;
> > +	val = rxsel;
> >  	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
> >  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
> >  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> > @@ -365,65 +369,20 @@ static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
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
> > +	if (host->flags & SDHCI_SIGNALING_180 || priv->flags & FLAG_IO_FIXED_1V8)
> > +		sdhci_writeb(host, FIELD_PREP(PHY_DLLDL_CNFG_SLV_INPSEL_MASK,
> > +					PHY_DLLDL_CNFG_SLV_INPSEL), PHY_DLLDL_CNFG_R);
>
> Perhaps slightly more readable to use a variable e.g.

Okay. I will update. It was kept the previous code.

Best Regards,
Jaehoon Chung

>
> 	/* enable data strobe mode */
> 	if (???) {
> 		u8 sel = FIELD_PREP(PHY_DLLDL_CNFG_SLV_INPSEL_MASK, PHY_DLLDL_CNFG_SLV_INPSEL);
>
> 		sdhci_writeb(host, sel, PHY_DLLDL_CNFG_R);
> 	}
>
> >
> >  	/* enable phy dll */
> >  	sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
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
> > -
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
> >
> > -	/* enable phy dll */
> > -	sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
> >  }
> >
> >  static void th1520_sdhci_set_phy(struct sdhci_host *host)
> > @@ -433,11 +392,7 @@ static void th1520_sdhci_set_phy(struct sdhci_host *host)
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
> > @@ -1163,7 +1118,7 @@ static const struct sdhci_ops sdhci_dwcmshc_th1520_ops = {
> >  	.get_max_clock		= dwcmshc_get_max_clock,
> >  	.reset			= th1520_sdhci_reset,
> >  	.adma_write_desc	= dwcmshc_adma_write_desc,
> > -	.voltage_switch		= dwcmshc_phy_1_8v_init,
> > +	.voltage_switch		= dwcmshc_phy_init,
> >  	.platform_execute_tuning = th1520_execute_tuning,
> >  };
> >



