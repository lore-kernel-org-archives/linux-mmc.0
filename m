Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B044AB1C4
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789056343; cv=pass; b=XAO5kbD7z76j+QXefmDRiZDCV7lYIj+E4oOODRYJYCKgDdRbYqZ4OK0lgatCMt/i1rO216JLOIvUpkW2bxMAVIJb+/cPYWrS/ysuGb7ArAVpjT7K5jOys6aDVoclM3bs1bCpQGWecBlGv/smdha4LJ43ix503MN+g4328wrlIsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789056343; c=relaxed/simple;
	bh=3oay50WY7oA0cOuOst6u1rwKL1yGnwSpPSeA2dNG1Fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JEA6qWVqX2l2rJoDhbo6o5qTdVsDulVJOg8H1qv5d8HrLEUm9qeC9eGuAiMI2i9Vx/+x6R1gDdpVv5yDz5pRWyu6spCOyLXvC3IOLC4S5k0+uJeEROlsd/96YGiEAO9OMO+WBiWc/7FPLw3YPvBLl0ejDMTP7rNZWroXsfWN27M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cDMfWZSg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PXH7aIK1; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cDMfWZSg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PXH7aIK1"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF4KCa1494228
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 16:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x22SVoUj0EMbaUzbs6EY9GWgQ3tV9w77TMiRTqsjhJk=; b=cDMfWZSgrgV39F7+
	pYOCoFZekczxkQzOAk7trY9ys3i0kyXPkz/DUY0YhltgFwxCz2cLgMn++aAJ9GCJ
	9Yt5zGiYC7IPyvHSHmrYqJEWasgmCM9AnX4bgBUiIGv0JiDJVOHbm+ePE2V1BlmL
	lEWQuTtk3gH7ovFYF1+Hb05/GbgQjFCBx9Z3AAbQ+owCS4asHUEKuor335KGv1b3
	zTLrVmrs3DlkYrQ5g0xtbXifMxhefMyIUkWmY1ZjF4SA/JeEZ4V59DUrZJIeBsZF
	j+y9peptrpesJNbru361cEx55VcxkXH98YRuAdPyl74nY5Gear2EcYHCaMmMzRlp
	wWOUsw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkwx9rucj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 16:05:40 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8663802b58fso4385096b3a.2
        for <linux-mmc@vger.kernel.org>; Thu, 10 Sep 2026 09:05:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789056339; cv=none;
        d=google.com; s=arc-20260327;
        b=RoklAWUG1zI+djF2n9JWsP2k/xGZqmkTugZ5rY/bR32X6pEzEe/sNqCL9zz/vOatX3
         +4srgFciwyTtgpgf5RWNbD4MTfldlOsZXhGpVol5Ux8N7/oqK2SnLuewaBlyxdLy1aBy
         XU7n7Bh7Xu5QGVVmJZMxNL6ZEZXCZARUepXIlKYRFNMIiTqhTa/PFxk6t5ZpNy9WBjAW
         LpV7kacgT3oATm/U89pFfNdywPICzovjGEnVj8SVRMvnxYGM6E8EQjOh+NiFbdnOR9ut
         wRk7saN2E392qlgEBupUjB0kpZndLYCveKRphlXyaJV1q/lKgZBwjdSkKW1DKyZaRmmA
         DI2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x22SVoUj0EMbaUzbs6EY9GWgQ3tV9w77TMiRTqsjhJk=;
        fh=4dBZWQuOXMCyAi1IsR8Fts58TUkcT5uNN3cFT/qImPw=;
        b=kH346CYzBVTRnKeElrx2+iCor7iWLdhOE4BeM5CBAxGdtw7svsxa7otAkYwP4WuJOH
         gvJzVWgBqBvFuqPnMCaq0kB722CwwvnN7WBsjSUwZJvg/9f+JMdMj9htxJdHUAg8OS1b
         isgKhF8Z+2PMRdoob+kdxR1eYJundPRbRcm/aUytVRDZV29bHPVZlt+BdS1uIgrSs1TS
         3hYCD9U18BjrszE6MpMZs4lubceNNt7eDTlcm+SreJdwZm7ivq7plKJCnT/8PI6ZWS8a
         vBy763jAQ7MiswN7eW+ucn4pXrlUe31/PUSA7LoTRkW0STrYm19J8V98vf37JC5sjcDW
         MJEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789056339; x=1789661139; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x22SVoUj0EMbaUzbs6EY9GWgQ3tV9w77TMiRTqsjhJk=;
        b=PXH7aIK1FhLupA0eOu0y+nEv61l90XDyAjXbvih6qCKg/i7Gp28ULDmw7SV93FapJ6
         7Y/nKgKD84G90bm514+7+rOwpA5PawIYFN0qFPuqZHEap9gg+5oeLCiT/QJxny6VeDMp
         ATUnSP+MrVDddvr4N6sA1nCgfyd8wMySjR97hek2eYSGzWr7Jo2Kzy6uJcQ5vU7dDkT0
         CDteQ7xn9fsLwtEk8I+SOtq4+GEnthipEbheHAJ7L2m46KpXyfPnpOchlKoZe7xk3W9U
         ekg8G3eo050p8NIzTmglmT2bq3Kbcq9iw3OUnGULGdILK3jDLfF+fC7HqjCE5l5ACQ8+
         Vn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789056339; x=1789661139;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x22SVoUj0EMbaUzbs6EY9GWgQ3tV9w77TMiRTqsjhJk=;
        b=oZr86BDv7z+TmF1d0ikdLBMGE9jJua+pZJGKspUepTtePsioBI3KE3XMSIMcRqDdkd
         E9ZxasO1Amhw6XLZDIwuyrlDcwEXQUfvANw0dTmE6Zega+EQ7JhbBRIvTtLpzbBhW3pe
         YWISsLe+ivLQx+c0m/xSLstKSgcKMZ45QjOO7U2T2DoIx+9MgzQ2p/A+72viiPiq5lto
         jR8HFRtnIcpJ7dgZO/Gcd+MC//8mcXceDuFFZMWwYITJ3amEf6su4Kkz+2pW0tUuBG68
         J5X9KbK8p1VyummHecBC8NDHatiRC0wa1NpeR0b/bZyw8IE954e49CjvxIoDXybn6mir
         wYLA==
X-Forwarded-Encrypted: i=1; AKwUvBzHk/HuZFEVIMa2MP89xc3xTsdNg9Ka1tuqWpoCp8em2IVkLaISpJaOAqVM5xKAeWxUCNBFd5p8xP8=@vger.kernel.org
X-Gm-Message-State: AFuF++kREr86VDBaz53HmBEDifxuMY42LYYIrHCkQfNSxlOr/0HS/Xud
	s4eRGVP+lvMCriDFfIftznguoIzEE18Guhj2sYZ8pPmkSJ0OhzRPQgrAuhSc7UxotOi3vO+jSHa
	vWx+GftqwynVjM0zdjVlNq9wUn6Ns2EnDvbo6CP+m+WNUPcM2irACs8NDPbHo9BIv9SBukucAkH
	WAy79mrMhJzaRxwsz5kDtv1mYUMXvymci3spmSNr7C9/11jg==
X-Gm-Gg: AYBFou3k4k8Y97AdgtDEdfPykfMUh/qGOkZcNTxuU+UTQbmrmsZnzNKiNiKkADPqc3H
	PfwcjXNPd42OHODMDffEGFxX2H2UFKjMZ/fJ6c0TK+9btZIoed3ftOsJ/v3w8MKOeCqTu2qEW/E
	Qq0Y0b0iHvpDo8jOS3l8ETICcLW405XY519rLPyTTWMQSQCWHl45jz99FJIQ==
X-Received: by 2002:a05:6a00:1584:b0:86a:881e:ea38 with SMTP id d2e1a72fcca58-86a881eed92mr4853520b3a.12.1789056339281;
        Thu, 10 Sep 2026 09:05:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:1584:b0:86a:881e:ea38 with SMTP id
 d2e1a72fcca58-86a881eed92mr4853349b3a.12.1789056338517; Thu, 10 Sep 2026
 09:05:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <50fc5e8a29e3a5e9a64c64c5f775d758dce39b71.1787603965.git.sean@starlabs.systems>
In-Reply-To: <50fc5e8a29e3a5e9a64c64c5f775d758dce39b71.1787603965.git.sean@starlabs.systems>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 18:05:26 +0200
X-Gm-Features: AcwNN1XxhyWT_Qk5KNRESJlzw706VHXCD-vgMwiHAKKnrAT2fNk77opUBhvOjaI
Message-ID: <CAPx+jO-TodBfjkJ6SV39LHWyTKDRj=P-Fq-VnfT=kin4VBKkvw@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx_usb_sdmmc: start card power-up at 3.3V
To: Sean Rhodes <sean@starlabs.systems>
Cc: Ulf Hansson <ulfh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE5NSBTYWx0ZWRfX6dIGv5IY3y/G
 1DPhp4jhpyeCC37d4817JkWAg9TfG1IHwU7Z9HlBZqk4xd3D/+nHW7jnTCldFLi4OwwiL+TJWYJ
 LVhIhcOTxKozqh38ilL8ieFhp9oDoOdUlGZ25mYGOSd1jlZRXJQ7rjPbqtBE3Z+/X9I+Q4Taldl
 Q27xmRpyvijEXNQ0s+HgRIwZ0A+9SzeBkrc/PyXFwmJE6BW71JNY+bY4Xx+AHmMOVZP4nV3F7AP
 gPn5eGI1jMxlj1XM41qJAf7qpAObJ7B12tjq4tAns43nMQ1QlnIxBuXDfebmOPeefJaR6KtlTxe
 +huPTQdbF32va+6PuXZxZ91xDddklcWezvR78nu55TV1QKd8CQWtxxWyURpsXJv1I/6oVMkWmhI
 FJoXcM3swRnQkZnE1lsrYOTo9OoOCUDAizXVxsnGBmJ2Ot2HtliNLox7DylS+b6RLvi6NBHWKu5
 KSqNbORHEpCJ4YosVPw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE5NSBTYWx0ZWRfX0XpNhCgLaM5d
 d6LISh+mpL7Z9Mw5D7CdMeI0QfWhQYHmmmzYUMaNsEycBEO1DKhaqP02b2Ia59kw674C8tAaxVb
 KLfIZkFH2Sn+E/ShEne+3In9ScEnnIA=
X-Proofpoint-GUID: e1vU8AOIywQPYuNnB6FKyj3iDfICjInB
X-Authority-Analysis: v=2.4 cv=TupzFzXh c=1 sm=1 tr=0 ts=6aa2d554 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=P4VcW8-MZ4Ji1alh_TMA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: e1vU8AOIywQPYuNnB6FKyj3iDfICjInB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100195

On Mon, Aug 24, 2026 at 10:39=E2=80=AFPM Sean Rhodes <sean@starlabs.systems=
> wrote:
>
> A UHS session can leave the SD pads and SD18 regulator configured for
> 1.8V. The power-off path disables card power and suspends the regulator,
> but does not restore their voltage selection.
>
> On the next power-up, this stale state remains until after the MMC core
> requests its initial signal voltage. Restore the SD pads and SD18 regulat=
or
> to 3.3V before enabling card power, as the old rts5139 driver did.
>
> Tested: StarLite ADL with an RTS5129 tray reader; repeated 1.8V UHS
>         sessions, power cycles, and tray removal/reinsertion.
> Tested: StarFighter MTL with an RTS5129 trayless reader; repeated 1.8V
>         UHS sessions, power cycles, and card removal/reinsertion.
> Tested: Both systems re-enumerated the card after every cycle.
>
> Signed-off-by: Sean Rhodes <sean@starlabs.systems>

Applied for next (or should this be a fix and tagged for stable?), thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/rtsx_usb_sdmmc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_us=
b_sdmmc.c
> index bf37fab233cf..d9b33aa79165 100644
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -980,6 +980,11 @@ static int sd_power_on(struct rtsx_usb_sdmmc *host)
>         }
>         dev_dbg(sdmmc_dev(host), "%s\n", __func__);
>         rtsx_usb_init_cmd(ucr);
> +       /* Start SD init at 3.3V, like the old rts5139 driver. */
> +       rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, SD_PAD_CTL,
> +                        SD_IO_USING_1V8, SD_IO_USING_3V3);
> +       rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, LDO_POWER_CFG,
> +                        TUNE_SD18_MASK, TUNE_SD18_3V3);
>         rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_SELECT, 0x07, SD_MOD_SE=
L);
>         rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_SHARE_MODE,
>                         CARD_SHARE_MASK, CARD_SHARE_SD);
