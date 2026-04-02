Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85453385A1
	for <linux-mmc@vger.kernel.org>; Thu,  2 Apr 2026 09:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120817; cv=none; b=qRcrKgi7MNLThDp6qk22vrtA44iVA6TpifjOzWFdpKMzVQKDmuAtIt3TR9yblJA6+UwlvvY+S5vW71cboYJ6JC2tX74PBFGo6Bi+UY222G1O/FT5gb5iJKeygHV/Ue4LwrKGcKPEg/Xgkr3hZJyxFC1y/d+u+Xvyb/arMGm00Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120817; c=relaxed/simple;
	bh=OCAMB/XWu4jjvzZYi74jIMx7nKtjpOVuKvIQDoMLA84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8XnFg4f3w+KXcoYH7mirIilF+axz9O5UE6QO65A+ZB6bygzJY8C6DPgcS/BjFfJkMwkWLOrAkJzzvgF0zXks4LfUyLBZJq+bKBTT3EGgVoxvc5a+In9Km5XKUCkjpaQIgc1a0mU7ebPK+cBJcpZ3W+xA6UMnAXfCpQXtLvYUZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MoSR3gDL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R6fIZSvF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MoSR3gDL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R6fIZSvF"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63274oPo547072
	for <linux-mmc@vger.kernel.org>; Thu, 2 Apr 2026 09:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eBHKqeFSeF5T06Q9DPdMvQmEY7TBogBNE3S5rXljXac=; b=MoSR3gDLAMqvU4Gb
	Lv00AonIZIak/0LXbvReEKJlJ7jbPkYETCsMKWj3U3mrSZhgRnsmOsQqENQik8v1
	ChEcV5vueBoeBo0L0H3WfpBsz6Wp2gM0WaW6OdkvPPRcMtks5dq/uvlc4fMabUAB
	xEO6DSh6b5DshioL6lKaApHrNC/lmYXd5TA9hB/LsDoE9eN+610sWY4IX3QF5/2m
	vaR83vCjWcECotYGDay1tiCRmUgVlCXdozyiBIIAC+6MhXbhxTLc4/Ay5Z7MdW7v
	dmVvZ8s6ys3DodutNJetsw/S01paj0b6ra5ZvdrPxDKpKdo3fuBF5u2f4Z/lVyPZ
	6TrBGA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d94vvkxkr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 02 Apr 2026 09:06:53 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35c1107da15so716561a91.2
        for <linux-mmc@vger.kernel.org>; Thu, 02 Apr 2026 02:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775120812; x=1775725612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eBHKqeFSeF5T06Q9DPdMvQmEY7TBogBNE3S5rXljXac=;
        b=R6fIZSvFDt04IFGKed/hYoOHnP2UmD+SgUIyCEF1+nwU6bBqtBkOQsXcRVZta0hb4e
         mRILwni0yIawYOjewwW229ylEiQZUWzkxMew9IH0qZqV+8RW6SIxXaRv37hpuBeRP/q2
         pAGoUozL1eRed2tu4fJvfCpvlfsEL+GDV/V2oJSFbxPo9uDvSemlxWiMyVURs+P1ucZc
         jnxJLA4LtDpo3GN7PPCLXota5cnLI8NTR75/QgX12W1f1OUyRj438uPmcLEVER4Svnex
         OnBEeegABJL+GjbS1W7dwW6JwzjFX8zyEMcu/AlblExfDO5LyKlgbF9ROaMTk3b3zTMD
         W2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775120812; x=1775725612;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eBHKqeFSeF5T06Q9DPdMvQmEY7TBogBNE3S5rXljXac=;
        b=SnUU22tkUf8YKQ6PCExziYB+PhRctrvMSYr4wF4mj3MXeKADHKx9bWyQJ6Ar62tWla
         Am1qzbwN+sLGcGSS4q5WB1K/Kopo0C0MIP1Vw+A0qxnj/8Nchrrs1cytEk1BYAlOPh4Q
         v/ZlUOzlVW3cySxhQouukmigNK4o8/RcKcIJiDpyy/6L7I5/kgl9a8Gs0oEnSPIvF5CJ
         zGzBqDfo0DqWQN9tZAVLeS/cHb3VbXW+kPUf0+YjGrfQ+Z5xfOPfhmgoWZ3HxQhQyUak
         FdPjMq0R7IL/fl3ChFwI6J1zEOvED1109/QuAPzgG6LYPi40TRQC/kq8i8k5yolONRBr
         w1Fg==
X-Gm-Message-State: AOJu0YyFSul2HK2Ml7PuwtEMi3UW0nUcU8x2oZq+BMvGUWpj3kwsqiUA
	El/frVvAL2rx2rXfP4v7YSkK1QgXTadATDwCH7dfezUiA2v14KgBZuq93vu+4EArbYnYBfN+/Cv
	G+7QaHnWNPDDGPsSUutEoxWwPZ2T6OaP+I7PXtYfZPT5fK4pDkzIELWZ9lxA7bYY=
X-Gm-Gg: ATEYQzwydcHa9tkHW5Q1fp+657meuHMjQvhgDU1kiq2VRqpO4BYdZxD0xfCEfPq6DWy
	3eFKwfIwoeJe1LQHTL46xoIbcQgYpFKY2MlXcKLerwKXeMu7M5CkBtkfVNDU1Hm1+f652FYeEhe
	mhRZpagb0Ii/ZsrTQgUZw7v6FUc1ePEXyiMbN5rNM/hZHrlWJ2y1fwUaSqBkve/mNPIC0sFCuRn
	kK+jEEH+Rzneu8ihYkP6vJnVxnKa1gW2YKoL5KnsYmLh2CClRm/JTTKyk7ov6W7bET+BU8H/vSX
	592OTix3ytCwxUUlVtBWt6M1s602JAZ0koGTMiByVFZG2lZbfTmeKxy90EIx6zZY/2YzJioRNhh
	ONddxbdKxsxIHYBnOtqULaf8NuoDz7oGbEa/nlyPahwQXaGLKBoID
X-Received: by 2002:a05:6a21:6d9a:b0:399:12d:41f with SMTP id adf61e73a8af0-39f108b5e20mr2888209637.7.1775120812509;
        Thu, 02 Apr 2026 02:06:52 -0700 (PDT)
X-Received: by 2002:a05:6a21:6d9a:b0:399:12d:41f with SMTP id adf61e73a8af0-39f108b5e20mr2888172637.7.1775120812036;
        Thu, 02 Apr 2026 02:06:52 -0700 (PDT)
Received: from [10.218.44.178] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65991a8sm2113342a12.28.2026.04.02.02.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 02:06:51 -0700 (PDT)
Message-ID: <e654c46e-9315-4593-8395-f8b8e2726866@oss.qualcomm.com>
Date: Thu, 2 Apr 2026 14:36:47 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] arm64: dts: qcom: kodiak: enable the inline crypto
 engine for SDHC
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>, ulf.hansson@linaro.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260310113557.348502-1-neeraj.soni@oss.qualcomm.com>
 <20260310113557.348502-3-neeraj.soni@oss.qualcomm.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20260310113557.348502-3-neeraj.soni@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA4MSBTYWx0ZWRfX2I2L9NSAKn42
 hQkHHWceNMNOWbnzNLV+hN3mg2FM5eEHLaTQpYZpIa3VSEjhDSFPOJFCcSDAWM+Z2VVRvNPxBym
 RG30pZoBN7vZjQDXfsDx70DxkcmP4Hkvp9Fw2hMcaLPgeDmTHQj4VGOHo+ikTZ/nw2O8zU5BveN
 0hdgzaFcA80cANv20c5PEAUQSWrNwHjrQnmMbVoUyxicejRK1dpaMrwHIsqzfipukgWYweb3DPn
 tj8o7vyI7WonLcfO5GYYNPJuvXsUu6xV4I01IQtO8Z6F6VnwOu/1t97TWYxi82P9/u1FR/gjIui
 sXYt54abTDt1a+YIw5PvipnNMA4H4cu+MTQ6opK/FbPax9CTPJs91KNkUmVofaJg7f+GJwpv024
 FFjLRC5n9B50XfYj2E9pwgPkGay2Jw19nDlnCKt9LDF/2h7Aq5uBg5tY2z+WUSB7cO839eKufKx
 Sv+y7HFPTVRpSjlbLyA==
X-Authority-Analysis: v=2.4 cv=DJSCIiNb c=1 sm=1 tr=0 ts=69ce31ad cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=J1RPYAV8tJtF6ET1qeAA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 88ShIwoRgTcbcE_XbC8a20JV1iwu-WXz
X-Proofpoint-GUID: 88ShIwoRgTcbcE_XbC8a20JV1iwu-WXz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020081

On 3/10/2026 5:05 PM, Neeraj Soni wrote:
> Add an ICE node to kodiak SoC description and enable it by adding a
> phandle to the SDHC node.
> 
> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kodiak.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> index c2ccbb67f800..de01a6669522 100644
> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> @@ -1045,6 +1045,8 @@ sdhc_1: mmc@7c4000 {
>  			qcom,dll-config = <0x0007642c>;
>  			qcom,ddr-config = <0x80040868>;
>  
> +			qcom,ice = <&sdhc_ice>;
> +
>  			mmc-ddr-1_8v;
>  			mmc-hs200-1_8v;
>  			mmc-hs400-1_8v;
> @@ -1071,6 +1073,13 @@ opp-384000000 {
>  			};
>  		};
>  
> +		sdhc_ice: crypto@7c8000 {
> +			compatible = "qcom,sc7280-inline-crypto-engine",
> +				     "qcom,inline-crypto-engine";
> +			reg = <0x0 0x007c8000 0x0 0x18000>;
> +			clocks = <&gcc GCC_SDCC1_ICE_CORE_CLK>;
> +		};
> +

Just thinking out loud, as ufs/emmc ice using same compatible and later
need to add some specific handling due to erratum etc, how to
distinguish two in driver then?

Can add an extra compatible layering to distinguish like
qcom,sc7280-ufs-inline-crypto-engine, qcom,sc7280-ice-inline-crypto-engine?

Otherwise,
Reviewed-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

-- 
Regards
Kuldeep

