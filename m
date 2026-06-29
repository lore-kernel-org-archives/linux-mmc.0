Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445FD400E0B
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736369; cv=none; b=naq9TlWSJJYccH83/mEgnApviHds2oj7tRMRe3ig6g1uOBSiOpioN8otu4jF0A4m7JBNcGyWAotlbDu6S7li32YuOXYneqO+HEV1IGe2XibVxtjt0QYlOYGzG5l7AiHIWIsPdyeRbmXLN6zwdXDICGW57A41LoX1y8Omb3gtYcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736369; c=relaxed/simple;
	bh=8efsNnD8ZlOsUYmypbKzEmPSzrjsDpxrNYVfgMTH7F8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y27675wKTASXBLieeSi9ZKhO/rb3ytp7KSK/RjzrSltfDR/rmPtMcNE3nr8HpoZ8GPCAX+Gatj6EWi0QTbN2oZ5pXussmYIcNEGKlRgkMEr4NYRQdsflK3f+eBGAy+l12Lyl+n9mc+Kg83V5gZWi3fnbOjXbVD/4gVEe/WAXFHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lk12HFCn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h+5nmyt6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lk12HFCn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h+5nmyt6"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TATJU52656107
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 12:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sg9b45lWyYW5afGwbosga7mripr2JnazhYSqMcE1s4U=; b=Lk12HFCnaKvFM50e
	653jd54V9RwoslGrx/MQZKA528gWHRvtjXFGVAXy0k1vjx5qoU+bvkd3DELQgXGy
	hngiO9YhJ6sPtRss1vsak1q/07Y6rfmnMIa+IO4ayl9QZHCksyUcdt8i2U3Q30rr
	s5n8e2AwxmJfRZfqha3t5SZ5RySHhb4dffJrjTujEz0pUcwT5z2MOehlXvXQzEqO
	wFw1II/JTTfxJNzPBeo5APDxuI16nk+coPWsjh8uo4foBmomuK45EvaXWRPm9MYW
	JFuezkOGidTl1laXbtFZPYN8a7JD82LFtA4QIE8lK0FBUWyQu7IEkE5N8ebnHPm5
	xEEkBw==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3np7gsrb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 12:32:46 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-48f5afc9692so4830342b6e.3
        for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 05:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782736366; x=1783341166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sg9b45lWyYW5afGwbosga7mripr2JnazhYSqMcE1s4U=;
        b=h+5nmyt6phnVHzdPRN2NYOMgxwhbiFgymdRveO3WmY1DadcQkiSYC8B/GSBAnVrw06
         H9mGER15thKCHR/YjV1TBOn4S9LOMHPpXCe9NhbUsIk5Dy1uWVacucclXXaxo3S8GzOP
         douZpiFf1omCNNdrIVSJC1enxw+fkF1NQHmPv94AkcepIsHbtp0XLx/bTcCdfpXrfDpu
         p72KRKR4oBm+DmNqNXCcWyvyaJi2vO2IFothuXMzq/gQbsWZQDuY6dt+9DVjfhqR2++u
         Wm73Xa0Hedfipe2s20fIRSfX/O/KtLdBb8lfm8Y0vY55H73zO5luzPnk//8aEG6nWIbi
         OC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782736366; x=1783341166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sg9b45lWyYW5afGwbosga7mripr2JnazhYSqMcE1s4U=;
        b=mcxCzo9IPU50z8DlYeqWfkRheoi06HBRkHiQgKDnqGOpiT+iOwuzE/knn+jermIRkq
         qyd3qSg7uhiP+gQ2FcaXUb0NRTA6ARF/jGfMX6EZQ0LGt9TlqE7vvF5YK6kGx/zdn0EX
         9UGb0lm6vT4PQqE8WegXvHCCC8FniB+Eu7Ff3GkHXnD/MCkiUx3UykLbPmUikEXXKnmk
         RlM6wM74lq06Kaetp8ucilosmsUJEkkdOPHcKZnmTm7j0B+ImRmgeol3sADMJMSYvZN6
         3O8dqUnRUeIgKE96HuCeyfvPkbXnutAcC6EH4bYNLQ/URsVwQhSc2+nkrIlo/Ae6jnwz
         M/4A==
X-Forwarded-Encrypted: i=1; AFNElJ+hsHPyV63XbW1axvGDoQ3eZD+QDodSoBsMvP8I2pHcXuhyEwqyWSQp+siCUUAGkt4RWh2Tvxxp+Rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzEOutcH9oD4Bc12YzYrhkjuAOI5CwLywWVWf7GuUZQ8CQda6h
	+NJq69tug097A7e34ge2pYO+QoHOpAEWqgcan8wQa0JLJ2uPv/LIQ+I/7zHAiXgSBK+rEUgqTOa
	/UEPQTCw7u0pCZ18cXGBNjTx04Z26UT8vOiAHVwRunCsreDp4Fijood74Q0w7GpA=
X-Gm-Gg: AfdE7cn11clv8sVLZRVyhIaMn/nYD3O7L29EsjxUHWj17t4fpZF2HPsw/znv7FjS4ve
	Rj1dcD/DemsbMNiONL34aPEi9oU+E96aJo7RNtBk0zRO+0fHg7oSvCJG+rsa8UnLcE6FXxHzV5q
	YgaVAWAvFIImn2Z+uX/v4AUnQGRUw6xRFMWn7QlNnyopuJuZn5XJ7YLNhxVyR+eY0VDLt06+f9e
	cpXUTBBNW4OdbmEAedDV14MKwr6+IuOqAXN1tqLSXSgSDZRY/m5U11K7dHSwenRkP9JfTHxev8L
	PYbHb8IS8ktf9M0DtsFuWnjfkzxMqJnLTqYFn009HpSQlVoxyAPdKPLrrbr0TiOh7o3NTrzXYm3
	xDghrnoMwYv3EiDnA28ybLd5kRHoOcdXB4yrKNWiHHzU=
X-Received: by 2002:a05:6820:2085:b0:6a1:50eb:2121 with SMTP id 006d021491bc7-6a150eb239amr7050238eaf.69.1782736366277;
        Mon, 29 Jun 2026 05:32:46 -0700 (PDT)
X-Received: by 2002:a05:6820:2085:b0:6a1:50eb:2121 with SMTP id 006d021491bc7-6a150eb239amr7050210eaf.69.1782736365902;
        Mon, 29 Jun 2026 05:32:45 -0700 (PDT)
Received: from [10.217.222.146] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472f0e7219sm22179629fac.17.2026.06.29.05.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 05:32:45 -0700 (PDT)
Message-ID: <d3be45ab-0390-4d0e-8d5b-330a48c529a1@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 18:02:39 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] arm64: dts: qcom: kodiak: enable inline crypto
 engine for SDHC
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>
References: <20260629-ice_emmc_support-v8-0-1a26e1717b85@oss.qualcomm.com>
 <20260629-ice_emmc_support-v8-2-1a26e1717b85@oss.qualcomm.com>
 <ba96f5e3-6b6e-40b6-b6c1-300e862e8ee4@oss.qualcomm.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <ba96f5e3-6b6e-40b6-b6c1-300e862e8ee4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwMyBTYWx0ZWRfX9c+TqedB4Au+
 kwJOf/ggd21uyOl8v+YWQ2e1Of0tWeg01WiddqhJtQyTD1aUMGuAbiHPk/wAXWUMytZAGJz7HRD
 YsOZe3e875mj4IJU7hLh33z89yEhlg9vYcXFdJVDT70SQHLwmjEfeU2v1eCeQeToghmhpfEWnIg
 WAKD9UJHDo8Lz0IU1i3xZ1bKrS2beVuD6pPtQL104rDpdKBUZ+wCgzgTE0PfXuvHI922FO3LLyA
 1UId5kBqRJxoC/LGeW8vH0XzpQXaXw+7VtumU1kdqUeuVMgZ2uKBoHaQ5dVCjYFaVVTvvsyzY64
 3sRSjBTR4cwpxftWaZRcX/vT4evkzB5P1KqeFZUdVRg15Jk6UsqVamyY3WpjLuTKYNmUDdcSRy5
 AK1CisovUu3WeXt1rd7UsS2+H9/PRYUzb6eslLgDAQ+Wpdp2BgYe7Lmw+54tNXJwsF/X64jyAoq
 x8980WcjLQIYw+ifHFg==
X-Proofpoint-GUID: Wg0uDHI_Vacy26TQ64VYj--TyfOSwUd_
X-Proofpoint-ORIG-GUID: Wg0uDHI_Vacy26TQ64VYj--TyfOSwUd_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwMyBTYWx0ZWRfXx2G7e/MRbBN8
 +y/6xqAzl7oO4oBAv1cEh0gzXnoJEC4QtGMX5m7L8IQHSsx85FBHjBUYw6G3yw7H2NapQfz67ns
 pKo9jetz2Mm6rwztPFeIGRThM+qjpcg=
X-Authority-Analysis: v=2.4 cv=OcWoyBTY c=1 sm=1 tr=0 ts=6a4265ee cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=s5cnJLgf_xX4dDY0o-gA:9 a=QEXdDO2ut3YA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290103

On 29-06-2026 17:24, Konrad Dybcio wrote:
> On 6/29/26 9:35 AM, Kuldeep Singh wrote:
>> From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
>>
>> Add the dedicated ICE node for kodiak and reference it from the SDHC
>> controller via qcom,ice.
>>
>> Keep the ICE node disabled by default in kodiak.dtsi and enable it in
>> board DTS files where the corresponding SDHC node is enabled.
> 
> Is there a reason to disable it in the first place?
> 
> Keeping it enabled it would ensure that the core is parked
> if it was left on by the bootloader
Yes, observed an issue on kodiak Soc which supports both ufs-ice and
sdhc-ice.

CRYPTO_INLINE_ENGINE flag can be set to m via 2 configs MMC_CRYPTO and
SCSI_UFS_CRYPTO. In default defconfig, SCSI_UFS_CRYPTO is enabled
default and hence, CRYPTO_INLINE_ENGINE is enabled irrespective of
MMC_CRYPTO state.
https://elixir.bootlin.com/linux/v7.1.2/source/arch/arm64/configs/defconfig#L1325
https://elixir.bootlin.com/linux/v7.1.2/source/drivers/mmc/host/Kconfig#L614
https://elixir.bootlin.com/linux/v7.1.2/source/drivers/ufs/host/Kconfig#L62

Kodiak Soc supporting both ufs/sdhc results in initiating both ice
instances which in turn votes the clock in driver. In general, ice clock
suspend/resume sequence is later controller by ufs/sdhc controller once
the corresponding ice instance is initialised.

Since, qcs6490-rb3gen2(having only ufs storage) doesn't have emmc
storage but sdhc-ice DT node still probes the driver, later sdhci-msm
never takes ice instance(as sdhc_1 is disabled) but ice-clocks are
remained voted on.

This results in an issue and hence, trying to fix it by enabling ice
only when corresponding storage controller is enabled be it ufs or sdhc.
ufs/sdhc are default disabled and enabled per DTS, hence following same
convention with ice DT nodes too.

I am planning to update other DTs too with same change.
Suggestions are welcome!

-- 
Regards
Kuldeep

