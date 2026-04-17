Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4533939B4
	for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2026 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776432593; cv=none; b=cDtI+c8gx67nSl1oALh186hwec2IoeervjRhRAIpDjbRJecfduuGrxnWc1sk0SA0qIyMdrOv7Xd9CZD6zpyzgAUroulPTx0IJt7yopMJp8iXbIEx0IxhSQeUNFD+uNuihAYapsiiZAlJ2hbgEycZ4p4uC6BvNU55ZtDtALola70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776432593; c=relaxed/simple;
	bh=SDOJrrI3lTBAebziczGzMC8S5O6qT7RZbqRtoZr1W6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q872oGquOeilfQgzhQBqpL7bVkyEwN7UvVGZMuZzPU+8ID9V9fomQRsoztMfIHW4Bt+gF8vZLL6rX0ZqNlkpf41lNr7MqlGm+otxlYZi4rgHOltQuCylWKAjhfrGYx7/pJGcXfD9fQPyD3y96T5FvvjOEscnjwG44gclZySRCaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iidswQYE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DQYtnBoF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iidswQYE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DQYtnBoF"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H9kYca1042150
	for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2026 13:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1HeSxgq6qe6Gt1Ak2J5KtEc+UgWpolaht6umu9cGq9I=; b=iidswQYEQzjN85nH
	G2ti/igpUnv19vyXSn0ZYOPAvXEd4sksWg+Y/P5kXJS470Nbi/PdEdfLCFZzIoZS
	JzZM/r2NjRsgDGjo738SNRl1toTXwvK1bAekOC24GvQGfg0ehdWEPcc/hEoupjqB
	fnJroOKZwMclndwTw0vh1DJp+p9Xs6xm7Ym6e6VVfpRxxmqy/U2MmpgV/ZHFHJSA
	Vp67f19HWYjJPdBZzytZGBzCNPAkvBkzDDUSLJeA35TJDjp2te9f9sGBtDi21nge
	uccaAl5FJEs6uw38iiwE2uJpltwjBLCbRoihjOlmjONR+9awUgvdPH2bQzy2Imoh
	eJDcBA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkjhdrrwk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2026 13:29:50 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f74f0e3c6so530009b3a.0
        for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2026 06:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776432590; x=1777037390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1HeSxgq6qe6Gt1Ak2J5KtEc+UgWpolaht6umu9cGq9I=;
        b=DQYtnBoFUhEVJMbx4PRgvMyaCDUoO8it4C8EbMrdNzxJnsNacomRmRKC9F+wM2EQof
         txQ5jz5hjWMQnS+Cm9X5zYvon+ZxBOiZfQ9AYXJimVQ6enscV47sbIBbPy7GTi0q5vvx
         yA75LjprB82xnQhNNXEYjEklxDMbOaSU0v0B8SdNG0T7KsPOgI2IrPyUkZ+89gnXLwt3
         tKn3yaV76Thfcf4v302Zfr2QtuxgOYYyJp1SYZjY/sf9A4psx7G4UW0+gEs2034Wr51i
         Q6i5Vk8PIYhXRTze1m8Q/xlfKucIgRkndrGRyAg0fvrA6GHOaKtqGLDikojVJKPZQLw1
         I6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776432590; x=1777037390;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1HeSxgq6qe6Gt1Ak2J5KtEc+UgWpolaht6umu9cGq9I=;
        b=fpPEJLIRzvomuzyFBTW7JOZa4Fwx3fVjlCiXUGmq9llNopGlZDzAFdcqqkMQoRvRvr
         lMgipkOm8P9Z7zZf1IFmFQef7ukiZXnKGUg1HGgootcocObg5VPnZcmP80pLYrqud+Kd
         JsItTJ76l/fxUqcWlpUNku0XtZNWyNK0VqYmzpH/nJYINyC5hqwtiRxeBcxw34QqsVJm
         fdmwp61L5AnB50Ld8W7CXyYwhTz3L0Gd0AxXX27Gtrqwt+RU641HXOGiNPK3tDDRHOr7
         Tif9BOiegBVfch6WkWAfHBAkFsaR3IDeI3KdOsU88Q4NRAp7nMQwtTvcek8BBsQofsMG
         44SQ==
X-Forwarded-Encrypted: i=1; AFNElJ/cO53WeZaC3mCVVjlslfmXJAGwod516eyI2bsY7BgB1TvZtWjcoNuLjIXuRQFrcsHcHHPv0eioxOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKlJPnsc6XFiNfkztFnQoKlrJm1kz6MDp5idXKQo4ygnWYrL3p
	Z9JoYi0Vk7OljesezkTOXikW7WEI+NuwynBt2sgw5aySbjWohaONZihIzhefnplbRtFfVLWrf4o
	bMyXV81+PZWVbhEVZ9Cto7fZEFTJeVmPB7th2Eh+9m/w+pbVrPjUuSfEoIDnxZ8U=
X-Gm-Gg: AeBDieusTAMI2wHsCjApVBvacgmEQ/LoH6ILVNwt12FPLv9ZLjx3iNlw+3w5n68gtK4
	pYN9Tr5JeDZ4n9QDx2GPcFCB7mR+eqoQW27yORdFrK04BySpGzdA7aGi68+hCziXHdJ76RVwW/Q
	/5hLpY7d/71jDkgPEG3hKeTiHC5F93xHznDyTnS7C57WwTmZpuFaM5tcfh+awnC+D9fmMtvGLdW
	j1QNJ1pigosaBgV6XHWrEqdq7bc5O6s9iFPEMpkuLI6SyNgZ/kgr65j1P3jKsUU3tMw63X94LBi
	2Uo+T23ZesRVZEygdamRcXp2KvVmpO3r+Jo5hs1WxBuiXwL5xpppCozydPQhx1jOZXWVHOy5G0R
	fFSyDgpm7cpJOhwsRWg0FJEBndGhP2fP6/jgpIWADIUQFUCBHojSKqW3xTGbd+w==
X-Received: by 2002:a05:6a00:a241:b0:822:6830:5900 with SMTP id d2e1a72fcca58-82f8c7eee25mr2726441b3a.6.1776432589978;
        Fri, 17 Apr 2026 06:29:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:a241:b0:822:6830:5900 with SMTP id d2e1a72fcca58-82f8c7eee25mr2726388b3a.6.1776432589265;
        Fri, 17 Apr 2026 06:29:49 -0700 (PDT)
Received: from [10.217.223.121] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ea0a97esm2695706b3a.27.2026.04.17.06.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 06:29:48 -0700 (PDT)
Message-ID: <a432b2c2-475e-4833-9225-801990cb2d34@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 18:59:42 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/5] mmc: sdhci-msm: Set ICE clk to TURBO at sdhci ICE
 init
To: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson
 <ulf.hansson@linaro.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260409-enable-ice-clock-scaling-v8-0-ca1129798606@oss.qualcomm.com>
 <20260409-enable-ice-clock-scaling-v8-3-ca1129798606@oss.qualcomm.com>
Content-Language: en-US
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
In-Reply-To: <20260409-enable-ice-clock-scaling-v8-3-ca1129798606@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TK-NXjkmxwngmWJyI1d6-8JZAA65OdwB
X-Authority-Analysis: v=2.4 cv=YpQ/gYYX c=1 sm=1 tr=0 ts=69e235ce cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=i-sMpDq2_rzAXM5hadQA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDEzNSBTYWx0ZWRfX+ibgUEn+9yPF
 lQ9tNAoHvRqiiXLaP96WdNPI/lZ4Yj6jdGI4tmz9XrF1pOweDUOJXFctmuPkECOrKRX/UBRwQqg
 bluPjtL4HpYIaCodM3nlM7ZJtx5EtG/OnN+2BtxThYQXzo0vxuuuErE7mZR8Kn7TYqKgOskgeUD
 mwrdzqg2CCnoEs6zj+g5QrucSHJFgCB7a14xEafwjGpnzB8vtFhHW8he98OV4UH9vB3vf+hib4y
 A6i4qwLi7NN0cDtbGdZr73cXVfIEwrXIXWazZTOwqlCqIKHPhckZlz4pITzX4hxWTYFdU086BLs
 WBYveO5N4XZ90pzPKLjHgQPgwrVNzSh8NvYAQe6sIeEpm1T3UIvDK1lPrqehcXNOVZbPIXDlTvd
 MK8Wj9qYB2TK4zVjVfmwaGOhmrPvVsUvoRin26AzQDIGQ42IjDKffhZsMfOocM04BMaOHM4kKhM
 jC0FesdNyN6tfG3vScA==
X-Proofpoint-ORIG-GUID: TK-NXjkmxwngmWJyI1d6-8JZAA65OdwB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170135



On 4/9/2026 5:14 PM, Abhinaba Rakshit wrote:
> MMC controller lacks a clock scaling mechanism, unlike the UFS
> controller. By default, the MMC controller is set to TURBO mode
> during probe, but the ICE clock remains at XO frequency,
> leading to read/write performance degradation on eMMC.
> 
> To address this, set the ICE clock to TURBO during sdhci_msm_ice_init
> to align it with the controller clock. This ensures consistent
> performance and avoids mismatches between the controller
> and ICE clock frequencies.
> 
> For platforms where ICE is represented as a separate device,
> use the OPP framework to vote for TURBO mode, maintaining
> proper voltage and power domain constraints.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> ---
>  drivers/mmc/host/sdhci-msm.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

[...]

>  
>  static const struct blk_crypto_ll_ops sdhci_msm_crypto_ops; /* forward decl */
> +static int sdhci_msm_ice_scale_clk(struct sdhci_msm_host *msm_host, unsigned long target_freq,
> +				   bool round_ceil); /* forward decl */
>  
>  static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>  			      struct cqhci_host *cq_host)
> @@ -1964,6 +1966,11 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>  	}
>  
>  	mmc->caps2 |= MMC_CAP2_CRYPTO;
> +
> +	err = sdhci_msm_ice_scale_clk(msm_host, INT_MAX, false);

The 2nd parameter is an unsigned long, do you really want to pass INT_MAX here? I would go with
UINT_MAX. But still, why go with such a high value? Do we not have an upper bound for the clk
frequency that we know we can't ever exceed for any target across OPP tables? If not, then maybe
UINT_MAX is best we can do here.

Regards,
Harshal

> +	if (err && err != -EOPNOTSUPP)
> +		dev_warn(dev, "Unable to boost ICE clock to TURBO\n");
> +
>  	return 0;
>  }
>  
> @@ -1989,6 +1996,16 @@ static int sdhci_msm_ice_suspend(struct sdhci_msm_host *msm_host)
>  	return 0;
>  }
>  
> +static int sdhci_msm_ice_scale_clk(struct sdhci_msm_host *msm_host,
> +				   unsigned long target_freq,
> +				   bool round_ceil)
> +{
> +	if (msm_host->mmc->caps2 & MMC_CAP2_CRYPTO)
> +		return qcom_ice_scale_clk(msm_host->ice, target_freq, round_ceil);
> +
> +	return 0;
> +}
> +
