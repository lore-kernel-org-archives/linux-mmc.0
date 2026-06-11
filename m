Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E77F374A1E
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 20:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781209119; cv=none; b=ANC6Yu+sT6WPgZ4FbTPzNwLvH5DchI6Q+d3BlgmV0EQWp/+P7hyRYU+gICzqrxj52dwg/7C+pp8s7Y2jrR9XJ6wBxHcgDbihBFNENNSNO8rmrlinwDUsbuByhbJz5oA2K0SeW8t4yK9/AzCdHz4T8l4Q8uYPulwio7TQ2u3BlKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781209119; c=relaxed/simple;
	bh=DYyGCuBDUK0slA/6RuMYTeuS3GjYvbT22yJ7Ll7B/gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVvBHKxvnryQczoxZj1JB4rjOOjERxNKFIVk5dCItKvIr0AOJCR7GBtlg4KHL1wwX0fL6Z1D8Zgg53qXPu6C4k8O5odd2wSqxvU5roshhroypFR/7Y2Xtv78xQxyJZmrrxkJy9iLmycMlcqxOS6Nx8WxCZ+ovWBUxfbDZApp6mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I2O7Ibk/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BYrcmJB2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I2O7Ibk/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BYrcmJB2"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BJ3L3B1457628
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 20:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kpV9CXhTZP38LIhNRCDWw+KJ
	MwHc9eylFcIk37TdED0=; b=I2O7Ibk/kfARV7iSNU8AauOIOCcRi4uWwE5wDc+n
	OFmOBKUA+l1tzpdCFuiwcOrabPjVhzcYW6oQVkE7oBCmg6t/+vV43SJWi2vnT3z9
	uNLWiirhQR5UWJw5K8aGlUW6+eUmiyv0OD+MhU6KBhSvH54oJmzpkT6hZya3mTbr
	rgnX9YeBvMk4Mip6hYnMbEKfCLH//gRbTPBZdDqUBiqci5H9FHVY/wh60i4sQltz
	cJsYfVEfuQXBrG60RoJtyM+kcybVXP9ZdcY2pg+O6uZeYRY/4Gp4dMCTxSGYUWu1
	GDv2za2bdmafr0BvM2sYVRYJQQkGLpqkqpD5hKt938xZiQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er2r5raq4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 20:18:37 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6c6dc39a6afso82985137.3
        for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 13:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781209116; x=1781813916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kpV9CXhTZP38LIhNRCDWw+KJMwHc9eylFcIk37TdED0=;
        b=BYrcmJB2G4ZyMQslqu83ZlgCCk6g6GCem0Auz+miyHyxUI0HEYQggjylF7GTH1ZziQ
         v3Af07+k2+gPO2wYq+OE3wgNcRtPMMp24cbZI6CdcP0aerTRpBnb2AHFG6HbzPuPkM4X
         70JN6FRxuu7BeGXwXu258u+zNrmBtciFPSvy48koJ4JRz/WgV0H/XpF9q6mpEeTCBm3b
         VCkr3HXN7igjUZj8DoehqBB17eIarlJff21Vc2IjwVdihYHM0sbBZ5VoWl9meFNZKp7n
         fvjqyT9xK4S6koV9UNz9H5XLU80barDeU893bCYaAi+KlCsdbtuabC9Z0E0OSIryRevN
         nckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781209116; x=1781813916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpV9CXhTZP38LIhNRCDWw+KJMwHc9eylFcIk37TdED0=;
        b=d1N7k1roAS5JEYoPk32plV327S0wWtcR+U5moDmadevQbJ1ZJ7GhuBwda4OedPcrgC
         M2SWzyjIAYaeWoRSOzAxTV7UYJTBBzjhsWsCD072k6M095pquCyl4ijULrxmldFGNcWi
         i7c9uQApJu4x7ry5KNuRoLwKWbxGOUxll9TMxtTvYItKdCjykymAvDM4a9TCYMFn6zSC
         4X+39fD1NO0OcZeKJXurryhSgB0hIzsT6m6xHzjKsts1BrqSPZRuO1wKepPGFoVK9vnH
         W99YAUptyJWSbhuEJi7MMTD1HQwJ/fAtXBoBXSbfVjaml/6Zth3WQWHQWupzcxth6hk4
         oFoQ==
X-Forwarded-Encrypted: i=1; AFNElJ++URCLeXBjl7ds/XmY85otC/32g76H+b5J2pPMJMxLUkPbH0IZREnCGcdryPsT78qMf2qcn+2BwXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHYvpphdG6MCI9HreXUknRNKct1sQax4leFcVO9dHdgui/jBz8
	eUxPx4tOjzUQ80kLWjoFi0cVrFYW6EA/u2ciTcltH8hZpyuX4agJPPuDvWO8+gpNTpNQFiRkc9s
	dPMYgaqM7bR7kFjWwEklPfAxBCtUj0ePNQzjj6Df5VyRwR4s8JzZq0wjH+/6I0+M=
X-Gm-Gg: Acq92OEqmr0Riqjzs6aWKXORZUeQDhqRsHqGj3PC5BYGpVBYmePa18o8deJGFnsCUSa
	FTCkH1AoVUSYqqt7yLBZnPkdR9DPnmCQxtrmGvtnB810HFmcxWHPMLC5wluBkc4E5egbL778HS0
	JfGyLqivAjSJDTfKKFPmO1uGL013VPfUdbX+UVls+FoYjnk4wIVILZMUhqSA+762Eh5wDX/lI4J
	CRIa993cFkacMYQ4Wza5xQYTbRiergkoejYQ0UPAOwaxqFAUvRQRKlaaWg/PZCqeaU0I311QUVj
	DkIxPmZQwS26nMrhbqxftoxsYicdOxCqBoPI53NOJ3sOh5dpWq4+e8/0ApoblddUQpyqnJGSyAj
	hBu64n+nKNTq8+jXrFaaXy3cvDamQRsE8Zm847MPl6X06FAWg8ezlqjd3+n/wqeqqJ7lul0yKTk
	aGNzuZrPSDMM9aQfvNKmWECULlT4WRKuif62M=
X-Received: by 2002:a05:6102:512b:b0:634:d42d:15e2 with SMTP id ada2fe7eead31-71d5d19c0d6mr3018838137.26.1781209116615;
        Thu, 11 Jun 2026 13:18:36 -0700 (PDT)
X-Received: by 2002:a05:6102:512b:b0:634:d42d:15e2 with SMTP id ada2fe7eead31-71d5d19c0d6mr3018829137.26.1781209116202;
        Thu, 11 Jun 2026 13:18:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39929f5683dsm197481fa.31.2026.06.11.13.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:18:33 -0700 (PDT)
Date: Thu, 11 Jun 2026 23:18:30 +0300
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
Subject: Re: [PATCH v5 5/5] arm64: dts: qcom: Add Shikra EVK boards
Message-ID: <mxtofzlu3nc5ybmrzyb5n5nijujxk5c6dx3tjajdzaj56asyfx@25hmlxhmwx7h>
References: <20260611-shikra-dt-v5-0-103ed26a8529@oss.qualcomm.com>
 <20260611-shikra-dt-v5-5-103ed26a8529@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-shikra-dt-v5-5-103ed26a8529@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 0xNfT4ZRxib5__oHgdMXfP0NNlfXBWjO
X-Proofpoint-GUID: 0xNfT4ZRxib5__oHgdMXfP0NNlfXBWjO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIwNCBTYWx0ZWRfX8gCRdRrYGGVE
 m6lxsmacFejjQ6U65AbJYzmK0iRPrSz4+bSi+pe4Hp4fdy9gOKRQq557+jfqDKncQRBHuW3RzSd
 kVC/h9DMwZpoO2n5r9rHiEldsEX5opU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIwNCBTYWx0ZWRfX4MI1DMDsfVn4
 Od3Us+NJEmlub6jDngN3WMVsO5lbFiGFxH9vDqiHaPFDbGPmg0hAhismPDVDi0cP3azz+HqYBFQ
 kB2hsQn5avm9is8P6ADrmBaybuPOIF5g1sXvkHLmWORi9JHOq8cC9t8VuoIdmFoWnmHF8+PcSYm
 DPL60L2vrsV+/sWVAkem/XDH9e9E1jRuUtLUUmssZq6XcbxzPrNoHK5AQ6BLBXgbTcugidEGTXE
 wZ1/bLiFL22X7UY3Y/2RlcT2mpfCtj+oNX2FP59W7ZfxZmWCWqH6G8+AMOoS5kcBfFRP57p4cf1
 1uoA1nkmrySPz/lqYc+lI5yhKI8ZdPFKrGM7B06qA88c/0DjiTgyjA6yDCP0KQXl5dU2zSpj31A
 oxjXxwfJlpqMv9XUgCB7366lw7yGOulOTm9fnm5Y9PBC8vhvHxLBHNR72D6y8zAD9WAyzYU5aU6
 6/ON76u0VLR6Op92DOQ==
X-Authority-Analysis: v=2.4 cv=M6p97Sws c=1 sm=1 tr=0 ts=6a2b181d cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=sekFKQr-SxL-p-8QmjsA:9 a=CjuIK1q_8ugA:10
 a=-aSRE8QhW-JAV6biHavz:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_04,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110204

On Thu, Jun 11, 2026 at 03:40:12PM +0530, Komal Bajaj wrote:
> Add device trees for the Shikra EVK platform, which combines each
> of Shikra SoM variant with a common carrier board.
> 
> Three EVK boards are introduced:
>   - shikra-cqm-evk.dts: pairs with CQ2390M SoM (retail, with modem)
>   - shikra-cqs-evk.dts: pairs with CQ2390S SoM (retail, without modem)
>   - shikra-iqs-evk.dts: pairs with IQ2390S SoM (industrial, without modem)
> 
> Also add shikra-evk.dtsi, it represents the common carrier-board and
> daughter-card configuration shared across all Shikra EVK variants.
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
>  arch/arm64/boot/dts/qcom/Makefile           |  3 +++
>  arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 40 +++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 40 +++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 15 +++++++++++
>  arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 40 +++++++++++++++++++++++++++++
>  5 files changed, 138 insertions(+)
> 

-- 
With best wishes
Dmitry
