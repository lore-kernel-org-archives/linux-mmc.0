Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA99390987
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169187; cv=pass; b=Q2YlsJQZGHJNsEkk1Ux1B2Z9tV0vXB7YYVWdKQpo6rLQJzP+pjvvuLo9qUnub6wcsqc3PS7knD+mVeelubTkAma0ea7GGPrTlQcf9jz9xktMcJYsx9FKDh4RcQixM1v4VyvdwkwsR/CJedrjGhGFoL6a2KKIW5D0Kv/k0cckuc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169187; c=relaxed/simple;
	bh=CYRMDuw+y2WIfUGRNRhwiz0KxMh/mfpfl53lxeGUyRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tskrps85LycXHJ7OSCcoPkCMD3itoESmIGu/JVdsKh7mv6YW/iIOt97lMpkWbn8MgpPE8urBzLHx++kzYDaM6J+7WQC1ZdmkZ6Sic5wnW1UwQktv/SegKSdA+4gHObCg7yyxyFz5WSKfP1j/s6g+pxlG7vDXtjbNNuvMf+M53M8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bKUWalET; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EClHNRQV; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bKUWalET";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EClHNRQV"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlYpL855731
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 16:19:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/nM+18oFo9xMbcyJq32Ax87Z5+meKINEq5a5KB92jkQ=; b=bKUWalETk2k6Vl+v
	FoBQ2UByKitupRIEGj7W695W69amLTYYj9srBA6/zhFstKzU6WEeItEoCcmO/tam
	jT3mLsyv2Qir7e8l9PfSoOOeHTPRH6vWioEkebExO62WO48TC5bGrfV4LkqTIj5j
	5T6ywoXIY6kfg29Fj5J7hcTz5hzHVx7g7G4/XPXga8mrogTUZm2t6vsH0Jc/IEok
	ARTtFRj6+aLTPGCKZ4vO0IxMt0TuhRl087oJHxONuglFb1OYaQm2q6I7rXSSjoXb
	G6Bbt603J6Th01hMLI14eFmYoXy8jxDPKYiihU0srMPNzaAtSjuc0/RlkBs/aC6N
	S+SLkA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fny9wk10f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 16:19:44 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ef18406878so38279916d6.2
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 09:19:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785169184; cv=none;
        d=google.com; s=arc-20260327;
        b=eDlFgH7Pf97W2dxNprWh7WlCY25aZPry9kDAphXujXhUWvsGI73jd3OZVjv9L9ZxUm
         dkJL4jetticFgVIcVeok11fE5BnhgUZ/yKW+hhBidMMYe8DYZRB7NtdjEo5pYjm5YuCn
         zfiA0zsRcFuhRaQ3Mrz8PwoOSVCEvMcY3ua5QMgwD09+hBMqCm0g9xS3izUl2Y3NsWDs
         IDYwDoTvhBbWzbTwsAX0Gdi2nBf9JFX/aA3W0RZsqcZVOgE4GclIic/q9cW+zmkV3EwB
         xG5uAAL/lBbU8L5yDDmhZZ70ap4Yy+bGkuEzrX0ENSkASuJWQGvvOwvKzPj3LMHdRqIl
         tlnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/nM+18oFo9xMbcyJq32Ax87Z5+meKINEq5a5KB92jkQ=;
        fh=QJxveW3wX7KpBiYhloUX+ZrpOJ2mTiXBHfEPytFsIp4=;
        b=NhVOcCBifiCFT+Xg6WNLxRAKBMHGJad5lxszArw5gR71lM2dbA8Shksi2o4Z7RkCvB
         d7AMqyYiJTos9WE/XSrxZdFHFCOkY6hP37arbcgiU/nCoQ8XrwmgCxNlN+oM6aRkyWR+
         U1/x7/U9tipxvSkPENpxWWuUeUsFD0t+cdYUzXlgiRgJqMUWfqjUu0JAgdTDclaAsJFP
         bMvNkfiqOBdvYXA7EK4M+DiyvawBDKN8h/eWVhPRHoiGx/z2Y0G3fUIaWOs3hObk+HEV
         ScASURjE7Ge4Hcjap5A4XCJrRs0QfH97b4pYhPu36AkqA1keucT00Y+MJDqWZFr/RfEg
         Pabg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785169184; x=1785773984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/nM+18oFo9xMbcyJq32Ax87Z5+meKINEq5a5KB92jkQ=;
        b=EClHNRQVUuViFZI7tvkymKL4XWPBghyolt+qYyV9ANx05GroqZ4BPjX7QAlERgtgq5
         FqJW8wvUA7VrlfY0WEzomMhNTegtWLUjiMkzvpbwOXeMcLEts0ENwa0fbSJ3hBP3ax9g
         JZJFjAtrmv80Wdqow0r36WHBGJJE4rQeQ7PMZ+CnCU7i2WlsdQEu3y7sYqTW/PGCyhJe
         YKS2wSlUoTVar80MdvUKx4v2EleMU3lzrZh43PfwyXSIMmr2GFJF3bRRUWkaVjVDPvBO
         k5TrIyIp/X6FM0lNjYruA+bdPSDJrLeFQMggVI5NZUmKEPDL69t/+BrrLe1FgKvCbq7J
         ySyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169184; x=1785773984;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/nM+18oFo9xMbcyJq32Ax87Z5+meKINEq5a5KB92jkQ=;
        b=IzhulW02fKjMaBDAtvWbztRuFNfpGYLJaSmgEjz0fSLe7SfpI6zOPKIRHkwUm1v0zg
         oX2BUGp+97rv8L39rL5ZEZKqudItQmfSkfQGUrYtw268oRXYA7hCqOe8MWTqOE8GCDYh
         hnTSkFCI15GjFUxRprtlYurrmbObUunbIuunLqWGXcZMJiQmNLzO7WVFgbKvnPx0nBLX
         bUN1cHNLWwNSt9wAVox826FX0rq2Vi94vbyYvShhS3gGKzjI39JgFz8BTEZphyMNYefI
         AeECloQB820Qv0DxEt5JL3BiW9vpnGbiBp9d4YDRcnH/K7EiIGNIlA8SgEnULrN2yGm/
         IJeA==
X-Forwarded-Encrypted: i=1; AHgh+Rpk1VdWps+r3w8qf1eK+Kd6AkOh7HvRsuVPbyLhybZlmEmeiKTzaEv5lhaWUfCiEMezMGADF///2Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLHTVPzLp3SF25fPXr0h4JQTqjRR4tKOesAWxl4AmCHSlmN9Az
	nqJ/g5NjCuIwDLP0bLNzCkhfj2PXIMe0mSdwXsA951EZyGcKFMNzzFvYfmFkvNhhzNGNHA01D9z
	oALABiWWAzs9umYrbBXFvuPPN+br6PzPESkiFbEh8KUk5ImYI2AazoV7zBKvQ+YpAm0oXrcQj5o
	6zoRKqQPt44vsqtmHve+e5xeT1uiEB8CvAb8nfXQ==
X-Gm-Gg: AR+sD11r2ie2/xcW41e7A+lAmDX17asP0vlYLv79Fns1qBavA4XMYHZ8p8QmR/WCIDt
	oSj5rZRAtlvEXHC6r9m96LMZvJ5iSlGHvvikKF/gYKwxD3A2LlZccJbgBGtu+dWWAmSk2KQdWm1
	GWu+uG+MI+cbLH4qcPVAegCZiomxQVRhJ711uJX00GknitnZZGeXUAlKfSSw==
X-Received: by 2002:a05:6214:540d:b0:8ef:cfa:2a36 with SMTP id 6a1803df08f44-90812699963mr2458666d6.9.1785169183678;
        Mon, 27 Jul 2026 09:19:43 -0700 (PDT)
X-Received: by 2002:a05:6214:540d:b0:8ef:cfa:2a36 with SMTP id
 6a1803df08f44-90812699963mr2458216d6.9.1785169183123; Mon, 27 Jul 2026
 09:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725185129.43397-1-kmayur809@gmail.com>
In-Reply-To: <20260725185129.43397-1-kmayur809@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 18:19:32 +0200
X-Gm-Features: AUfX_mwPlQrgFMQyjAZ5yXIWnjedtehlosD29SiCPKHDV_rQ9JCUMMSr7b3a9-0
Message-ID: <CAPx+jO9rFKorZ9DYQ7uNjRJK9r1+Kx6Qxza7GQChAWtzZeK63w@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: add MMC_QUIRK_BROKEN_WRITE_ZEROES for ESMT eMMC
To: Mayur Kumar <kmayur809@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE1MSBTYWx0ZWRfX3WoMOIX5Q/80
 TbnnqQaax5etIqV0tL1Cn2p6Q7uCqRfI55+RUoV29hhpOFD53bXmts7s8Jm5WPl3+AunuhUAGdI
 OzMctky4Iiugue+4lJ3/gVD33Bt6HNk9qYG8iCL5tZSSV8o4yye14sTzQGm5iaMWBTSP2ctrjBN
 j03vfFpbjEz5qUMm7pcPRSA2Tm15ucHv0AoLf43rYm3ukLqpsCZY1Yd0XrzTwdNYiHQ/1l2fu2F
 +phDJ5Wp4ij2hhHDzij5GmjgYVlv+5sC0NpLtkzcBW5Qy0m0sz3+7C6lWpfcZPQSzUdqWjki/lY
 uNr3iBuBOaQS3US+/gZWHe6dAtVFSHJXU9UuR3KOTS3qAbqwRmn2OGlnzm0HEGlm40YU9Lj5q7e
 qLs7mmY8hjGDv3LNibJTszF+Xt+LVu72tGXPrxEXM9NNjem5fZs3Bnm0orWD0hKPd00gD6l/SzQ
 iYZqIiQ2M3Z1tSyOmPA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE1MSBTYWx0ZWRfXxOJJfzvboiDI
 zi3ZMitW7IVFsBCyCIoUlemHee32YFdSHv2qNavV6HXrlBMv98Rh5ko3W+7apfV7y25R0GWd7Ky
 il8WZ6BGsRRJ+rIKdRA+6JrDPOs+GpE=
X-Proofpoint-ORIG-GUID: 1Y7ZcEMxkSp4-WlhpQ5Jr1yF2bQGFoRJ
X-Authority-Analysis: v=2.4 cv=E4b9Y6dl c=1 sm=1 tr=0 ts=6a678520 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8 a=ArojrkID1Xi9Fne5oiQA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: 1Y7ZcEMxkSp4-WlhpQ5Jr1yF2bQGFoRJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270151

On Sat, Jul 25, 2026 at 8:51=E2=80=AFPM Mayur Kumar <kmayur809@gmail.com> w=
rote:
>
> ESMT eMMC (SM0000) supports normal TRIM discard, but fails when TRIM
> is used to offload WRITE_ZEROES operations.

Out of curiosity, how does it fail?

>
> Add a new card quirk, MMC_QUIRK_BROKEN_WRITE_ZEROES, to prevent setting
> max_write_zeroes_sectors during queue setup when this quirk is present.
> Apply this fixup to ESMT eMMC devices (CID_MANFID_ESM_MMC 0xEC,
> CID 'SM0000').
>
> Signed-off-by: Mayur Kumar <kmayur809@gmail.com>
> ---
>  drivers/mmc/core/card.h   | 1 +
>  drivers/mmc/core/queue.c  | 3 ++-
>  drivers/mmc/core/quirks.h | 6 ++++++
>  include/linux/mmc/card.h  | 1 +
>  4 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index a7c364d0030..144a8f5e7d2 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -94,6 +94,7 @@ struct mmc_fixup {
>  #define CID_MANFID_KINGSTON     0x70
>  #define CID_MANFID_HYNIX       0x90
>  #define CID_MANFID_KINGSTON_SD 0x9F
> +#define CID_MANFID_ESMT_MMC    0xEC
>  #define CID_MANFID_NUMONYX     0xFE
>
>  #define END_FIXUP { NULL }
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 5d187e063da..3ee640056a5 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -191,7 +191,8 @@ static void mmc_queue_setup_discard(struct mmc_card *=
card,
>                         lim->max_secure_erase_sectors =3D max_discard;
>         }
>
> -       if (mmc_card_can_trim(card) && card->erased_byte =3D=3D 0)
> +       if (mmc_card_can_trim(card) && card->erased_byte =3D=3D 0 &&
> +           !(card->quirks & MMC_QUIRK_BROKEN_WRITE_ZEROS))

Please add a helper in card.h, similar to the others "mmc_card_broken_*".

>                 lim->max_write_zeroes_sectors =3D max_discard;
>
>         /* granularity must not be greater than max. discard */
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index ae3ece89d0a..91758fd7fc2 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -91,6 +91,12 @@ static const struct mmc_fixup __maybe_unused mmc_blk_f=
ixups[] =3D {
>         MMC_FIXUP("MMC32G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_=
mmc,
>                   MMC_QUIRK_BLK_NO_CMD23),
>
> +       /* SM0000 supports normal TRIM discard but fails when TRIM is
> +        * used to offload WRITE_ZEROES, so we disable it.
> +        */
> +       MMC_FIXUP("SM0000", CID_MANFID_ESMT_MMC, 0x0100, add_quirk_mmc,
> +                 MMC_QUIRK_BROKEN_WRITE_ZEROES),
> +
>         /*
>          * Some SD cards lockup while using CMD23 multiblock transfers.
>          */
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 9dc4750296a..938a4296b55 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -331,6 +331,7 @@ struct mmc_card {
>  #define MMC_QUIRK_NO_UHS_DDR50_TUNING  (1<<18) /* Disable DDR50 tuning *=
/
>  #define MMC_QUIRK_BROKEN_MDT    (1<<19) /* Wrong manufacturing year */
>  #define MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME (1<<20) /* Secure erase/t=
rim time is fixed regardless of size */
> +#define MMC_QUIRK_BROKEN_WRITE_ZEROES  (1<<21) /* Broken write zeroes vi=
a trim */
>
>         bool                    written_flag;   /* Indicates eMMC has bee=
n written since power on */
>         bool                    reenable_cmdq;  /* Re-enable Command Queu=
e */
> --
> 2.34.1
>

Kind regards
Uffe
