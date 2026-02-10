Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7178633CE82
	for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770715970; cv=none; b=nXx6t+HQR58KoM40gRKe9dmBFiXrdVtLP4BKepKH6KJa1JwdAHH2OiwVUtmnDBaM/D38ieH2rTUafRAwU0ShTIdRShjM5Ye/IfxOieXe7XwmVIos0g0uT9F7Dh4O7DuA0uIxVHcPWdiRNKtVYS//ixEdcur64K++y+ONrnnnK+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770715970; c=relaxed/simple;
	bh=lYXkrcgF/gfCqHIjWikYj3wuxE8pK3C+vUdP+nhK84M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OTgh4xpQ+rEkT3gjbUJyxS8xq2n46SiZG8whTYdefmd3UmCpdc0eq9hTCCJYYHMvssqrQ1x4xcV8CuijK3nC30xymuV1Oq4XpI8UY9tFoQqEIoVwde0t/hRj8Ct62pURzlF38TGvBCyvcTNqqCrIEQtVZm3t0hpxFzQlNIf7Pzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gyN0gdRF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YdEpLmsA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gyN0gdRF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YdEpLmsA"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A3vYUC1172329
	for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 09:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rLgXJquVUyBesXKA8dBPnaFYAdLbpSuCrTyxZs6wRLQ=; b=gyN0gdRFUJ97s+ng
	w9doHsRyEqEf4htP5kOOfdDEkdnknJuhCgyZofYt3++5xG6Q2jj+j80gvIrXZXq7
	rIGMjNBgpOy8+qvhQgro+ixrsVEdGl6ypCUHzgLTqBXvlmMV6JFqr3H+YYUFpKhc
	XpzWvOy1t+q3Pi34ZcxXG5ZTPwpCVPW3UntEPew9+94OHzMQ+1IB4P0U2UcilQ+r
	AOhWY7sX/DOyNWmZ9U067LepU7sqIUhxVLjBiUkhqABGxIUriGFKhN9yW2dO7Jbi
	c2tYVWDQw60hbqFST2xrQEGMlUmq2PI66KzRdyxQDtqBepaFU1klhTEE525WgIR7
	BGn/uw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7kftu06j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 09:32:48 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c53892a195so102985885a.3
        for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 01:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770715968; x=1771320768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rLgXJquVUyBesXKA8dBPnaFYAdLbpSuCrTyxZs6wRLQ=;
        b=YdEpLmsALwtK6Pa72IecphXXMk4NG/g9EeFodmwCoRne0USv7T8S/0ZrlwnXtdLRb8
         eWrKxCfpYFZSw6Lc5XI8ljOTOK+JkOCZh5Spyb4Sm58jeXn6GimUGrDSHslF4amjxRy8
         Skz8+XMYcYNkLQ8Odc2aolxnqg2uTY1AodPL0Vadf0yMs1+c35OGNwW1YILT1+KkrRCz
         vCoqizHUumiXo1zkt8ah3b4r1G4DBAaIxyLqXkgBCRUze/WNiHmuzmKRrjLvSnvxFb5Y
         E4/Dkcqo2Oe74/oIOIy8Onk8Fuq2hA6PJnRQvXKxatvQuwCDa7JkMJHV3eNunEajVx76
         Nw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770715968; x=1771320768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLgXJquVUyBesXKA8dBPnaFYAdLbpSuCrTyxZs6wRLQ=;
        b=IHBUr3qYTN2aqcaajW4Dr9Aw9PYvNrM7NpWM6E+TC/HkwDvbMO1sjo0qpyOUqhaDvB
         ASaSziu67ROel5SDBgzfMmBLVcBK4kkBj6KuVLBhj2FxOWbSvyqeDblmOiKH4AcqM1GK
         31opPfktfR//PBL8xx0kPoWvfeamApELySmo7T7e9zZD1NibSsLF8Sa2hp2iV78fUNlo
         ddRFlgwIYrdPF1HWr08qakVCRXFPxzqAElpGJQp6xMuJDidX7mRRWRfxnyrPlSGIqZAL
         m3bIkiAKbzcP4zsqHueQyNNDI+VlMWurjSHPXTWsiCju3GE4e5YVmyuxbukqRliqytmQ
         vr6A==
X-Forwarded-Encrypted: i=1; AJvYcCXlUEaWPftCZhq7Ovix8qkamcGJ3ymD/f1fVRMOk1SfO1ARX7x7MNgGxc7U85T0Bau6PHYVPbXVNEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoOOHgb/OMeqQV2Ahqt+uko2tVLpD85qATw82FAwLeLxuZiBmS
	1xVEPozYE07vWlBT/SsxABxLo8ltJfm5Rfnw5RxMYhrFkY1U0YUBqZFtlxEGdOgWYt3aevEWcV6
	O9bk2oJLEk9aetiOvlj132CrSOWgovr9M4bBqCV/8RJT3JdBxgGvYIPS/DYBItus=
X-Gm-Gg: AZuq6aI6TU9d7FkGLishhug/JIHZV+uBJfs+JJgR0RdciD7xy8l5F81BZyi15AVnSfM
	imRwjvzg0NOTto+47ZayviAhJmrf1k8xc1Djds8yCP4N0Ityrp9N7B3JN7NZi5hv2MkyYCBxBmT
	bbWXEdfcqQvzUmcQh5b8OWe6P2y5QrEElawVp1PJagX8ShUTNoEaaowb8yqpdvZktxFr68NMduj
	JTcPn+S+w2hncViaP3nge+3bMYx0EzrD+ts8EGg3YARnnbDeF/JMnFxmMEU5wWZ16yYiP6bpgNG
	kBb3PrOWBFUlHqeyRaEkkJN9W6hJib4Bhk6Ng6g7EZM39CafZfZ2Ge7vH1sXAb2uS1DiZOdoeOH
	PMhI8zj60EeUQRkgxyTboJ+RWvchkXE+OOGDvSLw8gHQsNzD9kP3FwoLych2umHgGFQEHOlqGS7
	MApBc=
X-Received: by 2002:a05:620a:1a20:b0:8c9:ea8e:c55a with SMTP id af79cd13be357-8cb1fed996bmr108851885a.3.1770715967945;
        Tue, 10 Feb 2026 01:32:47 -0800 (PST)
X-Received: by 2002:a05:620a:1a20:b0:8c9:ea8e:c55a with SMTP id af79cd13be357-8cb1fed996bmr108849485a.3.1770715967474;
        Tue, 10 Feb 2026 01:32:47 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8edacb18aesm499346866b.41.2026.02.10.01.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 01:32:46 -0800 (PST)
Message-ID: <15b87c55-9dbe-4a49-b166-498908f174bc@oss.qualcomm.com>
Date: Tue, 10 Feb 2026 10:32:43 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] mmc: sdhci-msm: Remove NULL check from
 devm_of_qcom_ice_get()
To: manivannan.sadhasivam@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson
 <ulf.hansson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260210-qcom-ice-fix-v2-0-9c1ab5d6502c@oss.qualcomm.com>
 <20260210-qcom-ice-fix-v2-3-9c1ab5d6502c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260210-qcom-ice-fix-v2-3-9c1ab5d6502c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA3OSBTYWx0ZWRfX6OAK7C0qafup
 6ZYSj1JRSAZrvf4TH4GgM/YTm/kNsB4qKBEN0Hx/nTy3WtGVG1hRErfGOPmngmPzGTrmaWdk9GI
 Ysu4XB7rKUU/VQMoE3LtpIsQ+kPYpEeEAnu6ycvg92AqLAMIWgtLNY/rk0JnR5vvqERfhyCI6TS
 zu7qpWODTQFKImmAJnFVrMJiH30eP74SAe+AcwCd9dcbToR4yqWwFc1xLdDQZe98IOqa0pDN6R0
 N4l3ehB2/YlZ44Ff+8REczAzgF5VKzHNM9XX6/5dpAwbCMvXLs3yfz8Y8DpwdBtZqLc/K7lBvU+
 ZGdEXf3KQ8fM/SIhcq+cqm6HU7N2sBmT/4f3kzGLMYH1Z7mc9xEKF9Q88tZRcrLeeC1Hx64591X
 xIO7R+qrI7Cp0PDVzsCxN7O9TeXxJlaF5e5AhDxLJN5oSSEK8n6fIByy7nL1L4dQrxQ7LvHgEuu
 nqeAmkcj7x1w135+mlQ==
X-Proofpoint-ORIG-GUID: jpk7S6PlRRhG7Fmhvb30kIESovsw1GuC
X-Authority-Analysis: v=2.4 cv=XfuEDY55 c=1 sm=1 tr=0 ts=698afb40 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=AC2hTCgHVLFjDka4hzMA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: jpk7S6PlRRhG7Fmhvb30kIESovsw1GuC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100079

On 2/10/26 7:56 AM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Now since the devm_of_qcom_ice_get() API never returns NULL, remove the
> NULL check and also simplify the error handling.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
