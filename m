Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6389921CC71
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020366; cv=none; b=ApmqIE2X/wYI4xxBgfiTJTCr7QU3FXCYegRIfvjfd/zho8YJ00MYwR/0Vbi6IDQk66xj8Tq5ex1s7i1UYEvsKTu1AAJTzIguI7I8TrbBNHdGB5Ow8tp8zMK2zRx2UxOZXPuRRPh67ew3O+nRLks4HUnzLhJUEDHA2oREHCxsI3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020366; c=relaxed/simple;
	bh=3dM7vJjkg5Mx5e5iRX613YlVuqKV1/6CMF1mfmG8ByA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsM0FO5ACmHMLAGpHJ8blI4/BOoUn2YzFocWyL5kJFx/R7u8vlDYsJq5kCUdpusZBpBNV6bidqcVbo/WRkD1rLEXRu84yfgJyZhUXEkH6eJ3bPTDfix8cULbAKJWbG9IdXp9ynA9MMa1pv78dEHPJSoXlKAHtUYj03yk5PduW9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iyu5PinM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iyu5PinM"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAZupP018492
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 10:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mFiDkj+L3cwYNIifGEmZEYEZ
	JXhnfzx+t8PT08ZFf5U=; b=iyu5PinMriJk0GeFWONK3k72LxXT9dlRpzDlwyID
	4isrTtlsPWxGcINhGfRg2Gz5klPHcUspF3zgrVQ+seHHm0GDEZbC3vFJAlvWN1W7
	J9KZCeD8idbZDwUHjhannikKtAwrG4llLAVfqxzB1vfwixDftMI+ZtJQiHpQ4QiD
	vHkr0TDI/RcA2d40hH0TN3wDURsxw6x0VSyS9ieY2/L75xobUQ7HFngo9mMaOdit
	hv6c0eRkZA67mzRSBZQVbHCoSgiDq1QDbtnHZjhaa6JU5Jp3TObH8SJSkVPB08ir
	56dC+5seyG2nJwTCZcx+QaWjJ2DZuxXjJPFFCr5GokZ8uA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496da9cyqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 10:59:24 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5ecf597acso120580291cf.1
        for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 03:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758020363; x=1758625163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFiDkj+L3cwYNIifGEmZEYEZJXhnfzx+t8PT08ZFf5U=;
        b=wTwVWQx8o+0zGvEKIBJhadY+kj3KgHZmkz8aYI5oz6BKO7QpevkSi1bx0SCKJ89Na6
         16a4/7Rn5Xq/Byx1Rh9y4KXz9eylvoRpCmJKdxvDJ3X4cZWWrSNsAK3tpy9Q9EpjBE8E
         MWHtELXpnc1S5NEyNoQ92N4IWUmTvY36E5YN6yh7AR28J+HRt/8j4QzX/ZsbvDu2C0H+
         BZHJqpGifsc/EXq6IqHgovO0LVL1XkgMQVxA71rX+pkFLCEWGejQsoGi4a55Sm3DzqiN
         BqttlraPO/xxjWI0/Ejem48aF+0MPtBKWc+T6L7bCYiZ8ozelwufMpkMXdTcubBQusNY
         oC7w==
X-Forwarded-Encrypted: i=1; AJvYcCXJIJjBJzq0dUY5F1u4doqeZ79uv+a/1vanAN34sNMba4tSXJOWHpCwnHdRxVEUXFnCxrCctE8eoN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8EX4njiDzZllpKAEWJ29rA0DVB0rxK6YLyRyUhGEvWKuJe1C0
	AciUbsE0LIbRQEUwKRYn4cCgwjXBBSUfiocx3MfPicb87fEw4ss5QPLWTqk6xLT3LGYqUP38J48
	4+PZqdB4GX/0dtCKyGgT9kwMiQKNsz+0GDNZ7EC+EnpoMTsaF6hi9SBqt8779RVA=
X-Gm-Gg: ASbGncsW+LPr+W59puhD+d0WNO8M3GrywWLlFMAQ/c9IX+Cqxc0hOiwCsEnjLSnje3X
	HRsXUHF10aqVj4AlvyBNtzlikpuC11tBU8q9KeJRziCfQKS6+66Hm+tI2nOqFQHTfCokhq0HpqF
	af9YvyhUhkhUZooBMlzVNgRF/c+xx2Fs4dCIiDfnA7potnDYCGn/6idS5gqks8V8K4SOs4CM5Qc
	VbV9EAbbBvI17hkAdecQZFdsw4rBX/qlkDA0LX61YIehxfu98+Lh39qaZXLuGjpJ4TmxTXUkMpC
	aVccBOTsE6lLtF/ynFVQJ7ysurUEseTTyfW6XeKArjpWyuUlwGQQm5BoBZqWfCCiD6RU9IQZkXs
	78ObYTzB8o+dZcjnbyKE0cpaTyZ/m6wrt82g10hKmy2efyKWleySs
X-Received: by 2002:a05:622a:5e18:b0:4b7:8cf8:21a1 with SMTP id d75a77b69052e-4b78cf8257dmr88217111cf.82.1758020363425;
        Tue, 16 Sep 2025 03:59:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDj/hhJ5O4jQLZi/UnXUBCLpKD2mcKKa7z5f6/+2XEQQYMmtnF8am0LXMBESmcmRpgg7zgUA==
X-Received: by 2002:a05:622a:5e18:b0:4b7:8cf8:21a1 with SMTP id d75a77b69052e-4b78cf8257dmr88216741cf.82.1758020362518;
        Tue, 16 Sep 2025 03:59:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e663c5005sm4331812e87.149.2025.09.16.03.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:59:21 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:59:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: Re: [PATCH v5 02/10] arm64: dts: qcom: lemans-evk: Enable GPI DMA
 and QUPv3 controllers
Message-ID: <n4p4www37qz4hw75l6z2opeqks4g3u26brceyxi6golam7f5aw@raandspcihi6>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
 <20250916-lemans-evk-bu-v5-2-53d7d206669d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-lemans-evk-bu-v5-2-53d7d206669d@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=M+5NKzws c=1 sm=1 tr=0 ts=68c9430c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=E-8pkxSmLjkzrIbgvO0A:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 3VE-mgdZ4zjTUVettFoc0dbsXmY9-yKf
X-Proofpoint-ORIG-GUID: 3VE-mgdZ4zjTUVettFoc0dbsXmY9-yKf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA1NiBTYWx0ZWRfX4WGH+h27cgqD
 pMi2hdhR+eKHUTIINbeXVO/rMXDOiQAGgkUWojksT7U+eCVVnjHdUf2kdb13mNMyc8dzMK5J2U4
 YthUm1364kRh93Liwj2PGt9ERClYYe9TlYepqPDcKt1v+5qejTPfU+EKSOg0GHlBHxD9WDIcGci
 ri2DLmFNP8uYRiCSgLo05FHLSJYlusAAOgk/ZUZ7tplwchszV/QgEQmf5f5C2Pnia5HfOoVbBAn
 pGgTgH3CaQc/JjNQB9NcFpG76z5tMU5J8Kwz2awcWjMiTlqTNYU3uL77RaVJCDUjuqMcPfcplrR
 A6avL7ExJCQWajRRaTZXJVW7MAAZurri6k822W8IFLTg/K/jO74dHEvCfWRKrnWQh6jjIcBq2q+
 RpbX+6Pl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509150056

On Tue, Sep 16, 2025 at 04:16:50PM +0530, Wasim Nazir wrote:
> From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> 
> Enable GPI DMA controllers (gpi_dma0, gpi_dma1, gpi_dma2) and QUPv3
> interfaces (qupv3_id_0, qupv3_id_2) in the device tree to support
> DMA and peripheral communication on the Lemans EVK platform.
> 
> qupv3_id_0 provides access to I2C/SPI/UART instances 0-5.

Nit: used for foo, bar, baz and slot ZYX.

> qupv3_id_2 provides access to I2C/SPI/UART instances 14-20.

Ditto

> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

-- 
With best wishes
Dmitry
