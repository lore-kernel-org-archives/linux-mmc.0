Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EFA38F94C
	for <linux-mmc@vger.kernel.org>; Wed, 29 Apr 2026 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455136; cv=none; b=M6FM9KktJhI9FFYFv7tX88KMMES3gJczZE9Nh2dOcAGq8/5A8tsNHuLqveIdMr8W7MvEP/tsaRbxkwZXh1EJ6ZKDbAVcBWNwm5wqeBfTJ8evCZFq83hmmKb4ouv28QyJcrHsv7aIDzr3JJGp0zNMhjt8uVpqxXSxYc875OkEgSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455136; c=relaxed/simple;
	bh=5q81zyT9bNFdWJs9YZZFd/1yiVmz3SfrynLds2/FimI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cyNiXpStlSpOMpDA1JDui3TiOh30Oos9tNQE83cxTmUdnu5AAj41L1KRwMFE7A2XZv7jWyMmIIPi2GACTUti7jQxN7SGMHYv3LRZZv6EHmuh+Zi2pw343BsWIBGSVy6BRPbrqSb1kZ7K+2Y1HSxg4BwvAnuYdVehBkpCc8g53Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QrFnsG+j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VK0pNfsU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QrFnsG+j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VK0pNfsU"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8prhZ1728581
	for <linux-mmc@vger.kernel.org>; Wed, 29 Apr 2026 09:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dpp2pOYs+zgwLnYd8Zpm3wMJtqBgJtWLRZMos+6qw+M=; b=QrFnsG+jG6rGzo9W
	lO0/0zNIpKPh5RzaU880EfRtJvcH9VKGHTso9BTsUoTdKhUk1V+siOywCL8LjgFi
	tsaJ6EiG+/j7Kabmwf9GqvEIuGlyf5V7pT7hOuM4P70FxKSiOaD/tOSHyLtQrefW
	NahBP2Wbc+FIakFEpEPpbyRRGGIXWu6Xi6wR4VZSz7O9gK0wRWBZh+f+km76aphq
	fOOYVZTZ4aExY24etzO0XVpDZqW4GUA9FcGEePBWxgcP3ccKN4YTkAEUhMCMSj6J
	LQanDekJryOGgpc0YHp2feY03k7QMgHdrEByr//wIDqm2f8yuyI9eHD1g6WhHYpm
	GeEgXQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4due5krbt6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 29 Apr 2026 09:32:14 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-56f71af9dddso903415e0c.1
        for <linux-mmc@vger.kernel.org>; Wed, 29 Apr 2026 02:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777455134; x=1778059934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dpp2pOYs+zgwLnYd8Zpm3wMJtqBgJtWLRZMos+6qw+M=;
        b=VK0pNfsUNUqEa4lJ9L2erBXv4206Il+blXl2uWvUQw8lnUzT+eGJKmdhX3BbxU5QBW
         5RhQMXFYTj6dJ+95kXBjOx+x44MGIeYvwXQuZdPHn8IML7J2FjREp8Z875QWiv9rajOv
         apGnMyu4i45kqcRi9S94WV9l1V0z9hVVQhhecbzdalNpUjaIqY5ZAtvDr7/IOZjHcbtk
         Nrfrpx473jxWjV1rPAM6+t4EwNELb+0DOa2/Im5Iwh3HHxjz1/Tt23r+5FNuSL18KS+b
         UR0QZ3rZiXRs6Pnn6ZyhD+e2e372mVMTkoSlQqkmTzwaK2C39X/Vf8gFdH+fLilePojj
         aUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777455134; x=1778059934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dpp2pOYs+zgwLnYd8Zpm3wMJtqBgJtWLRZMos+6qw+M=;
        b=ZKSQl6J2+QAs6khLyENvIPTGo5JEmMCv+vgwgafg0mO+LnWO4pG74JViTDozn5O9v6
         WhpUsUBs+ol0w9/vSJAJbNyfP+bS8KWvJc1KGDfttMJrfw8cUVoFaSnA7YJ6JB6McqEQ
         gZADkmqOLEXXSfAZuC8DZAqqnzqYeTDg5fvTcTRdaQ7AjX0GOKTOnUe4kVQQvr0Q4O3F
         D7R0d978Dl+G56DCk7/dihLtN7MjUs0npWNFCYQ/Ulwl8ilaOG3yqcIQ8iY8ENX2mZwN
         SEFCTvmxo6vUJzG/KGWw+Y6FMeAes+tFhG/Mh7RisRGgRonHVD9sjkd12PKlKNfhyiKX
         VtzA==
X-Gm-Message-State: AOJu0Yz45hRAx2+L+d0+VV7zm/Kk7w+iCTkznft23mW6ZRCnnpMsAfQB
	fLNRyB/OIlXfqtWU2Hi03BjsRbZmUNj+0NGyH9/jF3SAYel2Zv1vWvcgIWtW8ema9xD5NXKzj8d
	WSGke/epr1lGrSQe0R5nj7aVn11IDcT3M+EZMCUa3YsKt1kw21sxk8lVeRhw7drQ=
X-Gm-Gg: AeBDiesbPmrPVmXg4m5HAQ1nAon2S2BNtdDs7/1PjS8ry6Ntu/2of00IG3WBmB92vfy
	AqIQo2HGKA38BO7NH3NPqriFxKnhPFno+nffw3GwAk9CVZeJBIGEHQaVGhFLRTIc1GZQhdAHdZW
	llWb/w0RxkfnjOutyY4YPq1QDtZirzzfjm8WDac8WQ4Or7MjXAvFTG7P8Z6tZ9glCl+UaRwCn42
	rieINiSRvTBmJ7EwOgaUlQh/ztJ20wl0AGLZaALVuQLsWLF1W5OpHy4a8N+Mw7c3rkepVcljVqS
	h9OvgPjEsWE3zrUMaIrh2Af2CQoOcvViuGm1ltNYIB6nf/dRBYzN1pz6CI+zxaw/lkq5SjWgZI0
	thtxH46LgnMYCR6EAweLTuw0FXqOEhL3kqUZfQgqdk2ZfWJUMlmrKhlSD7rq0ol6EM9r+eybOnU
	uQU8/Ic43RNMFrcQ==
X-Received: by 2002:ac5:ccd9:0:b0:56a:9e65:3e30 with SMTP id 71dfb90a1353d-573a2df9fd3mr1309836e0c.3.1777455133953;
        Wed, 29 Apr 2026 02:32:13 -0700 (PDT)
X-Received: by 2002:ac5:ccd9:0:b0:56a:9e65:3e30 with SMTP id 71dfb90a1353d-573a2df9fd3mr1309824e0c.3.1777455133542;
        Wed, 29 Apr 2026 02:32:13 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb980a6f2e6sm67596966b.8.2026.04.29.02.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 02:32:12 -0700 (PDT)
Message-ID: <2390c346-0112-45b2-8d10-d29ca3cc8f88@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 11:32:07 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] arm64: dts: qcom: arduino-imola: Get Bluetooth BD
 address from NVMEM
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
 <20260428-block-as-nvmem-v1-9-6ad23e75190a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260428-block-as-nvmem-v1-9-6ad23e75190a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA5NSBTYWx0ZWRfX2DZcdzSKBkBu
 wUNHq0S1mtdzWAwWV1j9GdoCrTSmke1n+3i4kEgIa54OSglPEEmFvltAsKVZVwTSjQsyIPkwqO4
 9vL7KEr9yyvN2ZnbBhjNa49FlLOClC/h9hLrx1keVFgtVHEdzWU8r47CRTvQ0dW9IgorX+1Tfto
 DLfDdeqXjcyYpSxIv6CoKgmGO9yZ3u9EHbHnd9QPQz1KtGJB6ISlLFJE4Ul5d8iLwr5nL7NeNiv
 0QQtJN7QKfZ+33tS/KA+aOR+XlQUUcP+lW+uoBbWkxm1yoXT83++Fu1+hBI+SxLCEiXmqGHgRWz
 Dltde1w37IrEz22e9LcWEE4V832Q8LovtB5L6o6907jyyo31Y8wW1nq+H1iwMyJLduPCdFTAM1w
 HS+lqzmxiiaruaNpAPvMo1M2SLDNJFigN7NfIR7iUsm4p/CUKR9u2GcxtW0gz031BZHrTAQstm6
 wKE5V+v4Evx4ZFqzeBA==
X-Proofpoint-GUID: -to9LW16Y0mO2Rei7EsLDzLkbZa4sq8r
X-Proofpoint-ORIG-GUID: -to9LW16Y0mO2Rei7EsLDzLkbZa4sq8r
X-Authority-Analysis: v=2.4 cv=CL4amxrD c=1 sm=1 tr=0 ts=69f1d01e cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=vtxEUVkT7waMBiOsAPUA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1011 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290095

On 4/28/26 4:23 PM, Loic Poulain wrote:
> On Arduino Uno-Q, the Bluetooth Device address is stored in the eMMC
> boot1 partition. Point to the appropriate NVMEM cell to retrieve it.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
