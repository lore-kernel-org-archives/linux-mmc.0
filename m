Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA0A3E2740
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 11:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782733913; cv=none; b=da4+JYDLM/rv4OmIS7QzZKcLJB2byke5y/WMJyoGd+yAcRb7guqb+RF3kpWflaeZbv+j5aciPP+RNUcboKAFjmRO8UsvRfc9NmaCd0p7c52HBVa45KM8s5EsfiKNmykNff74kJUfrXmlQArCqG5fLbmZ7uHEt5aMZDc3afh47Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782733913; c=relaxed/simple;
	bh=SQfUKUlnEvyUcJ9FMoDbCcEIG5v0GHLdITejt2eWMYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLASJnk0gDlI+P/Jpesb+crDtB6irErBXk3upOtTtut9cBlRIg9PR+39vWZ2w2iNBEzi4S87AMQ6Mc0GpljDAFZSHZ+aXiUGA9wGyGbn5z8zWrOzbQyJeUxYF6Txpjv4sQp+ykwP13bGUHUko8U8KVYwJRQ9iMydoHNUfhLrGBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eCy7Msgx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eT5f/ztF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eCy7Msgx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eT5f/ztF"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TAT53U2618919
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 11:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cGLeaDWCQtP+UxuayJ4J8uBL/QTOyyZsye6nFMc1d/c=; b=eCy7MsgxNAxabOCO
	eXnBOjdidcwQQSpOQYnRlChGb1Z3DB4Szzy1BGgZiIHcvjUPZG5IWoCVrZ6G3ueB
	dXbKw197x3KZO/pjVIhl2ocKhn+6lEhwXeBfhpm2W4cTtJFlj3yNd17u+e69qcSC
	AJTPwTV4U2r3ekNSXg0Lg0loSfUATJZrEYsZ4oqTRZ1/plNQZN7WmBFYW0rj71Ek
	W5iwKlivyxlrHtyO48itfhRUasJ3oxMA4pMgl0yWJQJ000+KxkjFxEguW/kNGGl8
	JBN6z/EqxUvvpUBTwXZau9xws4BrS5h4XEsiv3hwkllax1OUC8BKRvZc30hENOCj
	a6Y7wQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3pdkrdhe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 11:51:51 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e44728825so49072485a.1
        for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 04:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782733911; x=1783338711; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cGLeaDWCQtP+UxuayJ4J8uBL/QTOyyZsye6nFMc1d/c=;
        b=eT5f/ztFRgVtadfI+MCHg9VQ/NmGd0nh3hgU0LSiOlLbhkODOa9b8oxjELzCMy/4Gy
         ARBwhnC/GQ6wt2MzldK02OQk87/AbTJ8QTRe2qLOMBD4kxG7mLnnMc5r/Irjam4fxcwg
         0RQWyQpRNXmAl8shA/KP2EMnYF24GUB6UIwF0l3Mfio6fkxGBM7LdGCLxzNc7fZvq7g3
         S4y6yNnWuI++/hU7HWSSRq/scicE16cFYalSrp6OsGNo8l/yKTOH7KHxus/MHj8duy9U
         5R1Hoq9UgwLXFZSGVkGMG6mRVePPLMdTwgO1G90rCbD0oP5bcFVuhyZ/wMkeuCbOZxA/
         UJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782733911; x=1783338711;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cGLeaDWCQtP+UxuayJ4J8uBL/QTOyyZsye6nFMc1d/c=;
        b=SBNdrowYpRLjtkTCXBAqCFzaZRKY0CTEZ8RYoiXNVg5lO0wm3Zes5aAgqcbzB3BAlF
         +w5WmnHIBRjie7W8LNTTpVRplvJVaKMsQtTRBgatFMfMIKQEnokEIx4QzxJtt7wSibwN
         HEASGIwH7LB14ShD8wmSH+WySNpEeoJcRai4fXuJPe6vVP2Hw8KCdGiyYbJR0JglKZmu
         UN7SNAcgLWy9r3kLysSiDuophdavgF8X2wY5IanaPl8W3eQeH82rxHdyisRBQgGWOtqW
         I5EAZzhL0IxNgnAU8wip37shTfs6Xdc2BBbN4TQ1kdiwODzqjwgXue6jDf7rxkX7tUpb
         V+PA==
X-Forwarded-Encrypted: i=1; AFNElJ8KGySBJH9q9XM5A8DJ6Q9XKncJgwxkgrPnHEAO/7JMJGWWWa+u9FK2GhIAkoyiJan7+NZmOoQeFpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6xl8lE679EBcYg9/hkSZqwUgl2GxEJdo6Meg5/D/iq/L7pmBC
	zE3PR4Zq+fQlfsbBET9vHrTTxRUoaQhMWmbkxMGhYFmsaWHSn1OzzrdkaYlYYqUz1yaIf69V9Nz
	tbZ7jkkuDJUfTmA462Kjx9Mx2Jd4z3xrzHCEtv8CMP6sfp7h3Mke2ZI04sM7O2hcBSTq44do=
X-Gm-Gg: AfdE7clDvebTAZ3ZEYQjPsWNLYXvZxjOL7V7p8hq1H/7WO9x+9OEm+lFvW9DTzc29Z2
	S+IDjqdKbhOam7fFFioFBfUJXd3P+Ej2O/at7EbMUtHyD2VQJ39EAvEdRzcQxrd48h30t7JNACP
	e4yb6u7qvHduCTZjXAPGdf2iGOingv1aZ6RWpGjk0niWnIvYWwcKWABg+TWZ6OsXBou0yzXUkdX
	3/dEzJ7T3QlGuW/Fw20H20ytvDeYLM/8IYBu3n08wsZtau7+cD4QAZhRJNXqEllHN9k7B5os+hd
	OCNgcNtGX0ZWnVW2DB1iQk2CQ/ter+UBDCBX05CTP7E9yXKYE1iXuY9vkjYmsV5LffexqBsBbnf
	9+e7eNbdfrYInLUST631HZ2H5av21ImkWWlQ=
X-Received: by 2002:a05:622a:211:b0:51c:8fb:fa47 with SMTP id d75a77b69052e-51c08fbfae7mr8780731cf.9.1782733910787;
        Mon, 29 Jun 2026 04:51:50 -0700 (PDT)
X-Received: by 2002:a05:622a:211:b0:51c:8fb:fa47 with SMTP id d75a77b69052e-51c08fbfae7mr8780401cf.9.1782733910231;
        Mon, 29 Jun 2026 04:51:50 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c124f1723c7sm259578966b.26.2026.06.29.04.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 04:51:49 -0700 (PDT)
Message-ID: <a8d05fb0-69c3-4905-9b05-e21bb6f3be2b@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 13:51:45 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 5/6] arm64: dts: qcom: monaco: Add OPP-table for ICE
 UFS and ICE eMMC nodes
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
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
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260609-enable-ice-clock-scaling-v11-0-1cebc8b3275b@oss.qualcomm.com>
 <20260609-enable-ice-clock-scaling-v11-5-1cebc8b3275b@oss.qualcomm.com>
 <d8fd7888-cf7d-47e2-8e77-3ba705c88502@oss.qualcomm.com>
 <ajjmXMKdWzae5qqk@hu-arakshit-hyd.qualcomm.com>
 <dcd6f0e3-46a6-4f57-b4a6-0b9362b1a8c4@oss.qualcomm.com>
 <86321e30-2bee-41bb-9d63-d0e6ab4154db@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <86321e30-2bee-41bb-9d63-d0e6ab4154db@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a425c57 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=DUC2ZapgCAhEJWWdRLYA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: aAjvRNl-NTA8M4xDXutyokmwotHNpYdn
X-Proofpoint-ORIG-GUID: aAjvRNl-NTA8M4xDXutyokmwotHNpYdn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA5NyBTYWx0ZWRfX9xmvx/BCjQ1a
 VG/WpXg3GDVGlFCN5O8qwhm8RYIRFRR7N9487SKuMvBLuMSKX+Svu/QHHIZ6EbRSzx/b7nj28es
 Ppzttu9M9qMGaA5sI9sagqWDX9awZfYQ4hpGwnooS5EYyTPg7fxqaokPYmRBjdm6S41XFVB9akY
 Q1FZkWFzGlLpL/Q+xRbCtzA5jrknFYk4GwC54LKj1iHcDYi2fP5s1Urb2v6hNurBwo2Sn1xc8te
 nxDmuC8CioDJumKArUv2PHWYl81r6GnG09/vV3DTL2fDvfmr+CtuICTn5doCoGs2FnnNfsVUzeM
 j5fvbzFHxOQRB7lbxRy79tM6DG7eXI+eTCpBZpahzFqWxDqEEN4yqB7mx/5hOHlNh92hhrsMkjS
 wYhNeRlRBDcgDBfW7Pc4G+Ew+a9+QfcXpbz3pq7ulI9yJlFZ5ljdTjLYG1tXJ7glK5Hu+IMNt3R
 xVK0XiS2hHUy493X0RA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA5NyBTYWx0ZWRfX0a74hFItAI3W
 07HA/UMbbU/ACk69wtsXRUJzO9aDp9gCz79Rh6Lg9fnyHFaHcsVoNKEFfUNZord5WbIUce0oj0D
 qQtMKEtPnjt8/sdevzFtNEGdVJQcNLM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290097

On 6/29/26 12:24 PM, Kuldeep Singh wrote:
>>>> Since 75 MHz and 201.6 Mhz require the same power level, is the former
>>>> OPP any useful?
>>>
>>> Yes, both use the same power requirements. However recommended by the ICE team,
>>> the DT should include all opp/freq supported by the hardware.
>>
>> Is there any reason at all where the OS would prefer the lower OPP?
>>
>> I think you at one point mentioned some dependency vs the storage
>> controller's clock frequency
> 
> I think Abhinaba captured all possible frequencies(even lowest ones) as
> what the hardware currently describes. It's upto storage controller
> running frequency and let it scale ice clocks to higher/lower to it's
> max capabilities.
> 
> Describing hardware based information also avoid revisiting DTs at later
> moment.

I agree conceptually and it would be easier to agree fully if you
gave me an answer like "this is useful when XYZ and ABC because DEF"
instead of deflecting the question to the obvious fact of the
hardware supporting that OPP

Konrad
