Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF183D6CB3
	for <linux-mmc@vger.kernel.org>; Fri,  3 Apr 2026 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775246410; cv=none; b=HIiD2EQUY73hbC2ENna0RoYJFOqqY4gyoRre6+YdkrSOoEzmB23U5xFzrA1nB3iwayKafCABjZsCyUI1B3qxEWHYnja0i0WucyQomlTcR/5cKqT4A6ZPFojLeRXI2yMmNpIyewTKIU3NMwRX1LK1MctI+FpnnE+poVwf8e/AWHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775246410; c=relaxed/simple;
	bh=sG+5QOeVSCKezV0m3ouTyeQAdPMO5wGz9Q21s1LFass=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFh8vqx8QnoGW/f2+/0ZTi7xl85kP5DkuWb3i/0vr636h8VQ/mxxmUjyjyq5YsjHDWXQc/yrdqF+zd+xmbJQC0Pyu/IoviqRxAgLcw4pUSC/nDaqBeG8IcFIx7G6ZviR8xDYGt5hTQ6d6/xTsO4fB7hdlxcVhm2ikFyEjab4SFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f5sgsR+3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QkMn6QvZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f5sgsR+3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QkMn6QvZ"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633B1d4f1453172
	for <linux-mmc@vger.kernel.org>; Fri, 3 Apr 2026 20:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=h3e1HySFPcFsy/9IzoZDxyD9
	SAP0usqz7ly0+vlzsYc=; b=f5sgsR+3xe47ELotQ3DKbnaqVnbz6kBEnl68T/DI
	22okcOBQOxoqGxIOu4rQNmOlWzIAC2b9piqQsQImufoHzs1VvWgOXh3axRVnJR0H
	QOW+NEcwypOceEZ0gbt3PReQIfbsaGgGPTxHDoh7CeSnNMjPM8kBRALgoj0bYUM2
	N65HhyVjb0h63eEBQqLD6rlKg/hlpC6vZ8QQRLgNDhh6c0/+awbQwFPqBU509AJ3
	aMNaAGgkZi+Zvq3pLi25isrq8KS0EWryueXMj/76z5y+mo1Ntj6VxePC0BKa0+Li
	Kz3HD++BiSf5cbE2Ao1SACW/pr7blC/r9s6S0BddfJ2i4Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dacam9ens-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 03 Apr 2026 20:00:05 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50b6f869676so51124111cf.2
        for <linux-mmc@vger.kernel.org>; Fri, 03 Apr 2026 13:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775246405; x=1775851205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h3e1HySFPcFsy/9IzoZDxyD9SAP0usqz7ly0+vlzsYc=;
        b=QkMn6QvZ+wycR9V4uNKCYTIHCKjxmD5bny8pUqw3G8Fyrx6vBcFAsMIcjtrEucjO+/
         vYr4Wad9Xk/3bwn5GwHnVh/CISkd6+tU2+CkvDPKEWqAknhYq4hU0P5i3ZRf3lLHizXj
         aZwLsdoICWNNbkFTSgCnSwxZ8BnNHp8vRAzyuN3aZ3NLmpQeNiY9fzKoENmB/VE7WVW5
         8EDhuv5JxF6vl/0OR2CukY9+n6kEN7coxlZHBA68zgwlC51mJfFU32QKssz4RxewxaHz
         +U1tfW9097TEbeL7kuJEsxaNSRIP+EuEiiHxUKyiUkJeH3UdXEBx6phYAxCXmt7QQ3e9
         dRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775246405; x=1775851205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3e1HySFPcFsy/9IzoZDxyD9SAP0usqz7ly0+vlzsYc=;
        b=K04BNGZsQNKhkGW7NX/1mqV3HuUqdGU3K3TR8M952wsPMFeaAhM8xbqgCG1p1hQZ23
         uK5hyBg2Bb01kEpjsBAtIanJUycXhJJ8sJWyGOBIdl16TvIoNasRuqsYXM+IoEER9LQk
         oPWWMzHG8UTqBPSyF06dxiSgvK08pr+u9zixPxv7raexEwPM+2BjXpPPY4rYBxiZlM6F
         MLB+PGmBbjsppLb1gkGH/LWvbFm9Lo1hGh7CWCJyZJ4RxlLyvTULjfkiG2G7VBr3APmR
         bCHyq4hXGsIWJ5cnJpu7+A4ygU17NYWtLEXiDjUJDDarUopntlzdFNe+7qrEx05YEbRb
         AjRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZdpyEX94sQhOCxJGZat2ulXGNR6/4g5qrJr6+fd30CBkrDrcKLayVOq4jjxphafXYTzFIkimcfWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy911Z0dUUZbWnHNFrqXY0iFQ7NU/LwEfOE2p9vFQ+QG/CwDqBW
	EwO426FalDUE1b8FL3MQcxZxAyZaoPaTGFRkLTpd3H+yO7cbvs1sZmoRkk8pW4or5vhLle+LdB+
	MwN9m2CjKt8UuA9/z+N55zOC5VfKIBbpOvbsomcmyXLmZO77wYXBcE3/l95VhQIk=
X-Gm-Gg: ATEYQzxitpB8MgbwCOOkc+3KGhTf7Fcu4bzAd7w8c+Q0ffEplx6TPUPJc0geEuL/8Uj
	1IoEuKMYfxso36YBKD3IXX7uU73aE4hKK/nl9LX7np4kVcq0eDKzEP54bozukDdmbr3H9c3Wa7N
	FsbnWRFxQkpPebIH28BPz0FNETkw2z24rI4us3ghXB+mzT1LcfEEOZ8tpYKEAQTkwVXmv9qjsjE
	zrdRuTAaCYDRCcr/mxsmceCE25m0d2Rvp4Mjl2tt3ZCBz38xKpljg6xPj65RD0aXc0+etB8sBOZ
	e0yxjGYkyj7q152Rf1oz+b1aWz5kL8ZKcHTa0h3Lu0aKa22yDuRC0joTWOeYyBbC1DDr2gwTKzi
	7YRteToWTZ0+iIeiqVZ7ZQdnGK6hyKEFjSZGeI5FAhQXE9BimhDv/hpmRZyBnzJd50R++ztrFdS
	ZySPBV4eQTPxQQZ8AjXGZIpFs7a52GE+J1sxY=
X-Received: by 2002:a05:622a:5810:b0:50b:4b2f:1606 with SMTP id d75a77b69052e-50d62750dbbmr67576591cf.15.1775246405289;
        Fri, 03 Apr 2026 13:00:05 -0700 (PDT)
X-Received: by 2002:a05:622a:5810:b0:50b:4b2f:1606 with SMTP id d75a77b69052e-50d62750dbbmr67576161cf.15.1775246404812;
        Fri, 03 Apr 2026 13:00:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6c951a6sm1627294e87.10.2026.04.03.13.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 13:00:03 -0700 (PDT)
Date: Fri, 3 Apr 2026 23:00:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: adrian.hunter@intel.com, ebiggers@kernel.org, abel.vesa@linaro.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: host: sdhci-msm: Fix the wrapped key handling
Message-ID: <x2mmttyg5t5qjo2tyrwqbynqylqqlulu7fhoyxl7vd54geubqx@qna6vzzr765y>
References: <20260403105949.1007447-1-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403105949.1007447-1-neeraj.soni@oss.qualcomm.com>
X-Proofpoint-GUID: OyLsdQmkbhDY0eBX6loTZoMBIpJUJN9c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE3NyBTYWx0ZWRfXzwG5jiqBrxRf
 qKi1b398zJbd2O8sy+Xj0dFzERseLVc4EYPhJmAKIhNKcHYM+GvrNV1Mmuxjgf0MQUcAYZWvgKi
 WFgv+kCwloX6qmfP7pqb3G1RmdkolG1vVmxdVBJ9tgcRcWq3S4/GbpQeRp6+i/V6Z4OEv1JtzBb
 BTcM4s0XyiUVfysdg1CLKTZnKYSWpTuw/xgWdTyn/gUqEUnu5Cc1BRUxy0LtndWwlRt1q6oNl0N
 Gu1kTRf7YoCfaKF3RXijJwhiLyZhbEUtmC2X9KmzysfKCJACvMUi4jHCqrQFLi1XW4IqonZ9uDx
 MRZw44dPeXcyIBVWjgNb4g3gzsLHGTOgCjiK+yj5kSEIrL0Ir4D6xJ9iD3meodObXZuuOds9lr7
 hzfQgRrIIg30GNKB258+X5FrhE3D73vwDpISOEvRMDr/T6p5pymF6UwOQD47UGiu9bAaiFT8hmH
 Whr+bzZi8LmS7QzEJ6g==
X-Proofpoint-ORIG-GUID: OyLsdQmkbhDY0eBX6loTZoMBIpJUJN9c
X-Authority-Analysis: v=2.4 cv=ULXQ3Sfy c=1 sm=1 tr=0 ts=69d01c45 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=PJDidmACEVZXn-zVn4kA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_06,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030177

On Fri, Apr 03, 2026 at 04:29:49PM +0530, Neeraj Soni wrote:
> This change was originally intended to land with the patch series:
> "mmc: host: sdhci-msm: Add support for wrapped keys". The fix was present
> till v4 but was accidentally dropped in v5 while rebasing.

Don't describe what is being changed or what was intended. Please
describe, why you are performing the change. I.e. what is broken.

Also, likely you missed the Fixes tag.

> 
> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> 
> ---
> The patch serirs "mmc: host: sdhci-msm: Add support for wrapped keys"
> was originally discussed here: https://lore.kernel.org/all/CAPDyKFqRG1_1aYavfrA0Ss85B0kcTnjVBeqLgq8PUJUcSx5LUg@mail.gmail.com/
> ---
>  drivers/mmc/host/sdhci-msm.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index da356627d9de..df0a038269d4 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1926,11 +1926,6 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>  	if (IS_ERR_OR_NULL(ice))
>  		return PTR_ERR_OR_ZERO(ice);
>  
> -	if (qcom_ice_get_supported_key_type(ice) != BLK_CRYPTO_KEY_TYPE_RAW) {
> -		dev_warn(dev, "Wrapped keys not supported. Disabling inline encryption support.\n");
> -		return 0;
> -	}
> -
>  	msm_host->ice = ice;
>  
>  	/* Initialize the blk_crypto_profile */
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
