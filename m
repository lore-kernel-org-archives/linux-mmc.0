Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC36852CCE5
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688874; cv=pass; b=rURJ3GGSHPEF/tGVFtFejv/5+z12mDAPkncnqwMMtvOm13CnbHpnIfqtBZY3gKoa5E0D49hnbWGGtj6BsYKPxA5/UYVuVLEAcmCAgmnxV6LMjOK16Wh038vWYdqSgT0X+BMmxj8A7dDOLZun0dCtMGskiIewWhUxZ5wqp477wYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688874; c=relaxed/simple;
	bh=Dq+JjZndauK+vhVyUCj0a7b3BEr7XKM3Pdyht8lKtAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRgnxdF84cvaeifHjl7dy8BWtjvx2J6m0QWdlte5XGHrhTsqmNlyh6wv0i3UbLJ8XZ2lCcx6qIoFNfoxfUlYe0aT4Yoxg5nNXSl6KGyoGsJBac3lhgDNsdJGH4PEd4b93yTGqRKVygIZ95FKr0Afd51y04J82E9SUCs2RVuwdho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NVAQWXKu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ffo052H+; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NVAQWXKu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ffo052H+"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TCqges858071
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 13:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z6wo6dq2auYma40qLsQxQ9lWAE5Nz9b936lWajd77mc=; b=NVAQWXKuWSV3fZEs
	3znWvx2M8K6IobiSvlaWsQaYZ512bUGrwQR2En582K4WHvNJEveCGy+kWwkDBpvT
	GdKDFYVdwm+bV5tEH2QFO/JfXjHw6FtYmP+e29UARIAc599CkofJ/3SuU4uSQ1Np
	4R+euLdhR18gStIGyFBeu4WjCTojMSFXAw/WgFXaAPWZe06aYuFppQeI8NV4RNlD
	38JtqDGRnDk/nyZsm4HHjKo06g/CgmhvZsCdshmjq21Z2baDIRSCJe0qsJBMQ8Ic
	BIjeRBaq8red2PhnVPTdqpb5EehyUvm9ihnlk6hweI41oJkGbAxcIfFvn/Wc1P11
	2s2o0g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h08e0hnt9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 13:34:31 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-882d8c4239bso1849815b3a.2
        for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2026 06:34:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790688871; cv=none;
        d=google.com; s=arc-20260327;
        b=qRARTCit7det69/zQH40fZ4awS+v8UTqdaKkEefyHdpJqgsMS/li2YEvd/Y2ZG/UQW
         54J4gGqzjJHXZNfe3jTCZxmy+xGGP+BcSIQDOOKrgAyCiqZZPV/qrcsz/IsheaL2NMqE
         /9BX4gwKRqCBGncBvvW4saIbli+s8FIDUSQjCO8v63jg/GKM0exWsL4KzTRqeh8eomTE
         5bP5/H4s6048E9OK6pDqTQyrmzwsEzsS5uX56hzk4iBOIM3CMXJOI8V4Tw0+4lye4GPY
         ES7YoQC2U2IOGIXztG7Nm+5FhZfpkMd6oA6RU8FWMKys/MuWUgDJDaqE75Q7cJaY3+Fi
         ZXkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z6wo6dq2auYma40qLsQxQ9lWAE5Nz9b936lWajd77mc=;
        fh=VqsGVLvbCkGW0TKWlYCu9jQAhOsZjMsJt2OZo4bI3lY=;
        b=bX31QGJWrfZCycXAEFhIUC/UTv08WQGcgY62J2abeR6PONoRtj6ZjRDnrdSc6WTlb8
         tAPw42HecTDfwHdVyJq4/B2l9Js5/A7sUS8KzocPAbVVyDRokVvDPTy0KSwD1KdhsL2b
         8eqd/NE9FCMuVRDs8mUchkU5YYBevItP3vtjcW4gdHxq8JmHojGnW/kaZ8v9RR1S0fwJ
         7DbaeguTkK3a/zNAlpldHWN6cG0qeivRN5LV16Za1pq+NtM7LtOseOCvDYdJVc1xNe1v
         BsOKsFsZtF14W9+SrwbMfk86zzta/n1mFwNazK4G7DduMAcU6IpHJHHH9i24tiUY5/jf
         nWSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790688871; x=1791293671; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z6wo6dq2auYma40qLsQxQ9lWAE5Nz9b936lWajd77mc=;
        b=ffo052H+FKSczEMT+V8sedwvEIveWR4PUBgZkQgmWBDlFBZEQFNyEktkppwP67g5KS
         F4oy/25spRX+n6jmuuUR3nMybVO9YnoSa76ykdcxeKQJAjn/svHtdF/nsP3QonhGHdWm
         i72foBOTe5LAILZ9OwgJCj8iMoET2GtfkXv2aOXjFbQXv2cmdLW8Ae5mPcuBxUml9BFf
         ceLe1E4s/mNMz6OBrrwxK1YuhHtguBkXyn1pVOspNK7/d9y8ElMW+StZ6tpTkTCblFba
         pORaKvf2GwP56jnxdfx4ReLe6UIYOt7OFvNKzLo19m/ogtDBWuoJaa9wt1yDSIJlqzut
         6bdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790688871; x=1791293671;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z6wo6dq2auYma40qLsQxQ9lWAE5Nz9b936lWajd77mc=;
        b=1REb3p145v8gvJPXLOWWFCxXqVx+2L83xxTxOOc4XQUBs4wnLh1ZOqUx4NXZm90zaa
         WTSMOKn9iOr9b6mY8MAEnFERUL0W9NCVStEnctirDeS6G1+Jl3ClzVHQUOzJBWM6hz/H
         0towmh3qDe+Fpg6Lw3wSDa0VVyCei6iMOfixIwFTcwgJBU00BVrhwF8lyepwX+yn2TDc
         5C7bK+mSAMYiKM+RDYTOLbEPpeFgmP8fAefaOnLSzzKHbj1ckoWxiUinUU56W/Pj1Jeu
         c/DMB3jpYjWkbO1f8y1yTi/dBNAiDl/D9U21p7YQkJxMMtsbNQEpPkM3pZJ1g6106LgQ
         1F/w==
X-Forwarded-Encrypted: i=1; AKwUvBzsHZGj2xn4LbRgjU0/EtdR6/fwDXgGezTxxb7IyljvAKF5IcAJhKzz1zRv4m36n/JmbADvCkIU10A=@vger.kernel.org
X-Gm-Message-State: AFuF++lecQTbQiv+edBu3N0Q5RXyq+MeqgPn2xHNvGaFhyYWN4l0LGqD
	2hec/nJCc0Yw4jYGJ3LwAXtddP2lcFa1Pc6uHBBaVUujlXx+FTBWumCi4bp6pcfdOL4fYo+mXVY
	cYtheR2bflXxfN1NeNJI26sQDjtoFEmi4v3y36PRLyQSdUHSSb5+zNYIDM5EE4/8/iocUmHy1bt
	Hyw8mVrf1RDXlRt9/Ln71XKp2TFZgMxP14JGUfLA==
X-Gm-Gg: AYBFou1VXwQqDDJtdK9316eQF3t7Y03/lrng49lFYCWDvQB62Gm/ELqWGOJee387IX4
	YI7DGIH+SgvfQCprmoDsSMOuTfylTCCbBWPQhl7sJzrrk/2w8g6q2PcGh3MrTocFFe1Aye912iX
	9vpRitxMl170byLW4Vejq9AbzjTYdIMtBxECtvd8nPtq4aHO/AojXFnAhwKQ==
X-Received: by 2002:a05:6a00:4004:b0:882:4e65:4ddb with SMTP id d2e1a72fcca58-8824e65524fmr6521610b3a.23.1790688870575;
        Tue, 29 Sep 2026 06:34:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:4004:b0:882:4e65:4ddb with SMTP id
 d2e1a72fcca58-8824e65524fmr6521588b3a.23.1790688870075; Tue, 29 Sep 2026
 06:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1790070007-11769-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1790070007-11769-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 15:34:18 +0200
X-Gm-Features: AclHuK8G5nGoHGTpzw0zhB2zp1tTVD0jeruGQoLq-x6OFpzxeQoeqBWHKQUtrtQ
Message-ID: <CAPx+jO-Yne-pT4CAMR6G0miUTsptKGSfB6Mq=3Mu3-viaJA+0g@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Disable CQE error halt request for Rockchip
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1NCBTYWx0ZWRfXwEVt502sZyeP
 8YOQKj9nsCA6r1v85GXaUGvhZ1oOl63HDiPfcMAOXwJDiGoTVXInuGnwigPo6+DktwW2eT31UWO
 KF18OlFIWbMrMq9qdWyevMeX6fJPUFM=
X-Proofpoint-ORIG-GUID: _Of7BkBnQpGyQb7yeJAqkP9NOmp313Jv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1NCBTYWx0ZWRfX1qc3QZdly2RP
 Bt0ovQ+cswi0qfy272F6EDw9XNVgO98OHUfvpUxhDBn7HgSB0xhqBlo9Z2FcSMUd91GcMKwbuxB
 4BiRcBGApQ/FWltLXHPwknwrmI/g6SgH2mWIZjGwdHS2PEH1y9KSxNac3cPlBrAFvIc9oOIutse
 9cLLRzxYjSDLzgXJ54Wxx9GBeDB6bYcwKSXlbBj0IoKzZtySrQHZQO2mDVPmg/D56ZXN+bduQ8I
 htTPJi0VqZNMCLfKxrQqixR+y/Lq3lpVNaos6mykuBz/SKisBrtXsPzj3mJaw/ZhmYiiJEJ1Flk
 c+63C/HLd+2hF+xaqjJhMn6S8fV+c2tkRb/fgNC/8yC2R/IoRtyj0N36AGV+Z9DekXQvk9cpf8q
 5v/W0tfZHrKWA2EgGwIXDPm/eHoNP8F6WxyAymVcoHuVySmdc4UGfXVDqfGIm7ziAuytKK+U69k
 l3wQv26pBQm1WFXsxkQ==
X-Authority-Analysis: v=2.4 cv=WJ7qzXsR c=1 sm=1 tr=0 ts=6abbbe67 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=NEAV23lmAAAA:8 a=s8YR1HE3AAAA:8
 a=r684gp1BP3o6S36M1wEA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-GUID: _Of7BkBnQpGyQb7yeJAqkP9NOmp313Jv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290054

On Tue, Sep 22, 2026 at 11:40=E2=80=AFAM Shawn Lin <shawn.lin@rock-chips.co=
m> wrote:
>
> In CMDQ mode an I/O error in one task (data_crc_err, data_end_bit_err,
> etc.) makes the controller raise a halt request. While the halt request
> is pending, the controller rejects doorbell writes with a slave response
> error, which hangs the CPU (or raises SError on ARM) on Rockchip
> platforms.
>
> A software workaround[1] clears CQHCI_CTL right before ringing the
> doorbell to narrow down the window, but a race remains: an I/O error can
> still happen in another slot between the CQHCI_CTL write and the
> doorbell kick, so the hang is not fully solved.
>
> To fix this once and for all, newer silicon introduces
> SW_ERR_HALR_REQ_DISABLE (CQHCI_CTL[1]) which stops the controller from
> raising a halt request on I/O errors. Set the bit when the CQE is
> enabled, which is the last CQHCI_CTL write before any doorbell write.
>
> Older SoCs keep this bit reserved, so writing it is a no-op and nothing
> changes in the wild, thus no fixes tag is needed.
>
> [1] https://github.com/rockchip-linux/kernel/commit/4b7ea0500a1a5c186807b=
737fecfc6bb4d4e06f8
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
>
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci=
-of-dwcmshc.c
> index 1baa237..0970202 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -239,6 +239,8 @@
>                                          SDHCI_TRNS_BLK_CNT_EN | \
>                                          SDHCI_TRNS_DMA)
>
> +#define CQHCI_SW_ERR_HALT_REQ_DISABLE  BIT(1)
> +
>  #define to_pltfm_data(priv, name) \
>         container_of((priv)->dwcmshc_pdata, struct name##_pltfm_data, dwc=
mshc_pdata)
>
> @@ -702,6 +704,8 @@ static void rk35xx_sdhci_cqe_pre_enable(struct mmc_ho=
st *mmc)
>  static void rk35xx_sdhci_cqe_enable(struct mmc_host *mmc)
>  {
>         struct sdhci_host *host =3D mmc_priv(mmc);
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct dwcmshc_priv *dwc_priv =3D sdhci_pltfm_priv(pltfm_host);
>         u32 reg;
>
>         reg =3D sdhci_readl(host, SDHCI_PRESENT_STATE);
> @@ -712,6 +716,15 @@ static void rk35xx_sdhci_cqe_enable(struct mmc_host =
*mmc)
>
>         sdhci_writew(host, DWCMSHC_SDHCI_CQE_TRNS_MODE, SDHCI_TRANSFER_MO=
DE);
>
> +       /*
> +        * Disable the halt request raised on an I/O error, otherwise a
> +        * doorbell write gets a slave response error while the halt requ=
est
> +        * is pending and hangs the CPU. This bit is reserved on older So=
Cs,
> +        * so the write is a no-op there.
> +        */
> +       sdhci_writel(host, CQHCI_SW_ERR_HALT_REQ_DISABLE,
> +                    dwc_priv->vendor_specific_area2 + CQHCI_CTL);
> +
>         sdhci_cqe_enable(mmc);
>  }
>
> --
> 2.7.4
>
