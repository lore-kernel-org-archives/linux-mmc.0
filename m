Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8884FB9D8
	for <linux-mmc@vger.kernel.org>; Fri, 25 Sep 2026 22:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790374942; cv=none; b=rCexFckzcBjVN5wHK+Whj/oa/PWeEkBl2V34ZFrgvyGsJ//oYFfh45s0xLU+TPHl6xFU5qD1FE7kCx9Q3ti/N3zhjagYJLG8tmENlLmPPWaSh+bnWyA8WtPbCti6tn0FnQXNViIpnXMDpJfchpmeLssLzGy93omsBjTcY2NIM4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790374942; c=relaxed/simple;
	bh=WDe8Nwp+8tXA6JvRXC4djLa/L7jH5WXFM1d8o/bcDuo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jzTnAePOklpg65SPHt+wbvf7CSpo1/I5LwLyKR5nG1azchRnM+myQ1Un0FkHLxU7nlWt+xCRDyCSTnhAAokUUDV+RpEsVMmt1STmckgSwBcxO2Sh8BwspQPqtfOii24KRO2ihV+PkW5mRN9ekXv0MJMpY/uZzKrxuB7djAhRLpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nwUVcUn/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wam161OC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nwUVcUn/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wam161OC"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PInuda3014944
	for <linux-mmc@vger.kernel.org>; Fri, 25 Sep 2026 22:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b1UmO4gb5quvleiJFqJ6eQjdTIgUvfS0JZPGJANlm1s=; b=nwUVcUn/sbesiu89
	0Im27RQQaQxZOJOZMyZhBMAlzBzDobwS2C6op74TgxAPFnj0beZHkqBa7c5CLnsS
	+Onoxmf9CEV3vB/unKZ1YOPE3UGaAQQU/n+S/XnZQKzMLu3prC7rS6/ezNBST70E
	lxl2cAsYAR5I4wGm+pGzk80ICPrSurQ+0Jp/sifqFF0tvKD0k0VwPb2X+2CBrIq7
	5fU+OdvOD5/6+FBxw6szO0tHDhKX6Z+Qe/TOce1QmxOqkzIL9Eo88G8qrh9Nq1Dl
	8/USu0aI7xJje5ILNbZETQU9yXNHd2S6krTrFoFibLz0iIe3VzodIXzYDnvPvoWo
	TouHlg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwufk1ftj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 25 Sep 2026 22:22:19 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1437272611eso1677408c88.1
        for <linux-mmc@vger.kernel.org>; Fri, 25 Sep 2026 15:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790374938; x=1790979738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b1UmO4gb5quvleiJFqJ6eQjdTIgUvfS0JZPGJANlm1s=;
        b=Wam161OC4FjEx8v797jE6nE0PGDipHtia6ibmP9wy5jfoPbYVocjMXnwgsMKIAmP0Q
         wMEhFNFPSSJTZFkqmg1SnRz9exJ7rCK0qO9+AYUu1U0Ovxp8rIYZ8rVtRbp2lzYeNFOj
         xA80xKABD4js6FYQSncs1zxKuzSy+qkIIwn3GGgJo/5gyAwwr96fkijazBag3F4GzQ27
         0K6hsR+TNANWGwZHZ/wcEiML1odAJWS1g8wVyQSo6LKcTecnwiYvy5Aast0QPzltJvKS
         guzcH9YB9qcpSYhrRCAsVZegwg67veTcxQUNENAadWaokT2UHm92Waq37hnEacJj8p8v
         sllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790374938; x=1790979738;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b1UmO4gb5quvleiJFqJ6eQjdTIgUvfS0JZPGJANlm1s=;
        b=1z/vtcWcGv8bvTeCjm+nX5yfG915xfefDgy1GzZ8JMxxvO/1z4DDztyqmpVkMaNBdX
         LK+v87yqHzHejyqo9IkUBEYUNB9GlBuLAi5gB0NWk4jFQGT9nbmOrpttr/OwVVEYHE1H
         Ej+ojagqsDEotlbvyu5Lns1OagxsLqq4HxYpQiPtqsnb/ea2YCCYbn4Yt4JkktTitq7b
         m4WgU/dweiTn/mwvchwYsnCDTMBJiXVv+R1qPCxkWX85wRhTlJYKX3TNI5UqVdIpEaZr
         e2UWBbilo3+Sn9CYvupC8MVNhQ+79EzZv776GhjvUcFUWsI2S3ON+43YHddTLzaemL/h
         BlhQ==
X-Gm-Message-State: AFuF++m3Ff3VHFLzmV+VCpu+XXG6JpwoKWikssvVzCo4Pzhg/rHFjfxw
	TBTB9r6Wv+UAI8BifRFOayK71WQZsjibqCYtTCWPVnHRNiV4jGa1e2Wrm57hD5EpteDGBT9M8Uh
	a5ci1TQJQzt+nUjFUu7L55GFYkUND7JvQIHxBCEVukZ6qyZtCR9GNHgFO7Mjg3tY=
X-Gm-Gg: AYBFou0a42zhxGvynPMmpvVdZmaqUS4ZdWrasrDRKV5dxo6ILsmX/ntJ1gI1efYlCl2
	Au5LqG94+lgyOWC79B5VF9eU5br2rN8alXR6eVeVr2yzLqN/T4cpfZEOvI+E+6I5Mda9BNSUjgi
	0E84qF85rSE3jsEYAcuWofb868vbshoSRliQsKU2n3pnsJxG00TnqraEaIEI1Cs+w5jqvkst8JP
	1VDYJTyUWCJr+d4TNpym7qgQmlLfl/4n3erpBs9WvBYSozFs5M47XHhpMxSaFcthL1wcA7Nlgl5
	RiaKkV2IdRDunSYc3/6xFVhAtyv0cJBiKcsDgr78haBNpM+If0Nqs8RKeiotd/ZE39sN2OtUrNX
	SvEZtrobjGltUt9KuEuNleHDINRAvB329R2b1hN1iSf3tbuJYbTEHZA==
X-Received: by 2002:a05:701b:280c:b0:143:296a:c862 with SMTP id a92af1059eb24-146cffbd728mr1187762c88.26.1790374938459;
        Fri, 25 Sep 2026 15:22:18 -0700 (PDT)
X-Received: by 2002:a05:701b:280c:b0:143:296a:c862 with SMTP id a92af1059eb24-146cffbd728mr1187736c88.26.1790374937815;
        Fri, 25 Sep 2026 15:22:17 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-342c9c245a7sm1273621eec.11.2026.09.25.15.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 15:22:17 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Christoph Hellwig <hch@lst.de>,
        Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com>
References: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v10 00/10] Support for block device NVMEM
 providers
Message-Id: <179037493652.3059844.6860403127536084948.b4-ty@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 15:22:16 -0700
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: 2TM1CkZhAhTNu2-AtVcfGDW_LgsAUq-i
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA4OSBTYWx0ZWRfXy9eJTIm8IND9
 enLqa1bdoYNtwcKtJqQzdUt1LG1yh3bxZx3se0HAn8lwJwxz6e/QT2rDPvQnaGE5jgkKNVrLGU3
 zVLlxjQhLiPPo3qUl8FICCH9OPqsk2g=
X-Proofpoint-ORIG-GUID: 2TM1CkZhAhTNu2-AtVcfGDW_LgsAUq-i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA4OSBTYWx0ZWRfX71yrSC1jPAK7
 mB4KDG0cNun6ir6IzTUCMYl7zforUWILazxIvHlHO0OI+l8HlMgzdNnUDnLyijnr9q0BG830hxZ
 Ha+CLfbX3TlGXSv/W5sd15jUgwpcz47UEIHQZ/v98LVRWGGVzl3NDe4XZxcdgOhBFW2nwqqZNcH
 z70HLko54DrNyVlqnzShI2gqG7xKmkqx6AqeDKROUrDcbAnF8i6raHLsCS2LOv/ZzawEgEj5vkt
 +6kiIPI7p52MpvGl0coU0MiRlJauxONsLcuFD780srt4gqTUMnt+W59kydV7m6zxJtG6naKJxCU
 fMA57H1/1PwVvQ/rl4IE3AJAQD+wjHV2iIFOIxgX+7QFUsnUw9O5NoJWdXf30N1b5iX+7qof2Oq
 HTPcsT3boG00AXvfPz/MLZSXEV8hUvLOwQXM2GEVLs9RZYb3JnAmF5qLTIQwWZ2EE0agJUROCvb
 n2Dkx27Dege+/oCz7mQ==
X-Authority-Analysis: v=2.4 cv=B+wsQ+tM c=1 sm=1 tr=0 ts=6ab6f41b cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=3vxmhWUQDq8JHCpcIj4A:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250089


On Thu, 06 Aug 2026 16:38:33 +0200, Loic Poulain wrote:
> On embedded devices, it is common for factory provisioning to store
> device-specific information, such as Ethernet or WiFi MAC addresses,
> in a dedicated area of an eMMC partition. This avoids the need for
> and additional EEPROM/OTP and leverages the persistence of eMMC.
> 
> One example is the Arduino UNO-Q, where the WiFi MAC address and the
> Bluetooth Device address are stored in the eMMC Boot1 partition.
> 
> [...]

Applied, thanks!

[02/10] dt-bindings: net: wireless: qcom,ath10k: Document NVMEM cells
        commit: 753baa59527f8e606c49eac25692b8b08918a3a9

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>

