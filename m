Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BA93B4EA1
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 11:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782734072; cv=none; b=aoow/kqoMBfvvfiK+M5ImBmqHKqsCfkqqiliY9FQ/wqqjMN//R4SAPCnB11VtgoS2iZI6qlWZ9nE9SEdS2RuO0Xpd78F2GWKdxCwqr2RmhlJqxWTWZLehJufcJECsmlkl66ziUuxFLKwwQN1n2ciUpdNAOVBqhbUMUsH1gJY1EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782734072; c=relaxed/simple;
	bh=eCoQyVtCq78WJx8EhlxIzy5RU6WrPRoRkxI1UymA5i0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mD5yPMVaCS5cBQzTf3cpi7fgbrLV62tNQJwWHluUfbuo2imSf70xkriHtwF+SygHONBPmdNSwT44Zw0VWxN2jMQQpZN9r3l+heT9Ydiw48/hIbOGG9FajQBdToePE0zeG8FsMi5XNrg8SKLbdokjk0LxsgNv117cd/HhgkB75Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KWJ/OGHO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MgoJWQ0+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KWJ/OGHO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MgoJWQ0+"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TATRE62592825
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 11:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mClBGsqoWOU5Y6dPYAFiYMzKLsWSBIwtM2ZQ9wxOdWc=; b=KWJ/OGHOy3hAcNo9
	UzU4CokIPrcBqZ60217gZPnWujuY3+qXs70XY30HzJRUE9zVsvYUORn2N+kDRkIN
	3I4Vlv4qxlqb2xDhvVLIlLjVs71QZhehLMkvgipgJUg+DL29M1tqjS8SsFV4am5t
	Zzln5ZA/5DGr0ZO4L2u0a6/a9GuL4PorjzMZvayJkIyShECec9Rq9XqRdpQcGLih
	Gcn7vaNwMFK0D2n8tyFg/ZrUtKkVN5F/tZDgaeoxXLIMRTuFz2sl/bXqsx2bFT6D
	FHNejihq41bXZLtBqnnm6jzwXqJNrtLb34XJfW4u25vzypcqmA/oXgSgY0RgacXt
	75H0eA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3k7vhg0y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 11:54:30 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-96927edf751so84166241.2
        for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 04:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782734070; x=1783338870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mClBGsqoWOU5Y6dPYAFiYMzKLsWSBIwtM2ZQ9wxOdWc=;
        b=MgoJWQ0+Tzwt1MoqsgPha1hpsxMSLt5uOhTTB8M0Wg9o7D7fA1QUSVSEWZIjJK7AiQ
         z0IHbU0oAEEAOkEHwvHms2I/jkRQG91OJ8BAyC5yk0U9xqkROPWhEr7TeArccVzcBJRA
         BtjFQOPZc72quxzwAWPWQn9Iy260yGYPhDQDzk5vFBLOg8f2cuGG4llswjnJgNxcX1xy
         w21XX4L6qKEYEyUCqtSMHgl1Plu7y9DHZaqf2mx4z0gLoajB1iUELJJhrymiU51jVwa+
         ycwmNdRMAmyayr65Wz0MI80YyvPqW9sgObRw3IIA+rJA9827HDqT/0SVAtgC9FeDprh5
         5lFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782734070; x=1783338870;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mClBGsqoWOU5Y6dPYAFiYMzKLsWSBIwtM2ZQ9wxOdWc=;
        b=rzEDd54cMdRp0pljkuGNzutUKe5vmL0n2TuzzH/X8B11exgonR2EvSBnC+S6LqT2pG
         08p8Bxj+qCe7vYfwvBd8NTG3T6tw/nEt7H5OnZ5RmT6sV/P4fhI4WdNVoKAdIovcQKn0
         L4a0fOBaVCZq/r1jERkNcu12JNt0ykCtH89kfNx8fsy2LV5FZM169v2+lIhAZCB8evE9
         e2hG1F+WxHgPhfNDx0Qqm6OAox62OzobMSN1araD8U8S6NQmNIzsVh8+jbr3Wjibt3Fp
         CW/+na1hbatQUsBc0zTmdtAQkFT9oVMe61mDmuDSKQG2JRXiURxclZxGhfBCa6ZVpCEK
         NPig==
X-Forwarded-Encrypted: i=1; AHgh+RqlElRlg4ewiuxXOHxOFkJWpGqbu4RH8AYexLY7FwJ+Ihsw9dX+aOsJoyqtRkkeDB9ZyxMM5xU+yTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX7Iph0t0KdvuHr37D0EVB0wwjm4AR9vLj+wNsvGeeU30tuKZq
	rdNxv0Z+Y/NP82k2YV07r72/o+FCYQp+lkaQfCXoCMONNpH08xwMV8A/qOq81dcRxlJnub2CUxA
	/P6GTBRD9QN0HkKXWjN6qEQwXo+hpcO9qxiA/sW5qQzimY7+1MtTvBKKNryZlsAqvtz9PK5I=
X-Gm-Gg: AfdE7clHd6Icm5Mi2Rtn99WD30uB5430Nh8MLM2Nzvdjia2d6cYnz/Ioji7VYCuyx6F
	Gv4hHbTeDy0dXmOKFcpH46PbeimyzjS9PimP7jHgLx8nmA8+wdKKW8d4ERdilCQQOY2z4LXRXgy
	jQyhRDjeXDpASGTmelQcQA3mDMGXwUCNusrYZpr1sF1bkVU8h448advYd2GWGgcKTnDUmTzyHw2
	/9gyV7FNEg03tNvYaIRbYtw/74k7CA8sBQRetC7Je0eUGDbqV9aaql9U2+w1X6OuNpNvnb1GwCY
	TLssP8OQ9n8eX/bOuOZz4rnYMS8inr8Fgv7WEEjuW+GJXtIT3P04X+Vk/NpbWM80R7/cV6r3I7C
	Ec2vNGmuQ6h1xCDLGpVYHOgzYBQm4CgJLu6U=
X-Received: by 2002:a05:6102:424c:b0:6c1:6ef9:db9d with SMTP id ada2fe7eead31-734360a22a8mr2291989137.3.1782734070168;
        Mon, 29 Jun 2026 04:54:30 -0700 (PDT)
X-Received: by 2002:a05:6102:424c:b0:6c1:6ef9:db9d with SMTP id ada2fe7eead31-734360a22a8mr2291987137.3.1782734069795;
        Mon, 29 Jun 2026 04:54:29 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f3ac461csm6825877a12.6.2026.06.29.04.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 04:54:29 -0700 (PDT)
Message-ID: <ba96f5e3-6b6e-40b6-b6c1-300e862e8ee4@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 13:54:26 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] arm64: dts: qcom: kodiak: enable inline crypto
 engine for SDHC
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260629-ice_emmc_support-v8-2-1a26e1717b85@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TAUYvpFsiDfsKfno5UqB65zcd6CSI6e-
X-Authority-Analysis: v=2.4 cv=CqCPtH4D c=1 sm=1 tr=0 ts=6a425cf6 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=YH5sNaOiGQQzhtlTIYYA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA5OCBTYWx0ZWRfX+8ojZTNiZBTo
 wIDE/r6CQ4J92GHDY9j10gorNLVjlZ4U/nGE+o8P8tGe6PiDR70fYOLtp/mUi9PWwW1l3ZrRaS+
 HjvrCdVevoUnDMYclhOLW0v5hhiV+Yo=
X-Proofpoint-ORIG-GUID: TAUYvpFsiDfsKfno5UqB65zcd6CSI6e-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA5OCBTYWx0ZWRfX4F0W4oNitQEW
 IRWe+46E7XI+o7fIB0u0l6JZE7uBqWgf9evPrgJDqoOh5D2mUXvspy4/lZLtmr1nmRCXa2E4mzh
 Ddx8RK0niqwYiFwF0Ou/FT3EjVUW+GI4j49H5xxJx0rTJvYM4LrH8CHgLsPCCVZTHBDJ4RtQFbx
 z1kntqHgFzJhXobf7N/QFjg+IydhW8rb5KClqemb7Crqghq5LkqWlTr9XKAbpCl+CQ38XncGsQ5
 YiiWmot+he+Tl6wm0NVC+ckNDFKapR4iAuEvJaeNeKnx5WvnuPEprF/pB+mlfLsfm++NryFWTBu
 zRO+9wsk9Oqn3z0Bnax/JIn3vqDGaf85S6huYWWzJt0bkMiqpojaC9ldj5DbsL8g+HRguGKQqzj
 zMqh2QwtSPjq8TMyg3tO69h35R+qZVyA+7sAN66bg7QkBjb7UzB/bWBK51Q+DwWZXOdl9N/BUQr
 cUBdw3PBT+ezGNdJ4YA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290098

On 6/29/26 9:35 AM, Kuldeep Singh wrote:
> From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> 
> Add the dedicated ICE node for kodiak and reference it from the SDHC
> controller via qcom,ice.
> 
> Keep the ICE node disabled by default in kodiak.dtsi and enable it in
> board DTS files where the corresponding SDHC node is enabled.

Is there a reason to disable it in the first place?

Keeping it enabled it would ensure that the core is parked
if it was left on by the bootloader

Konrad
