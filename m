Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE3F368D77
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 20:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781209065; cv=none; b=XVu4aYQ8O/QVfV3cjKUaOxKA4rBtdZnyWBLl8Vm4eF6r+c2eU8p0jPTkmT7RgLMwozA6jYrnXWjNDi/VLxoAC4z056UaXi9yp9RvtUjoncAcigYn5nISNt7l6D2UgmGHeIPYndFqZEhuAUT3sL2oFjL/sGmstf1fjAFS7A8gIKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781209065; c=relaxed/simple;
	bh=DEFzM9pXZjoiCXMOLYWdhHfA61XJJYsjWM9qvuHFVSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJZl3uOCBWU9sbtc7pDthrIMC8QjYGCD0oOKWLsqPD1o1H7LEPwRDjGwP5xg1oXJe1t/3QvnsKreAs1CJmR0stwAId0ddhBCgGSideQP2alp+lxgSyt1y80Ket6FdxlZuH6XQYpKKq1O/s0hJZht6rSshS1pfGEm+gyFrdt9lpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YYlqyOcu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f9wjlJtq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YYlqyOcu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f9wjlJtq"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BJ3Gxl1457454
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 20:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=9dSIL3f/lhstR7XBW0gRBnx+
	J0TbGOFQQgQzZUkFx2U=; b=YYlqyOcuNltzgMs7FrR3n5oiX34sYCUwZ/Xf9/rd
	MErXAos1iLNMlikcBn46+57ZPygnE+krVxT8qnR9BsKSz0ckkovQomkKHWy2s/bS
	x95D2pDC6KyVWhM7xdBEoB5ul9urTtY2/uoTlj19eRaXfQ1WA5jTF7hl1AU9riAY
	OxE/d1lhp815TCDR7O0p0YmFZjo+Ww6YJZGCBZ80W3VgKO8YgLpjxfnmDk1kfVDc
	xGmhy3Q7kS4xCg/5/PPkpytHAQvWZWSXkoLTU9trGTFlO1JYxeSuMuvEiPsKNLWu
	wegh/cG0LcTh4NoLXxFo/lU/sd0FISzy/F/4fGQz+evuUQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er2r5raks-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 20:17:44 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-963b11561bbso125063241.0
        for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 13:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781209063; x=1781813863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9dSIL3f/lhstR7XBW0gRBnx+J0TbGOFQQgQzZUkFx2U=;
        b=f9wjlJtqsevDqeZ//ufLdJAPYCGo4dAsxlYma7OVRNmtrycRO8vW20NCm6q6Bgz4rm
         KozVPQn8X95ZRUPsw09Z2D54WfX5M40DjGNt3pX7Rk/+BpFqxhUhTMnpiWSvorkBHxj4
         omvxRE/vWikFaZju/bcLHif55bVBfbnlShLps2GZjrOFmoqCBOFG2410vUNTcCn7bsVn
         AJU/a35mRYrdLMwC1dBXHdF8zpCA9wZEnVV9ug4GY2RzUHK0BtGafd8Qe1XMTJyUOXCA
         p0hQKh1JlrbX3zKjTwnkuO1KYx+jTQFNlhKVwKulqpw19xCxDqT9Wch0cAnriqiQ001b
         vXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781209063; x=1781813863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dSIL3f/lhstR7XBW0gRBnx+J0TbGOFQQgQzZUkFx2U=;
        b=W7jNrBxSFlZNFv1wpIO+ewsyWAtJx161p0N+dYpFb/Z2fwGI7Km4Xz4k9MOy4vM41r
         AXH/JKYFWQGZNaEEisXjM3wAsQtE6bhS2nG5aFMqpFMJ6xC+QB+gNVQrggc077fxa/sB
         j5yQlpsq2p9gm58KRsXgT9X8wZDRFXegNoZaUO5FNXC78ijiYLgRRReuJ2kotW6ZqMlZ
         ZReQT64fw0lVnEYBkE4NGxRhINjDQ24hMGJgO0n61k8hc14Kq3scdYZFJDFw+lAcdQra
         z2YD0/a56kIGa+AQEUDtUO2Ygs5WTWGpAdjjFsra8+jGL05b6CVlfVVxBPZuJuflQf/F
         ++XA==
X-Forwarded-Encrypted: i=1; AFNElJ88sDotLyePPgiFtOo/6iqNhVFvWrDWM6p9xLsoMlpaPTO+LthSVUTji1HJkePhobdalsvwHNofm54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4eq/JHHTI39oUCpbGW3jLSMBv/6LMvsCriBwlrCnf3/zgCHMg
	mwcK7N2Vhb0jxFhTMS5fCSHLqK3G2u5cZ9cvHFLUSO/ORL3O5wlb5TwYxCaFVoF0VpPDa5JFbzg
	gOf+M7DhbXM6DlOVOwfLBV4ju9m8WgXTXUu4O2J8gUfT3lAQ4gyGK3hnacTjf6RY=
X-Gm-Gg: Acq92OGBA8sUgLnwJRDbxayg2Usq5II1sXdLyFiNOSya4qtOGcEAsdoiZuGLrWebgtT
	umTAmpGgfz2PQworeWbAK6m/MFKiE43+bZRc0ycUWK0lvfWBf5pJ60ic80NJEYQdSfyFofE9SsU
	lsxidMKdCeD8GnaCYBzbaJAVUBMiLBET4t2epqpL0gB/G3vrsFX6sF/GtnbsfNcsMUFLUpHAjEO
	pF/tOocJ43mp0ha9Kt75Nbnb8JT+zmj8RW5raoUjuTZcyMztphvb1VAxn1IlK49KWK9Deq0e82v
	3g2R+FNScdbFRy6psovOdY5IfrXirq3BTWp6lZcgqHSyYu1p4ba1pdOyX874mQ4A4nRu5eFaRml
	6ScouqFIOoB/7bcPfjIaq60Tvqh4Nmg0L04TJgyAfmVsmQRMY/f+hkwbWMBsFQyMy2gYEgnJwho
	n1isrDfp9OAW9oi+LC7/kGSW3rnmrsLLJNb+w=
X-Received: by 2002:a05:6102:370f:b0:631:d3e4:efc4 with SMTP id ada2fe7eead31-71d59fe3bbfmr2378701137.11.1781209063128;
        Thu, 11 Jun 2026 13:17:43 -0700 (PDT)
X-Received: by 2002:a05:6102:370f:b0:631:d3e4:efc4 with SMTP id ada2fe7eead31-71d59fe3bbfmr2378684137.11.1781209062669;
        Thu, 11 Jun 2026 13:17:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2cb3f4desm121518e87.29.2026.06.11.13.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:17:41 -0700 (PDT)
Date: Thu, 11 Jun 2026 23:17:38 +0300
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
        linux-mmc@vger.kernel.org, monish.chunara@oss.qualcomm.com
Subject: Re: [PATCH v5 4/5] arm64: dts: qcom: Add Shikra IQ2390S SoM platform
Message-ID: <37vgpqv5rir2rdunvl27dv5kydybdwehinytow733cmkscue47@e6pnlxwklnq6>
References: <20260611-shikra-dt-v5-0-103ed26a8529@oss.qualcomm.com>
 <20260611-shikra-dt-v5-4-103ed26a8529@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-shikra-dt-v5-4-103ed26a8529@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: oKDITbASQsN8miu0wr3h3ijmJqXmqkAr
X-Proofpoint-GUID: oKDITbASQsN8miu0wr3h3ijmJqXmqkAr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIwMyBTYWx0ZWRfX0z3rHHVDMpvy
 IKJH9ZDGwBg7aYpJoZ3pKoF2c4Bx/4Ljq1FHEGSRb3uenFNudDWkAQriJmUEYkX29pEL0ofJBjg
 jZJ/bbOv5WKGT4HM9NPKBMcdCRZijdQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIwMyBTYWx0ZWRfXzbcoM1M7hqmr
 uzrh6jQCicaS0TyYZ5UUF3COtxxqyXFp751zLEosZuTE8eZoKBcthOz2E7yTVLnXpNV27ASdb/R
 uUp8Df2PvhsPcyGGhaPlYuKRenQ0p3Bh5h92OycKpFa3TkHK5/It29/ZD6elCMyJMdzgG6MVfuZ
 LRdOYSiwFMaOUQ0gjy+lJ9NtT4NCeO2tm8/g3iQkVdhepWUvM9dNWewoY4VdA0m6qSqQF0DMYfs
 vBMYsgThMVvmwmhpikopfhpS1WtE6sG9+bYVCbUWZuZoXpcXSTFExeFl/pqQDILpKcDsojQIA3U
 VhhCGiap6IhX6c/fiTOx7dTdsoLlzElExNA8xzr5gBfTHJwDkOtbSOHD7rB/5kNcluMpD1WEuX/
 lH8MHovoGen8Epf/mN/kIOvHDLx6zNqzZ6dx+38IsuwdR6Q7xggNyLrjlqmcrXEpCV1ST8G0yT6
 H3rbyQ+9S8rYWzpQpVg==
X-Authority-Analysis: v=2.4 cv=M6p97Sws c=1 sm=1 tr=0 ts=6a2b17e8 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=MSeU50jLikp4iQrAx_QA:9 a=CjuIK1q_8ugA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_04,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110203

On Thu, Jun 11, 2026 at 03:40:11PM +0530, Komal Bajaj wrote:
> Add device tree include for the IQ2390S variant of the Shikra
> System-on-Module, an industrial compute module integrating the Shikra
> SoC and PMIC for industrial IoT applications, designed to mount on
> carrier boards.
> 
>   - shikra-iqs-som.dtsi: Industrial SoM without modem (PM8150 PMIC)
> 
> The DTSI includes the common shikra.dtsi and adds PM8150 PMIC regulator
> definitions specific to this variant.
> 
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi | 170 +++++++++++++++++++++++++++
>  1 file changed, 170 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
