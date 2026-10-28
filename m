Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793207760;
	b=kv7gjNtv3vtfTkBcvpvgUEXiNvYogoaAUlW4asmgBgCt0Y/ZrLJV0vvyIft519WgNWJy
	 Z8Ag26wcLpSDPQxAJNrgGPpq925AdgYFX7Xvjgd0P2i4jCxfq2a5h94YjenirWu7Ffp6z
	 JfjyKFZRLm21KasVm4eKHOnrzjk5GGbLu+dyu3H+QsnJdiCph8CSa5PXVQ/n8/TjeKZ77
	 vw99GYJWszBUqHyrqaaGtPLX5MNWNYHKJyXwSlZeOZOWucaNPRGSbkpn3qhngyT5eLJhq
	 R/ThGWLbV2vcAHZTZm9QgBa440dCqRtPj0S9d/eEttMVdEGs1CWfcXd1to4H2CgQkrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207760;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=b7nsMJW7sValYVhjJXsfkawpLrM4V9tFf1Hx1aaRkSA=;
	b=3U/5+MpQSHtg+oW4HILB48BkP8E/jUmcKMUOmOoARna/6vuzaP+dz4rSoi2s/tU2URvy
	 ClcK0OXmMAwkdO8TC55FTfSwl4vzm3jS3YfNGS78SlPfgfhANSjRHkARdZwWBtUusNQbN
	 p77D3gS4mVR1MEH/vs+1S/E8l5MwgY7CXrw999GqK1kdxpbzSXFKhzgVc37CKdPIlItOO
	 +d5IubHbCGJVU3IU8fBQKJlGQY+lGvs+QRvn+ZiqKv+26wKVq6KC5l2X9v6KCfYoFVjj0
	 DqoZjdvf1HhA9SD8fB2/mWbP5wRhounLGZw3rmKcguloUzeGO5GhMOmsqh1LEBWsVHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nzh1hw2I;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ORUwpGxW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C3E606A322
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5C3E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nzh1hw2I;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ORUwpGxW
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFAbNQ1153708
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b7nsMJW7sValYVhjJXsfkawpLrM4V9tFf1Hx1aaRkSA=; b=Nzh1hw2ILcA6fMGI
	UvDuD8hEztdN1udak9xdaOgMfqFj4Apx/POTfIW6zHY7jO0xUfF4pWqGGqM6WMer
	BvXP3cGL8ka2s9O5slyHUcx4rVUT2AJ17zuWVysfLXs7t/2krlr2CKKwosm2vdSJ
	y2+J0TNT3PtvKhxuJx3ZQxzIgi5cki+DzF3AfJxSTDOaFcIeJRhPFCYq3lArSVx7
	H3IPHBrMty9croHEqkOk5d20A2hWN4cPhyhCTfA2JJ04QRECuKJTakwEfGCTry+a
	jQLJQ2inyPcF7Ja+ltCx0w59kKRsV4B8DR4dOH+56Wbv0lZ32tSqwJXDFnwaPMZO
	P1e8Rw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk6be3prj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 17:15:52 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a08e315b5cso541282b3a.2
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 10:15:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793207752; cv=none;
        d=google.com; s=arc-20260327;
        b=Wwr5SWfNqhKuj1HFcVqTwKXbaFZWQMK42j0zOpdeahvFNan5lXWE//wsp7/UIWwpr7
         bjT9Znl32wGb1eOslqvsZX/PJmIYsOgya7tNDFSbJyeMDeWMX5LGhnLE+o8Qhfz836Kt
         fBHHcvSENe/ULrE2UHUEu1K3sAxG7ImFnPRmqcxat2/37S0/VKhUyZRZa/WmLGNlJ4GX
         ypZjLZjfxLwhwaeOD31Hl8FCyKYEHryf4q9M8dQ8beG8YRfeQJvXxwmHixci5mNCy24d
         7rWRLMav8INs/u3HZklswx5VoPyWRrmocfVD45o4sIUFDHKZ/qf5EIzaiAIOPvUge759
         rZiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b7nsMJW7sValYVhjJXsfkawpLrM4V9tFf1Hx1aaRkSA=;
        fh=NcK/hDoPMEpS/xfs0w3O9atRm3Eu+CXZT7gkm79EIHY=;
        b=oGgnl7TClqelSgNn/OclfGqyomaH0EBMNy02SBMJiCXCbT1VaVRhUGEg4KIlP2ssBV
         bPUMTz+nJ4QAy0ayW8CbG5OgpD9Kjo7CQp1e6zU3TtHQkI8MVzXxDKaLnm1pFQeDrQ5N
         j5cQs4S5ppzi4Pu4eKRJwdkJqRV7Zk8HIVPkLc1Ao3gx0rAXvlSHJbq27krIkB4X1mY1
         nObs0ldNmLKcgJz9sDl0//cMN5maDvGT9MNhqKRFBTALxbPtyDR2QGm7fmLKWZBsifOZ
         5XHuc03IDmWkvLqWULhDzPHzsOXxUw3ufoQwtIdAXRwxonH1pFdc8YHidEJ8gcx6cfEU
         u6yQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793207752; x=1793812552; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b7nsMJW7sValYVhjJXsfkawpLrM4V9tFf1Hx1aaRkSA=;
        b=ORUwpGxWc8eiNaVIE6y8JZAhJ/4mQCyS408/JepFiY2YiMfW4U/dCEDUrwSRUxH8Da
         PhIEE55sZtp8JL7Tz0hIUyG/FG0gnxJ3BaEHQ6Q2ZxeOGWi5lcoU0/3Lw1bqeVbOE43t
         SVaDa74T7cJVs8f5ThVTS8GjsJr9k5Cq1fwk5/zoYI5zVO51X9nyfWb6JNIzUhAcc10+
         cWQRYUJ/X3gvpFGD3PtpUX8UussG8mVApsAdq5eQ00h3GUlhTCCyqtKUdDXpX+7B2PU2
         6smDqyrZ2RA9ATTfeeEhKTcXPbX3II6lwinnJYKumrN8Kja28myvzvsHvbGuUth4G8N2
         V8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207752; x=1793812552;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b7nsMJW7sValYVhjJXsfkawpLrM4V9tFf1Hx1aaRkSA=;
        b=r+6Z5wBBuMci7cli8Nca4fPzNN1N7k4JwDs3L3OXb7BQfHIA0SD6T3EggMo6xA4VRB
         1lIB99Gc6yufJpj6j/K2mq2PQW4HA0x8h58A8wYjKMFbiqIHCvBbxj29x3j6V7N0ZYfZ
         AwOrFcUclOMIoo9p2unPoKo1yYpIH5ziBElkmcDDtopJcfRYxqQCol87S2HywjBT6Typ
         0+MwYQnPq06+sWvsIVMnE4QjqY1VvK17FMrr33q75Ae3myf3LOdAEUUrZ0YvcIYm30GB
         o/Ec2XFzTkLiEx3UG4X7G7X65/ktCaaXNO5YcmNzvYe+zTybQ+dI1vdkfk3WA+FiwlU3
         eqEw==
X-Forwarded-Encrypted: i=1; AKwUvBxJ1CfFTIiVc8Xxry4Sjs4D6HhzDTiRHjseHdt1Mn78dgcl39CPIsR5etqRXZ58nphsC7Y4O5abmn8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKXlB5jnR9/BG0BUS7zB69Ne0cej6G7NuFTjJ0I0ylBN+zLfOQx
	croHXztJH9kB3FDSCCFb9+wIQKDjKho9nXPCWwOocevkY4Z/qZpT3l3pe1OzC4nYIQSmxz16gfw
	JRkXpc4rRuI3IpNzwp8v5lkLuJTSpW3S0fhPuRz6KkJVGduq7YIkXzLzu2/jI78SzAC7freSI2y
	GXfk/0TdXJSglIFyiNsKEWQB0L/vTzpLAPby6ekg==
X-Gm-Gg: AYBFou0mecXO0anpBeoL23JzHjf0161o82LOK4aJBFWCbOGvibwFtmqu/bn6ONubK67
	wJXWbLYQPceK13yaxp7yBVcpnKQn6eeBikPNENxXEFLBLAfOqPdFLnIxRgPfedZ0wY28tv10g7+
	5cfwaWIbbcGGAU3r82ninxDgf4vQ56dw5FhEO3XdBWdgejjrp01bjep1U+kQ==
X-Received: by 2002:a05:6a00:2994:b0:89e:584:bb77 with SMTP id d2e1a72fcca58-8a6e85a35f7mr2132740b3a.58.1793207751585;
        Wed, 28 Oct 2026 10:15:51 -0700 (PDT)
X-Received: by 2002:a05:6a00:2994:b0:89e:584:bb77 with SMTP id
 d2e1a72fcca58-8a6e85a35f7mr2132718b3a.58.1793207751082; Wed, 28 Oct 2026
 10:15:51 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <1791292726-31978-1-git-send-email-shawn.lin@linux.dev>
In-Reply-To: <1791292726-31978-1-git-send-email-shawn.lin@linux.dev>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 18:15:36 +0100
X-Gm-Features: AclHuK_ZhOCJb0opcJpYE-Aw09i0TqaQ7aFbqYnwFkLhA0o6DOoJbAk9H0bxz7U
Message-ID: <CAPx+jO_ghSFY31SJWngfhhEFGmmMxe0cw5sz=LVOadP-Y8wSLA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Fix max_dtr passed to SD drive strength selection
To: Shawn Lin <shawn.lin@linux.dev>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: PaPKIOq4XkyjhZOJrQdcWqPNwZbsQXb1
X-Authority-Analysis: v=2.4 cv=HeuB3SE8 c=1 sm=1 tr=0 ts=6ae22dc8 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=KYw6s9bVYVx17uabgLEA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfX5FoOyBFB+XRc
 u7F53VknoTQcbA7+D2HNT/qn4uDqDWwtsD6Cr0K2Cxtjjjfxh3rWFvcKJP4/icRl755E/m7Zsof
 Pq07bOphqMsY4uqKATmTJzuD6t1K3HU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2OCBTYWx0ZWRfX3SeXbZNpi0o0
 cfPU1+ZVDNzGXbmX0rbWzFElouLYr0/0UZJ8EVuNJ86qU0bdGIlPwFVk66MAgxbKzj5ZBes7Mdv
 TD69187WXBt/QOs1TYbL5EHNhR/evmNZ3kI1J+IWxZr8AsxkP0SfDNjvq1wiGwPRMZkMiSS1bUx
 ZDKd+l6GsuzFHvo5JgUdl7AtkKV1JZusJcLRF1RfeM0MEGdyJNpFUd2/AWJrC4+Pn4S00YynY8P
 OhzNhb636AvSG69xFy+wAUFS+pQchUIz83WP+/DYFvd2G0SSNQlxOehH1QJAOWUm8QZalPZvXm7
 /FtfWPCnx7DFdfHkfYXRhhNHa7wqQ1wYeiSNGLy4aQbKwRdhFw6N8CrxUQEipNomN2u0NRVrVIP
 VK/mrgEqPmr6e8+avKZzw+z6oMdEIrvETi1oNXY82GAqEJjXdfXK2v3a35zxqeLNYFajw7YDpIj
 JU8ZPoFucZVp7+kMAMw==
X-Proofpoint-GUID: PaPKIOq4XkyjhZOJrQdcWqPNwZbsQXb1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280068

On Tue, Oct 6, 2026 at 3:19=E2=80=AFPM Shawn Lin <shawn.lin@linux.dev> wrot=
e:
>
> sd_select_driver_type() passes card->sw_caps.uhs_max_dtr to
> mmc_select_drive_strength(), but that field is only assigned later by
> sd_set_bus_speed_mode().  A card initialized for the first time thus
> gets max_dtr=3D0, while a re-initialized card (system resume or
> hw reset recovery reuse the card struct) gets the stale value from the
> previous initialization.
>
> No in-tree driver implementing ->select_drive_strength() (AMD and Intel
> SDHCI) actually looks at max_dtr, so there is no functional impact
> today.  Still, compute the frequency from the bus speed mode that
> sd_update_bus_speed_mode() has already selected, so the core doesn't
> hand out a bogus value, and use the same helper in sd_set_bus_speed_mode(=
)
> to keep a single mapping.
>
> Signed-off-by: Shawn Lin <shawn.lin@linux.dev>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/core/sd.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index c763efb..5ba4e2d 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -417,6 +417,22 @@ int mmc_sd_switch_hs(struct mmc_card *card)
>         return err;
>  }
>
> +static unsigned int sd_get_bus_speed_dtr(struct mmc_card *card)
> +{
> +       switch (card->sd_bus_speed) {
> +       case UHS_SDR104_BUS_SPEED:
> +               return UHS_SDR104_MAX_DTR;
> +       case UHS_DDR50_BUS_SPEED:
> +               return UHS_DDR50_MAX_DTR;
> +       case UHS_SDR50_BUS_SPEED:
> +               return UHS_SDR50_MAX_DTR;
> +       case UHS_SDR25_BUS_SPEED:
> +               return UHS_SDR25_MAX_DTR;
> +       default:
> +               return UHS_SDR12_MAX_DTR;
> +       }
> +}
> +
>  static int sd_select_driver_type(struct mmc_card *card, u8 *status)
>  {
>         int card_drv_type, drive_strength, drv_type;
> @@ -427,7 +443,7 @@ static int sd_select_driver_type(struct mmc_card *car=
d, u8 *status)
>         card_drv_type =3D card->sw_caps.sd3_drv_type | SD_DRIVER_TYPE_B;
>
>         drive_strength =3D mmc_select_drive_strength(card,
> -                                                  card->sw_caps.uhs_max_=
dtr,
> +                                                  sd_get_bus_speed_dtr(c=
ard),
>                                                    card_drv_type, &drv_ty=
pe);
>
>         if (drive_strength) {
> @@ -490,28 +506,25 @@ static int sd_set_bus_speed_mode(struct mmc_card *c=
ard, u8 *status)
>         switch (card->sd_bus_speed) {
>         case UHS_SDR104_BUS_SPEED:
>                 timing =3D MMC_TIMING_UHS_SDR104;
> -               card->sw_caps.uhs_max_dtr =3D UHS_SDR104_MAX_DTR;
>                 break;
>         case UHS_DDR50_BUS_SPEED:
>                 timing =3D MMC_TIMING_UHS_DDR50;
> -               card->sw_caps.uhs_max_dtr =3D UHS_DDR50_MAX_DTR;
>                 break;
>         case UHS_SDR50_BUS_SPEED:
>                 timing =3D MMC_TIMING_UHS_SDR50;
> -               card->sw_caps.uhs_max_dtr =3D UHS_SDR50_MAX_DTR;
>                 break;
>         case UHS_SDR25_BUS_SPEED:
>                 timing =3D MMC_TIMING_UHS_SDR25;
> -               card->sw_caps.uhs_max_dtr =3D UHS_SDR25_MAX_DTR;
>                 break;
>         case UHS_SDR12_BUS_SPEED:
>                 timing =3D MMC_TIMING_UHS_SDR12;
> -               card->sw_caps.uhs_max_dtr =3D UHS_SDR12_MAX_DTR;
>                 break;
>         default:
>                 return 0;
>         }
>
> +       card->sw_caps.uhs_max_dtr =3D sd_get_bus_speed_dtr(card);
> +
>         err =3D mmc_sd_switch(card, SD_SWITCH_SET, 0, card->sd_bus_speed,=
 status);
>         if (err)
>                 return err;
> --
> 2.7.4
>
