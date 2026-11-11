Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794400687;
	b=q57luq4oPRZt+E5F3Ccri3qlHqZT9ePNj4+GKOcLgbzlw9soP/D04R9CwK6Uh6ZMqNKc
	 M4dDPMSHsEZ2dBfZ8uQopPjtCyqAUBd5O6o7jTfqXYsg0H4KniHsB6UCqZ+m9vGVVPYFt
	 VLkEnsCIoZzlzD5ZmW8UccoMyNfF4Brlk0rcVDI623hRuutKZO77FnSsNr+o0S6AEZYsJ
	 RFYTojohHlVXbkJsIDrEfdujLzRdLFyNXCpgOxW+Q64FIWgtacsIp9hUlWqkYw3mdPtDL
	 f1PLXakdpx3UBB0i6wainDAPFyjIljZOX2iMImSk/NqBz5gCn3q267M/lrA1GWx8B7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400687;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=OIaaQt//nzIPwn+uOg6pI3Fun/12DBLYeKqfKTTvAPY=;
	b=HPQRb0sHGOgSAp5ITmVTqQPUbzuwP2ib7rHXGLtW05r0tJ8jwU1TYOxYICIBvukfnN/W
	 D+JZGnBQ+8sZDVK5uANjlPv3zT5pdps/5vBXsXNqUxiR4C3BRK5ggmR7ikO0vbZywoJhi
	 rqAWX8zGESS25/L3R40xZtaQgTTUz04BtreWbF4kH7vcvJQd16XRjalLzB0WWLDAil7zt
	 CcsGaZ4QbWKqltt4Ww4a967IpeIiMzBStTaScJn6dHUiWdRE1Jg9JwE4ZnKRGzYvqUzOe
	 AGKFtQ1F0qq4HLXzCDPC1xHik9XXCt6c3h8tZrgI8jsKaDOOJZRD+rcs79oG/Myygtg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AoyWfbND;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MGpdJjvI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19515606A32D
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 12:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19515606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AoyWfbND;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MGpdJjvI
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCZ6TO2338330
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 12:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OIaaQt//nzIPwn+uOg6pI3Fun/12DBLYeKqfKTTvAPY=; b=AoyWfbNDwRALdbLT
	TZq1wnqLj9BihmFW2jTTc3d3Wuzn56HIeR4f/8nKIbHMfyUoM3G05CDGlsHGgE+Y
	9x8J4DeW+BBHAG+irF5HEYS/e+eQPcGoOLibrUsByYlrnVEmX1I/mvFnRA1Dhgik
	vPHfCgjoDf8e2YurRPkJVSogCWMDdHDlK5/5bDkqehzQY89wOW9Uo7+HlIULfKcL
	ko5Ts8WvfRrntpXGcoqf23FNNVn1oSgCQ8IQY1TU0uaBCJWQP2dhD1FTJ5LbBlZg
	qsfrzx0VOZU6ap/7sXocwDrsMR7QSxDR7/V7WYQu7xBS3xzNE20qpQW/4uceMPe4
	uV+VOg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnmakr9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 12:38:05 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cdd4dafdcf3so2684490a12.2
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 04:38:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794400685; cv=none;
        d=google.com; s=arc-20260327;
        b=sathvoy6FWgikZeOE8P554zDgjH9xBDqHry6o7KeKliKs0q300APX/DNbGMa13Ycoj
         5K/RUhNtQ7q+/wazLO/Rk5GRBvcLsWpCb/bB9918kWcpHGYhcZFL/ZMFCJaQVdpC1Tr0
         3A7EWJAcOsM+UNTs/C9qLw39UF9Pj5OdJVuEYQGZbL+vrNxNGMXQBbIa/Jhc3KmesXWc
         PW6OYpqy9sVa+lCaLmMK90o0vIdZnyyxk1Gr2rwO60W6YA9oKWI04uvE11iYfVHzWcl2
         olyD2PqJilJXb73neoZNK+Jg+0Xatd8da3q6EGARnXcJGlM4z/dRnU63SbL7/67oat7a
         7PfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OIaaQt//nzIPwn+uOg6pI3Fun/12DBLYeKqfKTTvAPY=;
        fh=DBSkeBqi6l5bOBDMn3TqXY2eHBvRNwJL1nme6H6fh+Q=;
        b=TucuwIgffGy10ZUl121eNX3R+vS04nNcpeMKCQPWpmbxywqMiLfdd3x8jhoixF5uu8
         GflAO4O5eyOG9uJojvZWMsCtJS7z7mHMkazxS5/ZyaAj8n6aiKKxOfSBhfBUDWb9tbh6
         8aT/4HRlbCKH9pWknImDbV3O7Oe5Lip9lc6qtZfpLXvX2YZddHctiA0oGK4+o4oFXakE
         I8u7UAaTdhcinYcWcXWwT/yIfbx0E+j5trKfgBx9+xqbdggKWhf/JTjg6fjXlDRYRF68
         f29XuPeQLeEwzGOg5azaupnAqpN8TIHVu8onX4Q7oTkkPGzPfDZhOU/49mdwHa/+euB+
         L/9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794400685; x=1795005485; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OIaaQt//nzIPwn+uOg6pI3Fun/12DBLYeKqfKTTvAPY=;
        b=MGpdJjvI6+iL5XNpgB12m0biUKG8V+5dvBTriN7JTnMyLcNoSxYvXWJuzZpFzhWD/8
         jibjjKPnCqzpgfYI82n3IOBT+qBnz8v/Mxh4x3HxiNPMTC6V1uCGJxTfq6M0dkoudxzY
         rpRUriEjJ3cb39L3fnRIqpFBTgP/mCQRqUsVi+wacZomWLe6bb9NCgqHMVSPTAcUSdYm
         T0VT2CME4XbRkaviuuySVlYPyVPNz0ef1siEUfjsuKfyVu9ZNh8UFkb4kEDVYdHnwW7Y
         hAsBS+kAJo2QEKKQaqsfibI+AqTGDlLviHsoHYsyEUbpN/z5CwPYztozWJ+urNLFBoPK
         t5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794400685; x=1795005485;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OIaaQt//nzIPwn+uOg6pI3Fun/12DBLYeKqfKTTvAPY=;
        b=ApwZQ0JLd5RAKnF9XZtebFRheQYFuoy81AcR6TKPZ9lsT6V8b4qoQD/0h7vT+/uohm
         8noW1IGmaOerdChIwvgFr4oUzhkrabxmmJDIGR5Jyi63F00L6WLHhOtnRKrTqoQ8rsy/
         CtMMGndBz8h9non1q9qgf8D6iRbRTSXU4IzsKRKhPbd3OWp2coRKqFM9ka4p3NbUbvkc
         qiF5IQLpleNEwTsh8NYWEE9KGJC6p7xQZnj5b9RJfodItChcLYMRrgoF12k9/TSxD+YK
         x7749nz5goidEosO0gjyps9DUfj+r+urigyYfaaJa4IhWdCKXS6Z+uhMb3a7AKInLQ2B
         viEw==
X-Forwarded-Encrypted: i=1; AL+hErEhdsToCBQxSBRPMVn3r8SX9iCvpf52HYv6HVif2cd+bpSMjcY5V3XOLpiNJxSioaLRn/EYcgo0mP8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+whQx1o0K+sEw6TvyM2ZbBwN79lt4fzBdaC6s4CUXuOw3XnC2B
	ZI/CYhW0tk91knQMJE/G4n7yzDt7qWsjItBcv6Ga4s+DHxKmx8K+QFq+IsiAk6F2MAfL8iTxjQB
	xQOrPmGkmN+j7G7VuYRKzRqvBz4n05IWGVhQFIedGoeBS/Wr5DGvaUBbd5zRyeoU63e3T6XuhGF
	8/b1q24kbl+UZjidN0dphs+twoTwUwPiwcW4J0rQ==
X-Gm-Gg: AYBFou2YynJBayqj8w/kpfcxa/rHyz7whnq2VyRQMhCE5YGpoNMvw+IAeNFZ7y8kvUB
	ejRBzpCNnlAVuuuCIXi43oXSh8k6CZL2w5sHj1ZNm5Z+AfdhVXvcSxA36eJG8lNfIGg8KBXnOTF
	0YfZy4+Tcq0D/R8h04NzJwbtifXNXJlyaUQjidoigP60ibj7ioSv6un9PyXg==
X-Received: by 2002:a17:90a:c2ce:b0:3ac:a139:1b14 with SMTP id 98e67ed59e1d1-3b182f5a137mr2516566a91.57.1794400684819;
        Wed, 11 Nov 2026 04:38:04 -0800 (PST)
X-Received: by 2002:a17:90a:c2ce:b0:3ac:a139:1b14 with SMTP id
 98e67ed59e1d1-3b182f5a137mr2516535a91.57.1794400684292; Wed, 11 Nov 2026
 04:38:04 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103093501.218232-1-paul.cercueil@bootlin.com>
In-Reply-To: <20261103093501.218232-1-paul.cercueil@bootlin.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 13:37:51 +0100
X-Gm-Features: AclHuK-dIsJ_Qoz2l3yI0jjzv4ubhU03owxy-3ZfjQUln--SJ7ACo_U1YirpRGQ
Message-ID: <CAPx+jO8xjpMAv_YQVJWPsBFBM5V-B715vGL40JXGVPWOJ-J5HA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-cadence: enable probing from ACPI
To: Paul Cercueil <paul.cercueil@bootlin.com>
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: sdsoYo9MEP7kERl-RJJfaXArBXEZMDx9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MCBTYWx0ZWRfX9qVuLlXL1tnh
 76oI0FwC0pUBuYDCQCnEtBbUrkHf+we6FULWPJWZSYE5JODJZ+P5DYNrIs9c6Twx+SW1+kJMY6I
 F/HgIh2yFi75SNyOB3nKQ+MOXlv4pfs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MCBTYWx0ZWRfXxDqd0nzH9E83
 4eG+sVaDWVShZtUmsLq2Oz9FusigpEXUMPhmzUb2hfGP2C5i8VO0o75V8kq7LW8gBIdnoptxoFX
 MhCCqyWQ1Avtdbz/TeXrb5eJCU7ce4sQk0CLVCwPaSFEAjeMn0bLOBLVc2bsqOLm3q3z2+E/KhS
 mcnzEm9M31B6Zi8b7Cq/5GmlkTMzbmqZFdMaUPIn73FlpbywIAz41fpKJQo0dw6DFZWybmHz2T5
 kRcSzqt/StnE44ZVnozHVZmvlNL3+emv7jBywMnnnIeo4rzYDIs69Ci6d59QEVmmUiA/WRNqKgG
 KKWjsuxopNCI2FsUO+n2EyVWyDTYXnDfvuW+fpx6tDCXMl3HMXeU/3222KFthhzpI65eSWuMw1A
 4gYSN12+Uz4B4YEY1LiHC3bZ/iRiUvw0olu2wBMTskhsPpc7lBmTKiIPQ4wz2CyO4AQZJHQVBkR
 Qqt/6OJrUBMP6cLQuHA==
X-Proofpoint-GUID: sdsoYo9MEP7kERl-RJJfaXArBXEZMDx9
X-Authority-Analysis: v=2.4 cv=MpzHeGae c=1 sm=1 tr=0 ts=6af461ad cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=P-IC7800AAAA:8 a=YmKbF_H_a6i2MY2qjS4A:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110050

On Tue, Nov 3, 2026 at 10:35=E2=80=AFAM Paul Cercueil <paul.cercueil@bootli=
n.com> wrote:
>
> Use the device property API instead of the OF-specific property API.
> This way, the driver will also probe from ACPI.
>
> Note the change in the core's probe function for SD6HC. We can't have
> named clocks in ACPI.
>
> Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-cadence-core.c   | 22 ++++++++++++----------
>  drivers/mmc/host/sdhci-cadence-phy-v6.c | 10 +++++-----
>  2 files changed, 17 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence-core.c b/drivers/mmc/host/sdh=
ci-cadence-core.c
> index 745455743b01..c5a4fa8e2fc6 100644
> --- a/drivers/mmc/host/sdhci-cadence-core.c
> +++ b/drivers/mmc/host/sdhci-cadence-core.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2026 Altera Corporation
>   */
>
> +#include <linux/acpi.h>
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
>  #include <linux/dma-mapping.h>
> @@ -145,26 +146,26 @@ static int sdhci_cdns4_write_phy_reg(struct sdhci_c=
dns_priv *priv, u8 addr, u8 d
>         return ret;
>  }
>
> -static unsigned int sdhci_cdns4_phy_param_count(struct device_node *np)
> +static unsigned int sdhci_cdns4_phy_param_count(struct device *dev)
>  {
>         unsigned int count =3D 0;
>         int i;
>
>         for (i =3D 0; i < ARRAY_SIZE(sdhci_cdns4_phy_cfgs); i++)
> -               if (of_property_present(np, sdhci_cdns4_phy_cfgs[i].prope=
rty))
> +               if (device_property_present(dev, sdhci_cdns4_phy_cfgs[i].=
property))
>                         count++;
>
>         return count;
>  }
>
> -static void sdhci_cdns4_phy_param_parse(struct device_node *np, struct s=
dhci_cdns4_phy *phy)
> +static void sdhci_cdns4_phy_param_parse(struct device *dev, struct sdhci=
_cdns4_phy *phy)
>  {
>         struct sdhci_cdns4_phy_param *p =3D phy->phy_params;
>         u32 val;
>         int ret, i;
>
>         for (i =3D 0; i < ARRAY_SIZE(sdhci_cdns4_phy_cfgs); i++) {
> -               ret =3D of_property_read_u32(np, sdhci_cdns4_phy_cfgs[i].=
property, &val);
> +               ret =3D device_property_read_u32(dev, sdhci_cdns4_phy_cfg=
s[i].property, &val);
>                 if (ret)
>                         continue;
>
> @@ -204,7 +205,7 @@ static int sdhci_cdns_set_dma_mask(struct sdhci_host =
*host)
>         struct device *dev =3D mmc_dev(host->mmc);
>         int ret;
>
> -       data =3D of_device_get_match_data(dev);
> +       data =3D device_get_match_data(dev);
>         if (!data || !data->dma_mask)
>                 return 0;
>
> @@ -649,13 +650,13 @@ static int sdhci_cdns4_phy_probe(struct platform_de=
vice *pdev, struct sdhci_cdns
>         struct sdhci_cdns4_phy *phy;
>         unsigned int nr_phy_params;
>
> -       nr_phy_params =3D sdhci_cdns4_phy_param_count(dev->of_node);
> +       nr_phy_params =3D sdhci_cdns4_phy_param_count(dev);
>         phy =3D devm_kzalloc(dev, struct_size(phy, phy_params, nr_phy_par=
ams), GFP_KERNEL);
>         if (!phy)
>                 return -ENOMEM;
>
>         phy->nr_phy_params =3D nr_phy_params;
> -       sdhci_cdns4_phy_param_parse(dev->of_node, phy);
> +       sdhci_cdns4_phy_param_parse(dev, phy);
>         priv->phy =3D phy;
>
>         return sdhci_cdns4_phy_init(priv);
> @@ -673,7 +674,8 @@ static int sdhci_cdns_probe(struct platform_device *p=
dev)
>         struct device *dev =3D &pdev->dev;
>         static const u16 version =3D SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHI=
FT;
>
> -       if (of_device_is_compatible(dev->of_node, "cdns,sd6hc")) {
> +       /* Note: ACPI only provides one unnamed clock */
> +       if (!has_acpi_companion(dev) && device_is_compatible(dev, "cdns,s=
d6hc")) {
>                 clk =3D devm_clk_get_enabled(dev, "ciu");
>                 if (IS_ERR(clk))
>                         return dev_err_probe(dev, PTR_ERR(clk), "failed t=
o enable ciu clock\n");
> @@ -687,7 +689,7 @@ static int sdhci_cdns_probe(struct platform_device *p=
dev)
>                         return PTR_ERR(clk);
>         }
>
> -       data =3D of_device_get_match_data(dev);
> +       data =3D device_get_match_data(dev);
>         if (!data)
>                 return dev_err_probe(dev, -EINVAL, "missing platform driv=
er data\n");
>
> @@ -723,7 +725,7 @@ static int sdhci_cdns_probe(struct platform_device *p=
dev)
>          * For SD6HC, sdhci_add_host() will automatically read capabiliti=
es
>          * and version from the host controller registers.
>          */
> -       if (of_device_is_compatible(dev->of_node, "cdns,sd4hc")) {
> +       if (device_is_compatible(dev, "cdns,sd4hc")) {
>                 __sdhci_read_caps(host, &version, NULL, NULL);
>                 ret =3D sdhci_cdns4_phy_probe(pdev, priv);
>                 if (ret)
> diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/host/s=
dhci-cadence-phy-v6.c
> index 22d56bb46d75..551a0e3b58ad 100644
> --- a/drivers/mmc/host/sdhci-cadence-phy-v6.c
> +++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
> @@ -880,17 +880,17 @@ int sdhci_cdns6_phy_probe(struct platform_device *p=
dev, struct sdhci_cdns_priv *
>          * Cadence-recommended defaults (2500 ps IO-cell delays, 24 ps DL=
L
>          * delay element) that are valid for typical SoC packaging.
>          */
> -       ret =3D of_property_read_u32(dev->of_node, "cdns,iocell-input-del=
ay-ps",
> -                                  &phy->iocell_input_delay);
> +       ret =3D device_property_read_u32(dev, "cdns,iocell-input-delay-ps=
",
> +                                      &phy->iocell_input_delay);
>         if (ret)
>                 phy->iocell_input_delay =3D SDHCI_CDNS6_PHY_DEFAULT_IOCEL=
L_DELAY;
>
> -       ret =3D of_property_read_u32(dev->of_node, "cdns,iocell-output-de=
lay-ps",
> -                                  &phy->iocell_output_delay);
> +       ret =3D device_property_read_u32(dev, "cdns,iocell-output-delay-p=
s",
> +                                      &phy->iocell_output_delay);
>         if (ret)
>                 phy->iocell_output_delay =3D SDHCI_CDNS6_PHY_DEFAULT_IOCE=
LL_DELAY;
>
> -       ret =3D of_property_read_u32(dev->of_node, "cdns,delay-element-ps=
", &phy->delay_element);
> +       ret =3D device_property_read_u32(dev, "cdns,delay-element-ps", &p=
hy->delay_element);
>         if (ret) {
>                 phy->delay_element =3D SDHCI_CDNS6_PHY_DEFAULT_DELAY_ELEM=
ENT;
>         } else if (!phy->delay_element) {
> --
> 2.47.3
>
