Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612853845CC
	for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 08:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773391335; cv=none; b=PRcqBr9VCTcifZN6e9IRW+C+VpM+C1RxSCZ9Ah2RI2QgoiIUeUNuImvTg3yi/35aTYxz5Sl3Mvphv3pcEtn+JaEytxbwnF6hNB1hfhov7mnG5rZmqYKaU6yHm357YXZhIrWo2mnNFsiTTizvQEb7Br7F6NEXYp9HdxMUa09oMxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773391335; c=relaxed/simple;
	bh=Ve6PiNcc143QryIJ7dyWVRwxS8jTgcoxh6k942QCyYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=du+DE/rH8Jg6Bz4pA2ZqVUipNa4oHXth48C1gV4zgvj7In3KdEl5fX1Mjyu+Ud4vqgoQuUPpIQtxi8TZPUl2snivmN7kfBNQQsXR/URroJXAiRZW2GOKvEyvPIt5j1sPr+igfRh6P6X3Akghk6heqhEeAkJw4Wnq4aGUO38673Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IEHPwd3M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gq3iY43v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IEHPwd3M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gq3iY43v"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5tZMt3229787
	for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 08:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ysaCnoNXBJd5CGrL7Xb3oAj5KBlRFnMyUSTWqYDXj70=; b=IEHPwd3MKzoKEP51
	LIKfGxQqvR/eLpVKJfkiATsODhEvatKFmry8eSM0wMMWVLVMy3axoLqak9C5UYNP
	1cWkE3Jtf3zXOFL1mrC+ctTsnaJ3+wamp1vjoS7/cVglFftCNdSsmYQfWazYcUiM
	R02aWkRr/GYmP3/n4JMfzK66pa/AXH0JJvNTcsUfH7HmDUMVf47ERN9v8cy5Wp6O
	r/D5plU0nHHJ6TwgslupTGSlvejAWeQQA6JA34mG/odJeBnHUiAeuuzmDI+onYhL
	AF6uZ8ZSIcqUqirWjDzqepwXy40GWGU0fR2VhLriYgHIL+R8nJvGND1cx/RJYUmJ
	FlgiNg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cv8n7hbu6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 08:42:12 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-829942cf9deso1557953b3a.0
        for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 01:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773391332; x=1773996132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ysaCnoNXBJd5CGrL7Xb3oAj5KBlRFnMyUSTWqYDXj70=;
        b=Gq3iY43vtRSgg2Qf7C3a3VIKgopoD8OBtDsp5rfy4QyQbk3XzwyquYyClacPJv5FvP
         WI8KgB3+NIgocAB9vqkpLU4JtYQYlRVd+u3hqolQYs7IPWXcXWh6pPbzNtiTjaQgjq1E
         Lm3udcY6CVsHgn0IJqCi9p4v3jhRWBCdAn/QAqcdUFEfuB8iOGrzMFIxIGjQSYQBJLKJ
         wXvU4htkUe9oJ1VgQMHO+1HHb5Vx2MzY0TmVCl743uvcbFJehiY+rleA990w8AsoLAW7
         0/ckHwpVPZx5pZzLW+3ghejvn+EsjONWPdHNrzjpax8ViHgbBRntc5M59WGern5/Qjam
         bZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773391332; x=1773996132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ysaCnoNXBJd5CGrL7Xb3oAj5KBlRFnMyUSTWqYDXj70=;
        b=qdPr42bfN0T/bSGH6WTQnREGsQPoFp1QjuD3Iao2NWvl/1nn1N1KHA/cfS0DffNESY
         hqaD3oG11IYAmjXSd9gwaCPqpfb3zlFUbMrV27ie1kV+ZQNEt+UINI92HZC9Kbt9NhJW
         0iV1mYk+P2IbIQabS7DRdkDAacKGO+2wWBpekh1AbAnxxi+DDg723kwMSIeo9VVeiCrF
         hm7mWuBQ4NUEKU+i505kMGBhQJdhzEcVfDkb0yMr+FgmwW9a3SauRCaHuAoNsgYbLZre
         rd7Qmz93Ox2kjTN2Xn91s5WBmVSI/o4whIC8fJOIHSGh1Gv4+DHKt4tajerkr8szEMu5
         h1BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUikuCuu0I6Wz4pYfahHEVqFpIZNf3xm2UUvXnSZdS5gLS5eErb1jL/jXN7QJRa/sAEkG89dOOqwqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAPGGf+UKVEn/yN7nbxpfelBUMwBHTNDyJDx1Szr640dPkxCHg
	H/Jzaad1ajLDNMrHCs4s61B3h/AxszZjVXrlct4wkoPLpPLvUZ330NKfCklLldJ7uozJWqy5/Rv
	owqdH8lw4/2vJJIFmeok1ys8+q8LjowhgvjaEV7GmBFd463pHwbfeTEMqT0B0S+E=
X-Gm-Gg: ATEYQzwp6W1ax6pmqw5zxQ2KwZXjVxufuU0wnnDY+i8ulrWREk2yZxbGSuMZRCu3kHt
	7632fgooWMKXEQTxBMX9KBwvXRB2ChE+Rg8bWS5+g7+ohAV/cCuDsmCQur9uSrjd7lcIi41UPrc
	LF5LKvuo1JaS7rDEOJ+I9uLhbYPk+zHZrYHUN+muP1XPXG/lX4Qu9JTD5JM9e1ouwinBJH3n4NI
	DQ68iYEVI8uBUipPCfiBrGz92i/nOe1NslZako09Dx5o9qEwC0U3xVBr+CP+qwQcR6vWk1lCDaA
	TQkuhx2dkYggKy46d0jaGYVviQ9dsZYGR+zMBJ1fbcalZZtte5slHF7gJbLciwJ59J0SQ0Qerww
	UwSdZhBwUr7ma078bnRA2HHTZLpi9jc5N44aM3Zfa75TiTiK7Vt4UomDZO/8XMP0Z9fk=
X-Received: by 2002:a05:6a00:409b:b0:827:2eff:a29e with SMTP id d2e1a72fcca58-82a1988e77emr2262736b3a.34.1773391331866;
        Fri, 13 Mar 2026 01:42:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:409b:b0:827:2eff:a29e with SMTP id d2e1a72fcca58-82a1988e77emr2262700b3a.34.1773391331400;
        Fri, 13 Mar 2026 01:42:11 -0700 (PDT)
Received: from [10.152.203.161] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a072414f8sm5428282b3a.4.2026.03.13.01.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 01:42:10 -0700 (PDT)
Message-ID: <d966a695-160c-4092-ad97-3761b1bf6b7c@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 14:12:03 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] clk: qcom: add Global Clock controller (GCC) driver
 for IPQ5210 SoC
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
 <20260311-ipq5210_boot_to_shell-v1-2-fe857d68d698@oss.qualcomm.com>
 <yzw4ruhxaznndpyzlrqnxlbrveenlpl4yp2ebbshyh2yo7te2n@64gldqqmk3nb>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <yzw4ruhxaznndpyzlrqnxlbrveenlpl4yp2ebbshyh2yo7te2n@64gldqqmk3nb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zUfoPaOZk2M5aZT4gaVY17vY9fbp9DeD
X-Proofpoint-GUID: zUfoPaOZk2M5aZT4gaVY17vY9fbp9DeD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA2NiBTYWx0ZWRfX5aAiKDiD6wga
 eZJf3QoeGLtyitBqbMwoJtVdFIMX8fdk1s+6HRt2TIeGlC13SZF1zhN8LHpvYOj0ZxdgCFAN46p
 tHAnjaC6FvRbOTUDouqMsJ3bdEvDypjm9ixHmjcDoVGPRzxsba/BrTO6pp4VKPW6dYehHXPqAQE
 RYrFUrq7XHUbex27R/Q//XkORy9TYWFt93vf7QfE89ZDTmi27V0rs21USX4CGh3VucgoZ5gx9Bn
 fU6GPvm/UzOEtID8h8T7m232YBIPqIYiwt7UB7BhEyauz5w2+LzpaHxE1U9pAblMsXx0+NLIp5L
 nvRDdqazRwXFdT1zO6Qw93tfZB3yhnRxVZk5JhAs7AuoQT+NVPu+xB+flpMZ/POQ2fxaanvrkbk
 GK7PF5x29IyBQjnh1AMOtuioJ3o+401wAmVRQnlFdPOvHhWzaktF6yBNRTrbvMrD0shzWbdFcdE
 HLINGW1ZWm3RHYUXNpw==
X-Authority-Analysis: v=2.4 cv=CpCys34D c=1 sm=1 tr=0 ts=69b3cde4 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=xo8W07fJ9kZJw7rHU1gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130066


On 3/11/2026 8:20 PM, Dmitry Baryshkov wrote:
> On Wed, Mar 11, 2026 at 03:15:44PM +0530, Kathiravan Thirumoorthy wrote:
>> Add support for the global clock controller found on IPQ5210 SoC.
>>
>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>> ---
>>   drivers/clk/qcom/Kconfig       |    8 +
>>   drivers/clk/qcom/Makefile      |    1 +
>>   drivers/clk/qcom/gcc-ipq5210.c | 2641 ++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 2650 insertions(+)
>>
>> +
>> +static struct clk_alpha_pll gpll4_main = {
>> +	.offset = 0x22000,
>> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
>> +	.clkr = {
>> +		.enable_reg = 0xb000,
>> +		.enable_mask = BIT(2),
>> +		.hw.init = &(const struct clk_init_data) {
>> +			.name = "gpll4_main",
>> +			.parent_data = &gcc_parent_data_xo,
>> +			.num_parents = 1,
>> +			.ops = &clk_alpha_pll_ops,
>> +			.flags = CLK_IS_CRITICAL,
> comment, why?

Sure, let me add something like below in the next spin. Will that be okay?

/*
  * There are no consumers for this source in kernel yet,
  * (will be added soon), so the clock framework
  * disables this source. But some of the clocks
  * initialized by boot loaders uses this source. So we
  * need to keep this clock ON. Add the
  * CLK_IS_CRITICAL flag so the clock will not be
  * disabled. Once the consumer in kernel is added, we
  * can get rid of this flag.
  */


Thanks,

Kathiravan T.

>
>> +		},
>> +	},
>> +};
