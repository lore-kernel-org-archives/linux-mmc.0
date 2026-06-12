Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8EC3EE1C4
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270475; cv=none; b=tyKFFY/wlWre/o5AI68XZfcWyNxMOlB1E/O/e5SzAgcO/MmrpSKAukNRtXiF4PSLjFaAjUfFg5Y3KkF3IMMMVp0HDQyA+zMz3Ag+UtTtnOYehzIkNu2EK6lRuOWuRXKmhwQ36N7hll/XOBidiQWhAecJocNC+8Qgen8oGY/MuyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270475; c=relaxed/simple;
	bh=xh4ucig5hPRkaGw1GggCAwEU1pqdfnGTPbj3vUFpt5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IAuMx2boCJPx+CcaDa5txwfhisrs7jDTSdxkI7WpdaKApXkEwG/jxW0AsS7HW5FIIT+OLFULk5Favv8UVWtxu+tboKVn8QXUcu5EpJaP+BEOe6D9nRSSAu1nJvjES1b6vArfyXJxegrpBIQ3ktoQOORbdp0/JlKnfuGks9RVI4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V0ajMPkg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MXmJpS4M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V0ajMPkg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MXmJpS4M"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CCixQY3716158
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 13:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=; b=V0ajMPkgVJ7WbuHW
	I9TlAHw7olRDXvBREzCOJY+47G2/2sELBRvv3TzcVzlAfc9MOM4WhBUsBa7V52Ae
	TMU1y+/PAqFWntHUT453BmMdQLJQvUe5A23KHWzxScFUiGlfrzKA7bXBVVQDuLx7
	S0w0mfTBqJ2kMs0gN1NPXUtmsdVIVpUlUGvSwwaif2IlmU/y6Yym+nX+XKkq2J1Q
	CicRK2ovRrFlTN82spPVbkzbYMIIzr345jYykfUgHUHxfwrKkVvewsj3wb8tzzlA
	r/oHgyqUuGgRHHoOvIj6ATBEAMLtp2ry5rTpj7P0I4Y3ozHQkn0VvHEzqaHTDF1a
	TdbIkA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er0xd3j5y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 13:21:13 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-963d7e5ac77so392852241.2
        for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 06:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781270472; x=1781875272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=MXmJpS4MDZ8yW2C1lySmFn4os85x0KqJs+F0EHHPa52WDcHdLSy0aLfZN/KUUJCRUr
         T0LWPlfynV4RybWXU7QtZr2eMqIMi7OIxB+FC2oqZ82gJcuiiY8Rk9jw8c8IrRYyWvGk
         Mt94tHmsIAMh5VpeQfLZzWTvZlqzHQGXY28vI7PTkF6mtEfZwBZNtmyFhQMup84ETDHS
         GzoF/XUuKem1Io10arjV7yEIDA953xOpbwbeMsA4GwsU7kWYqRI5vw7pfLzGrZjm9tJf
         xp5iWeK0DIsYeCgf4ebEZucDrDmxRPML5LGziwtv40FBGCEaSVLvsKTabKEeMGDp2D46
         zy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270472; x=1781875272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=cUJUeQBeC4nT6AcVJok5V5rhll0texFNflo5AAA3obeduPaom7ILxEbIyjcAd8uLtD
         Eglg29I4HVFeNPqiPfUFBJa/dzgPx5ElnM93OCMFxnLc7M+GEfzxsH7DIQqghZpFT2wF
         /anR58RwHNsjin67k0pHSZi+wln+AZUJleYjCnRhrNbp2buT1brGymQW3f18Zigsyqha
         GYuDtn+QVhgtGXDfspQKAuvU8zW2zPfPQtQ590rb5pcMdYSmVhxFwQcm0ErUAUiTcfi5
         kAfFErHnwU1u1rJUpnQlC1qD3PA40X+3x5ZjZjgapRQ1sPX9Qo1pcYAtsHF8BT7X73Yo
         B/vg==
X-Gm-Message-State: AOJu0YzXuK2zhhAjhlS9xrSFzc9Wpszlek9caTxvZ4M+MoaqaF6i9H/e
	0J20/GXknHCz9TDBlFgxWRPxsA/uMLEMX+Rdwz4Cx2y0SZjbk2gAX3QZZNdrzcPTW/CQ3Nu8XV3
	RRCH8e657Ty2uqJduqeuW3eD8/r0Bx6WW2GmNXK+6pINc+AVzdNuxe0CLWi/Vktw=
X-Gm-Gg: Acq92OFBh31p8klUK/k87NmYU9XD+GLTywr50LLwN4667iG3NJKjujJnCZfD9wwVvlp
	O+j6kVpfqKviU13tstO4VX5VA6Wceg/1EwBPB/MlvKYExu73WhnAE7S44EWZwKcaoiubxvURVLs
	NOhkNxSRbWxqeAx+Rg/lbz+xed+1QRtJVwpxv7bU/IWHneIZXBw7JqZU2XDnpN2cPTBHczsoqxV
	y0YkgBSr5sxc0OMpXLHB/tefgSU5Pve6AO1BM+JMJALazoKXmOYzEZeR68UOugcr9ChJIAVEgJB
	fWLnn3yj3fe2YJSbPOja4EnbKOAWrQGGoFOjbDvw+GYw7Rjeb/3zoPEG5xAcwR/BH8d+qkRvP8p
	sTLILg7N0P45Bh2xFutaTNH4vrSBhbkmWB0YV+VjmxqprEP+bUkrTiZcgi1jRqy/YkJVlZasS9P
	pbKG8c1gkqRjFgMk1QbGiPa7cirPA1k3V7rAE9z3aJmgMCp9D/8KTwJtJzksi5twQLuVwZTDML
X-Received: by 2002:a05:6102:dc6:b0:632:88f6:d6ae with SMTP id ada2fe7eead31-71e88dc1bffmr1060583137.22.1781270471732;
        Fri, 12 Jun 2026 06:21:11 -0700 (PDT)
X-Received: by 2002:a05:6102:dc6:b0:632:88f6:d6ae with SMTP id ada2fe7eead31-71e88dc1bffmr1060437137.22.1781270470888;
        Fri, 12 Jun 2026 06:21:10 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:3510:32cf:db6:13c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfe6f9c46f0sm59986866b.1.2026.06.12.06.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:21:10 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 15:20:56 +0200
Subject: [PATCH v5 4/9] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-block-as-nvmem-v5-4-95e0b30fff90@oss.qualcomm.com>
References: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
In-Reply-To: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
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
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: FAOvcY3hioJR4f1BLOzvaESrodBY9DDq
X-Proofpoint-GUID: FAOvcY3hioJR4f1BLOzvaESrodBY9DDq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX/xxbgjcUgV+L
 tXnbX2hBJX7hxlpYElcuKh10gUQdTJTFmZeIc0Err0zhzXgaqKIq+XUKj0LCo6efBTM87XV/CfY
 wyGBibio2GawtbyH/3mrDyuiLW7TPN8XXey7DlBMmcrWlGlljDKP2lJ+a4J9m3KDlbOjkrRcvTP
 3/UMK7kOp/pg7JMaGW5NDoDt753bZZ/Etrdcs9ijQvTX909Mrwy3H1el1Xi5lE2hZqhpvHiP4ZG
 515+5r+ILBpmPESw6tJu9qjj4k5pNl1BuGnThaiAJ9FjrBgomNwCJELFyVkLafzFWGYLyA1ysm4
 JbWNY13KxdQEJtGw2X5+rCq+9XkgQDwewlPojfhE1gt38UNZqtnjwja3aXFObEfDRo1Wdu5AzZV
 +njA9WXAbAjiBgx/itHnIoqam5jHkKuXEpkwQ3QDdXbLGmI8Tnl18kZc6lnjT+N78qkMJEUyH9k
 +A822jLWlXr5cJhVFag==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX6xpe7NIUYup9
 77xSL71X+MIC+KTqmSR1ERNbukOT0pzSE7eezfrEpnSKNLyw8JF2uIaJccb2artWqyRGae4p9sI
 ijh6r5soeWaKQCS+YUQKkODCqK9bxvc=
X-Authority-Analysis: v=2.4 cv=O6UJeh9W c=1 sm=1 tr=0 ts=6a2c07c9 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120122

Add support for an NVMEM cell provider for "local-bd-address",
allowing the Bluetooth stack to retrieve controller's BD address
from non-volatile storage such as an EEPROM or an eMMC partition.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
index c8e9c55c1afb4c8e05ba2dae41ce2db4194b4a0f..7cb28f30c9af032082f23311f2fc89a32f266f17 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
@@ -22,4 +22,13 @@ properties:
     description:
       boot firmware is incorrectly passing the address in big-endian order
 
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Nvmem data cell that contains a 6 byte BD address with the most
+      significant byte first (big-endian).
+
+  nvmem-cell-names:
+    const: local-bd-address
+
 additionalProperties: true

-- 
2.34.1

