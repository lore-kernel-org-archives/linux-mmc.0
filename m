Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5457314A60F
	for <linux-mmc@vger.kernel.org>; Sat, 18 Jul 2026 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784381589; cv=pass; b=Zkpn2PW0TjSjW+Xo8HfRx4ulPf3pIAZ3z8raOTB6/ohq17VFh4ZECc7OVA2QkcgcUBFiJD58PhOhBRhOtaIwqZrljY+/6v44rF32eS+b00SAc/tzWQsFDY1IhNtozcJRGgReW4ZLkB24GF7AnH+ymAhOY4A6yv0WSdHcwCqplco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784381589; c=relaxed/simple;
	bh=HanH8bEZTzNYtaOvaRRl5NwwwHhb8nLc//DBSm0XnGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0VUsPVYdvTbopfsVMwWieCE3odB5KepoF4T1UGYnvtDDsFx/a5sBYKZZzn/BdW0zOn2JPMgmgqlnWr314T9tmXe7M56G9GHtXJZRCnCngYU9xTwOU/RUO6lahjDZtQIf3OG+76v+IWW1oEEqBOB9qKsa71wRvHF/yIp/QfxVaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UBcGQ8FA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XwBHQEPY; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UBcGQ8FA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XwBHQEPY"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IDCmZw384575
	for <linux-mmc@vger.kernel.org>; Sat, 18 Jul 2026 13:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	42FNr3At/x5ESx27Y5yuzAt/FdNQD761VHVo+BbeSUs=; b=UBcGQ8FA39UiIjgf
	sFfg/Jmjmhd/Xb+N46OXM+rdu3MdVNM2w2CfmUcEOf5CdQPliKo+WoRBIGm+3upW
	8HsbnuxxLHZQwq/UFkp7S9dl6QsNWYKLP/USny9okq3veeJLwUEUvrenAhGfYUj3
	geqATmnspv5wb4KyMLXgw+bix056uxlZFFq1A5LhWkApyQssJFiNVJuLr5PdMe3O
	e6j5y4tsB0CvnfeHZfWJdw+QZ6buTfiU2N2rKE3K4+8la3P/PoNIywyXbH9LvqCv
	LlYwm4sfaF617+QPeu77d65Cq8PGy/7OsUIJE4O84e6KsMcCJfR9MGONmnngJ2a9
	Hoh6Yw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2nhgsh5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Sat, 18 Jul 2026 13:33:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e55f0613cso1266217585a.3
        for <linux-mmc@vger.kernel.org>; Sat, 18 Jul 2026 06:33:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784381586; cv=none;
        d=google.com; s=arc-20260327;
        b=YzD7KapemJfUViQgvp/huQvQL4Xrbk/32/p0sPGt2M33F5aCGJdGHS4ji7J6ea82x/
         HSuZF/MCxSlqUKh2ZVVjK0yXb0PdqWP1L2wcDqxeG7R5EsHW+7xeNFgKYPmJbriXY7nJ
         Zh1FBo2eHIGd/5OEj9lTVet7TZRi1ab9APQ6UacodF2u78QFe2sZyR+uI5S/y9UMw/Iy
         WZIQisJdcRYtnh2CsqjSJELLRwjQFJFdU59XFqV55oclXZAu5tUJHaQIk27KMzfn/y5k
         yQOR7z+HWMNvAfNU18Uj/nbPuFEi8LseRrpDCCG9SV2TT7CEGTt0JdxiF/VKQz61HcTQ
         OFig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=42FNr3At/x5ESx27Y5yuzAt/FdNQD761VHVo+BbeSUs=;
        fh=2i8ZgO5hXTktblDOqOFXFUIPoD9SKZtGmU8q4NKaxwM=;
        b=mtJlYpVS1OlJzNYVo0AaqqkWQ5TBfBkjvw8PIP6SIhBmeR1eiDSGxcu8T1KDyzoarJ
         xJjbesW5QrtnkCEuNdNZFSlkVfvRTWs3aAo9ye9JpfeKcW4qNuSWraCun3gjudnPR2rk
         wNFxeqdoocintgbZCS9z4nacpqRk4pcKVFKgttmCCtoHgwig1egNzPK24kXPVFJJyo/f
         33knwHjUL0oCAXEvdwcA9WC15X7br2ij+4G2Op9PeBtxVrt9aD7N3IRdfCJ6l4Soiavu
         tQuIvluuwPxmbtJPN9j8EiVk78oGgkRLvAR74zwsyOO1pdEWR8QTIOqDv4fhV4yVsluA
         4Ujw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784381586; x=1784986386; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=42FNr3At/x5ESx27Y5yuzAt/FdNQD761VHVo+BbeSUs=;
        b=XwBHQEPY7ts6p5GDfczBU6KfKVzL+i1M4OKfjFGC6JwE+uHtB1uAYhWuwsuQl1gxl1
         pf7fyPQe9tGOe39BYGREjZQHwVxtU4oHE6TvUbkyLcQuwDIyXBWxtQjjke2XHJ0JGYrp
         XrD1UdQ8QbBJ8LF0Y6he5wCQAPO0ZFQHFOEyQR2xyYxC8pmZDjUb29AXNvOo9g2YdLPM
         jsdADQd0MlzzyNlRfs4Mb95aa+E4rz/CVXCzhY4oE+RXWvVOX0jpaF+FCwLD3vaLp7Gt
         zqToUOMPl4m2B8i83QQoqEcA7aLT8AGfbVu1/vr+ySJ9UBkblTOqNbd6Bw4r2sbUG81b
         OPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784381586; x=1784986386;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=42FNr3At/x5ESx27Y5yuzAt/FdNQD761VHVo+BbeSUs=;
        b=kdDRWK3/Tn+4czL1Bnos93bmle2HI8IGm0+/8o7ltYPNAlg8qP3R92Qb8ZTDuTIVy/
         /d0V3ZNL6oANv28RLAvoW55yG6L88gc/D4ARiBkqd1mfC43jMzi3+/iWQ77fkT8W9H02
         1V1qXtwXBfOtVDaSa48fJavGZM9W28CzBDtmvhhy/C1M2P4p3msrJbYsQiSMvFKNBUnU
         EQqbtuHfWgOc+R72iFKxomHbyi9iS2INbNsoQ5X8YMrFIww5Qg4rM3f9MlNui0H+f2jM
         QLczdJYJKNeIf+3yl+oisdBU9CGyRxhyYNYPQnkzXU8/P8oJBLTR0ZPAwYPrXjNcy9P+
         N7IA==
X-Forwarded-Encrypted: i=1; AHgh+RqR/L+x/l5wVXEYtNLy4h5g+8ea1+vS66iwVzRn9gcI0IYrIWznE6EJQci1EGkbkDoaibbneBRfVYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXbwMZm+3jR4T+xhtBcM1ZKEDUenZdX098xLHm25xWSxxlYwGL
	aMqeShjw7ZUSFAyj4+kqnNACjpnXtSK9oJHJbulWILQrZW+VNBgRYjp6SZ9TAzmrPiH1Wp/w3c1
	JLmTx7YN61BulOf18C+WCgz7XeccuEqQ90sJuoSNQPbb7zjAmx6Mjtr+TeKvVvYh2Yy6oWRLQBX
	bdyXegKGTIqPXFuDQRivjtWvU2HB+YVb00R2cgZg==
X-Gm-Gg: AfdE7cmunJ33RFc+a8WmgI59CPB4eh68T7Hnb1CPuuQnrLy8kNlo9GHc+8+dfvvjeiu
	aPJG+IZyPLOADXU41H8GhZIQfS6vwxwHXoBG0mr4ls3NqEMp2yPNF0XRnI6yazDHLS+L54Uhfqd
	7W76cOd+Wt3tqShx5xAytYvNXzI5/X6WYgvteIVTEg7HYW3Geb+faUDaWIog==
X-Received: by 2002:a05:620a:26a7:b0:930:adac:1e99 with SMTP id af79cd13be357-930b3eb2277mr693996085a.38.1784381586342;
        Sat, 18 Jul 2026 06:33:06 -0700 (PDT)
X-Received: by 2002:a05:620a:26a7:b0:930:adac:1e99 with SMTP id
 af79cd13be357-930b3eb2277mr693993385a.38.1784381585942; Sat, 18 Jul 2026
 06:33:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717180536.1757204-1-kamal.dasu@broadcom.com>
In-Reply-To: <20260717180536.1757204-1-kamal.dasu@broadcom.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Sat, 18 Jul 2026 15:32:55 +0200
X-Gm-Features: AUfX_mxbJEWh0yyOj6ankKJdP2Pwv9z2F4va8Rdwv4_vds1PeyzxjEZjeR5kUN0
Message-ID: <CAPx+jO-atdUN1=uV=4GpRScWaRJ5-TOBhaGo4hnwnX=xyPpohA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mmc: core: Add a host capability to skip SLEEP for
 cards with a broken resume
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: Ulf Hansson <ulfh@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Avri Altman <avri.altman@sandisk.com>,
        Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
        Erick Shepherd <erick.shepherd@ni.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a5b8093 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=Q-fNiiVtAAAA:8 a=pGLkceISAAAA:8
 a=XiturQijqk7JkzwUXrQA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: lAFnPgS0RzGCzK0qf7KYUW5JE9XEmdve
X-Proofpoint-ORIG-GUID: lAFnPgS0RzGCzK0qf7KYUW5JE9XEmdve
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDEzOSBTYWx0ZWRfX/3klHQNX75Pc
 GRkFHE4r445TXnCRN/1BtTN1bLaZGBygFCcBzmGaGUAmr8lJbgF4z9E+ozd114PXYLRJTcXlm/n
 VAg7cDIgCLCqhw09BqeJaGPn9iSxMeqh24RroMTjD02YkwFXMyu+b4ZASbDoVJMAwZIgkoDE0ZU
 TRlLs2S5BLH9bLXKEEp56vIbLoZ9s2sT+YkeS7Cuiq+Amm7nP1/cvFgLwfdGORL/6X3fDyFjWV8
 szAAfeiMzod5lYFlui5Xhc5/q1QUnbcxex8hLMHbbPmnVp5ecJBVPToJUr6n3I9eW9GWyfT1x3u
 iBgSxSYfwGIngX/E1JyFfmvT4ug4wqa/AKVE4KEDTU54i1vrbsw0/bD5xZSCPzpt4slwcCeANad
 5X9H5UMc4jgtUfzUM2NPJmHxdCYoEc4VeyFNcdnbDi4Zj4zIB27M87rNgK7l8MDliv3Ue8x8lss
 wl3RzlQ+L0ELnQsNy5Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDEzOSBTYWx0ZWRfXzJ5wq5ZqcvcP
 xXCQVdzTjxZtNHViJLZfxQFpbICI9ZqUydXKMOlU5px1zIGlzZ0YjiQDkfaiDghwegmaEnP++u3
 KSc09YhWM1bPFX1qGb3pG5OFZLH3ndI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607180139

On Fri, Jul 17, 2026 at 8:06=E2=80=AFPM Kamal Dasu <kamal.dasu@broadcom.com=
> wrote:
>
> This is v2 of Florian's original patch:
>
>   Link: https://lore.kernel.org/r/20260413180551.3683969-1-florian.fainel=
li@broadcom.com/
>
> Background: the Kioxia 016G01 eMMC takes ~10ms to exit SLEEP (CMD5)
> instead of the ~1ms it advertises via S_A_TIMEOUT, which can be
> problematic on systems that resume from Suspend-to-DRAM by first
> pulling boot code from eMMC using hard wired logic that is not field
> updatable -- if the card is still asleep when that logic reads it, it
> resets the board. The device stays powered throughout suspend-to-
> DRAM (no software-controlled VCC/VCCQ regulator toggling on this
> path), and the CMD0-before-resume sequence follows the JEDEC boot
> spec, so this isn't something the kernel's resume ordering can fix
> on its own.
>
> v1 addressed this with a card-level MMC_QUIRK_BROKEN_SLEEP quirk
> keyed off the device CID. Ulf pointed out that a device-specific
> quirk doesn't generalize well and suggested a host capability bit
> instead, settable from DT (or derived from a compatible string),
> mirroring the existing no-sdio/no-sd/no-mmc properties. Oleksij
> separately noted that quirks registered in mmc_blk_fixups[] are only
> applied once the mmc_block driver probes, which is too late to avoid
> a race against an earlier SLEEP/poweroff triggered on an under-
> voltage path -- a host cap resolved in mmc_of_parse(), before any
> card exists, sidesteps that ordering problem entirely.
>
> This series implements that direction:
>
>   - Patch 1 documents a new "no-mmc-sleep" DT flag property.
>   - Patch 2 adds MMC_CAP2_NO_SLEEP_CMD, parses the DT property in
>     mmc_of_parse(), and has mmc_card_can_sleep() honor it.

Hmm, this sounds like this is about skipping the sleep command, while
in fact what is needed is to keep the eMMC card powered on during
system suspend [1].

Moreover, during system resume, even if the card remains powered on,
the kernel still needs to do a re-initialization of the card, because
the FW has already used the eMMC before the kernel resumes.

If you could rephrase the description in the cover letter and its
header towards this, I would appreciate it as it would become more
clear what we need here.

>
> The actual board DT change (adding "no-mmc-sleep;" to the affected
> brcmstb eMMC controller node) will follow separately once this lands,
> since that DT lives outside of mainline.
>
> Changes in v2:
>   - Dropped the card-quirk/CID-match approach entirely in favor of a
>     host capability bit, per Ulf's suggestion.
>   - Added a DT property ("no-mmc-sleep") to set that capability,
>     following the no-sdio/no-sd/no-mmc precedent, per Ulf.
>   - This also resolves Oleksij's concern about mmc_blk_fixups[]
>     being applied too late to close the race on an early
>     SLEEP/poweroff path, since the host cap is resolved in
>     mmc_of_parse() before a card exists.
>   - Reworded the rationale in patch 1's commit message and binding
>     description per Florian's review.
>   - Added a Reported-by/Closes tag crediting Florian for the
>     original bug report.
>
> Kamal Dasu (2):
>   dt-bindings: mmc: Document no-mmc-sleep property
>   mmc: core: Add MMC_CAP2_NO_SLEEP_CMD host capability
>
>  .../devicetree/bindings/mmc/mmc-controller-common.yaml    | 8 ++++++++
>  drivers/mmc/core/host.c                                   | 2 ++
>  drivers/mmc/core/mmc.c                                    | 3 +++
>  include/linux/mmc/host.h                                  | 1 +
>  4 files changed, 14 insertions(+)
>
> --
> 2.34.1
>

Kind regards
Uffe

[1]
https://lore.kernel.org/all/CAPx+jO-RJYCwKLLYCPZw8nR0VLVJ+UXPotXwXXRHGvar04=
QyDg@mail.gmail.com/
