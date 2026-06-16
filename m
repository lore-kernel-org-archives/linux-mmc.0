Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA32438FF3
	for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2026 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781611294; cv=none; b=dClIswrlZVzxyP6GuIGE5FgWpXRbxzxi0FQshpF00DHnacKmj0Get+HCQP7K+KkqssQjBNyiT4hAVX47xaRBj6QvC00+RGRvf3GHEyJ4KRJsphO0fLrxfKUyI/O82qXRfotatTdEmQyFw/GS26trHK1vI5kSH6FRXGIkk8ykJxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781611294; c=relaxed/simple;
	bh=hynp6thCVYAmrL6SqdYPRJ7dHOMNvaccD5sK5f6y0wA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlUgXIMUqDn6fBlciv0iqyJ0eVFKDYUX1vdsbEJe+wCM4BdwKYFxtrWR9P1YNbd9B79ZKN4SKAXGgmImK/kk3bmn93vq2lL+N/WXA+5t9RM1yVKABnLwAceqxcbAOpsisQK93X3ybk7UIWioZQ36WYulRykLzpN5sK3nJ8LUfHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N4pWvAlL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IGRSs0c0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N4pWvAlL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IGRSs0c0"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GA9KxG2914553
	for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2026 12:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7JlxpDVrPhg2ZsWuRW7hsIZHghtGrPTfnyImlkmRxEU=; b=N4pWvAlL7Eq5FdBW
	D2OVPhhhgJ7AAWanktjR2Bgwofm/NadGLvpwoSCeFZhwW69aseJi2WK4hANEM1MU
	9lru7heSSoQCq1+j3NXBNAp8hnaR0zS1hwlhwi+YbYLsWYTtskYqG5KzE8UdqY2H
	3FcqidsPJbIAT/n8bBDA5CqYFw0rK2Osi2i5+vGm4tt8iCd0tO5AqBADJoI+VM5s
	WrhPkXKCgjAZvHhXrcq4Y9qNbzc7Kv1LWm4L9vKvljkggQqoTytrZnKOTbl7r/o6
	TfNEkrjAxxl6dd4Jo3q5AEe/gHdCiVTEYBonGRU0FGhYFFbICchGjk+fPMNecLcO
	7Mz2LA==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1761bm2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2026 12:01:32 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e6fe5ab3b0so748042a34.0
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2026 05:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781611291; x=1782216091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7JlxpDVrPhg2ZsWuRW7hsIZHghtGrPTfnyImlkmRxEU=;
        b=IGRSs0c0PwMEhV6QDFO+JearF7RvOWStPKnw8dVPVwpoyEUG3W8CgCTHfbEPmPTigx
         +ivQQhXotTqhqZQLvchO4j9cpfHCvJd/qtrzqZEx2WtnBl7FZmRHkdtakptS+WgFcgBn
         EGLkzHcjCzVqCxioHi+jjPPPGENCRt9wzdwGVgG+EObOnoQ5zArP2nt5PoA09EnQ1GSP
         APuxZ71/9V5arwOD6vZpJommidyb/f7lMwPwSD7DZKme3lyhbnhA6+rn01jzAtx1Kvak
         uyWNBtNeGg9XBYxlp7/FcshQ9l9l390Hrx09ZTYYvxeLwsdH1Sico4A9xpmhr2KVw76d
         LNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781611291; x=1782216091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7JlxpDVrPhg2ZsWuRW7hsIZHghtGrPTfnyImlkmRxEU=;
        b=L+bWCuLYyvBebB8fqrCp7U98uYP4Q4lsAGBNaiVMGkHYaeUR+S0oo2y7bUzm6PBMGB
         olfSWxj9Sd3G7AqhmYUKhXgzjE7SDrEgT953zikLWn5comuVQXhTx2c2B2lFSHxiLXKS
         eJCwpHoY2OB2lkUcmZxddc9/Ws7lG3lrIKG7J3Yd0oPSmjP0S2cHGVS6fydS+A/d3R6c
         9rOZb2P5Xy9Fi6jSNio8DYnzX6SfzqwqhdSIvsruf5qBO7E3mcRqlMha/F+PRGwFLO3T
         b2RJ7R9bWZgYr0s4uRDvq2qZgRLWzKsFZJ++LxthD9CS1DuQoKDJ65wXH/8axrZLBGxN
         LzaQ==
X-Forwarded-Encrypted: i=1; AFNElJ9JrzYA6UPTUVPPMg737sXGmaKJxfwMiuhl0R7kZF3CsPHaS2cokGx01RV5wEzVJKkjq/0Bbsu1Nxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu2HsTIrQNhceef8euyoNAL+zwpCxdaNFbHOgMHBkKiouYACJ+
	6mWI5k0OY32BPcJD/uQRsDMkCxiYFwd2/FXDJQOVc8+/3osh5B4kvAvAfXgvVEXWtSUr2YSAoEU
	emMwiXnZQ68lr7OJVslnGMzfdJCm8w7pNR3pA57fdltJL4/IskoXbA0I2+kT+sd8=
X-Gm-Gg: Acq92OGk/6Yl7Kl1HRIuYsmab6Ij0fRh9OyPgAhxfzXWPp+ypBBFio8tiL2UcufWoet
	oIhzH2/sm92txUkJQ1NnoyImIkkQmcPdApwv+Co8MdkHiuWZ81NsjMM0kfp/D1npjHudzcTaytn
	hscJZO2+nc08R7U5d4VyR+QnBRrz80iaXSICzpnpwJ4y4jlkSzYlXfgjk+Rggg1Kpex5HSLXCB8
	MznhyoWomplUURqZ9fWBbglcPPjAiYek22AAM50HeaBqRyiyBuvs0kWe4fzY2/LX/1vXwHn16Mu
	sGXe2h9aGzRkFf5s5yD2MmpKK0g4/NYN9c1lEGmbXGdxF/OuzLGvF3+kr6nnRfagbw6eCjLWdsJ
	DE+omFIB6LVszKChLKFBompWN7CVYZWtyGEyj/nqVjzoqIw==
X-Received: by 2002:a05:6830:4115:b0:7e6:e162:913 with SMTP id 46e09a7af769-7e7847583cfmr7195443a34.5.1781611291496;
        Tue, 16 Jun 2026 05:01:31 -0700 (PDT)
X-Received: by 2002:a05:6830:4115:b0:7e6:e162:913 with SMTP id 46e09a7af769-7e7847583cfmr7195385a34.5.1781611290862;
        Tue, 16 Jun 2026 05:01:30 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb5223309sm635175666b.28.2026.06.16.05.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 05:01:29 -0700 (PDT)
Message-ID: <8ae67f39-3faf-4db2-acab-ec7149215bb1@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 14:01:26 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: talos-evk: fix sdhc_2 vqmmc-supply for
 UHS-I mode
To: monish.chunara@oss.qualcomm.com, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        ulf.hansson@linaro.org, nitin.rawat@oss.qualcomm.com,
        pradeep.pragallapati@oss.qualcomm.com, komal.bajaj@oss.qualcomm.com,
        jsodhapa@qti.qualcomm.com
References: <20260609073509.2453273-1-mchunara@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260609073509.2453273-1-mchunara@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ol76DMMlKa_Zk0zsGZyH43jjREN1gEbl
X-Proofpoint-ORIG-GUID: ol76DMMlKa_Zk0zsGZyH43jjREN1gEbl
X-Authority-Analysis: v=2.4 cv=I4RVgtgg c=1 sm=1 tr=0 ts=6a313b1c cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=uRqv5Ot6X4B4uVllIekA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEyMiBTYWx0ZWRfX/ArgOT/g2U6B
 veBacOzQ9bh/bY9lQSk7+rZqB7ij6ZgVTKbaNoFbn4o/KgNL6y9mrAui1jAFkckBHAIX1X46zXc
 gnSeWQCLxCFL9fPRBUt46liiTOI8nes=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEyMiBTYWx0ZWRfXzE+7xrhmR6ib
 BT3GhIjMCZxNBPg2DD5OZABg1RYLlpaF4pEfG+8zJd33Ym4ma8741Tp1BPsdpgmOmHvEGANWGsO
 Cwzw0zWvwZ7nRchqf/2+Xa8jvCFgzjky65Bpiu7ZCM8WL5Z5EqD0Ef5UrsmNm1wRq4zkCeK5Qr0
 sOzLD/cYPMeD+tut0oEvT5IYUQJCKI2HTDl/YA5OcjXqsirQZDbxAZeHpnmcxTXqBXnxw2Uyw5k
 QF7IGMFSOqW7PVL2lnWarVmS/uCskdULzYPpDvlCqkGB8HQzsYdw3moGHVgqB34Fn229VCccAcP
 2g41WKtZWJak729cLRyXKgzINHGzeRfljnMHQq426Jwn3ZB13OZGJkUwvzgKQEL0fUqP8E4ZXqV
 S6c9MvdVk27qfhQGn73QrPMcEAHRBmmm7PcH9+k/eHA7MMAuTJmqNe4UX2rgePE0EmJ3l6ItStT
 oUkj8Jv/fQZWguA0Sug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160122

On 6/9/26 9:35 AM, monish.chunara@oss.qualcomm.com wrote:
> From: Monish Chunara <monish.chunara@oss.qualcomm.com>
> 
> SD card is detected as SDHS instead of UHS-I because sdhc_2 was
> configured with vreg_s4a as vqmmc-supply, which cannot switch
> between 1.8V and 3.3V.
> 
> Switch vqmmc-supply to vreg_l2a and update its voltage range to
> 1800000-2960000 uV to enable proper UHS-I signaling.
> 
> Signed-off-by: Jaypal Sodhaparmar <jsodhapa@qti.qualcomm.com>

Incorrect s-o-b chain - is Jaypal the original author, perhaps?

Konrad
