Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF5D340A6F
	for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770715943; cv=none; b=Zhaue5ia5y0BmblFgfGDpO2APuwU+wSedCN9GKyQgfgPYZD9psflunim5fA66LO6qYokTwEiylR4ofbRnXPXShKvyJ1YcwIy29ryPI559DvL0TA7U9LQu5u5AbXautsMGIrAISuzMThsmCb1P6mctAEjOHpGLwbNH2WFMgRaRw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770715943; c=relaxed/simple;
	bh=fmc7AiyBkTqnaea8LVR0pJCHhVnmR0CdWnSQqss2KiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTiXHh64NlyyKKljYVRzwVGfrsFIeMQ+kd8XkA4az5vWOQADdtmLj5r6gKb3CCUTaqJlLkRceRx/SS/C1bqMzc8ZzQ+fheQWJoaSuO517I621JecAhI3r9lx+t2FcAswI4+S4V2QGLGmiqY9Jx3FzvGAvva8JJYdkgTd2fwmTwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KdUDAqZa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V925xCqL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KdUDAqZa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V925xCqL"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A773hf1151816
	for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 09:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q0odEq89IVS+nnV/Xemci8oKH5h9bGTzCaaca+V1t7E=; b=KdUDAqZahMHQY2rW
	CevKoLyzXcKoXP7sE6rtiw5lQlB4g3U+7u3RL04UYt6luj9aNLMzw3fXJw8jFUSq
	Lo0HA/bOAhHZaE0QFQH94ugIFUAV1sAE19XYq1lv817PmBe345DMe9lBOtVRZ1ZS
	cFSW0qbABf65bsAB9g7VTu/GIbs1fx6nFjHAgOYkZyIXkKCH0r0Gs+Zn/rHwnIIN
	Qha5Xw4U9ntEO2Rel/rzkciV+FdbMrSuNiCzIlSX++E42YBa0NUtIS44ALkKJ9zk
	zI1QKVJwnrpQ+bqemIVlKJhnuTUDUaDknEAan1KkWe6vNMJah9p81OHhvGsao53w
	6a79qA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c800j8heh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 09:32:21 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c53892a195so102978185a.3
        for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 01:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770715940; x=1771320740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q0odEq89IVS+nnV/Xemci8oKH5h9bGTzCaaca+V1t7E=;
        b=V925xCqLPpDB8EGkDqFK0OnmBkF2+hV2+M9iszZmU+mFx5N9N45ISvy8c9E+hTkt7Q
         ngBuov/rgrpnI7El+/2OvgRngrKSDmv+h4YuvDmmSzcwD0208O9vsVyrKWaIhJWx0TlC
         InYSEL7plgfxcco1sU6KPW1t/e/fZmA74AwVtcrIQBHB3BV3az8yHEyBlaLVBDomxOmm
         zHV5cwBT1g/+vkLvrRGocTZPKpl4U4YH+QRMzEBKASuG3t9HDc0cZfoa5dInixtdyqKn
         iv1Nxh2M7CUxItUpvl1RsTETvbo7vLfgYzzbpfr+7Cz08GNimOzVsodpKeO1eNRGEnm8
         SXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770715940; x=1771320740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0odEq89IVS+nnV/Xemci8oKH5h9bGTzCaaca+V1t7E=;
        b=ClvIvyhtVTfjekVu55BlLo2w8gp+HVJpr9onRaN8kZkLtAXemF9j33z/2cLq9+09AK
         Pym+KAYm6A87Kh6lCZQUZeTubUYYn4GsHORKrbwEG3pFZppy4tlf+qgocABaqoA3n6KP
         T1ElIDnA2H9l8Ltjxg76kD3VBe4XXrVpfXI0kS+A+2RvxNDsslDPPjFjiBejBzRIAT8i
         3HKZ2ViN0G3EVnxjLGqUTm8+HGiOpiD2pT6J9UE8dcUvj0d4Hpo1DALwcDcemmbSOEdp
         0C1kbnhrNcE9o13MPQRswgxfTO1U91/XOhEz2CdJZz+gmpqBK79lFTcuwOlD+eFHqxwg
         QY0A==
X-Forwarded-Encrypted: i=1; AJvYcCV385Rg7SWGGlNH0JFnHeV7p1su6PDaB0GCJSaB1n0z70luNlmA0gUCaHmC0sviLBbnAkExxwTFYd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT5u8umFwtr1GdnmuiC+9T3V70je1Aw7N4xsTZIsc0D7hWdOcm
	SEpgZOxUpOZk/umUbtYVzPHTR1O6zeut4FIwqnvGvTVrUqXesObZ1QZfr6zBMR6txWc26e1ou5k
	8Xk6FskIuPZ8Kh6F+MeAzDIGFBxmDMqdcezxBAEO7X2OHgE+7Wq8dbJh6qW7rfrMFXccM+gM=
X-Gm-Gg: AZuq6aL+OPqI8L5sKKf9+hwA/71MqT6wJ/pwqqOP3dMm68dP2CmxeHibHUvBkvlnFWI
	a35qWirgev3X0bORuMtQbiCXO9Az/RfHpVV4USZ0KA6yV6jGJGrhxXgR9oYbyOmMcJPU2gnk+fH
	LMjwa6qr0U5EXvTCNvkc/E7hz/K20S7wG3EdQo0+eek9buxCo150DK5NmTHYtuIklYlXutPwuWO
	ZU0lvb9NboVX5AIuKtIkcoDuh92ijmySZU+mNGs9fgt/yUrR7wGOLKZyOdU8EjFNmZsNmGuB+3q
	KynQocKt/zr9hO4H8BJ8Zc3bRGb6avkfhuuqMKecVZAZrmafjgOcmpis/4g6VOS57dpP5kOyPnW
	t6ZOf+ao/yMNrFT8T/x9jPud31zS9gcp0p7+PHupC6R0w4KRhh7Mfnh7BvZ3jN9nVPPFOgUkIR3
	g5Nx0=
X-Received: by 2002:a05:620a:468d:b0:8c6:f7ad:49b with SMTP id af79cd13be357-8cb1fef263cmr106554685a.5.1770715940398;
        Tue, 10 Feb 2026 01:32:20 -0800 (PST)
X-Received: by 2002:a05:620a:468d:b0:8c6:f7ad:49b with SMTP id af79cd13be357-8cb1fef263cmr106553285a.5.1770715939925;
        Tue, 10 Feb 2026 01:32:19 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8edacb18d0sm490923266b.40.2026.02.10.01.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 01:32:19 -0800 (PST)
Message-ID: <32314fd0-3d15-49eb-a0f2-d029728d8d00@oss.qualcomm.com>
Date: Tue, 10 Feb 2026 10:32:16 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] soc: qcom: ice: Return proper error codes from
 devm_of_qcom_ice_get() instead of NULL
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
 <20260210-qcom-ice-fix-v2-2-9c1ab5d6502c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260210-qcom-ice-fix-v2-2-9c1ab5d6502c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA3OSBTYWx0ZWRfXyrYojY9KScW/
 yDVi6hz6qInp8u+aNhdwz5eoPBL9wX0Ks3nTmZeintneCZqNXN/adkpT4CfJbqPb2BJyEl7vcJH
 QM5/Xuv7LFuAq3jVp4ujxNmmVzHi9YvuqDoDj72hduHlfnSB8k1X71XndoQFVq289CGNbjkYjdT
 B2RVPpplIMWF3+QPq4xUXpzoVzXQlq/zhs1zk+hARdKrp1vdJMIhbz0uc77TsV1Axa2MjUoEVYy
 5FFaMEc4aSc/2FZAeh5+cIxmWUd/vixm7xjco0K1JqHwYEARoDyClpqUdfFMhs0ptbG3QSlUj5h
 ylgiewVkfO5hWsj0IbHqPDRNQjcq3rYfyxK/lZf1QakIQPiSYBPU3Hxx8TxEm5kFj0w9YJhxuea
 k+RtnWVPSFR+F++41ix1zOq6osoUNNgcnif1xflml5uil//fuePc6+zF8uOkt0PHjbIhoBDnOba
 wsCFLKXwxoQOjsYDzYQ==
X-Proofpoint-GUID: dt17lUvepkQp4jKl4D7jpEuSdsXMS3ia
X-Proofpoint-ORIG-GUID: dt17lUvepkQp4jKl4D7jpEuSdsXMS3ia
X-Authority-Analysis: v=2.4 cv=b9u/I9Gx c=1 sm=1 tr=0 ts=698afb25 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=AC2hTCgHVLFjDka4hzMA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100079

On 2/10/26 7:56 AM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> devm_of_qcom_ice_get() currently returns NULL if ICE SCM is not available or
> "qcom,ice" property is not found in DT. But this confuses the clients since
> NULL doesn't convey the reason for failure. So return proper error codes
> instead of NULL.
> 
> Reported-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
