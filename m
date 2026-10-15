Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F3552F271
	for <linux-mmc@vger.kernel.org>; Thu, 15 Oct 2026 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074381; cv=none; b=om4V1G576SC6LclGTBjP+Y5GmIZtbVP8MsNhWNyqsvsjmt2Fh/IOVRXVn4PAcYmRg5qQcVrZqt+4ei8W+nFpZ3UHAX4LLIR1v/nooiYCCWFbw25Ho7HWSVfYj0pI3uW+ekUnKwlvjZiRvOcCYcEhGfiKhREgn0V1vmM8qfQtN8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074381; c=relaxed/simple;
	bh=v6B4pGlB15qzDa60OAR4xYAziYlSgj48SYzsH2z92fA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TsuFS3z1dlvwFR+jKPwNSpbJ2VQLVqMVValcVY8jTdZH7gXRdxjyBW/TPnNJFVXjqJT8hZw9PqgkZKOa6J0vDqt5Dw8ueRRIA/THiRjfJa1yYAV4pOr3ore2TS2n29/aFc5rzUTNecSJRIUMGl8f1br/cbt8WgaD9Mff4Ylgu9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FWIGrUZU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JcHtsMZ2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FWIGrUZU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JcHtsMZ2"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jnE33408836
	for <linux-mmc@vger.kernel.org>; Thu, 15 Oct 2026 14:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xhiR0eGHIMEJDeGPWUuO5n
	vAYyIG1mI9G6WhoIq53T8=; b=FWIGrUZUdNKKjjZWBp3l4RMNHqJJ2aKexIy6pw
	DvKcaX/iVimpXKY6jRZU/xxYklHlux3kpHXn/+CTB05Cbky8BlSB3hwx9VDjimqI
	039OUEuH001yGize62ZWlMrDXM2PG9iBn1Ge0eEvO/lq+QGNegaXKMVl6JvtW068
	CTxevQdD3Y6paxiPfLio11L3IstrXpWynDxHsoAXZj+zKJIUodoPsDGOaNJ6H97b
	BqfhDep3hX6eS+jlB4LtAH2W6DhkFLci2TERTR5/CSwovZm9vcoohyokVpqgjZlx
	UpHX6jVXsFtlqKLPTmfAvNj3ThrplCfii7WANYajF6ZT4TOQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakwn36gc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 15 Oct 2026 14:26:14 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5d600e3ee5eso1557252e0c.1
        for <linux-mmc@vger.kernel.org>; Thu, 15 Oct 2026 07:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792074373; x=1792679173; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xhiR0eGHIMEJDeGPWUuO5nvAYyIG1mI9G6WhoIq53T8=;
        b=JcHtsMZ26pbvfDHLywXbimBwwxVk2WL/1FXoZO671931STG+B8vCEyO4wDP/aoYKBn
         4D7tGAPGmm+y4Jx97X+wVir3p6frvlj9vaV002PmHPphb3RzZjPjQ2r+Br2udfADKlVn
         +UjpsBE1bkw2VxLPl2GqtSJAfHB+7CHJnvGwfiGwJj1Hh7Zi5i+Q0Q6axJPvFpzDZQnX
         0ye85pz3uX8laxdKJgcBLFHGVOi/FM4DB8Xqj6pvgJdlH9A0BlEVBKLs//I7l/wAnyuV
         HSsEcGFo5WpSAKSrH+dMSQiREVENPOkGgWK5WzPaznh59usLehFP0saaMIquN40YGsEA
         lIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074373; x=1792679173;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xhiR0eGHIMEJDeGPWUuO5nvAYyIG1mI9G6WhoIq53T8=;
        b=1dZRGg5BhEuuaT7Sowe4a8AAM1rbjnF2Auu/CjfPKkly0xvAYFAv0jrd4n6r1J1M1a
         GeXpoeQbFE0FMACJ9if8TGQQuyaUVkCownWpPd/ss78+DrGPptTRfIs68FC7uspOm4Ym
         Ao6oiIpcQiZtgRqz13Q3vXmZBA7NxGDJ8mt8MFzFZEuSilaEaVC79ZvQ4GHX96E4vlSv
         ehHm6zJMYgVYt3UM7oVhhhldevMxiouEol5yBRffRjxUjtEBby3vhkEZ5Jkc1oeAkAjH
         leLCsxKY5uKjlmRYfFhC0XZYGe/3lvT+9kDQ7tKpXmlJ6WPaXHKnAgmquCiCWJQq/Mbs
         0y/g==
X-Gm-Message-State: AFq9FYJ0Y/kJli3llT/IEpnZnQe22HHavQcwadBF+6o/pCTi91FxyZgn
	WdNkZBiF+cCzVP8JV1bhPpiiZhDjRQWT2voF9atq9RgGr7XfDPa95y/7gkni0Aa9dyHlnfysqF9
	Qhtl//B+D2HVKQxCHdrzVbFfHCTxgm5doYAtkCHNV2VaZ9PVy/K45GfP0bDj0vSs=
X-Gm-Gg: AYBFou1q6W81nX24e5Ai2GnSMjYNC9ntI+wr2NjuRlj1bq4Eetvc9AzUwUa69Ft7iDa
	dphZL8kKYvhVt1IHYSXLwN65OorIJ9xwxGlE430A6X0syBRAe5Lg2VWbu0frSNxnjjHkNwisGf7
	xOij6C3a4SOgn65BcPlvneIpNd2tT25oaIc7OB5ACH+6PCCsWI4EsCZRIxxzYRA/Ku+aApwjl/Z
	enDA4S/WH2kqNvqz9BSc/3vuhlvkDZe+GceeAJ7czJOzaRoaj9qvU1r2A3ET7AD+W9zwLwjKoB0
	nEpwMM4wfdHU9PgtV4dgA/yPa6o0gLInqsUTMcU5cIYu1yckJFflbovD5j7F4QqrcUtbJtNWhh4
	MYqKHfFxJAkHqfnI+lYNcUT3a5cD+eBJQJXcD/m6uB4I68V7txvZOOXno8IVYStMypKi2xYfowA
	6H2EE70OlgxdyZvTkd2dZCrpchROx9x90XErLBC6tpSw+xIq4HMrk=
X-Received: by 2002:a05:6122:8b1c:b0:5e9:176f:a548 with SMTP id 71dfb90a1353d-5e91efb1041mr6704175e0c.0.1792074373237;
        Thu, 15 Oct 2026 07:26:13 -0700 (PDT)
X-Received: by 2002:a05:6122:8b1c:b0:5e9:176f:a548 with SMTP id 71dfb90a1353d-5e91efb1041mr6704076e0c.0.1792074372429;
        Thu, 15 Oct 2026 07:26:12 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:5402:5e0b:9ef0:9b5b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd6428b3sm69083145e9.1.2026.10.15.07.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:26:11 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v11 0/7] Support for block device NVMEM providers
Date: Thu, 15 Oct 2026 16:25:59 +0200
Message-Id: <20261015-block-as-nvmem-v11-0-f890ac74f87d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHfi0GoC/3XSzW7DIAwA4Fepch6VMf897T2mHSCYNVrTbGGLN
 lV995FeEolxQbIlPmzjW5dpHih3p8Otm2kZ8jBdS8D506Hrz/76RmyIJdEhoAaJloXL1L8zn9l
 1GWlkMgiwZEP0znfl0sdMafh5iC+vJT4P+Wuafx8PLHzNNqmFM2DaRxRkFHfgn6ecj5/f/tJP4
 3gsR7eKC26KAlMpWJSQuKEYFReSGorYFA11LaIoFrXlSYH3QjUUuVdcpciiSGU4kg6IvW4oaqd
 wrBRVFKcIyqhTSg4ait4pWNeii5IAy0xiH6WODcVsigFeKaYoIpFFUJTA24Zi94qoFLt2ZD0JD
 KmXrvXTbqcIqBS3dmTQCWW5iSE1FA4bY0HXawfrxpByNqBXZXj/OPf7/Q+q0+5bLAMAAA==
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
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Eric Dumazet <edumazet@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Christoph Hellwig <hch@lst.de>,
        Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1NyBTYWx0ZWRfX0Dn5/DF1I2ZN
 hRjBpAPuLP/IEL+q/nEqUWjJDI7ZK2OT8OeCAswhaZZNlyM6CNYDpKRrB8wzqF9EaH/KHc1Uw8k
 /rAXjmiORbkrgHDiIG9ZhZO8nu9KOVohc7ZaTjbAhLTYFuDfg+EGF1TrF/ChJJQms7sXErds9d5
 NYm33u9smWh5vh5VvwlXlK2GAm147mDT5kKwzN/KhdhitlrjWHCTvvhXF8mO2eJnvA9/VR/3DR1
 DG1nqY4J3YRJx23lBAf3tZgtJt4qohXjOVsqWBWYgdILOgU5gzNs9Ks6OtEui9XsMx8Dxuwnbom
 qDQxtRRPJCHSNYYJP1kHAzR4ZSeQ2Bz+wfO5LcK9LPuENifHc5P7gCYiCQGV70JaIEj7b4Iv7mi
 YhpqkJYn3x9uZDEmn4/idXibW7PjT6HH8eAjcVXTspLFQViYO/M2qM6TufpAl5LsSy51PjVK62m
 MSstq3wef2R0+LzHU0A==
X-Proofpoint-GUID: nIGkldGbGsleS9fcq_17EduGAmDFzIRb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1NyBTYWx0ZWRfXzuAXfgOfBxJy
 Wt1TMIT8Tchl/Axppi+2vX4YNktID01z8wuf/caqvFw2gH1NE+4uuYfPKjUevzNV4Mw5DfrOmpf
 PjQeIilXGiDk6DPuM3FxgglmE50TeNE=
X-Authority-Analysis: v=2.4 cv=BqUIUoX5 c=1 sm=1 tr=0 ts=6ad0e286 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=VT4XjZGOAAAA:8 a=EUspDBNiAAAA:8 a=zFza9r7X0cgvMxzYsRQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-ORIG-GUID: nIGkldGbGsleS9fcq_17EduGAmDFzIRb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150057

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
Changes in v11:
- Rebase on linux-next + resend
- Link to v10: https://lore.kernel.org/r/20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com

Changes in v10:
- block/blk-nvmem: simplify read error handling (Christoph)
- block/blk-nvmem: verify dev_t wasn't reassigned before reading (sashiko)
- block/blk-nvmem: drop __free() cleanup for explicit of_node_put() (Christoph)
- block/blk-nvmem: init static nvmem_config fields at declaration (Christoph)
- block/partitions/of: fix fwnode ref leak on skip/abort/error paths (sashiko)
- Link to v9: https://lore.kernel.org/r/20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com

Changes in v9:
- Add nvmem support for partition blocks, not only disk (Christoph)
- Prevent concurrent exclusive access to the block device on read (Christoph)
- Add comment about nvmem being a side channel for block device access (Christoph)
- Link to v8: https://lore.kernel.org/r/20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com

Changes in v8:
- block: Fix bdev->bd_nvmem on registering failure (sashiko)
- net: of_net: of_get_nvmem_eui48() now also rejects all-ones cells (sashiko)
- Bluetooth: mgmt: account for HCI_QUIRK_USE_BDADDR_NVMEM in
  is_configured() and get_missing_options() (sashiko)
- Reword blk-nvmem KCONFIG help text to satisfy checkpatch
- Link to v7: https://lore.kernel.org/r/20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com

Changes in v7:
- Rework bindings/dts so that the eMMC boot partition can be a nvmem fixed-layout
  and not a child of fixed-partition. (Rob)
- Add Support for fixed-layout as the nvmem device node itself
- Remove "block: partitions: of: Skip child nodes without reg property"
  This is no more required in this series and will be submitted separately (Rob)
- Add missing linux/cleanup.h and linux/device.h includes (Bartosz)
- simplify nvmem_register() error path using dev_err_probe() (Bartosz)
- nvmem_device forward declaration to blk_types.h (Bartosz)
- Add hci_dev_get_bd_addr_from_nvmem() kernel-doc for return value (Piotr)
- Link to v6: https://lore.kernel.org/r/20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com

Changes in v6:
- blk_nvmem_add() returns int, error properly propagated (Bartosz)
- Redundant if (bdev->bd_nvmem) guard removed in blk_nvmem_del() (Bartosz)
- Size guard changed from UINT_MAX → INT_MAX to avoid signed overflow in config.size (sashiko)
- BLK_OPEN_RESTRICT_WRITES removed from blk_nvmem_reg_read() (sashiko)
- Link to v5: https://lore.kernel.org/r/20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com

Changes in v5:
- Fixed ath10k binding issue + extended commit message (Krzysztof)
- Moved blk-nvmem handling to block core instead of a class_interface
  This allows correct/robust integration with block device life cycle (Bartosz).
- block: partitions: of: Skip child nodes without reg property (sashiko)
- Link to v4: https://lore.kernel.org/r/20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com

Changes in v4:
- Fix squash issue (dts commit incorrectly squashed) (Konrad)
- Use devres for nvmem resources (Bartosz)
- use __free() destructor helper when possible (Bartosz)
- Fix value return checking for bdev_file_open_by_dev
- Link to v3: https://lore.kernel.org/r/20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com

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
Loic Poulain (7):
      dt-bindings: bluetooth: qcom: Add NVMEM BD address cell
      block: partitions: of: Attach partition fwnode to the block device
      block: implement NVMEM provider
      net: of_net: Add of_get_nvmem_eui48() helper for EUI-48 lookup
      Bluetooth: hci_sync: Add NVMEM-backed BD address retrieval
      Bluetooth: qca: Set NVMEM BD address quirks when address is invalid
      arm64: dts: qcom: arduino-imola: Add NVMEM layout for WiFi/BT

 .../net/bluetooth/qcom,bluetooth-common.yaml       |   9 ++
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts |  32 ++++++
 block/Kconfig                                      |  11 ++
 block/Makefile                                     |   1 +
 block/blk-nvmem.c                                  | 112 +++++++++++++++++++++
 block/blk.h                                        |   8 ++
 block/genhd.c                                      |   4 +
 block/partitions/check.h                           |   1 +
 block/partitions/core.c                            |  25 ++++-
 block/partitions/of.c                              |   3 +
 drivers/bluetooth/btqca.c                          |   5 +-
 include/linux/blk_types.h                          |   4 +
 include/linux/of_net.h                             |   7 ++
 include/net/bluetooth/hci.h                        |  18 ++++
 net/bluetooth/hci_sync.c                           |  41 +++++++-
 net/bluetooth/mgmt.c                               |   6 +-
 net/core/of_net.c                                  |  52 +++++++---
 17 files changed, 320 insertions(+), 19 deletions(-)
---
base-commit: d419d682257d813f6cb7a28e42b35d0edf4ad038
change-id: 20260428-block-as-nvmem-4b308e8bda9a

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

