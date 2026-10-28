Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793184219;
	b=00PDGrU4Abga9/gQGc2GX4V+tZrOcZpxjRX5MaWoVU5prWlv2lNG5mKmbUTxxbhhVQas
	 AyoNjdksQ2qAdTUCXZkmDF/TV7pFYXQyN/FrZ06EzrX8iRN7mfnw0ui/c7AVjqOh8y5mt
	 0SEH/75gQMmo74JK0H1qE8Oud+O89zDzJbqbSA5CLH/1B4kEUzoov+f3FmVR0tthy9zlf
	 DM6nzOu+s+VO3QGGwu8Zy6xBojdfpfcWKzgROINg8S5VIFc/i4Bavj7q8ses+pq7t5YQz
	 V77Zwhenme/oFYkuvJXX2BdzA8hcTeBHLhjLUd9xkubkkeSBUbQF5rtDybVoVMZVE9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793184219;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=O1Rv4j/6uvOd08Dpf/Xz0pIpfr0jYSc+eyXt5pHDHM0=;
	b=xvxbM84bkkvSqaLoVTTCQw6A3XwRRJYIug2LvKxZHr9Yr45xJskK6QdrBFqFPhmwpXfd
	 M0ZIed9zSJCjOOKnXPtzu3tvOBrXxLlG/w0ayuMueY/sZNnPy/1py4cRlAl5PlW127Yf/
	 9IhgryXDfTP0XNltWMGN+D8Ef5BKzGjzsMD3Adaj743svgT42O3vE4MuUqHgcsfvm/E6K
	 hEr/ElYfVzOqRpaVo4V95qQhEpqtNasYvmREutQ6W/MKVtHYaYC0CflYAXq9uwoyONe/O
	 fjlkLjc1Wkdm+Fhx9TG1WjsLKiWZd2EssYJGVCXxt5MGULLpxv20ZYhFE2wWL4im48g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gnfmcqMk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I4QmHULz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F789606A31E
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 10:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F789606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gnfmcqMk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I4QmHULz
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8JxTi3892482
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 10:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O1Rv4j/6uvOd08Dpf/Xz0pIpfr0jYSc+eyXt5pHDHM0=; b=gnfmcqMkq6lA9KVl
	rPfmN6ahaWIQwN/5qy2ETROlTIP0r4NviPMFeUt6hs74cbawpaFJdcn7m4peLkrQ
	MBrH4iRtdLvmVhIUE8t71rQl0bwPbJ780swqbIOk1x7eQxUKkUkxRCAz5kvXPu3q
	TwynsCQH5luOfquuGSok0h9dqTH4Voafvj/Lm0jYSCZra0UbdM5i/vHKDndaJlpZ
	QkkyuLgBldDR5zwmId7ULX1n1fw1DxKjf8cfZpvfuhyb6aVGH6t5GtV4+BlnPYcq
	M7LZUAwphRTe863dJLNBi3QXLbjqI9DqSaCa5fqR4lorSe6PfH2L+hlaxQHh1GxR
	Ia2Lwg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk6f920qe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 10:43:37 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e832c03576so12800915ad.1
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 03:43:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793184217; cv=none;
        d=google.com; s=arc-20260327;
        b=E0pOoqzxp1Egahs1ptCCb3QS5bMZwRI7uLq8xaFXDBfELHc0GOVw18LYA3FoKB4YOj
         rZocKcgiAr1xnEMti8B3bRdD/ronjTR96lJgCkAnF1aIzGVl4c7AX8BTqH2PcxbtDWz5
         5cWj7TP4r4wF5rEB3BIfCx2OZ0o9NZtMPCMuB/bb1iy6Y3yS2PwMPzlrqynfxN4p0rcP
         NprkwiO4Z9eiHPcnVr4fSjKV1k99zDKpP7dq+EK8EK37Pa6gmXFUrB2UCnwHdHT69Qld
         H30oRJ+crQ/pFxdVGUFtWkv6TyNXfbgpqhOvdRbvvEqXpc7IwqPhSIRmBVjDQilSw3J9
         14jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O1Rv4j/6uvOd08Dpf/Xz0pIpfr0jYSc+eyXt5pHDHM0=;
        fh=6HDIuwWgKG8TwulPQAUUKEM9fA48P1EqVorDGHtg0uE=;
        b=fDG93GndfcQGrTGPlxrvPEjMTiFL1c+a1cemWz+IzEJfebWfceF8rG5h4dlyfoU+js
         I/27Dsqg8Ru1AqRFxK0Jggv60upC1J05j1Mie/JnWCc1x/8srV5vHRsrbaXuwknyn/Zh
         +oli5DjwHiyMjeCXm/l7A6H6h7/mkggbTxMoJaQbBCx1bPzCpBsBuuHR87Vi84GQKJov
         7wN7jQBErPlJCudsSp3my+NGGCzYXq2mVKQseWdrMbm4r+bHhO6nYfC2W4P27aF3BjCS
         reY50PwYgou0MbSUyACy/ij3bVVjqDJb4SBj+fcvqb5iSDPjfrN/kJmp0g8IeZF90tUE
         Idhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793184217; x=1793789017; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O1Rv4j/6uvOd08Dpf/Xz0pIpfr0jYSc+eyXt5pHDHM0=;
        b=I4QmHULzaBThIlQ+ZScCIJ6gnflPVZV41qNw1KAoo/CSjj7NneMt6WAE2bCu9IfMNg
         UD5uj7ijcAmu0ye//rjLbieifmAR887EoP2ujUln1Vd91AWEU9qeNtmooR8zP21BlkDt
         +0Zf/C2vkMC1qFj4QpLsfQzERgS/0y2niLYT3wT1dNFbYe/Ah20aQYy2k8VeXHU1MwTE
         M29LaZ9YMkFlYPX+h/gcVyn3Zp2F9+y1bc76QfpIakrjI2fBlTDEDmR4DzSkSxLAgem7
         UI/q2e+5hnnYAopG+OjtvmD6rIXg/i3/5xxFtTUV7KpsANLnhd0+ZeXRajFKfPcOp56A
         kN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793184217; x=1793789017;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O1Rv4j/6uvOd08Dpf/Xz0pIpfr0jYSc+eyXt5pHDHM0=;
        b=LHqoylcKuPfe4xrW7Vu09sK3bnuAB5mmduYQO9s+KB9KwnJjgGmUIWQ5BUQ8BB3zxj
         JxZDcgKLe1bkDBm0hRXFFDO0BfTPXAzb+fCu+WYWTOH4CSTNPvlYGoy+2hrDZSFub7jA
         N/x03AqDjJMigIDNPx5mznYUlX38FOPdiGEgaaIDZMxlZqNIi0OGls5CKHM3b24amEYH
         LSJgoHR09MuYbtLAiDDfYY61lnZU8drgvAbDBLL/SDjdblVwIXD3+vhLB9pbYcsFG3cu
         cHEl+UXpwlgctzzotCF9FBB7Y8uMh6vWvxeZ+v26OlS3ouc1FgQ/CotleEppCo6CYJzN
         JDpQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXU/HGLHTPeF5lS3Y+PUVpRH4ckLJZCgeoo0t9usWPKgaLUI91DwjoqPWcMiAmfOiIAEPrTi8FcEw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTuKsDvEFo0/vcOew04mKtjsPklYSVam2jU0IIXjwqNoVmO/ME
	7zdHqXp24TO8s8+xQd9MKnWpQ/fbxZ002Q7WJKiI0mmbxYm+YWe3PmZMF/4xEOgsW081+FlAQQl
	f/HoGVGoL19XZjn0n7EYKQ1jXUoByHhpganPgcCMn4MLxzlkic/Qh1vhrESA+w7SPayK/VRfe3D
	/rUVZj1whhPegulEKJOTErWQ4Gqp8c/kKhjZiNZi5VUhcAPJUM
X-Gm-Gg: AYBFou2pLqXnopl/ykCxuJn0jYpQ5zPt0EWCB8BB2we2QIDYE5IXUThX9xEH4/KXOg5
	r9+tIfhl/MRBBnnseQKoF67gn8TKQx4NtbPzEGFOZBElYttpONFpkCgpeOAWZNKBzvRj3MY7eSx
	NCA0LAn/8FKWKCYVH7WrrS+Vq5KtgCax2Nw3Bn9gXBFDgNNkcjhMfTqFbiOAlltnhVFO+xiuhDl
	GX+QBKKM8h4K0wkLA==
X-Received: by 2002:a17:902:f545:b0:2e8:8637:5e3 with SMTP id d9443c01a7336-2eb0052b99bmr17120055ad.34.1793184217047;
        Wed, 28 Oct 2026 03:43:37 -0700 (PDT)
X-Received: by 2002:a17:902:f545:b0:2e8:8637:5e3 with SMTP id
 d9443c01a7336-2eb0052b99bmr17119865ad.34.1793184216581; Wed, 28 Oct 2026
 03:43:36 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027144051.249211-1-ulf.hansson@oss.qualcomm.com>
 <20261027144051.249211-2-ulf.hansson@oss.qualcomm.com> <583dc515-855c-48d6-aefb-abaef26b2564@linux.dev>
 <CAPx+jO_+P-ksGzbYp9Aky7etMyKtTUvtAZJZJpauw03Y8zP0Lg@mail.gmail.com> <5ebe0445-a111-49a5-b9cf-0185d3c3f67b@linux.dev>
In-Reply-To: <5ebe0445-a111-49a5-b9cf-0185d3c3f67b@linux.dev>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 11:43:25 +0100
X-Gm-Features: AclHuK-qGveGNHeghifsFMqPAZAO8a978GlTSHJA7r_OAEvgCwAoy8i3r1F71po
Message-ID: <CAPx+jO98iHx=VRwyWgg+aQmduquLVZe9Q8FNNK4VwkizXB2A9A@mail.gmail.com>
Subject: Re: [PATCH v10 1/6] dt-bindings: mmc: Extend keep-power-in-suspend
 beyond SDIO
To: Shawn Lin <shawn.lin@linux.dev>
Cc: Kamal Dasu <kamal.dasu@broadcom.com>, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulfh@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=frhJ914f c=1 sm=1 tr=0 ts=6ae1d1d9 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=Q-fNiiVtAAAA:8 a=XdD-yPI1Do4n0GidWpkA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA0MiBTYWx0ZWRfXwFQ2wv95uFO/
 M70LIq+EoLDQjjgmEaI5C07iuJT0fgDzb0J6MMvwbeVtdJaEfMvHn+ywZJJniyJs5j3TmOYhWlZ
 zJqgTv5yyhpQ9ss6zXbADPjkKXmYwPk=
X-Proofpoint-GUID: WC426bzBvNvlOJiW0Td05WtvrCO2XvEq
X-Proofpoint-ORIG-GUID: WC426bzBvNvlOJiW0Td05WtvrCO2XvEq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA0MiBTYWx0ZWRfXxc5Wf9/lG19G
 Vf07wDYeg7jg38KNjbLhUCw0pThfCUgJ7WzbBdSPl592iTa/V0eLXtNoJ0n3zNmE4TGWTM6b0Xj
 rYJHuxN/YPRuW1iX/VdDZGFUhUGTpKktX205GEh/5fb+ikBGSn7+SZpPTzEGAJ/RBybEmag/QrB
 ZV7NYZlYjLelE+XDmpbRExmCw6bkFEiWB9Epddtv5VfjuVUGgMBUMbyvL0gk3QvCv3vhD3RJzgG
 +06yC0R5fYJPSPvs3pa0aGBfh5nJwrsmQe78lgduZixntfbWxvvyAubYQlrk4AJ48ldy1RpN4ks
 LhLxQuz4a1/ovVK2N+Fnv6q7Opi7GtgKXuvGxh3hcf/w+nFRs9LDVkTZ5blnTPkobaHsaHpOcDR
 5KzTszWxJb1VEjdEMkuf7qOBS70Mgyp8IiTFBquuKCHzmB//SeeGkYRQ+xfO8lGDznhJnoMV4r/
 AH730eBHIyjD27+6HIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280042

On Wed, Oct 28, 2026 at 1:37=E2=80=AFAM Shawn Lin <shawn.lin@linux.dev> wro=
te:
>
> =E5=9C=A8 2026/10/28 =E6=98=9F=E6=9C=9F=E4=B8=89 3:46, Ulf Hansson =E5=86=
=99=E9=81=93:
> > On Tue, Oct 27, 2026 at 4:02=E2=80=AFPM Shawn Lin <shawn.lin@linux.dev>=
 wrote:
> >>
> >> Hi
> >>
> >> =E5=9C=A8 2026/10/27 =E6=98=9F=E6=9C=9F=E4=BA=8C 22:40, Ulf Hansson =
=E5=86=99=E9=81=93:
> >>> From: Kamal Dasu <kamal.dasu@broadcom.com>
> >>>
> >>> keep-power-in-suspend is currently documented as SDIO-only, but the
> >>> requirement it describes -- preserving card power across a
> >>> suspend/resume cycle -- applies just as well to any card type. Drop
> >>> the SDIO-only restriction so eMMC and SD platforms can use it too.
> >>>
> >>
> >> I don't see how SD could use it from the following patches. Perhaps we
> >> should still be more strict here to say SDIO and eMMC only, unless
> >> SD part is implemented later.
> >
> > I didn't have the bandwidth to implement this for SD at this very
> > moment, but the idea is to add it for SD too.
> >
>
> SDIO devices have a clear wake-on-host requirement, so keeping power on
> is reasonable. eMMC and SD are passively accessed devices, making this a
> pseudo-requirement under system freeze conditions until Broadcom chips
> changed the situation for eMMC.
>
> However, for the SD part, I doubt such a need exists. It would require
> dedicated ROM code support, and unlike eMMC, SD is not used as primary
> storage. Worse still, unlike eMMC and SDIO devices which are soldered
> down, vendors typically have an AVL to certify board-mounted components,
> while SD cards can be freely swapped. The compatibility of off-the-shelf
> SD cards is relatively poor, so I question whether there is a real-world
> scenario for SD cards here. If there is no such scenario, this is dead
> code.
>
> > That said, I was also thinking that maybe it would make sense to add a
> > sysfs node to allow the behavior to be controlled by userspace.
> > Thoughts?
> >
>
> Sure, regarding the sysfs node you mentioned, we already have
> mmc_caps2_set() exposed to userspace, and we can add
> MMC_CAP2_RESET_AT_RESUME support there

The reason for the proposed user space node is not to control
MMC_CAP2_RESET_AT_RESUME. That is a different story, specific to
Broadcom platforms at this point.

Instead it was solely about allowing user space to keep the eMMC and
SD card powered on during system suspend. Which may be useful for
other reasons. Like, internal garbage collect and suspend/resume
latency.

[...]

Kind regards
Uffe
