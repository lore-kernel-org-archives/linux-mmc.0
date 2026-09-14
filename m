Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B4541D239
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789380586; cv=pass; b=IRrNjfWCwT9WuW2yyByteTEa6V1EFXyXaZz8omX7X72VeKxZuiLK4D3pk4udOZBp+O6PLX9amYBb6QFFgL1s+M8Pr1aigMLyqvvr1yHieNgXa8DgbtkuM7/OTQaG5XVSFXRMiEdHTj5MZDYST1ofamnCOmDuSPBIduJaPAr6kV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789380586; c=relaxed/simple;
	bh=vzB4SNwuhwwMCxOidCwj+63w9/MyrSbVoksqvS/1/30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/n1EuVoF8YZdeDl7huP/OdafIoE//tYQF86W4FTNbrU5pPM0MehXjNWljY/qIaPr9u7MFcxElCNjXXpWPvnt2vJ3Wo+/BX/vp2cA9zKr75nPDvs41m9/udYyVt550q6PMRHOxzmjpQiArVvKj1I0XsnJXKXPCYix7yIOrHqEYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B8JZ0G6q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ToYcf2gV; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B8JZ0G6q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ToYcf2gV"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E9nYpb3731565
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 10:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qighZoWM5dpWx81QF8Cb15nPWbYF5m0mVf/jdXl/6iI=; b=B8JZ0G6qGoDuiF7+
	CwRpKsVFlPCMb7N0MZiye72Ss48g3p8y4u61X2fKIz/6igzFOBTOCbsWtOwfP+5a
	VEfCKL3INfj15QFZPG/lqxZtt+z7SwZMnbWKmNKQwXN6n1Ji2iINhQfpAGQ4EsiP
	WXrvFOzz+1RVaWItJTmQFC2f5C0IxeByYNcdYgCbdZhAZrMjBWBT+DoLiWoYS+jt
	300p7sylN8LXLwXL6GOIJvjaSSrTAtFxMnF1sE5glZzs2IUHXfozJMgJSXQySD1j
	Rr7Qyl5gR4Ya2mqwPuVwe1aMXbMM+OlOyxbJqf9rETVADb3MJUHOp1kis/IdyGp5
	9jeJbg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpd1f0e9w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 10:09:43 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc4ac5feaa4so4690834a12.1
        for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 03:09:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789380577; cv=none;
        d=google.com; s=arc-20260327;
        b=oI15r110aq3ivBmWMpe6FBCRs3vJ3FQvDka8OFtAL4PEHw8eF9cf4b2+pWo5TKOip3
         bClOOUZHVczjVE6ZzFSmXzpzfLn3ZTbAu5wHdgVEMGxpaut7HjLaJfGtrLimxk4nsIQp
         coRm0bEaZyyq53UO49VyafmLwFjadWWIwUDEoZJKcuydwp4aBo+A8jUYQeOxKi6unyRZ
         kHOjfRUWxwVnyM9CTLuAt8CIFgosjCbPE+FP+yAxmMHRYA6nuZ+obBF1/RjZbAsaZkqb
         ON9jECvQ4WNizMpCvH8M801Dfq5+o/xbq84pj4arHg1ggXMPB/Dq/ByWbRkOesloIb5J
         Js0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qighZoWM5dpWx81QF8Cb15nPWbYF5m0mVf/jdXl/6iI=;
        fh=EtLsZfo5iVXvCMMZmZqNuwWdux8s5Bh4rMFPNs1SYlo=;
        b=XPRCx85gzvijxFevC7h3HI17XeCn30KTtCJd3jYNZeaf1A4xhY2L5ooWUzVsvzqBm+
         V4HN9g1fjMe2MYVOmnaPgeSZXozSDxZ067vuaO8XtnYOMKEV8EIRcUbilZqxulFNqGc1
         aoXxh7eCDUhseJ6PqPMRubdwESnhH+Z0ObR9V0Kig93/uMPH9maoGBfDK4zweM76u/1o
         891jJ3rcmuNrwlFZdEzS9DOg2pwJh/I5ndGhiHu5R1y4ktYCjKW+Z5VaCrAgAx4QsVzM
         VgscGh7DQBhVgNGs41883S3LMRXfRkRlXGiComLhYnHnGesoah8eJZSryp7fwN5UyEHF
         cXyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789380577; x=1789985377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qighZoWM5dpWx81QF8Cb15nPWbYF5m0mVf/jdXl/6iI=;
        b=ToYcf2gVttctDd/kCEAUapKmOC7KQNY0aaxvjgJNoX3fjioSDFYFdYwDo/k+3gXAjN
         nnqNU1E53shqZQApz79IjikGDdN/18N/+IjuZgRIc9htG+mObA/sFSOz6B6cgDEPOUgU
         cM1bsdwMPzuPT8TLpTC8cYO5MiJHfAPLb1r70zD39rkg87VZWn8z4MvppryahNxMkIxr
         K9748Jbonh1Eg4KyffTEAFvDIuW+XZWb2hD0TY158FZvmETpjM6Qh72GXNzQpQ1auCI5
         n223zHPgbqPoeh1d53Y7lpUu/uTbDeLjDL/+t4IENvTULO8g6XJGAsr8Gx0otwMtmVXP
         jWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789380577; x=1789985377;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qighZoWM5dpWx81QF8Cb15nPWbYF5m0mVf/jdXl/6iI=;
        b=J8BE4WAcmEE34M9o1sPUt3NuZal89wu+den4koZw2oC1CC6ltByjRV0YWZa69dUvrQ
         SB7QrSLMa4BktIIFzLlOWtGp2BFhJDFTcPwbPX6VTtfIkALU567mXmjZ+T8D9KkNOxXX
         o1TDhMx+wpsW1Uex8zVZCr4t1plzJg01uPWw61Ira1hCcbpncKYOZuxedXU90LyiJbA2
         OqPsWX4Wl2uody2zYkrX0hlN6/vSi41aIeg4ltX2lQd9HJKENI/9UgT9a9H3Px1gsUzg
         3CypzuBJ8k0PiLG0+ol0uTfkpVfPGEWa9lTmqnBEynYI204/mk16KMuQVKAhMokzSOfh
         j0FA==
X-Forwarded-Encrypted: i=1; AKwUvBzO7+DpF035K0qd8hek73wjVelkeFGobc7Tjd2pGM7/0LRycywX89BOYUMoJ+x/tNAL7CR1sxK5A4E=@vger.kernel.org
X-Gm-Message-State: AFuF++nUY51d/UcQXBgED3HpAvrxF+zuVnp0szyzvfaf5FzLlkSDZxtq
	8tzoxVe4X1b7DCLYzQo83mksMI3FFmnmTd6w+9F70iiSNJwHrJpIJbTW6ZKwCvL5iDDaU3INqoa
	PuroAHJgayUo0VY3qiiZS5eswXPviEp1kRNDWpo343RNXfuGdtvQpMAe9RY3xUz22gZ2dl7yLpj
	+6EeN0G/YGfXKJKLlXsCgmLLPsJbq2PIFU69WCvA==
X-Gm-Gg: AYBFou19/QR3EYUXUrclCQXyMHyqS4anIXBZU0rCMta9gIjdi0rRaeVnBc+7nZa8T2m
	zAjwoo+nXzWUhqn0tGOvO0VervY1ABrKqAY1MRurIVoI3GjvyiJI1aic8ZCUA1mHff0BxKY/DRk
	NNYuUzGtF7Pp9WTv0oU1jmahav3skcuGOkqVaHol9U3Scm15Q2vMj/1CfbrA==
X-Received: by 2002:a05:6a20:6a08:b0:3a0:bc61:62e6 with SMTP id adf61e73a8af0-3db404efb8dmr4344915637.8.1789380577306;
        Mon, 14 Sep 2026 03:09:37 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a08:b0:3a0:bc61:62e6 with SMTP id
 adf61e73a8af0-3db404efb8dmr4344857637.8.1789380576896; Mon, 14 Sep 2026
 03:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911-mmc-credit-ossman-v1-1-9e914bf2a57a@kernel.org>
In-Reply-To: <20260911-mmc-credit-ossman-v1-1-9e914bf2a57a@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 12:09:25 +0200
X-Gm-Features: AcwNN1WskC0GMfDOBDRWQ_J7Zbtjhdka9VHK7jDNjM8d-blsUVrDTxh2q6OtXS4
Message-ID: <CAPx+jO86_1EUwp6MHtJpykEDH-jby_owub6-QcYRGjew6BkSJQ@mail.gmail.com>
Subject: Re: [PATCH] CREDITS: Add Pierre Ossman
To: Linus Walleij <linusw@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Es3cuKybY_LRv2Onf0SwekoJHjhVd6xl
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE0NSBTYWx0ZWRfX9MCFhbW48yzP
 +URDCvqrLBEc7IgX8Le1pj0kEXFpKajuq/I9PJZ2BRUytpFzCj/VUDgpvux1up1F9tGhV4R/08z
 5uRbejMOT0a6/vtvFN9rfl/xCtq9nKg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE0NSBTYWx0ZWRfX5gS/Nntplh6U
 NXlOTaapap97+ZThcjDUw8cZyAGAY9GRxryae13ylzNCBIKIeLiJWvmeok0D13VuD/6dP48cnbr
 7IWgx62n33TEopCV2wbULu1/l72rGRP80YON8owJbVGa7d0zDU2uZba/N4eetLlsBuUyFEzwC+K
 wREiW92Cj7THYj1LHcI4hb75+6huSQftyMhKkgGLpPMq0D4m5pgmBvZAdYo9eOY2e5p4JGH9oAk
 dQNy8eHmqajGOymMndC8QmPNfnkkMsnce3+r+DZIWPGNULl7C6Rz6EYh8i+7MN+SCoMOq5GVaYQ
 v4PRa0JS65/VF0ljtn2DafeFfE/h5X/uAzjTfe87Sr/VVazWuxUai15kMx1VTM3aARpWAa8O4TI
 I6CYk4EOx5JDGm69RXkzY9yiTQsZZWo5IjTOoes0IDu93jAetKusCZdLAPOzVY3y+h4nCYM+UEE
 caBUOpB21AxfBVhdL+w==
X-Authority-Analysis: v=2.4 cv=XKel2ghE c=1 sm=1 tr=0 ts=6aa7c7e7 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ncCQWe4oCxf8H951awQA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: Es3cuKybY_LRv2Onf0SwekoJHjhVd6xl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140145

On Fri, Sep 11, 2026 at 10:09=E2=80=AFPM Linus Walleij <linusw@kernel.org> =
wrote:
>
> Now I have a bad conscience for removing Pierre's name from
> every dmesg without properly adding him to the CREDITS. OK,
> it's an easy fix.
>
> Fixes: 366b5941566c ("mmc: sdhci: Stop advertising the driver in dmesg")

Not sure this deserves a fixes tag or does it?

> Signed-off-by: Linus Walleij <linusw@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  CREDITS | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/CREDITS b/CREDITS
> index f8a33916e2a5..bcc2ce59b935 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -3109,6 +3109,11 @@ N: Peter Oruba
>  D: AMD Microcode loader driver
>  S: Germany
>
> +N: Pierre Ossman
> +D: MMC maintainer 2006-2009
> +D: First SDIO implementation
> +S: Sweden
> +
>  N: Jens Osterkamp
>  E: jens@de.ibm.com
>  D: Maintainer of Spidernet network driver for Cell
>
> ---
> base-commit: f7e3f4d9f425cf4c5577cd84a096e6e618488083
> change-id: 20260830-mmc-credit-ossman-147a6f6ce81e
>
> Best regards,
> --
> Linus Walleij <linusw@kernel.org>
>
