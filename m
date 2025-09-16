Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16802F7460
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035507; cv=none; b=lvVovSSXyjRjsTNZqCTUUuIbkqVN8kroWOXHwiI2w57Zkp/ytfD6bNzaCk9xI71C/HNQYKM+zKmemYUjnqH+72cAhimD4ly/Z0T8DsIFvReHlzO7ChhauxreIF1PrLh8N6xIOvLfV2ZzSZVQj7R0BkA6flw+sfc0qLk/zl1VedQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035507; c=relaxed/simple;
	bh=t7UUwd4xgMft90yTMEDkSkQCO8HRauBhf0Zx0laARP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/idK73Tp+XlTSe/2Rl5k9/Kon+IjhRcNjxkAUxewK77xj1Jj/8YID9yizAChhS4FzCUManw0i5I9SrsvuZ7LL1vANRcLqZ5t9vVDnWBKLtnpoDjAjdNKqgOK8Y+x4BB2ZJgR2l+18pBVtiiBOuRFvpuH6iKmRqdGJPeeSwyZU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JL73Uz32; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JL73Uz32"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GAOJoB020391
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 15:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TNby5qq49hfo4o9k//m3Xyh7
	0OtDv47+M1YG9MtLCxg=; b=JL73Uz322hjo7db1y8VK6MOqpZS/kNSXyhblTxji
	X/8ett4qqsRTgS904srclOUiORO9cUQ6fCNQAdqVvbcsd/FpA1QncRkBfd94o/9A
	ayIVhYJNJflxOOTiId6jWan/mBB5kLQNYuopyYXUUqOWrhXA8sAyxX78F0XvlXJG
	pHHv0lRCGDuOZLzhNvBwVoJrRRHia2ITx3ocbJdXEAH7TxVOXS2Ot2X3WxnxRsKs
	w1eOZm7vGwK6MbzBwazgwh3l3yTmEKfroCsKUCamZGZk1e5bGDicRtqDY167Q7ag
	Hs+kbQDaAo6941gLLkSbxgZDV1ZTBANlxA4/IP/V80SL4Q==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951chh89s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 15:11:44 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-544a9f8878dso1855406e0c.1
        for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 08:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758035503; x=1758640303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNby5qq49hfo4o9k//m3Xyh70OtDv47+M1YG9MtLCxg=;
        b=EPWXH3jUr4GcfPuWAbQ9k1ofnmuZ/6Ogupam/MN1ZiOMHxcAZOenAuuF8naLKxjWr5
         zqvWzjGsFWLK78nSdbhttJYEm9hQCkNr0T5Npsl3Fj47qb++XkS+75iSdSj0xSKir77f
         Zhwd2KM1rysG20xWLEyOeiAkFRD414YI1QGLL+h95QrLAWAMbEerNrhESIurnI6H/s9O
         NniXyDgZLKSkyF9GhLC0i1A6BcwrPu+6776/5PfKV5ck8sEx9WhplxQbpKFVBTMsG6xH
         FxGljEEPLC2sz4vc76nSdeXFrM8fxB+HfhViIBQeiFfHS6MUG8MtSFz47jVS4/8e8Z/6
         f4SA==
X-Forwarded-Encrypted: i=1; AJvYcCVkOU5fEJzjF4qErVEKmUfv+WPY4x/KUr2fZBaxzr7ktoYsGv8HJxk0YqiZ32EqBhwqmsKNzsppbCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0PIDxVtIiEBOKxR6L9iuiJNXZ11MHVWSdEe5m68MA6MQLmDWg
	+q1qKrryUnT1nokLaBileSX5hiUGwPwn5M8l/KGjAQIn8ruA9HxS0Y+8qmMjFfFh0xkqeX4cJi6
	oz8T/q0zDXG7FgHiEeG1xd0ZJTjRRksz8vrm+ZXdYFsQHadv0iTdDq/P12umX3rQ=
X-Gm-Gg: ASbGncvcYXwEnI9VrubfM6Q5rLDkRC4GoW/IyxiBY0wpezKFIP+3dySkyb1mmMvVOlB
	h49sKwT3RNo9MX1LqcZJ3lLRuDNA7YDe7s5g4UrBEFznxSyPAn+pjV7+436VoJBMJyRhUVRGwLK
	KMpD4io+V58xux6OsGehVbiMqS5pDW2c8xEy82fASL8jK2GiTKM6K1uBpgrzi1/eLgX+F01pYp2
	KKU8NwaTcOf9jGDL3eAN5UHUy+Ab5kmCtajiLVZt0atcrsxi18fE3DW4NFFlsipDOsvxvhzHMgO
	BTpUQniVXGGeqA4Vj+yPyLhSyQ6SsVB6LxyvmvMBg2EOYXZMuKm4NIIPgF6ttBBfSpKqT99yFtz
	kkSGsl4uJn62ILjR1/oht0CqewClFw2cQ1jRmYrgVIFnQpxv+07to
X-Received: by 2002:a05:6122:3bcd:b0:538:d49b:719 with SMTP id 71dfb90a1353d-54a16b2c285mr4799748e0c.1.1758035503247;
        Tue, 16 Sep 2025 08:11:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjpODeFy3ymdDzfM3pALWwp0engqNOO0v2fjb8KygHwUWmCU8dovGzcM73w2iuBtRoo/d/ZQ==
X-Received: by 2002:a05:6122:3bcd:b0:538:d49b:719 with SMTP id 71dfb90a1353d-54a16b2c285mr4799705e0c.1.1758035502721;
        Tue, 16 Sep 2025 08:11:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-35828d19a04sm15474721fa.9.2025.09.16.08.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:11:41 -0700 (PDT)
Date: Tue, 16 Sep 2025 18:11:40 +0300
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
Subject: Re: [PATCH v6 02/10] arm64: dts: qcom: lemans-evk: Enable GPI DMA
 and QUPv3 controllers
Message-ID: <pwnt6obqsyq3o2qzqk5fcydzlhwv7ycmywvdeo5pwhvt6kbw35@ce36yjyo3hp4>
References: <20250916-lemans-evk-bu-v6-0-62e6a9018df4@oss.qualcomm.com>
 <20250916-lemans-evk-bu-v6-2-62e6a9018df4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-lemans-evk-bu-v6-2-62e6a9018df4@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=eeo9f6EH c=1 sm=1 tr=0 ts=68c97e30 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=lcEb1VsSqg0gz2oZhFQA:9 a=CjuIK1q_8ugA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-ORIG-GUID: 1kW2Xi_uzk4fwALQzXF9XszHoMfPsSh-
X-Proofpoint-GUID: 1kW2Xi_uzk4fwALQzXF9XszHoMfPsSh-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzNiBTYWx0ZWRfX2jcYLnXlVPYX
 unZmpgXuTgj1hq8G/TrTMHf0LK8xdNUNGGXmGgiAy+1p7+Ao+NtbeKRi6s1aHrhKLX5NmGmYhI6
 47ChnRq/1t7x49R74iuFL+tkQcReimzYy9yDkr9zGhYtSgl82TbHI8Iq01TgjFQvJe8U4cz1udO
 tJzoFvQNQF/ocu4NE+Pa/QZlr6Rtox1B+tEpIvhnzuFEIyqUMg1EHanfODxZLKED80NkQ8wKDS1
 tBV9VLHlPKHLk6P06gmxqdGPCOQqibcAZystFJhaggGIMZsaoqYtDTM+mbd1JMLJam8uXSZPdrI
 Sdi6Z7Bi35Gtul0pgp3qNVwkNd3nAnGczNeRaXFl71+8WORqnjhvnToqTJluBm4SgRXBJ3mdh49
 NgZ5VO9L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130036

On Tue, Sep 16, 2025 at 08:29:24PM +0530, Wasim Nazir wrote:
> From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> 
> Enable GPI DMA controllers (gpi_dma0, gpi_dma1, gpi_dma2) and QUPv3
> interfaces (qupv3_id_0, qupv3_id_2) in the device tree to support
> DMA and peripheral communication on the Lemans EVK platform.
> 
> qupv3_id_0 is used for I2C, SPI, UART, and slots 0 to 5.
> qupv3_id_2 is used for I2C, SPI, UART, and slots 14 to 20.

Don't rush sending the next iteration until the discussions have been
sorted out.

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
