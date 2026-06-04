Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D85547ECC0
	for <linux-mmc@vger.kernel.org>; Thu,  4 Jun 2026 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581006; cv=none; b=cRpV17Yn3YK9bslEh6xsG4xM0ETfgbUjf/DTw8SYul5z6wUubLU8LaD1NW2Y3a3PFKGWWa5H8R+29IuzG3Q9uIvfS/CKwFZRRfcufm1y6ul7r+k1uep5ubf7rPXOPTRNp5asVyCroiRjKiX/NL8Vxm9TKh1jOBEqe/WzXBOrmqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581006; c=relaxed/simple;
	bh=ps/xJcr3jXf5AMzvO+G9tT3W2UqJl0/zoHc06lrzgsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rftYUiYKkxvJsf7lk6xKueWQ2X5c5XzDNrLoQnhsGy6goabtDJlMaUJDrHxfXytpbF4qOg40ej9n2v7pJ6Q9t/FLJzyEHLNqEm5M8HjXoYfrtsfPFv7AIbg8UGTaj4KlXnYs+rr1l5gsE9JT5BLu8G7amJ3zMasalwW1KU1uuA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZJCO89+j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BiSwjyhG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZJCO89+j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BiSwjyhG"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6548epOq140473
	for <linux-mmc@vger.kernel.org>; Thu, 4 Jun 2026 13:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pNZYhuT8aP8yjUE8ts6a4+Zb
	HuHx6SQBsmF68wpFsBM=; b=ZJCO89+jHh6MNbWGmkV5dEEs5s3lM9jadMQaLPZW
	7VuttPfqDB3Oo8hcN3C/ctDbFdKJ3mGrs/N3FOYzqBWWZ4zRERVPO3Y8TKiFth6l
	Nq5Hrs8OQu2r3Jv6KAUYytPUALjbNfW4TcfPs+i8tqE2kMBlt34Am79ihU/Y5NEq
	apWkOPJjQ8krMW/r6xg+IVwE7kTtXgS7qTWwwPltVMBoQzggnG0YvOy3Sa4PeAmj
	8SUz0M7+QynNRuKucV9xS67PDdppdTbGhgf0zkW5Ew7D9TpkLttUDT9XItB72yQK
	dMLp958QWaCNl97S9WftCYT7rX+trqIi7dmtcVQihd36LA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejyenam9t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 04 Jun 2026 13:50:03 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5a10923f7d7so2862401e0c.0
        for <linux-mmc@vger.kernel.org>; Thu, 04 Jun 2026 06:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780581003; x=1781185803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pNZYhuT8aP8yjUE8ts6a4+ZbHuHx6SQBsmF68wpFsBM=;
        b=BiSwjyhGF2RxjNI5Dvp5nzxYtRYRjBMm9+lYukWRHXNsK3IH3MFXGF7cW8kNIMYbVm
         6hnss5X4SX1rp2FOZqeoRL0DpakqK9L/TLYvX6v+ByS9v/S/AjqyZZNazU5v5fKyKYRE
         8YmQQvdWmYAw1DGJ5HsAOV74zudzueDZWPQ81z/G1Yl2E+cLc+SjFF5aRg87kUvGK695
         b1HBxJTLh/UirtwwiXi+L8Nr06JEapGBR6xwFqsfHwie5wBfQPxKn+MavEwIq9L+Fdze
         QlZ2HTB1ovLiZL3eVMRHMDaaL+duzg6eyStuA9xviHbm8YanFIQyM900e4/Qv+GJT9L+
         Rwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780581003; x=1781185803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNZYhuT8aP8yjUE8ts6a4+ZbHuHx6SQBsmF68wpFsBM=;
        b=hasY1laDb0KqVJtbzuKWHEAE7h+6pPWKAcBfb+jDFwT0UDLl3baazIbm191tYF8ovn
         0dRUPRePxoVJ7lWTxiJYQPVZGGPcm3qaqIW0sI2AzPTzzpqYw4+i46DRpVixXvWA+h1Z
         kr1PmHlr/zCbvpbtsLwIiaaaQeLma4sMQE1PJ0afMDPBLOFwszMiZOvfm6DwgJ3w0LWv
         HN2j629X4YjqpXccbZAUMeTxqdH2SwrinW/RiR7S9fY8CWwDq3++uDuPT/4lv1Niuulk
         Qkprt6shKd6RYg0DncZDvAeuslzNxAquAYYuGFHKnb3TldjFCUzFuqX7htcTXDFFUOVR
         uTNQ==
X-Forwarded-Encrypted: i=1; AFNElJ8SfeL01DcT1N4f5bvx+dFSbdtqRysy4h/0bUJfLUisU72/P5msnvVCw5Qi/IblCsgWwwm0Wbb6ARg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAffmOKGn5wKosIeqwqz96cCTWpdSWKxAn2PSrT32SjAk7XFB0
	6OL8BjsqmVNFmPtliDgORVG60Nnh+sKW96SN4Pok5+WTRbVZtRy2M2N8W4qLSvPm/t0DS0c4aLO
	ntea4uddJDaBXX1QMNyTDIm0tr2YyuXkp6GC4cngy2Q12ULLRUrjQLq5kPzv3Zbw=
X-Gm-Gg: Acq92OFqDpQOqaBawmJCWxirM26P84fWSWGqLce16lDlpEtxQegNgWnijDdovmey8FE
	A/mXSlk6300dOTVih5OwsT0iUw/S1GUDPJkLC077o/amp8t646B5nn5JxcyHac6m+k4tQz7TQTB
	CfL+OOpHAMOrtUHgTbj7/d6zA00omm0VvtdOv4GKpNH+2FwYSZEi3lV40CFL19ZgH+zCJ+kryeN
	dKzXnjO7TC//VdTXsXh+BQV/+9QdOIWC/koBVSTnbSX+cYD897z3SJpFBsqCFh13PMth3F2XkmS
	TIrsM44Gq9A+vtJrNetqIDpPV3vpxJRHDewYq03gkTo+yercP6zf2sG2Qwo2J/NEsZTL+u+Jigp
	reOIQk0E219wPYzG/ucRQUj956ZCs5ulTi1g/EVS7RI+XkaRHPUBNzhzEMe4AuU47dI7HASRVGs
	M2K9FQ3CBZCOIzXgJ5tJaZO4y8Ij0ImJoAgBmNr+qiozKZLA==
X-Received: by 2002:a05:6102:26c2:b0:6c5:3cad:68bb with SMTP id ada2fe7eead31-6f53f84fb55mr1743870137.2.1780581002919;
        Thu, 04 Jun 2026 06:50:02 -0700 (PDT)
X-Received: by 2002:a05:6102:26c2:b0:6c5:3cad:68bb with SMTP id ada2fe7eead31-6f53f84fb55mr1743843137.2.1780581002320;
        Thu, 04 Jun 2026 06:50:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8fdc6bsm1211693e87.29.2026.06.04.06.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:50:01 -0700 (PDT)
Date: Thu, 4 Jun 2026 16:49:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
Subject: Re: [PATCH V1 1/2] arm64: dts: qcom: Add SD Card support for Shikra
 SoC
Message-ID: <gq54nr2bzvvqkocphvkji7g7rhbsrngsno7gvsfl4nsfvakj2a@wsfsnohrnscm>
References: <20260604122045.494712-1-monish.chunara@oss.qualcomm.com>
 <20260604122045.494712-2-monish.chunara@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604122045.494712-2-monish.chunara@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=JaSMa0KV c=1 sm=1 tr=0 ts=6a21828b cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=6ET1qOE6ZwCBE8PxlAYA:9 a=CjuIK1q_8ugA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-ORIG-GUID: LoE2wL-b23si6aCqXHTZV4BOmiXqnHI3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEzNCBTYWx0ZWRfXzV3wIv5TrY2K
 TGCSOiRQjyVqLi6gZKRMzm5BL5ozrKIjUqvX2QnSEbkb4cKyrk0DPz3Z2vjIPUuJF05hXOZJ5c0
 3a5TTj+4J61V4KiLYu4QrtVh/xCGIhyTdbCH1iyB9Z77Cksiz/uRE3vjUDOy0bQnSzy/WoX3Hod
 1bAnvtjENmXVdbJzQ2cIMPQVadHjkkt7f6eQBGtlh4Ta6YVgaA6Bb77OvP98hONcaerVrrUgi7H
 M43WGzIuCvK97DvMKEKoxQeYog5rSMDxEDNR/kgkDy7i/uoH0bYLgsNfJyC+jKQFkD8mFy9+DRB
 i00RLHJetvo1Q82xk9MO+4Wah/eBvfh2kPSUV0lTf2FOndPJDibD4z4/gfFqwEUebMDLInZl1oe
 nc61QmPwBplEGnSCT5cWU9ttp373AWPeEYgc0sP03Bx/646R1t5FiVjmpNJtZfyeZlWbR+lVpWF
 M2HyOd5RL6cdcPnUUpQ==
X-Proofpoint-GUID: LoE2wL-b23si6aCqXHTZV4BOmiXqnHI3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606040134

On Thu, Jun 04, 2026 at 05:50:44PM +0530, Monish Chunara wrote:
> Add support for SD card on Shikra SoC and enable the required pinctrl
> configurations.
> 
> Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 93 ++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
> 
> +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
> +					 <&gcc GCC_SDCC2_APPS_CLK>,
> +					 <&rpmcc RPM_SMD_XO_CLK_SRC>;

Misaligned

> +			clock-names = "iface", "core", "xo";

One perline

> +
> +			qcom,dll-config = <0x0007442c>;
> +			qcom,ddr-config = <0x80040868>;
> +
> +			iommus = <&apps_smmu 0x0a0 0x0>;
> +
> +			interconnects = <&system_noc MASTER_SDCC_2 RPM_ALWAYS_TAG
> +					&mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>,

Misaligned, make sure that ampersands are at the same column.

> +					<&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG
> +					&config_noc SLAVE_SDCC_2 RPM_ACTIVE_TAG>;
> +			interconnect-names = "sdhc-ddr","cpu-sdhc";
> +
> +			power-domains = <&rpmpd RPMPD_VDDCX>;
> +			operating-points-v2 = <&sdhc2_opp_table>;
> +
> +			status = "disabled";
> +

-- 
With best wishes
Dmitry
