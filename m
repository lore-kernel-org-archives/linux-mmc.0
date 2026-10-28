Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793207711;
	b=Zrdgs5v+8MKW58YwBG3EvCT93NYZ/gu7jwVGeQENXpAY2akI+4IfpzvUaaGxt8tYDQQR
	 0EO7fQwhmtNIO3Do1obKsMC62Jbiwu1wVa4Q5nB0I0r5CHTdC17Ifmd8lk35gR4rpEWl8
	 VGjwRu6dp+B7HmFvkuSIdPKVIfNmclvSnH+RLL8mlDiraTLDU1kcXO9a7V+TIdF4dNm3h
	 5Jms0djJY2pUNOirYms0LySsvTp7m9SHrUMx/4zOYWEBlaQXm6kUtr5b1XgK25maZ6+io
	 WdDHXjBa6wUfLbz+bajb3rXi4o2PRaytHh4bv2ComO597UQq/gXNkh1Tw/wLZWJMwsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207711;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=LnugOozrP9VXqnObYje6VqLo7X1iy+GTdieQ0zj7BwY=;
	b=KntifmUk8xFfNt5aerL6TW60qlJrIcsVyS8yKSd/peCVg3S35f133QgmxxGlqjOaa1Dv
	 ix7g2P938GctE1pwwFKLD2hEBMdY0IDmy+M4yLtZD6vlwTlbxzGcqVP9LasLocAFuPnM4
	 29E/TdqgUoG8QWrXERa+nKrQk+SQTpilcjRCIkWkJh8lB/bgix4xNvFm9fZnxUays7i77
	 +96G3WhsIQGjrNFN8FlvZyl8yA2Ddg1ZRfk9Vjdy+3KMewegJHtKVdSXeOfnepHU6ogpU
	 KKi5j6l+i2dhPSrshLYb6iaxrGKwbmQLTqGjUEsv6gtffYTv+a8YJIAvS8E8E7jh14Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FX7BORYH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GNWToNHe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D10606A31F
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25D10606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FX7BORYH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GNWToNHe
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFA41J600090
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LnugOozrP9VXqnObYje6VqLo7X1iy+GTdieQ0zj7BwY=; b=FX7BORYHJdGVYKvP
	zR05piPoIjX63d2tWSfCH0J6bCKixFpnUmf1n0mhrH3EC29X58LJUIr0LMWnDcrt
	bhBIetCLQUndTqTHCfCeDfME5hyzY1n3eqewj40uPzif/a0i3be5ZtooHM/QHDq5
	VDW90hWYqF0meKrmTr6FHQWoz1ztHZvQk/2ymvsLUXEW60148Tto7S/iOHhqVac2
	0VL2hz16Pjb0nLEdQZAoea1bXtJaWNLpNaDT840VxNPKzHnIWXv8/dM7Z28XoDAA
	4oMdN4NRefuwGCVQ5hCYsMIP9DFz0ZoQZGDorG5vt14rJWtpcHyc2cAf38G3DxQK
	mJtQfw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk6f93psr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:15:09 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd0b795aa8cso1416494a12.0
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 10:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793207709; cv=none;
        d=google.com; s=arc-20260327;
        b=BaOKH3tXYFAG1x1L2elCF3O+Gc4jqTZcMaLb3juW6bIrszpTFRFr42zB2HYy+pPlf6
         gW/EzVhNtQRoMkwK4P+OAo4hGkjFKCee8sKtldQP6zi+/DSBR4U/WFewroKViKqDt+3N
         60HSx7YkF5BHzw8J0ahheADH8V0e0k8bgG7T8tG+Zw1r+AEnwZaJTeBURw78Q1JMSn3U
         nYXfP7ChOXUrzYtIefjhFPqEKzbBML/RBlrD1KO/hhYjjI189dW7aCmSq9C/PvD2FxjY
         p6yttKeGHW36GjgtNVY9CZxlXmZApmlhk6TGFMm/KLG1+lSTFivgvhwvMlSc+2JzYCOn
         GXFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LnugOozrP9VXqnObYje6VqLo7X1iy+GTdieQ0zj7BwY=;
        fh=Y6px1fmNJgcjcBEuzGjDb1hByGRQtCFMCqivlH3ngEU=;
        b=C11DszO6ydVIa7NfYjtnT3bh7ChsHjepqlO4BgQPZ/Dw6wlak8gziXc19xw3r00dt2
         +xNdYyUMLwLF+DFoTAIipIlpvfSBUM8ZTSGqBolaCxn0KNTasegXZXMJJQZK9r7HlTXt
         +Yb2O4G9YYym9H+b0K0zI+zDb8GX2m4QMiPtGlp7ox8z8IX1sS1Z4GXN0E02ksoXbI3y
         RPxGajVpj8nEP5lqSSvi4n2cYBGkCaDNirXr5eytic/IuoblHZiqmvpY+4i5c3pMz/Ro
         gHMElBE9guz5gEu9VuTfZambQqC0qKq9yFUJSzlRxKPS/P6s+repDsHTFoDVM3ZR2a6x
         vayA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793207709; x=1793812509; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LnugOozrP9VXqnObYje6VqLo7X1iy+GTdieQ0zj7BwY=;
        b=GNWToNHed3bYT4+kWleZscnKYhPlHPwActwHmXX/XBwgnIMIsdJaIIBlCZ1XTTCyvr
         eoZ4uK22Q82Pmt99l9+BWT4Q7TXjJeIHpjDeVIqEVnQu5zVh3WplA+6NFM0mBOK85zPt
         GixX/jHVxbjoPaiiCU0TnZ3Armxy9VAnR/NbON/WQVjbpvep6e/grtVSpPPXNdWWgyhU
         Yfe21AP+BhsMhx6WL6fskkpKyZjt/lQUX2lNu34WoHnl5ORBKjtcMZ6ikZB2IZkK9JBT
         SlAwvsWUJpoQz7Y6wMoFMANclJZYvjqnvV+SxJDvkcOfz1QTM+77PvDUkXrVArXmdqZB
         EP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207709; x=1793812509;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LnugOozrP9VXqnObYje6VqLo7X1iy+GTdieQ0zj7BwY=;
        b=FCKs5rJp87QrjPwHWlZXMla30QKG1fhMXIaSxOFt+RDXjZBm/umknJvjbK/MHQjjCT
         Vay5o4dYSdcpqFgNRvzf+oKxThhYIsMXBlMNW7JtmLkHQjb+fF4gCZznp8udGdYlhazy
         WDoAe4pzcp1OggdQhikdPlmmwG+fndmZBpw6T+X0fPuJ+LKnBNMktaq+kVNaqLdM9/Xr
         Enue29Ln09R1c9IiCBhZPpx5g5Zu6lAyClKkVRV20ISm/hbH6w6N4g+JJwYqpke4c1TA
         az4K9KbvSH4j6re3sLQrYlcz/SItSdJIP4NrrnTSsFO1Xir//GWUtR1b9+ZVW14oPYWL
         xH1g==
X-Forwarded-Encrypted: i=1; AKwUvBw+ejj3eU7+c4qJnBsAj1OLegwxOA+ycv9myzbvC/+N6sd4xJnsTBzAOhE224v8hVSGHEDPNzSdqnc=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7w6AjC971NQZLrt3P3gt+bCfU7e/UnOr8w1eUhmuE28x5Vva7
	bbikhsTnpPznVp18+NO/VENqN9f5+c5ND/m4tWmp4QBilrefR09/ZGNQsMMW72nJFkbn2xPfzWc
	jX0ziZbICbqcBieYlgr9Q4e4UjIjCsQmkOmV9xvQ1O7359yV9qn2m7S63ks6shrC0afHnIyASzH
	k0VNWjzSlIKOZYqdjKko34YiYd6cG2WtPtGQRZaJ1FJ0myeA==
X-Gm-Gg: AYBFou3ZCOzmPNzhMQjf+0aUXYGveuzBrehJ3YjFgGbyVxyGHXPpSQjuln8xAta3QOq
	7m79kjgPKYsGOEvDDYSc+NOA+rrJw3ZMBzHdUJ9SBpoS7lOEto+QMRPL3xee91ucJheA68gQcFm
	aAtSKY+3idii95EiaahxtMIo1APXabmSe6OpZjs9IJZ+QCXl1CZXSbylhhpg==
X-Received: by 2002:a17:90b:4cd0:b0:3a9:79b4:d85 with SMTP id 98e67ed59e1d1-3ae6eff7393mr71043a91.32.1793207708743;
        Wed, 28 Oct 2026 10:15:08 -0700 (PDT)
X-Received: by 2002:a17:90b:4cd0:b0:3a9:79b4:d85 with SMTP id
 98e67ed59e1d1-3ae6eff7393mr71013a91.32.1793207708003; Wed, 28 Oct 2026
 10:15:08 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930103258.13375-1-changhuang.liang@starfivetech.com>
In-Reply-To: <20260930103258.13375-1-changhuang.liang@starfivetech.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 18:14:53 +0100
X-Gm-Features: AclHuK8CaXJNTmA5tKbBoAyE77_drdIKa6H1QBEjzQPCv7RqE6LaFLcpv1yZaLg
Message-ID: <CAPx+jO9dthZCQ4V-25PKGgEJ2qF9Znu6VVFECYhjB-JabyV=6w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add StarFive JHB100 DWCMSHC controller support
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Inochi Amaoto <inochiama@gmail.com>, Chen Wang <chen.wang@linux.dev>,
        Jisheng Zhang <jszhang@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sophgo@lists.linux.dev, Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=frhJ914f c=1 sm=1 tr=0 ts=6ae22d9d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=Bq6zwJu1AAAA:8
 a=N58GgX4bPs6XW67x5a0A:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=KQ6X2bKhxX7Fj2iT9C4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfX17qzooJo/rZY
 hgEhuZq7shthQ+PlGh+Qx30sM014RTMYMccWgk8OqTZi+qkcxaf8N89psZVsGNrwS3OuF5eK/AY
 8p2+EN1latthnwhmzqbizAkFRqmXAd0=
X-Proofpoint-GUID: Tvopjf8A1fVq2qrTgsOYVIiN13mpe7Vv
X-Proofpoint-ORIG-GUID: Tvopjf8A1fVq2qrTgsOYVIiN13mpe7Vv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfX8M3L6obb+EoI
 cHvGhHlbLflLnsB5lkWk8rlN3hAbxwg8ufaLfi73o/MPsxEMhkGOy3F8uIDYklKvYGTGsWi+rrH
 rdqRDR7TMYSnZ0eTwKtd5GvVrOiNsKeyrlAcBYy90gJl98ITbXztJtrFAkERx5p5C9VS+8IvpgV
 emLSo04bgYlCJUfgo73ViRlSFrifwumItfLIweAYIuYYm5CW4igOycrax6CSk2SnEe0d1Foaidi
 0uycF7h2HJ3QJJVZbrpVF05hcNtPYkDwv9DIYqAPkwp93UadiRxDmSGj8OJARwfSN8YyAEQ0zy9
 Hi55BCpe5NhkbT/UOw7DRZdkJveJnogxUnBUDK4/0g4pjl07FOVYO2a4IMf5+dn2+xeMyjHInjK
 jdn1+/ihUs/e9+HGzQA6YLhCeuevsDHpJiTylii+Vu+2WAGtdwlRKuzUXcprAQBulZYcrN20Gyd
 3dnxSu2agRtjpREj2sg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280068

On Wed, Sep 30, 2026 at 12:33=E2=80=AFPM Changhuang Liang
<changhuang.liang@starfivetech.com> wrote:
>
> Add DWCMSHC controller driver for StarFive JHB100 SoC.
> This series has been tested on the JHB100 EVB1 board.
>
> Due to syscon limitations, it is necessary to use dma-ranges
> to restrict the DMA address space of the eMMC controller to:
> [0x400000000 - 0x4ffffffff]
>
> bus_nioc_4g: bus_nioc_4g {
>         compatible =3D "simple-bus";
>         #address-cells =3D <2>;
>         #size-cells =3D <2>;
>         dma-noncoherent;
>         ranges;
>         dma-ranges =3D <0x4 0x00000000 0x0 0x40000000 0x1 0x0>,
>                      <0x4 0x00000000 0x4 0x00000000 0x1 0x0>;
>
>         emmc0: mmc@11b00000 {
>                 compatible =3D "starfive,jhb100-dwcmshc";
>                 reg =3D <0x0 0x11b00000 0x0 0x10000>;
>         };
> };
>
> Changes since v1:
>
> patch 1:
> - Add Krzysztof's Reviewed-by tag
>
> patch 2:
> - Fix the DMA address range error in the commit message
> - Clarify the 36-bit DMA capability and its constraints
> - Add a named macro for the JHB100 delay line value
> - Use dwcmshc_reset instead of sdhci_reset
> - Detect 1.8V capability from mmc->caps/caps2 instead of DT properties
> - In sdhci_jhb100_set_clock(), keep cclk_tx gated when clock is 0.
>
> v1: https://lore.kernel.org/all/20260919092950.178617-1-changhuang.liang@=
starfivetech.com/
>
> Changhuang Liang (2):
>   dt-bindings: mmc: snps,dwcmshc-sdhci: Add starfive,jhb100-dwcmshc
>   mmc: sdhci-of-dwcmshc: Add support for StarFive JHB100
>
>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      |  74 +++++++-
>  drivers/mmc/host/sdhci-of-dwcmshc.c           | 169 ++++++++++++++++++
>  2 files changed, 239 insertions(+), 4 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
