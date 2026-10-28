Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793207783;
	b=yj5xgSACuwz2V+qr8QEze0ch71y+OSIxc2wNqRivZpxY0tK2Ss8gCwv/P43527ANU3fK
	 bM8uzqZRtAZbpr8U9e0rs0PuKhDXjrahgsYN3DRFhsVg8B7DMIQ0+jUSPwKt2Eu6SsixO
	 i6M6esJDj6Lbcoc/ZuoW0YMWmpjT1NtTIYsfHdZjTwo1/tbwL9LAdGK0CtzU6cX7De88b
	 4+7TBvKYwTHpQWnmkkBqTsyj6YbhkE74RLkh1qdtu0w1fb0qyr+2vYgsPreX284vvQBov
	 tHhQfCTv3MRJHKz8ytdZmWfRcCYBQvFyYkIxpGyY6mgs9lHjjjfP2fncWbgjtvRjKCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207783;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=RvdKRTa71zGBb4REkTJXLVVYnsNBImkhzu+/0ATTfes=;
	b=nem3B4XXdIpJhJuq+cSprJuWZr1DTsrVSIDlizaqd7Quo8aCQTdPi1TlCiOmgC4xjZXu
	 6kdH/5AzwyAUxHW2U67dDWGdS+rh+7hFD+SYSPMLbJmjpE+ThcNnHMWILDBbWhREszOkx
	 KUZ0m50hqJDLISj+m4Ziz7QJjMAKFD02mvyvMqglX4O6JfsxzAZK/7yTyjhmKIK8mCoiX
	 JUwjdcfC2Ksys58hMgz7AzJv6W7nyzjheirEpcGesaFnVNEQRzb8h7E3uYlGdjbB4AoXP
	 bC+YNF/e6rOMQqPSHcYiw/w4k45WZiVYx+nN+vhksunx76415VpJ1otenP1RDq7z2wg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hf1AoZ1+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c7B3cPx0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7319E606A31D
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7319E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hf1AoZ1+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c7B3cPx0
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFA5mh1471889
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RvdKRTa71zGBb4REkTJXLVVYnsNBImkhzu+/0ATTfes=; b=Hf1AoZ1+GDgRnMJt
	4Q3unm7eZ2r4YHQEr2bRWT7MNtJMIXzg1cvD20v1VVvoKGGXpUWUXOa5YxJajsDy
	E8VTjy3oHhDyhBQLlXMHJhXhEMQVUD+77QbmptNhKTsUDCmc5/0PLj1nPfaAecD7
	aD+OXdLOrZKoEVOtgfZDuAH+AZu9aA989VuPVv2BPKsOxeMJtcbWLVQPyPdmjWcm
	y++fEmqehy5v7PH2LdLZeXL4qJAAH0cVqqa6jjRw50cBdZhCBaodJciBmqbH67If
	Qkx9GFDgp6cfXTOW7gJw7Z45JWoqqwCvfz+obk9pAckBEO3Ilt36zJVva4X+Dxzq
	QfHPdg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkfehhp38-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:16:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e80f7acc67so13744435ad.2
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 10:16:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793207780; cv=none;
        d=google.com; s=arc-20260327;
        b=PR249XJ/nCooisy2dDPIlWPdqFG83DYqFT7GixlfaHsuwc3UlVgyNj0O6WqkWxjmou
         8T4V10xyL55GhH+ZvZBNsQpipAZc/+y251y9ZEmwe08rITNYoJzQe3Yy5/KZHZQwWJ9C
         u1JSxi1RJJSaaYhC5G+XZtsjZ5JX8y2DTKAjUXclopnNMXOlcSPV7QuEn7C1s8wTqq0k
         d80jemil5HMu9W3nWrvSzsyJOS7DbzOj7OP6HHrU6dneV9ywaehFpIM88xayA4WtBF5V
         epcUMC38QoIrJ0y8HabbR04zbSmvGyix2f2djxH9CO/hEJ3wFJmB6a7UMy5ldIsE60kc
         XOug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RvdKRTa71zGBb4REkTJXLVVYnsNBImkhzu+/0ATTfes=;
        fh=gu2mtI/sbXILfkOF9Lv5tt504SoY5sBB5M4S5bZhYE8=;
        b=iWnl1a3szqv0f6V4XFBvYVQKY6ZepAi0ph3ejDYMAap7fO2ESvBYC2HgptZmpWVoNW
         ydFpaYlefNqWnkj/BVoSG8pIgrAMY+wASZfvSQ7WzAiUV84Rx3Y2EU9fRQAWn7YAvVP5
         MR5afKzUF5jH22cpIViv6iYjaoaVkYMR8rSNzbz3z9tG0x4c0rC8NIs9+nLCfs9AAvoN
         Ool/SF0NTuJEmOkSXqlFpbq7C6sJ4PrMK0Ji1N2RXt3+RVeXGi/xa+ZYXmfFfHEDXgff
         usx3oYL0rSOw4nDaFnvY4WYmIEiZhPuIoHhv/UniHvOhi40nqDpGBd7BqirPcox3ufc7
         HhLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793207780; x=1793812580; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RvdKRTa71zGBb4REkTJXLVVYnsNBImkhzu+/0ATTfes=;
        b=c7B3cPx0Ve8xe3s49Lp68zXsVROrY6oc+vlGpqTzpDSfOdKcLHJFRtrVnA0UTpq8Ba
         MDg1Je0WIDzx7nQoofmnWriTEsGxsWtY6YAW1/G8WUtGem6Hitbjh0sciIqsGzs94m3o
         +ltBLML/s2bqJ9eu32TOxHR3X4UIphnUYtTomaC7ER0MH2amjuHsrg4zatW83/p9s30G
         9HBH/F79GUXbsFd1up+geYrFmbNmFik8NssyBOR7rW1d6yd8pWpD7uMZf/vveImj9VFz
         Rqe3N6jVrBkf1UwATIKSKAOD6F4oc5RTPfBh0CPUwYqkCFw6iOQ5EW4WnfeMeDoPYzuJ
         WPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207780; x=1793812580;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RvdKRTa71zGBb4REkTJXLVVYnsNBImkhzu+/0ATTfes=;
        b=ZOTG4vtHbLiOTUI60ElDakbNM58AKkSxiSWcboLD7uBUNUp7k6LRL1VTNPrQiG/pvB
         8J5QMQqI94Ic0NbZdtbQjUWQ7ZbPZZu7WJAIfNYwFKuDzPJ8jQSKbFAarLJ24arEZUrG
         7BCDSet7qDxlmb1W5nHEjf2/REnKjgz5Z6cKB4FJ0MVSdJeYPUQYjpD4LfajSDGAh6bX
         np/gF2KcdWm/RyqW1QeEzmYYy+KIlZ71UnQyJW9YUScbgmud7q1gHRh9oCCF5PyX3xc7
         KQpxhpUoViw4C3spZ1o/G44KijyaSwh2A3UZjTrVW+OUDYDocJK25neKZEEPt5TnVOGN
         aj0A==
X-Forwarded-Encrypted: i=1; AKwUvByEYTt5rrhzMxVk6iQsI8jUC3pYn4pGjQQ7WqpA3Q4QxiaO58WFQnSLTw3j7hfmSs23mJJmKMK7glU=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8pq4sL5WGOh/nQcUAPInVmkypFJQH7MEFmPUUkx/BJhDXNyDu
	g0sDjfmoULfFy2KiBdAGsPFChfWEZYoA55vFrB8AwrLTK90K/3PEnYanznjdeKsRT6oDUwsqBcy
	0cIhmxOhrNLgO64UW4jwDR+C+wMJhr1QKy8mhmHCgugPb2xUI2lhbcMHHtsPuUaR1QIu7fb4RAD
	qyRzOX8lgPI9qXcQhKywev2QKqR66GhNEKQ/1Uhg==
X-Gm-Gg: AYBFou1e/OxidG5SscG/DJRxKzLlhd1MCEjb2rSZRtRvw9NaiR+fc7RvJRUrw6eSTaS
	gaE4hyag528fHig/enPdCMPMquHH7Qoa8sRDqEJ+FW/M/uilMiQ1yOsNvbogDBBIrN3kzYrxhk1
	ZDix0zG2N1uekDtwlxO62II2JEbBwUw0g1IwGaPG6/w2oCcvVuqIuUeOfQzA==
X-Received: by 2002:a17:902:e94c:b0:2e9:9524:b004 with SMTP id d9443c01a7336-2eb0052c6bcmr23727465ad.59.1793207780406;
        Wed, 28 Oct 2026 10:16:20 -0700 (PDT)
X-Received: by 2002:a17:902:e94c:b0:2e9:9524:b004 with SMTP id
 d9443c01a7336-2eb0052c6bcmr23727325ad.59.1793207779945; Wed, 28 Oct 2026
 10:16:19 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <1791722984-123689-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1791722984-123689-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 18:15:50 +0100
X-Gm-Features: AclHuK8Lf70SdY5DFZSw3EQaOeBBl_QiZ3i-ZXevSvTPJeE55HTbxUKaxs41DMg
Message-ID: <CAPx+jO_pCiU9qG5swLz6CExPUE55=wp0+pQ62j8wAhrvvaXAYA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: fix wrong comments in mmc_ops.c
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfX2yD2cJ8O4mXC
 7Bu7Mqfq1bCpg6OL2nZN9l2z1TOPJUw2jS3gLevM2W6F6xRhqnzwg6BIdSbWjFEkTyzgb0cG9SG
 xiK9gjpCn8CTma70vX11kV1H/alQSnuv79D8jGqvs4VjrsHIy3JTdR0/wjfLer0bSIbWBRVK6CG
 1Jpq6PzPBZkpuzr8SHy3FmD3mCiFuumqrdLXFRAoznV2M3GmPYkrQ4BsHncvWWfXUQgCBrm0Ak8
 hcTCHK1zntHhdIibjfYy/EhFUUFfY7Lt5UsBoPDQb3YE2ndlnm6LezLixjAaF4Pcz0LUnucknXT
 YPqcb5noKuV0hRthepJbvarjV7BXhvBqiTXd+ytzhT6wtqEBpCjAe9AqVmiIvUZpeRFkg93gx7m
 R6PHosAB13ZdM9IW+8cNAK80FUmsIKfe486/t0dCXEvFotEC3ccnJNn2hK/+bxbM3XtyTof2gDM
 o81Q0tUKgAkajsBBw1g==
X-Authority-Analysis: v=2.4 cv=A/T5rKWG c=1 sm=1 tr=0 ts=6ae22de5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=s8YR1HE3AAAA:8 a=ZTRnR9ALD0t5UWsEksAA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: 4DluiSU_NkprdJ7AxOv0rSwkS4yR2GKT
X-Proofpoint-GUID: 4DluiSU_NkprdJ7AxOv0rSwkS4yR2GKT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfX+5z1Bh2kjwxc
 s9Cpcq5jGNNka9S6W3+ZyfBnGPf0aplOotCLwZOM1tOGvoIU/B+mZSIPIu5ne+bU2j84yLfLTQN
 IE3wc6M+C0l/JbiGe8A1o22PiqxIghQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280068

On Sun, Oct 11, 2026 at 2:50=E2=80=AFPM Shawn Lin <shawn.lin@rock-chips.com=
> wrote:
>
> From: Shawn Lin <shawn.lin@linux.dev>
>
> When seeking to use mmc_send_bus_test for eMMC HS mode tuning
> to workaround a vendor product, issues were found with these comments:
>
> 1. In mmc_send_adtc_data(), the comment refers to "CSR and CID",
>    but the branch handles MMC_SEND_CSD/MMC_SEND_CID, so it should say
>    "CSD and CID".
>
> 2. In mmc_send_bus_test(), the NOTE HACK comment about reading CSD or
>    CID with the R2 response type was copied from mmc_send_adtc_data()
>    and is irrelevant here: the bus test commands do not read CSD/CID and
>    use the R1 response correctly. Drop it.
>
> Signed-off-by: Shawn Lin <shawn.lin@linux.dev>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/core/mmc_ops.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index d59ff82f..fda728d 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -319,7 +319,7 @@ int mmc_send_adtc_data(struct mmc_card *card, struct =
mmc_host *host, u32 opcode,
>
>         if (opcode =3D=3D MMC_SEND_CSD || opcode =3D=3D MMC_SEND_CID) {
>                 /*
> -                * The spec states that CSR and CID accesses have a timeo=
ut
> +                * The spec states that CSD and CID accesses have a timeo=
ut
>                  * of 64 clock cycles.
>                  */
>                 data.timeout_ns =3D 0;
> @@ -815,11 +815,6 @@ mmc_send_bus_test(struct mmc_card *card, struct mmc_=
host *host, u8 opcode,
>         cmd.opcode =3D opcode;
>         cmd.arg =3D 0;
>
> -       /* NOTE HACK:  the MMC_RSP_SPI_R1 is always correct here, but we
> -        * rely on callers to never use this with "native" calls for read=
ing
> -        * CSD or CID.  Native versions of those commands use the R2 type=
,
> -        * not R1 plus a data block.
> -        */
>         cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
>
>         data.blksz =3D len;
> --
> 2.7.4
>
