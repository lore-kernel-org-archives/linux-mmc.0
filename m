Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793207685;
	b=3z5RjneahiiR5ndGgvwOLCOgmrN/gZvANjf8KD+6FuZOuwO4CSGrEY6ZkpjLpLGGtvf2
	 r3elRZjzmgbq8n/J1kw4qgxSNRpCZhFrXt8rCODQFpFdVZRBATwLgrCHOI+ChO1eG7pTY
	 B5NrHHW2AlhZVr4dr9lbET2sUYenObWg30bHAXV4q7EagLxKHAOyPzJIjDHWGhgfIc7Zg
	 q9gvDOVSSP12NRxUsp48JFUtFmkFLFWp0GDpNKwobo909pR1gQWc+OkyMe7PGtNOEAq9U
	 dDzJs3KLnFfJzjtXZqsXNXMLzNrAMiDy3hRSTPGs7jJS3e6XrnnFGvMwwYlwjFrsThA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207685;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=UDp0wgkglTmPmDg1owrhZsr+zbSjJcFONFEn6LtAuCw=;
	b=afvXW/1cfwWHifnNu86obHMhXq8L1VEOVG4eO5HLDR4eq5jPR7xknO1qeQa7nZoaPVCQ
	 tjQy2CjeNmRoCediZ5hWpNQWgZAZsHqhjDHv4U+lZtZxiAOIHuVQKDc40lOsPs8gXGW/g
	 hx7d87PrgR9VMjFF89HdXlcQXm/rcm1E643xDQyEHdMIXXnk/JTlGsYkUymHSAogRKAaj
	 joUyEwrGkQ6azeATAJo/8Ah+VDXQ8dd0nA7F3PMpBHmcCZFfR1CjX+mI7xTb2vz6qSYF8
	 oZnwGsB5Sr3m5rJBeAJsReEegpDigKytV6xHcyUzZ4JN1mcFhUOEhNsGElys9mu5jXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RYGmdgia;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ItWYps3q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6643606A31C
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6643606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RYGmdgia;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ItWYps3q
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFA3EX2568825
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UDp0wgkglTmPmDg1owrhZsr+zbSjJcFONFEn6LtAuCw=; b=RYGmdgia+3ENWT3K
	8+9fUgyk3+OJ48GqrcLUDuwVBC9OSko/LEE1L/7t9RXLVs4tE1UHXsyw9MBM171X
	soVqa+8kcSxMwLw6aKmHKma7nuVbkr09rYqDakq8oZRPuWIyxKPSGBFu0dxAL0Sp
	Ez+h5JedlHpuq2D4MGclYUBV0DaB780wGy2MgucF9vVEALqYzjQuTDrJYQdAGtwE
	m/LPl1MRV//GkFz1jINnl0hZuJ9wxS0OlpbuxTOfDdXF6bnGn5Qv+mtPWkqsGgtn
	38v4cf5wkYahd2NDWLH2klgFk/XgEEWejb0wMkwRzsZUrhukUndRLnjyoFz0wtA8
	PzrMoQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk12pvspx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:14:43 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd652c0385bso819273a12.2
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 10:14:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793207683; cv=none;
        d=google.com; s=arc-20260327;
        b=b/75GBvhKFFwK/4AWexhjGQQ5eqGfo5EIhu5tVZR8Rj8SrRInbJli7WUIK2E2/hAca
         kxCOAYzFwpnfDjOY8+R1ZJT84/05FWAEvevjtRtxHBM1CTgY8UUBiVyV24tfe2jpwHtq
         ldsxU2ZHCXSafs7L0dGJiGzk8YOyKJ6NfjWHJ05RPcqacKgsFbpvCoSdUsBfJ1lKM9SU
         R9v9WeW6brlbwfq2zVJYtoG0N+4cMm/lJnHHDicuO2jLwzcqq8oSwphEctwYl9swyt2u
         NpRIZ9s0h/eHdGFjiVqRQr5okYF3HMn4tfWKaCXboYKsTxaCLrMlYO0R9LY060imk89l
         k5Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UDp0wgkglTmPmDg1owrhZsr+zbSjJcFONFEn6LtAuCw=;
        fh=VfFTdaaHbDemhNfl8cNTAKInoBWlILrJJe4A1yBbLBg=;
        b=qPjCY5Ap/TFvGvXu8GnhfHseLAijbmwCKdgShmgIIJJk4aDXZzhzYK3cnoDuxERCga
         tz2CstoHZxfRCjI14jQfb/kKw6u7Kik6qfmXAFxzoFIu8FNE33nmMDwi/KMfKyuR5XYE
         G2zl+k4KKxcIB+m4UnksNqKcMPL7S10CpGT93erJVR/mpZZJbOV08IVe4VX0Tx37s6OV
         5fs4YAqMPK7bq8oxV1vinLppkAVtNFZkXQUeeVeS4QY+doIUcq4/DA8xqAbuajJs69si
         0I+o4n3SgLXEEcuuYErJCaP0DjGyTx92VXz3rskXYn65aVElTKOr8zXfCcpvevV7lEke
         fF2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793207683; x=1793812483; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UDp0wgkglTmPmDg1owrhZsr+zbSjJcFONFEn6LtAuCw=;
        b=ItWYps3qeISaj+0QKytoXeoyep6Hd4pn5F0pyPX5ltoPrLVbYbtoFBMhtaB8nAb+ZW
         6/kzRMD4/0pIFPCS0NbSyMQYtkMHnBPt7NBI2vSbgRP/1nNe2PW+CINN4sjZj9YMgAMM
         1IPz7+611RruaRWGV8TpDYyFQiZORyPZIBEYYPrnJx4HV6WMpffohdc4tJ3JgSjlkJvi
         l3gEDy55CJODaUzSxnfHWugj6zQiJVuhgNwbthIgwe5wyhTinGkrXAUJrvPK4Rcpz5vQ
         2JLGCpYOPZvJza+YNhuOtV8MVaVVnjMt1ttWBHlHEelHs4y6nVMVy/OqaMGemayskbhf
         2jdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207683; x=1793812483;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UDp0wgkglTmPmDg1owrhZsr+zbSjJcFONFEn6LtAuCw=;
        b=0z/qcxj9sq4L1CrF/6su0qdO4qysITOQS9IfKELz+zlRxC0VqRyInu8J5mbpqdXXTe
         ZSAVAFUczQdwUo4wO7PSdb8EWVYJLkbnq64Jo01G9rTI6yo3gYa08QGCojVaTN1otmGD
         N4rMNdcZAphouMsJvsseM4yRbQz89sULmRfJWeTj8rcGCM1DQwWW1CYIJAlyIy7DKQ/O
         oG0Ztbr71M71GBinwQm6z1SNw0OrU3oZqoUvWxvmpmmqNYb8VThMGz3F9AiFpRdhpxFJ
         hoNVHEtinOchpaYp4+YnDVd3r+/OvcDEC8c4DejCYlHGDOdwwJ9gu+vvv61A1p7B0gfx
         6plg==
X-Forwarded-Encrypted: i=1; AKwUvBz5ObWs31YHniG+Mc7KgAKvN1fgUSMr5ZJ9zKggjPHx5rXi9pJNAE3eukgTawaDHpkt5UTPDb8o1Cc=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8qLImByAE1iPTs4dn1YYVS8Y6GIBv9yjxfHDCgoogcFN4g2fh
	YyZunDE9os+GA35hexxGkAMeF36S6+37NiTaD+VJWkbOyJ4QQ1BeRhiY3gRTLREF9JRnbOEtVhm
	ciM/SEPVoz/6iAWELhpzrn0YfGjiGZBUJubRV4nLt+1vIiih+X6owhHpFKnlfBeSroh58av12pk
	TauUidjiUps7cV51oIuFXsS7rS04JPoI3mmJNnBw==
X-Gm-Gg: AYBFou3qeC9110S+mXRNAk4UXitD7QENfaAyNkrWbQNcoFJIGtol9Q+sGT3m+ei2JkR
	etSUdpZCoIZYx3rh3hCXxFF6IPC2tCcbXlnE0kEoxjx3tpLgiJURfrJd0ngCv8S/0SBs1peR5tK
	wx7RCmW62e0tSQK7P9V2F4B0bWaPRUtupdiaoaADgmsw8RJ66I1uVnMJGdRw==
X-Received: by 2002:a17:90a:e7c7:b0:3ac:9a03:20bc with SMTP id 98e67ed59e1d1-3ae5824d380mr2248113a91.47.1793207683163;
        Wed, 28 Oct 2026 10:14:43 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c7:b0:3ac:9a03:20bc with SMTP id
 98e67ed59e1d1-3ae5824d380mr2248076a91.47.1793207682688; Wed, 28 Oct 2026
 10:14:42 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261007070313.863-1-ian.ray@gehealthcare.com>
In-Reply-To: <20261007070313.863-1-ian.ray@gehealthcare.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 18:14:29 +0100
X-Gm-Features: AclHuK8OzKAlNJgB9bkGdb-Xga4FUgj0a3CnfcJYrvb6cJly0UazM3hY7LrTXlM
Message-ID: <CAPx+jO8o3+ca6LE-1DPuiOrxOWVRosuW7rf23SzLAGq4vRHqeg@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sdhci-esdhc-imx: map unsupported driver type to
 Type B
To: Ian Ray <ian.ray@gehealthcare.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Haibo Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>, stable@vger.kernel.org,
        linux-mmc@vger.kernel.org, imx@lists.linux.dev, s32@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Fck7HidmUVKn9RURKoO2w-RtVUxkvDGu
X-Authority-Analysis: v=2.4 cv=DtDDa2/+ c=1 sm=1 tr=0 ts=6ae22d83 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=lb8OlhKpAAAA:8 a=QyXUC8HyAAAA:8
 a=NVfV2Rmm9NVekzJLEn8A:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=7GnFejQYy5TgUzHuXd-m:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfX2VTFTC8sc8G5
 3nWb7MIEr6/R2MAkiTtNQuXANun8fYpKiwZNh49ltLM9L5CS9NST5xnO6zOpaW9lCtr7Q6h3Z//
 x8/Ei+HPbbIMlxBdP/wlY4Dfi5wzj/VYTWQ95jdvdU+CRx7+10XNxoZh/akjn5QZbAeH0zVvkFX
 CFWd4HGU6aGmarqcT+lAXisyhLAX7krZhvAF8M64W4oTqq5zKqsKl6gT6etV7F8lt14FpMREHUS
 4uVMSLOMAM7g1DQCABlslFZwNnIznd/80EYEfFXsiX+pKp1RjOiXzicvDOgYKlMFy2IoaSpJ+EN
 nC73ipmL1nbO9X1Y8pKhxn/P3lT0Jw7TFlf3/MOyk/PWU0PIHnMvI8yy1ZzZkF4MuNjmeR/lHFL
 DNxfNMOP9Esqw7i477jMs9P2mjdALNIPfWmQuKoUaYClZ5ka7HXLtSTdZoCIN+RVZJjOJju0KEW
 QviqGblRVyMsiHr3TZg==
X-Proofpoint-GUID: Fck7HidmUVKn9RURKoO2w-RtVUxkvDGu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfXzkqiIg1yQwib
 oIOSwPKjMVz02SrUfZUABlu92SoRezdr8YSsuLwYPVElc7DwB89uMc1K7EyCwA4c04C6xXc2a+2
 UR3ZV3KJGhY9+OMIj1lUaISWSot3IeM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280068

On Wed, Oct 7, 2026 at 9:03=E2=80=AFAM Ian Ray <ian.ray@gehealthcare.com> w=
rote:
>
> Since commit 5a52c5701a67 ("mmc: core: Fix host controller programming
> for fixed driver type"), the eMMC driver strength is passed directly to
> mmc_set_driver_type(), which propagates the value through ios.drv_type
> all the way to sdhci_set_ios().  For value 4, SDHCI correctly warns:
>
>   mmc2: invalid driver type, default to driver type B
>
> The host driver type has no effect on this controller: esdhc_writew_le()
> never programs the driver-type field of SDHCI_HOST_CONTROL2.  Hook
> set_ios() and force drv_type to the always-valid Type B, so that SDHCI
> never sees an unsupported value.
>
> Tested on i.MX8MP (usdhc3, eMMC in HS400) with
> `fixed-emmc-driver-type =3D <4>`: the warning is gone and the HS_TIMING
> register contains 0x43 as expected.
>
> Fixes: 5a52c5701a67 ("mmc: core: Fix host controller programming for fixe=
d driver type")
> Link: https://lore.kernel.org/all/20260926122908.866-1-ian.ray@gehealthca=
re.com/
> Cc: stable@vger.kernel.org
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> v2 -> v3: Force drv_type to Type B unconditionally;
>           hook set_ios() for all esdhc variants, not only usdhc (since
>           the driver-type field is ignored in all variants);
>           reword comments.
>
> v1 -> v2: Move fix from mmc core to sdhci-esdhc-imx driver per review
>           (see "Link:" above); always provide a valid host driver type.
>
>  drivers/mmc/host/sdhci-esdhc-imx.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-=
esdhc-imx.c
> index 6ab59d3e346f..931e383748a9 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1142,6 +1142,20 @@ static void esdhc_reset_tuning(struct sdhci_host *=
host)
>         }
>  }
>
> +static void sdhci_esdhc_imx_set_ios(struct mmc_host *mmc, struct mmc_ios=
 *ios)
> +{
> +       /*
> +        * This controller has no driver-type control: esdhc_writew_le()
> +        * discards the driver-type field when writing SDHCI_HOST_CONTROL=
2.
> +        * The programmed value is therefore irrelevant, but SDHCI reject=
s
> +        * non-SD values such as 4 (eMMC 40 ohm, from fixed-emmc-driver-t=
ype).
> +        * Force an always-valid Type B.
> +        */
> +       ios->drv_type =3D MMC_SET_DRIVER_TYPE_B;
> +
> +       sdhci_set_ios(mmc, ios);
> +}
> +
>  static void usdhc_init_card(struct mmc_host *mmc, struct mmc_card *card)
>  {
>         struct sdhci_host *host =3D mmc_priv(mmc);
> @@ -1952,6 +1966,9 @@ static int sdhci_esdhc_imx_probe(struct platform_de=
vice *pdev)
>                 host->max_timeout_count =3D 0xF;
>         }
>
> +       /* No SDHCI driver type control */
> +       host->mmc_host_ops.set_ios =3D sdhci_esdhc_imx_set_ios;
> +
>         if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
>                 sdhci_esdhc_ops.platform_execute_tuning =3D
>                                         esdhc_executing_tuning;
> --
> 2.47.3
>
