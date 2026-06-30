Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A7C3F9FB
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819649; cv=none; b=LxZwa07ArCzIHATe7AR07Is7a6NiyaVxL0F4LR3DdPBG1whg8n0TSdQDlpLHVkanWDczwFG0lSyjrPLfU6d/pJ/163igJchr9DCvjBbAMsOTer2I68fFiQ1DrbXb6dcPvJg+IRByo1ndqhk67Bm/EOzSHTE5n0yrrbarITAHWiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819649; c=relaxed/simple;
	bh=YiO2VZ1Z4/VqZFRv1Y071DZKVJf3APynuKIljItqCRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eh4kC1DpsCUEGJDSwg3CESsyd8UeIxBxxpxIbhu5737RD1J3Rw53yu5cRhjVxS7IEo/IJp4rc2Ww184Wsit00vCaMXHQ7jElbMPaODHIpN60pnQWyS8goWEMyPa4PfMxVPjMuRgrfEjAAu1f0yxUX2W9osj/7XbDhtU6GLv8RFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kDIwdl+F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D+N53w5e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kDIwdl+F";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D+N53w5e"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9nCqj1590607
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 11:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Iu/2dveu+R9hFdVPTPFLQKVnjQWaGi/W5/Il6dZxvC8=; b=kDIwdl+FsDNtJWC8
	mA8UYMxOlaR6mQTOQrCTPzzl98NOGJD75VI5r0SGlAtY2XjpWNqVI/pLpdeoTsiL
	hINcd7c1y9xrJ2DVbWTL1f9FkquhGq0XubcoV0upDf/dKwZf90SF3Y2aA3Kn4kHh
	P6c/gx+ca4vdcGlJaQ7Yd+YlmnbvxwuIiVTEK/AHPez4c0wPup+KrC7chfDSssao
	YUddsNS6WWKf9QfjjCi6z2XNdUi0KIDNpKIvAyohaZ9MjM4iAXbtMttvJRwveyIO
	lfZfYreI+fmlswJrKRUisIV8RWKn67roEHK0iVfevsTZI3yrmNnofxCMZ9AcTqMv
	aoRUkg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3y9k3aq2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 11:40:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e6cb57d25so5701685a.3
        for <linux-mmc@vger.kernel.org>; Tue, 30 Jun 2026 04:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782819646; x=1783424446; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iu/2dveu+R9hFdVPTPFLQKVnjQWaGi/W5/Il6dZxvC8=;
        b=D+N53w5emBfMBr1pMghnbyRSmWpLKn7YjcFxuhACe+u4aIRues5oBAwOkhdWLF8YJ7
         8Tmbmng+cztGVKADlTgFuXeRnCgqcr1qXHT1YtTJJsQOi4NOYLyvsM+ugWMhWIJIGj/G
         tCvCSkVoDmOL+zjxNpIsq/drJC82TQcfkdSZYspzW2FLbBNbST3zgLGazUPiJ7PECDbt
         EXzZe1InQE6BpF9ZQ1tWmeUHrYp+6I2mFTJNbV1YFE/eeo+4d6/gf5MbXkyOI0HGmOFZ
         nCNhkOQwfAYQLSKbWx66KG2VN8Fg5sBOWAf5lJCQ/qvDKiEAZKGJJoCtVSp2l376n+i6
         LXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782819646; x=1783424446;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iu/2dveu+R9hFdVPTPFLQKVnjQWaGi/W5/Il6dZxvC8=;
        b=SjnKX85oN34P2DrFMefRSJlKy5EeqrXTTaAdLQRGpzhdm4/n0yhzpXpRFwV2PmhCBJ
         vZl8UN8D+eLYUlkRekUgR5sOCgcf/8oCvLC2Z+nE/3tzRAR6c/gxH/uFO3pD6C1peuYO
         Fw9+BmCyQ8QvYkeXc8AIanu9psf5BFfVgxWrVZGLismifzj8kUGvAQFGBIcylRuOfdfl
         3kblnR9gk46JDnjB+hzbeCroIJ7pOgOQYALgPxVpAMl33tmRF6+iVoQNSdGHkY8oGE71
         VgW0N5mL7Gqgll63NCMUUNVuedHo6sKgAkm4STdkH0RmqqdG2OyK8RZbAILnhRR5gJ9h
         OZgA==
X-Forwarded-Encrypted: i=1; AFNElJ9f4I3t48bNugZYpZp8bjkFddhhqkhDfHfqjMPiU2pZueyjc8JxiBhw0EmIudbUIirIt9puoyZwz0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx48LLeP8khHHkggB6hZBq1/xD0iH6J4IFAGLJOLpRl50k+uswz
	7ex3D+FLedEH/ve619zqABnHGcOtiEo0CUpTmwuYGVd9Cb/1xIlKFuPLhYn7kLN6W6EWqtxTsUK
	kb3UpklaOth/D+/UewwH6NmCLCWcWueR/wHKNnBQtAxhB+ppGR7gxJVYz2uh6idU=
X-Gm-Gg: AfdE7cmFXYneCyGI7rtQD/tWtt1/LMd2Ly206hg2ciI3LkVDgYsBduKG2Ed5SIsmRs0
	8kPnUuaQ+lSphMOtGl1uTBmVd3xZFDJbNFHv1695nasU0NyxYLGuilDyshjg2KGP1i24DyOWXLu
	jlcaw4RdHING/mFx6VRMCYDj/NNE4fvszZA71Aw41CzM9IbpfSpbAeJngCikJvj/7B5Hb5JA9q6
	zUnMxMFX+opP94A0huU5LEh4raf/ogeir3uMK44ntge0oW8ZcZdhrp3TH2ZsxDxH28yHgoWZM9a
	sP1n4I9H8xyilMfIIyZuCQd/LsHTyfK3WivzldJ7Bx7XubmIf3Kiyp4b0FSTeGRPAp/LCbahE5M
	hVXi7B6PuCyazqf0fq+AKJGSKTYZ4wiO3wgc=
X-Received: by 2002:ac8:59d4:0:b0:51c:8fb:fa46 with SMTP id d75a77b69052e-51c108ea935mr28923711cf.9.1782819646213;
        Tue, 30 Jun 2026 04:40:46 -0700 (PDT)
X-Received: by 2002:ac8:59d4:0:b0:51c:8fb:fa46 with SMTP id d75a77b69052e-51c108ea935mr28923251cf.9.1782819645781;
        Tue, 30 Jun 2026 04:40:45 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288f4c3aesm110014466b.47.2026.06.30.04.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 04:40:44 -0700 (PDT)
Message-ID: <f3c79cb4-02eb-4e4b-b5b4-9732876c075c@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 13:40:39 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: ipq5018: add nodes required for
 Bluetooth support
To: george.moussalem@outlook.com, Jens Axboe <axboe@kernel.dk>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Saravana Kannan
 <saravanak@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
 <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20260629-ipq5018-bluetooth-v2-0-02770f03b6bb@outlook.com>
 <20260629-ipq5018-bluetooth-v2-5-02770f03b6bb@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260629-ipq5018-bluetooth-v2-5-02770f03b6bb@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEwNyBTYWx0ZWRfXzPplo510qsyM
 hbmwwsiai5s94I0NZ2QJ1iop2xrGRFP9l9XX7Qbkzl2vUGvuc2Rw2ZWO2JxlpFT2se3MJgXu7qa
 E5JegBC7PXjsBv/q9rPtPNZlGwp+Es0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEwNyBTYWx0ZWRfX6SJA5K4vZ4CI
 4QpSpyTrcdaTvBwrV0zudQILOsxcUVx7HLapmvAVOqbSgas2b7bH58zI3XvGuDL9+j1lY8jVmcC
 yfF6HqUFlsDbAfYX03f0rzH9tC3R3T3rbT9fht5zcJ7BLXBoinuQbwec6NSRbI8GNXsehkSiRbE
 va+lArWiqlbBykwmoYBK9053kscRk5ZYkv295InHFkqGjEjxY4a8eJPxEQIijOeQ3VsSPSkX14O
 ZxGHt82YrlvCpXf41l2dm8xBqVBuefv4pFM3ZnjTjzdj1qW1MNO7C6MFH/vYvNmC2IOpuPZGJej
 h3C4z7r6S3+RRJxs3PJwjOAUpEQZ942nGkx1yFEP//J1hUrTEQvsXl9ckEaInwaqwUcyylPeAOH
 EqCPjJjspE9fgUyfE8m/vLbhOoneXw6UpPjI5qibsYnJqXZTaChVKajIelhZD8Q2tcavpSHXd/D
 U/QNDiZN7uK62kT3kWQ==
X-Proofpoint-ORIG-GUID: e9qnuZVgRMG4DkqO5uayjsXvqU5bOOrk
X-Authority-Analysis: v=2.4 cv=TeqmcxQh c=1 sm=1 tr=0 ts=6a43ab3e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=UqCG9HQmAAAA:8 a=t82OjkPGvLD1vuDj7LAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: e9qnuZVgRMG4DkqO5uayjsXvqU5bOOrk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300107

On 6/29/26 3:01 PM, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> Add nodes for the reserved memory carveout and Bluetooth.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> index 6f8004a22a1f..65a47ba7d3a3 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> @@ -17,6 +17,23 @@ / {
>  	#address-cells = <2>;
>  	#size-cells = <2>;
>  
> +	bluetooth: bluetooth {
> +		compatible = "qcom,ipq5018-bt";
> +
> +		firmware-name = "qca/bt_fw_patch.mbn";

Is this fw vendor-signed?

Konrad
