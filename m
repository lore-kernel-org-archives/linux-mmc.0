Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0F82FD1B5
	for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761214707; cv=none; b=BvqRGlXDTu8U09JHQUfV2aa07PyC5FRQvm8AK3PsH1YQTLkceItiF71s6s8qc36S1PytQz6q/JFOURgaR6Zd5ide7pX9zPvf48dftCkCBHbwCtWHpWbv8zpEALLhs7SzlQRB1wB7N+17/HjgJN0bDoBE1H0cDr8O+9zU45Soxjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761214707; c=relaxed/simple;
	bh=1RnLQ3v5S/1nsTAmNc4jlYHFj6K1Jk58trMvxEAtJEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXEknA7LyjeVIy34wZnLCFJqvromJESV4gmQx5RY4rPXDJNLUVpWy1lnxbr1sVhOdQjfvvBYXObh1L0ELRo7ykQ6JrgOL/E0jJs1NgPh0Ac4gvqK9qXPhNUu63xkjWIMPd9xQZCjCt8t1s59t/aUzqoDocHfQCUYE8S9dAVp3v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=blfamD2V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="blfamD2V"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7UBoo011813
	for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 10:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JXQvqOCIifU70x6E5l/eBJ77oOljySsiWz1sAln6OEo=; b=blfamD2V0K6KFvxb
	KtyyNqCrw1doC2aSK8SH3SNG9hRhDkw5nyy47f9wMKb9WOIVSGuOX6vw6ykhAdlP
	J0wmSOXouYECU6ax/zN2h1wGVNzrC05nt89moMyGJh4IpoTVesnP1jqfoMmhniL9
	3V/IQf17jSYCd6CKvTuXx9IB2Qj6RNmvlYM1vDxYsd9XXWQg1d9Qh35+gPxSaSwY
	wc8B+FjDPtlVX/8ULr8OIPjHHffYkGQWxwtxlBowSYDG38ufYFe9pnWX6Snn6CXH
	4+5m3a8cXw7ngeLRfhvwPEkzoConjWu1GgQr11/x6kvJWgIR2qbte0DODJDxr7zN
	2Botkg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y524a6fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 10:18:25 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2728a359f2aso2410405ad.3
        for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 03:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761214704; x=1761819504;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JXQvqOCIifU70x6E5l/eBJ77oOljySsiWz1sAln6OEo=;
        b=YTuf8oNQ3oCwMyipK8DodVQw5VW+HUdpYFY8GQ4Olg4qwZ6m6Wd9S5NxdVLc7pSVDA
         as4mp1BdIyfz0cBSsLCot5XDPBT3qw1CQateROUj1H8qr+VdJ0Cgv3hTD/4XIyrHyWHA
         u0AnhvCPF/LdZEh08ddOwvjc/AhqH4VhIl7XUXVllKx4WK0LFt615+lPpBOibJpRwjai
         i7DQAKLb2Hcuf7+e5pkoV0KDpX0nfWkpqMzChQVYgExWANDbAijqe+2MSP4Ty95X1OKK
         tUMErLo1CjUBfP9UmEwJ32vynNRzEME9lVGLJtQDvdsLdkaMsTvncYCR+lJsoZS23nuy
         Y7Zg==
X-Gm-Message-State: AOJu0YxRzVKW7NbYki8mx8ZwQMuIYIvypyLUqPtKFmWQSs5BGwM6LUUO
	BLmrWXGF68TwFKl1WFLC6pOLG+4Vo7rvmJE5wkdsVyJwp+j6idO4n5ClUtZRc++Eg9J4GYrvCOH
	nsNuzKxISDsYV701XI5h49C3arf6DyctT2QZLZ06kUIDMpzSBZIbJjSYVoWiRtA==
X-Gm-Gg: ASbGncunNJiBMvCaB5x0k/wcyHfb3L51CLu/yWwHyKvzMk63mGiggpOafZ2S/zBGhfe
	5F+6nizpLHf+2IjAO2CHmEnKUnD9PNGyc/YMa4MxV5VDU0RRbaAoXovlfivUealFVlwVdxk+npE
	0iDsl4TvXStho5AV1i+NKdJK41WnHBE7EpphJuEQlU/87eUhHYpEuk96x0TVTXPvSAoPoqb/U+X
	rOWXuA8KRVOhtz8JbE70Beux6Uuy3WOFG7sKZvY2zKpDQJ1TOkP9aqzljfHVqxSohxuygebiKpU
	TVRq2X2C5pVbwMzJMpQ/O4SzsqqPDqAa73SLVgzBImHvHM3jzfJeyvbvwTG7ke20dpFbxR4WP4e
	LrSesgFiJwGhT1fjjM2jBXHU9sjv/
X-Received: by 2002:a17:903:8c8:b0:277:c230:bfca with SMTP id d9443c01a7336-292d3e57324mr66629665ad.4.1761214704430;
        Thu, 23 Oct 2025 03:18:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTvHNcr2Q4NEwC8d4MLm5CmnKWQFx1aJoWBr0IhgqiAMI6t5IKZWuVUChlyP0voh0nbGgtMg==
X-Received: by 2002:a17:903:8c8:b0:277:c230:bfca with SMTP id d9443c01a7336-292d3e57324mr66629485ad.4.1761214703961;
        Thu, 23 Oct 2025 03:18:23 -0700 (PDT)
Received: from [10.217.216.168] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946de10b53sm18460375ad.23.2025.10.23.03.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 03:18:23 -0700 (PDT)
Message-ID: <c83d3438-2baa-4c93-b8cb-5109d2ad84a3@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 15:48:17 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/3] arm64: dts: qcom: sm8750: Add SDC2 nodes for
 sm8750 soc
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com
References: <20251007054445.4096630-1-sarthak.garg@oss.qualcomm.com>
 <20251007054445.4096630-3-sarthak.garg@oss.qualcomm.com>
 <d0e2b0e3-4e32-4cff-81c8-fe943084c570@oss.qualcomm.com>
Content-Language: en-US
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
In-Reply-To: <d0e2b0e3-4e32-4cff-81c8-fe943084c570@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE1NSBTYWx0ZWRfXznh6wBO6yl/w
 8eotz5nm0JZ0UyxWsKduY+9aVPeNZ0OBBvUri0IvZYiQ/YYCMa+pMMKWHSDijCrhJe2oVvvhee2
 18JNFbQatuJ29DJOgN64/HKvB3n88zMQPWYrUQBrOULGmXIZc9WBdtuC5OCSKinERoPdxuHIg3A
 D4JmjGf28XKV/zk6ZqSmckis6D2IPDsVnB66x1mUlpTo5TTvjcjFbBKpvXM9YsGLqVU85H/IIpW
 N51QGN5yDfs4kRV62fEPYBBnwVpWQOm/nbAq1nJrBAcZW0yiIeClHTeq3ucVzu+3aXKWzAYx2cu
 G2fEkvglGlCktZhn3sePaze+2E5l1Uq+YC/DtZBj19sIgtrN8D578Ly4NmzcHt7xCywBO85rFM9
 dshlvC0pm/o+eShwdIPAdjmIlR1DrA==
X-Authority-Analysis: v=2.4 cv=Uotu9uwB c=1 sm=1 tr=0 ts=68fa00f1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=DMDGrHW2khae0FuLqQAA:9 a=hK1Zo0tywebNB7qn:21
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: KXDeMWGWkyFt_kDDTyemuxdcpHZKg2Mz
X-Proofpoint-ORIG-GUID: KXDeMWGWkyFt_kDDTyemuxdcpHZKg2Mz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220155


On 10/8/2025 5:47 PM, Konrad Dybcio wrote:
> On 10/7/25 7:44 AM, Sarthak Garg wrote:
>> Add SD Card host controller for sm8750 soc.
>>
>> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
>> ---
> [...]
>
>> +		sdhc_2: mmc@8804000 {
>> +			compatible = "qcom,sm8750-sdhci", "qcom,sdhci-msm-v5";
>> +			reg = <0 0x08804000 0 0x1000>;
>> +
>> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "hc_irq", "pwr_irq";
> One a line, please
Sure will update it in V2.
>> +
>> +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
>> +				<&gcc GCC_SDCC2_APPS_CLK>,
>> +				<&rpmhcc RPMH_CXO_CLK>;
> Please align the '<'s
Sure will update it in V2.
>> +			clock-names = "iface", "core", "xo";
> One a line, please

Sure will update it in V2.

>> +
>> +			interconnects = <&aggre2_noc MASTER_SDCC_2 QCOM_ICC_TAG_ALWAYS
>> +					&mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
>> +					&config_noc SLAVE_SDCC_2 QCOM_ICC_TAG_ACTIVE_ONLY>;
>> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
> and here
Sure will update it in V2.
>
>> +
>> +			power-domains = <&rpmhpd RPMHPD_CX>;
>> +			operating-points-v2 = <&sdhc2_opp_table>;
>> +
>> +			qcom,dll-config = <0x0007442c>;
>> +			qcom,ddr-config = <0x80040868>;
>> +
>> +			iommus = <&apps_smmu 0x540 0x0>;
>> +			dma-coherent;
>> +
>> +			bus-width = <4>;
>> +			max-sd-hs-hz = <37500000>;
>> +
>> +			resets = <&gcc GCC_SDCC2_BCR>;
>> +			status = "disabled";
> A \n before 'status' is customary
Sure will update it in V2.
>
>> +
>> +			sdhc2_opp_table: opp-table {
>> +				compatible = "operating-points-v2";
>> +
>> +				opp-100000000 {
>> +					opp-hz = /bits/ 64 <100000000>;
>> +					required-opps = <&rpmhpd_opp_low_svs>;
>> +				};
>> +
>> +				opp-202000000 {
>> +					opp-hz = /bits/ 64 <202000000>;
>> +					required-opps = <&rpmhpd_opp_nom>;
> This can work at SVS_L1
>
> Konrad

Sure will update to rpmhpd_opp_svs_l1 in V2.


Regards,
Sarthak

