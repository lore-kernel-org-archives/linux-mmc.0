Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961494;
	b=rGyCju6Fk8E17s4AypivT9z/jT6h4Ujrxf66FF3m3L/50bzsbmSFiK87L1BuVhmlsCVS
	 l39yxevIlEzTHILHTbtxcBxDg+jl+Be+6vMsJb4jUhVlwHorNxVUV9Dm9PuPev0+mZbDy
	 XPWhK/pFOZzNqVg7SgBuh6OvVWF7rx4/pIGYTltKrWQ6fkt++SZT9IUf9zCqfN/BVwscb
	 zXn0Cl5aT6pEBoIpVuK202LCynM/vtnm35PS8vs8SvjndiDMAyGeyZg6cjgbTttlBVK0/
	 AsaxT6SOEcv1E/Fpyy+wARPMnU/ejA2BX3PKvO2CFORh1kfzivRA6Ea/7ZOuQ/vhBug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961494;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=DyCrYP+arTiB7/cTGUoXo/XRtH3sRHAhV8u4R/DUbFc=;
	b=F+xQAbxXFy6it+27rbGp6HR1Bh8S9gL2Xb14aPkt2MEnX0qb770Rh1ZmWLOPoPqC42TA
	 OhpnLHpZfaXWzGRGODspRTf2vxdeyIn4wCmkbyeUhfh97FO3mYsfltYZ8DOBLffFz6Es4
	 N8SslungINdtIuffPCuPmicgBHe00Mg8vHz2VbnH/aec3WTkTvjZ1G72KzfVVt/09iBKn
	 FfqnJhWWJWd5OCqHROuBfmsuE6i4GYsV0MO96x1Zh/SI0zIsR3/OZEawxi5kp+BYK4b/J
	 bH905bpvON5pqhW66jel78O3WFDXj5TL3FtGVAZPDs4xffybj9gALdxtAOWbd7qYH1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=omGGguMY;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IKUbLALy;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52623606A330
	for <linux-mmc@vger.kernel.org>; Fri,  6 Nov 2026 10:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52623606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=omGGguMY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IKUbLALy
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6APSDf114862
	for <linux-mmc@vger.kernel.org>; Fri, 6 Nov 2026 10:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DyCrYP+arTiB7/cTGUoXo/XRtH3sRHAhV8u4R/DUbFc=; b=omGGguMYBzrdrvVJ
	5zcf4qQbl9gCkqfimWau9b9I1VlUde5wnumfSOFHdFEcCUWE0aiGB80nRN9eEX7q
	r7I7N4Xfo9VQzxez1VLnh4+6U5Hw039O3YxO/zNEMvcVGEiSvlfFL25t2ZJbsLPZ
	QNDUcL3vbhzkAA8bEXk2LkiD8Cry1Gdu+1nNcpens8NiEZ+gvIjEvNHNIR4Rb0EJ
	ZUfdiHnOi6kJ0tnPf3eqIrjcrRNH5pYANDkr8gd/DktvBKqTBjYlb6w4C/G0EuZQ
	fhStuxFU7HIYnpuortIGrh7h6mbZhPX6buB3oMTLnhWT3+7UZD9ZpaHlSDL7uEnp
	hIcKMA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3patcpr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 06 Nov 2026 10:38:11 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2eb362d1f5eso6814945ad.2
        for <linux-mmc@vger.kernel.org>; Fri, 06 Nov 2026 02:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793961491; x=1794566291; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DyCrYP+arTiB7/cTGUoXo/XRtH3sRHAhV8u4R/DUbFc=;
        b=IKUbLALyIGrl3JckBA0FiFYs4fH6Ad+IJ08GJAYNZVxH8UVO+lo0ZYZt+pf0AMVQoz
         eSJaYPZGhdMexy/PUF1bUpXHn32xYtfu7q2ghr5Ok3G1Jr2diM4LSdWn6oFByrjVE22O
         8GJrP49kBq5+e48cz2dXtp66WBJIDXWtF5SSWCGWG9yjrrD4UVl9TewfvRV0Kb57MV+K
         t8pJuz5HKud9DQfcQ/E757XRU/sLymIhOAVkFOfMVDh2bKEO3HUDLf03qlIjegyACKce
         9CtqBTubNddFFSbJC7Mnrd8o5UG7gdRFyO2w4ryBne0PXXa22Y/jz7HnZLoL35Rs1gZH
         s1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793961491; x=1794566291;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DyCrYP+arTiB7/cTGUoXo/XRtH3sRHAhV8u4R/DUbFc=;
        b=FHlKasTsWCZoafNflUuy2He8os0DlhNN6v5WXsOgGkwWyMAj1Fcwyf/4fcmwHHMNcR
         Mmmie2djLytMtE2Ie8m2sWPDxMdGEbtgAKD6Nl9yNZ4m+GDLb810z41RoQrkOOzrXEnL
         oCWc6MDlxHrft7/4Stbi9sFV09mC9F1zAFOINzGQpKAA2ruEp3Zz1ae6EdrA1lSQR+j0
         f1UFRiO8jI+p2skdj9tAJwp9xUnZfQXWvp6MH1wSDm/PiwVPaQTyp1FUe6rmh9hfUlNf
         zoeu4mPH6rf0Z2vHm/kxx3t/bvnnMUxBqhvS2+EJfFFOkpm5yIl8saGxsCOWW5Zkyx+h
         P5xg==
X-Forwarded-Encrypted: i=1; AL+hErFE/NIXfrLoNbaYxXrKKt8xYjwKL9xGWWJGMHXzZW/Bx41BVr45pTtSwFdyUTHoUmQEO83N6ZZl9U0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NRcC5/4e4/m7MKfVZEZOZhKEhYbLWCT1H+1mIaICfawexJ2LE
	cIdJ12p/AjF1T9Y2lRlsuXzfUrTcc8EFqlywV0FPXXvgcAzs+H+0pQPKBKACJCJ7l+M2wWqTaCm
	Pft1zN1G3HzPq2ra+lYlyZJ4eYx15/BsSrdvEbS0J0pLPZ2onvYVr/7eRcBtnbuY=
X-Gm-Gg: AYBFou0twKX0tXU5FVdg4g1YqvpaTMRaTXeDS0Kxz0VlQE/AypjuY4PJo0pF3McKc/l
	kkaN3xD5+fifaOCRsUKg1bSZjP4gZPC+5pFJQzB2FSb7JzwbaB1cTb5sVUWsDkg+TKeFYTrWJKI
	Dy9eVpSzd+3n6j/FdbhCabcoEE22EmXUNlvYDVvlH4/ktEqoEp3fcoc+TrvAxJTiiuuihI624LW
	MoCPmq+F67Wff7SphTKlCX2i7kjRcaSzkUE5u9Jo5tZmgy/F/oYwffxS2OuGjAIzPJYpmKIJhN/
	mqkVwja/yKJylnUKEyFCVvO66bRXuUb2/a+CCWAfL4WRDuxsVBoWPv5lQlgBtgfwHWEWaJqHnZu
	flFKyGbWl5uSBJflLEXzKShhi04caqJXTVzZzNh5sbGYDGqZDP1Sps10rMcsnc6makZv1A2457g
	==
X-Received: by 2002:a17:90b:2d0d:b0:3a8:1943:cb7a with SMTP id 98e67ed59e1d1-3b0db6d45camr2003521a91.18.1793961490736;
        Fri, 06 Nov 2026 02:38:10 -0800 (PST)
X-Received: by 2002:a17:90b:2d0d:b0:3a8:1943:cb7a with SMTP id 98e67ed59e1d1-3b0db6d45camr2003491a91.18.1793961490106;
        Fri, 06 Nov 2026 02:38:10 -0800 (PST)
Received: from [10.217.219.8] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b3280378sm7235684a91.12.2026.11.06.02.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 02:38:09 -0800 (PST)
Message-ID: <67f05266-77ea-4018-bb0a-e877e288f9da@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 16:08:04 +0530
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mmc: sdhci-msm: Add support for firmware-managed
 resource platforms
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shazad Hussain <shazad.hussain@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Nitin Rawat <nitin.rawat@oss.qualcomm.com>,
        Ram Gupta <ram.gupta@oss.qualcomm.com>
References: <20261102-sdcc_scmi-v1-0-244dbd893051@oss.qualcomm.com>
 <20261102-sdcc_scmi-v1-2-244dbd893051@oss.qualcomm.com>
 <afa7f2f6-17f3-468a-a7c8-4b1b7840bde8@intel.com>
Content-Language: en-US
From: Anjana Hari <anjana.hari@oss.qualcomm.com>
In-Reply-To: <afa7f2f6-17f3-468a-a7c8-4b1b7840bde8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA0MiBTYWx0ZWRfX4THI8f6bh0n4
 xixxa4p6L0UDxeavCcSY1ezlcBTLDzyhIy3+DlihdKH/gWyTrJkMikGsTfXw3L45TXeC1YecDwS
 dzM8gQxmCyhmpynC2bfwOONLwNtDGKBQaIcA05d6VTsTroNppd3jd8G1ettCoJxTzwFAUprAWle
 8mawlIAmk7C2OVJ4i0KDfU5TH5B8nplQdPfCT0053O+6l90KmzIe4UlcGqdXOwGGNnfp/64KsyI
 6duyvgdmVUlZbRqnS8HFAbcsLQMsYuKmZn8z1ZPxplKxpaMoBxta4h3Pi+Y7hPu0jp5T7GheztO
 wrJseyErINrrLxrxk1xf5dTIajmN0XyxvX6suMuicPi3HzVTME3C0/HAV43sfNXLlPO71IpSbJq
 gtkAQ/Ueq/m8PMTGIc1LuYuNBFMQ7U5ffT3Cds88qj2cFTPJ37qtukyHIvhKCCI1Te6zjaleYyG
 OJGD2ysChL2EhJyqEiQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA0MiBTYWx0ZWRfX6RiJSmyCGfLW
 I2rj1fYc+DQs53AKAkwq0gmhizXerFDkOgn+h1oipW8+8hIz5HGixMBFrNKTWyOVQynLtRBac0h
 RRy7fUL/pEhYGbW7TMy/EGH20X7H2aE=
X-Proofpoint-GUID: y__KN1S1qNkbii63Vly10Hu94uae-XRj
X-Authority-Analysis: v=2.4 cv=P4ivFSAu c=1 sm=1 tr=0 ts=6aedae14 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=6dTfJ8FaPMCXR5VNEZwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: y__KN1S1qNkbii63Vly10Hu94uae-XRj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060042



On 11/4/2026 5:32 PM, Adrian Hunter wrote:
> On 02/11/2026 16:03, Anjana Hari wrote:
>> On certain Qualcomm automotive SoCs such as Nord, platform resources
>> including clocks, interconnect bandwidth, resets, and regulators are
>> owned and managed by firmware rather than directly by Linux. The
>> firmware abstracts these resources behind logical power domains and
>> exposes control through the SCMI power protocol.
>>
>> Introduce a firmware-managed variant of the sdhci-msm driver that
>> operates through this abstraction instead of directly programming GCC
>> clocks and PMIC regulators.
>>
>> The firmware-managed model uses two logical power domains, attached at
>> probe time via dev_pm_domain_attach_list():
>>
>>    - "power" domain: governs SDCC rail power state. It is activated at
>>      probe and released at remove via pm_runtime_resume_and_get() and
>>      pm_runtime_put_sync() on the domain device. These calls are
>>      translated by the SCMI power protocol into firmware power-state
>>      requests.
>>
>>    - "perf" domain: the SCMI perf domain driver populates OPPs at probe
>>      time by querying the firmware-reported performance levels via
>>      perf_ops->device_opps_add(). Clock rate selection uses
>>      dev_pm_opp_find_freq_floor() to locate the nearest OPP at or below
>>      the requested frequency, then dev_pm_opp_set_opp() to apply it,
>>      rather than directly programming the GCC clock tree.
>>
>> A new variant sdhci_msm_fw_v5_var is introduced with the compatible
>> string "qcom,nord-sdhci". Detection is automatic at probe: a non-NULL
>> pd_data.pd_names in the variant descriptor marks the platform as
>> firmware-managed, causing probe to select firmware-specific platform
>> data (sdhci_msm_fw_pdata) and ops (sdhci_msm_fw_ops).
>>
>> The firmware-managed ops provide:
>>    - sdhci_msm_fw_get_max_clock: queries the perf domain OPP table
>>      using dev_pm_opp_find_freq_floor() at ULONG_MAX to discover the
>>      maximum supported frequency, replacing the direct GCC readout.
>>    - sdhci_msm_fw_set_clock: routes clock rate programming through the
>>      perf domain OPP path, reusing the existing bus-mode multiplier
>>      logic to derive the target rate.
>>
>> Suspend and resume sequences bypass local clock and regulator management
>> for firmware-managed platforms, as firmware handles those transitions
>> autonomously in response to SCMI power-state transitions from the
>> runtime PM framework.
>>
>> Co-developed by: Shazad Hussain <shazad.hussain@oss.qualcomm.com>
>> Signed-off-by: Shazad Hussain <shazad.hussain@oss.qualcomm.com>
>> Signed-off-by: Anjana Hari <anjana.hari@oss.qualcomm.com>
> 
> Doesn't compile:
> 
> drivers/mmc/host/sdhci-msm.c: In function ‘sdhci_msm_probe’:
> drivers/mmc/host/sdhci-msm.c:3105:1: error: label ‘fw_detach’ defined but not used [-Werror=unused-label]
>   3105 | fw_detach:
>        | ^~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Please check other Sashiko issues also:
> 
> 	https://sashiko.dev/#/patchset/20261102-sdcc_scmi-v1-0-244dbd893051%40oss.qualcomm.com?part=2
> 
Acked, will address in the upcoming v2 commit.>> ---
>>   drivers/mmc/host/sdhci-msm.c | 213 ++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 208 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index aecd425bf095..da52a45203a5 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -8,8 +8,9 @@
>>   #include <linux/module.h>
>>   #include <linux/delay.h>
>>   #include <linux/mmc/mmc.h>
>> -#include <linux/pm_runtime.h>
>> +#include <linux/pm_domain.h>
>>   #include <linux/pm_opp.h>
>> +#include <linux/pm_runtime.h>
>>   #include <linux/slab.h>
>>   #include <linux/iopoll.h>
>>   #include <linux/regulator/consumer.h>
>> @@ -168,6 +169,9 @@
>>   #define ICE_HCI_PARAM_CCI	GENMASK(7, 0)
>>   #define ICE_HCI_PARAM_CE	GENMASK(8, 8)
>>   
>> +#define DOMAIN_IDX_POWER	0
>> +#define DOMAIN_IDX_PERF		1
>> +
>>   struct sdhci_msm_offset {
>>   	u32 core_hc_mode;
>>   	u32 core_mci_data_cnt;
>> @@ -275,6 +279,11 @@ struct sdhci_msm_variant_info {
>>   	bool restore_dll_config;
>>   	const struct sdhci_msm_variant_ops *var_ops;
>>   	const struct sdhci_msm_offset *offset;
>> +	/*
>> +	 * pd_names != NULL marks this variant as firmware managed;
>> +	 * see fw_managed detection in sdhci_msm_probe().
>> +	 */
>> +	const struct dev_pm_domain_attach_data pd_data;
>>   };
>>   
>>   struct sdhci_msm_host {
>> @@ -285,6 +294,7 @@ struct sdhci_msm_host {
>>   	struct clk *xo_clk;	/* TCXO clk needed for FLL feature of cm_dll*/
>>   	/* core, iface, cal and sleep clocks */
>>   	struct clk_bulk_data bulk_clks[4];
>> +	struct dev_pm_domain_list *pd_list;
>>   #ifdef CONFIG_MMC_CRYPTO
>>   	struct qcom_ice *ice;
>>   #endif
>> @@ -302,6 +312,7 @@ struct sdhci_msm_host {
>>   	u32 caps_0;
>>   	bool mci_removed;
>>   	bool restore_dll_config;
>> +	bool fw_managed;
>>   	const struct sdhci_msm_variant_ops *var_ops;
>>   	const struct sdhci_msm_offset *offset;
>>   	bool use_cdr;
>> @@ -414,6 +425,45 @@ static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
>>   		 mmc_hostname(host->mmc), achieved_rate, timing);
>>   }
>>   
>> +static int msm_fw_set_clock_rate_for_bus_mode(struct sdhci_host *host,
>> +					      unsigned int clock)
>> +{
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>> +	struct device *dev = mmc_dev(host->mmc);
>> +	struct dev_pm_opp *opp;
>> +	struct device *perf_dev;
>> +	struct mmc_ios ios = host->mmc->ios;
>> +	unsigned long clock_long = (unsigned long)clock;
>> +	unsigned long desired_rate;
>> +	unsigned int mult;
>> +	int ret;
>> +
>> +	perf_dev = msm_host->pd_list->pd_devs[DOMAIN_IDX_PERF];
>> +
>> +	mult = msm_get_clock_mult_for_bus_mode(host, clock, ios.timing);
>> +	desired_rate = clock_long * mult;
>> +
>> +	/* Find the nearest OPP at or below the requested frequency. */
>> +	opp = dev_pm_opp_find_freq_floor(perf_dev, &desired_rate);
>> +	if (IS_ERR(opp)) {
>> +		dev_err(dev, "Failed to find OPP for freq %lu: %pe\n", clock_long, opp);
>> +		return PTR_ERR(opp);
>> +	}
>> +
>> +	ret = dev_pm_opp_set_opp(perf_dev, opp);
>> +	dev_pm_opp_put(opp);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to set OPP for freq %lu: %d\n", clock_long, ret);
>> +		return ret;
>> +	}
>> +
>> +	/* desired_rate was rounded down by find_freq_floor to the actual OPP rate. */
>> +	host->mmc->actual_clock = mult ? desired_rate / mult : desired_rate;
>> +	msm_host->clk_rate = desired_rate;
>> +	return 0;
>> +}
>> +
>>   /* Platform specific tuning */
>>   static inline int msm_dll_poll_ck_out_en(struct sdhci_host *host, u8 poll)
>>   {
>> @@ -1253,7 +1303,10 @@ static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>   	 */
>>   	if (host->flags & SDHCI_HS400_TUNING) {
>>   		sdhci_msm_hc_select_mode(host);
>> -		msm_set_clock_rate_for_bus_mode(host, ios.clock, ios.timing);
>> +		if (msm_host->fw_managed)
>> +			msm_fw_set_clock_rate_for_bus_mode(host, ios.clock);
>> +		else
>> +			msm_set_clock_rate_for_bus_mode(host, ios.clock, ios.timing);
>>   		host->flags &= ~SDHCI_HS400_TUNING;
>>   	}
>>   
>> @@ -1847,6 +1900,28 @@ static unsigned int sdhci_msm_get_min_clock(struct sdhci_host *host)
>>   	return SDHCI_MSM_MIN_CLOCK;
>>   }
>>   
>> +static unsigned int sdhci_msm_fw_get_max_clock(struct sdhci_host *host)
>> +{
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>> +	unsigned long max_freq = ULONG_MAX;
>> +	struct dev_pm_opp *opp;
>> +	struct device *perf_dev;
>> +	struct device *dev = mmc_dev(host->mmc);
>> +
>> +	perf_dev = msm_host->pd_list->pd_devs[DOMAIN_IDX_PERF];
>> +
>> +	opp = dev_pm_opp_find_freq_floor(perf_dev, &max_freq);
>> +	if (IS_ERR(opp)) {
>> +		dev_err(dev, "Failed to find opp for freq %lu\n", max_freq);
>> +		return SDHCI_MSM_MIN_CLOCK;
>> +	}
>> +
>> +	dev_pm_opp_put(opp);
>> +
>> +	return max_freq;
>> +}
>> +
>>   /*
>>    * __sdhci_msm_set_clock - sdhci_msm clock control.
>>    *
>> @@ -1892,6 +1967,40 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>>   	__sdhci_msm_set_clock(host, clock);
>>   }
>>   
>> +static void sdhci_msm_fw_set_clock(struct sdhci_host *host, unsigned int clock)
>> +{
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>> +
>> +	if (!clock) {
>> +		host->mmc->actual_clock = 0;
>> +		msm_host->clk_rate = 0;
>> +		goto out;
>> +	}
>> +
>> +	sdhci_msm_hc_select_mode(host);
>> +
>> +	if (msm_fw_set_clock_rate_for_bus_mode(host, clock))
>> +		return;
>> +out:
>> +	__sdhci_msm_set_clock(host, clock);
>> +}
>> +
>> +static int sdhci_msm_fw_power_state(struct device *dev, bool power_on)
>> +{
>> +	struct sdhci_host *host = dev_get_drvdata(dev);
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>> +	struct device *pwr_dev;
>> +
>> +	pwr_dev = msm_host->pd_list->pd_devs[DOMAIN_IDX_POWER];
>> +
>> +	if (power_on)
>> +		return pm_runtime_resume_and_get(pwr_dev);
>> +	else
>> +		return pm_runtime_put_sync(pwr_dev);
>> +}
>> +
>>   /*****************************************************************************\
>>    *                                                                           *
>>    * Inline Crypto Engine (ICE) support                                        *
>> @@ -2550,6 +2659,17 @@ static const struct sdhci_msm_variant_info sdhci_msm_v5_var = {
>>   	.offset = &sdhci_msm_v5_offset,
>>   };
>>   
>> +static const struct sdhci_msm_variant_info sdhci_msm_fw_v5_var = {
>> +	.mci_removed = true,
>> +	.var_ops = &v5_var_ops,
>> +	.offset = &sdhci_msm_v5_offset,
>> +	.pd_data = {
>> +		.pd_flags = PD_FLAG_DEV_LINK_ON,
>> +		.pd_names = (const char * []) { "power", "perf" },
>> +		.num_pd_names = 2,
>> +	},
>> +};
>> +
>>   static const struct sdhci_msm_variant_info sdm845_sdhci_var = {
>>   	.mci_removed = true,
>>   	.restore_dll_config = true,
>> @@ -2566,6 +2686,7 @@ static const struct of_device_id sdhci_msm_dt_match[] = {
>>   	{.compatible = "qcom,sdhci-msm-v5", .data = &sdhci_msm_v5_var},
>>   	{.compatible = "qcom,sdm670-sdhci", .data = &sdm845_sdhci_var},
>>   	{.compatible = "qcom,sdm845-sdhci", .data = &sdm845_sdhci_var},
>> +	{.compatible = "qcom,nord-sdhci", .data = &sdhci_msm_fw_v5_var},
>>   	{.compatible = "qcom,sc7180-sdhci", .data = &sdm845_sdhci_var},
>>   	{},
>>   };
>> @@ -2587,6 +2708,21 @@ static const struct sdhci_ops sdhci_msm_ops = {
>>   	.set_timeout = sdhci_msm_set_timeout,
>>   };
>>   
>> +static const struct sdhci_ops sdhci_msm_fw_ops = {
>> +	.reset = sdhci_and_cqhci_reset,
>> +	.set_clock = sdhci_msm_fw_set_clock,
>> +	.get_min_clock = sdhci_msm_get_min_clock,
>> +	.get_max_clock = sdhci_msm_fw_get_max_clock,
>> +	.set_bus_width = sdhci_set_bus_width,
>> +	.set_uhs_signaling = sdhci_msm_set_uhs_signaling,
>> +	.write_w = sdhci_msm_writew,
>> +	.write_b = sdhci_msm_writeb,
>> +	.irq	= sdhci_msm_cqe_irq,
>> +	.dump_vendor_regs = sdhci_msm_dump_vendor_regs,
>> +	.set_power = sdhci_set_power_noreg,
>> +	.set_timeout = sdhci_msm_set_timeout,
>> +};
>> +
>>   static const struct sdhci_pltfm_data sdhci_msm_pdata = {
>>   	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
>>   		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
>> @@ -2597,6 +2733,16 @@ static const struct sdhci_pltfm_data sdhci_msm_pdata = {
>>   	.ops = &sdhci_msm_ops,
>>   };
>>   
>> +static const struct sdhci_pltfm_data sdhci_msm_fw_pdata = {
>> +	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
>> +		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
>> +		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
>> +		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
>> +
>> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>> +	.ops = &sdhci_msm_fw_ops,
>> +};
>> +
>>   static inline void sdhci_msm_get_of_property(struct platform_device *pdev,
>>   		struct sdhci_host *host)
>>   {
>> @@ -2665,8 +2811,21 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>   	const struct sdhci_msm_offset *msm_offset;
>>   	const struct sdhci_msm_variant_info *var_info;
>>   	struct device_node *node = pdev->dev.of_node;
>> +	bool fw_managed;
>>   
>> -	host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata, sizeof(*msm_host));
>> +	var_info = of_device_get_match_data(&pdev->dev);
>> +	if (!var_info)
>> +		return -ENODEV;
>> +	fw_managed = !!var_info->pd_data.pd_names;
>> +
>> +	/*
>> +	 * Based on variant info, differentiate platform initialization
>> +	 * for local and remote managed resource platforms.
>> +	 */
>> +	if (fw_managed)
>> +		host = sdhci_pltfm_init(pdev, &sdhci_msm_fw_pdata, sizeof(*msm_host));
>> +	else
>> +		host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata, sizeof(*msm_host));
>>   	if (IS_ERR(host))
>>   		return PTR_ERR(host);
>>   
>> @@ -2684,12 +2843,11 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>   	 * Based on the compatible string, load the required msm host info from
>>   	 * the data associated with the version info.
>>   	 */
>> -	var_info = of_device_get_match_data(&pdev->dev);
>> -
>>   	msm_host->mci_removed = var_info->mci_removed;
>>   	msm_host->restore_dll_config = var_info->restore_dll_config;
>>   	msm_host->var_ops = var_info->var_ops;
>>   	msm_host->offset = var_info->offset;
>> +	msm_host->fw_managed = fw_managed;
>>   
>>   	msm_offset = msm_host->offset;
>>   
>> @@ -2698,6 +2856,32 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>   
>>   	msm_host->saved_tuning_phase = INVALID_TUNING_PHASE;
>>   
>> +	if (msm_host->fw_managed) {
>> +		ret = dev_pm_domain_attach_list(&pdev->dev, &var_info->pd_data,
>> +						&msm_host->pd_list);
>> +		if (ret < 0)
>> +			return dev_err_probe(&pdev->dev, ret,
>> +					     "Failed to attach power domains\n");
>> +
>> +		if (ret != var_info->pd_data.num_pd_names)
>> +			return dev_err_probe(&pdev->dev, -ENODEV,
>> +					     "Expected %d power domains, got %d\n",
>> +					     var_info->pd_data.num_pd_names, ret);
>> +
>> +		ret = sdhci_msm_fw_power_state(&pdev->dev, true);
>> +		if (ret) {
>> +			dev_pm_domain_detach_list(msm_host->pd_list);
>> +			return dev_err_probe(&pdev->dev, ret,
>> +					     "Failed to power on domain\n");
>> +		}
>> +
>> +		/*
>> +		 * Skip initializing clocks, regulators and reset in kernel
>> +		 * for firmware managed platforms.
>> +		 */
>> +		goto skip_resource_init;
>> +	}
>> +
>>   	ret = sdhci_msm_gcc_reset(&pdev->dev, host);
>>   	if (ret)
>>   		return ret;
>> @@ -2786,6 +2970,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>   		}
>>   	}
>>   
>> +skip_resource_init:
>>   	/* Reset the vendor spec register to power on reset state */
>>   	writel_relaxed(CORE_VENDOR_SPEC_POR_VAL,
>>   			host->ioaddr + msm_offset->core_vendor_spec);
>> @@ -2917,6 +3102,12 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>   bus_clk_disable:
>>   	if (!IS_ERR(msm_host->bus_clk))
>>   		clk_disable_unprepare(msm_host->bus_clk);
>> +fw_detach:
>> +	if (msm_host->fw_managed) {
>> +		sdhci_msm_fw_power_state(&pdev->dev, false);
>> +		dev_pm_domain_detach_list(msm_host->pd_list);
>> +		msm_host->pd_list = NULL;
>> +	}
>>   	return ret;
>>   }
>>   
>> @@ -2930,6 +3121,12 @@ static void sdhci_msm_remove(struct platform_device *pdev)
>>   
>>   	sdhci_remove_host(host, dead);
>>   
>> +	if (msm_host->fw_managed) {
>> +		sdhci_msm_fw_power_state(&pdev->dev, false);
>> +		dev_pm_domain_detach_list(msm_host->pd_list);
>> +		msm_host->pd_list = NULL;
>> +	}
>> +
>>   	pm_runtime_get_sync(&pdev->dev);
>>   	pm_runtime_disable(&pdev->dev);
>>   	pm_runtime_put_noidle(&pdev->dev);
>> @@ -2947,6 +3144,9 @@ static int sdhci_msm_runtime_suspend(struct device *dev)
>>   	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>>   	unsigned long flags;
>>   
>> +	if (msm_host->fw_managed)
>> +		return sdhci_msm_fw_power_state(dev, false);
>> +
>>   	spin_lock_irqsave(&host->lock, flags);
>>   	host->runtime_suspended = true;
>>   	spin_unlock_irqrestore(&host->lock, flags);
>> @@ -2967,6 +3167,9 @@ static int sdhci_msm_runtime_resume(struct device *dev)
>>   	unsigned long flags;
>>   	int ret;
>>   
>> +	if (msm_host->fw_managed)
>> +		return sdhci_msm_fw_power_state(dev, true);
>> +
>>   	ret = clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
>>   				       msm_host->bulk_clks);
>>   	if (ret)
>>
> 

