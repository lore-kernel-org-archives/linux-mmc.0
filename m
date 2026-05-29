Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189A22F549F
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049969; cv=none; b=u/FqKTty+f4z0W3ZI+EOVSXyVsXqaUJmzuTkXZ3kjHslvA3w2STTT01Q8QveM0Auw3apvsjvdBKwK0kUvMmYPZ9tiA44nbXRqsflBQDqObWqhhr/gA3mmOF/meCJ7MX/KRIN0TjNcPgWOJiPWBY7foPkDWpssVtHNz6qO+aPldo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049969; c=relaxed/simple;
	bh=6KKnIYJJVCj8nV2etPjUel7tCqrSD33dBAHj0hh3Pwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MIerxsEWS4WAe6pi0gUlZ0N+afgDnx9tVWX3dTeZ5riG/6IRu/5MG5Ydxh/aVRV1XVdL7CltJ648B6bRxN1GSobIUXUDT83MCw0OKb/PRuOObKqq6caKfbDdPxWLa/Vz5xZosaqNkeyJPzjyvj7aTe++ounC6aX7oAu4TI+rzr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VxQbYGoB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OyXl/ZdG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VxQbYGoB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OyXl/ZdG"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TAJ8iT4193313
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 10:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M/Skb4l/nACf04TKh2rNhCpVjz/iy4wjGxm1q8IUBCs=; b=VxQbYGoBbsNdzfnV
	uXfmEGVBThJ0Dpqf1ZT0jXtvHO7CwiyZ+8TAGR+MbQXZdyNFXP5/Ehk5jyl188dE
	UOeNwV9WMZ3lxMBj3mvbT1yV8PkVgB+Of86VIjsJRc/LzJ7wbEGQpt8tkK5FSqSo
	OUksFcFNXz4FFXiRSMLfBREgaYSEM2nAxDzbMD5o/BA9lL2ETPHJDNazC8Ms/6bY
	b0MaNktl1aXWY80N88x3tp3dWCRiwNJd5wtbydg2NHPb60LasdyZf8TIPwKzR6jS
	mjaJYA7M3r/qK7rvSAuX4QgPhhWvka4PAIaXqFzUW7+JN1FHXDorRizIhPYan3dr
	bKYmxw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef3te1d55-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 10:19:26 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82fa2165c3eso9123182b3a.0
        for <linux-mmc@vger.kernel.org>; Fri, 29 May 2026 03:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780049966; x=1780654766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M/Skb4l/nACf04TKh2rNhCpVjz/iy4wjGxm1q8IUBCs=;
        b=OyXl/ZdGeyzP9ZbKxgk0in/vjErQTILn+p2e4n0SjZkH70aXzlRycVESM6kpwIu/az
         W4PHlXNVTuQr7UXa30m44yu9kAOXo0RKNlk33SZGULbFfKsBY2vPRsfgEKk2RpOBqK6x
         4IEMmXzWE037LSIlRPdVABdZQHzotIWM82KPh2xExl26WAVuuLVvzkkTdCrOmoiwJuAt
         xqA4v/7lJMpzSL88PB9vpZGmUjV7/CVSuaFopjuUHRe9iBnakf3EXEtswzihtazyERkt
         VAausOXZQaM23QrskpDZ4gyN8VypGAhPoqPntNJd+5cArKuYgiwOxP7H1gnvGyACBn46
         faMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780049966; x=1780654766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/Skb4l/nACf04TKh2rNhCpVjz/iy4wjGxm1q8IUBCs=;
        b=rwPZounl+FA7e7A5XpdU7YxMCuHzE+Pc8xYr1XksFfXOAM9YrBFL3uJBHh+9LNuZm5
         sgTwpNI6/mbxhhG5DIbpvWFtWbe/KV3Th0RS++q7MWvg5Gd9MjX3JROIlv9feYC/ZvF/
         N/vO6uXq40AcxuO6VZUDlwpSdTPGEjHNW+ww3+5ckztl33123LOsQP6nje6uNJ5jqdYH
         oiuRYp00JSlMBU0a3gqToTmm26dPw91YhMlPVBTCLXzmhONVs80PkVYj0OG8xfW8A8jp
         3elsZiLpNi+KXU/t0dVk/lukcVcoxlEjliHiu6PB7QA39kEaKWk6AnZJIbIQCQ0fFm13
         +x1Q==
X-Forwarded-Encrypted: i=1; AFNElJ9IqE5hUqcXRQ9ZIGcuHg1xX4JwM6CTbVJdkyVAIBKo97J7um8rIUi+JuM8WnjJ/5/Di04AVSJto6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfRo+68FNj5Dkp4RxHQPYn1fAu2rwnf+Hs09oagA83rt+VhyU1
	rFIjLE9CixyBVLt4d5kk/ThxW4fL2IHrUbp8+owIbBy1ka4AY3VPCr0eMI9HsWz1//knC5jTjka
	RZk4eisvuC+6EOIt1pb+Ip5DTBsDI/2h6QsFc96SIRHkB9ZIL7DiHSlABG3znAyM=
X-Gm-Gg: Acq92OEl5utUYhjlpQfi1A+7etPCYpi9xxje1ugWRMP3vcnvIk3EeLH3TENBqFRsQ/7
	0p4l7bYwxgDnOR1v41pYa4mI8t1dakZsCjyK4WYKEgEzplxvNnT5sk5Q7+UjLnJRimZzUfkRy0G
	rHUoYU6Tduq+7vPAgBh0E3sLUoi7XHv23KTtx23/LhO7UPLm+ihF5jCiQiL22pRV7DrGI7l99dU
	BN4gyjIovNp0vNqDpPNcTQc+WxNdo54+xlTWCZsv0OLDA4OzzktLMj+RSNYHkmypLS+7TzdWK5Z
	EJu5PdS4e1SAecIgdLJAQhkpzpMsQEpOf72hfrxAL52hmtsLBCpx+gMsv+ZS84Z66Q/AmKtpy7l
	eAdE6IKrf6eQmcNxQcYNbRvQds/SRbOTcnFu9luBUKwl2O8+2+H54vPYeqojQz7dEhLSUf21HqY
	yExVzHBF6L1wUQdlyLe96HkQ==
X-Received: by 2002:a05:6a00:22d3:b0:83e:3050:d0b with SMTP id d2e1a72fcca58-84212ca312bmr2505133b3a.1.1780049965545;
        Fri, 29 May 2026 03:19:25 -0700 (PDT)
X-Received: by 2002:a05:6a00:22d3:b0:83e:3050:d0b with SMTP id d2e1a72fcca58-84212ca312bmr2505104b3a.1.1780049965016;
        Fri, 29 May 2026 03:19:25 -0700 (PDT)
Received: from [10.133.33.250] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214d018fcsm1373595b3a.60.2026.05.29.03.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 03:19:24 -0700 (PDT)
Message-ID: <e9cdf8dc-40ea-49f2-a655-b99ed0707a8c@oss.qualcomm.com>
Date: Fri, 29 May 2026 18:19:18 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4] mmc: Avoid reprogram all keys to Inline Crypto
 Engine for MMC runtime suspend resume
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>, ebiggers@kernel.org,
        ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: quic_dmukhopa@quicinc.com, quic_rampraka@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_gaurkash@quicinc.com,
        quic_sartgarg@quicinc.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260529092612.1749752-1-neeraj.soni@oss.qualcomm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20260529092612.1749752-1-neeraj.soni@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oJEamDg2qpNB-RahbwKlQ868Qn-fJGPJ
X-Proofpoint-GUID: oJEamDg2qpNB-RahbwKlQ868Qn-fJGPJ
X-Authority-Analysis: v=2.4 cv=daSwG3Xe c=1 sm=1 tr=0 ts=6a19682e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=QyXUC8HyAAAA:8
 a=K10AMJlnD9AZVQnTPLIA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEwMiBTYWx0ZWRfXwGRf7wr+VNRt
 CKfff0eoWkgzRLiniOFxLhe/13y2Akco2Ln8p1jc61fUmEAzxC3fYFive9rRJX/tpPVWyMtYxDk
 W2nChLxs7hBbDtPWv+QlUlc/98w7Fw0HFAVESYuXjtsDNVI/FHiQ4twW9QgdpynZaZrc/rG/4fd
 F0gfHzoBsSKnVbDPg1BRBnOx9oRn4It4SnkohWVLltsjRvSq6LxAhCTHXd5fF9ZTZEWxlE3wtVU
 VwLa48J6cpH2Gf8c4xDLZ+rKA4+8HNa/5JHwnmdXu7vLHPB8tzbULcv/fzm+K7eX9aCWjUBcTsV
 QryPV4wQVoZ5Zcq93myh21qe+Mh03E6BXTBM5u1Uka49K37ejbW0cHjrGS49dlUP8cpljN16SXf
 NU7wmA5URZnBb1H9Xy3+YX4VP1RfmOlQ0jyDQ1CI1Zw3aWD/hCLP0a+MtzB+VANObONGu85OO0b
 yK7yWD8smORH46vQPCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1011 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290102



On 5/29/2026 5:26 PM, Neeraj Soni wrote:
> From: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
> 
> Crypto reprogram all keys is called for each MMC runtime
> suspend/resume in current upstream design. If this is implemented
> as a non-interruptible call to TEE for security, the cpu core is
> blocked for execution while this call executes although the crypto
> engine already has the keys. For example, glitches in audio/video
> streaming applications have been observed due to this. Add the flag
> MMC_CAP2_CRYPTO_NO_REPROG as part of host->caps2 to control reprogramming
> keys to crypto engine for socs which dont require this feature.
> 
> Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
> Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> Co-developed-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> Signed-off-by: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Link: https://lore.kernel.org/r/20260116121004.1829223-1-neeraj.soni@oss.qualcomm.com
> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> ---
>   drivers/mmc/core/crypto.c    | 2 +-
>   drivers/mmc/host/sdhci-msm.c | 6 ++++++
>   include/linux/mmc/host.h     | 5 +----
>   3 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/core/crypto.c b/drivers/mmc/core/crypto.c
> index fec4fbf16a5b..a5a90bfc634e 100644
> --- a/drivers/mmc/core/crypto.c
> +++ b/drivers/mmc/core/crypto.c
> @@ -15,7 +15,7 @@
>   void mmc_crypto_set_initial_state(struct mmc_host *host)
>   {
>   	/* Reset might clear all keys, so reprogram all the keys. */
> -	if (host->caps2 & MMC_CAP2_CRYPTO)
> +	if ((host->caps2 & MMC_CAP2_CRYPTO) && !(host->caps2 & MMC_CAP2_CRYPTO_NO_REPROG))
>   		blk_crypto_reprogram_all_keys(&host->crypto_profile);
>   }
>   
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 4e5edbf2fc9b..2ccb63dde9c1 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1949,6 +1949,7 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>   	}
>   
>   	mmc->caps2 |= MMC_CAP2_CRYPTO;
> +	mmc->caps2 |= MMC_CAP2_CRYPTO_NO_REPROG;
>   	return 0;
>   }
>   
> @@ -2526,6 +2527,11 @@ static int sdhci_msm_gcc_reset(struct device *dev, struct sdhci_host *host)
>   	usleep_range(200, 210);
>   	reset_control_put(reset);
>   
> +#ifdef CONFIG_MMC_CRYPTO
> +	if (host->mmc->caps2 & MMC_CAP2_CRYPTO)

Always false at this point. The first set of the host->mmc->caps2 is 
later in the sdhci_msm_cqe_add_host.

Thanks,
Jie

> +		blk_crypto_reprogram_all_keys(&host->mmc->crypto_profile);
> +#endif
> +
>   	return ret;
>   }
>   
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index e0e2c265e5d1..2fd76f966e24 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -457,12 +457,9 @@ struct mmc_host {
>   #define MMC_CAP2_CQE_DCMD	(1 << 24)	/* CQE can issue a direct command */
>   #define MMC_CAP2_AVOID_3_3V	(1 << 25)	/* Host must negotiate down from 3.3V */
>   #define MMC_CAP2_MERGE_CAPABLE	(1 << 26)	/* Host can merge a segment over the segment size */
> -#ifdef CONFIG_MMC_CRYPTO
>   #define MMC_CAP2_CRYPTO		(1 << 27)	/* Host supports inline encryption */
> -#else
> -#define MMC_CAP2_CRYPTO		0
> -#endif
>   #define MMC_CAP2_ALT_GPT_TEGRA	(1 << 28)	/* Host with eMMC that has GPT entry at a non-standard location */
> +#define MMC_CAP2_CRYPTO_NO_REPROG (1 << 29)	/* Host handles inline crypto key reprogramming */
>   
>   	bool			uhs2_sd_tran;	/* UHS-II flag for SD_TRAN state */
>   	bool			uhs2_app_cmd;	/* UHS-II flag for APP command */

