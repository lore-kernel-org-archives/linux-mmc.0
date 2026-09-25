Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2214A4825
	for <linux-mmc@vger.kernel.org>; Fri, 25 Sep 2026 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345451; cv=none; b=VLI/RlPnMExDdWuvApNr/kujnsiUOcsvWqvnsIt9usMAfzcCc04UeKIEiLzJ7lxSLoNor9151gptrb0K9fRPPW5XZ2wf6XAejfa0KdUGXry1Y8r7FUT8r4S8J1gDpigBRWW9xZvUEDM5mnSZHmyTljD2/VNmQ9MTL78IKQHr/HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345451; c=relaxed/simple;
	bh=Yg3zrQBMAnqEW0AFGnByx9lrDxc347u5l1v3CVX3nu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JD/lVFZR1VP9pwk434hm0KYUFgnvgw69KJmU+j4lttaRqnI+i2XlIwTgdP1PDJGnLDJCtXie44hj6HQBlOdXxggmKzYxJI2OZMcsU+s0Gb0r945mPUikeqTVbs7cVs9CI1KoTNNe29s+hz6piEJv39/76Oa7mSt4eLSikFWg3tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cEW2Gr68; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VESu6pbi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cEW2Gr68";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VESu6pbi"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PE1VBl601381
	for <linux-mmc@vger.kernel.org>; Fri, 25 Sep 2026 14:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dSAwvXSu0z/cPlAloRsBK1Y8v4BwQK6DKrIQDBSZuBY=; b=cEW2Gr68J/yjV9hf
	LNqU2nvoxSEwn0pCeoRSzf6frVtNvyysoVE6beEu+utx8RIdLQ6B5jJxEVVPbE5f
	93BCcsH/PaWeQYpvzgoXNVGO4lcKf3r1jfpeuLKKmH6slaMbs2WbVJTa08OurNHG
	llAB2HW6DvnZi6wHmCSRIr0oLErXHCw03L4ta6aSFr2/3pRuANg4rKCaAgH9VlSO
	nDV8KAWKGzAlYZQMUu/INIy0K0r5V5efPH3tqRwD1syigBxl7w0Calqr2RjndKcU
	Nvxt+nsasLfKTVlRNC9n/DU6m30KZnpOlswyXckl5wFr0/sUz7kmjutAMtI6BGKd
	aLj7yQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjpvsmjn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 25 Sep 2026 14:10:48 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2dd1631d291so8042025ad.1
        for <linux-mmc@vger.kernel.org>; Fri, 25 Sep 2026 07:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790345448; x=1790950248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dSAwvXSu0z/cPlAloRsBK1Y8v4BwQK6DKrIQDBSZuBY=;
        b=VESu6pbiP7Wqh1qHnFK1Qgl8hcMRPGxGV9WLMwfzZuoyQcK7TY2zhwM1vywp9dFN7w
         5jMioNZSCtRmdeFpGZKfzt6VcJ1hVoAEQIweI/drNJCrSn6pEs9guYw+cw3wUXw96vvG
         qvirB37wNqCsxof7rqE8s6CTK4rEzL76thkVy33IJX6fjJlVRQVud/Oe0pGHojMxcaSK
         NM8hDpC6v7pUN87sZPo/y6lFp61bBU6aMFdL9iMOtxfCDrJHHGwpSHvJCFlNAirLftiz
         hO+c3UITmn3k9EedHDftIgzQ8S2s3U0qnT8alp2FO+/bix9E63Au25/xmVR25B+rYKOG
         n0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790345448; x=1790950248;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dSAwvXSu0z/cPlAloRsBK1Y8v4BwQK6DKrIQDBSZuBY=;
        b=YoFswZvHyRH+tHOQGfwQlAAymuY6YIHAxsMhLvxfeTMoBj4duEVY38lPlkGLaosEmJ
         rVBTYhwKf/upZljGnePZpAQb9s7tidzHm6ssSC1EUhbUaDgWCOQhsPKqxUlcl2qZD0Nr
         txuFWGmDafqFouP15rWuStLKs6J9MBI9f/6yfw9bMWlw7H9bh5P6Jb+SYVa2xwHypFRh
         UCL+iZpYJQZKzi0DMTlUzdyMDt5Ry5fnTUC/o5OstBtlK0G4ifcuO8KIbNnEXBCpaRzr
         +7ZeGpP6hHMQ2mzhKgWjCC3f+tZSw/KOj5YtE2W46GxLgyVkd1OYlbPahF8X9fcMvBeY
         vjhw==
X-Forwarded-Encrypted: i=1; AKwUvBygGN+eWpl+FzPJd8rRJkdY5U4rNOKlU0CgW33y3LoQoUSkckLNzzziIGHvh+2aYgVxJ2Xb8RU3ngg=@vger.kernel.org
X-Gm-Message-State: AFuF++mGYuz6cERI99zTSkwxQNmW4H0gpY4HJBIZ5dtBaWFA7VTIdOZC
	S2m567ZgiUuIOoXLEipzjRRcktRqKhsXKnzx50/3XtDLO5tmLWoPS3cR1S3bIu+SXgqVuBid4zh
	IRU7FWO3BoMPt7v3/um409CEr1P8OA94/zlsyGi+8Adtk0pfUoA77qS0qENXGpQI=
X-Gm-Gg: AYBFou1eHFXTPvHWq9FwgOab5Ar1VsBzbErfoCSVFiuFb2n3i9T5PKOdeFWKDdiuAxe
	APV6qZ191RTWuHtYgCDhOcaM8Hj6RIQZNfVSOdaGM03h/A46GjbiG/zp0QpAO72WLdAATrbFUTK
	fDHwOz7Mvtx9Of1rPkGPDbPKEGD5wERYsx95lq52gIpXEa5ErNkcdm8YVCLL5GuMDDVX72rPhrC
	+kSUamsos/PUBxlS1kjvgJKTUOhqhOYKRibH4YhFSgNiUq3p9jixVAyuWePDImZemlWIWPQSSrK
	BkoFd44PGEzh0GmIHCGOquqrQ/jAsCOnKEmoUDjHbCr/c9XKAyRUCDU1TU3VjxEQWFQdGX+mdgE
	1CoLlnAlGErK1pCX60ccQsi1qrui7sO1Lq3wKapBQZT/2KT49TIvDKKglbzn5
X-Received: by 2002:a17:903:324c:b0:2dd:c100:80b5 with SMTP id d9443c01a7336-2df7e6644a0mr43024235ad.48.1790345442733;
        Fri, 25 Sep 2026 07:10:42 -0700 (PDT)
X-Received: by 2002:a17:903:324c:b0:2dd:c100:80b5 with SMTP id d9443c01a7336-2df7e6644a0mr43024015ad.48.1790345442134;
        Fri, 25 Sep 2026 07:10:42 -0700 (PDT)
Received: from [10.227.105.111] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9142969esm11450165ad.45.2026.09.25.07.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 07:10:41 -0700 (PDT)
Message-ID: <f8815dd7-1e31-4567-8f12-1b2b1dd451f7@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 07:10:38 -0700
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v10 00/10] Support for block device NVMEM
 providers
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Jens Axboe
 <axboe@kernel.dk>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
 <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Christoph Hellwig <hch@lst.de>,
        Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com>
 <178998281449.889291.7893229102394463283.b4-ty@kernel.org>
 <CAFEp6-2P14MdYJGuH6ygRL4ZKtLnJEj=PVMx2p+b9L1RuiX1dg@mail.gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEp6-2P14MdYJGuH6ygRL4ZKtLnJEj=PVMx2p+b9L1RuiX1dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5zNyT1MLUCdZf3_Zv12y-tnjxVaboPWW
X-Proofpoint-ORIG-GUID: 5zNyT1MLUCdZf3_Zv12y-tnjxVaboPWW
X-Authority-Analysis: v=2.4 cv=aLBlOr9m c=1 sm=1 tr=0 ts=6ab680e8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=pXJ7akKBZDLnz8CNZxAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1NiBTYWx0ZWRfX1ZzYtIpS1jn2
 n6rsL+gX1tMvDcJQBIqAeEjFvsLRk5Shisnnuq+ymkSDYODnEiM0Csd0PN/YwRNwBDNbCZyPjyz
 Bx7V0W7TIJEJTfT4iVlHDLQzQDiXLcU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1NiBTYWx0ZWRfXyXmXET1cdUe8
 Rytp3H2buCxeXiC3ahIA4PPOTVs4tPTVRix0U7A7DsHkSh/5ovIPNPnPxsZ+C5Bt1XR9eBfKdZ/
 Xb4J4eklTeqgbgCKrY9mboUvvZSEOFl0hXMDGpqOIYhmuVTOAHoY6wv2JjTq49BU25De1dabwR8
 BQt2NhdC2dKvlopuXgIKZiazVZwckPJo7/mmgzALCcpV7t3KXrG2LNCFLZrXtgNi8446IZFh1za
 pYFrb++qP7A5IWJZVZzkdfusJRU7Q5UE6gqGWKhTprvvWGoDBRzuV77rkNiw11J119HNMbXeEPW
 qFoZMVUFAWwxtbDOXG8vXUQjgdUi2alB+hwHXslIUEJWVkevl8easo6c2gZr5zu8zipn0MiytVX
 X4RnZUwTbqTJ8pODVnwrlkiIrqyxETYJYkTBq0T+SGVQ+C4JLt6WKlu7NsGy7gOQXw0eApxaiEk
 lrY3vcPE2QKFfjJYhmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250056

On 9/25/2026 6:38 AM, Loic Poulain wrote:
> Hi Jens, Luiz,
> 
> On Mon, Sep 21, 2026 at 11:27 AM Srinivas Kandagatla <srini@kernel.org> wrote:
>>
>>
>> On Thu, 06 Aug 2026 16:38:33 +0200, Loic Poulain wrote:
>>> On embedded devices, it is common for factory provisioning to store
>>> device-specific information, such as Ethernet or WiFi MAC addresses,
>>> in a dedicated area of an eMMC partition. This avoids the need for
>>> and additional EEPROM/OTP and leverages the persistence of eMMC.
>>>
>>> One example is the Arduino UNO-Q, where the WiFi MAC address and the
>>> Bluetooth Device address are stored in the eMMC Boot1 partition.
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [04/10] nvmem: layouts: Support fixed-layout as the nvmem device node itself
>>         commit: 9c6cab93dcd47c3075d896c777567b9d8f813d18
> 
> If you're happy with the current state, would you mind picking up the
> block-related and Bluetooth-related patches in the respective trees?
> They are independent.
Should I take the following, or someone else?
[PATCH v10 02/10] dt-bindings: net: wireless: qcom,ath10k: Document NVMEM cells

/jeff
