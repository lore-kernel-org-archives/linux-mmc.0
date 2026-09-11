Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537D1495039
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141250; cv=pass; b=vDwzK+he22/NrTCBpcQJbB9GqMIpUALqZjDs2/shd9erUMSy8R78tcqDs2HUdKR7Fs3WuT67/D4snPvNyuNnwCOW4klPN6Tz01k13w/9Kdn7K6K1x+PH8dx9V49gv6LftGyCwP+FLM+CeofrA7QUcxQdwNMOdIWGMDxC3NCxyA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141250; c=relaxed/simple;
	bh=kQXQO0oghS8R0ta0G4UMFCbDP7svrBfBTLWTZIZ07no=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqlNFrvr5um+zR6PEXgI6JLWWBbppgHHBBPHTwQqZtBexDKVAVgtN6Eon6ZN11X9wQiqzILlAH8rgQzkzZNgOQtOaLxmNrzvYQHHv28zkkOQ5P/S6SjlmPzHgR4EzF0J0amZW5gbg3kBrMes0Z6tH/UcqgMMLne8JzXptor+chU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I3TZVEPX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GorZ9wpV; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I3TZVEPX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GorZ9wpV"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BEmEh43780643
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 15:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9gVRbTQP7+HXM2XZul7tJ0soNXDAB0XswIPF3ZiIrx8=; b=I3TZVEPXZXd1Os5M
	NrODBZZh7T1xCUBzKFyUjkEAOKX+RRhB0xUdUtqnXOD7wpDfJgVcM0P8ZAzbzvJL
	17AjNsRXhsgYC5/xF3Hz+eo0TceSARvcGYLMIQwqFJRdfdKtgutrri/KzKcvQE7q
	28Rok/kNb+0XzN8xl2dgjNWrDHiJ/ENoqsceZe9haNYmE2I/eUyUlVT2J1t8q6QD
	SLrrbQEDq93v0gaYF4B2SeI1gp521usXrUP7WHGlDJXSRZNOLmz1u4BX4hHyEwrx
	XGTXtD2+scqMlbuWYo/tagR/1XZRpd1B6QX0sGpdvpj23BhXJClvEu8QAj32QnDw
	vQqPkA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmcgfj85a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 15:40:47 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2db0a41434bso18090865ad.0
        for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 08:40:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789141246; cv=none;
        d=google.com; s=arc-20260327;
        b=DxKxJ4zuCnmG5vCyJ57xvNa/hFTeVHrxsS/TNMqgGG3PFHwbcDd3ZZm3eIV+JKIWH5
         qF1oWzmkWRhF+JrrhNNZBFxvPHVONUXRin8jQTT1jC7lkMDwsuB5OWZPPAQb9iWwlLvP
         Vp374Uu4DAD380tOUMYUr7MbV1zYtATJc1mzRfGuVEtLckNqCK1Tfxl0sXq9DMvlu7fp
         /Me6UzUuwu2wSgj9cMr79MYVUVUMgN0oFfglkox6tR6aXc+Hiv2iVbNhmBvJqf89cjhg
         yKvpA5GBroNjn9cyRlCxcb2+EFJxgkoIGDPdX2n60b0vIFKWzt9iCJc9FvtUA0PSzWMh
         dUhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9gVRbTQP7+HXM2XZul7tJ0soNXDAB0XswIPF3ZiIrx8=;
        fh=bFfvUJ5vb50ZzMwrJq3LtrPTMTKOKKVnHMeC1hsyqQc=;
        b=SLQOaM+T2fUdkYoauaSi9xdZDJWYUI6RcK6dYgurZtRay1aenVrFL9HhfeETQw6V2d
         PYSZNWcE8XGEHz/L33Ia/T9QrM6hTOkMR+awXEZmC14vxnVe4u7BJzEVZmJq7Awj/n1G
         fM66luICsOmdpIyJo8EKXw8drzesOnypcrzZX1sIbbvYU2MI4InjEP8vcJDQ8ac8arSg
         bsYNqRluLGp125Wi29W7IRMUSC3uI3Gx+SZoKccDA4sHKDmRr2t0WJ7BprySAg6qLAYq
         ADrQ8uPizFrJZnxpyBhkzyxZ1GUSQHN0SrkHIZxoCoQgEILbAvXXAjaLVUKCzikRSSNZ
         jKHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789141246; x=1789746046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9gVRbTQP7+HXM2XZul7tJ0soNXDAB0XswIPF3ZiIrx8=;
        b=GorZ9wpV9CtedjUZufW9tj8EbQQJ8CzKEV18Q/7f1bIR44tG+7SNNZhetOCFHOIcR5
         5lC+6Ds0UF26E+PhZn6lXLc2S6NeGra1tfz61Id5aOcySB3yaJ9Q5mC12yOkknCFObms
         yC6BpHUvgIAm07j0kL8rSQzl9uXvi3ohA85uZQbdzACnI0/lBpal5B9yCkNESAwnEieV
         zEPBzCcjrGuhK9r26EqCpWopMe2mNKPJZiQnvE/W7AOt447QQ7RyQad7BYFHuzAMVhZc
         82blQxB8yicaJiJNE/cJMXfvQde/+zDmVhTVJ2ftTgm670AImChN24bX1/qzw2WEWGxb
         63TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789141246; x=1789746046;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9gVRbTQP7+HXM2XZul7tJ0soNXDAB0XswIPF3ZiIrx8=;
        b=erlVjk8tx7lU789wlYcCid1KXpCc7PKuj81G2rOopvJ0ixsijxLf2mahQZsvn5HfTD
         5WTwERkQw+FTaJqkj2B9jPIFuuNzIMu+NF3MkswFOzniC5DfAKq4NUasj+uS0wSjmhjK
         fgsbu+XLG2uN/fJ1FkzKNe/e6WmwJJH3nFEjvhhkLZbI8lH0iak0pUD/da055G9IfRsr
         fXRzMSZDc258h4MEB/Fl15oCmFfM+e+ob7Mb1mm5s0xXAcYXZl13yff6nUGG2bFaG4vX
         poEVMzLLMU2RjHnJzzDh+LEYMbOmjjjORCi506/jqMhheqUQEdFCImdxQXHtPul4VR7h
         /DKw==
X-Forwarded-Encrypted: i=1; AKwUvBwBZdDdBc7zNO5mpBk1lRcIrdYHT1SevTYkOFWkep3SYAnF59udRh8Ae8lKn0axb5I153m78cfTuRc=@vger.kernel.org
X-Gm-Message-State: AFuF++luz4S3g8LNSuvHIfmY2DmP1YpZ0puAEAs+VL1dxTdpO7W9GUxL
	zyNIEMeOFYYtUImxQxV6Ei+zVTpIaYLZt40yIMYt0sISv4qqNm5BYXdgB+Ji93gPpE/1PrfSjCN
	CLbBzwyg89g6r3axxroC1wV5DAE1v1oBi+G2y3iDmLwTeb2UjFoOzV7j52c34QO/Ctm7vHa/CvO
	fGymgGawGYUqh1yB29RhFqw6T3ukYO3+qYrpnWAA==
X-Gm-Gg: AYBFou0O134G2nYJ6lVAGBWchtGZYGJxxbuX/dgMeiBi59PUwB3ksK5h3FuOeUuyCIZ
	cR+mf7WRE/7ZHQxYzhAo2gyRaqnXs24Gx+tkYaX0HaIw/spEcxGmjGAAw3e6KcE97hBdF54HONH
	otxxhQR3sLrFwbcvlybAYVlle7yaIJmpOqR88TnV4dYrTxhYY/DWE94LUrFA==
X-Received: by 2002:a17:902:d551:b0:2d9:4871:393d with SMTP id d9443c01a7336-2dd2a45aef6mr95924895ad.21.1789141246363;
        Fri, 11 Sep 2026 08:40:46 -0700 (PDT)
X-Received: by 2002:a17:902:d551:b0:2d9:4871:393d with SMTP id
 d9443c01a7336-2dd2a45aef6mr95924275ad.21.1789141245940; Fri, 11 Sep 2026
 08:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905153234.133217-1-tanure@linux.com>
In-Reply-To: <20260905153234.133217-1-tanure@linux.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 17:40:34 +0200
X-Gm-Features: AcwNN1XJiqHpLAh6BkLXLC9WoOCg1aSLupw2Vf07ULv13DKT3f9hOH1d-RT7-pQ
Message-ID: <CAPx+jO8oWZxgkWTv3v5odp8K2oWMY-KhJVR3U+iqY4mQ9LrG9w@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] amlogic: t7: give the MMC bus pipeline clock real consumers
To: Lucas Tanure <tanure@linux.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Chuan Liu <chuan.liu@amlogic.com>, Jian Hu <jian.hu@amlogic.com>,
        Ronald Claveau <linux-kernel-dev@aliel.fr>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX8lgPajDuSKG7
 /ap1bPAGFAEmtOWEf5HGYlWGPikiuxiGEAePKnaKAao5sppJRyX/X67yH6LavfvQX5DBVRtK2WW
 egSsOGgVK6ro4z0P12bBhOJwpVnrMkckUudI5LzTz96ougNKQp21IjMtEHKvXzsLSWt983azKLc
 P4g1Lcmbu1ZTzbxPHXCMx6HaNMfoyWfI9wrKmkOJ3ktQ5uB+OEUG4Y8lRlaxwCQnasglwvzLnrq
 gEKDPnfCsZIl12uLlqimBt6GBlHKw1k1WjuIPtVHCwT2jcLt8I6Yp6qOVYyGcsyt6sPd8t/p7it
 neBbnG2SFLUuMS3063KjWgCxjiypDEwGauqPDbsvALVTGw59J8RMV6NgMcg51wSQdnVOdiMnIG/
 3seJy7gTPzqTL8nU5CnYPtd2fm8SFXEOkCxANRcx9Prc1I2KXyZK+4CXPgNoeDJtbhPzCMRidPH
 kpHfORj2FPUHdnx6gKA==
X-Proofpoint-GUID: WcZRArAr-hYanbtDx3QnMKgv0IOgsedl
X-Proofpoint-ORIG-GUID: WcZRArAr-hYanbtDx3QnMKgv0IOgsedl
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX5+s5nva9drFG
 Cig1Av+9wDNMHn2+ri4yPb8LIH/sjtbwVYkV2nNs3ygdSlk17X25yf+W1eS4Z6yTtI7gnlleUdQ
 8U0GNu6iJqX5yZhPfOqHHt3WuyOZ57Y=
X-Authority-Analysis: v=2.4 cv=ULtIjyfy c=1 sm=1 tr=0 ts=6aa420ff cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=NufY4J3AAAAA:8 a=yCDuxKIkwSfSSdlP9cUA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=TPcZfFuj8SYsoCJAFAiX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110218

On Sat, Sep 5, 2026 at 5:32=E2=80=AFPM Lucas Tanure <tanure@linux.com> wrot=
e:
>
> The previous series for the intermittent boot hangs on the VIM4
> marked sys_ampipe_nand as critical. But as Chuan Liu from Amlogic
> explained, sys_ampipe_nand clocks a pipeline stage that the
> hardware design inserts in the bus path between the SD/eMMC
> controllers and the NIC_MATRIX fabric to help timing closure.
>
> So the clock has real consumers: reference it from the three MMC
> controller nodes and drop CLK_IS_CRITICAL instead.
>
> The series crosses three trees; patch 4 (clk) must only land after
> patches 1-3, otherwise the DMA hangs fixed by 43e1705ecab9 come back.
>
> Changes since v1 [3]:
>  - Dropped the Fixes: tag; this series is an improvement and should not
>    be picked up by stable (Jerome Brunet)
>  - Moved the patch 4 dependency note below the --- so it is not kept
>    for posterity (Jerome Brunet)
>  - Dropped the e-mail address from the Assisted-by trailer, see
>    Documentation/process/coding-assistants.rst (Jerome Brunet)
>  - Fixed the space-indented error path added to meson_mmc_probe() in
>    patch 2, it did not pass checkpatch
>  - Dropped the CLK_PIPELINE() macro from patch 2; has_pipeline_clk is a
>    capability flag, not an SD_EMMC_CLOCK register field
>
> Thanks,
> Lucas
>
> Lucas Tanure (4):
>   dt-bindings: mmc: amlogic,meson-gx-mmc: document the T7 pipeline clock
>   mmc: meson-gx: enable the bus pipeline clock on T7
>   arm64: dts: amlogic: t7: add the pipeline clock to the MMC controllers
>   clk: meson: t7: don't mark sys_ampipe_nand as critical
>
>  .../bindings/mmc/amlogic,meson-gx-mmc.yaml    | 29 ++++++++++++++++++-
>  arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   | 15 ++++++----
>  drivers/clk/meson/t7-peripherals.c            | 10 +++----
>  drivers/mmc/host/meson-gx-mmc.c               | 20 +++++++++++++
>  4 files changed, 62 insertions(+), 12 deletions(-)
>
> --
> 2.55.0
>

Patch 1 and patch2 applied for next, thanks!

Kind regards
Uffe
