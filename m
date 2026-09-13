Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BB2331EC0
	for <linux-mmc@vger.kernel.org>; Sun, 13 Sep 2026 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789312822; cv=none; b=uyGEOB/+56f8RBL6BoSCEgUI/uDJNc0y8lMdY01aqcYKfBRzqpnDgWGl3oxkeibq7MdQ2iKZTkGEWT7F3+eBHsKl1vQ3B0JJBN6zbTgTfmWmwURRu3ZReNLgwgV+telpeAF9Y7lGFCfuUxjlweUW2tdiCj6JctjvR5jgA9dBQPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789312822; c=relaxed/simple;
	bh=8SqdPP41lYHYCTdkr8owB3wjXGz3LwpStONsz+DELzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k5CaUgMopp7Cibg8WiBV+Osh64p/KUxaUP/YEQl8cC98wOBO97UjcrA6o7xhzlr4vZU4X0BzqhLA2jP1wlRSYQjugF0LiclLfaHhcQjt4eK0eP2lIuHxGYQzzzzXd00gSRLUR33RhJVneZytMdVgMGt/xkZrtndPNQrKnVStPeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UXUdYpRw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RTc14yDV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UXUdYpRw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RTc14yDV"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DE04BZ2481025
	for <linux-mmc@vger.kernel.org>; Sun, 13 Sep 2026 15:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8SqdPP41lYHYCTdkr8owB3wjXGz3LwpStONsz+DELzE=; b=UXUdYpRwymBhpkca
	0NdA6NdoWFF89CdeqIkpAQywZyfpkF9as8Ev1Vu/t7wmec+YDYbVVYvsgTt7uk9z
	58+Sram/KpKxxPnIUCBe+04SN0yudkAx+9jxQ6CYiP+HG5K6jeJx3A2lhkitPPKX
	VWEHkfdk7Thoo40SQFDalCdDMCrtlTM2h8Co9QynU+6HeIVYlCMxzfM9QW/4h02b
	3qhf+FRCDlxAIiliZ1tG7r0gs6Tfq3p8FU0w+Tu/MhiRtG0ToUmhT8KgjyrhP3lL
	9FXHnd73IFTMKrTyJjpTqPOIdwVLYrkMiVLSfLTqrPWgHyeR8d2FbICFmgTRbHTm
	gsM31Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dkj7s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sun, 13 Sep 2026 15:20:19 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc4922b7c31so2436972a12.1
        for <linux-mmc@vger.kernel.org>; Sun, 13 Sep 2026 08:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789312819; x=1789917619; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8SqdPP41lYHYCTdkr8owB3wjXGz3LwpStONsz+DELzE=;
        b=RTc14yDVaCHcKb8Vx2XqODh9J30JLFXKA9rFhjlbof8mIEjrL8rf5rcsVbBSQfHctI
         AgO/BNG+jqBf4sVAprUjZe3KMVFaMIlN+/bT9hlJIi5mhCtJQ0NrKNSyTfsFEf8A0FT/
         dpW5gKfKZiHE3OlP+JEd7XYJUi9bWjSPM/jO9FZXMSxuGr6GKfcHzM9uSyTjnAmYLtvS
         AnfrtRV+GZcgYMAZ6idcfnf5WacAom/tBuaIBCpuUDlBkMj1HIpPLKspbBWdc8ZRj06s
         9ugX57bTh/vhV4Jzuxdb/BpcF9vRCcmGYJ41mZuR9l/PzbVIjjakdszijdbkSEGQAl9X
         VM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789312819; x=1789917619;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8SqdPP41lYHYCTdkr8owB3wjXGz3LwpStONsz+DELzE=;
        b=GSIyZjkv1uTMHJSeJ5Aa7SuKH++viqm9OKlEWCWhn6vct4fhPDFLWiOJ1+SkO1J3ZA
         x8TGvLWC71XDNwYe4TNCOMVdYsAQr1Inx68BggcosPVKlpDaPYdMmTmz878S1nCV5vPh
         55J64G37KRzD3M5ornVsYfR8XV9Kk8AwZiavq5wbdfLhuVNwaSr4yRtx2TlX5cLqTgj4
         kj6CWRPcWydn0Vi94yJ/NrhnrHlGho5t0vJ9o/BJac2uisLL5EEFt/bBbpquw6HNs3Pv
         Vh/chLp87YzdmnL2pb2nb3Z9sjiEqQNaWGvIQLDXgIEYmNyP/jgS7KaVL/ky7111mjP1
         QtHw==
X-Forwarded-Encrypted: i=1; AKwUvBx0LlE0tsSg2AF8LVAQMZiYAkvxuUXDJDIjqSMP3phTdF4RQRIIz4qGrIXzT2GJRcQA0apME9onYMo=@vger.kernel.org
X-Gm-Message-State: AFuF++mbiUD0g+h5n8gm+rs/Zy0ts6+Ts/rwVRXUgD358G0F46dCJFPR
	5dExBOPfpBComX7fIqzvWHPu2iErkIaqq5i7B56c41wKN4qmeBqMA7R27RJ13YRlSN4eEysczkt
	gXSGZdSsqH4IONiEBpQdEYUBAmEROvO2HWvMhSw3F5IZiL4vx3ubUTy3tF3UlV6Y=
X-Gm-Gg: AYBFou2blCep3xvK3/GblN7FE03KZmoBSOdDFZj+fVKYEMJ//k3d4Xs0pSQ0lBkKHBl
	Azi+rjrAR/84gobKjXdNXU5WeNDgJBR7R7gVM80JY0mzIWyEZMMcrbiSBQD6Vid5Ag9QRfWdnQL
	A4KWEeZ5Ngx+QsRNMfQXXNlP7OtdE7cF5aswhGvDP7gkqvzCzAvBWtv/BXDhHelnehPxH5S0+Ej
	Wjsp/vp3k5CLy1b7sP9Lo27yxX5uQ0pIr9sUylrA6hrZQbvAgXOM3MfL4hvt/QXnNXQEkSw1G8E
	6ZJdmKMxvOxNd3nFb5gsb5I78a4SA1BVQK6Z24x0SuKK6bHqw3+gbcf++yHNl2YFQLPBxiy8JkK
	+svy8cmk1o+0M0fqBEafEXMDfa9OmFA==
X-Received: by 2002:a05:6a20:939e:b0:3d3:adbf:7784 with SMTP id adf61e73a8af0-3daed4ec53emr25613312637.25.1789312818697;
        Sun, 13 Sep 2026 08:20:18 -0700 (PDT)
X-Received: by 2002:a05:6a20:939e:b0:3d3:adbf:7784 with SMTP id adf61e73a8af0-3daed4ec53emr25613246637.25.1789312818313;
        Sun, 13 Sep 2026 08:20:18 -0700 (PDT)
Received: from [192.168.29.166] ([49.43.233.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4cf72dbsm22243050eec.3.2026.09.13.08.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2026 08:20:17 -0700 (PDT)
Message-ID: <93c23619-f5e0-4998-8da4-9742d9e9be9d@oss.qualcomm.com>
Date: Sun, 13 Sep 2026 20:50:09 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: Add SD Card support for Shikra SoC
To: Monish Chunara <monish.chunara@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>,
        Kernel Team <kernel@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, Nitin Rawat <nitin.rawat@oss.qualcomm.com>,
        Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260911093932.2376058-1-monish.chunara@oss.qualcomm.com>
 <20260911093932.2376058-2-monish.chunara@oss.qualcomm.com>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <20260911093932.2376058-2-monish.chunara@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1s_vPLV6d4vC4kA6pn6HruF782wFCryV
X-Proofpoint-ORIG-GUID: 1s_vPLV6d4vC4kA6pn6HruF782wFCryV
X-Authority-Analysis: v=2.4 cv=NelzRGD4 c=1 sm=1 tr=0 ts=6aa6bf33 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ygYGJKfEQ+goyyaro2Znww==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=UBd3s1dwWAu4bQkakUwA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDIxOSBTYWx0ZWRfX14eUAJPZHkex
 ZBHMLcYIJAuPv9BzsVqWTMyJBy0GIL9P+ZwJ2c5XDHjQu+Q/VW43ZmgC90h9ggDzEBHhB+7hGcq
 0mVBAMOtoZQtEQc9nECfaudHUTC6i9w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDIxOSBTYWx0ZWRfX8iAxlTZ9g1Au
 MYh2eej1OFu5uHo4gDxFMe5boPXE1tzMC7jmCEfhdSHibX3iMqKLFQJBLyJHa7k7jarznj+5LZp
 8GT2VWY/3THKKNuiBwxrx7wwBVPoq/6bvjwxfKdHcyDBZivnAT/Ll6qppJHXK7L2VTLxvzw1PdM
 xU6GBkaavpHpwf8dwFzAzAUlXb0vOjRzW6Z2sYVOkvGJyFTMcwdIp9nQNWgqQm0V0vj22JYjXQK
 wJs8FKXzskN/pRolVGLp3TgpaEGJIUPmR9QG+ORXb5fKf1UkCwahfgLVw+Nm2Dn5rmCN9R9Mfio
 yf0yCGUTVRlacTAPFbI4AmscwCFAiYbG61gyqL4NzFPi4cXrTaibmF5/fovJqrhbbAdDVpbzYvf
 Oim0HJUBBq/30dLv7hEW0W9q3HhQ0uo3fepsz9/64FC9ICIrCZ1Pn6IA3iXo7VYDPiu1FH63je0
 PFrFsroDoseJodNaBkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130219

On 9/11/2026 3:09 PM, Monish Chunara wrote:
> Add support for SD card on Shikra SoC and enable the required pinctrl
> configurations.
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>

Reviewed-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
