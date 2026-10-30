Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793357993;
	b=DYEoMfTTJntlVfb+mwbuSSehE2at+2y6Er3Z6zP5vLgQgbQd9ZJXD4+nLcpLFg2s3q5V
	 PHBUQf3ZhIIVW4te51neln+mL+VPCcAl/Sz02FgOMoK7ypCAP/4jm+XqQQtaruOwZs67Y
	 Pc7XF2C0O/4SzrN/39Rh3MHTv4Cc3+ZATqjCjEPGNqujO5AAdjiYIhM7SBRqCmYUEC+C8
	 KVjIxjbEJfOhb9V647aIHoe1pug1i/Eeo5H3ahL2FRryQjmWlkyuwP+wbWt8S3KRGVEA7
	 +AM5zCutmWycZuowwNFXJWftAlAoxc3vfBFgkTwJ2g6uMUXXzT8wB1GGy7D3f08QPyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357993;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=vDOT/HhgUHlU3MjW8x4oJxTOedSxk+uzqpn5UVeZzvw=;
	b=u6dGbuWmFpWG7EiLs6PSOPecMawOFZASA/agAdXAIlb1O8gFirxT3Do6X0E2ih7quJns
	 ebX9tPWOPVvxXreg5rhRTZWLr5Gl5ugUcj+x9gMm2JKfRMimelfzK22IxsUTaRpjd1ABx
	 UGdmqEUj+aDKMfAo3zLtDmbaHLztLDfz8Epezvtwxch+c+gYP+Ufzbg/GiiaDqe22Ke74
	 +JZjPRGk79cUWydCrx92IzaM/Z8tYNWX9bg21BnyQ52+cpP454OQjw4t5MgrEfLgzrm51
	 WMHLleEchOcS4E4kDeYaJ2iHzb22oTo85mRJ3R/+a1isH/A9H8YBK7PWxh4jMcTksxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fiZbw3Iz;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YPvqMUXH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFAB606A320
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 10:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEFAB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fiZbw3Iz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YPvqMUXH
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8FFUK3709532
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 10:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vDOT/HhgUHlU3MjW8x4oJxTOedSxk+uzqpn5UVeZzvw=; b=fiZbw3Iz2WVzNyiL
	/M2RUyBdusck7Lux5DYqrcxzaHj/uIZ2SfnlUQ3x37efH7UaRhxFCiMKKqBSefBK
	n7MfyvAT8G5bWUbskRgoz9VjgVk8lU9IRkCnPwDtmydCno4pmJ1y2xLJRbFuWfNk
	i1uzkPSKpOP0uAOCUhobWrU0WiuIjDEiPnu3AzczA4ngNEuscVMMmFjLvU5V/if2
	dqIrn4QxNTsOSrNHAO2oBpV1baQCMsoiV+B0ZiedKB0Dkfrmq9Ku4wizyACfCJuR
	PA1n5GjLd7MYerUpASZi/ZRacUk5IzpHDNf0k54p1HibIMW9jdtNVfkX6VPNlKWV
	3oZ99A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6rjnfu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 10:59:51 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ea0fe07201so4343735ad.1
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 03:59:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793357991; cv=none;
        d=google.com; s=arc-20260327;
        b=pmuJ8aUPUw4/5mQtbvaHw2Xl3uyK+gDmW4rfrHih+Pq2nmmjnAMovpfbP1KKKMVu6B
         Ja3N63IdjAEEWY/sFI/6+t3d55eQN4oyHx7WKlJHn9N5zZ0dBLwKJ5WJdI9awVBc4LNr
         53kOJeq12/h34PJhjESWOQCMk9ACkl8m5l78yvMvGH4rvKPDG8RrnAt8RfaH7PX/8xFL
         +xEgfhdCv6ghjEw6hhJBzwIkcMmwoSoCrSekDOZT8plLjo/mQ5gGeNfA/nd1GQKUo0j+
         quf9cy5qbQRGGxWs19dUc3H0NLo2/S/TwoEs7ZjsjLdAp6KGjIxQrpgMfCOxhg4iQQOF
         5Yzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vDOT/HhgUHlU3MjW8x4oJxTOedSxk+uzqpn5UVeZzvw=;
        fh=418mtCXs0CXqIbGDUBxgFh6SfSQKARz/7AZY8KrxgkY=;
        b=SdTqnhrDSF/hHQG94gseA94X9eVX3vaUOlwvQl/IbbfusSL48RoEsLYqrS/0kJ+iYH
         rqnCTXNLCwO2eEdAi6gYiKIeVr0XTWDM7V9ysbjJ6b8KKK9JZYvArD2bE2SagS1JXxk6
         N+mCmYLtK4SBnIxr8JZAfl70ThamQOt+UyyNJH/meNkuiZFcdV+eSEgbopDzex47+GwS
         QNZOCjNwMFEWSWkrbzsJiuuBGB2LPFzc8cqLP7v63eWdh62eWmCDwydj8QG11JmDwuJq
         hHb7YiFS+3VE05ES8mrXNX7sI8QikHo8NCiYj7eCOMzx7VSkStC+pRU/q1Ozg2LWOAKh
         sXLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793357991; x=1793962791; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vDOT/HhgUHlU3MjW8x4oJxTOedSxk+uzqpn5UVeZzvw=;
        b=YPvqMUXHdb8aPsannhpl64ZG5AkzK6DDgrvV8I0GT0j/wpltd8KaSAmcQNVoJitj6P
         K9Q8738trmpUYPAX9rtQJNYGficFAR60/bTZRyA0j8X+DT6C2PtdP6ikG2n3u2pGqS/g
         ZCSTHAbSDLws7AuCQcJ1xMlpsFKeg/cm8Hd3odO6rlZIR1dwlGjV3ilF3XmXUtlnswa4
         tpjRNotkmd3SZJuoj0CjmBokTgprUcuSZGOEOdk8urO+V6uneQnFcj/MpZyAISallfUd
         /VVEfD4MOYb1A8/WGugt+L5/vYL3XIibeAOPfUPgldcR1NPBQXNNXBgEJitU0OYKoP+6
         fR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357991; x=1793962791;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vDOT/HhgUHlU3MjW8x4oJxTOedSxk+uzqpn5UVeZzvw=;
        b=KVZX//iQcNXlWjs2iKcGneZj4sSaHsgU51afIfXPAEc/mhIvum29KZ2dO2tDyXCbVx
         njg6SpxJcLAht5oEEdGCYLOrkUoQFdc2DJPCuDzEIAYiKM+dS8fL2z4te5HhOwDY2bVJ
         9qwI0/KORCJySL/pj3gY2rLwBG3DZA5kXBTaxrCj0KEJdxtslMl81E3tdrLti6+mINW9
         jJ2YDwYAa1sw1BjChjjtsDHERt9e8P0vmH4Ahw7Y+ujQ363VwxY2G+2oSivhUYEJUao+
         /kZHC2Fox95JdJpTGLApiPsJz7ERLaCj25YnPDfPlxiqNQaayyModepKXtu0NRI/cXmQ
         8BnA==
X-Forwarded-Encrypted: i=1; AKwUvBx4bUmtNh1RF/EGL5Jh3KxMPM0SzRlncr7BvE3D4eD5RbjWfrQQfLqC1E0G1xouxkaQ7ZIS1snxu3g=@vger.kernel.org
X-Gm-Message-State: AFq9FYISVxV22TW8yKwJxKGuF2G6sc8jM6v6GmBtF/V3Fqx15Q2JTBxr
	qyxdrOmnzIOQfpms8z19Q4Rmnx8BK30EU7xkLkKiWJyw9KuU04qUuGB+bW56CJ11Ps2IFVz9JEL
	YxRz/0rRhT0BZxmJsJmjizjvA56ZjIWv1qwOjhhLuQUepfDEr1+lx3Lp0n6pcG4ZWflX0fm/GQ2
	qa6meO2OcPcPJsmlar1DRTjz9QIjRN/ZH8W8c3dQ==
X-Gm-Gg: AYBFou1UlEnoec17/lLOATaX7VLOtnyvklGSfjPVX67OazExv3Mprh7wehGR0BgO039
	V15/WdduB70WuTBbpKkAEZZZHN/xXWlSWRw+K1E71BkeHqpRiW7GPaYGFs/DqVjW0HMFZn4Ir3O
	dMzkkJwNJbcoUo45x9JCrI30Sgf4rLUy8YS7bbML5VEPO+xsJQkEpIQ7u1+Q==
X-Received: by 2002:a17:902:ef02:b0:2e9:5714:6087 with SMTP id d9443c01a7336-2eb36395e9dmr20826085ad.5.1793357991353;
        Fri, 30 Oct 2026 03:59:51 -0700 (PDT)
X-Received: by 2002:a17:902:ef02:b0:2e9:5714:6087 with SMTP id
 d9443c01a7336-2eb36395e9dmr20825935ad.5.1793357990908; Fri, 30 Oct 2026
 03:59:50 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261009084604.385664-1-jerrysteve1101@gmail.com>
In-Reply-To: <20261009084604.385664-1-jerrysteve1101@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 11:59:38 +0100
X-Gm-Features: AclHuK-45tf3ThWkqdvsO5mUJq1nqk2GuMnJ2AywcP9iKz-UYyoXJpN2C39r6JM
Message-ID: <CAPx+jO_+XJvyQUMepJLs476BSyfme8gorvoA8Moo0MHduXuJaA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: downgrade HS200/HS400 clock-reduce
 message to dev_dbg
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Ch1A8_u0z-Usyjm9A4UBBeN7stk7ldhR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0MyBTYWx0ZWRfXxJ+K0EIhcoLB
 nUzEz+K9I3Qi0Re4AQjC9yIisQa8sKdfQPDbs5S7gzY5ePcO1UxZhCSdcuRN6Uf9ivFh8pxqtb4
 ga64AXBkJl2b1Xym8wepOyg89o5M5Jk=
X-Authority-Analysis: v=2.4 cv=PIqaavqC c=1 sm=1 tr=0 ts=6ae478a8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8 a=hkP90TJc7pLw8sFzWZEA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0MyBTYWx0ZWRfXzWzqMnZbM7Y0
 5YOdcvtOHyr5tL2hYmLk57GGqv/QMVdtSihc9wvzJyYituOINlj7u3Rnn+0H9hBx5SlCthkLLJT
 ED/WmR5WF2PmZv8Kmb+j6y9VOktIMOr4pWN7f3K2t+b8NRpF/rCsyH5B0tknIdwWw4r0fke3xsG
 /Yi4z3640oZ1HjPFq3gkSGqoS3WnJATl9wh7bCn2LEMyM1Y6ekuZEv3sqBdtCKADUO6R5DcwwI5
 /WgbC3f8fZ3iNZkwe6D8lmU0bshyTYxAPAh9ybmTu7682jFxpJ3PkgcVJqok0N7yv5vrmOrTUy1
 Tv27q+FP5eJoLpNaxj0fl3of/YE6EHOlU/aFRgSn0mr539GS0Mwn7cpURvO5aDFVOw5vP0Frk8Q
 Wu6y+ChgEF+Bgx9F0GMP/nSLjvS5AlDM0bWtqFtI7Lt7evMzG61s5axdbl+9yaDTfdgG26/ENG0
 JKpusRRmAS70KB6qrfA==
X-Proofpoint-GUID: Ch1A8_u0z-Usyjm9A4UBBeN7stk7ldhR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300043

On Fri, Oct 9, 2026 at 10:46=E2=80=AFAM Jun Yan <jerrysteve1101@gmail.com> =
wrote:
>
> dwcmshc_rk3568_set_clock() refuses to lower the bus clock below 52 MHz
> when the eMMC is in HS200/HS400 mode, since those modes require a
> minimum 52 MHz bus clock.  This is expected behaviour, but it is
> currently reported at dev_err level and therefore fires on every boot
> and on every suspend/resume cycle, cluttering the kernel log.
>
> Demote the message to dev_dbg so it stays out of the default log while
> remaining available via dynamic debug.
>
> Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci=
-of-dwcmshc.c
> index c688f3eaf468..b4fb1c1e6d99 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -790,7 +790,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_hos=
t *host, unsigned int clock
>         if (clock <=3D 52000000) {
>                 if (host->mmc->ios.timing =3D=3D MMC_TIMING_MMC_HS200 ||
>                     host->mmc->ios.timing =3D=3D MMC_TIMING_MMC_HS400) {
> -                       dev_err(mmc_dev(host->mmc),
> +                       dev_dbg(mmc_dev(host->mmc),
>                                 "Can't reduce the clock below 52MHz in HS=
200/HS400 mode");
>                         goto enable_clk;
>                 }
> --
> 2.56.0
>
