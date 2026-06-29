Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9E23FBEB2
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723356; cv=none; b=mVxmS8pifEoy6UDrAfb9H5yLYKcH/f5Uwmes7CZGMzQtfVOeNz/HknaBFQm0o7t85jLBjcwktMqqD2CFLIzRVOyRyl0uuIWv64lRNBNfC5WVMVx1wy8fw470fh7TcEW8R9VTJ7/c+c7/uItcyYxrLh8ht/KJB93PUsAVuS0Y1p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723356; c=relaxed/simple;
	bh=OKx/GH7ZUq9+Mjfs4xDvFsGX2/Vn8N7/Q0k8/BzXAPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HWZslTQvv03SJitCBXQN13OPivYMXKzDSNAhcVf74EX1C2ViThMsCI/F48i+9rXNESW6RMogKRURl8Q7iu9fummL7HNx34qJCFzSVMHO+f/8YrhPQr6MYbHADU/xaJtJCZE1dpkbiGlc4cMv5PCij7wIQbudKp5eiZe9EWCPtBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=czdkQeM5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hkfs9oRp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="czdkQeM5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hkfs9oRp"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T7E0Lk2188890
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 08:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=; b=czdkQeM5XH12mExK
	rQBsqBTVulz05q+nbLZ/hDzVsMaEjL1c4QwPswA294pcy5d4tcPszTVQCbRi8HFP
	dtuBQ1P+Bref1rX/fKTpVD1kLVqSOt3e/EB800H1TnmQgUGmPM4PlepUhLErNW44
	9L2MaE6m38IyfAfaUllVU0PMbM1o0ZbvVaKFeuDqb8+sTN7qkI/nJskmKo3OhiY4
	tE1bJ4viyymvwTGiUg56tQ+T6nrlqNQAmrSjp0I/1d8xds94EULEkD3nhT0qa8He
	Cmo0MKo0h+oEXuMSPN5Fdcd+wH1BMYPzLzqKIB8xXhQE2auXmxUYLIPsNsKbMDfA
	Ws2w2g==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3m4trdm9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 08:55:51 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5bd954154b1so706163e0c.1
        for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 01:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782723350; x=1783328150; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=hkfs9oRp3EkTiD0y3RURDU85z1IrmGDRZs/H7j5Nbl3Z7NIzUBzDqYdjxHeS4IQkOb
         xsaSv35oNia++HvBgKgwpuFGQ0axmUkrlitxAXcxXNxkZ+2m24QtddrtJodn5hiSF7/Q
         b/eI/xz+Y3Rp/wbumSrNT4OYnVWll0mlgbPdGAAJbqUHzPdGs6DJXFH33eFgiS6AecZN
         eBXq55GeczZjD9Flmfvz8QCNtf/4ZSLuZHfLQzn/g6+xmg/ubsLW0CHbkfZXSRkqIfV1
         IWyoj5Qw2e95QFYazLDAZBiygEzO4rC0qE00yQVlMvu9zj15uiq2ceq8h7E01QCimpB3
         A4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782723350; x=1783328150;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=S/GjgRhDh5HGwU2EIwKES4qJROyxCtOxdT9qF3H8PakHmBvSGQNrNjXpGgd/lWNN4h
         lY1OwZVc+M353fg1tk9JRIsKTvllZI6C6p/HIqlhcymXVCYdojVhyZmkYZMGgm/dStSK
         IxVP7903zl3pUkifQgSFuTagI1cHvwPZnoyh7+mOBg1PsbaxH1phgXlsrdET/5LF4PAl
         Tq+Tvia5euj9Z/mL3kybXM/XPE8s52UQv43k+/9sk7xRrS8iTAclxPnvVelmyhvEWxKw
         jvPPNBiINy5Y+EpqMGuv9uGWyAN8TQ1YMDVemcCKWV9oRrejlmquralwBoU4sccqXZsw
         Nynw==
X-Gm-Message-State: AOJu0YxLgU0xcKMTkrejqyquOHYeYF9IHFxs6ZX7gxO3Rb4FyJSHwnLf
	uagqs/xy3CbnjOnhlv7ebcfPMmoNuoUNXuuyePGCoJCMeChVPSsdxJ6XMZRJiiUDO1yulFl73ZN
	VhL5bwnPSl2dPp41DoaStlB9sFrYZoje24TIC3wsbZABVvoz0zrhfz0BWkcdEyks=
X-Gm-Gg: AfdE7cnzP1TuWedhQDnsbesWKJ8Mz1/sQoC/ceGNEeVEAY+mMqjyQu/hioL2npyHD6h
	+W6Mr65edjt7k+LVDMFyex3il6qWSM2oY78zWPjyIsTXg/S5JPTMl+GjBC7y7dNa0vQpaFAzL3Z
	nEYvxmym8XUIgvTAE8gwQKBr05JSuEAHPSHlMNf5XdDpx+57IdM8jwWcMDC+ZCicRofQI6I6C6F
	mNk8JMDn0ZlKbscT78rSOoVpYu/riFacnrCWml2+lIcR5csLiAb0QdKL2wDO+f4K0yjOjLWMQDl
	/C34M2MAx+1VkeL3bxh5GC9bhn5jBKesnggLPcuYU8eY44AgD8b/tAiWDX9BT1io2d8p9QV1snp
	YUJ9ThZA4oVy1eYUMTZ0YKaDaQjh6FhpCA4tzcvcY5mVfs+cYpx2Sb5jShzdrlc4Dy1Mw6xMDvD
	m76H5bX1r3GMirGB3znUgKuwBW8rs9m7FdIRuFPT+SdrCodYKYlt8JouDiTdbkaiYBT3ozq4Y6v
	viy35d0eHTP7Unfvbam
X-Received: by 2002:a05:6122:6588:b0:5bd:ac45:5b04 with SMTP id 71dfb90a1353d-5bdac455e68mr794046e0c.9.1782723350206;
        Mon, 29 Jun 2026 01:55:50 -0700 (PDT)
X-Received: by 2002:a05:6122:6588:b0:5bd:ac45:5b04 with SMTP id 71dfb90a1353d-5bdac455e68mr794004e0c.9.1782723349679;
        Mon, 29 Jun 2026 01:55:49 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bc8016sm6558981a12.25.2026.06.29.01.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:55:48 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:55:27 +0200
Subject: [PATCH v6 8/9] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-block-as-nvmem-v6-8-f02513dcd46d@oss.qualcomm.com>
References: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
In-Reply-To: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX8GE86ZCEa2oe
 BBnqBLgbSpmmd+oGdTrXnolX5oyNn0evBYYoZ0ah0di9RAS1lxQ6ZD30mCM9TpEICypsRPOu4yz
 h9Jr6tqsYolYtsXU1FIt0vM3e3W2f62hkQfTazcUtcF5tcNz1axjGZuFgVULlqwDBuLCyKEwamp
 WUznXOI6YXhNqv8q/mXlldK2AHdoGwPmnmH/jEaUsA8beuXkscHGiuDp3aWC0wXxRfHO2wSPygS
 bLJ1yt4Tv1zupUz/htkUww/u8bEOhk39lNre35fRagL2OLwqGPIdEWbf33QX2qmxVq4F16t9SHq
 YuYSddjDX7RFbgSGcdu+X9Nxw7GIu4SY8VImK9QgIKXvrkmVBFDnl1L6UKnJxlo0nY1tyAS8OaY
 Cnm4aBsnqu8TOMVardwV1a3do/fpWICTdpoCxmLRxwpWO0ZQztXM3hq4ay80WZnMg65D9fHcWLG
 zSLK/mxnWaSH8bFUjxg==
X-Authority-Analysis: v=2.4 cv=R58z39RX c=1 sm=1 tr=0 ts=6a423317 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=99fXo_IpyjsNTNVBUdkA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX6HWnVwrgEy+V
 Cec6x9rDHi00vWvvb2Rra2oQGyDiH6ZE4ucbQcN/byLREFerbrb3IEWjVfvyLIEbd09BkERh6ud
 6nLh7+CASK8FMMOBkhvvqi9weFyhEf0=
X-Proofpoint-ORIG-GUID: XRbD3nt6vDELvsX7Y_9pdPAxYx65e5BQ
X-Proofpoint-GUID: XRbD3nt6vDELvsX7Y_9pdPAxYx65e5BQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290071

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

