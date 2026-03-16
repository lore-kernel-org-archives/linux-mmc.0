Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D15346FC0
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773646039; cv=none; b=l6wxasHlwhLXvAgiB2iT1P6Zqc9CWL9afJQLqtBSKTp3qaW1DvM7Uz7+vIkPKGinVUk7WTftqxKVMxUl2JpVng83o87MW8Jl2ZPo+39yDWrqtnC3zEwJEoRtn6Bs6kdTwsAIgIpCRCgoaYUYxcFCTtYRaQAkpadMMH+yK3buUqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773646039; c=relaxed/simple;
	bh=idhP3raNCBc9CYcTy8C7XdEy8xQz3oMFvJUQt6kJp9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Thl4mMcwyLbt/Eh49hHzwUSFkf5dWv6DnVnKXPCWH1X9KAbiaNATWHKIURYRuQdTLROA+bLkx0xUqS9n1/nJIwdLnP2ch+tk+i8p5oh4QaqkOtMqm5FT/3S3jTIFdpyjMrxl98krO+w3CkEYZ/7kgllEaboIqw6HGA6s0FyablQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JlV0p3nL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O2tQ6LVG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JlV0p3nL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O2tQ6LVG"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64rVN2129174
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 07:27:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OK1uBq1HcvaDU6l8IK1ArJBmNEb/gYGGSynId4hWAm4=; b=JlV0p3nLaJb6ZV3W
	L+WI9NGSyz0XgCZJl9CYFvtLJHBYQP4jdieJFB7ehexKdSyYlZ4iadN+rtXTOrxp
	iFoNOIucy0yhjE3uI6B7EDYgcV+W0J2tXZrCn213m71D3WBJv4uStjT1giCY021g
	Tm8Upjs+VLrWtGkYXrJRfpulNbTXRTrxmKcVnXgsmawsINWU8r6DmQ6nCVCixqgZ
	Qqqhg0aIXWi7lekGFt23MiM8cSQOTLPgceRSfl/enL8FLFZNvRRbxlVhSp6QMSfT
	FNbRqu8yp5bqtl9w3u0SyrA0iYOCE694iGHTlEzKrYs9ccJJyV4+NSTk2s+XWPOO
	x/Ue8A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw00amng9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 07:27:17 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ae6dd98043so47344535ad.3
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 00:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773646036; x=1774250836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OK1uBq1HcvaDU6l8IK1ArJBmNEb/gYGGSynId4hWAm4=;
        b=O2tQ6LVGgE08wJ6Gyfjh5M3xxcPL52Ki3TNxzYNr5oG0+x3XY5dq6VL7NEjZ5S1hKi
         HzEwOq80WO7ZSTY2vdNyTJ84a8ozqnXQf1vxG+EyQqvk8dvpsma4g0UMBFSV/sCYDZz/
         CazyyG+V/occYsbTy1ygIX6Tibc1N8ouqPWbYG/hABFkagGgA0937kW3YdSTEdQzBeiP
         tuPh3YEkvv6K+SoZV7VcwCm9VccaDwE18H5cAj3g9ZUX40nY72bZ015yFoOPuwzSOIit
         gTiz7FELgi9FNha/8AkNWkOTsQL6etoIg1NYZbS3b6nTYBcYCsDYlyWcMy6Mjlpspt2j
         WJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773646036; x=1774250836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OK1uBq1HcvaDU6l8IK1ArJBmNEb/gYGGSynId4hWAm4=;
        b=epEl/YUibtUx1COK9PEJLb/dagQ358RNNuURsP41N3gsfG3k53UJDIfgo1UbESNtMM
         obni7uljHCAGrW0vkWT2mS/GG18GZKhixwRq2xyPfzHlKYCnXbWShi+SWgnA31Vs6WMc
         uHzPECuBjmxrASBFSsVjWI6UmK9DBlq8JjCPQ9g5lCYHBP9IhJ2yekaxiW8QfL68VijI
         k2TG/d3QiYHhUU8QXji4c36eP0wI4yItzC+3aqQjYe9iu9LY84XLLuljTLbYgTotc6S7
         vJ0DlnqH5twOz2PyF/hfl3F3kcAsms1vSuJKn5eKa+NTMrR2wZBhBBK8qkf7DLidjD3U
         jOUA==
X-Forwarded-Encrypted: i=1; AJvYcCXD3j2nc6iZNdDxG3Bt4f7gzgKZCButqgn9dKgt/bM+xA5qsJJIL1WO5eibgPIswV2DyQjJo/Jkwso=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkBAqPJn3tt1qjPXx3cP3IM4T1thFz6W9PF8CzdnyTDVk1DSVC
	wKdg4bojs9nOYIEDLNu9grkbpGsQhLr8+Y8srJtoKA8P6oS3fqYTg5xVil0QoUaY7PBEqwjgaUI
	A3N130CjmdX/BEc93t/NXFJwGWhtZVvHuSe2I5NB2BcOzoKOA5gHngv3F7b9nzW8=
X-Gm-Gg: ATEYQzyBLrXtQ3su9MnTQ8i9ZsftlNtOpfF+ptzyjadgs2JEMR71mZZ9QqnpLUqa4Rz
	g+gcKlWHZfJbgX7GWAWFaKneN7ERDODT0loHedl8QxBGez+IImzE7HXMwUzEXEV5lkXDcxSpuLf
	O6CdfMDQPVeXIK6XIbPHLFuT5O2mHUYDcKhpUT2rutG7LMu+E5yqc5D1w8KzATIR4RwupwzlrsR
	hVRB+Lcxc6uYVHM3aGn/iN7WDE86yQkCfIlsTqt2O97bgj2kxk6BTseX3vE3QHkU2ks0LxG/FCL
	hAE5DhntYDLPv2TeVG1maJs0Iq+v7JF16qLMIjmWlofJQgHpdt+WXmFm1WEORTJ/Zs/kYObzL3Z
	1BeCuKLfbJ2q4jeWQf7IjjBMVCIYBp36b50Rh0Zeo1EABljYSHLZHY0nagPFc3Q5qPg==
X-Received: by 2002:a17:903:94d:b0:2ae:63a4:3baf with SMTP id d9443c01a7336-2aecaae66d3mr113855665ad.46.1773646036222;
        Mon, 16 Mar 2026 00:27:16 -0700 (PDT)
X-Received: by 2002:a17:903:94d:b0:2ae:63a4:3baf with SMTP id d9443c01a7336-2aecaae66d3mr113855375ad.46.1773646035745;
        Mon, 16 Mar 2026 00:27:15 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7ee9f2sm99694215ad.56.2026.03.16.00.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 00:27:15 -0700 (PDT)
Message-ID: <9b49adde-3414-4e2b-81b7-ecf54faf40b6@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 12:57:08 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Add minimal boot support for Qualcomm IPQ5210
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
 <20260313-serious-calm-chamois-4a0af3@quoll>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <20260313-serious-calm-chamois-4a0af3@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xyob2x0Kzlsqe2y10DTIH3o9-mAqHgne
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA1NSBTYWx0ZWRfX5Kfc75KdOarL
 Gmk5B0iwtarW0Sv8imlf3vR8UGhhm7QivpApo38KjIGlx6RHpiXqV8T+kq+flqZCg+jtda94Wml
 44YVU+9IbalqTP1T8olztTxOFxMORsPJvO5cTjRrk9AD3vDCxpJR7y6qQAAZQsAcM6kLr8x47LN
 2gbxGug01yrGIHwe0UlfsF67jQZAuTF7Z+7EoKMZrcNgYORL7yZ48T7b96yJfr8b/3x+M5qjGTr
 vyMrnGJpysX6U2K3nYX5vJxRqErrX4y+3DORI4qJERo2mlEoCUg4QgG/zy7HB+AUupDBUqONGN0
 rwtl7I4LYwEBECIh8UR8poyaC+SHI+P1OwOO4c5PnSrVGINqIaJ9ks8yuCFn/R8MRD6SHPi28CN
 cxy4TvAhYeLxlUooNzIWZUBGcbZeCyX96sKr1jEdTQ2VikpkWXmkfKC9nWbQ99Py+UPqx+V0mEE
 Toaivyh70aI/esoXqqQ==
X-Proofpoint-ORIG-GUID: xyob2x0Kzlsqe2y10DTIH3o9-mAqHgne
X-Authority-Analysis: v=2.4 cv=ebIwvrEH c=1 sm=1 tr=0 ts=69b7b0d5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=e8CD1ygSFDIBAwsAQqEA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160055


On 3/13/2026 6:55 PM, Krzysztof Kozlowski wrote:
> On Wed, Mar 11, 2026 at 03:15:42PM +0530, Kathiravan Thirumoorthy wrote:
>> The IPQ5210 is Qualcomm's SoC for Routers, Gateways and Access Points. This
>> series adds minimal board boot support for ipq5210-rdp504 board.
> You combined around four or five independent subsystems. Where are
> dependencies and merging conflicts/strategy explained?

Sorry for the inconvenience. I will split up the patches per subsystems 
in V2.

>
> Best regards,
> Krzysztof
>
