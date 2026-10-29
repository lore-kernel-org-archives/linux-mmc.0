Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793273524;
	b=AbfEohk6UTq9WDVhFBCxtmXowk1bj535tQ1TzRXfHr7klyhEBlsBqjP7F89EUvP/iM2K
	 fbu+m+UVetcaQFJ0KZZdYme+qCmQAti3/jh8Ml8ZPBe4OQD4EmeJdfa7PNgVE1NH0PMBo
	 vLcGf+x6bjNQifeqaLqqlNPPa+Wr+GeTFKdwMnPZCGMm1MCCJcPeqxFQIf1j96mxpWRHV
	 18lScdzzCkmoqjnoZJe1GLARWInLxFcWBjM2LQgvGe/Z/F2eDwv1XAf+6PzD3rOcW+Ys2
	 /2xv7wDUwBi6FUWOlW7KYoJhUz4MW7mYbEG2Sw2oT8I+ZbvJA50B7IyMpggdXrtpVOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273524;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=SmeG8eDrUww7PbplsIcYx6wyVdH7rGxQXJYVetL1ZLk=;
	b=Z08BAa9JOn4x11BU+InP3maVMJrshcrt7nRLjDJoyjG0RVreP1CJjZsv7SFrjzaEXvbA
	 e39JEIvYTaq+jhdVW7NN8PItaCV7W8RwZ17T8RVhhL0HoPZrXY4SzTpYciAg9db11mu6b
	 4d69IHgeKMQ08rISlDt0vZ9jqN6WycEu2b71ZwX5OwNEfsmC5EA/0nILnRQwe8jBUC4E4
	 RUAhp6oELoewSEKn+pzPorHeJNnTPfSIGEpdjKHakb1ExjIa0i+eKlSxybyLOn+G11J3B
	 vPyi0lZDi4fHWxDJtbP44cfN5H9KAzHi9o8xCoa0p9uk/GAzpnFdkvufP+nNtPhgNOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N2ulyUq2;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d7DpF0c0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8EB606A31A
	for <linux-mmc@vger.kernel.org>; Thu, 29 Oct 2026 11:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A8EB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N2ulyUq2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d7DpF0c0
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T8vDqd3824956
	for <linux-mmc@vger.kernel.org>; Thu, 29 Oct 2026 11:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SmeG8eDrUww7PbplsIcYx6wyVdH7rGxQXJYVetL1ZLk=; b=N2ulyUq2zQlxC4vG
	5LBSt97dCkUvPpTIWLM9QzF/oTONOlYpjFHqdGTYm/5FjOqreU8Gj34ek14PzYb3
	Lj5hkgh+a5XBCPXxUFpDwKi/Buwkja1XEMgaBUkL1PLDXzrjBpzGpSFXTLYcI9SL
	FLAlPCIIebAXBDGkAamNdvf/gzgnSGXkxCLP7c9hrypgtAZ8mhpWlQHZLibDjNTX
	JltAweSlnEZVoEdeXkk8y5rsNAO9r6uq3XvLNJetGafOJymdV093csowGjjv0qkw
	cTn/3wHGsmafNGn96owgFSRCsQCsIT2cm5aCoCS7Gre5eibWb3xznWMQh1oX3JPb
	xtXJ8w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkut3j52s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 29 Oct 2026 11:32:02 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd68b8579f2so932652a12.3
        for <linux-mmc@vger.kernel.org>; Thu, 29 Oct 2026 04:32:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793273522; cv=none;
        d=google.com; s=arc-20260327;
        b=bvJP6df301nc+ntLyVxZ+U+rDCuxt37YNfUrmgF/08Nx6QNwax1vUSxEdOhbcPnvBg
         pzWyqj8CQ6Dd6/7rOJOXyftOv0q5WSDNceSfs8RSqQ0uKHwIOdeIgI5Z+zfrl+8i6wm4
         3AVD3XO/XlaGMIwIsHuADibkt/gKNUbJtRfVQOhNCCDawWhv1zEjSl/yKu+NzFWDLg6q
         LfwRrocIQ/OonxJwSENm/7tItLy+pd98rfGKy6G26LViQ0dS6gHtfQoBAtA64yE9WFL4
         oLrOfY9l0F8C1S94KN+eRDo0QG8r8KY18cbfOdvMd0klSgIbLcc6yFex8ZDFK21aByL3
         v2Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SmeG8eDrUww7PbplsIcYx6wyVdH7rGxQXJYVetL1ZLk=;
        fh=ahvEAKEnuq93kDuM0A81+T2DoIF18gnxVqoW+98fcSw=;
        b=VSgSfFqVer7BtLFR55AG4CLeTdp7BfC3JNv8RkuatlQptC27W8UJMHx8uDkB143wCj
         MGd0LmYwLK2LXRM3yRk4xL/Dsse2tL+ojvXoUKy9fAMiG8Nd8QIa9lFkmjxQj4VkP+9f
         dza0d9i+H/PBqa4QPqF122vretUmbiykEiXBRQ415iAE1hefGaZ2nVkLZB1nFc5E1n8P
         yPDTD6AB8fJu9vBEowWxPI2SNV7XYsgCu6d7NIcS27cJqynA99yYbvZFyfEewvkkjPEb
         6rQZZqFtG2ebZW/hRlz04ZbCyckXo7uAoKdIxSbdUei2cHNIIAoPsAStNsfRlZ1khlzo
         qtbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793273522; x=1793878322; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SmeG8eDrUww7PbplsIcYx6wyVdH7rGxQXJYVetL1ZLk=;
        b=d7DpF0c0rs9IOOvUsK93M+q5cZ/FiFC7hJiVDVPTt4Dvtzo+hL6S6kbayP3n5+BGhN
         X7ObYWDpHTq6Ss3Z2ybt6SpkkS6+dilCZ5FE16u7wplabp85zUdNqClZ3aMG/a0xVYiv
         pOHFI9O5aMqYHr5kRjbtUFzyc2SpPh61oKBVDvEbCLq7UXeATinAtz6sQPEc8q4aux5e
         FU9wl2VuSymXNOHWAtDv3JN4LDG27juyeIJ4cDluBUPwDaRAm3t3vhd1g9/7CxzKAIan
         xj8LqUxNoiGHlwvdQu6yuN2Lmt1OQMbzw8M7PrN157v5oFYUvM69u5Vcs4/Oqvi5qKpg
         39/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793273522; x=1793878322;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SmeG8eDrUww7PbplsIcYx6wyVdH7rGxQXJYVetL1ZLk=;
        b=MVSMS48PjrznJycjKH9E36EejIiY/yR0MZcQKIEMNIlFA9wxCRJlog2dEBQvYL6Y/9
         iRHXqCgMwrud3pnDrKFv3aLlF7FqEDDOKQbdqQJEpw3ETdhUrsctTOnp6Rl05zZPauXj
         wfnsSfF4xfDZZbv/m4idbhs8LLuOEku4tniDEIAWPJNr4Eee42bN9qwmqF9lrVgRs16F
         xivv7VPsl5cNaE/31BPKhTgjLnNf27m7PV7aobbndZONjyHYlyICfiGJEg+WFljNUoUM
         FPMkAmX10GDyOfZxtbnJ1ryKu5ImQ0ZExPf+t/Z6p8/z8lSEQlibmGAhw4FLnh9JmzZj
         EpuA==
X-Forwarded-Encrypted: i=1; AKwUvBz9kiiyTxcLwrULas0NXwXiMfler0lOTWZ/y+SoauObkGrlmf+bBspUczqYnl7jLat8J2YOpfdHVA0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqMs3sCc9aGsosJPCZr4ByYK2TK9QF1H/yg4sjrwNz9ooUxb6Q
	i1rUiBUa4Xe6+vqviLjMcG6cUDyJojWY8Y2+uyR7gzpOiFeY2M7bF1NWiqmALz5Dld5aSlqLHjD
	f3mO2xeJVTd5G9ssOMlcizf4XNL5sFrdBVa7LU2h3+BBqvMtR4en9ayxIt6K99bg2fizwrYkrGG
	HXZU+lP94fDOShDFgawDIJ11OQM25SsNixp3ahCQ==
X-Gm-Gg: AYBFou0Bd0MiPcM8Jt4S3GFEoIi7Po+aVCIFxXZt+BlzMqQfVdIxpCsQyOR2VcTy9QN
	8zAFkWuuOmqyI0em2/7Mv7sZUKvM0ofmoLDT1+rqALQl8FlFcNZACc+y3uUIpqpb+UYfoT7a0+q
	7wdUKCcVi7yo0gWwoqJtAYUMDsGPJlLssZCKM7KN/LKuNejrY8BBdF+dq6GA==
X-Received: by 2002:a17:902:ec8b:b0:2e9:69ef:ff38 with SMTP id d9443c01a7336-2eb0046897cmr53687825ad.55.1793273521892;
        Thu, 29 Oct 2026 04:32:01 -0700 (PDT)
X-Received: by 2002:a17:902:ec8b:b0:2e9:69ef:ff38 with SMTP id
 d9443c01a7336-2eb0046897cmr53687425ad.55.1793273521275; Thu, 29 Oct 2026
 04:32:01 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261014202619.715573-1-aubin.constans@microchip.com>
In-Reply-To: <20261014202619.715573-1-aubin.constans@microchip.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 12:31:49 +0100
X-Gm-Features: AclHuK8ocQ4ZyIc2NMN2E2foJvz0KUaZfpo5I8Tv2CJSYssB2wGKDJkhP3QujAQ
Message-ID: <CAPx+jO-fyYy9ZX_O9UQ-tSnOG7LCd0rZ8SNn307hFWLbUAqBRw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-at91: disable selectively clocks on pm runtime
To: Aubin Constans <aubin.constans@microchip.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Eugen Hristev <ehristev@kernel.org>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Romain Sioen <romain.sioen@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ryan Wanner <ryan.wanner@microchip.com>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0NCBTYWx0ZWRfX0H/P/KtlVxAt
 MsLoSLNlEwFMHu2pmGiv+CzI18i/PZRbAP5lurVvHMNOYs3gAalZMqLvL2AL5eTpETZxkF854NV
 V2zyT9JJQKhNa0IbNm5LMcRQKMqL3jE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0NCBTYWx0ZWRfX3qxLSyTTa2t0
 rA8scerJjWsjwEQWyLLhBO6Ws2BvkDWTadDSnVaDPAu9LhqHv7e8QOP4qAso0gqtHWsJ+dDzsCo
 PzSNH7FiZlMnQTiPg9TwPPHqwOEoXhAZpWq2dEiMlFTteBHc4CVQ6GO7iJBrvG1iNyvFHRH7isA
 kBWRk9cxBNmP/npALLxDN/VIQ5DMXx0FmeF3uPpcGQHMl02/2aqis2cVeMUastanF0+7zkgRUnz
 GFLAxvHoTOkiWrLhcrnJk6rhreR9vJ2Of59cRGZidBb12SquXrKme47uUNDVpwkdwGhcZ7RDRzi
 EhqmNnYn6ZQ6pA+EITlYTpPtZLDlSH5liSGIjRh1iHmOR/04N0k/3ujtzA/0RF++Y0bNRIH2iJt
 eLS0etVoVMYmsuFFiraaJUzNshs6kuN/WTDe2cJUq/oTRG6lMrbfNPqxwKkFBAS4A3uj342ZMcT
 tII/CvRED1ZLwRa3ijg==
X-Proofpoint-ORIG-GUID: ZttUiH75dnivPoj3uMUix8HxFqYpMwhn
X-Proofpoint-GUID: ZttUiH75dnivPoj3uMUix8HxFqYpMwhn
X-Authority-Analysis: v=2.4 cv=HYSB3SE8 c=1 sm=1 tr=0 ts=6ae32eb2 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=XYAwZIGsAAAA:8
 a=Newhmvhl9Q1cYdYltlgA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290044

On Wed, Oct 14, 2026 at 10:28=E2=80=AFPM Aubin Constans
<aubin.constans@microchip.com> wrote:
>
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>
> SDMMC run-time clock disabling is not supported in newer SoCs, including
> SAMA7G54, SAMA7D65 and LAN969x.

That sounds a bit vague to me. Exactly why can't the clocks be
disabled? It seems like the clocks are still being used on these newer
SoCs.

>
> Make the clock disabling scenario conditional:
> - still enabled for the sama5d2 and sam9x60 compatibles (which are all
>   those implemented at present),
> - otherwise avoided by default, for subsequent SoC families.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> [Romain: Fix unbalanced clock activation/deactivation]
> Co-developed-by: Romain Sioen <romain.sioen@microchip.com>
> Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
> [Aubin: Rebase before sama7g5 support and edit the commit msg]
> Signed-off-by: Aubin Constans <aubin.constans@microchip.com>
> Tested-by: Robert Marko <robert.marko@sartura.hr>

Kind regards
Uffe

> ---
> Changes in v2:
> - Edit the commit msg to say the patch prepares SAMA7G54/SAMA7D65/LAN969x
>   SoC support w/o immediate change.
>   Also, move and summarize Romain's own commit msg close to its sign-off.
> - Restore Claudiu's author and sign-off email to the microchip.com addres=
s
>   he had upon writing the patch.
> - Link to v1: https://lore.kernel.org/r/20260918153414.909333-1-aubin.con=
stans@microchip.com
>
>  drivers/mmc/host/sdhci-of-at91.c | 36 ++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of=
-at91.c
> index 7c4ac65f247d..399856643e57 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -39,6 +39,7 @@ struct sdhci_at91_soc_data {
>         const struct sdhci_pltfm_data *pdata;
>         bool baseclk_is_generated_internally;
>         unsigned int divider_for_baseclk;
> +       bool pm_runtime_disable_clks;
>  };
>
>  struct sdhci_at91_priv {
> @@ -149,12 +150,14 @@ static const struct sdhci_pltfm_data sdhci_sama5d2_=
pdata =3D {
>  static const struct sdhci_at91_soc_data soc_data_sama5d2 =3D {
>         .pdata =3D &sdhci_sama5d2_pdata,
>         .baseclk_is_generated_internally =3D false,
> +       .pm_runtime_disable_clks =3D true,
>  };
>
>  static const struct sdhci_at91_soc_data soc_data_sam9x60 =3D {
>         .pdata =3D &sdhci_sama5d2_pdata,
>         .baseclk_is_generated_internally =3D true,
>         .divider_for_baseclk =3D 2,
> +       .pm_runtime_disable_clks =3D true,
>  };
>
>  static const struct of_device_id sdhci_at91_dt_match[] =3D {
> @@ -164,7 +167,7 @@ static const struct of_device_id sdhci_at91_dt_match[=
] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_at91_dt_match);
>
> -static int sdhci_at91_set_clks_presets(struct device *dev)
> +static int sdhci_at91_set_clks_presets(struct device *dev, bool start_cl=
ks)
>  {
>         struct sdhci_host *host =3D dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> @@ -174,7 +177,14 @@ static int sdhci_at91_set_clks_presets(struct device=
 *dev)
>         unsigned int                    gck_rate, clk_base_rate;
>         unsigned int                    preset_div;
>
> -       clk_prepare_enable(priv->hclock);
> +       /*
> +        * Manage clock prepare/enable procedure depending on if the boar=
d
> +        * support runtime clock disabling and if we come from the probin=
g
> +        * or restoring procedure (for backup+self refresh).
> +        */
> +       if (start_clks)
> +               clk_prepare_enable(priv->hclock);
> +
>         caps0 =3D readl(host->ioaddr + SDHCI_CAPABILITIES);
>         caps1 =3D readl(host->ioaddr + SDHCI_CAPABILITIES_1);
>
> @@ -223,8 +233,11 @@ static int sdhci_at91_set_clks_presets(struct device=
 *dev)
>         writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
>                host->ioaddr + SDHCI_PRESET_FOR_DDR50);
>
> -       clk_prepare_enable(priv->mainck);
> -       clk_prepare_enable(priv->gck);
> +       /* Same clock management as for hclock */
> +       if (start_clks) {
> +               clk_prepare_enable(priv->mainck);
> +               clk_prepare_enable(priv->gck);
> +       }
>
>         return 0;
>  }
> @@ -254,9 +267,11 @@ static int sdhci_at91_runtime_suspend(struct device =
*dev)
>         if (host->tuning_mode !=3D SDHCI_TUNING_MODE_3)
>                 mmc_retune_needed(host->mmc);
>
> -       clk_disable_unprepare(priv->gck);
> -       clk_disable_unprepare(priv->hclock);
> -       clk_disable_unprepare(priv->mainck);
> +       if (priv->soc_data->pm_runtime_disable_clks) {
> +               clk_disable_unprepare(priv->gck);
> +               clk_disable_unprepare(priv->hclock);
> +               clk_disable_unprepare(priv->mainck);
> +       }
>
>         return 0;
>  }
> @@ -269,7 +284,7 @@ static int sdhci_at91_runtime_resume(struct device *d=
ev)
>         int ret;
>
>         if (priv->restore_needed) {
> -               ret =3D sdhci_at91_set_clks_presets(dev);
> +               ret =3D sdhci_at91_set_clks_presets(dev, priv->soc_data->=
pm_runtime_disable_clks);
>                 if (ret)
>                         return ret;
>
> @@ -277,6 +292,9 @@ static int sdhci_at91_runtime_resume(struct device *d=
ev)
>                 goto out;
>         }
>
> +       if (!priv->soc_data->pm_runtime_disable_clks)
> +               goto out;
> +
>         ret =3D clk_prepare_enable(priv->mainck);
>         if (ret) {
>                 dev_err(dev, "can't enable mainck\n");
> @@ -344,7 +362,7 @@ static int sdhci_at91_probe(struct platform_device *p=
dev)
>                 return dev_err_probe(&pdev->dev, PTR_ERR(priv->gck),
>                                      "failed to get multclk\n");
>
> -       ret =3D sdhci_at91_set_clks_presets(&pdev->dev);
> +       ret =3D sdhci_at91_set_clks_presets(&pdev->dev, true);
>         if (ret)
>                 return ret;
>
> --
> 2.43.0
>
