Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794400677;
	b=q5GR4l7iIj2Fnn9q/1qgnVmd21bHCtGqtUvhtW2CTribAvak7nMj02oaxkG+jDYY5Uus
	 Fcl9H6LIlkPPUlY7u76slV7y7qVHbYioIdzCgJ0mtxbvqKdvOSfUXXFqiNMLmKNagjmOS
	 dto9u3nEokHMJWgaH8SpmaKw8EkeSMo+i0vlWNKbBVDQ39bcguQmT/9fWubkAoaRFEWLe
	 hFECVwzqZioU9T4QLYSGbdfIRN5pvqnVPyv0FRgJWE8k99+oFUlfS0NPdBEaakKFAuZQt
	 6u8bqkFTL7PKR3KpMIXCmguaMmOK1JEHMSYUq6nxg3xMvk2N8I/RtPS7Jj8LsSMnr6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400677;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Gul0DZZy2os3Oi+7MpRNBs1ymdpKQ0Ark8+uU45of0k=;
	b=h2UbooMyaZq5kSQwDxTQEaznacGBL9hp5zBRdvclfPc7xY9VemWfBZrazb93BnzzsNCD
	 qpK3aNfMj42nmuBSHCZ0TXzIFCT+3LYS9wCGNRORvH3S6TgjOc4l50RljQMAp3vYOKnSM
	 mIxcX2XbSPztJ8EfrgvLdxlkb8LY+rLuqWArKYeGaMkNKJspIH11+eCjA4KklbBBB5jvL
	 4kREEKVyZx5RAgOmeH+kZ9CbW+Wj4XBCHep5ADPYlyQkL4yajMLDl0aA9DxSLF4HOzI2p
	 Bg00//RM3wil5rwBeAvaiZrefka57542NC0hVa/bSwDYw8IDYT0QtbCH+RMsxuC5jlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ObCDNI7m;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d8SCx8aw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A17606A332
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 12:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4A17606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ObCDNI7m;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d8SCx8aw
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCZMjQ708112
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 12:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gul0DZZy2os3Oi+7MpRNBs1ymdpKQ0Ark8+uU45of0k=; b=ObCDNI7mu00vdBlM
	BdBftEbOXb0MFSAzbf38IabYbXVhCYnZv+YNaCYl7C4Q7AS/dDd5M3CswUF/aHGz
	OAIQ1Nh/zwCm4VIaM1tK9AidZpylVdpLwsvEkGHcUB6ceKGi/JvBnZ4fqZyQ+Mar
	iuCNDgxdNDWqL3Fmm3k+67gBLEvrriB5uKBnhPxJ+6rLV1b3mIJxe1Mbf6F5cS0j
	M424PRdc8UuxPAcrq/2q35bmVPUVqcYr6AlcR7A9kOlxmK+Ip9zCPrJ93BSkSEBp
	48JKJbHtDL0vSEiX4oRyWJxON+Vu/kFzSqLBAj/dzc5PQhQ5IGHpj7nuEv32lYYH
	BmRZ0Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv9b33hc6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 12:37:55 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3aed37745bcso2357570a91.1
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 04:37:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794400675; cv=none;
        d=google.com; s=arc-20260327;
        b=Nr8emZ9ZSsjaIQRo1k4HSXE7xju17CoWMGTz5Rk6SwXmxKEFDeRevtNrPddIyfWumP
         giKCXy69qJXIZ+/VH4L8LHmlKCQ/xAV9uTlMK3QmUF9mKttbC+IoArqfnh3l+7jCFkzm
         Yl2aaztIOVjrzE/OoYQ5eh0y56vhmiEPlia9+KVvM02mqS5gn34s/iJyxx7Feqb/3DcW
         /6BjThrKWqMvD8qCcKYvobp7Enp0d4QJ0DymIlE3cOPuVpj2vNO7Y3QZLa3Tq169Rz1G
         K632uxI7JIxjEXdgjabaUzdRv5aBtyNuBv8cWQmziP3oJL38F/XnN3EsHRpwMv/b+HbM
         tcBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gul0DZZy2os3Oi+7MpRNBs1ymdpKQ0Ark8+uU45of0k=;
        fh=gjPedHVe+7TFFd3LmPWXDKbDQEYoFivl2O5YOh2duvI=;
        b=HBLp2PpCITUkesIuqxjMA4TMH5yheJKgWZrB0KvymQNeA/gyEibx/PSQtp+nwPfIdQ
         sKgW7x0pZZH2LxA1YfbwzxZArzjU2yuvXL+rH6EXrr/SHWGIXssWPmvERiYvI5LXfppE
         yzpHZ2nEf5PsmNnPPHAMcckhl6E3e5pt0PkfgIghaoaL/5e1w/a0yEjpufCVua2QT0cU
         yQlINvcPHlNMIVAPytRWpwQdfuI5Tg2FZIex4Zop+3Oa3sYCULVZYccRKVL0s2LJu8Dg
         hhTQZUkRMKcJXZaUiFenTOYbt1xsjPGw0VNo14grQDWya/0AyuCVAMkPoWH//aApkHaT
         h68A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794400675; x=1795005475; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gul0DZZy2os3Oi+7MpRNBs1ymdpKQ0Ark8+uU45of0k=;
        b=d8SCx8aweQlwQ2YxeaMGmjD5J7/IfmK8T+IN5kjZRKgZPojzsT6xY1gEDFdpg6m2/K
         fLAtMG9oG0JnGrsALGFmjRjj2pBCG+CAKTfzb5eT9i4bS8fNo+EnQEo/gpgF8Tte3CAG
         hPQ9BSWfMu37R+o854ad0wJSj+2os9GQ2OWKL1JpTBHdJUlw6OYyvX/PJZSi5vwsuTd3
         yxFQ/kx8iHWfeKbqvUK+Pg0eEVRrpGhTXkrUS07U1q9bYfy0BKtdLrthVEr1CUlue8sz
         l8IHGRQCU+TxAcXGFd7/1GkSH/TFjVciVgmMd5Y1yCy68aHe8BaOlJTigZ+kCmOgORLR
         d+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794400675; x=1795005475;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gul0DZZy2os3Oi+7MpRNBs1ymdpKQ0Ark8+uU45of0k=;
        b=mKmscserCrrvIdorY30tEDVKgVdec5LpoFg+nx6QYi/eCSNU4fZnvGg1WrFBx7pMvf
         a7k9P5wyvEw/6nI21JMyMupgBlFNzXg9++c1ILFlUIoc0UXy5V9ixlsdGvlWVW06MrAu
         UTLHD8Gzjze3t+c52nh/V7VPoegr+xNFrvWp7cVpT9TTjs8WFr9SlWYQPodm0aWZNZ88
         IxKyYUCZtK3DewlRcz3HrwPwtJgewUBPZ/mbh0Or9sk2qtWc0qZgnT0lJp1hPjenmlKo
         AuZYDjKuQ+Jrqz0uLWyNKPuWIe9FXVhcV89jlMClG/zRDNU0BMvDbo7tYCuMS8n6aaXm
         cs4A==
X-Forwarded-Encrypted: i=1; AL+hErEEr4p4AZhrrwk+fPkCTLZ3zWKytJU3j2DhaKFiLk0n+BDbIVzUG4LJGaPnqXNXXnN4Z159Xr5gCws=@vger.kernel.org
X-Gm-Message-State: APuU4Z9BXbA2qkIG7iSkyatQLiOjGTPZdSub0sDrro9KJVo10XkG8mLu
	3afQFd5/NVycSh3lgxf7VNH0Gh3JHOA23XZHM26DGgewKGVnnrRkhWBSUwM95K405m7uToXRXQX
	j+PfHI97SgUsbJkklb1RS6TGc3MQ3BKr/xYPx9L1PRy4LidNkH2rMkGcKTZhjgb30yurLXFaaFk
	lL5R/PBQj844GaW9b7VZKGutGTBFpvVdpCMsJSlA==
X-Gm-Gg: AYBFou05cTGHLnG5Ufpndo+IRPsrAGpfso0+QF1tJqqjp5EDKr5qvokpa4CCCzb9maA
	Kpst32+am7+1jS70JnN8PNeIH+NRKwaIHMUUmZYz19RyrSFULCoROwCCkKKSwNeMDEiiy4rzzeV
	2ZL+uIlaNvlRFVe0SGahYebG9Rvzspfb6s9XcW2Lt3hFcdG1au43SIpYqFrw==
X-Received: by 2002:a17:90b:51c3:b0:3ac:9ad9:6afe with SMTP id 98e67ed59e1d1-3b182f9d62dmr1558992a91.39.1794400675164;
        Wed, 11 Nov 2026 04:37:55 -0800 (PST)
X-Received: by 2002:a17:90b:51c3:b0:3ac:9ad9:6afe with SMTP id
 98e67ed59e1d1-3b182f9d62dmr1558976a91.39.1794400674641; Wed, 11 Nov 2026
 04:37:54 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028-rzg3l_sdhi-v25-0-57f16691c2ed@bp.renesas.com>
In-Reply-To: <20261028-rzg3l_sdhi-v25-0-57f16691c2ed@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 13:37:43 +0100
X-Gm-Features: AclHuK8o0uVdfxHZAmhvgIoBqg4smXNKTRXKoYRu3--Rc_VHFBtg03dl4JTb9lM
Message-ID: <CAPx+jO-Fv_qnq_ibUP9A4iY7k8d9u4W5D=2PzF+w9oF0NXDDXA@mail.gmail.com>
Subject: Re: [PATCH v25 00/11] Add Renesas RZ/G3L SD/eMMC support
To: Biju Das <biju.das.au@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=GKGdgeNK c=1 sm=1 tr=0 ts=6af461a3 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8 a=F2NunwkvNQPXbRNSDdIA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MCBTYWx0ZWRfX+ofNwHRfjAri
 Bp7qEHsvylsTwJAX4s50VT8APHcSjuUhnx1RSZlbcUtkgHVaYdIuQ68OYU4wr21CgMOtfmddlfq
 WLpK2fhkcKlHfW2XM612pZAxGJs7F8oRQFTkr92/Ij8HO6s+vz6BgOlzSa659bwX2eWZGcVMpHf
 ua2eXOel/Gse8cbgNjzEf/r6g1939qENvsg1EQxA13mMQSjZMSgsrOt7gdifHcrQX7C5pshN99n
 ON4s9e6yjzMhilZ5dismFJ4gMK9KE3RuWuvc6E9tz1x3M7Q6z3M4fu2rPGrmw6aii7aIcQ/V9kc
 YcQnhABhtPmqGy/0gN6G1Zr6/iHR0zTclkTAPIsay60GJbpiJpNbloR5nzc8IXY46knUQCJkldz
 NBRjDGsyFzQbkDduw62bwBdoRUcfkyyw9CCIOSZXLgroNnCYkpVM3jf0sYUetOxhlWSsSsNA5A2
 NEyI4zXI508KPoyq7vg==
X-Proofpoint-GUID: 8dzJyZhfqloY5pYBVL1U8_ht8Z3XloQ4
X-Proofpoint-ORIG-GUID: 8dzJyZhfqloY5pYBVL1U8_ht8Z3XloQ4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MCBTYWx0ZWRfXxfTX9RAkf0M4
 f8CZS4dypTpgAjM/ZesKtjhGflos4JqTzpWez2M1SXurna/EqlvxbBM8VuLk2zogmyRu9pY5Pc+
 sudLseFXWoPig6VwmBoU4NnILkIcQfM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110050

On Wed, Oct 28, 2026 at 1:51=E2=80=AFPM Biju Das <biju.das.au@gmail.com> wr=
ote:
>
> Hi All,
>
> The Renesas RZ/G3L SoC has:
>
> Channel 0 supports SD and eMMC (including HS400/HS400ES).
> Channel 1 supports SD and eMMC (except for HS400).
> Channel 2 supports SD.
>
> The SoC supports a maximum frequency of 150 MHz. The SD0 interface does
> not support IOVS and PWEN in the SDHI register (no internal regulator),
> unlike SD1 and SD2. It has an internal divider for all modes except HS400=
.
> It also has a 2048-bit divider compared to 512 on others. Moreover
> RZ/G3L supports HS400 enhanced strobe mode.
>
> This patch series support all modes except HS400. HS400 support will be
> added later.
>
> This patch series tested on smarc-rz{v2l,g2l,g2lc,g2ul,g3s,g3l,g3e},
> rz{v2h,t2h}-evk and hihope-rz{g2h,g2m,g2n} boards
>
> v24->v25:
>  * Added max-frequency is a required property for SoCs with internal
>    divider.
>  * Retained the tags as the change is trivial.
>  * Restored struct of_default_cfg.
>  * Updated commit description for patch#3,#4,#6,#10 and #11
>  * Dropped initializing clk_mask as it uses the default value.
>  * Added suffix ULL to macro SDHI_CLK_MASK_DEFAULT.
>  * Fixed a very low or zero clock rate from the clock provider that cause=
s
>    an infinite loop in `renesas_sdhi_set_clock` by max operator.
>  * Restored the data type of max_divider from signed int to unsigned int.
>  * Dropped initializing max_divider as it use default value.
>  * Updated mmc->f_min calculation with clk_round_rate().
>  * Updated the comment using "ilog2(max_divider)" instead of "{9,11}".
>  * Dropped initializing clk_div_mask as it use default value.
>  * Updated renesas_sdhi_set_hw_adjustment_delay() with force_clear
>    parameter
>  * Added a comment in renesas_sdhi_execute_tuning() for tuning delay.
>  * In probe, if the SCC registers are not available, it clear the tuning
>    delay flag.
>  * Dropped default masks from struct of_data_rz_g2l.
>  * Dropped renesas_sdhi_is_internal_divider_enabled().
>  * Added a comment about the internal divider in
>    renesas_sdhi_clk_update() and replaced 'clkh_shift =3D 1' with
>    'clkh_shift--'
>  * Moved mmc->f_max to probe() and made it fail if max-frequency is
>    not defined in DT for SoCs with an internal divider.
>  * Updated tmio_mmc_host_probe() to set write32_hook() to NULL if
>    TMIO_MMC_HAS_IDLE_WAIT is not defined.
>  * Added macros RZG3L_SDHI_SCC_HWADJ2_{1_8V,3_3V}
>  * Replaced the quirks sdhi_quirks_rzg3l with sdhi_quirks_fixed_addr.
>  * Added helper renesas_sdhi_sclken() to handle 16-bit and 32-bit access.
>  * Updated renesas_sdhi_set_clock() with max_divider check for
>    TMIO_MMC_INTERNAL_DIVIDER instead of SDHI_MAX_DIVIDER_DEFAULT for
>    consistency with tmio_mmc_reset().

The v25 series applied for next, thanks!

[...]

Kind regards
Uffe
