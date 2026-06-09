Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861A13DEFFC
	for <linux-mmc@vger.kernel.org>; Tue,  9 Jun 2026 08:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780993882; cv=none; b=qGrxA4Hho9jyNgICTUvbdbCl78Eu94RV6BUL/DK2VpOWn8tEzqSXUOWKDRiHRkMK8JsFtLG85voVdW6gsnmzjIy7kYr17/ckSNy0Q4s3YCTKY4wcCsNguoTRM+6Nd0osWFcOrW2qeh2kgS3kJ9HPXDTed0qMXN6Meq6z/F7+wRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780993882; c=relaxed/simple;
	bh=FupT71IspFghkCOY+MaMa8PhJF5X4yNy+GJaJOku1+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JAHjDkl4jl7od7Goq2Tz5M6nvm+TC+8okKGr5RmjriW1G0Dq9X03vc5lcIMaSRoo7EdwdX8SEC+DX5LlDzr4uW0JK0H6ruLCABHQ36myRDDSnOP/RZg9Lgh/3C2ScEsnBb1VYkp4sU7CE8inYcpi6MmQ3q2hLXZKa9Axkgd16k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZCovegja; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DzowZdkT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZCovegja";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DzowZdkT"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65985RMI006849
	for <linux-mmc@vger.kernel.org>; Tue, 9 Jun 2026 08:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	44EplKRTyllVKZ0I5jH9SM9IevfCtPlHwPoIMOwW2b0=; b=ZCovegjahJgux1s7
	6smcIup0YtkKDW5d7+zwsKLMQo2fWbdcS+NOyDIrnjDE+SaUMNe5Q36ZgYHl8HO2
	uhmqCXKEkvy5o5T4XsIyTZ8l5fzoLCXAjGHq2xsTbXXC2ZiPBXPZlxT1YrC00TVb
	wxPecq24X7ktHaCW0Nbhlj8taeppcqMfY1X8lbW81AdmIKsYYylZ3LYI9qbzknbs
	i15WM2XXHLOEV0xJjAf1+t+laZKyeRNUY0Ty3CEX3LOhfh9MsPzgZzdpnzqyGNCt
	o4j2UNknZoaATzN59tO+L2cSr9hEHZXBDd8U7M1nWuuA1ibq72eMet3qBhaNsXv0
	cIo0Zg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epf0sr39m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 09 Jun 2026 08:31:20 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2bf11699875so54378145ad.1
        for <linux-mmc@vger.kernel.org>; Tue, 09 Jun 2026 01:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780993880; x=1781598680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=44EplKRTyllVKZ0I5jH9SM9IevfCtPlHwPoIMOwW2b0=;
        b=DzowZdkTkm8UqIJkDVsuFUP8nr6HSPhaBF6x3GrZYlnH1CxjnO2rI6IX5DCZJxCDs8
         ozrdC+j0xU39Hx9OJsJG8WZxoQ/v1Q2EkPhGMy9GLz9bQ+El3qT0e8K0JxjfDdDSkCOP
         plJ8rIs6cqO+sZmoR7Y7eokNaiz3gXxHBUg1mY7PMJvb1ZIiVEZibtSKMZAe8UWzRWBh
         Sz/Hl/gS0rVv/xo7dpbfjeqhEbnfrfciwvRFt7z9U9eCmmmforoeuX8p+Fw3Q820NXzG
         WGqr6C+30oIk8iY4mlEpNp3WCviq4FLUkp/BmlgdpkYAkPIJuIaHw9zG2+UqvM5GT+nG
         J4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780993880; x=1781598680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=44EplKRTyllVKZ0I5jH9SM9IevfCtPlHwPoIMOwW2b0=;
        b=PZxHxNsvmcsFaqYfNQtRe0TEl7sTA/QOBFixCiAMfyckAqTFoKKxbOKuUXlHdOCJPc
         yqYdZamOxPd5xIeloSTuOvq8Rjhm+UXes+0uE/FiQR4jukEbTTFTwZ5HWAspyscn+eXo
         5zSHD7gJ2iBmeG5YPS2epb5Sx+/ZI9Fcg9ynCljNDQu7A6TC25y3Y75bo4S/mjF2iUTC
         R8qYfcK3iMARXmsFhNzllFvA3gq+5U6RdpvgOAPvyYnE0PMzIffoE/laj9WuiGEj478U
         bpIFE2HlWnPk+aj4I1H4/3am2JsOY6pjvdQn9eAoZp3Q2zZqYyryhCcz6tvJI3IIXcGy
         3buQ==
X-Forwarded-Encrypted: i=1; AFNElJ/v8ksP9ZmMElKMuSeqQrcgK9aPkFuLLr4cTdYiG/jfFBoFrb6bQBSPe/nu/UHgeHcBAczgmScll8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIniHKHzpK6s4soVM4yLm7WZKb16rUlHT7ZFE7Q/yODYqw7W8z
	ENVjaZCN+3Aytk/zZcb9dJACLUqdQdlD8A+YBuUkG3tr+NannYUS4cVFzeu8mo2hlcFGv+gsFB3
	0VBrSxpoMy+PzW/ECQfj4QTj3Z6vOJLKrTVyP8jf4BmeaEwm9BPJfKVEYiYI5M/U=
X-Gm-Gg: Acq92OFlXaqwylCYRJh3C8e2oJdZRMmTMW2R2uhGs8X/uz22lFgkepnNUlwDWFXZtYC
	0v2onD8AJviO8vBsgVB8y4O8qYkrn3k4RzzZG72hPdfg5X3yaRy1++bMa2p8Lh5svAAmw/VgXdF
	MEjPctdk0btH1dpK1VGYzoybyuBHwWYEW9qJ2IZm5d8AgYWuY5PO2Kd+B+JT6pvUu9ime6E2dsR
	1y1KavrljDYPyQT+mf6zwExST/OHQipRKwgzElokyFfEEzuLn+fXTOTRVOkMAjMu2yHRduVgqhb
	i9tTIzKbq9NKXCLGRrr9d10IFJdbSQ5K9rGg4KLJ78burk4T/rwRLZxpa7lwl6ByFQnSz5EWU19
	AeQZDoNh3LYCEbBADyhlxU6i6GFqlxoags14MqTJZnDp22t3K4hsdrhd/QMDmeT7/A/zyiCPO9D
	jxuF9zm6n084k2X4njCsBbQQ==
X-Received: by 2002:a17:902:cf0b:b0:2bf:367b:f46f with SMTP id d9443c01a7336-2c1ec932816mr163730415ad.30.1780993880022;
        Tue, 09 Jun 2026 01:31:20 -0700 (PDT)
X-Received: by 2002:a17:902:cf0b:b0:2bf:367b:f46f with SMTP id d9443c01a7336-2c1ec932816mr163729965ad.30.1780993879458;
        Tue, 09 Jun 2026 01:31:19 -0700 (PDT)
Received: from [10.133.33.148] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164fa00b3sm196112495ad.32.2026.06.09.01.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 01:31:19 -0700 (PDT)
Message-ID: <daa47ea3-1a80-4f95-adf4-f41eaf2bb1ab@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 16:31:13 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: talos-evk: fix sdhc_2 vqmmc-supply for
 UHS-I mode
To: monish.chunara@oss.qualcomm.com, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        ulf.hansson@linaro.org, nitin.rawat@oss.qualcomm.com,
        pradeep.pragallapati@oss.qualcomm.com, komal.bajaj@oss.qualcomm.com,
        jsodhapa@qti.qualcomm.com
References: <20260609073509.2453273-1-mchunara@oss.qualcomm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20260609073509.2453273-1-mchunara@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3OCBTYWx0ZWRfX9hvZIU4UYyFl
 pW9EwcewYbVsbN0usg04MvDZFdw8jfH70hYl1hiCi+v0vkHbZLqf9DVZ8J1qfNp5K0ihTUPajC0
 60r9zdlSu0KvvzrIhVEbDspVCYGykDv3TWwQjVI8tLtUjbTzEAPXrI6UUJK0uAM5h/SkYO5YftU
 sE7uEudJ0zHKpcVyozHdoBnmnkVbIOKBjhPWTrULdJl6wFmgGSCQlgVLfATtyFuMX4Gt50hwCjv
 SjfGfk4oFcoetCDNbr4MtO8SJzF+0Y5Q3CrXuvpeqRl37xizWOG5d/wXvbo1hKwG8ioyMsw8OVe
 FS1Alp8dVCivtr1E0hDcrABqsWZj/J5BSUjTvY/CLDMlqF+2Yu4fc7xPsPoKcV0j7YR46+Ik3N7
 kXm5tjn91Oc94yrU5a+bu688wCAO8+pBzjmCWMDLlUPpztxv7mhDOvyiwe2xOgQQz1xkcOIMINc
 6YN+FG2gxjsOBxvWrCA==
X-Proofpoint-ORIG-GUID: drun4MkXFR6y5z8vtogCJcGTA_CaXOWn
X-Proofpoint-GUID: drun4MkXFR6y5z8vtogCJcGTA_CaXOWn
X-Authority-Analysis: v=2.4 cv=GeonWwXL c=1 sm=1 tr=0 ts=6a27cf58 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=bcY_RnAor8WR6QYpvxoA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090078



On 6/9/2026 3:35 PM, monish.chunara@oss.qualcomm.com wrote:
> From: Monish Chunara <monish.chunara@oss.qualcomm.com>
> 
> SD card is detected as SDHS instead of UHS-I because sdhc_2 was
> configured with vreg_s4a as vqmmc-supply, which cannot switch
> between 1.8V and 3.3V.
> 
> Switch vqmmc-supply to vreg_l2a and update its voltage range to
> 1800000-2960000 uV to enable proper UHS-I signaling.
> 

Please add Fixes tag for a fix patch.

> Signed-off-by: Jaypal Sodhaparmar <jsodhapa@qti.qualcomm.com>

why is there a signed-off-by tag? Does it belong to the original 
author's tag? If yes, why you are the author of the posted patch.

Thanks,
Jie

> Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/talos-evk-som.dtsi | 4 ++--
>   arch/arm64/boot/dts/qcom/talos-evk.dts      | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/talos-evk-som.dtsi b/arch/arm64/boot/dts/qcom/talos-evk-som.dtsi
> index 294354c034c3..f70823b31391 100644
> --- a/arch/arm64/boot/dts/qcom/talos-evk-som.dtsi
> +++ b/arch/arm64/boot/dts/qcom/talos-evk-som.dtsi
> @@ -195,8 +195,8 @@ vreg_l1a: ldo1 {
>   
>   		vreg_l2a: ldo2 {
>   			regulator-name = "vreg_l2a";
> -			regulator-min-microvolt = <1650000>;
> -			regulator-max-microvolt = <3100000>;
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2960000>;
>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
>   			regulator-allow-set-load;
>   			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
> diff --git a/arch/arm64/boot/dts/qcom/talos-evk.dts b/arch/arm64/boot/dts/qcom/talos-evk.dts
> index b7f514fbc7b2..9ed48765ae6e 100644
> --- a/arch/arm64/boot/dts/qcom/talos-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/talos-evk.dts
> @@ -189,7 +189,7 @@ &sdhc_2 {
>   	cd-gpios = <&tlmm 99 GPIO_ACTIVE_LOW>;
>   
>   	vmmc-supply = <&vreg_l10a>;
> -	vqmmc-supply = <&vreg_s4a>;
> +	vqmmc-supply = <&vreg_l2a>;
>   
>   	status = "okay";
>   };

