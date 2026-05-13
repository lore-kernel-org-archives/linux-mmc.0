Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7DA3A1A59
	for <linux-mmc@vger.kernel.org>; Wed, 13 May 2026 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778673850; cv=none; b=mRqi8kWiO6RyGkWTfCibAAuNiG8zFaJmIYnN3jj5fzp8RaRiaU6vstepEEWZ4TJJzAVe5mhPk6KwuWBjRLsenR6nlv2kh5rH9RGvGs02K40ZjVbyTpM5vvhBdVY+TGtTdofFyu5IlLyJwgaAmFYXe2zJf1V8sXSr7cKmuxG3tqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778673850; c=relaxed/simple;
	bh=fgxSvC/I0Ea/NY5kmuQWxC8qbNmf2ilb3RccH3mP4uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6FOh8D/HhSeBWpFHJfawwZjJYuFmYWefZpwB+JicaBvwm2PoUTgNMWZuAPqQDqwYHfvhTeTVwPQrKUz607bzwK7o38J89ZYqHRKS1XSfwZ3YHFK2Arl3XSQoV+B/hmN5RHyBlyBcPRzcsbRjlSvMxt4uO6As6uyrgYSJK5iHxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ER2fh0uC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VJU5JRao; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ER2fh0uC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VJU5JRao"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D9oeYm2338837
	for <linux-mmc@vger.kernel.org>; Wed, 13 May 2026 12:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=OV9Khvfl40DlHcmGDuk2UkcX
	+giPUcBv3DS5kP7UOsE=; b=ER2fh0uC67lfhAc7TZFl8mYdYi8OjdDillN91uXr
	JnMCSGaHxIHKpxsm+pYYg90tzH8iqDPH+0ckJbL5rkac3+k1JdYQXnsollO/K+fH
	emchE2H3mdEoYqI32YgOqL1D72M8ZSXjaNRabk93PoRZJvXqAQl6tSyniKOFTWnN
	KOkrKXEb7vAbqsVnC9rjdK+tOxAjILkP646VcA9AJMpQ6E+ZsPgKx5WaxmIcqUAa
	YAraIfUkohT5BB7qhZZqwD7/Y80ofZTiYwK8zMahzVNXzRXwhJ2FrtgYjqGOk4FI
	QVH+ZNMJu4N0eVzOW8f+kMx1Uiii9MM6JI1qCBohjjOlyQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e49vxbaph-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 13 May 2026 12:04:08 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-95f6b47ad17so3414547241.0
        for <linux-mmc@vger.kernel.org>; Wed, 13 May 2026 05:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778673847; x=1779278647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OV9Khvfl40DlHcmGDuk2UkcX+giPUcBv3DS5kP7UOsE=;
        b=VJU5JRaoG3g4A8m5CWDt75yeD4vw/xcaLGxTkXu+Ylua54umfIHwgHkd7MPsxupCvQ
         u1ScjH9rix5Y6FlwF4HF8uiMGhyfPsR4lruA6FXvyK9gLt5MXT5xtz6Y7AL1dxXatSXq
         19APZL0OZgzcE41Ef/1Jd4Qc1D56GkFlfvBkFIGbxQ6Wn5lC4wmmS1PGhUp16Cv2DQsr
         KA7LPh1j578BjzGfimQxFcrPOFUEhkH345oIg72KNHmk4T7e797qE5YM87OI3z1Q4hoX
         hnD6d0pG5apX/a4LUQDyyndeOlBOKZu3cwjgpYjNnzpAFZGFqhQaSA+zUlYgBQs+r0zD
         8bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778673847; x=1779278647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OV9Khvfl40DlHcmGDuk2UkcX+giPUcBv3DS5kP7UOsE=;
        b=C9oIEwXkZWv5J54qyJ91ajAVSsJO5T3LOpt0L59KUPfEzy5augINro/Ze31+GuP5S9
         EoRw1O6cqOb6Ci+mtBN8kyUzh8WnhQU02vZBupzt2fQ12TmOnmOgoYEXNvbAwh2yVn98
         rukrktU3v6eMmowfSdmZ3AUjwSKrma1KI2cOQpMchuTpeQnZHQvjsnr7x7KXL487KIVA
         Dxjf1ZsssYLHMJjvbeJvh0KUBUEXlm0W8GGWrTvaEXMYIvXZSmGCITOEarDxjbrwBRv1
         q/F+9DzJ0c/UJXLt4tdqiaa9EBorDMWoUNaSakt9Po/Ggj3O5vjm9RQZnXvfsK6dUjOI
         h2kQ==
X-Forwarded-Encrypted: i=1; AFNElJ95SG22wu4Z7CCbCNZ4IFzVk4NiRLnBPazJbtKkbG1VNCwwzKcepkuxFOYJZhTLlCNtJuGmcnKEIOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXOGX2/z65xNhON3/1uRvN9kg+D3/TqgRsoaGUdLFHgKsxGBl/
	vhyOhmIaH8RPc6nyDRo3+Rr2NgSDp5nguncuEYnnHX9pSEbaccV6pJuqTwKmc7YZvkSW9J15Lwn
	ZHLeCKPumrIuXfsq8ESiWjpGGvY7cVu2Eqxlpu5R/ru05mhFDDr9aDFeg5DYoZOM=
X-Gm-Gg: Acq92OE3y6pXx9JN0YlHanYhUmKa1GyIvKM83EYNrLUXhWN7QtL5poqdTpJifh9iWYt
	Hj7V1cQLvkEpuhQNYldteNaEfquFyQK1BNLMf+mD4gUav2Y80xYS5k9XnLsyHGyOmrposzLZEGm
	zUqhbbUaMHPuv0bcxlkFzvSCPvEXlQ6J3ryDRyICOfJyqqau2nL7kFfnRyf5HO9P6cGLHk+E0N/
	YidLJRDA8AV/WsQV/9BZzsgWwHWPFluF/vlE2/FRUAFg8RR3z+ysjXrutKTJGQwCPmfxmCIWq7y
	hdVfE8Yh81Cy4Sedu6Iw0zl+Lul1Ba92Su3FjE2vXiP5xXtt9djlUQqWljc4ITv+YBWQVcvf1zM
	DPFvSpT6tutE/4V0QcsYfoXNEz0DPNFPQ6HK+Ivapby14aO0s6Y9s1pQNCLyoogOdImp9wPl8IL
	zYbDgXtNO3UzzRpISmjKi44NF5oHoXFIl7Cg8=
X-Received: by 2002:a05:6102:32ce:b0:631:4ad7:b367 with SMTP id ada2fe7eead31-635d24dc6f3mr3453055137.20.1778673847574;
        Wed, 13 May 2026 05:04:07 -0700 (PDT)
X-Received: by 2002:a05:6102:32ce:b0:631:4ad7:b367 with SMTP id ada2fe7eead31-635d24dc6f3mr3452972137.20.1778673846939;
        Wed, 13 May 2026 05:04:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f60db67esm40073641fa.24.2026.05.13.05.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 05:04:05 -0700 (PDT)
Date: Wed, 13 May 2026 15:04:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        Xueyao An <xueyao.an@oss.qualcomm.com>
Subject: Re: [PATCH 4/4] arm64: dts: qcom: Add Shikra CQM and CQS EVK boards
Message-ID: <mw2ipu5z26ubmrg6qe2v36cp6ktkqtbpfe3hmr434qdgm66nz4@pu6yy7hw4n3t>
References: <20260512-shikra-dt-v1-0-716438330dd0@oss.qualcomm.com>
 <20260512-shikra-dt-v1-4-716438330dd0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-shikra-dt-v1-4-716438330dd0@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: IRHR-givC-9I1LsYZnAtf0K9_XwSwPGu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDEyNSBTYWx0ZWRfXxD+J89sihgfe
 7a/6emrV5b/c63wtFJ+JfpZv144HJkPMUVJAR4tK3XS1k1JJ1crpFinng77FYdWLKtGpaqUVJsk
 nP1V70avaJ0Do0eIFuhYqAm+01St0h3X8oRDIZbPxsshwtWbLZZWzTLmAacucWya4KBsa0GTKcV
 63ZTg2rDG3Q6H8pHGfDYk7Mx0VdTEj2wwF4JwuSLZ/5wd4t4P1h40Rh4T68bEy7Y9gAHT2WNcvc
 bJdH4WK2E6/e05BOgACPZeWvYyhUVOXK5Nonht+uyTHgrZ3b/m/94QbqoSlFStOWJQ+0fnfe/e0
 e2GRAVX2Htuohgr5nqJpidqYUR2FHHODm4jIJyFFrM0glS8ptNRXteKdGTDORq9a2u7xYrOsV/M
 hq1hM02LklVac8QCe//mTVGV5e94K/9HL7XBr98A8WwZl0fRe1fyDl3+Af1H98DDHtsy6ky0opf
 UhWeGHOoXQzwSFqyUdw==
X-Proofpoint-GUID: IRHR-givC-9I1LsYZnAtf0K9_XwSwPGu
X-Authority-Analysis: v=2.4 cv=A8Fc+aWG c=1 sm=1 tr=0 ts=6a0468b8 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=YDnyACv__Rn18NothnkA:9 a=CjuIK1q_8ugA:10
 a=o1xkdb1NAhiiM49bd1HK:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130125

On Tue, May 12, 2026 at 09:38:07AM +0530, Komal Bajaj wrote:
> Add device trees for the Shikra EVK platform, which combines the CQM
> SoM variant with a common carrier board.
> 
> Two EVK boards are introduced:
>   - shikra-cqm-evk.dts: pairs with CQM SoM (retail, with modem)
>   - shikra-cqs-evk.dts: pairs with CQM SoM (retail, board has no modem

CQS

>     support)
> 
> Also add shikra-evk.dtsi common across both EVK boards.

What is the split between shikra-cq[ms]-evk.dts and shikra-evk.dtsi?

> 
> Each board DTS enables USB (peripheral mode) with the appropriate PMIC
> regulator supplies for the QUSB2 and QMP PHYs, and eMMC with the
> correct vmmc/vqmmc supplies for the CQM SoM's PMIC.
> 
> Co-developed-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> Co-developed-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> Co-developed-by: Monish Chunara <quic_mchunara@quicinc.com>
> Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
> Co-developed-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> Co-developed-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> Co-developed-by: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
> Signed-off-by: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
> Co-developed-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> Co-developed-by: Xueyao An <xueyao.an@oss.qualcomm.com>
> Signed-off-by: Xueyao An <xueyao.an@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile           |  2 +
>  arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 61 +++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 61 +++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 13 ++++++
>  4 files changed, 137 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index cc42829f92eb..6de783bcd133 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -328,6 +328,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-huawei-matebook-e-2019.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdx75-idp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= shikra-cqm-evk.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= shikra-cqs-evk.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm4450-qrd.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6115-fxtec-pro1x.dtb
> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> new file mode 100644
> index 000000000000..12eeca84832c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +/dts-v1/;
> +
> +#include "shikra-cqm-som.dtsi"
> +#include "shikra-evk.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. Shikra CQM EVK";
> +	compatible = "qcom,shikra-cqm-evk", "qcom,shikra-cqm-som", "qcom,shikra";
> +	chassis-type = "embedded";
> +
> +	aliases {
> +		mmc0 = &sdhc_1;
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&sdhc_1 {
> +	vmmc-supply = <&pm4125_l20>;
> +	vqmmc-supply = <&pm4125_l14>;
> +
> +	pinctrl-0 = <&sdc1_state_on>;
> +	pinctrl-1 = <&sdc1_state_off>;
> +	pinctrl-names = "default", "sleep";
> +
> +	non-removable;
> +	supports-cqe;
> +	no-sdio;
> +	no-sd;
> +
> +	status = "okay";
> +};
> +
> +&usb_1 {
> +	dr_mode = "peripheral";
> +
> +	status = "okay";
> +};
> +
> +&usb_1_hsphy {
> +	vdd-supply = <&pm4125_l12>;
> +	vdda-pll-supply = <&pm4125_l13>;
> +	vdda-phy-dpdm-supply = <&pm4125_l21>;
> +
> +	status = "okay";
> +};
> +
> +&usb_qmpphy {
> +	vdda-phy-supply = <&pm4125_l8>;
> +	vdda-pll-supply = <&pm4125_l13>;
> +
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
> new file mode 100644
> index 000000000000..bc93282f64cf
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +/dts-v1/;
> +
> +#include "shikra-cqm-som.dtsi"
> +#include "shikra-evk.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. Shikra CQS EVK";
> +	compatible = "qcom,shikra-cqs-evk", "qcom,shikra-cqm-som", "qcom,shikra";
> +	chassis-type = "embedded";
> +
> +	aliases {
> +		mmc0 = &sdhc_1;
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&sdhc_1 {
> +	vmmc-supply = <&pm4125_l20>;
> +	vqmmc-supply = <&pm4125_l14>;
> +
> +	pinctrl-0 = <&sdc1_state_on>;
> +	pinctrl-1 = <&sdc1_state_off>;
> +	pinctrl-names = "default", "sleep";
> +
> +	non-removable;
> +	supports-cqe;
> +	no-sdio;
> +	no-sd;
> +
> +	status = "okay";
> +};
> +
> +&usb_1 {
> +	dr_mode = "peripheral";
> +
> +	status = "okay";
> +};
> +
> +&usb_1_hsphy {
> +	vdd-supply = <&pm4125_l12>;
> +	vdda-pll-supply = <&pm4125_l13>;
> +	vdda-phy-dpdm-supply = <&pm4125_l21>;
> +
> +	status = "okay";
> +};
> +
> +&usb_qmpphy {
> +	vdda-phy-supply = <&pm4125_l8>;
> +	vdda-pll-supply = <&pm4125_l13>;
> +
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
> new file mode 100644
> index 000000000000..fae8c75b68b3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +&qupv3_0 {
> +	firmware-name = "qcom/shikra/qupv3fw.elf";
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
