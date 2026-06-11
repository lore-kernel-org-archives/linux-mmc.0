Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF2A392C3C
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 20:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781209017; cv=none; b=ePSWQ/gWGoLYOG4WRBJbt79cJfqzOEwhE1hWEygkY+R7+AnaItS22frn+vTMKs3XGxdZLeGZeDdzLU6K34W9exIUapOrb+xn7SKt/825Dy/vUuJ3SuhqZxz6GuAyCE3ob933D/htcBub8tqrXMk8oiF73UZPgH2BLG3I6hV8G4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781209017; c=relaxed/simple;
	bh=YJq0j55CRO8wxi83erJLxi7d4LJ+0Qu6CeJvyMiZr3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvGafpf10KOOIEH05MXoxTE9+Suuolvr3UFhCL/yP/bL7R7puWVyIx/mliJ7mOesfSCu5TjC1OUPeLCVNYzLUZhgAeiAnsWdKN/12xFTTSMltUBJoG6yKpMDpxORUDlnf2rh/ZBZnHPUyyPnWvrBV2H96Diu1WIXHx2NFK5BKtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WGPd0WPC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Paz8zr+g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WGPd0WPC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Paz8zr+g"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BJ3SrQ1426989
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 20:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6SCinHMjZ2J3w4Roqcjw2GQM
	ab17NAGCM+R3vMfhRW0=; b=WGPd0WPCoAB2KyheGqY3gMf6zT9oH5krcp4I+rwP
	09iHgrfa9eA381ElIqjMhyJJQSW8yisxrLMi0h+lyTErbPgKUtz4TZrNDlHy1NvJ
	aLv3xrqVhoVbrD8lVDaMqU1wtW/RWh9oPZV0FQgPddWSUXzY9mWio95mvLpp7//3
	m0yiBi6q1/rHqPdJMTs93UuOmc0kskgNtZM2Py8t2ZJOyGKvwS5XaeQ6vNODzKjm
	yW6Ou4qlAwYMcatqRYSxPxzYBpsXC91PcnutgIo5gRAvr7EPxMUzr5fDobnvqiJZ
	SCyead6hSu91UABaRt/ypq4GYKqRWZNp/SrIG5fR7K8VMQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1xcghnh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 20:16:54 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51776d4355cso30708811cf.0
        for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 13:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781209013; x=1781813813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6SCinHMjZ2J3w4Roqcjw2GQMab17NAGCM+R3vMfhRW0=;
        b=Paz8zr+gCQ2x6l73LY/LGmjF2nuCGDoIs7cJ5UikCrTFxEyGXZkdkDzUQoVuLqsQ+e
         73Wvfv3x4nHRJL2MIeiOaqfYjmDYTAboSARMe/fABsGZaIf3VmhIL7gP0wsSI7pb6Ks8
         rgx8/7oA3tVlPgA7aXqMlJzBCel87uDSt0fegqumNxhnZQhxHg0QV3PwdybsKymobRpA
         pkiDfeZ/PLZjVVm9qulCnbhBpgcOvTw+K2ju1+zs6eufDSxIp2hIqJRhkbuvb673N4j/
         fDlGbAB3AEQPS38Uj0rwS9gyxfo8BLD2mBhWgajYtnORi9kCkWpCQaJRTQExnq3HIjc6
         oOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781209013; x=1781813813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SCinHMjZ2J3w4Roqcjw2GQMab17NAGCM+R3vMfhRW0=;
        b=ZQ4NVQJdmfjUteQLeYfT37jiHxk8114B0aeYb2yho5btpYBgdElYXzqf7ssQCgagCH
         a7yvPzUh/BfIsigTS2MG9jF0eQSZ/EefPW3/1XXgDHTLrQli588hv4pQ7jonViOBE10T
         7XFvAxOvKtdbrSgHxA7yOsFyOY0YwR5WiBL8Yqv7/m0LCMrs9/STFYlA6QoMX636/sDU
         ax5wGhHTTEsYucGh+co6wZvWyUEIqyHggm6Ws+A9opJVGyLFL/p1AluwX1gCK2V1s+uy
         /OP5AKvxmCdaFl+330r6uEBObP/lAcx5Hbz/jqm5EF3DPXpI/R5zznUMPcUFXqHg/pcH
         48ug==
X-Forwarded-Encrypted: i=1; AFNElJ+l20ZyDCadO9qx3D7DhhXssRoKc1lsnSbI9nwnhBIu6mbROjqwxAb0WrbTwHrrRFac7weFfGRpRuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPGtED0yyiSt0Ng4SHBqXvNcPTiJm7uRLB6FwdbNVLeK4Trch/
	xXLREVu9BWrKZAA8yJGo+Xnkdg6MfntelQiinEQXZYxoPudfS1/yVIYcoD1vr40yLTqdIcpJwhb
	M18pOaxu0YwYEHAqXevXir2V/k3jvoUS79m7QWjvxtLTxoYM1fpmmK4KaDj58WFs=
X-Gm-Gg: Acq92OHCoTwxl2RuD9iXYxucWRMZVhmAY1qQfKZa2weJu59HWNIL6RQOrRkxJBUUhJy
	8qVOHWstSy6JRheO7nXbA/M3i6/mDOTsurHEP2oAhUl2wejzLk9e5T6UcZ3k06EO03ttJ/Z9Unh
	Gkv/YunkKZxbWoM7PpIjcrj46w3srsic4Ymzfe/pBVv2DSzKupnhfV9xtM/ChACszCBZXAWqLjh
	tTI3Z7zy9I/0zIDW1db+MlvhwXxH91KrVRIlQACWCh+cuqoEYf4SXQomC+rw9nyjAKBI3QImqIA
	B/ZHd+c1NNvh3ArZPMO0EZ9jDnjy4ZzSCBiybju20fSFGfZ92Tnyn0GMi9vn+J7rgbSZbjbTDPd
	6vl7+w2unaRjVpvwVNfpspgsQ7XDHaoWXcV7fnSXwdKXz2olqRyZpNnu6I20IHhLHzsSoOfhPsh
	P5m6vZihhh5gf492xOLGyERIntoyuw60hCBL4=
X-Received: by 2002:a05:622a:138d:b0:517:9407:5c38 with SMTP id d75a77b69052e-517fbe61614mr3716081cf.24.1781209013572;
        Thu, 11 Jun 2026 13:16:53 -0700 (PDT)
X-Received: by 2002:a05:622a:138d:b0:517:9407:5c38 with SMTP id d75a77b69052e-517fbe61614mr3715471cf.24.1781209012969;
        Thu, 11 Jun 2026 13:16:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2cd97dfcsm114395e87.73.2026.06.11.13.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:16:51 -0700 (PDT)
Date: Thu, 11 Jun 2026 23:16:48 +0300
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
        linux-mmc@vger.kernel.org, monish.chunara@oss.qualcomm.com,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        Xueyao An <xueyao.an@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v5 2/5] arm64: dts: qcom: Introduce Shikra SoC base dtsi
Message-ID: <zzveallrfaeaclkes4dvexcxacyyew6mjgar5ctmhevh6ld4c5@caxx3gdr6g6v>
References: <20260611-shikra-dt-v5-0-103ed26a8529@oss.qualcomm.com>
 <20260611-shikra-dt-v5-2-103ed26a8529@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-shikra-dt-v5-2-103ed26a8529@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIwMyBTYWx0ZWRfXzMXAn4yAMvcC
 7+HadZz7jN4v46B+EXC9xJZ6fxUfR0f8oTan+nVtP28/fJyreqyM+Mv/lcb2VkXKYWE0y6CGepn
 9tK8ojgcEb2ceXb+gadjADEobK48aN02IOVHI1mCdrK9+TLUMbWnaPZh3bOUHytqHSEzNnJdBgf
 VfW+WGLOB0hSolQDReheClDBVxJqsm7hGmhKeQ/jUkYFU00VECrCjtwqXw4zcrkPeBKmcdoRslh
 DjBSJgyzmoJ+0xxcBPi6KTUkXC38Iff8kAGLkh6Lf8mrToWErV/hKxirUt/WR0Sog/TKAY7HDAl
 Bg6G3VDq1gfbn0S+JehCQOc/0kD6aEPOMUZ8mYtcWodF5qzQPEmxcW8mfQFzQ+y9LNOr+vgAehi
 A8R5Bw/HoCrH3C5F3TCja9XXAmZmHuaWN+f8+Aypx8eZ8d6Gu82Pz8t4YED4X4gTTJKmJdSdj05
 pvf9T/zV2hCFKor1f+Q==
X-Proofpoint-GUID: M1SPTlcSkxkfTkWXZai1RftGpN1L0D6K
X-Proofpoint-ORIG-GUID: M1SPTlcSkxkfTkWXZai1RftGpN1L0D6K
X-Authority-Analysis: v=2.4 cv=NZPWEWD4 c=1 sm=1 tr=0 ts=6a2b17b6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=nLTNWNGuSljmtZLY6HsA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIwMyBTYWx0ZWRfXyWNQquRLkGjZ
 AXBTlJ8c5zMFatmaR2obTe+6O4BRjiI8dVBBV6vGuNAPobBw5xbU03uKPG4BArQtmRoN1zneqsN
 BggBqi4QRqDenpQ/MmqNgS39TDhT5PM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_04,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110203

On Thu, Jun 11, 2026 at 03:40:09PM +0530, Komal Bajaj wrote:
> Add initial device tree support for the Qualcomm Shikra SoC,
> an IoT-focused platform built around a heterogeneous CPU cluster
> (Cortex-A55 + Cortex-A78C) with RPM-based power and clock management.
> 
> Enable support for the following peripherals:
>   - CPU nodes
>   - Global Clock Controller (GCC)
>   - RPM-based clock controller (RPMCC) and power domains (RPMPD)
>   - Interrupt controller
>   - Top Level Mode Multiplexer (TLMM)
>   - Debug UART
>   - eMMC host controller
>   - System timer and watchdog
> 
> Co-developed-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
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
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 842 +++++++++++++++++++++++++++++++++++
>  1 file changed, 842 insertions(+)
> 
> +
> +		rpm_msg_ram: sram@45f0000 {
> +			compatible = "qcom,rpm-msg-ram", "mmio-sram";
> +			reg = <0x0 0x045f0000 0x0 0x7000>;
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0x0 0x045f0000 0x7000>;

0x0

> +
> +			apss_mpm: sram@1b8 {
> +				reg = <0x1b8 0x48>;
> +			};
> +		};
> +
> +		sram@4690000 {
> +			compatible = "qcom,rpm-stats";
> +			reg = <0x0 0x04690000 0x0 0x14000>;
> +		};
> +
> +		sdhc_1: mmc@4744000 {
> +			compatible = "qcom,shikra-sdhci", "qcom,sdhci-msm-v5";
> +
> +			reg = <0x0 0x04744000 0x0 0x1000>,
> +			      <0x0 0x04745000 0x0 0x1000>;
> +			reg-names = "hc",
> +				    "cqhci";
> +
> +			iommus = <&apps_smmu 0xc0 0x0>;
> +
> +			interrupts = <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH 0>,
> +				     <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH 0>;
> +			interrupt-names = "hc_irq",
> +					  "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> +				 <&gcc GCC_SDCC1_APPS_CLK>,
> +				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
> +			clock-names = "iface",
> +				      "core",
> +				      "xo";
> +
> +			interconnects = <&system_noc MASTER_SDCC_1 RPM_ALWAYS_TAG
> +					&mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>,

Please align on '&'.

> +					<&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG
> +					&config_noc SLAVE_SDCC_1 RPM_ACTIVE_TAG>;
> +			interconnect-names = "sdhc-ddr",
> +					     "cpu-sdhc";
> +

-- 
With best wishes
Dmitry
