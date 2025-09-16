Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB2229B8CF
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020759; cv=none; b=KRnIFYfujj/DrS0bwBSGg5xiYK61cPL7kFCQWboHu762UI1wv+U7IytSxTrQ3kKjllodqkHG8xUewlgQcEBLHKFCsSVrNU6rRec4OJTZkY0JWY22jSEm9zSgcVy24O1pJVe4PLgI452LjKkGW8vDNPU7xhu08jVPNF7l0VKZuW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020759; c=relaxed/simple;
	bh=Or3sS/huFAjjeAedfhopVNlc2SuDocesMGLsvA4ovd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4OLcV43e7SAd/7G4khdDA1nYMJPhob6Yb++pM3qbEKeXLQSvGFKQQ84eYzjOU2W60ljuIg4Phnou+P+0hNkIBsbB/p/vdO3bZCjAEMkOxUc/PJUYVjvxAYNiowQuIEoVwkPWFuKqq4RjYqKPdIkspFROoj/V02cATqoZB5szDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dlMnqi8U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dlMnqi8U"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GA4kSj019791
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 11:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ViaUWXz7piwPDVzZe4GL/ffGnLLhDpYLwoddXmEXM0M=; b=dlMnqi8U2RnOWLuX
	aUoo0GYh4eO3jt2D79hq2zvH/s22QZ4in9+ugovXj7b8YuuCsexG8YKjLFdc9SHO
	3dmhpbPf7JzY92hJpDvqvOOhjThlIrGQjPJqJ1FVmzJK3fuGGwo/QmXm0Ojg9vPM
	H+t51KcT923S/64eW6v5izajWnen1tdA/1NWXt95CZifKbvu14UrOlRaVJRVbHUP
	iF7ePXDwHTyu5u3U7MfQLSmjlurJjO1XF5NB8I/M2cxz7DeHYanVxei9CsUhdLq3
	gjVsUtEMeI6knYUh5ShX0fuTR57RqRy4G3HoB/uOwhJy1sqvr+8bFLxoQAk7nUYU
	t8WfQg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yma8ksx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 11:05:56 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-78df9ea0c9fso300606d6.0
        for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2025 04:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758020756; x=1758625556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ViaUWXz7piwPDVzZe4GL/ffGnLLhDpYLwoddXmEXM0M=;
        b=OOaopm/atiAWKnuRGsw+Zyn8flxJtGQAqTmtwa4NPDZQ5CEy6aP2rRRdM2QjqX5CQs
         F5V6rnD13IpMubTxI15uIA3/OgTLcIeqEWnPyigsQ2/eyx1HOpTuXoJFuoqOa0qzwe2W
         oNLOXiuRVSqVsH15NxSYodUoTFxEReemzoenBABraJwCALzUY2R2aWuGeqDTFMzUcIE4
         pbp0+zhtKiyOUmPw/qrfzC8UdBJGeehsxylDlrRJqcDZqWseZnYZi1k1i3LAYOZ+B4MW
         I/ruyW+0D2Jb+touFzZknEc7QqLJckyQ947it81WPDuj27/jateBhwFJ1QdIyE/qEA3E
         GMSA==
X-Forwarded-Encrypted: i=1; AJvYcCVk8eGebAJfZ+y+ONvw22oyZRjwklo9tO0NocvJKEl3nJoXsn5Daed4WuzI9xU9RrPAcpfUjqQkh6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY5V9bNps+w/RpfJWB+nMGYKPkIaHhzzrIvF+7A5CL6CO+VnOo
	Ks51/tF9QOYP1vB/dQJYXRcWvJWD/dI5wYqRH64YPVICf0xeMPKOrXXuA+J4ixh3wLJHo7a6i+u
	/Pb4Lq7IC1lAB7MeUQoCB2OeodE7oDJ0WPj7/HtMwXeTa6VuArLeioDpfNr4CiTA=
X-Gm-Gg: ASbGncvfv3q/NcrTixSyILjHFlYsGm1JngicovCSxPm7yvOx20NzlHYmVY1muQjpAWs
	jQ1mQHaHgK/w+onXXuXOIy5b8qGkpNn3n6mdmU6ohHyedVNDCNG7K9Kt+TxeQXmqk19n183YyaJ
	MlfLZwfO+2w85XL1KGWQsXnEWizqnTWSuBfNd+sgklaDK2tIse3BldDSls0Lq4YvGpzSQ8Dey1m
	0TD4GwiisaZkvD+3Oh7YswhD0q7YFtlUl/uy/AfbQsqPgfTxRD2pXKK5B33ewnaQ0DHGhbZdmRk
	9Yd6swI0dTQ0rE2g2d//uvwPebljrYrmnCtZOdSr3tqe2Ipc5336OtUwpmju+VLDODCubhFUwcL
	kcKmT/e7L9K8QLBFS3xZwwQ==
X-Received: by 2002:a05:622a:143:b0:4b5:f521:30f7 with SMTP id d75a77b69052e-4b77cfeb0a8mr138161931cf.4.1758020755588;
        Tue, 16 Sep 2025 04:05:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwsWlh/wMA1kgn62I3osn9yA6YaFnlN+94SeqOOqPpYtWKmcu0OzDbrZ+IaTwxiRXlalQ7pQ==
X-Received: by 2002:a05:622a:143:b0:4b5:f521:30f7 with SMTP id d75a77b69052e-4b77cfeb0a8mr138161411cf.4.1758020754944;
        Tue, 16 Sep 2025 04:05:54 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b31287cesm1146190666b.30.2025.09.16.04.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 04:05:54 -0700 (PDT)
Message-ID: <cd6d164e-a6bc-457b-97d3-503b897fbd62@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 13:05:52 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/10] arm64: dts: qcom: lemans-evk: Enable PCIe
 support
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
 <20250916-lemans-evk-bu-v5-5-53d7d206669d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250916-lemans-evk-bu-v5-5-53d7d206669d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOSBTYWx0ZWRfX4Do9wmsyehrk
 CwlvHXgDLJASKkBQ1jtLL8BcZAAkepgqhfTtSrGqKzmz4HYRkepfZWepZck4nB+nRx7Tqm8fVj6
 1s7KFdbPK9VapLUAHHa0H0z9/KYa/F1iajDUKNz+4bajVJIYHTFONP7OHOy3t9Fmsv8b9s71FMd
 YHNdbQ1M2KFOxOBfcutJAeJVs0fAU7xWmPT2/ynpgijQxxf4PeRLsJjZ1C6hrsC0XuF0lZXaYCj
 fAXEw2+xcnamKG1p0eJ8ZluAzi3rp3brdr87QCpf8FAEpJ26UvX+qHBANg1xdQW6nYuqpN5fN1d
 +guD049gf6CzO5rDfIkfsTpyNp3zqmxsqwF2ZPYM7zfGnYTM938aO7v//JGga7zaSIVtUHrRH9K
 0WJuMPSP
X-Authority-Analysis: v=2.4 cv=cdTSrmDM c=1 sm=1 tr=0 ts=68c94494 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=lLTZtybaiap_q6JmIOoA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: UdwrXTfRty9WfIpQ9P8dFINJEM38572f
X-Proofpoint-GUID: UdwrXTfRty9WfIpQ9P8dFINJEM38572f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130019

On 9/16/25 12:46 PM, Wasim Nazir wrote:
> From: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> 
> Enable PCIe0 and PCIe1 along with the respective phy-nodes.
> 
> PCIe0 is routed to an m.2 E key connector on the mainboard for wifi
> attaches while PCIe1 routes to a standard PCIe x4 expansion slot.
> 
> Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
