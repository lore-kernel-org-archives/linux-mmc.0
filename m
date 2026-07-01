Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79E648A2D6
	for <linux-mmc@vger.kernel.org>; Wed,  1 Jul 2026 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782912708; cv=none; b=FyQczLugMKDHxwsWkzNELm9JQzBzQDKOpeY/RvPnNbBGqS5d5JRI4KcurLsw0DdVz7rI9wJBcKWVgZkptbF1U2Y0FpRzIUYd/j+EQG+Yn7AlXQPRviunjhBKOKj75lnVCNt3AoSN/nDziJNl3z89iJnzEpcqoulVl76jpeLU94s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782912708; c=relaxed/simple;
	bh=bP5KfU/0EvFpzUaA0IWBbLVnj4P0xljC3bpOzpSGDv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZNJzuHTJUcQSWFSCPAT2cebyUqnfV8TR9T1tkh2Mlki75d9+WhZ87fT/XRhP5IcleXG18lZTKeKpWgoehp45w/5bTJf7Bevu9O8KSDHHrdYWqQkZeSJUucFZdodqoCHnCUyokNefyUGPSy23XO2LrSWUA7x7g5NGd51/7pp9Yio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oKzsFzNT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aheu+lNy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oKzsFzNT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aheu+lNy"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A8rXa763048
	for <linux-mmc@vger.kernel.org>; Wed, 1 Jul 2026 13:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wNaW08++vnLTFi1SsLSGWlzJVpLZiWA1rhZCbZvT7rs=; b=oKzsFzNTJKFZTGEw
	+dbmuPRNFK0epez/YQ8C8fHxvcJc6prV05IP5VHVd2DNOne0+d6uSx/k3giB0Gh3
	ODRqpBkzXUIZF4Ch7FGQJ3Fe2nOS7GbuL5jxeTTrLK13fGV8GYVNApjA3DptNE8P
	oE2Gh5n43faByuq0PwBYL0S9ZPbWnNmDDkVzBObVBhzvOe/YW57D7s7HMlWOygKn
	C/rseP3uIiEkDyrIP8IUnk3qhPVIvLUxIzL4ONK64zmUmxUIH3Swh5GmHdXiFx9h
	0Noo2gdkFUv/LOSsRsN8ABueob4pt0nygp6+JTox9LsbRO9L7jkSnLPJvFvDljSb
	QzAF0Q==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jktcd1y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2026 13:31:45 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e9e8723ae1so154017a34.2
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2026 06:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782912705; x=1783517505; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wNaW08++vnLTFi1SsLSGWlzJVpLZiWA1rhZCbZvT7rs=;
        b=aheu+lNyvawOexkm+FpJSAtn29zC9F/hvcPRkp8Of4MKlFWn91UG/44Wa2tfp17V19
         8OofGlQWCE1DYrzazzjAxSfzohs1qZe4hDq0e30ROeyERcyEZRQJei1Gp7kp3anaDUBS
         VQZrJ7ke5HVFhnqctVMDSeTdurf9ncIaNAjqzFe6YTdB88AgbFFyW2v0O0+MODdfxPP6
         TW+kvkTmtsGV8uRY+pWJlr7Yo1RZzCJiFedtQ+i4vDQvjs7Y3FbzANK5Z3CxhEErIOk8
         Il5y7WN4b+cNsNqD37VNtCDwSQKIob7UXWgxmn207nnZWYJDPy0tRp1HDM7eCqZCuEfB
         2xNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782912705; x=1783517505;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wNaW08++vnLTFi1SsLSGWlzJVpLZiWA1rhZCbZvT7rs=;
        b=Lu9k/NMSgZlLLEzzVJzikUPZD6ZKCoTHV/zVzhpOtczVP8XHF8vBu7MBXGYcIU7qje
         FivnWQ0/Qr/tTX2EnDR8wMlKpaVbTF+eO7GbiX4FUY6RZrO7rTYqiG3s3pL+e5USCUoQ
         8C6NH5krooAnLmky69NUpPNlsAQdN/WP5nnJT3UZdJZ9l9wmu9qHQydmqJqMNnV9Qjv3
         VbbAqjpz7M6NsIFxhjHcSQTdZYamBY0J+TiUMNQ1VTUP/Fx22ER8cxUzqSSvMVAUXnST
         2WLliC+UXeKfiE0EuRf+XXJj+RhaUrcNIRNLoUuVojS6msOIzM9q6M840vuFgCR8gABf
         5CRA==
X-Forwarded-Encrypted: i=1; AFNElJ+04U3w4KbWJhTgT85VCHSOd9Gej+vv/m2jJ+rSqLrUYwcHMZzVdnyOoPQaZ2CQ5ZhGZfg9RTUQ184=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrXetkQQhxPjfmCyvJOaxUjDFs/4uUJEZpWC54FnOkCRBrmQz9
	w0wcULlXD1eioImmUvaS0ZtszfnJZH9bdXgc+qiD3ndr9GguBzazJld4QQocfeYy6TT7MYYZG4l
	HxZBcdghggzKHqT+3WS40iFfnmM5nRrttZPMlDjXcDleuWKmIaK8T4tmOQMztFwg=
X-Gm-Gg: AfdE7cneDBrOQYaqqDU/TbZ4y36lHIyZ+nmrIOsB8kCrCXSyNiXWY4oqwut921Lt+ir
	cK5SGLjmUT5pK+sY3EBfCb0w/ODr5oFF3ywMhT3v0OrizCSDUdSOmvnkPWINTolFt8ZVEzmpw8y
	whcC+keTgzLlVnIjEKxnwQe8mIslu71Ye3zvqnSpBOIZjYu9tXJGm1EHR7cRgT25/YjFrB0Umlu
	4aufRWHAfAKewob7J/3HrVjk/DkIeDhLEtcWVTDblQEl9BsmCYj9/3wIuy/GUo/+iydqFKT8MRs
	CnJN9y2AfmR78t62oecgawExiezUKJ2NOyjrr93H8CgmEmfXMBMyuk+2XkeDJX3ZFj2dp4YSGKt
	FT5LLuS3RQ9xEnfuoOigOF9vOmx2JZ558wc8=
X-Received: by 2002:a05:6820:330d:b0:6a1:7ed6:9de with SMTP id 006d021491bc7-6a309b4fe66mr369491eaf.3.1782912705166;
        Wed, 01 Jul 2026 06:31:45 -0700 (PDT)
X-Received: by 2002:a05:6820:330d:b0:6a1:7ed6:9de with SMTP id 006d021491bc7-6a309b4fe66mr369458eaf.3.1782912704654;
        Wed, 01 Jul 2026 06:31:44 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19df8sm277296666b.10.2026.07.01.06.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 06:31:43 -0700 (PDT)
Message-ID: <1ccca566-f804-4c4b-8d71-1f258380db70@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 15:31:38 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] firmware: qcom: scm: Add support for setting
 Bluetooth power modes
To: George Moussalem <george.moussalem@outlook.com>,
        Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Johannes Berg
 <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Saravana Kannan
 <saravanak@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
 <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20260629-ipq5018-bluetooth-v2-0-02770f03b6bb@outlook.com>
 <20260629-ipq5018-bluetooth-v2-3-02770f03b6bb@outlook.com>
 <175f7835-df18-4bc6-8267-ceef35696af8@oss.qualcomm.com>
 <SN7PR19MB6736B784D6A16CBA531DBD5C9DF62@SN7PR19MB6736.namprd19.prod.outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <SN7PR19MB6736B784D6A16CBA531DBD5C9DF62@SN7PR19MB6736.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE0MSBTYWx0ZWRfX0etpLDiLpz50
 MCLBHMI+RaEobcEvk97vBU/4jhu0p/nHMCw0tEIgbs3v+FZpklP2jXdpWy3boWKHao4pX/WsNFJ
 H9U3k1KEjwZAFNRpiiiIO6iCmr4RSMw=
X-Proofpoint-GUID: PH0Wc3UfAz82aTpOdDsixBeKmONGZx2E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE0MSBTYWx0ZWRfX7sEULHptQjki
 BM8VPFBqz6uRBPwnNf7HQO6u8ZI5S478uMkB/nwOfMtJBP5NhTwmUe0qG2MKBHN/M9Yrk6sUx9F
 u00FiqC9eAenj2uMqqMw6/jmdlOtGZQ8hQEppNJ5KkDXxBpLuT+8aj6tkspXEUrAtAOhordDF3+
 GU6glc0nZzqzUot+fPCoVw3fxTqw+7f70MmPyEwkvn5DRC7y2iMBLmxjTPqKcr4LWPyT4n955nl
 h3nuirWgODpu6pSvxuEu0wsB28UUaSSpqF1tmW7pnQryUiggJBNtJQSnPBhta/5H8JszJ/LKKmd
 wCNjTisX275xApSDmXSUo5EVwofTaANYBMbOZF4UM40T7u+heDE04Nff6L5IyptFggbfDb6zQzo
 G+krJLlCuJQqrcUkOK5ZzftooDflrh9SSpUKBty7gerwqbfw7aUCfIKJ5VSXUEudKZKZk33M6Ng
 AATWEIfykvLHd7NGCZA==
X-Authority-Analysis: v=2.4 cv=R+wz39RX c=1 sm=1 tr=0 ts=6a4516c1 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=UqCG9HQmAAAA:8 a=zNuiAkW08ekSdzkv0MIA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-ORIG-GUID: PH0Wc3UfAz82aTpOdDsixBeKmONGZx2E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010141

On 7/1/26 3:15 PM, George Moussalem wrote:
> On 7/1/26 14:40, Konrad Dybcio wrote:
>> On 6/29/26 3:01 PM, George Moussalem via B4 Relay wrote:
>>> From: George Moussalem <george.moussalem@outlook.com>
>>>
>>> The Bluetooth subsystem (BTSS) on the IPQ5018 SoC supports setting power
>>> modes which are required to be configured through a Secure Channel
>>> Manager (SCM) call to TrustZone. However, not all Trusted Execution
>>> Environment (QSEE) images support this call, so first check if the call
>>> is available.
>>>
>>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>>> ---
>>
>> I'm amazed changing this setting is a secure operation
>>
>> [...]
>>
>>> +/**
>>> + * qcom_scm_pas_set_bluetooth_power_mode() - Configure power optimization mode
>>> + *					     for the Bluetooth subsystem (BTSS)
>>> + * @pas_id:	peripheral authentication service id
>>> + * @val:	0x0 for normal operation, 0x4 for ECO mode
>>
>> If there's just two values, maybe we should make this take a `bool eco_mode`?
> 
> that was the direction I was going in initially but then thought that
> there may be more (undocumented) power modes I'm unaware off so changed
> it to u32. I'll change it back to bool.

We can always change back if needed

Konrad
