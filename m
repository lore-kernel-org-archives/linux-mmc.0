Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23746430311
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352846; cv=pass; b=T1sAuIzVKg2wR36ugyabR5ABvBMFStl8MLJh9WD1AKGlo1isjZrf54N89vR2wF1sojDnqqZapqiH4/OAk31nVs8gLcVhvi0P+MEFXbYrZ6uYJO4coOlBFAyd8f6EFHXIbhEMXAVTD+SJ+wBgF729YgPb7eqYTZ/jSi8RLZTaT+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352846; c=relaxed/simple;
	bh=Zb3cH/fai8fDmo5+VF4j0GwH/xc79uxvxl3GXDwcAhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvh4IAwvqBs+QfexTpz4H4t+AmFJJQjvSnyz9sXZ3n+7VX1IyQwetsc71abHWNm7g1wttiWuF+YqDOt8ZUJbUgghnDpXRjJ51yywQyryAlSKtP+ar2mfhQY09Pft0hcvHZugPTSmSz4S/pbQYkLtslwcgPpaaWFOKLpqKxDuTJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KEuW3qTD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ceaoRugY; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KEuW3qTD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ceaoRugY"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FFCEv990326
	for <linux-mmc@vger.kernel.org>; Mon, 6 Jul 2026 15:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XDe1SM319R7dXYpM0TKd1mksOi+amIB/t46psKRtyxA=; b=KEuW3qTDKSVLDEBs
	WHgcYg4mADpR1KremIPHqcJUE5rO9UXe0FCgTQUlCr0GGsBn1oAHmFJ6qFsOnGbH
	NqGAfDcCgi2FjZ3ZTj4flkfzWXbJghCk3+dN1uaFqs6S6zhQ1PwPWLzFuTa/aZ3k
	lDADQeuQJvTx8VPVcsOfVi7VBbDiBt/rX5OTHWH96MIwPNjkT3tCpZB+fWYNL6mT
	Dl57auozveBd9BwCQwUHY7YKr0lgsyf6dR+bi+Vv0Cte80Gv6shojFqsPRrXIZdV
	EJErFYAj5Q4nuoPFBX0/qjwfDi+91KmjhIL0d8k3vqo+r3ogmcWhAorQyIPPRMxa
	ybiAHg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gskcd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 15:47:24 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8eec6acbe21so74912526d6.3
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 08:47:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783352843; cv=none;
        d=google.com; s=arc-20260327;
        b=X/Czc24kDeUxKc0Vry40nBxS8GQ5o9ooM6NGefy4v0V+8ZXU7dd8NwyGYWwYH2smbE
         mCjUjPtYmP1IC2z+FEOL50xE45cyjEEvJF3zlzKzxVyJie6WLcQV8DtLgE7E1gobgT+z
         TUKCGxjqA+RhQlfpttb9kRCsJ4kwRfegfm14nqPt2R3sCf4fQeAuKK8ySIccnBRihLC7
         KUqOoDlbKCaPVE2zuaLf4dK10q0K2ncE2+c169WUsCJldRCKUsS1DVfHfhlRUxCryqH8
         NiJnnWfYwY0DsMdndeInMyvJa5dpDW7omZg+dT4sEymaTou5G+CbySK1iF2rT7i6x1gi
         715w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XDe1SM319R7dXYpM0TKd1mksOi+amIB/t46psKRtyxA=;
        fh=KQWm6djWuDONWj1mebeFe0EwAAj6rOgSgPL5LIHYN4U=;
        b=CDLUsG4Biy6xE+7BZa/UNPEoTVcjVzHYt6w/Lw8spsqAeD5uX/JcmNPMID9xmb4dC+
         7CMc09AffvK/YtsvDrdHMWhU2JqQqdB24qcgH9n2WKEfFg0CrkNZ0Dxd0nNQoSDh0bJO
         jAW/cn/AszWPZ74uirc9nBpvOOZb7aX1LA7u8KSQgprsaKIQybusJQduq3bDCKq8Ap22
         yFIhQGjNKcZ6Wnre/8ICTSb1UgHBLXvqF3y/YdkzuKmiGLZ6TvNwh7xXraizqcbIJuCh
         Wy2Z5SG9SSMzGOda3VtC+BA4eRDvFDUL4pIC7reklUZqMigUu/Y16+PSqkuMZkBDdSC1
         AODA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352843; x=1783957643; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XDe1SM319R7dXYpM0TKd1mksOi+amIB/t46psKRtyxA=;
        b=ceaoRugYoap1V8gKQPQHievEoPWz13WzrZR5hIjJ3yxW3H7/q45yOQBPWC8qBg3zKf
         InZQCxbh8XioeM+CLMxHMHdxPZsTPTssjYb9BNbEANlZmmCYM8x4k54GzIpi29pUhSPF
         dL2J4FeuZNyd77ltzkI/D0oGYlwsILFBXROX6459V0jIksm5OtpN8cDmcY0R9pWrNiA7
         wt/NuM2Zyy89HiswFZg70P2RKVpPLh9j4E2GloSMAg11aYab8T/785CpaMu9IK/QTmES
         MfF6OuoiJWA4kOwIR0rXozq4bj5S6Gz3+Mb0zzyvM1vXI2BrYqD/hSbPtNnJ4xmn/WMU
         qGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352843; x=1783957643;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XDe1SM319R7dXYpM0TKd1mksOi+amIB/t46psKRtyxA=;
        b=GfaeY6vCpehN+jZL/VGVVutGsf8Qq7l3BcRvCeAzto4cjRod0Xthm1Ondgd6e6EsqH
         kflX8cNiN4LDw8T3UxI9/yfLVRM2NbJnR+qH4Fln70DvZ9KO6nGFF535iIqME+RpA9+X
         1vFrZi2OAYwsHgUk8xwXAkCF3C5mIYx9GE00R+u4BXna+501f4uWPf0KfD84GEjdsagj
         agaS4IyVYwSvWQV/R4AQbQ3c644epLhIWiOvknykYWOKjpInl219nungsFYTfgP6AhV7
         QHuAmtvkSA7+NvYPXF4gsO6c8pQ9qNsj7zso/+SnlOCGvgpPvL2BhNK94UETVHKy9lMa
         ymtg==
X-Forwarded-Encrypted: i=1; AHgh+Ro/suu1k/pGP0QBhpIWouzgOGeaZ8R7+KrW1x7QU2tTj53225Ce36I8Akm64UIfxOtQqxDSXWDWSTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJOTJr2NTeWXGomhewZyaB7kNLY1l7vMu9bZvvpG54GG8DX44F
	YnPxe1+VRvd2ICRV6gJup8VacW57I3gmoG2YG3Xu7C9jT+jFqJ406Sjlw6iUlzm239i6KMhHxkh
	mZC8+dJaT0dplgxnsALhtEfgZlYfw/VVJt2X7F6X4/nuXxzBAnmqO1yQTXqbzdfeeu4HtAuqaRW
	sW8stHNltiuH23Mn/YmcC0/0CQgmdKmiCz/oJnZw==
X-Gm-Gg: AfdE7ckJq4/5tsB6VqdFBCTc1mRTNQ1qUHCDeJYWlTNB0EaNnWBjAB2s4a649CSyZ7v
	X45xCG6HOLk8ODGluFSPEhbFeVTd9FjTMB29NfQESzFOg0prNCmQcIsaQ4NyImobRNklwY/TOY6
	OHM1eo4VVKXpBvQYSqDORVXd1zOo+loUS4XLV2wxwkzC1aZGfFOBFYAsl+nfwJwp87eTvS
X-Received: by 2002:ad4:5946:0:b0:8ef:5c5c:dbfc with SMTP id 6a1803df08f44-8fcb4a042d4mr12696546d6.43.1783352843337;
        Mon, 06 Jul 2026 08:47:23 -0700 (PDT)
X-Received: by 2002:ad4:5946:0:b0:8ef:5c5c:dbfc with SMTP id
 6a1803df08f44-8fcb4a042d4mr12696066d6.43.1783352842865; Mon, 06 Jul 2026
 08:47:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com> <20260626063014.1275235-24-lachlan.hodges@morsemicro.com>
In-Reply-To: <20260626063014.1275235-24-lachlan.hodges@morsemicro.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 17:47:12 +0200
X-Gm-Features: AVVi8Ce9U-pzBFpRo6F6_AW1qMU08gSYjLH35DGEhvet44vD774wHB9GxPSvsig
Message-ID: <CAPx+jO9TEcARhBc4_SUqj2h0uMhguzHJUSfYMH10v9Yuq1rW7w@mail.gmail.com>
Subject: Re: [PATCH wireless-next v3 23/33] mmc: sdio: add Morse Micro vendor ids
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: johannes@sipsolutions.net, Ulf Hansson <ulfh@kernel.org>,
        arien.judge@morsemicro.com, dan.callaghan@morsemicro.com,
        ayman.grais@morsemicro.com, linux-wireless@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 3lgu-g0IDTJV4kGxWbdPKu73w4F2fezD
X-Proofpoint-ORIG-GUID: 3lgu-g0IDTJV4kGxWbdPKu73w4F2fezD
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4bce0c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=YPXFKQCaAAAA:8 a=VwQbUJbxAAAA:8
 a=HBoK9o11-f7nQtA1NX4A:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=R5n2JtruLZ7-kf9guG-3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX8K3LhIXdVZDZ
 aHwSZSa0CicMyYeKnctgsYI5P4qQX7Fa4smqFOJr72x+k0jornd+whbKP1j1Xj76UdWR8ii/OBc
 xbsu719nUbWRWxEWhH+GZJFHvvCDx39WWAKs1MUHysWD2p8ArsxrBOvo8nW9eEV0EuRClmFZbjn
 XfkqEuJRWM0uqG5E/VTvgnZ3HzEQ7CUzBY5lot/GMwDKs6DzTnuM8H97+fbd5I2U28/Hktj2SLA
 ieGPiqilQbchPfMHA9SJM7Ofk7u+dk7m7CRoNzMO00GhgkiO4/xBfv0054nY1nMpf9+B9H0RpaL
 +GXXEivL6TsfkG87mnWaln1gFQvAU08Mx0Joxjavb2W95EacOs3wu16xz56HANG6ai1ciSMev3D
 Yf189xg8i8Et7Iv5Prn92tn7VANOg09rVuSkCK8uJKPHPOqSYmJKaPYbladAkV7gLPTF0201LFj
 08rfDTcZW0cAmNeoG/w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfXwP0n8t+061c/
 JLs+nkp9m5t/gxZw951fd1y0eeYHAUeXD2atDE+NUO0lQufrPCkvUm1ZjExId+zBxBSLo3Wz26Q
 U1eH+KfBONtP6Sq2AEGehR0ehXtgETc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060160

On Fri, Jun 26, 2026 at 8:32=E2=80=AFAM Lachlan Hodges
<lachlan.hodges@morsemicro.com> wrote:
>
> Add the Morse Micro mm81x series vendor ids.
>
> Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>

Acked-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe


> ---
> Hi Ulf, since v2 we've made another slight change to the name removing
> a "B2" suffix so even though you acked v2, I suppose it's best to
> recollect again - sorry about that. As last time, the patchset is
> split once per file following wireless driver submission guidelines,
> but will be a pull request with a single patch adding the driver +
> sdio ID once review is complete through the wireless tree.
> ---
>  include/linux/mmc/sdio_ids.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index 0685dd717e85..bbffad9ae88e 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -117,6 +117,9 @@
>  #define SDIO_VENDOR_ID_MICROCHIP_WILC          0x0296
>  #define SDIO_DEVICE_ID_MICROCHIP_WILC1000      0x5347
>
> +#define SDIO_VENDOR_ID_MORSEMICRO              0x325b
> +#define SDIO_DEVICE_ID_MORSEMICRO_MM8108       0x0809
> +
>  #define SDIO_VENDOR_ID_NXP                     0x0471
>  #define SDIO_DEVICE_ID_NXP_IW61X               0x0205
>
> --
> 2.43.0
>
