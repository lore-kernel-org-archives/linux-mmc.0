Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8D5298CAA
	for <linux-mmc@vger.kernel.org>; Fri, 23 May 2025 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748024755; cv=none; b=nAe8yhEHchJB/AVEbd4AiX2wE/+VooPOSdIkU9vJ9+EPZ1Hebl+y3sDMCLw5wVh0aS2UKtsg74TJZ6ibd1p1BLqqXvsMlPkV2vwzBZCaSg+UeAJZpBl4smLlCwqFjdMxaA4dYCLj0qBU81prjhASQ34vBLxo6Q3uG9T3cfygthM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748024755; c=relaxed/simple;
	bh=NtQOkWCQz8U7GrzRiRmsaukr1M2Wq2lGQo0FZR6FC7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1vX7ZfqDCo0QLwdArD23f8hMtayoeryRa77gF75Yhbn71w9IEvU+nFBcPJrKv0FJ0z46v+epYT5GimYOly725A8MTK2bvFyU6S49lTup19xi3xXF1REm7N2XI/lIOCRHmZ/1u/n+MehnPLR5NPz5tPEKkXvKWN7BJSRis/GVfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HfR6BXcX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HfR6BXcX"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NBvHrQ029654
	for <linux-mmc@vger.kernel.org>; Fri, 23 May 2025 18:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q7jAskVrOtvAVeaEb311Ty4pkBPjetu94PQoDx54lkY=; b=HfR6BXcXPhL9z02U
	7PYNsF3D2uRj8K+AgnLAdgTlfOtOTU7JIrVaxVtVsb4fyYBC39rjqJBgMgzkha2V
	V/BW4qrAp1ucCNPQf9Paw4wBMBv2dCA5FmNtc3AUhlMiEBnAuTNhO+PJ1xP08Cod
	pfRla/oupSxgc0uE+dionxeGOEvAQYT2e5zFwIbZDW/ZgfHz3Garg+7PIofVQDYe
	0xtFPknPdg2XuffIKAXg/2WUCJOYQWpkrb5K5aPX/GhgfWxUmqSDn3UcSlKUE6mn
	VKLhIpafA2fL1XeOQA81nsI2tnVWD6mT02eNotorFnM+gl571xYwfgEh5Qt6Ycwt
	xXme4A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf4b00w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 23 May 2025 18:25:53 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6f8aab0a94cso214696d6.1
        for <linux-mmc@vger.kernel.org>; Fri, 23 May 2025 11:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748024752; x=1748629552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7jAskVrOtvAVeaEb311Ty4pkBPjetu94PQoDx54lkY=;
        b=vm6/XM4lXxKyEWQJXTHgeBIxDagf9inmRkYZBK2rHaLt/5yT2Hshs2uf5KBjAIRuhf
         ibw5+8FnwoBUohKtalVyttUq1QmwIUNrUKOS5YQn4cV4cQtIbwEkAIpFyIekNHfsoobk
         SbhlnFbm+KvR3zVDn1ivJGFQtleFch31VVxdJGfa3oikEwgvkJTpmB5Z/ikulv1/zFGN
         8dtzdTnwVHRtgnQfcRp+BtMshDC8M4wfMVUBmChfI1pdaWD75SK7i8HFObMjAXTQhFai
         wjL4c9K4pqnEKLoEaMD78GHytI/ecyBo2UsWEkRxlZRm5hWWAOQdx8lv55URGuddVD64
         bcqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVllEfpuiiYAyLPwhOLXgByZ5heB7o6ChR2bA3l2/uJKbWYm9D6gjaDM1Oo3xGogx658NiosWEGtfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1498r90tWVfSzLMF1rd8rPNWAG7sJTUEfKBxLZivCkMo1yGeg
	D0ZocQOMLKDuABzZxSxH8p88EBht9EmIBi2XYbaCqq+uPFcHH9rtTdwXI0iWIue+6wKDM0+oMfG
	2Iw+Oce1lNO0o1PyVXUpc3r02IlrcAzWppszS2SPGgC0tBBSnu+bcwHx07Rhc2w4UoS+JtsQ=
X-Gm-Gg: ASbGncvbe4HA9XTpJJo0ObMBlJ+9pYfpMuPQgBZ1UynrJFjPe6rh20in3AaqWHh14DB
	K+ca0+qjaa6e9/p+6nVgFbLqswXI5y0cvbUwKlC2sp0EQvV22PXkgyefgeizMq4U2j3TnsY/scr
	jQmPIJGTDukZvolwldZuC8w9pCkaR6V5Ydvctu4jNZ4QFmOMjHO11pGRzRrUwxD5kpHECT01Ei5
	d8+FgXSgxWMgiukZtqVu3nzlVgsxJOJK/+xLCzZaiv7klVkqy5dRQuBBd08Fi/B6RX2Awmo8ZC1
	IqoDOCKD8eKg+yI2FyU3HCYvtHt/hlUaEFahCinh2pGKWpCKU8wxP2FUm+nVv0gdfw==
X-Received: by 2002:a05:6214:21c2:b0:6f2:c9dd:353d with SMTP id 6a1803df08f44-6fa9d2baa17mr3427436d6.10.1748024752341;
        Fri, 23 May 2025 11:25:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRXjYKiZh4UzYAut+MyKZE13w0f4gwaL2w4sBdwdgygXZc6Mqqi5zfAiRZTmNuRy9a3FKMAA==
X-Received: by 2002:a05:6214:21c2:b0:6f2:c9dd:353d with SMTP id 6a1803df08f44-6fa9d2baa17mr3427246d6.10.1748024751924;
        Fri, 23 May 2025 11:25:51 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d04f263sm1257906766b.1.2025.05.23.11.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 11:25:51 -0700 (PDT)
Message-ID: <d0d3c2c0-d5ab-484d-835b-3a76055cad55@oss.qualcomm.com>
Date: Fri, 23 May 2025 20:25:49 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/3] Add level shifter support for qualcomm SOC's
To: Sarthak Garg <quic_sartgarg@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com,
        quic_bhaskarv@quicinc.com
References: <20250523105745.6210-1-quic_sartgarg@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250523105745.6210-1-quic_sartgarg@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE2NyBTYWx0ZWRfXysSj57pnjAS/
 qK8BXgDvfzcJvu+gvQI43pY7JyQyl6+3B7fjh46yac95RGwFs1TtjKMaHCLsmcS+SNu7/2/FQik
 hwqtgB0a9+JfS5D6WKqqyo8L4/eLSrlmfoeF39wW528oPwkw4C6pEUy6r98hM5rfpMELgkvD79i
 3hHvK3uKN+YY6ipkAe3Pk329FWvubumqgYOklE2YF88t7/c2f/JdIe12d8xJwhcaNW0Sn5V+Beq
 C1k2QvGQ7immmT+x7KqmH6ISXkG8+3gKTmdYLdgwdPRsWCyxq821lUQa33zXfeOZTS89IRSpSil
 UjJh4CE69XG8Me2ZrhH6bSJGIjaq7FvGIAxKM+1WvqZjvH288uakoMADYEDgfdHVlzGUA4CKQKM
 G0PjwrT5vpdL6TUakjxVmlfBh39Hq201UpDliMuXMyQBw2cnXLGFx/DJpUxp1iJcBiBQo9HU
X-Proofpoint-GUID: O3aFNdzlX-PqBB4ihRY0aLRpgUrkyYtu
X-Authority-Analysis: v=2.4 cv=Ws8rMcfv c=1 sm=1 tr=0 ts=6830bdb1 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=phjHtPm2XXW9BfwSypYA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: O3aFNdzlX-PqBB4ihRY0aLRpgUrkyYtu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_06,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 mlxscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505230167

On 5/23/25 12:57 PM, Sarthak Garg wrote:
> Add level shifter support for qualcomm SOC's.
> 
> - Changed from v1
>     - As suggested by Krzysztof Kozlowski redesigned logic to use
>     compatible property for adding this level shifter support.
>     - Addressed Adrian Hunter comments on V1 with resepect to
>       checkpatch.
>     - Cleared the bits first and then set bits in
>       sdhci_msm_execute_tuning as suggested by Adrian Hunter.
>     - Upated the if condition logic in msm_set_clock_rate_for_bus_mode
>       as suggested by Adrian Hunter.

During internal review I suggested we could introduce a generic quirk,
perhaps called "max-hs-frequency" which would update this
currently-constant value:

---------------- drivers/mmc/core/sd.c ----------------
if (status[13] & SD_MODE_HIGH_SPEED)
	card->sw_caps.hs_max_dtr = HIGH_SPEED_MAX_DTR;
-------------------------------------------------------

(50 MHz)

which I believe is where it comes from

Konrad
