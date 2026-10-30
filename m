Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793368842;
	b=K2EEVwM4wMsYxLKdB/KTS7wwvW59ZyvoZrkXTWLLjHvG4689MxZwqErqPUNn/C/JIbiJ
	 3UMtg0eXO0fhOU+hTB4CJryzZX1WnlsFWAYr1INnNvuF33Dlnk6o0cFMqYAsl/1ZqZRq/
	 1UU61k1Wk7Z+MpL3KIn55DYqmXXEJyxFBkthJFeQhu0ulN4w2hUsCwv2PaN7o7PDp5ZOX
	 83Gwicu+OuqBfBEqyii8VYaWC01fHjW99bQERyHsQnSWH/CRcAqHcR2AWvrbifHHcFtIC
	 hCOdXSNFPSGUrghIOHzrmGcsXZdgfCeG81urAcJvEDFPob2JlM2uAAIuI7twZFYlvNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368842;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=OuitTymSSoEUqo8wxOrof9T+ZUTGPTidse28qGJb34o=;
	b=rYZRlIJyruCC+fcOWMUqTeXt+jgOdwBGYiicQj3tlukzAoqfRkPBHGvrULARqkCZkX7u
	 8JLFmUq/ZemfEtlJXX35PJRFif0copQ3McuCSYcIyREtYTLFVme2CjiWUskfgfbTmjS2X
	 u4j9vgGJ+RcmH+r2chPikwjOpiJaNFCFLrSL6djclpaTKrSGfX7wOsp5we0bYFVsAlen1
	 lgUDKy4HzD/9NcT9POlYJvyMeiskzHqe4VGHSRNX8jciPPMQ3qE6J9rEn2Tzy8+LcL+DL
	 rIsqgaxSxn8zDSV5RCgzTOGBlkH7cRcWd+PGVGhvYWWg21S0lN6Jg64FXWhmRdvXF3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IHDI6toP;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MjD6nwdg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4F0606A31C
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 14:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF4F0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IHDI6toP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MjD6nwdg
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UDneGc4057690
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 14:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OuitTymSSoEUqo8wxOrof9T+ZUTGPTidse28qGJb34o=; b=IHDI6toPVOYrtJFP
	z1ZskiucSL9zaQF1sOyXvlzXXmXLcY6WxvfQOn8yxwZ/hYxEfwFWQ/xNVWoXwEAw
	pi2RJnDNfhF1UY3r1JVkL39V2aGWfVLebudH4SncyDQbgusv+q053AUMKyXiydcu
	Xuuds3tuDj36SZThVwg7WNX+iTMThoNIdbLdehPh7qg+SsNrAl41CZj8mGPab3aC
	IzSvs1s97jhg8gczI1Lc967TPUvwZW3AZO3Od2RD79WhwlAtEum8sDjTCmqLUOnB
	b2ChyMvzXr5LPhJDFH+YAD9wCpqfVYMRl17krS0QAmuFPTV0YMDCQfCTL3T781mK
	o4VBYw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6quawa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 14:00:38 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a0589ff620so592030b3a.1
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 07:00:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793368838; cv=none;
        d=google.com; s=arc-20260327;
        b=WF14ZHfcEui5nCIvtf2huuGiW71PW0K1+XXFVvcFR7k93awk9JLTMVq9kDHicSN6bf
         JYvurhKqcxn76UWHacOua//FTyXhRal/x71TWPjQDJAad1oYF7Shz8rfHW/riD6JaqPp
         K7t9wzpp3x6Us2u+ih5dkO9hsNmrcDAe9hgxqLgbQ1PJOh923EsWXu5r17B1ENu67oE2
         1EmMFwy+E8OXn1pHfhSjrimxOWE4N63rOaZmDVRNhCMQRk1UU76mYXuCrRasn6t61l8Y
         EC7Vo6yLnUshg9GK9D/RqDP74q777S5fkbLVLYMO7XeBqckLs+/kVOXRZ/gtLYO+v0vS
         Bb+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OuitTymSSoEUqo8wxOrof9T+ZUTGPTidse28qGJb34o=;
        fh=Tv4hMmE280WIscBKqNBOqi2TxBQZqqPTNcHWRDAieTo=;
        b=M6aEnbgZovH6uNZRqW7lGMg6Ek+rvfnk9dgC8dzodj7zhT01YSSVZfIKk6LECu6Ci1
         2hlJ+NR94dKD7yaRs7fY3RJzX0yxWHYVTumsh54n1liCQsME0pJqi9eS3dB0PPUybjIG
         niUCp5ciQu1LXBRN2Mdh34nJkrHVMwoPJnlmEXkvMv2drP3WNSECz18pOa8eLizxxkRO
         2md7pBmZHWUDtlxV90853gKgGz/7llNh3UyvTiNMhXBsJDbpa7iXfC2hwzfbBzNikPvP
         B1bJcgt1t1lFSAtZOKRiUrxd1SQlb1RLaMWmfpgbRIA1B9TCseNZjptirqxWVKbIDeIB
         3LLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793368838; x=1793973638; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OuitTymSSoEUqo8wxOrof9T+ZUTGPTidse28qGJb34o=;
        b=MjD6nwdg2r4v5CtB7SpyZww9+rFGXGXGLgChJOhpGoDd1wA0PYjuGZ0dWdhlgwz3VX
         VkCZM6TC54vEDOUQkYhf5eP+69UkLtusS0s7buLHITEh/dvLlfSfHwd5sJhGV0/GLt91
         lY3MKfo82pkJ+DPoBVssigvpHuXtvqDLgYgXdSGJiyH1n8q+Ouh1tNlgETWTHuy83s6B
         KJeKSWWIKfbmf6GPonHyeAwMbRC/cqJioPOMAIWXkez29Xk3bzn83fFmmybqXTK8P1dZ
         AephpsfXbARjROX/UwDiYr12XNgP3/W5gqf3OXPAhL9DEAi+0Z3jdLbwDBRbmfX9Wfmn
         jRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793368838; x=1793973638;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OuitTymSSoEUqo8wxOrof9T+ZUTGPTidse28qGJb34o=;
        b=E6JW5LUY1lA5i2FUFrsawz3FbZJSWg23xFrmPZR9zSo8FXcdIVsVGNp9w9YmdJJyp5
         e3HS76WUe64balgqvysgITpdmKnn6EtpcxisnCuiRU32hdQWJcImAczaMGvzHY6MAD4i
         FB3G1LwfPSzG8SW6SrOvlX2Sd3ULt77YiNv7PDtd0ALrgdMn/We0X8oJcb0lq7jQ+nfW
         6meeZEkH4HiEs51ihv20sYiQcceW0sTyv4Df9uXtR8ETY9whfI3fBuKtaas752Xt8NpF
         IwLe4QpsLpGk8iFwZDZMDmK0LBzb4VvEj2tNszfLmSKzyKVbfXSj7sFYDl64JVJ+LWoZ
         VEUw==
X-Forwarded-Encrypted: i=1; AKwUvBymhf5vUPwnmRUBrRXWmzKlNaHa+lPi+OHwcaJXqfqZIkxF9sYxzzJvpvJGNK838gLt/2y5PLLw/NA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJN0nYqmJJTUXRB0ChQPfshAgCUSlVGSGD8CG/JZnZXN8p2rykJ
	z5xf/IdUUBcDrEZqf4b/JIA9qn4nsIdBR4a8uzucsqa08EMo5r8rVJae9Rkdxp7SGy5pL4d670A
	hZFqB823C2BqC09yc3d+bjR+2Rp6qm1NM/CwvTfBDg5lXXYJ8cAN7UReCk9BKXIO1nwkcFrom+c
	++kSAe7ViqztdZ7F2FppQTJgy/K+ThQw1qlpWeLmqheAE7kA==
X-Gm-Gg: AYBFou33sLr1bXQG+szLTFVAM+xfevlrl9TE4YkAWZrOScPngoWrHhwdS3UW03iTyUe
	8X2dkVuQ7OnwYOMljXLucnHV5o1WPlzrjK2iQGiyBY2TL8vdl9uj/5p6Fqd8q4cSh+2DevI3Ty0
	5n8YzfisyCI3PTByNjlxPQGmTrefqbsa866JkGMWKo1kaDqYzRdjHs+PsX+w==
X-Received: by 2002:a05:6a00:1c91:b0:89e:584:bb77 with SMTP id d2e1a72fcca58-8a9c098ab29mr2174607b3a.58.1793368836873;
        Fri, 30 Oct 2026 07:00:36 -0700 (PDT)
X-Received: by 2002:a05:6a00:1c91:b0:89e:584:bb77 with SMTP id
 d2e1a72fcca58-8a9c098ab29mr2174559b3a.58.1793368836406; Fri, 30 Oct 2026
 07:00:36 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027144002.10606-1-ansuelsmth@gmail.com>
In-Reply-To: <20261027144002.10606-1-ansuelsmth@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 15:00:21 +0100
X-Gm-Features: AclHuK-MTjfwt2OQzyBtwa_iraZJVoORJ1j_v3oQYZTa5jWvtZ6sOZH5C5h4Bak
Message-ID: <CAPx+jO-TT=UAhH5=5DEPuu1XtVvvE_QA_1V=9qw1moZJoPUU-Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: Document support for
 Airoha AN7581 SoC
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: tcB0Ha01qaGTuCCbPj6NtxWCNVTdifHp
X-Proofpoint-ORIG-GUID: tcB0Ha01qaGTuCCbPj6NtxWCNVTdifHp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NCBTYWx0ZWRfX4MPd0dSpjzvK
 fRWphXwoepci0i3us6pOg6QoV/uwgGtiZ5PPv4bi1khXiYCilJBtma19sI2JEoJ/zCU1YHyTHLU
 v8kbQddES8WUS5WgSIxo10JT+U8Bw9Hoq/c3zRVxC5z0P+7t+dDpI9A6hOLIdW7eq1W6vFBcYnR
 wPhuUpPoP4F+KL2sZjGQYFWkGLbBj+oO0hL0nYbUr59+oh0d3RMMjtx/QrvI7h97PTIkHeg+7jC
 9ypBto0Dynw4scbDH6ZT3yfvxWJhhteCUqj4etZwEE88gc3hQhtlK5sQ8GAl+XXrA4WNoEzzj5T
 ixLXhTAMnfgr2XG+ROgWT+eWbDY4tE46d/wdqF4ddodPocsi/pMA9hbmRgGXSDrqueQDbGgSZCx
 hdFPEqGx0i1CaxY2GTFTeVdO6A7eqYqL2mPsZIB+WwavnDGFwnOi1NuiQJD2oAFM3CAYpWNmG8B
 50JLxUKxpAozJFzN5Tg==
X-Authority-Analysis: v=2.4 cv=dPgzC+Zb c=1 sm=1 tr=0 ts=6ae4a306 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8 a=5vCY4yJ5Sko5zDJxFQEA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NCBTYWx0ZWRfX0cqtlx6gHvd5
 ttzOrFLb5DFX/HVbQp4Dz/ejgZiy/C/aldSTv9QKwDDDaJd9zqIoWeSludQUTa/KMD7r23W8lYM
 f4ul7m2CGGOfLug5FMKipSJTyk/+7Is=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300054

On Tue, Oct 27, 2026 at 3:40=E2=80=AFPM Christian Marangi <ansuelsmth@gmail=
.com> wrote:
>
> Add dedicated compatible for Airoha AN7581 SoC integrated MMC controller.
> The MMC controller is based on the MT7988 with the difference that it doe=
s
> have a single clock controlling it.
>
> Add the dedicated compatible to describe the 2 register requirement and
> permit to define only 2 clock (the main one and a fixed clock for HS)
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes v2:
> - Also add compatible to restrict clock-names for source and hclk
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Document=
ation/devicetree/bindings/mmc/mtk-sd.yaml
> index a4d032224dce..704d59360bcb 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -14,6 +14,7 @@ properties:
>    compatible:
>      oneOf:
>        - enum:
> +          - airoha,an7581-mmc
>            - mediatek,mt2701-mmc
>            - mediatek,mt2712-mmc
>            - mediatek,mt6779-mmc
> @@ -182,6 +183,7 @@ allOf:
>        properties:
>          compatible:
>            enum:
> +            - airoha,an7581-mmc
>              - mediatek,mt2701-mmc
>              - mediatek,mt6779-mmc
>              - mediatek,mt6795-mmc
> @@ -238,6 +240,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - airoha,an7581-mmc
>                - mediatek,mt7986-mmc
>                - mediatek,mt7988-mmc
>                - mediatek,mt8183-mmc
> --
> 2.55.0
>
