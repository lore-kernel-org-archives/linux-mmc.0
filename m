Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723D64C8FE8
	for <linux-mmc@vger.kernel.org>; Wed,  1 Jul 2026 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921681; cv=none; b=CO5ab1RGDKBmoJG/5K85bAsGZGCvn/PBMIh+b+gZ652mNl4zFQgqynoa5IuZc5HTlD830Hpe0kYuN+3NBGybeyt/xd/b2KQvdYmjKqHcOYlHCgs7MXWDV+ywy2kujhIT13iksHM2Je2tRPVPuYg7V7FfuqqFwtjSQDyniFne3rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921681; c=relaxed/simple;
	bh=OKx/GH7ZUq9+Mjfs4xDvFsGX2/Vn8N7/Q0k8/BzXAPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jCJt+JqLe1LHqDW3Ikl0cgHUrUIFZ8VLSutQ9cNvEjs01mcas1AbmpXhbMLLz8UDXLF9sdEM7giHDuDAdXIM5uLoPmhlZGyzkZb4J84geLfaqFsBZtkYWssuTFk6iaJZ8d08VPQNc7J/0KlVmQ4hPFyQV23xs8efMKTq0L9bh30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pq5NS/nq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jszjgWUD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pq5NS/nq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jszjgWUD"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661Fo8vG1551136
	for <linux-mmc@vger.kernel.org>; Wed, 1 Jul 2026 16:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=; b=Pq5NS/nqw8AXlglr
	RFqPdkUwA1KGVsv7K+LRZtwF9K3E1Wcxk47eHkwTdnaldY7gZWQ6ibH3fP9dqRJi
	pbpa0Qh1kylkdNRlU2sHby03bKMc9gW7pcNAAmkJH48C+M/Ba4cjddY6cJ0FheyI
	pukFFt6cPC+ejY5Em3EZrEzYJJdnGgLy86amxW0eQyglo/R93w/eir4Ttv5Ov7+Y
	yhKQsOPbFm8P4KFGopv9y5LXIN9IvvMNq/SSvDowpVFLYJnc8VbvOA01OWsX/Xsg
	ntzgGP680b8EXEOjhjOtVLulFLNmnvCv5G829Z5Isn7bEB+naQI+CzXe5Y1Hhl7D
	7scrIQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4kgw4wrv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2026 16:01:08 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9691eef15f5so159458241.3
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2026 09:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921668; x=1783526468; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=jszjgWUD6lVHhnLYWwsfM9npbas1miRY6MtzfSHlGSavJ64cknuEto6XqlDPsihi/x
         qD2LttnzN6b0ix+WCzIZj40W7ILVYCBWsXaqYLJDpkVJw62zQQdpRQmqtf3jhg1M9a/s
         YXh9uNmMRxKbDxJ8/ByEO6lvhgN3lRyIPL/7RebMRZoCDrhsJXUOfRkT7I2HiCmA7bWw
         hIEDuC2gShH+QZU36UkpT3N5tZvQ1WBG1N7LFJpmFUjeoU8MXVfM/rsi5JWEvIhwYq3A
         GC6hEs/XtsmxEKojWfaIlSiqApw6k+8HVU7rVosBdQ+z3va+lVVDaC1n1WuTU34lwkdn
         1GrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921668; x=1783526468;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=fFM1f26W0TFpF/sJIqD3GwkjBeesfRt5kvk8u9n3V6PmWgGnEAfs09euIZobsKilAB
         PytB79fTGxtgeJIsrqTvThHmBfasMLeoX5Eyu8sXOhHu6sWKoTvmqooeQsUTvsWX+5yg
         jBFFuOlDK1yxMAxM9a6sinqTlnAhlQlkBo5CTmhWXWf7hir7ZMetZpxg1QKcYvLi3RMM
         uJyJkyn4f6eY9ACdv8Y1W7Hkzo8lbDxeF+8IRpiyISULAEwiQnYziELw+kF9IHNNIrVb
         srdcSr2a6Dkd2+A+tSNo20ls0GlM/x6Q5vOWwej+QsH7VKVTQz7AqGUOurqZ6V9B4OZh
         vwIQ==
X-Gm-Message-State: AOJu0Yw+3frfb5C+MI8QC96p61S/PYJ9dgFyzLMlShgMmz47nyOmNn81
	uqxjkdl2eqV6PHUaxzUyx2Lkuoe0QMKP3CZcLyr1W0gLLkjCt6qYJUlOsegc120WtHaXkoYdT73
	laOEGKQQuCzbsG8wReP65n2s241ASOeWCOhH0WXyjTqlQ7PSsJUt4BFADr3qBL2E=
X-Gm-Gg: AfdE7clh14cb91y1Ua2AZIksCldrjZn/A1udt3ZwpYs+dcfAov82AsJa3gFpSsL4UNB
	+xVWp/qhcU40J8pEpbfk9rsoNFrDCmFr3aY2vMltLYL3zGavDFAYvVOwzf6DmJsltJTvT/0JzlQ
	bbnZXinVIFHq2BNVDTjCa7NQufEGD30Mm+WeuND/4OEdxyUSCuasM7MIlMKwslNBXH9Veq8X/Tq
	h4mcyelvZyX79A3yVPJilpeW4doPTiwqTVR/ajdMgs0SFjEQPM688xM3MOOCwQFSBxlo/7NbFpQ
	SYnsEDtnoAFqFO7iWqKLhtuzLoHy5Rw70JI1bmBOhxwlCoYZhaNiWaangJ31z03rZAe1iQwJ/JL
	kj4EfraI2WEp2jbwvOSJ+ib5rWRYm3nL45OPUcLQcL0xVP7hoz1DNdEJzbIG9yRHkLgjv4zTaou
	yKSSezagtJPVxDSzAybimv+3OUmPFizhwvvLmxi3tCfGXnGzl5UF8AU83erXA+ers=
X-Received: by 2002:a05:6102:38cf:b0:739:d787:be9 with SMTP id ada2fe7eead31-73daa349057mr1034958137.17.1782921666854;
        Wed, 01 Jul 2026 09:01:06 -0700 (PDT)
X-Received: by 2002:a05:6102:38cf:b0:739:d787:be9 with SMTP id ada2fe7eead31-73daa349057mr1034801137.17.1782921665861;
        Wed, 01 Jul 2026 09:01:05 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:01:05 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:32 +0200
Subject: [PATCH v7 8/9] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-8-3fe8205ef0a8@oss.qualcomm.com>
References: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
In-Reply-To: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
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
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=Co2PtH4D c=1 sm=1 tr=0 ts=6a4539c4 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=99fXo_IpyjsNTNVBUdkA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: at0cfUAzBKl5UkwSVrS_aotXTnqvpFfW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfXyaUKaaXgJr/+
 jtT9VEFwSD4n74X7DG1NfMmOM7eVK7T8PWzGVlVNU7HcZQqnXhUDUgLQJIxKtCX8ZeZm/xurqWF
 1v14sDEI7pBN7/dmOP0XstgV1cl5emc=
X-Proofpoint-GUID: at0cfUAzBKl5UkwSVrS_aotXTnqvpFfW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX9tiQVAA5G5K6
 KaLQQHY2aFsyRyZNeLxJlSAs44czMCdAa5HBRbG9G1K6/NBr3rOGo8+BqNj93rz9m5kYmvFCAQQ
 KPY632YnT+fH4yDJe79LLMRftx6MnVk4MgvpXHliq5l5t/mI+Km6zy8PKaBxisI/IFIXI3AD4Ve
 iZzY2V1vXSnFCe6rPjOEJ97mSu9CXrSfxuDxa3SAJLjCr/KN6JGwj4qNTHptWfAPdHDPlZDnvvS
 e9NFWQjGiL3hPa+Kgx/d9q5XlVy5egewH/u3yKgqQKFkIaUiqevMC3nLMococMjV5CwTC5oyzCT
 AigtJncdIvULNIMzr4z5Fq7iXnFkjUylLX2x/H3hRfmwrWUo1ziSNSelTENJEdz+RAYQCRg4eyE
 TNzvHKT5e61es4OExFMzUOHlHqPEHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2607010169

When the controller BD address is invalid (zero or default),
set the NVMEM quirks to allow retrieving the address from a
'local-bd-address' NVMEM cell. The BD address is often stored
alongside the WiFi MAC address in big-endian format, so also
set the big-endian quirk.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index dda76365726f0bfe0e80e05fe04859fa4f0592e1..df33eacfd29fa680f393f90215150743e6001d5b 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -721,8 +721,11 @@ static int qca_check_bdaddr(struct hci_dev *hdev, const struct qca_fw_config *co
 	}
 
 	bda = (struct hci_rp_read_bd_addr *)skb->data;
-	if (!bacmp(&bda->bdaddr, &config->bdaddr))
+	if (!bacmp(&bda->bdaddr, &config->bdaddr)) {
 		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
+		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM);
+		hci_set_quirk(hdev, HCI_QUIRK_BDADDR_NVMEM_BE);
+	}
 
 	kfree_skb(skb);
 

-- 
2.34.1

