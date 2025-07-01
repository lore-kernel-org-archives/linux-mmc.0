Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBD7226CFF
	for <linux-mmc@vger.kernel.org>; Tue,  1 Jul 2025 10:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751365669; cv=none; b=Fbf/18FOMDdpUbx5MUHaSAbwUqFF7RQRrE3LgjZq2pTbtPUSf1k7gSi+gt+YISJgwJWFlweWOYlMo/0A/oZ0ETdXDMiKYpQwdFNlmrhJ8Uv3fjxnD2uvDL/RRX40A0N1EJPkB/KwVQmEWo+Tn7ofVt3z2jSy7gNKYfywUjd9uu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751365669; c=relaxed/simple;
	bh=mSqqIKR39IZUVf0Dath6YHPY0fqv6iQc87YDsgoCUOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8ZpiJj0PVwyWf7eBHwd7paAfpaT14FQ7DFJP2XJVwlnmWVYWVecDptIlC39wVKuNqM7OKqFEgcHSDIhTvC2O5cE+KaA6FJzZj3Qu1KcFKGACFK8qShX2Dd/T79Z6rf3xxqKgD+HK//Xz+F8rmhepYF3nQWmG9suROj5AjCb6VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CYeUU3Tx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CYeUU3Tx"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561AAn4u024904
	for <linux-mmc@vger.kernel.org>; Tue, 1 Jul 2025 10:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YeUJ3xa7GjwoafFi/aMcA7ba
	8m0/8IBjRzKVhVgXe98=; b=CYeUU3TxznOMb9/j0k9Pkdw/pgbShnRQ4gs8hKbZ
	XrYdN1fa0rgulwvBuV4raTQQW7HwY2OTNCkeCP39I1tPHh5pIDdKDHq4veXcSPlI
	JDbdxG+Jt52bGM24fOhRr7SYruB7u3Q5y7lk4oqbYoMMWzFzf4j+6N1KSzZiSeC/
	grmifaD44y4i4pSiocNeijgNuv8blxuUo0/RH6DTjQIv2NfGT0CslagzK16AQyap
	RE3QqGT6HsI1DW2eU/jiQ1e9YLj/HNfLFl1jglrH+pTBAdre/etc8OLTulz8ohAa
	+00kWjDfosUVk7d2kBfMU3DpV1xF/CfF4T4RzbnmOBxsqw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8020b3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 01 Jul 2025 10:27:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d4576e83cdso620030185a.1
        for <linux-mmc@vger.kernel.org>; Tue, 01 Jul 2025 03:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751365666; x=1751970466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeUJ3xa7GjwoafFi/aMcA7ba8m0/8IBjRzKVhVgXe98=;
        b=xMUTXzRs1FfGk7rEsWvWQj/JkwvZQ4zRrKuh4D5q2g0Q2XJO0fS4l70vG+IdUeEkyq
         LFkhoM4aRL513FkoEo00hTXAUEU2pbJPsxXThTjxrk97Q1eTtTQJPopeTF5JiFd93F/G
         0l8cqi5yNJANffaM4fNqWiyMIdQPNMkfm8wElZS+qFOzsv/kqkH9zX6mGd3+MHm9Kn8z
         oXxFFXcr2kMZugf/kiHrcT/hkxcxsD9Zzv+Ix1XrkBic1WvlB/bMQCOA39OGkPGRxK+V
         RtVk0st+mnelamK8/kocgkY454+JM7W5YNToVGaHz4ZCurESoP07GU/ZcXyQyWZli4mn
         FbMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzwpRhCBAu1oljFcopUetvxu5oXc8bhzsMj3xOn4QWblkL/T457SSOphGxz91h/0zIELWeyLkplQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqcpMYnAwqJUuOfusVS37BozyPDb/g+kOR+TCkP6bBWfDL7x5M
	XUWHXHShZdYibq9MPfjapCujAGmYxFImS/oXlxExHq7IbnLLxMY4EKhhd9L/691QEH9Idsrgr7S
	LdraJuAEYDLQXQYEW1sMZ352N0VSYbkfI5mIIguO/lp9Au2LQ+D7J1HFUTN1OpLc=
X-Gm-Gg: ASbGnct1gjFVYi7RTpzqXlkQV8HB3my6ApTcghI43BuaWmGhPGD/i6cA3DK3/WHs3gi
	Eo+hSZZb9KChezXckmb9NvKzb8hR6DJ+zpVLACExBFK7CNkd6B3ozE04dOB8nIBAak09+xBvJn8
	DVsHYPkouBAuqKV9y2ki+zDGf8E5BXub3baCSeRpYaU8PEQnqb8SK3w6M+3rKAYH4HLfRDGLRT7
	jO1ACdY4id1Ea+mSp76lmu/LprxQ1QbcBkSsLsc/68bSWmiBFUKvwCIrOj7CRTK2viV0SQe4V0A
	AB2g/FvmLj2+TiBshbi74/QtAK/7WUK2PIIH20bTmH2/j2WrzFE7tEvxNpIePRUcCm1RIOfQ7y+
	kzD9qJdLFc3KdDIP0P81I2pQGfVYj54h8T8o=
X-Received: by 2002:a05:620a:25cf:b0:7c5:9fd3:a90b with SMTP id af79cd13be357-7d4439a6782mr2794586585a.47.1751365665735;
        Tue, 01 Jul 2025 03:27:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+oCZZjLmSDOoCjvzvargEla3NI168MM5pcpbkDG2dcodzKQIT5n55eeaWDSwOx5TuBio7Aw==
X-Received: by 2002:a05:620a:25cf:b0:7c5:9fd3:a90b with SMTP id af79cd13be357-7d4439a6782mr2794581085a.47.1751365665229;
        Tue, 01 Jul 2025 03:27:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5561f56b8dasm324973e87.164.2025.07.01.03.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 03:27:44 -0700 (PDT)
Date: Tue, 1 Jul 2025 13:27:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sarthak Garg <quic_sartgarg@quicinc.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com,
        quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com
Subject: Re: [PATCH V3] mmc: sdhci-msm: Ensure SD card power isn't ON when
 card removed
Message-ID: <c7lpaij5f5monr7zfeqitncwnau22iollid2gs7okyorlegtmg@jlq65x7ipp25>
References: <20250701100659.3310386-1-quic_sartgarg@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701100659.3310386-1-quic_sartgarg@quicinc.com>
X-Proofpoint-GUID: 5LyAVvGwWbGer-iAwIW0xVFDVHm2LZ0J
X-Authority-Analysis: v=2.4 cv=YPWfyQGx c=1 sm=1 tr=0 ts=6863b822 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=QyXUC8HyAAAA:8 a=mSqIZBNSWgCFo2GgjH0A:9
 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 5LyAVvGwWbGer-iAwIW0xVFDVHm2LZ0J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA2MyBTYWx0ZWRfX/aCz9UA/XcCr
 RZaLL6/M1rOzfNALjKczuEXKqsxWd3HCa5w7OF8que3fpDJIRSWQoleWgsBLSoRfQb9qbKLOy8G
 jwbJr7Rm1oJnAaZ2J6NIGMraUvBj6vuaYGIub2lOFEzT0NFP9XoUOdzWR95uI9zQb1+C/zg8am1
 wTGUSJS246Pg+NeXACc03izkRKE8t5Pm4Pp1zAnjEP1CCmKpjrRlPbL3UhRl30x0e7MRJMydRQn
 yDZs2uZXeB6kRlEBfpm2ppnO92TtXwaXFrsb7gRRdLYmJWIw73Rso2pK1z7mHV3kv/KQyw3Rjn3
 RiomKUlHcwa/gIdJKXL/kp6iilpEwjzuQZzDmzVhxGysRpdYnrju07vo8ZgrJXS0pA4m0EHWO7P
 lL7vkS9NQTADm+4xkAEdV+Q93dE7aMpzumOCjUHgbO1XGnEdvZvYU8kQTz3rG62QhHaCYehA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507010063

On Tue, Jul 01, 2025 at 03:36:59PM +0530, Sarthak Garg wrote:
> Many mobile phones feature multi-card tray designs, where the same
> tray is used for both SD and SIM cards. If the SD card is placed
> at the outermost location in the tray, the SIM card may come in
> contact with SD card power-supply while removing the tray, possibly
> resulting in SIM damage.
> 
> To prevent that, make sure the SD card is really inserted by reading
> the Card Detect pin state. If it's not, turn off the power in
> sdhci_msm_check_power_status() and also set the BUS_FAIL power state
> on the controller as part of pwr_irq handling for BUS_ON request.
> 
> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Should this be handled by the MMC core instead?

> ---
>  Changes from v2:
>  As per Konrad Dybcio's comment :
>  - Updated commit text
>  - Removed READ_ONCE as mmc->ops will be present always
>  - Passed the parameter directly to msm_host_writel
>  As per Adrian Hunter's comment :
>  - Removed get_cd function as not much use now
> 
>  Changes from v1:
>  As per Adrian Hunter's comment :
>  - Removed unrelated changes
>  - Created a separate function get_cd for cleaner code
>  - Used READ_ONCE when getting mmc->ops to handle card removal cases
>  - Reordered if check conditions
> ---
>  drivers/mmc/host/sdhci-msm.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index bf91cb96a0ea..f99fb3b096d6 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1579,6 +1579,7 @@ static void sdhci_msm_check_power_status(struct sdhci_host *host, u32 req_type)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +	struct mmc_host *mmc = host->mmc;
>  	bool done = false;
>  	u32 val = SWITCHABLE_SIGNALING_VOLTAGE;
>  	const struct sdhci_msm_offset *msm_offset =
> @@ -1636,6 +1637,12 @@ static void sdhci_msm_check_power_status(struct sdhci_host *host, u32 req_type)
>  				 "%s: pwr_irq for req: (%d) timed out\n",
>  				 mmc_hostname(host->mmc), req_type);
>  	}
> +
> +	if ((req_type & REQ_BUS_ON) && mmc->card && !mmc->ops->get_cd(mmc)) {
> +		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> +		host->pwr = 0;
> +	}
> +
>  	pr_debug("%s: %s: request %d done\n", mmc_hostname(host->mmc),
>  			__func__, req_type);
>  }
> @@ -1694,6 +1701,13 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
>  		udelay(10);
>  	}
>  
> +	if ((irq_status & CORE_PWRCTL_BUS_ON) && mmc->card &&
> +	    !mmc->ops->get_cd(mmc)) {
> +		msm_host_writel(msm_host, CORE_PWRCTL_BUS_FAIL, host,
> +				msm_offset->core_pwrctl_ctl);
> +		return;
> +	}
> +
>  	/* Handle BUS ON/OFF*/
>  	if (irq_status & CORE_PWRCTL_BUS_ON) {
>  		pwr_state = REQ_BUS_ON;
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
