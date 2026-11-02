Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628259;
	b=V+iTlIbjXCPmG3O6qd9HYS2kvzDJXHmjMemcCksWvH19JwoeLco9e4F1zrffv/LaFD6p
	 obSkV4eJaLF55QZZSuo/Tf9Uw774UNMh7+Ys5yJ0h7uIrC8qKyEozE5flLNWQLoYqnRBp
	 SIHihGAVo2+Lk4lUw3eskgeb6zYv6J4uZHo/8Liavbs0QMxGyTeap6q1qewIcIad4nT7R
	 JLq/wEuJGvv3gz+8ugJ9OpKkYpyWnIPL4nUVIYFWhbrZyelEP/XBRKjZ1hN8uZ0q5DeI2
	 f5x3CxMd4w0DmyWehdsBuLhFOUo4MxODAx+dD/utIl1Pkk8x8ifh/zOzYJZd6sbVDzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628259;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=MM6WPQvZHCORWNa5gBSC182WytjG7gpmpHokMfwajXg=;
	b=3QQUZmjHTaVpY/DMi4Qn+xJ0p4WyhlL4waqOKD2O4HKKD7ChMzhYZA/AAgWSEog+bj7N
	 mph3HVZJwpvKERpplYkgA/YwIfvZZSq7oGSuYWQbWf20jg97+QwS2bxzLEUWj7ueulqhz
	 BUc+G6P5zkUSHQHMpq7yFaz5hQsbfBgV1mq4hH5eJEVsf5VniMEhe4AJLfqm1AMIUT6iv
	 01CHI6uyzobzzFWAHQQDgAjbuL+KMf8umNslI2x8uuJt6/zhsrhStJHVyyVG6Nvhewnci
	 Eyj65cby2kleFNCVo+CbZZGYUGt2ezvbRSc6c/x03jgRxFbXy3aPmPeYGFTAKANvWsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PMHsexhf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bqtWHwid;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE8860A2604
	for <linux-mmc@vger.kernel.org>; Mon,  2 Nov 2026 14:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FE8860A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PMHsexhf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bqtWHwid
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2Dplm32449634
	for <linux-mmc@vger.kernel.org>; Mon, 2 Nov 2026 14:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MM6WPQvZHCORWNa5gBSC182WytjG7gpmpHokMfwajXg=; b=PMHsexhfRoZiw1Jp
	hOovDHYjxEUFNn9NPgdNHGpNAiORq/2dwJiC+9wV70VCWP3fAc0MRmV8jSetIhUB
	hI/epuixlKhl+2gw23566HJ6rsomcZJVkgfY9eNeJzmxuN3DgQXqTJOkhjBwH2Fn
	mF1XuoaoesAmrSiYKSQ+e1DI7jOJZ4ym6osZCKcQYuROXtemf01nav2SP3XUlt3s
	3E7SKsdgHJZaJP23jAXdznL4Xx34lxrIuDroTg2lzngDCeQtl2XGblpR/8uMegRy
	Bt8fXx7qLg4edSYaRw66CAEu8Cv4DfznRhZU988SQmfHtXmHtfzqDTSXNkwH5iYm
	FQJz0A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpky4hyw8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 02 Nov 2026 14:04:17 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a086ed8980so2236120b3a.1
        for <linux-mmc@vger.kernel.org>; Mon, 02 Nov 2026 06:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793628257; x=1794233057; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MM6WPQvZHCORWNa5gBSC182WytjG7gpmpHokMfwajXg=;
        b=bqtWHwideMN7zz0WtMHedmiJWRLPLUHF6pmZX5qEHu3P8F9YvJWnpzMwvt0JEdTV/U
         zuxZqXrNuIoP6DvO5azSE6re+bhzz5Sp4H4hk1CJOk7RzgLQfZP/cDwiPbSZFTuDObCQ
         m+ghtkfJZC7XtYCVXu5ialhrIcqJG6rqfrmGdLS3ggRk/WnW0zs4xjTNPi8gGk9n21CS
         zqxm1teD44V7eQ++bzqiUU0uRvrXsVlUAJsCe0VbDOQMgt8di7ytEX7qlL80FLYZG6rY
         rOf3r9aGRoeJr033TbACvzqcvGUIN9ZxX4Fwxc9AzMPjqgdRXTGKjsYIOKae0+rXMru5
         Q0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793628257; x=1794233057;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MM6WPQvZHCORWNa5gBSC182WytjG7gpmpHokMfwajXg=;
        b=csiHesD9aGC15FDOLrJ2sNnFVIxveDbyiSc7JX/9qRVg/qSxLDvKsscE645guUtUJD
         PVYP9GFA9K+wbjN5RgZ6xQzFaWohr6eK19LSKJnc6Q5/gE92RlU9SpamIDLXfpCEctEL
         XdzSEbaS7yOKaCW89YECs8mv47+lP2US8mPP4OmjqcLHosDlfS5h8ePO3DB3+8aA+fZ4
         qGR+Ab00O2lRhGuvvoh02mnp74W4o6BtqqLD+TMse7salKKbpRZljOacdYQrVJwn667F
         zH1yCAzARG4W1J71MIUbdc0EJ+VSazlMBcDmMIK3J3gW02WGgi2oVfxFIt2JMHeC+fN6
         wRcg==
X-Forwarded-Encrypted: i=1; AKwUvBwbe9F1r8D/5ktjRfBxwre0ptZFfX5c4Iheh9dGftpKyDBBMkcLxQKItwdP6FuotMzi8E6W1iFLwPo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8OkNGWlpv4GwGD7U2abis80lV+HGU05qg4S3Mk7V2OAz++Cn9C
	UZFHnQIFIMs5RbIegW1fXSvwoILaLlYML62mDyKyU8RI9cXsAGUpgYKqTZ7ZB0uxr7cmFTkXoMx
	1Z7t5m+QfGM1dKK4nJjZfJeKEuGbC8vJ0klxLFWne+gjoiL+EHD/dvMb1fGF/jyc=
X-Gm-Gg: AYBFou0lkDrwOKSIMQcaGYx+LoEipe5VzHWRubfyfy0Ku6qOXsYWT0Bcyak2ZFY+lIh
	ACabG8GXhZ17feQk51CALj+aA6j9thMnMq5Z/VGRwy2L+zSIDONbuymqpHJ9TQJidxJZLKPscFW
	mdKPSyXAOORGshUeKM8F44h7GB+DEytK0fAvKsolSfA0Jl4qksKBRt0aYlWJHtGwQasYf7sKRIn
	PSBjJavN4y0iyXaQLrm6qRXq+aD1NoFLLSGvNQZWUzyt8STiNrXzqBFHCj/lyiHe8vi7iwcR/tj
	yVLFflUF0oOUVhYV52rIzfLM5jHUd6m8weYWWby1nTeiz1nuVx3d1n1EzAavGCfYbqpALxj/oTD
	NUK4nlxhTBVNYPU++Ntao0uJ6uRzdhLNqVH02/WzpOh4OmUPWVSScDw6z/DYXzWEXGm0qDYewm6
	U=
X-Received: by 2002:a05:6a00:bd02:b0:8a0:3617:b53a with SMTP id d2e1a72fcca58-8a9bea6af02mr5307509b3a.18.1793628256832;
        Mon, 02 Nov 2026 06:04:16 -0800 (PST)
X-Received: by 2002:a05:6a00:bd02:b0:8a0:3617:b53a with SMTP id d2e1a72fcca58-8a9bea6af02mr5307477b3a.18.1793628256260;
        Mon, 02 Nov 2026 06:04:16 -0800 (PST)
Received: from hu-ahari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad77fd956sm2286942b3a.3.2026.11.02.06.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:04:15 -0800 (PST)
From: Anjana Hari <anjana.hari@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 19:33:42 +0530
Subject: [PATCH 2/2] mmc: sdhci-msm: Add support for firmware-managed
 resource platforms
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-sdcc_scmi-v1-2-244dbd893051@oss.qualcomm.com>
References: <20261102-sdcc_scmi-v1-0-244dbd893051@oss.qualcomm.com>
In-Reply-To: <20261102-sdcc_scmi-v1-0-244dbd893051@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anjana Hari <anjana.hari@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shazad Hussain <shazad.hussain@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Nitin Rawat <nitin.rawat@oss.qualcomm.com>,
        Ram Gupta <ram.gupta@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: F3AJnzcO3BSe03HuArIYScOZ6p2lH3Oz
X-Proofpoint-GUID: F3AJnzcO3BSe03HuArIYScOZ6p2lH3Oz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1NSBTYWx0ZWRfX7JsoIeAjaVBo
 eJ8t34/SrGNfa1KNDQreENHIO8VMcj5//Gy/ZsFKtjqQKjIAqr+L5tKNlcCWjF7SCIuzFjc7xWF
 gnpKA7UjgBPR+YkROa7FIqPxjUqtavc=
X-Authority-Analysis: v=2.4 cv=QoHLTlyd c=1 sm=1 tr=0 ts=6ae89861 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=tGE8Z9jcIeqfSwNaEeYA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1NSBTYWx0ZWRfX/fq1FoEClmH6
 rInCKJC/Tdf11BG3Sl9ov4hGrgdXiqmc1iUa52SyoGy55ayNGoywp3E7VtD4mP6eTtRcIaUPgkN
 8W/9XiL6AGBQmygKMyBcCjHuRgCkSEzJCLzTyWeEepIf6BfXPq/7m8hGP5IdzAV/ab5uC56y7zT
 r9anpYQTJ0t2LZZldocj/8hO7y1nZ5mGYAvYwvcX1pFXF36RDQnjFiUB3OKfQOn//pfsQUzNz9T
 TamgFt+lPa7WeoHOW6VlLuXJgszDKXQTPsz0nI6j2Z24ib4M8ypwAXxl4Ad/bJjyYi3Tt54zdjA
 z+09I6oj3bejPH6ZddtWdTsAEF2M0Z11K/czzoPtndkQNF8tlz3H6dly4ybp8+TJ2u3RjARIKJu
 DhDM26zQc8lcxoM3g5uxF9DnZwkRGnRyWhPrpvQdS6e5sF5VeS3KepoQv01ELvJ3XNqBnahHqRg
 JPcwjsuzs7cFz+Aa4Pw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020055

On certain Qualcomm automotive SoCs such as Nord, platform resources
including clocks, interconnect bandwidth, resets, and regulators are
owned and managed by firmware rather than directly by Linux. The
firmware abstracts these resources behind logical power domains and
exposes control through the SCMI power protocol.

Introduce a firmware-managed variant of the sdhci-msm driver that
operates through this abstraction instead of directly programming GCC
clocks and PMIC regulators.

The firmware-managed model uses two logical power domains, attached at
probe time via dev_pm_domain_attach_list():

  - "power" domain: governs SDCC rail power state. It is activated at
    probe and released at remove via pm_runtime_resume_and_get() and
    pm_runtime_put_sync() on the domain device. These calls are
    translated by the SCMI power protocol into firmware power-state
    requests.

  - "perf" domain: the SCMI perf domain driver populates OPPs at probe
    time by querying the firmware-reported performance levels via
    perf_ops->device_opps_add(). Clock rate selection uses
    dev_pm_opp_find_freq_floor() to locate the nearest OPP at or below
    the requested frequency, then dev_pm_opp_set_opp() to apply it,
    rather than directly programming the GCC clock tree.

A new variant sdhci_msm_fw_v5_var is introduced with the compatible
string "qcom,nord-sdhci". Detection is automatic at probe: a non-NULL
pd_data.pd_names in the variant descriptor marks the platform as
firmware-managed, causing probe to select firmware-specific platform
data (sdhci_msm_fw_pdata) and ops (sdhci_msm_fw_ops).

The firmware-managed ops provide:
  - sdhci_msm_fw_get_max_clock: queries the perf domain OPP table
    using dev_pm_opp_find_freq_floor() at ULONG_MAX to discover the
    maximum supported frequency, replacing the direct GCC readout.
  - sdhci_msm_fw_set_clock: routes clock rate programming through the
    perf domain OPP path, reusing the existing bus-mode multiplier
    logic to derive the target rate.

Suspend and resume sequences bypass local clock and regulator management
for firmware-managed platforms, as firmware handles those transitions
autonomously in response to SCMI power-state transitions from the
runtime PM framework.

Co-developed by: Shazad Hussain <shazad.hussain@oss.qualcomm.com>
Signed-off-by: Shazad Hussain <shazad.hussain@oss.qualcomm.com>
Signed-off-by: Anjana Hari <anjana.hari@oss.qualcomm.com>
---
 drivers/mmc/host/sdhci-msm.c | 213 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 208 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index aecd425bf095..da52a45203a5 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -8,8 +8,9 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/mmc/mmc.h>
-#include <linux/pm_runtime.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/iopoll.h>
 #include <linux/regulator/consumer.h>
@@ -168,6 +169,9 @@
 #define ICE_HCI_PARAM_CCI	GENMASK(7, 0)
 #define ICE_HCI_PARAM_CE	GENMASK(8, 8)
 
+#define DOMAIN_IDX_POWER	0
+#define DOMAIN_IDX_PERF		1
+
 struct sdhci_msm_offset {
 	u32 core_hc_mode;
 	u32 core_mci_data_cnt;
@@ -275,6 +279,11 @@ struct sdhci_msm_variant_info {
 	bool restore_dll_config;
 	const struct sdhci_msm_variant_ops *var_ops;
 	const struct sdhci_msm_offset *offset;
+	/*
+	 * pd_names != NULL marks this variant as firmware managed;
+	 * see fw_managed detection in sdhci_msm_probe().
+	 */
+	const struct dev_pm_domain_attach_data pd_data;
 };
 
 struct sdhci_msm_host {
@@ -285,6 +294,7 @@ struct sdhci_msm_host {
 	struct clk *xo_clk;	/* TCXO clk needed for FLL feature of cm_dll*/
 	/* core, iface, cal and sleep clocks */
 	struct clk_bulk_data bulk_clks[4];
+	struct dev_pm_domain_list *pd_list;
 #ifdef CONFIG_MMC_CRYPTO
 	struct qcom_ice *ice;
 #endif
@@ -302,6 +312,7 @@ struct sdhci_msm_host {
 	u32 caps_0;
 	bool mci_removed;
 	bool restore_dll_config;
+	bool fw_managed;
 	const struct sdhci_msm_variant_ops *var_ops;
 	const struct sdhci_msm_offset *offset;
 	bool use_cdr;
@@ -414,6 +425,45 @@ static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
 		 mmc_hostname(host->mmc), achieved_rate, timing);
 }
 
+static int msm_fw_set_clock_rate_for_bus_mode(struct sdhci_host *host,
+					      unsigned int clock)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	struct device *dev = mmc_dev(host->mmc);
+	struct dev_pm_opp *opp;
+	struct device *perf_dev;
+	struct mmc_ios ios = host->mmc->ios;
+	unsigned long clock_long = (unsigned long)clock;
+	unsigned long desired_rate;
+	unsigned int mult;
+	int ret;
+
+	perf_dev = msm_host->pd_list->pd_devs[DOMAIN_IDX_PERF];
+
+	mult = msm_get_clock_mult_for_bus_mode(host, clock, ios.timing);
+	desired_rate = clock_long * mult;
+
+	/* Find the nearest OPP at or below the requested frequency. */
+	opp = dev_pm_opp_find_freq_floor(perf_dev, &desired_rate);
+	if (IS_ERR(opp)) {
+		dev_err(dev, "Failed to find OPP for freq %lu: %pe\n", clock_long, opp);
+		return PTR_ERR(opp);
+	}
+
+	ret = dev_pm_opp_set_opp(perf_dev, opp);
+	dev_pm_opp_put(opp);
+	if (ret) {
+		dev_err(dev, "Failed to set OPP for freq %lu: %d\n", clock_long, ret);
+		return ret;
+	}
+
+	/* desired_rate was rounded down by find_freq_floor to the actual OPP rate. */
+	host->mmc->actual_clock = mult ? desired_rate / mult : desired_rate;
+	msm_host->clk_rate = desired_rate;
+	return 0;
+}
+
 /* Platform specific tuning */
 static inline int msm_dll_poll_ck_out_en(struct sdhci_host *host, u8 poll)
 {
@@ -1253,7 +1303,10 @@ static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 */
 	if (host->flags & SDHCI_HS400_TUNING) {
 		sdhci_msm_hc_select_mode(host);
-		msm_set_clock_rate_for_bus_mode(host, ios.clock, ios.timing);
+		if (msm_host->fw_managed)
+			msm_fw_set_clock_rate_for_bus_mode(host, ios.clock);
+		else
+			msm_set_clock_rate_for_bus_mode(host, ios.clock, ios.timing);
 		host->flags &= ~SDHCI_HS400_TUNING;
 	}
 
@@ -1847,6 +1900,28 @@ static unsigned int sdhci_msm_get_min_clock(struct sdhci_host *host)
 	return SDHCI_MSM_MIN_CLOCK;
 }
 
+static unsigned int sdhci_msm_fw_get_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	unsigned long max_freq = ULONG_MAX;
+	struct dev_pm_opp *opp;
+	struct device *perf_dev;
+	struct device *dev = mmc_dev(host->mmc);
+
+	perf_dev = msm_host->pd_list->pd_devs[DOMAIN_IDX_PERF];
+
+	opp = dev_pm_opp_find_freq_floor(perf_dev, &max_freq);
+	if (IS_ERR(opp)) {
+		dev_err(dev, "Failed to find opp for freq %lu\n", max_freq);
+		return SDHCI_MSM_MIN_CLOCK;
+	}
+
+	dev_pm_opp_put(opp);
+
+	return max_freq;
+}
+
 /*
  * __sdhci_msm_set_clock - sdhci_msm clock control.
  *
@@ -1892,6 +1967,40 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
 	__sdhci_msm_set_clock(host, clock);
 }
 
+static void sdhci_msm_fw_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+
+	if (!clock) {
+		host->mmc->actual_clock = 0;
+		msm_host->clk_rate = 0;
+		goto out;
+	}
+
+	sdhci_msm_hc_select_mode(host);
+
+	if (msm_fw_set_clock_rate_for_bus_mode(host, clock))
+		return;
+out:
+	__sdhci_msm_set_clock(host, clock);
+}
+
+static int sdhci_msm_fw_power_state(struct device *dev, bool power_on)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	struct device *pwr_dev;
+
+	pwr_dev = msm_host->pd_list->pd_devs[DOMAIN_IDX_POWER];
+
+	if (power_on)
+		return pm_runtime_resume_and_get(pwr_dev);
+	else
+		return pm_runtime_put_sync(pwr_dev);
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Inline Crypto Engine (ICE) support                                        *
@@ -2550,6 +2659,17 @@ static const struct sdhci_msm_variant_info sdhci_msm_v5_var = {
 	.offset = &sdhci_msm_v5_offset,
 };
 
+static const struct sdhci_msm_variant_info sdhci_msm_fw_v5_var = {
+	.mci_removed = true,
+	.var_ops = &v5_var_ops,
+	.offset = &sdhci_msm_v5_offset,
+	.pd_data = {
+		.pd_flags = PD_FLAG_DEV_LINK_ON,
+		.pd_names = (const char * []) { "power", "perf" },
+		.num_pd_names = 2,
+	},
+};
+
 static const struct sdhci_msm_variant_info sdm845_sdhci_var = {
 	.mci_removed = true,
 	.restore_dll_config = true,
@@ -2566,6 +2686,7 @@ static const struct of_device_id sdhci_msm_dt_match[] = {
 	{.compatible = "qcom,sdhci-msm-v5", .data = &sdhci_msm_v5_var},
 	{.compatible = "qcom,sdm670-sdhci", .data = &sdm845_sdhci_var},
 	{.compatible = "qcom,sdm845-sdhci", .data = &sdm845_sdhci_var},
+	{.compatible = "qcom,nord-sdhci", .data = &sdhci_msm_fw_v5_var},
 	{.compatible = "qcom,sc7180-sdhci", .data = &sdm845_sdhci_var},
 	{},
 };
@@ -2587,6 +2708,21 @@ static const struct sdhci_ops sdhci_msm_ops = {
 	.set_timeout = sdhci_msm_set_timeout,
 };
 
+static const struct sdhci_ops sdhci_msm_fw_ops = {
+	.reset = sdhci_and_cqhci_reset,
+	.set_clock = sdhci_msm_fw_set_clock,
+	.get_min_clock = sdhci_msm_get_min_clock,
+	.get_max_clock = sdhci_msm_fw_get_max_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.set_uhs_signaling = sdhci_msm_set_uhs_signaling,
+	.write_w = sdhci_msm_writew,
+	.write_b = sdhci_msm_writeb,
+	.irq	= sdhci_msm_cqe_irq,
+	.dump_vendor_regs = sdhci_msm_dump_vendor_regs,
+	.set_power = sdhci_set_power_noreg,
+	.set_timeout = sdhci_msm_set_timeout,
+};
+
 static const struct sdhci_pltfm_data sdhci_msm_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
 		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
@@ -2597,6 +2733,16 @@ static const struct sdhci_pltfm_data sdhci_msm_pdata = {
 	.ops = &sdhci_msm_ops,
 };
 
+static const struct sdhci_pltfm_data sdhci_msm_fw_pdata = {
+	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
+		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
+		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
+
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.ops = &sdhci_msm_fw_ops,
+};
+
 static inline void sdhci_msm_get_of_property(struct platform_device *pdev,
 		struct sdhci_host *host)
 {
@@ -2665,8 +2811,21 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	const struct sdhci_msm_offset *msm_offset;
 	const struct sdhci_msm_variant_info *var_info;
 	struct device_node *node = pdev->dev.of_node;
+	bool fw_managed;
 
-	host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata, sizeof(*msm_host));
+	var_info = of_device_get_match_data(&pdev->dev);
+	if (!var_info)
+		return -ENODEV;
+	fw_managed = !!var_info->pd_data.pd_names;
+
+	/*
+	 * Based on variant info, differentiate platform initialization
+	 * for local and remote managed resource platforms.
+	 */
+	if (fw_managed)
+		host = sdhci_pltfm_init(pdev, &sdhci_msm_fw_pdata, sizeof(*msm_host));
+	else
+		host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata, sizeof(*msm_host));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
@@ -2684,12 +2843,11 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	 * Based on the compatible string, load the required msm host info from
 	 * the data associated with the version info.
 	 */
-	var_info = of_device_get_match_data(&pdev->dev);
-
 	msm_host->mci_removed = var_info->mci_removed;
 	msm_host->restore_dll_config = var_info->restore_dll_config;
 	msm_host->var_ops = var_info->var_ops;
 	msm_host->offset = var_info->offset;
+	msm_host->fw_managed = fw_managed;
 
 	msm_offset = msm_host->offset;
 
@@ -2698,6 +2856,32 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 
 	msm_host->saved_tuning_phase = INVALID_TUNING_PHASE;
 
+	if (msm_host->fw_managed) {
+		ret = dev_pm_domain_attach_list(&pdev->dev, &var_info->pd_data,
+						&msm_host->pd_list);
+		if (ret < 0)
+			return dev_err_probe(&pdev->dev, ret,
+					     "Failed to attach power domains\n");
+
+		if (ret != var_info->pd_data.num_pd_names)
+			return dev_err_probe(&pdev->dev, -ENODEV,
+					     "Expected %d power domains, got %d\n",
+					     var_info->pd_data.num_pd_names, ret);
+
+		ret = sdhci_msm_fw_power_state(&pdev->dev, true);
+		if (ret) {
+			dev_pm_domain_detach_list(msm_host->pd_list);
+			return dev_err_probe(&pdev->dev, ret,
+					     "Failed to power on domain\n");
+		}
+
+		/*
+		 * Skip initializing clocks, regulators and reset in kernel
+		 * for firmware managed platforms.
+		 */
+		goto skip_resource_init;
+	}
+
 	ret = sdhci_msm_gcc_reset(&pdev->dev, host);
 	if (ret)
 		return ret;
@@ -2786,6 +2970,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		}
 	}
 
+skip_resource_init:
 	/* Reset the vendor spec register to power on reset state */
 	writel_relaxed(CORE_VENDOR_SPEC_POR_VAL,
 			host->ioaddr + msm_offset->core_vendor_spec);
@@ -2917,6 +3102,12 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 bus_clk_disable:
 	if (!IS_ERR(msm_host->bus_clk))
 		clk_disable_unprepare(msm_host->bus_clk);
+fw_detach:
+	if (msm_host->fw_managed) {
+		sdhci_msm_fw_power_state(&pdev->dev, false);
+		dev_pm_domain_detach_list(msm_host->pd_list);
+		msm_host->pd_list = NULL;
+	}
 	return ret;
 }
 
@@ -2930,6 +3121,12 @@ static void sdhci_msm_remove(struct platform_device *pdev)
 
 	sdhci_remove_host(host, dead);
 
+	if (msm_host->fw_managed) {
+		sdhci_msm_fw_power_state(&pdev->dev, false);
+		dev_pm_domain_detach_list(msm_host->pd_list);
+		msm_host->pd_list = NULL;
+	}
+
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
@@ -2947,6 +3144,9 @@ static int sdhci_msm_runtime_suspend(struct device *dev)
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	unsigned long flags;
 
+	if (msm_host->fw_managed)
+		return sdhci_msm_fw_power_state(dev, false);
+
 	spin_lock_irqsave(&host->lock, flags);
 	host->runtime_suspended = true;
 	spin_unlock_irqrestore(&host->lock, flags);
@@ -2967,6 +3167,9 @@ static int sdhci_msm_runtime_resume(struct device *dev)
 	unsigned long flags;
 	int ret;
 
+	if (msm_host->fw_managed)
+		return sdhci_msm_fw_power_state(dev, true);
+
 	ret = clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
 				       msm_host->bulk_clks);
 	if (ret)

-- 
2.34.1

