Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D82283FD9
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827829; cv=none; b=KEwMpefdNOauW8UsTWzXg/oBQTxA5PwanX/CfUC4MTVDkCdpJQ6Vtn/quEI2cmflN8B7gsfLbSo6VizAy3GH9pCuBcq2t2d1aqswJCpvPRlJOYlKbL+Q7JXh3wkkorXrEdcmFtjI4FoggYCtTUk4c156wvnKlOlN4CWJIWOEGlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827829; c=relaxed/simple;
	bh=d1Xt+LCSeLsvO5aRhd4vU+y91sKUruPMlkg+Ebm4BfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HElIMl1wnOc0+r6leSb3le2ZP+5OEK49fCfXql4BFKixHu+R4sFuUgtYyUwWYn7FWe+ls+cgZHFL+2XlOm1nLJfF09qenTkM8j7HLPPK57vhC+cTvYAa4TQHuCYuNrVja2GjgVDCrn78MC2LDUhO2xcViJnMn/71KmI2CKpH/B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NJFmWDeD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X/EQEN05; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NJFmWDeD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X/EQEN05"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9mtr31522275
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 13:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5xGf3q1sMxp7hVytKtAfTiomXRp8edhMsYCsyjla46c=; b=NJFmWDeDxxzpzIQr
	JZzizpdOC7LqG5EH9JFXsTxreNVt7jo3OIMI1OZHLMeg8/dCwv048IMAMygxVOyd
	nOU9sWQwFQtTHnoeTU1qgkn4y86o87eiPmSFY1h7XeSY8PCv/U5xdPi6QA7epDH3
	UBWdWJQDcraiRDd5j8h1fgTuv/1TMZ0bWPmDVojKkBoeC3c6A+xYGq0J3KYc8xsn
	pDSbpBeRiFm9v+5y6nfjgzJ9I3LAraawRoyWGaZGmpnuVvyJ46qIkwO5wmhQx/6T
	zi41Lmp+esNCxEwXhQKQA9ByEa67bCo9OonnvvXq+DpCpfsXyls6CTcnoEcAoG8N
	uCVkNg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3yw93q2v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 13:57:07 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e6b97afe7so12452785a.2
        for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 06:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782827827; x=1783432627; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5xGf3q1sMxp7hVytKtAfTiomXRp8edhMsYCsyjla46c=;
        b=X/EQEN05dudiQ7gN5BPLHIUkbUKbwWE/PBmvL5xJ3OhUxKstrynRbBoXzQyRZwLHTQ
         1xQzVm9WGyu3E5e0ac9Z1yqjqnV8veTrrbaJWzKOSdPEAg3wa4AE1FHoKmz/k3bgHHpN
         qG/v0r29pKRzdl0/NIJiEbRwb/ISAAPV/iwKIRAmzx7RiKVpj76QoOCRxY4KSbIM7Nw4
         4OqNg9kYnilsES5XpVtrrYHv8U8DkZj+kaME4K8EEvDkacAsw/viRDYmzX9apWkF4gGk
         ZuySGII9gebb0GaO2EY6InOXNnSi/FWl5Ep7ewpLItgNMOQ0KkMNIXIxcBbbpP7Dv5mH
         s/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782827827; x=1783432627;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5xGf3q1sMxp7hVytKtAfTiomXRp8edhMsYCsyjla46c=;
        b=tQPBa0tnJZb3/jdGwi4FLbYFy9dIPsR3padKOk5Wxbw9XUsh5Ra8YgYGvHAcVaTJn1
         iqRTnZhTdzJ0ps4hQnwV2egemiVVrj2eRMNwKswo/m3RpE6gJct0Ralt+A1n/nFe7pPq
         4myLx+GVLDhaSLq5/fVWHmsso+M8qR0AT878AZMMJamE7WBTnxE2iDITmF84FTwqQAMD
         amXJEy/pJUpFfPNG/PrAcy/+wm9Vn6pW6BM8j5i6gaF/NjB9aQhcDDF0xqvhM4Un0TqU
         TgSJNccjU14b2OWt6ik+4xxFAtXPqqi2KIOXkI6Qm1dO6ypfeEiWMTBURjW2zvyRu6R+
         ClwA==
X-Forwarded-Encrypted: i=1; AFNElJ/mvAO0ap7qtEAeixV7MTHyCWfTf2wsfZvkIxqxl+5hx0n/smCqkmtFBJmkLynfqzjT4fHWYDrvNMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPIWApUo1QlEFq675/6b31Ip6/bQRD6hnqtRPbMBWHYg3oqS8t
	MI00Oc9qm7ev0gtVQcCpVT5h045rNSWhJGO/LUeojS0YD/zaZ9esAabaaxbMEU9udHjoBWf7uDz
	cQxvP0zu1zQ7mbTvpgyoOLPksN/xkaGU6y2PLtxvcpQLZvCLhhhql2c6W/0wfn8Y=
X-Gm-Gg: AfdE7cnDx2MGC1PLiA3Iab/P+MRFkPymzO5EPBdvXLT228HGYD7Qtiq6SOjvHp51T2L
	pf0vk/xmlza/VdBoSmlLnAgE00LRY4jf6BXQxlKIQMv9MCgw4ORpq2GM0dgwTchRI5hshng/hLc
	FuoXExjZJuMgWxVT8QZB+UwRb07NEeRYWLPjfdbYY6OAPe2Wqpjh66xafcseo8dEzsqcgo2iFaD
	/xIokTYC9yd+29nin+vggjph4AMmNHKCvNkFKVEyah032ZkGlunmzlb6rKSzbR/ZDz5ojQaK8b2
	uCIuTa33Vc+46NTGp/Xi2NTwOnjykfbPgZoG4iMa01GUSYEWIURTB+WLQg054zjABe3ddsiDE5X
	rs+xKB0EG+SbmvwzYNFTE3o1gWDUERKdG7GM=
X-Received: by 2002:a05:620a:4710:b0:92c:b769:ad1f with SMTP id af79cd13be357-92e62adf8d9mr360895485a.6.1782827827030;
        Tue, 30 Jun 2026 06:57:07 -0700 (PDT)
X-Received: by 2002:a05:620a:4710:b0:92c:b769:ad1f with SMTP id af79cd13be357-92e62adf8d9mr360892385a.6.1782827826465;
        Tue, 30 Jun 2026 06:57:06 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288b082e7sm133823666b.0.2026.06.30.06.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 06:57:05 -0700 (PDT)
Message-ID: <53a2a17d-8400-42fe-bac2-6af997b5ebf5@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 15:57:02 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] arm64: dts: qcom: Add Shikra CQ2390M SoM platform
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, monish.chunara@oss.qualcomm.com,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260612-shikra-dt-v6-0-6b6cb58db477@oss.qualcomm.com>
 <20260612-shikra-dt-v6-3-6b6cb58db477@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260612-shikra-dt-v6-3-6b6cb58db477@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzMCBTYWx0ZWRfX9V0LbE6/vlH/
 wAo8QSHrLcsRJTAxwqaeiL5irNwE1TkEJlq93sNVyO7ekg4ETd/wUy5/yEdIiaM3RsYROoXZeu+
 wJUwIZpzqxzOUavNSmnwaLo+LGPVnvs=
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a43cb33 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=djcwQD5uGQ3GNs8by1sA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 4K5iodyfslprRBxkloKLp5IeCD0-xFpt
X-Proofpoint-ORIG-GUID: 4K5iodyfslprRBxkloKLp5IeCD0-xFpt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzMCBTYWx0ZWRfX5cv9+KNdZnKq
 0IOxCeAbKrx93G/dLV6oUz9AjSb7eGWStJDNm/04wWfy7E8Qqvn/qqm1Ag4J44+SU3UWx3qM7o0
 q23HJ69ZnrPSO72XglzsYBP9OgLsVxIxFlwGJr7XgaCXrBHaneYpoOvijXrSAbK6cgKZ/cl06Za
 4W6g1qurtRz8+uOxFKJftKjrUadA5p4jaUmNK8yeM4SrBdG7hKtQ6FhiVZzqhsfpuOqZtihy/i+
 aH5SgADsDqRDiQcEkirmW5q6xnAryiQGCiFKpJnHeNJvJO8Z2Jg/0HCLr9oJ2trLjA0bP7ZEVDh
 qpKTUS7bTfZST6HR56d184UYJ5qot4v3zeMU5xjGaiutGC1Y29y10yrJqxc6kpbv4eRut7dPwkY
 LiZa2D0/uMxzUN3ZVp4kNGLfrSOYHJNWQ1MUtfraIQexcbmGs54vKFLULBTBXjldkISVNzJjGJm
 woUhOZWiCpjyUrWHMHg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300130

On 6/12/26 7:27 PM, Komal Bajaj wrote:
> Add device tree include for the CQ2390M variant of the Shikra
> System-on-Module, a compact compute module integrating the Shikra SoC
> and PMIC for IoT applications, designed to mount on carrier boards.
> 
>   - shikra-cqm-som.dtsi: Retail SoM with modem (PM4125 and PM8005 PMIC)
> 
> The DTSI includes the common shikra.dtsi, adds PM4125 and PM8005 PMIC
> peripheral definitions specific to this variant. Since PM8005 regulators
> are controlled by rpmpd, so disabling the pm8005 regulators.
> 
> Co-developed-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
