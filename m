Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B774D4F5DF3
	for <linux-mmc@vger.kernel.org>; Wed, 14 Oct 2026 11:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791976636; cv=none; b=sYPs16iHDSV3/etB+yyhTtZqcxUpNdQ0H+EOAq5bL9GarxiZRup43nYwplq+4JWpZKsGuU9cW9fUKg9HkocEj/oqBeKKjwwstKxoGrLktKAGWTXXAgYTPHJsv+rL/cyRZbTOWgCaZOza109d8RCtpiszvOruWivHNJ9Qyho/6GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791976636; c=relaxed/simple;
	bh=2vrKF8mOD5KYteJonBX97eQDhJTkrsZRQJ+cGz7SJz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suapbUA5dMzQe22/CYkQIE8kO/O+p4NEfmo+Ia2jcXbhCqNQu9L0+UGHfAk1N97ITtjOjO+lTGQGOpGiYV+gleYyJu1qadWGvyQlp1Z210jEZtMVtTkeq4gRZ0u8Io/wXDuFwxAZ38QQ8o22P3aLbYFIJ1NaN4uZ5oLiBXwGszs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RvMdUCLl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AkUOjvtN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RvMdUCLl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AkUOjvtN"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E6WfBc2088269
	for <linux-mmc@vger.kernel.org>; Wed, 14 Oct 2026 11:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nR/ijon+rHa9vEbSCj1pW479jS8KYiNuAqFs2gzfUdc=; b=RvMdUCLlldwO+tzO
	9bib1Vnywyje91Yi716mGMgy1YM+Xn9pduiK3OrKsXpSmXcs4s8fBEAmT84F4mRy
	8acPDtBpn2yovYksr1N7erSWy0gpefatXHSexbRNZsD/1azOSKHPIRmUdth/N59h
	Zfvr2fMZdjS/SXXlz032mh9XLmTLf0dy9U1iMdEGX0DG3lwzFPQN2Mi+AwbzNGSG
	Qae3SjQ9pmJ6Z3iT9MZR5SUMVqVB9fcKBuLP5YF/YfaQA4dU+aVUXCNfV4odejyz
	xEh3osAJv5MPW6C8ZxKA4j/yUz2GVqBGsGbQEcVHW3MSAOqF3fzIcKQJIMyswTeC
	g2XmgQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9x49jhwd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 14 Oct 2026 11:17:13 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3a4a0017549so6569486a91.3
        for <linux-mmc@vger.kernel.org>; Wed, 14 Oct 2026 04:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791976633; x=1792581433; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nR/ijon+rHa9vEbSCj1pW479jS8KYiNuAqFs2gzfUdc=;
        b=AkUOjvtNqhMVauwqqdt7AUtLdTEkKozJUfHRZjXA7dlnSo6WaDYu7VfLq/YMG9TlOo
         ipVIPcfXOhpHgU+7JIHPn2lVDLDFTNxBiiaq3kP4MahDkgmS/VaiDsswmvPidEaGP4gu
         uLZsH687XNoSNcdzZnA3JqqmBcm5OpTNEroVbWJ2dPmT1P3oqBJ7Ltl9+AecHsfo5tjy
         jzkxxZHKQlQYhM7wnBcnIHelLee7rEgM0oOfjrY5BfFAPzaIe4Wr2gX3e+QeIL5YXQLp
         BtMKqdlhdDaPy1rLzH1R3iMy7GNyXEH2KlpyaxVXpP3Tw8Rw5HcfIrWM7AOzYkzKsTRh
         9VXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791976633; x=1792581433;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nR/ijon+rHa9vEbSCj1pW479jS8KYiNuAqFs2gzfUdc=;
        b=VHg006gJU0GyIao5TEAyOIXMSu+lb3VK+XjtC5X8Ngv/WPcdFER0+sc5uO7NuSoGoZ
         AAhFs5/w7VRpkQqPyNzgiGJnsBTXvBz19UH7x/gSC7A8eutAT+DWAe71PDQq6Td2ks2l
         lRJnVlfn181lzaXPAi5bwQuvUthN3wkeTBlYa7GVrJ7VbOaHzaZeXm2zQU7MAX6UY6M9
         FGOGO+fEs8++UEHAxVzw3AAoOL4VFz9SWr0+XRtOgVu+SyhUG0PYHd1+RzI5MCYueON/
         QA+2BjEX7AQZt4I+JLGkJTRSd0+xZz+NKTNtqPPNRU39L7e1gx9+9RgVvKOKgk1hUJBQ
         OVZQ==
X-Forwarded-Encrypted: i=1; AKwUvBwwIcxmuhJXv4Q8ITCNgEpxPQp+nJKqaPjPR6h7cZLOyBEVAgWwjyfwZDxJLpLclrZ2mAcXKTZu/n4=@vger.kernel.org
X-Gm-Message-State: AFq9FYItdEEkl4TPQKfU68fmjgZqTbO2Ztm4/7gC/tWhdZRg40w5MAgI
	ND7llze6jXdQQCeFF5/JkNVWbZTydP2I7TE6LfYd1BNOHlgBZsqh9dG13YsZbGOS4pY1Scr2eKH
	K0oivDtmDtCCvG1Ml3kcEgpTPlsvj7HFL/79o3tS7lUiL1+MQYqvKVbYezLqhGn0=
X-Gm-Gg: AYBFou3jCTfmPQz+CJIJNbNefpJIq2GSoVjToGgx27HJRbbDrZahHxyeliXHloGCzg3
	JtNrVx4a2jCqEjZwBch6lszeyKtWGASJEPnFEqfKymMH5TUlv9QAzReGK2HiAyouNu/8lQBil6B
	aCWcETs7ZNeJuRYSkjcRAxf4iOvUzzE0O87Ie1qnacGDVrCEl0lzOTAOpylkiKZybd9LSrBHwuu
	ixfdkhxyPYHGaHVtAs5sk9HQMGNc/VaH9m4G1Ll2K9+y0qQIhVklJjWWMlN4mr0dzQDCsWqurki
	BcPxaVjuk8PJi/hfcY7NX9ZIO6WCE02EbG/XNRXbN4sIwDrHkJYB6ve0szeL6t/tl0lfRK5qigH
	5SUXbMJ7gAVURI3jgTbuzTDtziVTW73DIfnT5
X-Received: by 2002:a17:90b:3b82:b0:3ab:4f1:4f76 with SMTP id 98e67ed59e1d1-3ab3a94f426mr14359471a91.24.1791976633167;
        Wed, 14 Oct 2026 04:17:13 -0700 (PDT)
X-Received: by 2002:a17:90b:3b82:b0:3ab:4f1:4f76 with SMTP id 98e67ed59e1d1-3ab3a94f426mr14359445a91.24.1791976632686;
        Wed, 14 Oct 2026 04:17:12 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac6325e28dsm1962341a91.1.2026.10.14.04.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:17:11 -0700 (PDT)
Date: Wed, 14 Oct 2026 16:47:04 +0530
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v12 0/6] Enable ICE clock scaling
Message-ID: <as9ksJKk55wYuoOS@hu-arakshit-hyd.qualcomm.com>
References: <20260824-enable-ice-clock-scaling-v12-0-09271f583dc6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260824-enable-ice-clock-scaling-v12-0-09271f583dc6@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=YJcKWhGx c=1 sm=1 tr=0 ts=6acf64b9 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=yZ4vNV_xbO2V9HmvDQUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA0NCBTYWx0ZWRfX4QGnYCPZu9YX
 MC4gNvklcAuoEyFvXwQrRh6HnpiuiCUVl+6bVaBKKOJvJmkE56YSS0TNrH06s78kw8gmzbcE8s1
 HSLVtlIvtPElVl54btRoDvRr01rICEONk5RtwqsYLr87qn3J7k0xojzigapIeLd6UoV7ZJhXkfq
 upFlP2c050cFouVKs9dP5APy/u897lrGEsRBXpkPWZjeD+i4q8BIruTUASX5g02Usv/Rgav1KQC
 Z+ZfUcPMG/cgI8C3x8algCuBsjVikpJuDBPF232wHWXJppVDH6YKFmDdiyMJxf2DqjY4BnMZiJm
 qZJXLkeX60+kYZoJYUkPN/WiH1/zDLSYzkJA85U72cBCW2wMcYhF35B6uR1tZKPpWAyFm/GKEEp
 WmKcT5upk+KgcYcw+sF6Y6Raz4xvOGJUCjT6nW5TfzSvF5NBZAUMVjUzaqbpkk0rLIQbjD4EhaS
 me+Ei2s2D0WgLXzNA8w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA0NCBTYWx0ZWRfX8I+BNdt1J/py
 h5fiuDp4GrnPn4FxPtgm6bRRYfBDsA6WNxGCAqUP4PKT26iobnYScLhlUSNbgfye7M8UGP8HKtR
 CzXWGKgkVpVV4YkVLwtK58tBk6uogCg=
X-Proofpoint-GUID: JHB-w_SiqyPBXvEefc2LzRqf67HCtGk6
X-Proofpoint-ORIG-GUID: JHB-w_SiqyPBXvEefc2LzRqf67HCtGk6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140044

On Mon, Aug 24, 2026 at 01:17:37AM +0530, Abhinaba Rakshit wrote:
> Introduce support for dynamic clock scaling of the ICE (Inline Crypto Engine)
> using the OPP framework. During ICE device probe, the driver now attempts to
> parse an optional OPP table from the ICE-specific device tree node for 
> DVFS-aware operations. API qcom_ice_scale_clk is exposed by ICE driver
> and is invoked by UFS host controller driver in response to clock scaling
> requests, ensuring coordination between ICE and host controller.
> 
> For MMC controllers that do not support clock scaling, the ICE clock frequency
> is kept aligned with the MMC controller’s clock rate (TURBO) to ensure
> consistent operation.
> 
> Dynamic clock scaling based on OPP tables enables better power-performance
> trade-offs. By adjusting ICE clock frequencies according to workload and power
> constraints, the system can achieve higher throughput when needed and 
> reduce power consumption during idle or low-load conditions.
> 
> The OPP table remains optional, absence of the table will not cause
> probe failure. However, in the absence of an OPP table, ICE clocks will
> remain at their default rates, which may limit performance under
> high-load scenarios or prevent performance optimizations during idle periods.
> 

Konrad, can you please review all the patches in this patcheseries and let me know
if anything is pending?

Abhinaba Rakshit
