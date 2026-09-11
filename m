Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CBA2DBF75
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133735; cv=none; b=Fi24bUjgQ/sa38woJ9EZVfi7Udle+BuLchOdcyf4V3SAtiN59XcTuXfOWbRpGfjrltUrQIziBZPU4wNC+YKXoK7V70OktzY/ArJyBBR+tYal4RfjW2qsJg4Awiwigi3CjhrlAb0gUqi0uP8/2q7jkqSOcNBW6H9CC3iQ969QyGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133735; c=relaxed/simple;
	bh=Bdr58TASYAcnDyr8NYgzvmX/VNnrlFvX5qTimGt4OLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXdVKKVDHI3qTI1K4wS2nMvsTg4H/qtTRQRBv1GP5NWGrQLnSd3HDieoo5GeMjLqu32Ojri3ETfQ4GcAkhQiWIvFipMgXSu0rKvu7cOuPoZlFvCS3qvURF8DkpYY+an3AtgYNDNdgbbePSg8hZAj0MwDcEwv4SuKD8cta5RbRhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QS0btX3V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iVKpvD/W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QS0btX3V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iVKpvD/W"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BCjZE0524805
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 13:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7fDBLHg2JhK2hYvJq0Kdbjyb
	j3USOEIeZfURdTQMJP4=; b=QS0btX3VTC64YMnoJ0GS1sbqxEsPlWBbiO0cKvwV
	WZAQTjjtoRpG72dSt83l0Rv3CBXnFLuYD6YfMH72HScYda8Y+tW5eEA6vBMzg+Al
	Qx9jCO/3SaD4tXTzS5DypjFJQu4f9jXgRBXEpUIEHRcLIymgY3/57czuEXtXeTms
	VPBh+tMEZbgtgxe2XyG2njcmnaVDpS9eqIqKtuC9nWU83oNqDzPOZW2KcddrYLmE
	P2gsHmWe8uSq1XrQQwj+Gr4eE/G4Zrc/UU8A52gWZNDd2HyQgBBX7UHuZtkCf57l
	CgSrBC7fDh/+nB323OL7SWYvGDLrndMwuZP9GiwVxv9kWw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gm2q13rev-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 13:35:33 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93771aa0379so163037685a.1
        for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 06:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789133733; x=1789738533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7fDBLHg2JhK2hYvJq0Kdbjybj3USOEIeZfURdTQMJP4=;
        b=iVKpvD/Wx5ttv067ZJzAwzpPGeZpsH4RQoUKAfv5CIRMfW/4SId/cPYKbog8AI7wlQ
         se7PihJqxO1IyXiIIMYElf7+r7vy9Mq0IS8QwjwzCmzU1hbzNd8ybatf8ZwYHf87+MKs
         72gkVswm0WUifgXhfTjsmW7HYUZTprZVsNjlo6MoB/bM7UWKMPhg4Fq3LFokRGeoZT+b
         DxCWLIbjLewLse+Nmz6SiIZoe0/SXl/kgm8wXMFqcYTq2siVnuqAes6Hk5AbMemrUc+n
         glfPxf0ZuLzT4t+ZwopRwlpm95XzPPP4lr1ozgpA8I1fxlQ5yg07PYpLL/oesqXgU5xB
         bd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789133733; x=1789738533;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7fDBLHg2JhK2hYvJq0Kdbjybj3USOEIeZfURdTQMJP4=;
        b=TsdqN8SNxvw2qH9qkOnLGqFXDDd1mQhGCMSlH2LYzrBm8K79ciPhLlZuXz8zNK5Y9F
         OIepYBfqUiLRWLH4Nab5zi3NKqevrnwGLRKv6wMQgQPO+Jzfgf9+H41WWo6zszeEm9UI
         XXefNf479ro8t8CktWPa5wJM/F/nsY3pJheiYgeWqx1rXv/p1bB3gi+2YuQ8NG8jSVtk
         PKXqIuO+AAF5RUcPtqcwYCCfjgopnNLtJTf2JiYqVeQ1b/vv2E8vL9DwKUuM4JaDtvBp
         K4Wp4ogAoyUA2EGdTap4Pxc8PJq0rArX58dWiQvqYgFP5tyan7Jd1B8OITFZ2DKCV7g3
         v5rw==
X-Forwarded-Encrypted: i=1; AKwUvBwskJnZHq9iIPkaThHUVnk2hD5ljeRM8LMNl+AMevHksGYEFGOxyCPk2Bcuzu2BADbIYtZP5R2uHIY=@vger.kernel.org
X-Gm-Message-State: AFuF++mvWPro04LO71rOCFbvonAq0pwe+PaJrHbtbhU+GsP07mk4EetD
	sizs76HbbUUXbYhS4wMXndftDyguq4i09ILWh7f7VQrqvOQB9I2u+bRbFo1WVKODgyWVZV7orIJ
	V4UAlBRqSrY/g/cQr4AF5t4i1WKwPcrNhgRgPUMMq9qnK2aEf4On8clv+pU96rzE=
X-Gm-Gg: AYBFou2KLiL1+PEGCYeN23WoCQqkQvQfel5VS7Z2oqdZjwoozhbULFUjFWeygNzIhVD
	rbAogAE6r5kuFJtR4MsllMhgJkd/krY2dVvx5qtJ2gPq/Y1K4LNQXauKCOobm63glfiKP7CF4mB
	I8yHKL3nu0XZSuDu4KT2XEAKsTrWx2RLkXFEntkIt7oyK9PandD2GkV2OjcojU6TcwJRmtz8K6w
	mYongd6JgG2TSKDm6Qg5h5wWfhzhlMaYgCYlDFyhheXC/zzDPM4Y4IyneAH3doEEVEEZvXXDW4k
	BKa+sTyLfjNTl9ZuJM3gk/sdPPM+mj6aQK7tSefniEITGEp2Hr3Ni12wUIC78yjcOLTGlbi1rBX
	cbIBWpj7WrW09qGU=
X-Received: by 2002:a05:620a:630e:10b0:939:f978:c1ab with SMTP id af79cd13be357-939f978c3b4mr135522185a.4.1789133732679;
        Fri, 11 Sep 2026 06:35:32 -0700 (PDT)
X-Received: by 2002:a05:620a:630e:10b0:939:f978:c1ab with SMTP id af79cd13be357-939f978c3b4mr135511385a.4.1789133732044;
        Fri, 11 Sep 2026 06:35:32 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb350686sm6290623f8f.27.2026.09.11.06.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 06:35:31 -0700 (PDT)
Date: Fri, 11 Sep 2026 16:35:29 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Monish Chunara <monish.chunara@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>,
        Kernel Team <kernel@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-mmc@vger.kernel.org,
        Nitin Rawat <nitin.rawat@oss.qualcomm.com>,
        Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: Enable SD card for Shikra EVK
Message-ID: <e3h3volimyab5h6nov4bzassb6qki72c3wev3h7yyaxkdn4gfg@l2f53ch34aru>
References: <20260911093932.2376058-1-monish.chunara@oss.qualcomm.com>
 <20260911093932.2376058-3-monish.chunara@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911093932.2376058-3-monish.chunara@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=d6lgWhjE c=1 sm=1 tr=0 ts=6aa403a5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=vBACkDl9X50tgIqftl8A:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE4OSBTYWx0ZWRfX2ClYhYmO+rNr
 tEKlYnN2jtjO+GED7Ps4sWnWjIS1RTX6KzNkItpMJPkTjjXwgt+lrCSU+UUW7Gclh4xbn3AkO77
 WwjGJTZJuUxZCVxFlbTv6g/0Nsx+LoU+n+IuvqUigguTSDCE/xrZhqF7ApaW6BAZY9AUZaC4ZUh
 yq32HC4/Dv04DxbJbWCIIZUTTqqcI5VKXZvdSB6yclrnp8Gp6P7bPoZt6mGbn55/I8nw3vk3oie
 1Rn4U2hW0K32Jz7XYOWb2GaPf8aly5ms78wvEYrFqTDZY2zp8671F9vh4YvF/WqaYsqdjtyTGCh
 DxkewcsG7HDkQ1gOBTu3n9cJK4vF6VD7kbcR99toUF2c0gpdf/7N4TTt9oy+5G5J58K4aGjF7+b
 HQt7UTpKU6hdfQPmJwKETMlL6RFT+V23zwR929s1svJnKdsXPBjdz1g+DnSv6ZzAimOcPrn97vq
 y8xjilS9amsIgDVPnVw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE4OSBTYWx0ZWRfX4akbdFr3chvz
 j7SpS8K6saioFi/PO3rz1zh65N3/Nq6uqqQ8xDl8NV1EDha9xwa4R2P/iN2KvWO8c82wrAE88Gt
 7EGctmtUJiNqZTlBEhn9CHJTp0vMUeA=
X-Proofpoint-GUID: BUSQ28IRV2v-C_Bafa_fN7-ylxIfo9kt
X-Proofpoint-ORIG-GUID: BUSQ28IRV2v-C_Bafa_fN7-ylxIfo9kt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_04,2026-09-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110189

On 26-09-11 15:09:32, Monish Chunara wrote:
> Enable SD card for Shikra CQS, CQM and IQS EVK variants. Configure the
> vmmc/vqmmc regulators and gpio-based card detection for each board
> variant.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
