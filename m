Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3F52EDD78
	for <linux-mmc@vger.kernel.org>; Mon,  8 Jun 2026 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915845; cv=none; b=uEGPUxy9Zt9NmapLO+qOQZuggB6KlacYSpxAiVxE9WZRtPKkCXuPEIenBqQnt7iAxatyDllzd0fHsxFGdEkitO5fCauSl7BucAUdq3myUnloxWuRhkwF/dhpt8R2EtRwKYYIRTs2UYFEmblwsUYsC2I/y0KEFqpOx26Pf2DrcwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915845; c=relaxed/simple;
	bh=jaf8PFyJ4WPDw4q85PUXH2HS3A+jjIMPeI52wtzYaWo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bQ9TSAIWRl4WED5YdTcmhJ8xARvdsEddhJqsU4fgCGaI+xzIG5DkB6dyhbnh+HcB3F9jWe7JlIL0+f2DPrpKsTSH50aO+6SPRz9tF+IsUoLU/9+hHMCTTG+Z18+oJKGMZMxEeQ0tRL1Psl2U1/rQ9SDAj5nLh23juyUItXyzecI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mtXioEHn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TkIHFkrr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mtXioEHn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TkIHFkrr"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586OtBH2384451
	for <linux-mmc@vger.kernel.org>; Mon, 8 Jun 2026 10:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hw/eHeJkR5tO+NdQr98v8w
	mguro8AATIDIzpZLKzK2E=; b=mtXioEHn1HMmoInhBE01qgoDocjx9KnU89yr8g
	QoN5WkV4prt+rvEA9e0SfeLQEvEzM3zgMsBNPckmdH/3BxX8Wg0AAbLGSgSoF2+t
	LXDHTpbTItdGAB5qgRGOfVG67fJXuiDZt+Wmefo1FwYqnWsZDTqUXGUdnjjObmhm
	EdUHmTbG21T3V856a2LN4DzrRlDdmcxCB6KxG4v9jbe2jsjZOwR9qc6f8CoBCQHj
	jNcftOQKWCiRiJ+nfH6q4pSl49lY5gloMEZA72wj74W06dGE8K/1udrCWnkuFaQR
	ivxjhZbmi+AdVZlewSY4r2KR1wQneQJkBRmMpaVZJc/+djog==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embs1fb6w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 10:50:43 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5178fc89b1bso51351021cf.1
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 03:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780915842; x=1781520642; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hw/eHeJkR5tO+NdQr98v8wmguro8AATIDIzpZLKzK2E=;
        b=TkIHFkrrCwiR2OE6L4SKgWmoMwUbfDKn5MLnYMJKLBiXIyEFTOW8vpetMBZZplXyzl
         jfXN4y98toxpv4GCZA9DLMB3tn5z4ca5gJDuXcZhgJZs5O3e9AwtRjJ3lIUdH+fjPOvZ
         WmPrwEVpDBWEsLz38CKu6eFJMfhSw97lEdIfvT+saUGXLwMW7CAaEF+kZJwdrpCVw4Y3
         7eh+TQF4SbiurjYJ8cJukWavJFHU7t59AA2Nd1rP+WzgYGUn32FCQwW7kaycBpLK2R/b
         h2wBaGmdJ8xdfU+VC9ISuOhlpw+phpAzHGfVhUNPRNNF1pzOAr4vXRjJlSIagf3GgbhK
         rnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780915842; x=1781520642;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hw/eHeJkR5tO+NdQr98v8wmguro8AATIDIzpZLKzK2E=;
        b=XvxIFm7sQoawTOKsyJHWmoLzcLEZYantV1BhrJqK3S6ukO7eLPvoyrDePuG6FooIgj
         16+++kTlUNdT/Y8IlMM+A8NP/HIi4d+OyaKIgTTw4QXz/W41rZ6j7AFtWjvWefT/y836
         ALppIulbDNsmH/hE4qZdHKlxynCo4Qhih7N3Z65zZuZsCcMZismYK4/Qq868VFrotTSr
         hDr4/XzSyJ41ML1xP9/FjR+fkvBeTNaC6ikhf+XZxMRWDtAQxHGIWl8uhFqh/cT8uKFI
         X5EomGn8TI8+cLskxxXNcDhGnDoLKOkFkVs1FG1xZasQTTiiNOLUXdYnIetSNEGSUIuF
         0jQw==
X-Gm-Message-State: AOJu0YxmqY/faiqMjE5T+355W2nZD/kRNv+s0FV5q29IZ9gQN6AZ3hl9
	MJ/Hl4ZuDblGXbj2ShQvpIfbWcAbLbG5S9HlzlgYM+BW/AR2jOAmak8XyWNvR21kIGyXw+OBQHa
	WVGCp7jhECvXky2/EdHlk1AXJnlOQx7YsDyM7u49Jzf0fnvdb4ADnlPzbQuUt42ImsyuEXrRPYA
	==
X-Gm-Gg: Acq92OGkRarupRywlMzcVb98zDcr+UpZbOe5oh9KmQswLN/Cjp+bISG1zpzwq6wfTKU
	YwON9RNySfhR+xPFU12S0y2XtkI8d7MMCL8s7vlG9/gFNIKYhifIvgkk/rg65SaABPBSEtnPFOZ
	aQXrCwZ3ZRjUBPCPnT4WNdLOnaynUMf8L7roYXXTWHt7R+yH7DiUdX/UBrmGfM6pNOVUOdKIh/8
	BIgZKhcA4nQDa7/VdH1cZdCfIVmb1SGfyT/BcCtOaC6IAAuvlnWBGQBrM9Wt5IruTo+UnDu3Ro3
	QcAnW7aX/0+30a+3kzpVxkHllBZAxPl23fAm0CbNsuxoq9AMIVFhrm0BLZubWpi/KiERsWiGhE9
	VO2cj5cJm2rckcRQdCYRBEtu+cHMfNsfITtf3F4HYgOwwbysnkEZFnhTRirr3GDvh7Yjwc/b/8V
	lNKN9w9KK+IC0z7igh/ePG5RQseLjQ22WqU0jHTU0i7a4Jno49wdi29FlKUL3iziCBhjYHxcIO2
	P7qcFxzm95a
X-Received: by 2002:a05:622a:6096:b0:517:917d:e3d3 with SMTP id d75a77b69052e-51795bbf2b1mr200561901cf.36.1780915841928;
        Mon, 08 Jun 2026 03:50:41 -0700 (PDT)
X-Received: by 2002:a05:622a:6096:b0:517:917d:e3d3 with SMTP id d75a77b69052e-51795bbf2b1mr200561291cf.36.1780915841490;
        Mon, 08 Jun 2026 03:50:41 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051e9aa33sm850399866b.24.2026.06.08.03.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:50:40 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v3 0/7] Support for block device NVMEM providers
Date: Mon, 08 Jun 2026 12:50:37 +0200
Message-Id: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH2eJmoC/3XMyw6CMBCF4VchXVvSC1dXvodx0dJBGinVjjYaw
 rtb2LhQN5P8k5xvJgjBApJ9NpMA0aL1Uwq5y0g3qOkM1JrURDBRsUI0VI++u1CFdIoOHC20ZA0
 02qhWkTS6BujtcwOPp9SDxbsPr82PfP3+pSKnjFbKCAl1yVumDh4xvz3U2Hnn8nTIKkbxUUpWf
 ykiKbrnNRhTclnAD2VZljcPNGyg+QAAAA==
X-Change-ID: 20260428-block-as-nvmem-4b308e8bda9a
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEwMSBTYWx0ZWRfX2Y6Ns7rZUpfY
 XqztTRzmoPszx2mYpDLpV0xcASvJRUsLnOOc79fQbF5fZQ03TXNYm+7ISFMUqSxnStMAarUGxVQ
 xypInBUBUAO4V2ipVUXSfQp3IbDzdqPpetO425D+3Y1GGmez1Um+TFExlMNSOyVlR0xUpILPkT7
 WhTpgmoZcPQkFLRcekeS97ERd5SXLTTlF/eqWLRToraJtYzyWDjfTF7YMN1xCCMUeiv1LldhUWF
 42Qg1R8JLhOdK+h2IQQk9Qi7WQPxNTmW+1LnJtFvTl+TGmpmAle9cgAHZHdXG7aLpXGj8/uw/dH
 snPm+lnm/jS5M2wCt8slhWMDJwnwVIjrJcKSTWYu+Tu4GjoYiHV5wjR00Oh5tj356p80FhQgRCJ
 VIu16Y8ZPDctpYNPL5I+CaxaIWRRXRS7Ac96BK51JgXdPCGDaoATN/RMU4PCzIsW3WsG+cyy8eo
 5B/beRynauU319LKzcQ==
X-Authority-Analysis: v=2.4 cv=CeY4Irrl c=1 sm=1 tr=0 ts=6a269e83 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=VT4XjZGOAAAA:8 a=EUspDBNiAAAA:8 a=K84096E0MCUURokRqYgA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-ORIG-GUID: yu6-AMYoIFPibZv-I8ymUkVrtuO-CDAL
X-Proofpoint-GUID: yu6-AMYoIFPibZv-I8ymUkVrtuO-CDAL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080101

On embedded devices, it is common for factory provisioning to store
device-specific information, such as Ethernet or WiFi MAC addresses,
in a dedicated area of an eMMC partition. This avoids the need for
and additional EEPROM/OTP and leverages the persistence of eMMC.

One example is the Arduino UNO-Q, where the WiFi MAC address and the
Bluetooth Device address are stored in the eMMC Boot1 partition.

Until now, accessing this information required a custom bootloader
to read the data and inject it into the Device Tree before handing
control over to the kernel. This approach is fragile and leads to
device-specific workarounds.

Rather than adding a new NVMEM provider specifically to the eMMC
subsystem, the new support operates at the block layer, allowing any
block device to behave like other non-volatile memories such as EEPROM
or OTP.

This series builds on earlier work by Daniel Golle that enables block
devices to act as NVMEM providers:
https://lore.kernel.org/all/6061aa4201030b9bb2f8d03ef32a564fdb786ed1.1709667858.git.daniel@makrotopia.org/

It also introduces an NVMEM layout description for the Arduino UNO-Q,
allowing device-specific data stored in the eMMC Boot1 partition to
be accessed in a standard way.

WiFi and Ethernet already support retrieving MAC addresses from NVMEM.
Bluetooth requires similar support, which is also addressed.

Note that this is currently limited to MMC-backed block devices, as
only the MMC core associates a firmware node with the block device
(add_disk_fwnode). This can be easily extended in the future to
support additional block drivers.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Changes in v3:
- Fixed missing 'fixed-partitions' compatible in partition (Rob)
- Fixed clashing nvmem cells, document calibration along mac (Sashiko)
- Remove workaround to handle dangling nvmem references after
  unregistering, this is a generic nvmem framework issue handled
  in Bartosz's series:
   https://lore.kernel.org/all/20260429-nvmem-unbind-v3-0-2a694f95395b@oss.qualcomm.com/
- Validate mac (is_valid_ether_addr) before copying to output buffer
- Link to v2: https://lore.kernel.org/r/20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com

Changes in v2:
- Fix example nvmem-layout cells to use compatible = "mac-base"
- Squash WiFi MAC and Bluetooth BD address consumer patches into the nvmem layout patch
- Fix possible use-after-free in blk-nvmem: bnv (nvmem priv) linked to nvmem lifetime
- Simplify nvmem-cell-names from items: - const: to plain const:
- Factor out common NVMEM EUI-48 retrieval logic
- Reorder changes
- Link to v1: https://lore.kernel.org/r/20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com

---
Daniel Golle (1):
      block: implement NVMEM provider

Loic Poulain (6):
      dt-bindings: mmc: Document support for nvmem-layout
      dt-bindings: net: wireless: qcom,ath10k: Document NVMEM cells
      dt-bindings: bluetooth: qcom: Add NVMEM BD address cell
      net: of_net: Add of_get_nvmem_eui48() helper for EUI-48 lookup
      Bluetooth: hci_sync: Add NVMEM-backed BD address retrieval
      Bluetooth: qca: Set NVMEM BD address quirks when address is invalid

 .../devicetree/bindings/mmc/mmc-card.yaml          |  29 ++++
 .../net/bluetooth/qcom,bluetooth-common.yaml       |   9 ++
 .../bindings/net/wireless/qcom,ath10k.yaml         |  16 ++
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts |  39 +++++
 block/Kconfig                                      |   9 ++
 block/Makefile                                     |   1 +
 block/blk-nvmem.c                                  | 171 +++++++++++++++++++++
 drivers/bluetooth/btqca.c                          |   5 +-
 drivers/nvmem/core.c                               |  13 ++
 include/linux/nvmem-consumer.h                     |   6 +
 include/linux/of_net.h                             |   7 +
 include/net/bluetooth/hci.h                        |  18 +++
 net/bluetooth/hci_sync.c                           |  39 ++++-
 net/core/of_net.c                                  |  49 ++++--
 14 files changed, 397 insertions(+), 14 deletions(-)
---
base-commit: 47c4835fc0fed583d01d90387b67633950eba2b2
change-id: 20260428-block-as-nvmem-4b308e8bda9a

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

