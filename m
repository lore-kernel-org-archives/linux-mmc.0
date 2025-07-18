Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B2D215F42
	for <linux-mmc@vger.kernel.org>; Fri, 18 Jul 2025 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752840358; cv=none; b=LuoRfm000sgeJrkjqWaBh+tCe9k8JLmiss94X1ZQtArizjr6PpRvqm4782+VWpCJN59HdOGoi+UaT+fb0u6OQ23GhnHj8ridio8cFj20G6cxxZc3RHG0qrkDKO4NKyOqIzBV3B0B86h7e0I5bPY+0zf9F607UAlqLuaBP1UMW0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752840358; c=relaxed/simple;
	bh=7U4qOHFZvZLxWGVMYR7f8oDY3EFaK/os9tDzF6lr9FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hi1MuQLwrwjo1Jf3tpbcuu1vIH5BLXxjZkqS+7CEWeNlxWZ2YT4J87fBw/860ckujpX0NCKrj9VVlZ1AhQPxppPf/LZ13/DJP/g1SarzG5wHNoxyUVGzKeAKNEfSQTn6z7yE9pNan4njVQ1hhbDeyFchBQlxyIifxIa/MuosR4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LdSzPevX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LdSzPevX"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8Tl5D026790
	for <linux-mmc@vger.kernel.org>; Fri, 18 Jul 2025 12:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8UtRmvk1FOoWe2iPf/lIbg2tWc6zOKHKHM5RupZ8S24=; b=LdSzPevXM5JAsAu9
	vM34FB2+xLk17yZoA0lKX72401EL72yks9USgrWEBlt/LD0mH/XLGDU8hk0xPQjI
	XgiyPzGR/y0MWdDP9gqCUxYjggQLyaAyQOjPijvFMVG5t8VeO66PUylBgNtYgX+g
	VIuoFHzlpQd6V7HX5tJM2B23KAZHidkAJUGJc+wsVRdqma4+o7ZZWPFFslU6p3ry
	22bFHQA4RqApjI9IoG1LkI35YJyTE22HLMG6Al/4mvfFMwcPAZwPNzdOJun9zp06
	9r75YE2ue0Vc7H0g/bYXHvSdYzOwgiyYbZ5OWV9/YcC+3VWDPO6veWrc2Mt8Mzw4
	oLDMYA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xbsqfjud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 18 Jul 2025 12:05:55 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab7406bfa1so4382721cf.3
        for <linux-mmc@vger.kernel.org>; Fri, 18 Jul 2025 05:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752840355; x=1753445155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8UtRmvk1FOoWe2iPf/lIbg2tWc6zOKHKHM5RupZ8S24=;
        b=m5B0Wt6aF03lJVyclgkdcjsdGcGQeubaswkVBtqY/7GgiOHv12KEOCMLQuSBq5KqQx
         TAhSd2448X+vGT6liA8YZ19ZqZDxyEGLuXqnwCkzDAu4bD4aJRKPj0wiK0NFlkADH0PU
         r8pMT1Y06V7LHgyQtlM11bk/dYMvuPujCagDpMHaPfIyQ5VMffMOXiTNB0JbNU4hr3uq
         RkdkXCPaoZqmV7CsobuKcWYU6nD74tGE87M3cKLk0O0VDlThNnD7vyxT8I5JkOAzRRxz
         9lHCdirgXMfOZDrvQIfqXstG3CzXJgmtjpLWTvTs46cig/QI31erfofLdcRaPkhVPf5F
         4cng==
X-Gm-Message-State: AOJu0YxptbkPk0ieGXRZrNWVE4fr5K73wet+dy6ejvAKHCWQBrEfmP6B
	cFqCfaAcUSMgm2uda+cskF3ewzp8w9J3DvOdOs5Qu1HVcB2fOGbNIsbKyg3sqFQBot9cdl+HnxM
	GK4TvFXAEhhFtD8NsXULmNRDT4JlUXuZzegzjgzX7r9gOnZKcjyGWrqk/j/kfLmA=
X-Gm-Gg: ASbGncvk7FOsBao52htimQqsSbFjN7UvFTdpaN+5ycpZKcmoDioxhtjxiLlfIjkPOAi
	i0gng2AyWPA1SlXoIvYXVUAU7+sr3SV5Imiga9963SK16Rca1FJ64+TWJOuG/29DXqrbN3zDZBW
	24veiUNq74hdwerAtZdEfm9wLdT5v863xF5D4OAPYBqJeRh30QvEGNID3pU2zk7JicoBSiNqs7J
	Lr9wf5tUHppieKW0MxR6Vu5Q6hlYwRqR6GbP3XbpBnJMTwwgEMOz+8iUDPZz3yidrPMLNBd8PON
	tZ3NQkThck0q4UpVpyNKjWszjkoxH2LAx2Ee5asb3OyP2WaGzG/Rs49lbTPvrDn/hT5h268mRSK
	uxJ927+0kkMnNo8AwA0Bj
X-Received: by 2002:a05:622a:302:b0:4ab:6499:785d with SMTP id d75a77b69052e-4ab90729467mr67177781cf.0.1752840355067;
        Fri, 18 Jul 2025 05:05:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEul6bHo97RUTHI+UU0ltJXObJlfOp/FKdGwuUle+uoI3cN3nXxhZnpbltIlsaOTmG/aibb8w==
X-Received: by 2002:a05:622a:302:b0:4ab:6499:785d with SMTP id d75a77b69052e-4ab90729467mr67177501cf.0.1752840354617;
        Fri, 18 Jul 2025 05:05:54 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca7ea53sm109360366b.133.2025.07.18.05.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 05:05:53 -0700 (PDT)
Message-ID: <a569a2c3-2fb2-4a40-8d54-898e7c36f4b3@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 14:05:51 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: Avoid reprogram all keys to Inline Crypto Engine
 for MMC runtime suspend resume
To: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@quicinc.com,
        Neeraj Soni <quic_neersoni@quicinc.com>,
        Ram Prakash Gupta <quic_rampraka@quicinc.com>,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Sachin Gupta <quic_sachgupt@quicinc.com>,
        Bhaskar Valaboju <quic_bhaskarv@quicinc.com>,
        Gaurav Kashyap <quic_gaurkash@quicinc.com>,
        Sarthak Garg <quic_sartgarg@quicinc.com>
References: <20250718110217.1929526-1-quic_dmukhopa@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250718110217.1929526-1-quic_dmukhopa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ad1hnQot c=1 sm=1 tr=0 ts=687a38a3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=K0aOVt1QNMoejPNc-jgA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 90IzFV8-1y_gO8bJkUAu-n8Eo-9gBX7z
X-Proofpoint-GUID: 90IzFV8-1y_gO8bJkUAu-n8Eo-9gBX7z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA5NCBTYWx0ZWRfXx9luchdHllN5
 L54HSpt5onwSg3L4aLyVJA5FkqC0gFGgJBeEQ2WEgM1ghlV0g06LcqcqKs8J+L/p+l6VbpUP/er
 5XCvxuCl4c1S5fEWaShDTg6CSp3YyxRWSjiAPYbITrDmjjGsIckhJdREnOzbDLcb0vUa1ic9mst
 mqR59fdIZcjkJzSI0MFjwI2LsSQrS8rZuRbhbPPawxB19fTfjTsCvB0wgVAXs/iLYJoNcK1PEaR
 BH6acZgd0by+IvGlvrjMPVRglL7CRuVPRQAXDXj00LkLRuCOwzcy+lCB5UPNZnwsMrby5eE5oXk
 /zAzvZiDOpc5ujUlfvKtz41QtY8hAJg2LeBdqgHUEBVyU/d5MIk/mm7GWKz4XbNoUznTMu+xZ/x
 Eeu0ecSPv5QXWGDspX19Tsttg/GvfqhoxkdcAZ2GgvBCVTdjPZ07JLm5VbjU2L0+3w/kdtkD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180094

On 7/18/25 1:02 PM, Debraj Mukhopadhyay wrote:
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
> 
> ---

Let's take a step back - do we need to ever program this more than
once on QC? What about other devices (e.g. the generic cqhci-crypto)?
Do they also lose the crypto context over a runtime pm cycle?

If our hardware is fine with set-it-and-forget-it approach, maybe
we could limit this to a small if-condition sdhci-msm.c

[...]

> @@ -459,6 +459,11 @@ struct mmc_host {
>  #define MMC_CAP2_CRYPTO		0
>  #endif
>  #define MMC_CAP2_ALT_GPT_TEGRA	(1 << 28)	/* Host with eMMC that has GPT entry at a non-standard location */
> +#ifdef CONFIG_MMC_CRYPTO
> +#define MMC_CAP2_CRYPTO_NO_REPROG	(1 << 29)	/* Host handles inline crypto key reprogramming */
> +#else
> +#define MMC_CAP2_CRYPTO_NO_REPROG	0
> +#endif
This (and the crypto ifdef for MMC_CAP2_CRYPTO) looks like unnecessary
churn - crypto functions should never be called if the config is disabled
in the first place

Konrad
