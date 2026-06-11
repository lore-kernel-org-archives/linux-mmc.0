Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E11E346FA0
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 12:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781180618; cv=none; b=XKUnMSr2lj6tYobfM00GG0ZgUuW5E5N83+bWwroT7u6MM8raM1C4TyoGJg2BgxPLOfQW9qd4156W1ZjJ6JIACx4IiJrEbS2AYq50hPUAEbqI6OODpMYrN1WKAKuxdcJsl6wI+ZoOQnaJG3noG5RW8N1M7aRfNb4vr+6las6Lkgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781180618; c=relaxed/simple;
	bh=Up0TGC9AUDlVL81y+b9nF57+0CbKx535aaKX2JXMVYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XHc5K0WEBCMGsnfngNL9szcYqWXbyhrbI2WGuqsKDfShi594wkN2cmcMkbOj3b2kzIus1qQ8j7bAo+sRl7qcCXu6l+Ss9zrhn+YmjH/vfHou6hzzEkA4WqJDdfMOeUPf5Pa4Q2kaaetusNyqrEatb27Sc0UgzT2Hse/hKg/OIno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CR+I5iQl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a4GPVmlR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CR+I5iQl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a4GPVmlR"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B9xLCo2890671
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 12:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b9p98jHioztL+apkrbpHDu4L/Zphbn62xjE/pBSrzbg=; b=CR+I5iQlPQdsXKSe
	LO84UORERhKbegjou+maJ0fU6W/qzZG1kuXZsnBXKFhxvrm9Ngti5U88QrcgQvVv
	YEEQPgMwcJLKhbY4nSOi6kiBSWokRV/6nly37BjAH4EfJY+VRMQwE+eXqqYwrGSB
	8X1RCleRgSCjjz+01my7k5LZyteMLSPCsTv9wlNNRkDWcFtYIZcMuDRm1ofHgpm+
	gAd8lftZOsQf86LKTmGLD0c3WMeYnOYTH91Ez6xXCOupdUDbr6pzdR4zhZ+/LNmd
	8ExXIi2yDX09Ghg8XYW94O+EaG/RqM8iF9WRlvpiYZHKRzhTPmF4BX1oA4T2DaGb
	8M2fNg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe79ka42-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 12:23:36 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c2a4babe45so17561665ad.2
        for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 05:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781180616; x=1781785416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b9p98jHioztL+apkrbpHDu4L/Zphbn62xjE/pBSrzbg=;
        b=a4GPVmlRj3oHWri/Ne9fzytcqGum69H39RSF0Go7Fuwgbu6vBOaknwn+OVrDrj9nJ5
         EVr9LGtq43oaGsqGxMJbFHSr0TW2vCa1M6yUvn5Zz8QSkPumFde0khv5CGT40PubWnmD
         9Io63r13rrOo5NZise53BCjM38/THTVat0jhXvg/zfYTncSAA2sac4X8O+0mgM5w1/E4
         7os97h9Sd/h1BBy5hJBL/xpi/l2IQMJMJLIUj0pL9OKFkxp8vD6W1292LXZYDo/IuT8X
         Xjc2hdQRP8N8xFHXjsIji4PcFQMhYp9YnF+y0j6I8Cin0u7zAu3ZPpQSXXMONepameVK
         FMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781180616; x=1781785416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9p98jHioztL+apkrbpHDu4L/Zphbn62xjE/pBSrzbg=;
        b=J8lejN29/01ihtuFTmf+Nga1DbLZPJu+Bw6N4pz8Xa6H5RaiEEKJ9NuJw2mkyFa7Ja
         wFc56qevbUAoNW2FtYRQbEY/A6/eyP/7iTAa/93oOAvqiHxY6hOd+gd7yWHjqYGfjsf5
         21aHusfjYyjOJ+XNPRR6KD2R41jE2IcZKbdQEdd4ETPVLl3R2dQLk7pZ6T9pxweOyTNx
         1tJHdxq4Q5EEUyHvBQ11p8GqjTN3VZp4APSk4S7l73o23wuJmSUKbNq3PzTz4MwhRMAC
         yuJWZ0KV9Kb9cjVFHQCDf/H0BbqaCTvbDoN72ZZ6SNZdiSAfDIRAksp8rJC2sOmBSKNC
         ekYA==
X-Forwarded-Encrypted: i=1; AFNElJ/75VUK/JR+9VSyqqmult3qb8gdbLbRGqEErIQYEge9i6zv432Iyqxgf/pH+WfoEv0wvTbx7mLjD4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSxTPompFQVkZrWNCQcaWM5/+BVzGI0jZfJCgen/7eCeoEmUcJ
	SmXq9qmSVv9LX4qnI/IXd4UGd1vS9sxsFzV8P4jZuMMytz1hmqHux0S6G3lphpz9IfqOc3ghWkD
	mewr19c7K8b2mMAu6d2y5G40olNbSmbZHZXtR3jk0g0RtN7gkBvnwCSu/i3300hc=
X-Gm-Gg: Acq92OE/rU0/L0J5KIq5aD3WIwgD0WRekwCVyQa9B0yr89Jx40DZl7PwogDsNAx3/8k
	PkrGoCT723vHF1BSqWawT16G/3seXDtzu3xm+U30uE2bS0I+JcGnSVDain314Yltlny7vVxoyi7
	w4YKw264B6L4jWhiYwgeZczajbhWUzQb/KB0GKISPxJVDRM14CViFT5bJqwKUHNIEz2nLsKOQdR
	WWRlrZ1mLP7JR7cJUnLDfj38WNxF41aYiJ/lhHl81Ir0Vvs41ai7S1ykAxHxYM6M5i5Z/E15QaF
	nFJ2UoSG+Ys3rE1Z/Ox1iOlxg9ZsLoCDcZmRQR11qfRrWz+Cxt5UW39+vK9VyjyzkU6BQQNtdDD
	XmaF6N0lXXv11UvtedwmorUoc8cWE5cTXZxyALhYwFT2yrh62w9/+KW6mWT3rj3E=
X-Received: by 2002:a17:903:41cd:b0:2c1:737:bed9 with SMTP id d9443c01a7336-2c2f298049cmr28064595ad.30.1781180616163;
        Thu, 11 Jun 2026 05:23:36 -0700 (PDT)
X-Received: by 2002:a17:903:41cd:b0:2c1:737:bed9 with SMTP id d9443c01a7336-2c2f298049cmr28064005ad.30.1781180615613;
        Thu, 11 Jun 2026 05:23:35 -0700 (PDT)
Received: from [10.92.167.195] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f70660sm277319705ad.11.2026.06.11.05.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 05:23:34 -0700 (PDT)
Message-ID: <9661cc21-7f3b-433a-86e3-d1593dfbebd1@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 17:53:28 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 6/6] arm64: dts: qcom: lemans: Add OPP-table for ICE
 UFS device node
To: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20260609-enable-ice-clock-scaling-v11-0-1cebc8b3275b@oss.qualcomm.com>
 <20260609-enable-ice-clock-scaling-v11-6-1cebc8b3275b@oss.qualcomm.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20260609-enable-ice-clock-scaling-v11-6-1cebc8b3275b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: fbMIrTnRJ0gTAYDuNEHrh2eBY_AIMApn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEyNSBTYWx0ZWRfXyRTnRAcy4UD1
 puTEFyZLaRUk9BHm8Z/KvmFDz2LYFtNa8PeMgXe0D47ioMw7uX8+26C7GzYvBA8z6AE87it+Nei
 AvUKeou/PSLDZHA+dkX+ZLnoDMd+A5yWZo0Vks4MlaXorJe9Kqo6nAJ7YlhBEa+7b7rYeMF9IFB
 GrFu07urOqXsV9KCXY9vcf6Qaa5Gf5Rhy3umiMw23lO5eWAmF2hMAKFESmSKwMtgdlI/6JqntHa
 PpqppsmhXSo2amvqnXNkss3dcEtgteVeXnnh4KQE0OCNRenCtCtiReK4UHEyO6duQ1gL1Fn1Z98
 DS6YSCxk8yg25D/mjYlSQ5FuJ430edJCXApauGrkKMM5XYAVmwDOsL9AibNJyp2rJlL5WH6OYq2
 cgx7WPfH5ggjMdJwgMpmMi7qjVwBSSLO7RijHGbTY7+1gSRLFuMAW97POF9m0DRAybRqY24FYI/
 nVeLiq7lWOMzBcufFag==
X-Proofpoint-GUID: fbMIrTnRJ0gTAYDuNEHrh2eBY_AIMApn
X-Authority-Analysis: v=2.4 cv=fbydDUQF c=1 sm=1 tr=0 ts=6a2aa8c8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=xhZcOr--89cURCpmMK0A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEyNSBTYWx0ZWRfX/8zAXdhlVLFH
 RL8piJcrY4cKxgPJ144MoPUwpdzZhBBi7oDGxAkZF7XTHn+iepDzgxY0+S6Vuk08Bn22jtfUlDB
 EPWVMCI67eZQ/lKNCr1xIn1gVN6vJvs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110125

On 09-06-2026 03:17, Abhinaba Rakshit wrote:
> Qualcomm Inline Crypto Engine (ICE) platform driver now supports
> an optional OPP-table.
> 
> Add OPP-table for ICE UFS device nodes for LeMans platform.
> 
> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>

Reviewed-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

-- 
Regards
Kuldeep

