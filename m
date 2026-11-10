Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794317577;
	b=S/y0XAGOb2xdi/2ddvTKW5/VG+ZVpW4q2tTo7FuzxFCaO1QavzNVgeJ17p7JE0tlROvH
	 T0Q/gSt1ve4XAVs8Var55UAN3fQl4kU/2Aj2UcirAHQ61EL1y/DKSbIw1N2Mf/Bm59gP8
	 /rG/fol6XBbGma8Y5g+SRkBJ+2nuU+skzIikK7jgGGA1MKYNXh5gblELK2Upnot27qBMP
	 clgIYAl35el7Uo8A7etjwEnSrk/DHwCf30uBFCpyGxjQL17vYnlF/j1egSgFuBH7ak3rY
	 DpXibCF/k4K1jqGVxHQIl3BUqQaCBY18QnZ2rKu+Z2MJfeFuw9D2/QY3EInEBUdPDGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317577;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=6Z5YcW7xlIzzHsxLmHKjmX9pKRKSjf8ynNvjp0PPJ5A=;
	b=2HYXY6Y4mfILIbhG+Kz1VQZgaZclrtJnyHyG+dNWeeKrNlE5Rwm6nc9YSsGKpxwR3dTN
	 PXFz9gQKEy4M0yPY6pxTXWGU6M8wmAkWCR6gkQVM3jXOweKE5c2hiaiaaBU6wnMlDsr01
	 RQqaCWepQwllYr8tQ/EDiO5f67TcR3mED8MkcwyHyYpuYxjxet/Mq6eIuYSQNFBOwYIg8
	 oMXSy5ThmXENw0dD/AVrsIa9M3F44+tPzoZ86TYos3PeMJW7MTNkU+wDkOEbYdo920TRE
	 z2VW3aXltKAvADrkpXlH+WhpMsn/kaKzKCiO8r5610trHZPOy04z7q0i3hlE2vyqVfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iuDAJXJ8;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="kcQRF/Tq";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9257F606A7E1
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 13:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9257F606A7E1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iuDAJXJ8;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kcQRF/Tq
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABAF2V3217311
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 13:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6Z5YcW7xlIzzHsxLmHKjmX9pKRKSjf8ynNvjp0PPJ5A=; b=iuDAJXJ8ws2c8/K2
	9/o3QwBAzIrsi8dKAitTKKwMebOCcGsdncMrYeleUcLsB5j/j/rgFl0IO8SVhh1c
	0sqUwqtdGa+Y0kO7rCpBuFWHEqHeKMzEQ9u7irbHB7QEIyUXRrDCkZLjBfHvtTWp
	qmSAP3EjY3nc1/DUMsjVLTggzBiW2vNBIq5Gl/8PEMWNF5oLWkm//dElZKDsn8ad
	kykVh3RoE/ai7o6uZoxYUzi64iqxzi4/+QvTT9cKqom+ahvKRxgkh3OPWee3d60C
	/mMy9MCtEJfafT1UXMQfxk/xh/tvNubKFkJeXTRTGkXpDILoxRVCkqhf3CXw29pm
	Z3UFuA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huvtd9usm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 13:32:55 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc4ac5feaa4so1238614a12.1
        for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 05:32:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794317574; cv=none;
        d=google.com; s=arc-20260327;
        b=VHfH8bMPLdz3msHDxyMUtiBtHi0MVIym8gu2+jKDvuWWvSONzTZUSC0iqpPDABTvnO
         QIsPZEMDWFCwCoi8r9C+82w6meAjca2C5cfLrjjn9JMrhK7aY5dmAq9Ph4Uds+nZBhv2
         ufUOt9s6iyUldnSFHbQeCUCdalek6tjJ7e2k0m+bUlqZKi1QOxiZKf4G2v0YWFfXro79
         lxcdKCmKyN9SH3HzMoyx3x4n73wTsYrabrrSN3p/Ee4bI9IgMj1HCBPCI+A4NPutKncQ
         ZiBXpDPkqAedIQTQSxyIrUwF3PFeFl4rdWlE4HyMMMRWiJXYv5brfIILEbhUfUo5CIWi
         RQKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6Z5YcW7xlIzzHsxLmHKjmX9pKRKSjf8ynNvjp0PPJ5A=;
        fh=3WbTKLwQSK/lMP5U8XRxJ7QBpKeeHA4X4sNYEaub8GA=;
        b=qU6aa9j6xMXeD+q+5fVIamYv29fAiQ0k7lcKvgLSIHcEEae+mVwymKJJpaw35S8Aih
         5PcxeyeLMtMh28drxck/tYoYqMNnwpFzrjQV3zmTj+EKlOq7qHtBN39/3MiVHZcrNh+z
         Z8rLIa9e4PlQNVyqF+79LzY/L+U8z/1O+Bqr+iJG6kYxkhX15LyhajQOLtsb/9jejLK9
         DYr0pKjU6b8/4j2eLMsGm2H6BhDcqVvdGQDoHXIMTvzivd2JSKIcscjpWub0D7nVmlkM
         nQYVBYlzP0+Xeaxoidoq9zlXY2GZSSe2n0uGgdUfU44fuABwObAp54hFtuFJ6CO+1B5M
         bNbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794317574; x=1794922374; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6Z5YcW7xlIzzHsxLmHKjmX9pKRKSjf8ynNvjp0PPJ5A=;
        b=kcQRF/Tqt39wKKnhc/DX9C2F9JhOeCW6ZsV5msBKJhlfxjFJ80eZr9H8x6oMVya/vB
         so3OL6w4JfZ3AZeyc8DzzgPFodx1hdArhpVnZk+AlMV5g/sLkChzSffCbpHK15cI50wD
         SMhEWOb55f+5wH5K2xVWTzeQKygfVUDgcszO2gK4cAzcTEU7IasV9QFgnv1zK017BejM
         uSNgyFtxBeEaeugfZ+CUXkesgj6JIoLZHTzH6W3icIvC9uC4F9uXb/hK28PJnPY1PCkk
         /fdxNbPpDSVjd6iCHAnMVKgRKplvth4wtIP2EXANSlsCqgUH0t4rg6nikMGiQ95MY0G+
         rn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794317574; x=1794922374;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Z5YcW7xlIzzHsxLmHKjmX9pKRKSjf8ynNvjp0PPJ5A=;
        b=AlMB2gcOqcnSjeOle1TqlvdRUSYzr2dUtxgc1uKu55q0XmEcfMcIoQghiXKZeMgILy
         5HukmpJDOpOxTE5NzFTBb3zuvrqvOR8B4Zz1V2UkGIJMOWU71EpmaQxA9gn69sGKN9uC
         nqFrMp8yM3ulwC8dpSqBNh+oNpyuuo2lz3mJmFWwYmrrgVTZ+SJhtDNT6zc9gv5bVImf
         xiJa4ynmjZxWDHvrFYlT9PMYx65XVNYlxomRTr4XNkCNGVPbvLJXT7n6zyU0lwxxn+OP
         QiFISuy7Rf5+QxgkovGPNBPpbRnCCM53mWK96fFDtuXaBDvjKpA89sdJfwuPTa0w5n4y
         w1Xw==
X-Gm-Message-State: APuU4Z/ZBuBRsPtbQbrAlu3YxAGK3vdMekKvFRE35wBZGVlllJlSRCP6
	MtJoF+5Ox9LEYHf6+awASMXCkU5AFV8ZRYmZjUNd2+oG3DqBJA3IJpbbI4HBeoNVWnhKmTzafNo
	TdZL5pIliIYQi4GC2gSkSHGTQJ4zVPDnFyGV6jzqCDr4oDc1gUMJ3aDFgbBwKynuoUeKrS1Fa8S
	YhZcdNzQlXxtiG691DTx+jVXuGpPPRrloCV1MXvA==
X-Gm-Gg: AYBFou3H0Iw9a8CK/J8FEphv69EX03KqbQG+LyGT8HEr1O30PSiJN1loFlOP05eQLRV
	ik6sWYvt2+WgY/zjbN6IlmNrzcKrX7ORlKIA6UoA6LoerEAxL/DIptDtAMy1x0wd/7DgyyYd8U5
	Rl83ePmaO55hrY98RrZlXJLC+HQmNBxpBTTrjlcUdfYJ1n6yLwNExJSU2AQA==
X-Received: by 2002:a17:902:da85:b0:2dd:ad73:5b68 with SMTP id d9443c01a7336-2edb9162f6bmr24070725ad.24.1794317574332;
        Tue, 10 Nov 2026 05:32:54 -0800 (PST)
X-Received: by 2002:a17:902:da85:b0:2dd:ad73:5b68 with SMTP id
 d9443c01a7336-2edb9162f6bmr24070525ad.24.1794317573847; Tue, 10 Nov 2026
 05:32:53 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030215427.488298-1-marex@nabladev.com>
In-Reply-To: <20261030215427.488298-1-marex@nabladev.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 14:32:42 +0100
X-Gm-Features: AclHuK9cSqFPuGhIfXjvW3xjTIABdJvSnxFQcMIeO9HCW1ENUGZJbxffDIA9Fdc
Message-ID: <CAPx+jO8sc8gbxNQTjK2tx+1UPLqwwEof3E9vknHNc4kmbeB7oA@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: stm32: handle mmc power up
To: Marek Vasut <marex@nabladev.com>
Cc: linux-mmc@vger.kernel.org,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ulf Hansson <ulfh@kernel.org>, kernel@dh-electronics.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: gSHtF3v8JnpDDYf9PAzCDnpSBEsmTQyW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1MyBTYWx0ZWRfXw7bA8Piew/d2
 jWq3r4b8eXECUcUN4TrDVP2tpKrGqz8N9mZyZfJZAgGJ2AsyHZ2tSLf9/DDZceWr26UIb9VaVXt
 gnKFz19F/YP55VlpDH04hx2OKKYcNFo=
X-Proofpoint-ORIG-GUID: gSHtF3v8JnpDDYf9PAzCDnpSBEsmTQyW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1MyBTYWx0ZWRfX6Kgow0s3G15E
 PBGdgM91vEj9clPfiHuSzVnlTVM7fVEbWVE8/5vhGwDplTrni+JLUf89dmByZGvdh9406trWAFJ
 rdhwXbKhAjlfxngmad358BOwNK5cj4XVabO4gwFFF4PAzo7EUJQfTuTfGb0j/666m8aOWse1m7A
 O8zgZNgSnjdhOuwCwaOgsO/kGtLLepsH3HoM1abZnY2tgpUTb8ZWZj2nbNZrXrYh/EoejxLWm2k
 D8N5fOtb1B9D+0nEPIx2sMq8+eDnMN6zN3PA/yfLh+zKjf+Bjb6Pm0ZXam7CDEbpl91ZnpGqve5
 6asFmdxB8bokJXESF8O1/AeYAuCHG9LzKvGPPg165ppzuH0gdttf9GfzzhcM73qdgkLUYq4WkTm
 oDsK9z1r/C4Z/M19NxHTAItklTO/U5uPSKpOrhcm2WmyR8tj0Fp/Hq0IOOd/bk1GKnVqvx/hx8V
 4AJMmDJF2xLOkRy9Tqw==
X-Authority-Analysis: v=2.4 cv=ArR7T+9P c=1 sm=1 tr=0 ts=6af31d07 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=p-LfKV-GAAAA:8 a=8b9GpE9nAAAA:8 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=zk4-lHRcAAAA:8 a=JfrnYn6hAAAA:8 a=phlkwaE_AAAA:8
 a=T00PcwSzXyzIdGW_Uc8A:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=97BuGM4RKn6GwmfqMd6i:22 a=T3LWEMljR5ZiDmsYVIUa:22 a=7cv85riZL9-k45RWW8P6:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=uKTQOUHymn4LaG7oTSIC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100053

On Fri, Oct 30, 2026 at 10:54=E2=80=AFPM Marek Vasut <marex@nabladev.com> w=
rote:
>
> From: Christophe Kerello <christophe.kerello@foss.st.com>
>
> Manage MMC POWER UP state like MMC POWER OFF state. In case of low
> power use cases, it will avoid random initialization timeout. This
> fixes a failure to switch DDR52 eMMC to 8 bit mode due to -EILSEQ
> returned from mmc_get_ext_csd() in mmc_compare_ext_csds() called
> from mmc_select_bus_width() after Standby1 suspend/resume cycle.
>
> Fixes: 46b723dd867d ("mmc: mmci: add stm32 sdmmc variant")
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Christophe Kerello <christophe.kerello@foss.st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Ulf Hansson <ulfh@kernel.org>
> Cc: kernel@dh-electronics.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> ---
> Marek: Update commit message
> ---
>  drivers/mmc/host/mmci_stm32_sdmmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_=
stm32_sdmmc.c
> index 9dc51859c2e51..659a5040729e9 100644
> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> @@ -368,7 +368,8 @@ static void mmci_sdmmc_set_pwrreg(struct mmci_host *h=
ost, unsigned int pwr)
>         if (dlyb && dlyb->ops->set_input_ck)
>                 dlyb->ops->set_input_ck(dlyb);
>
> -       if (ios.power_mode =3D=3D MMC_POWER_OFF) {
> +       if (ios.power_mode =3D=3D MMC_POWER_OFF ||
> +           ios.power_mode =3D=3D MMC_POWER_UP) {
>                 /* Only a reset could power-off sdmmc */
>                 reset_control_assert(host->rst);
>                 udelay(2);

What exactly will this reset?

Kind regards
Uffe
