Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B344B2288F4
	for <linux-mmc@vger.kernel.org>; Mon,  7 Apr 2025 08:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744015431; cv=none; b=ovoP26IU/cqpwjCjzfvAJ6+RXYJECx0HpaVyJQESHW8F8my8SLBNhUyPXYI4/xpv5Y2zEETpreE3R6WORDmK1qiNLjJVNml5ThhmHlLtMkGnwoj4usfZyiQE7FWIG/Bo8berCZqthE4eHayi7/net1WbDt7u1NH7btdpua0eYAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744015431; c=relaxed/simple;
	bh=keeF2gzO1BG5TWSeisN2mF/28JltLtP+6/MPGcZqXK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YXTLsDw63p9ryD0J7x0cyLI4xH1uU/wlzudk9taqKPIxPURAcxT8T2OE3cmfRQeusNgwwbt/lWrqZKL1H3RvyHms1T5YUu0XV0F2lDMFBOfDNakiSoEBjGqlTuS1DhQ+/8vuooqyCp3yvgzYrbUD2GUhIHMlLIQzYg1PWhns4d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eskuvMgP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eskuvMgP"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378dq8o001341
	for <linux-mmc@vger.kernel.org>; Mon, 7 Apr 2025 08:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3LBZTe8by3wdJUm3j4TfqVrMn6/WCYmbjyVJqI9BVQI=; b=eskuvMgPTq/478q1
	aQrcm1nxa4BmpCqiMspO3aan+oaX57dgYk8O3sZaJSJ/GfvuXof7lncClX/UqrLE
	i7LggPpgmUzsg+cILKjgk6TbgDvXNEzqD/K+hVjjnSxD3LcIZhrta09w6OG/yL7h
	FeEUUwtyrQepSTHAyZd/zD5ItJVRoPKQ/mpqNnW4nMS6jcr1g+0DFZaOv9hLsSoh
	3ViF+iGeWObcIeLR5UJEio7DAHMcJfAUak/5EUgJABMyzlIkwnvvAu+IairodlNd
	QoYecjWf9Mq1DTw07kU/jroJLWRBOVk/hVnhnJWFUIdWKRB9o8lnV4PD7ZeTzxU2
	FSzYag==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twfkbjbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 07 Apr 2025 08:43:48 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6eeeaf707b0so2985556d6.0
        for <linux-mmc@vger.kernel.org>; Mon, 07 Apr 2025 01:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744015428; x=1744620228;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3LBZTe8by3wdJUm3j4TfqVrMn6/WCYmbjyVJqI9BVQI=;
        b=gktYofb7Oc4pHw3htqTi/xGT8GAYE3Oy+w+JuF+fn1+rDeW/odraVw7DL/A22Trg9I
         wElPccj7NQGNHnQouVlMVRzN2ql3XCj9tTdbolL8Z5lH9xt+er5RWrMPgql1/FHkz5K+
         Ac7tDiuzUlnVVWr2DNkUUPwuRte3BCvtam8sL3yMR121O4feTqWUgF2H/nRftfRkelQC
         Bpd8CnjkJi7CxFxg3nE9mKW+EyujLEe5PkOAB1jp+E3gvY5jkZmhybERuLHLNgLxrFTl
         wFINesAXCfw/XKm3U67R2V/h9FB7AL4AQVZ0dg3/pqzHDymUvxTP2U/4daY7sjM+eXR2
         twLg==
X-Forwarded-Encrypted: i=1; AJvYcCWvtpTFCj5tvlqi/TGQAAXH/EOsmedlX823c08FnsCW9eIBjFEgS4sVQNmgix/xQ5skwdQs7oce7B4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0qDDOhcJH1w9siJTblFVgGLJ2c0KlLh7m7xzEfZbbgZ295nKU
	WvkboMaaC5VYtHDO8RdUq/bZjAgXSs79OCt6MU1rb+Ls6BarWPTX1Gp3DfxgRYnLPAC1IulcNAh
	3S+MsiTGF/8MwEKaArI8CLbUIwZ7muxJL2kWor2nCWo/FEaoQHjCjwDuyl94=
X-Gm-Gg: ASbGncvmP8KdxEFsiRp0H9FCrYEqwexY+1pQmLzk3Dzr3gkGINyNoWB5ngpkB8My9H4
	/VS6FSCJdubdwzPj7Y3vVcn1N2cLkewuSNqWP9sAz+t43Z0gerV9OlsM2P0y1c45aaU+xajYy62
	AFKxkorw56Vya55aOctmX0x9w79BfsnXcb6Aaz/WmVdLJ1LqvyIbyNJjTPnQuFiNAtQuuQWBrBn
	q31IC714leI/nnF5TA5ENPuVzAslvjSYZ0et3RzoX/EWFX+FkfQEV6ByR9dqNn+GTESv708zj/c
	dyZsq6u3PNQm2pWgZh/DU9Uz0ljpQN1CTi/i/zdGQaamAtjCEs/r2d+5y2Xwl7H+lAmSTg==
X-Received: by 2002:a05:6214:e8e:b0:6e4:29f8:1e9e with SMTP id 6a1803df08f44-6f00214d08fmr68496696d6.0.1744015427731;
        Mon, 07 Apr 2025 01:43:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFebGzNDRB0fY7+hPc7f12BLxECnTU/bMrpcOZJhMDdfXfqIZ/Ci0T8pDYTDUbni8F9lrsXA==
X-Received: by 2002:a05:6214:e8e:b0:6e4:29f8:1e9e with SMTP id 6a1803df08f44-6f00214d08fmr68496546d6.0.1744015427351;
        Mon, 07 Apr 2025 01:43:47 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c013f34dsm701813966b.87.2025.04.07.01.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 01:43:46 -0700 (PDT)
Message-ID: <9eb0b21c-6830-4636-8a92-e174e34d779a@oss.qualcomm.com>
Date: Mon, 7 Apr 2025 10:43:43 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 1/3] soc: qcom: ice: make qcom_ice_program_key() take
 struct blk_crypto_key
To: Eric Biggers <ebiggers@kernel.org>, linux-scsi@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Gaurav Kashyap <quic_gaurkash@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Jens Axboe <axboe@kernel.dk>, Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20250404231533.174419-1-ebiggers@kernel.org>
 <20250404231533.174419-2-ebiggers@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250404231533.174419-2-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JPfISV1FiFGNkHWcGMNHLS2GhmpqonhP
X-Proofpoint-ORIG-GUID: JPfISV1FiFGNkHWcGMNHLS2GhmpqonhP
X-Authority-Analysis: v=2.4 cv=b7Oy4sGx c=1 sm=1 tr=0 ts=67f39044 cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=1XWaLZrsAAAA:8 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=frSOPK2eQqz-eahEfmcA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_02,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070062

On 4/5/25 1:15 AM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> qcom_ice_program_key() currently accepts the key as an array of bytes,
> algorithm ID, key size enum, and data unit size.  However both callers
> have a struct blk_crypto_key which contains all that information.  Thus
> they both have similar code that converts the blk_crypto_key into the
> form that qcom_ice_program_key() wants.  Once wrapped key support is
> added, the key type would need to be added to the arguments too.
> 
> Therefore, this patch changes qcom_ice_program_key() to take in all this
> information as a struct blk_crypto_key directly.  The calling code is
> updated accordingly.  This ends up being much simpler, and it makes the
> key type be passed down automatically once wrapped key support is added.
> 
> Based on a patch by Gaurav Kashyap <quic_gaurkash@quicinc.com> that
> replaced the byte array argument only.  This patch makes the
> blk_crypto_key replace other arguments like the algorithm ID too,
> ensuring that there remains only one source of truth.
> 
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org> # sm8650
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
