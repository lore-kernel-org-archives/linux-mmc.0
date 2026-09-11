Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA9248EC79
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141242; cv=pass; b=tcuk1LtrvDGuMu1Syg1QdMBLz2CzLXodSbDI12Kr8b6Po0Le9nqtvtjqYe5GZgf6RZHH/O0D7ZLy2vrfSSRoQWYLDKtO0kyXyQZVZAylVa9ynBfFMkXGmZ+ttvQ3xxp9AXkNbHH6CRoBw+s9bVPMGa6UBhhyxiPfdP/TQegb7SY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141242; c=relaxed/simple;
	bh=jSbG3aFjNRvRvglCvIfgQax72pr/b4wGvV7pjDViZ0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBeO8aL12EqvyzifRGrsYR/pPP9A6WyNkKTjqjAvnB1WhWXodOMOyGtkucmy+/92NXJX1yOzVqO9IWg4dea/lbUpFDNczkYQF2HVbujChLa0OJNr07K9nJQkcUnnJNiZa5c7WlapAw6ULgS5q2HztdF5FFMGs6F21iuBHmqSUXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OUb9aTsd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fxsa+ZkZ; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OUb9aTsd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fxsa+ZkZ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BFAKEJ659064
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 15:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rwhZbo5aLjtiDYX1mzkp9wLc7h/COgN//PfmC+92//Q=; b=OUb9aTsdXISgso5T
	eC2dvUM9d3yZ3dI24Fr1V7aix+9VQ/FWGD5nsi1ZrWPXeMt6M1h95C71SWbFaSbo
	nO503MioXgVG1ih0HcKSe030MnY0/UKUI43l2uOnr4LPPgD3vlu9CLrn0b+bG9Xf
	Y300USjs+2qh9JztbWocUw/zKZDJ5bvTUVwd/bwHEJtxaneNj26e77FFIdq0SEPa
	U24b/2Mwl2oZ/BpkKiLPQmz1OzJjHhmVfgltAhPztGTlpFSaml73t4hjRBz9DpYN
	BMFR/KYGylrUO5gMyno2mhXu+RXEFBWOEhdeMeJrBmCNoKxFGqiMoR5IhdeCaKPl
	siONmQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmm22r4cc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 15:40:38 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1b8088202so1002615a12.3
        for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 08:40:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789141238; cv=none;
        d=google.com; s=arc-20260327;
        b=Tgc1f3uRUmOurzRPgiA+LsLhNKpPsu7G1XVU7atOEnut6hmdEcHtTS9dcBsPtKRMiv
         28hV7X6t+odqX3hLgju0SORyDi/3MiYMti391nFyoHYU/wVAbBXAGFXGHSgLZ5FieJxL
         j0iticOWCYX3JJhn+WcuFdPmN3wJaYGMJgVHv/beyU4U19TgL+mbSXb33Fg9YqYymEj0
         AcFV2H687eh7Zo0cohVnecOvdvGA0autSNlDJY8hNzsb1Jm2N6Wx6W/IaBptbAz43aUn
         BQHCD3QaX6wrPflM6cuJSO7ny1VLQoKAUsxovSLjTaUjic02/BHnzphr/l6inC6Kj4bJ
         PIzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rwhZbo5aLjtiDYX1mzkp9wLc7h/COgN//PfmC+92//Q=;
        fh=hfeMpbAx8fckvWjdm65rQsvELXdP15D9Ml5t48skCCg=;
        b=iwIUZCJz4bJ9IpKW0nPcdzl0AnQ+ZmzKSEYcu/SOJ/0cPuvxUwHzI1ZwHr3YzgV/g8
         3Q6zkaRBw4brqZyiV9e8FZJSXlbTALwK2tQSmt91y1o0884oWzQhH1YJrtSfhy+CVTls
         ViT0PvmXqErqmgBz+cbNXhP/b7yCkAcCDqseZtajrB4B2AGczgHrjo4IHf/Zg99Xo2YY
         Wf8etnR7KUmDcoJn4+1hpbFjPv4P38gobZtpNK15wz3H7sBxnjHpCQoo/cnlQmV2FbwU
         2uuUE3vb7T23Fk8LvZZcJKeOdQni7KYcR0RhMgkh7C2+36vf/JuiHjNxMQta7ymPPAtP
         E9OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789141238; x=1789746038; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rwhZbo5aLjtiDYX1mzkp9wLc7h/COgN//PfmC+92//Q=;
        b=fxsa+ZkZWlmIEvTRVO7JVqJVnJaInP4VGG0psDSUNEHBESMB/p2u4r+Djb7J/D/I8e
         gGgXfjnHXOgqlVdWSnLddBeGapx65CUNx7dQG8NjxEv2GHQLUGzuhVxS3Ir0XjlV8KJn
         djBNToqdnZy7SaZy69rVJmhJ3FTLYoKs2d07xBy19N32RxD2Q9hPszLkWuwQCNF+6vLd
         pmBlEIRZXvMouu0gxKfJeeJ3IifJMqxw1N8iaGEitMuUlRLstjT9IM/hGnzqmjPzYTuI
         qUkaJyh0mw47tpr+HIGLfElFFqAmthUzMF8BDZY4hvK0YNEKJAA0GKeQciK/t31pmblo
         PF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789141238; x=1789746038;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rwhZbo5aLjtiDYX1mzkp9wLc7h/COgN//PfmC+92//Q=;
        b=GTNS7ocmNNVejc2080sNz6tR3ldSwu81IbEe3H3RNoiCEooLCIDGwe/gtcZarcysxx
         DMrB2BT2UIzdm5oXzXiULX6X06yIXNEL50sjIGkgKsGt7kJAgdX0ZPytmNuM4j920Z3v
         1d5UeJeUWK7wulQUwInMli+Lo8xuqyMuuMefirisMhXUhgqTQeCH04533DN/tCvuqh7h
         Ee42r/z5QlO+2ShEm5LGIcgzDYQQXETjDTLMhsMCe1I1wAsieS5yNC4w8ddp75yLU88u
         +TBVUuQvNmu6BymD4WpXy9Jd58Mxf014nI4oeNzZA8ydqtTv24o7rbsJHlWylnm52WX+
         yeXg==
X-Gm-Message-State: AFuF++kSgA+QSsj+bkVBPrzJQk+r/GnCUmEEl/5Qzj2dRr5GK5XZrrmc
	8SORVR3Emzfy2flk8wntXqR5uU/dP8TrWFLSgAk/uoT/ceD+BYW+xBgSVeNcnDX7hpSavjiw4wd
	O0/ninfMMy+mgpaRJ1tAE6p8N81RFOakuWxkeE0RtRYqmjd2LdHbOgtuWsHrPXvS9IGXjRM3TUQ
	n0o6RfUTX8c9F76Yyw3+gSFEGHOYxB1ws7DKcX6Q==
X-Gm-Gg: AYBFou0QPhxgagC3HXNNtiqRN60K+dsQxfR+knE5xTqxmrun/p8QUfsAqq6oHr75elH
	0tzgPxe9TVwYFO9Z0Zk1XSDE0V8sdUpQjMtyJzl2ITHOj9XaZvvbOto1xQC0BHsWGeRqWQvGIrP
	WgPzs11J4lA/uB2yb/SQSa61nqGXE0CODghZFUyxvnzPghu/UuQ46cYV1Qng==
X-Received: by 2002:a05:6a21:6016:b0:3d1:39e9:b261 with SMTP id adf61e73a8af0-3daecb013demr10117990637.0.1789141237842;
        Fri, 11 Sep 2026 08:40:37 -0700 (PDT)
X-Received: by 2002:a05:6a21:6016:b0:3d1:39e9:b261 with SMTP id
 adf61e73a8af0-3daecb013demr10117921637.0.1789141237396; Fri, 11 Sep 2026
 08:40:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901184828.15653-1-tanmay.kathpalia@altera.com>
In-Reply-To: <20260901184828.15653-1-tanmay.kathpalia@altera.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 17:40:26 +0200
X-Gm-Features: AcwNN1UjpdCBRqChgBhbCl2kStXBAyPFr9IkrqKfFP-Qp3GjYbsgqmQxMbpF7eo
Message-ID: <CAPx+jO_6bH8i5BV=64i=dLdi2CVwiu1wceXcqWB14ux3FuX9Bw@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] mmc: sdhci-cadence: add SD6HC support and Agilex5 enablement
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: linux-mmc@vger.kernel.org, ulfh@kernel.org, adrian.hunter@intel.com,
        krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org,
        dinguyen@kernel.org, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX1lVR85kGS8s1
 KNPl37JPujw9Ca0ib9AyhDo+3tYbDHL4XkPrZvuiGH930YlxZm+movq+lF9WGWnnIZmmMqrLXK9
 3XeeupqA3itTDK3o93JOR968AMuj8FiqetEZySet+TWrlW+o8ahfgikWJ3BvLI0L2s9tx8gfUHj
 RW2APmVvwqL1tzgzr7mgg0esT6fqh2Dn1lCwMKiAQkwlFEe80ne5JIPr4B6REHSHzaOwJMYu/oq
 lUYzwRP6h2gzHQ8BwXE83Daex10V41v1N20llKOT/RA5N0lD7DBVWV9I0vJxZmUbxfF2NDen2E0
 NIUX+JPbeEDsm7C/w+Na6rPFUvgRMxMTkZMnb8aK53Kuuoci+OSzKHhDyyUxy1lsEWkdW9SbMST
 JPRhQPYNf6aA8JaXgbr/naGzLRUsIs8b50CQljCT08htVWrJJGKYDxa2yAHIj1pi4SwB38MPvW4
 BNINmCq5fhjFPRhChIw==
X-Authority-Analysis: v=2.4 cv=LPDz05W9 c=1 sm=1 tr=0 ts=6aa420f6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=yBYpec10AAAA:8 a=_gfIGWHmEWhiKiydougA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=zbxmTX4fiVD2UiCe4Dha:22
X-Proofpoint-ORIG-GUID: sHwTxM9-DrbxToyxKy_g36amWi3mXXuV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX76FPzFXNRkAt
 znUvPx088ZJTLloslUUWh6t9oRzzRI4Lb5r10oQQrnxCjzOwDTIsM++aT5L7ZRKG3Sne4Bfy90i
 hTtSdgMKoA98XF8o7PNAWzKEpkvdXjU=
X-Proofpoint-GUID: sHwTxM9-DrbxToyxKy_g36amWi3mXXuV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110218

On Tue, Sep 1, 2026 at 8:49=E2=80=AFPM Tanmay Kathpalia
<tanmay.kathpalia@altera.com> wrote:
>
> This series adds support for the Cadence SD6HC (sixth-generation) SDHCI
> controller and enables it on Altera Agilex5 SoCs.
>
> The SD6HC PHY architecture differs substantially from the SD4HC: it
> requires dedicated per-speed-mode IO cell timing parameters and a
> DLL-based delay line to achieve correct signal margins across all speed
> grades from Default Speed through HS400. These are programmed through a
> new sdhci-cadence-phy-v6.c file; shared driver infrastructure lives in
> sdhci-cadence-core.c.
>
> Note: this series depends on commit ab45ecfab540 ("dt-bindings: reset:
> altr: add COMBOPHY_RESET for Agilex5"), which is already in mainline via
> the reset tree. It is not yet in mmc/next; apply or merge that commit
> when building/testing this series on top of mmc/next. The previous v1/v2
> reset binding patch is therefore omitted from this series.
>
> Board DTS files do not enable the SMMU; that is provided by commit
> 10cf797f3f8a ("arm64: dts: socfpga: agilex5: Enable the SMMU") in the
> SoC DT tree. It is not yet in mmc/next. Apply or merge that commit when
> building/testing this series on top of mmc/next, otherwise the SMMU
> stays disabled in socfpga_agilex5.dtsi.
>
> Patch 1: DT binding
>   Adds a dedicated cdns,sd6hc.yaml binding with SD6HC compatible strings,
>   clock/reset/IOMMU constraints, and PHY timing properties.
>
> Patches 2-5: Device tree
>   Patch 2 adds the SD6HC controller node to the Agilex5 SoC DTSI as
>   sdmmc, left disabled.
>   Patch 3 enables SD card operation (4-bit, SDR104, 200 MHz) on the
>   SOCDK OOBE board with GPIO-switched IO-voltage regulation.
>   Patch 4 registers the intel,socfpga-agilex5-socdk-emmc board variant
>   in the arm/altera binding.
>   Patch 5 adds socfpga_agilex5_socdk_emmc.dts for eMMC-only operation
>   (8-bit, HS200/HS400, 1.8 V IO, 200 MHz).
>
> Patches 6-9: Driver
>   Patch 6 renames SD4HC-specific functions and structures with a "cdns4"
>   prefix to separate them from shared driver paths.
>   Patch 7 encapsulates SD4HC PHY probing in sdhci_cdns4_phy_probe() and
>   makes every of_device_id entry carry explicit platform data, removing
>   the silent fallback.
>   Patch 8 introduces the SD6HC PHY driver (sdhci-cadence-phy-v6.c): DLL
>   lock/bypass, per-speed-mode IO cell timing, tuning, and HW reset. The
>   common driver core selects between v4 and v6 PHY operations based on
>   the SDHCI specification version reported by the controller, and
>   reprograms the PHY from set_clock and set_uhs_signaling. SD6HC clocks
>   are requested by name ("ciu" and "biu").
>   Patch 9 adds the Agilex5 platform overlay under altr,agilex5-sd6hc:
>   40-bit DMA mask for the SMMU address space, quirks for
>   CAP_CLOCK_BASE_BROKEN, PRESET_VALUE_BROKEN, ACMD23_BROKEN and
>   MULTIBLOCK_READ_ACMD12, .get_max_clock set to
>   sdhci_pltfm_clk_get_max_clock, and an init hook that asserts and
>   deasserts the three named resets together, keeping exclusive ownership
>   via devm so they stay deasserted for the life of the device.
>
> Tested on Agilex5 SOCDK:
>   - SD card: Default Speed, High Speed, SDR25, SDR50, SDR104
>   - eMMC daughter board: HS200, HS400
>
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>
> ---
> Changes in v7:
>

[...]

Patch 1 and 6-9 from the v7 series, applied for next, thanks!

Kind regards
Uffe
