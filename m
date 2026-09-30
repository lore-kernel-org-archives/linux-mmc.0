Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF8C39B969
	for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2026 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761250; cv=pass; b=NMBH9OnIpypCOgmYWdGXgqWU3HT6jBrxfooS7XRrbiRNS9d2ADRjmCCTSWOMn6srkKTl/4sRsmlhMWOFrnFr8XaQJ2iXMMOx7z//awKvWjyv1DEn7rCPXabcoRS+a3YeNwxTa9FpUZfkrGeiXl/4/93vFYBI17gBNWTRt/chq8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761250; c=relaxed/simple;
	bh=pPskIP3YQdntT0SWxii1FRZrKrz51j/PFfCfhj+7X+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DAt4wtvECtdiJFjr+2ZTBulnITEd6KMzGpPVnGa2hJ5UsIy37ziCo8uxxXvqqCayibBJas6A0hgT206LLIdv1fBgXn2+EQ7y2LZ90CFdwmDv+RX7iC+RW33P/Ei9HDgC0HD3bpTvOBXweC/Pg0XAEDOnI6jCGCxuFKLpHZo0FQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A/KDK5Qu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AjZrUb4z; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A/KDK5Qu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AjZrUb4z"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U97t0r4151913
	for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2026 09:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KZWMHLE219x3709P+AjMvXHPWhrcV6RGzOP0PzNMJ8s=; b=A/KDK5QuyIrplEaK
	cpkGymtLE/oVLFECf/FJtenNanLNdr/ZLdZ2Pgd3uOCnfiGQaREMCm8fyGQrpb+f
	9AMLuTld/Li96Hd537JeVb3kRRpo/cfNWJWvfs9+4I3/FtyydlRX/3Q01vtPCB/x
	r3POK/4kZOC8/YVwosUYD3DpqIHafsLsiuWZW78qsCB0Yt74fjHbFDjdz0eHsD8u
	RLGHkubB/ETmevspEbPSmbzjrWRwNaEu+ikYmnl/9sryju4tWcSfDTbVUdnyISOD
	rQWAlanOSBIrfBMMp0NKPGyBCL0eDuBnI3rCRBVExxYT5JuxESS9sdkg12BkPEuE
	G0Ujfw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0yh804sf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2026 09:40:48 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-86a43fc3527so1858370b3a.1
        for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2026 02:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790761248; cv=none;
        d=google.com; s=arc-20260327;
        b=Sr3B+YpLeeW+wUxrOBubcwkCzvXZLvT/HbPOrw2XNJHBmzFrwuQ6Fk9rI0P16yrgFx
         JYz8Hp+Ex5HS8CmUcVDshYbg7Tb3WSmwoB/b7D7bscf6jdao+lgdWgHLCUxze2W60rlu
         +HSraRMn5L6ZYRrPmpdUmjTyWjKtFh7LUC0ezZuhN18QoZftQtIqb+6qc26S/8R2d6Cl
         lRKd3gKHWzut17e7L03iQprbABcF/tXSWWXVDbY2tm6JCn8Fp+4LeyQJo28Mv1cYMu6R
         Hg1tX/L6gY6+B5LgQLwMfiNVx0x3N1u4ON40uMmZtQB0JFPnI2LmiaVddC4Ysz+g+wmK
         VJ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KZWMHLE219x3709P+AjMvXHPWhrcV6RGzOP0PzNMJ8s=;
        fh=IW3djtWdAGbWMtm0UDbADB/EhnMTSax+JjRydea75FI=;
        b=Z/X33q3LxEWb7Sxo0Cm5fxvXZgP0gdu3GNAJI1LUE00+FsaJ4QDaNeGB1kWGzvLPwV
         zVCHNSgyIp3FsBX/EAQeDxemLXagRvM2eY/zIYHM4fpM4cMevndb3CZ5acr6McAvbtNo
         +ViFn7qmLq3stG9NdYOMUtUgua/jtX4B6BPGWGHSwe+UmENIh0cU6tLXyphnFG/wwLW+
         AkD6Mu4mjp1YyYKxmyGjfnaq+xRUQoMuYgd/mCp8x84U4p/kLus4YdC+o7lAK69EPc6+
         wLUWotoELoi+nMPzN5LA7Fhgjj+z8khmBHUpHh2RL4p1WvgdqUbDb8IBUP0bovSBf3vv
         wazQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790761248; x=1791366048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KZWMHLE219x3709P+AjMvXHPWhrcV6RGzOP0PzNMJ8s=;
        b=AjZrUb4zKW0RCLzVerP0jVnAAxKiWQbdUZeqKWNyEjAQ01i4U51hjECEtz0GZWoBLJ
         MOaHSSltSx2evLasrQ7FhU50MWI+M6e9gI/tMyOUXC5II+fGC3fy2DjdjodglxenQnHr
         Nk06WLC/R3Zkwonjr/X1r9+MkZvvLKc3Y1oXlY//dJbNcHYR3joQHAEZUr3Yy3fxS+vx
         u0w4vRH7SqWdJaOyndJw7VA254/CWRhYPYuaPXWOiRaBFCV0sZYMby3v4AVxxM9I9zaG
         KpNDXNnyNAyag3Bd/G5+h3Snl5RAYC4gEjYM3QWDorGvnanPV830pdcDm3VEoJmKHn4M
         twLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790761248; x=1791366048;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KZWMHLE219x3709P+AjMvXHPWhrcV6RGzOP0PzNMJ8s=;
        b=rALvURbecP7bHCrA13+c2ZT/QPEgfVqmozGCV5cbZ2DgE2XzUwtI4biv6qFFMZ4BSc
         RCKmORxjsiBoneYv6txGqrCL6qS4rkma1Ij7PdW2XCzhfGkaDvImZJri234Ir8mvlkV/
         hGKNNnW9Y4ziS4CSwkfZGyKPHU7zjwM8P51wL6PbgFOWUShOqfhG4SPIP+WwE5xG/S20
         c9qExsWGIS755MBPV6sCFbSLTBG5/0x3mdgU1mXKf4MMe4fsJyUa0UScvL+6C9NdU4fg
         Ffyenbdym/6XidKw8a7Vf/BPgGUrmDq5UMWsyht1Vl2j7kplzgEl235WiLUe7tKveNdR
         58Iw==
X-Forwarded-Encrypted: i=1; AKwUvBwcIJQJV/NkhgN9lrFfvPh4bzWAOZpBTFvFc5ruXJse2IC0QaiHEvX3ohlEPmN4303m9GHOCRQNZ80=@vger.kernel.org
X-Gm-Message-State: AFuF++mu5vHyxufF+dwrMfgjxlm3quT8ftgedNY1P4gvrFH73B8Z9uPu
	Zs2BDD2aRyvOpUiUSHOCIf6ewQg7YhISZLv+ghC92IzmpAcP51jLR5z8QSq49ap8/u4bZJPxBNf
	FqS5fmgoGVL0Y8Pg8/xQECEACYz/xcL4uBrJ17Y8g+pUM2cbpcwRSzNJ8sNNwM+OPnTACftB9p/
	znS55T8RsQyoQkr2kEfPEYeZi8oLmojJYPYIrlDA==
X-Gm-Gg: AYBFou0U+I5S6cXP0/mkf2BY7V+wmB5USW4OlUJsnhtVxcMRjTS+Pqluqsr3d7BvheA
	eA7HGHky7DIjNCEJknhuYMLImgCBu7M00zLZQXP33OXeoU+6E6RXVh849j+WoL7vj9SZdIgABrA
	CNO5NaPoGpjBGMgQDvoyGaeTAU08vZj91zkBXjrcnAXbPhLdZV4BPTmCub6A==
X-Received: by 2002:a05:6a21:6194:b0:3de:4275:6a03 with SMTP id adf61e73a8af0-3de9f2958cbmr512614637.32.1790761247576;
        Wed, 30 Sep 2026 02:40:47 -0700 (PDT)
X-Received: by 2002:a05:6a21:6194:b0:3de:4275:6a03 with SMTP id
 adf61e73a8af0-3de9f2958cbmr512591637.32.1790761247121; Wed, 30 Sep 2026
 02:40:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1790742751-245571-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1790742751-245571-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 11:40:35 +0200
X-Gm-Features: AclHuK-_lv5zzUnSrJjhUo8Ov2oy9JCpDePqu6u44Hk_CSvC55A3_11o4qmYvKQ
Message-ID: <CAPx+jO-8tii2kFmVQUfcYN5YUGuOpX_8aPg=BndPurt6bff2vQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Let mmc_regulator_set_vqmmc() use ios->vdd to set vqmmc
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAzOCBTYWx0ZWRfX1eiw7J8dV8Uy
 Pct4SW2WqQSws5JYy5YST6/x1gOptr2nHPHVBtJwqUSAZkizYFykbYLQQREJjGUixqg1rW/MlRu
 UmfC/nyUxxXDFoQ9DwFCA4pF8eAu+KZKVJUrCskR5tnRfpnQQLKn816zLxCIXzet5wXmeXEmMyY
 ELLS5Ug2qcVhqWj8WosKae2yHAAKjzF+jV5Pz6n4ntQHdzWNqJvn6KUSovJRCzCjhTwsaQMoqR0
 WALpUIb/Ahz/9SnX6yRAlcthbLt3rbexZKBg/JbKrxwXy790QRSbmEd+wnxNJxI1z8HW42dH4g6
 tFsc8HgkKydRg32U0g5xWPWY36A7FdtFVnQRARRARInoQesDhVX3RkWZOH9UHvzGePLiOLyNFdr
 wbGvzhu3fZaCj/bOYJtQRKIj97fyJBrwUsIbb8p6UWnJcvr4yXcTZQzWZF+ZJpc88+39qA0vAPQ
 T9uVI2qNBEqAsAHy1og==
X-Proofpoint-ORIG-GUID: rdhX7Kj877KgsjtsMVkcA_KTe7vnLvbr
X-Authority-Analysis: v=2.4 cv=NedzRGD4 c=1 sm=1 tr=0 ts=6abcd920 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=s8YR1HE3AAAA:8 a=Qqk-UaXwsSa3U4-5TL8A:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-GUID: rdhX7Kj877KgsjtsMVkcA_KTe7vnLvbr
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAzOCBTYWx0ZWRfX8xlMGg+4+rZ9
 GrsAQmYx/kyFdSnsvdeU1GZRDxXNAPSQK51nEjJUeauSMG7CNzO4AIZ7EJI2qbUkZ2nM5qSVgbA
 3IhuNbmAwy0AixKz+JKZDyd+E3AyJd8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300038

On Wed, Sep 30, 2026 at 6:33=E2=80=AFAM Shawn Lin <shawn.lin@rock-chips.com=
> wrote:
>
>
> mmc_regulator_set_vqmmc() derives the vqmmc voltage range from
> mmc->ios.vdd, which can be stale with respect to the ios passed by the
> caller. patch 2 uses ios->vdd instead; patch 1 prepares sdhci-msm,
> which passes a local ios with an uninitialized vdd.
>
>
>
> Shawn Lin (2):
>   mmc: sdhci-msm: Initialize the local ios in msm_toggle_vqmmc()
>   mmc: core: Use the ios vdd when calculating vqmmc for 3.3V signaling
>
>  drivers/mmc/core/regulator.c | 2 +-
>  drivers/mmc/host/sdhci-msm.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> --
> 2.7.4
>

Not sure how you posted this, but it seems like patch1 didn't make it
to lore nor to patchwork.

Are you using b4?

Kind regards
Uffe
