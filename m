Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795711894;
	b=oWk4+RJ7IdlvvTW3PYqQaKEe7g2aPUy2soKjg6lz9ao3ye9PacUc0jOjWMIm1AY739SN
	 w4J1jH7uiZAgCla8c2XyhajmFqGEEL+NIxEsQbyOhphn3sZTIm2vjb3PGkoE848N0KV0k
	 WzaoODvL0mVKv4Zk59j3EnUBZex1P0mRwf1Z3cSjeLWjXdV/f4V9+YIoJ90g4r/xPVSus
	 Jp9r8r/fihXcTDaH9GW/b3XM7oN9L6gnhU6LNIhyCIHoMCMutMUBisCn9iUSHHNVauDo9
	 qMwVvtyhS4ZacBqTLeZMdZ102US951LGIQOiJxVCqwtbTh629ubjHbhVp4cfhU4rNuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711894;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=y/HymTHxVh9JSPRhJ7hx3UDSfUl9znRn6BmHLB/weDg=;
	b=EzVS31DXPWHilzD4QsKiN8C9NgiEWMzRCJMxFY3EYogU4/byddH0jkNrUoOw5Asa1peH
	 fyjsNHPZ7ExlIoQ6t6cTYJaJuOvu1U1QpVShqfsh91MSdxxDCj+FFCMwBfyn3XoeIQFrw
	 XDWk1dhEpxoZa1S9+umPCLw0JuAki5YBCDoW+NZU+OEUgl2Ncsu+/8nTZqFqB4wSttT91
	 gMfuizlsfOFC91/scLamm7L7JpPKRgjgjgNCfeHnmwHi971KDLzZHphg+B0BOgmJCGZOH
	 QRdaK178hzqdsRsWq9uT/cTw5C14wC/hWO2H6jFncPfD0fK/6BzNOUI9+oqQSgLgN5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LN8w68kC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MM8HQdIp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA91606A31E
	for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 16:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEA91606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LN8w68kC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MM8HQdIp
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQFtwkc4048185
	for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 16:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y/HymTHxVh9JSPRhJ7hx3UDSfUl9znRn6BmHLB/weDg=; b=LN8w68kCprRpgF05
	kJDoNtvjfd4aAUxe9bIeSOxX88cccqH0S0YCVlika7aERAmDsO8j3AmIdt3eEbqV
	e+OKwkZNPHQ579sxl6c5y+7iQypvPsXf9R25964wlGy2noNoKhzruXSdor7sDVcJ
	JNnx38dYK3oc89yFYC9jnumXhtRoccPim6YC2Tnj03L3WXmr0IYMM+wStPc1L7ey
	suNC8+bvVwvs9qvsyyT1ddQzK5ux3eFleUZ37cmeuguxY0d358hTse4amoa8Kt2x
	NqsubbxpPW172KRqtootduOnp2JoCEewC+LbdOLwW8OQ2CrI3V3v1G35OOGqtf52
	X27YgQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6f8rj8jc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 16:51:32 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b4092b645aso6080501a91.2
        for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 08:51:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795711892; cv=none;
        d=google.com; s=arc-20260327;
        b=OpToq0JfPlfi8sVE0frcyk69u9gN4XG3wTg3zrMvyOTkc0g4/vWF7f4Bl4V8/Rm9CZ
         Kss7zeBqwROcYLcP03cCTtMIw1BuxEuMaAL7HiKhvGg6bwDlu/CybimJraEhSXYCJ79T
         D3X6xuCvzXFNu/bgvyUtEYSYQ3SA/2sHqFQnwbXPQQGtiAI+kytHkx8vTQPZy28ZAA3c
         M+jau9k3QX2+MfOYxVu2whYqX+x2R2znPosWpgVLBbajIFDb20gjaXXChAJVmiYR3Oyn
         rP4knGIagzd5FtrdQSE+oBvUHaLu6qG4N9RE30+ury2RpRnuEH1NCaJBMbheUhPFERb/
         I5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y/HymTHxVh9JSPRhJ7hx3UDSfUl9znRn6BmHLB/weDg=;
        fh=Jr6bxL2NRt87wzK13RmXD3XmRPnnY+QT2W2m7reF3j0=;
        b=kPwrRAkTm+C8gziX1aYlp4PcBR3rdpp/qY4GXxDJm0UKTYVZRFqMjl4JnWKofzM6fr
         BuWFPyCDT/SEgOd2z8Iha9aL1xS4aU9+D93crGgoYh+6xhICJ8XJ3j03jJe3GD/ngXZE
         wQZ2gw5D+dnx4ltSdKeiUXMZFthmcYF1FrnmIrMUsK4s0QzCB7Mv4XyRP5PzLeTAGr/H
         Cw+wTWTVdRGTAU7Z8ow3XbnK8QsVwRlrdV1ha6AssPDW0LBhpwQDA/NfswRMp4LBp24X
         puB5JmEiZNJRI+Hs0p9P3TUgTBzDgJ4bLppxla1bkW769UQHHyg2eEaQh7rPHl4dJxvX
         oL2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795711892; x=1796316692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y/HymTHxVh9JSPRhJ7hx3UDSfUl9znRn6BmHLB/weDg=;
        b=MM8HQdIpqb5+ZCZcU8fme6VsNf+G6M2cQWwR97jYknUCZ/jYarYxJbTsnvExhZEy2y
         //dneQmJ8a6yAOcvgaXsCfLRO0HA8rnf5xUZsZcpYdnU7xi7ysCJkFGl7opOoGBVnCsT
         HYPSEpCJ1w5QuXbpQBbF6Tf1cR/VdAPhTtBhmK/S+wTJXhHrhoiKN4Jy6hp6Tob8VxJh
         4NJeWkZsbDs/o0ij7oq8WdbBZsNG+D1nq0d95KuD7RldjJGpOEjrrmtunE5H2FIPw/x5
         /Py1Yf6IIZjUYruRA+M2v8bslYgEEW5jlHL/jTJXbNq7LQ7xIZxGxNN+kI6iPc4wRvE/
         AWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795711892; x=1796316692;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y/HymTHxVh9JSPRhJ7hx3UDSfUl9znRn6BmHLB/weDg=;
        b=JK1c+Ftj2Q7cOupORrDuoM6urzbl3Z7ox2EM3lWAGExKsWL/xQH/9WkxqVJl/2syb5
         p8/3Bla8tIwEFnW07cZA1FkHk6GJHWAvEZpBK47ONwj+3DkYuUgWdiRVEmP1gJraZRGv
         RDkooOG8LWyXfzxk31cpBIctLIMDKj3ggZwL++El5yafCng9qM7zvwDHlGqDM2VLlfJi
         Hs5WgFSNa2AgDs8Z2ITF5EEYyeMDCjHyIbZR5he8n3rV+pYFMoDVBPV/kPnGmvRYoB2D
         9bxpnZdE70JTDJdgCMi7bBe5WtGLdnvhUQbuu+bObUvcxCBC+NIbxvixqlXtGZnj19dl
         Xgnw==
X-Forwarded-Encrypted: i=1; AL+hErEPWyO8DRWZxBoCbTFy2NiYMvybORUCN9vIMZ5ar+MXP9HMhEHtNUSXq3dZDykzggAM4QJYnYnrtrc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+eJiyq+bPugi+2YRCiB7WEIrmQ8LoxEy99HjAFJOmUOaxb3vqL
	eE4JzSg8FE03qcl44GNYZ6+WGk2FsvySSFXeXSIx/M/iDMrEizBl++2rvwciJHOWvilcNTgP0n1
	SVpQvcz2tL1BkXG83VB4d2uYqVlOwq7Du88udeyUWHj+HQeOBfRkdW4Mc54ZMthW/WJKjjzMgYJ
	tav4sPBiiZiZp3mJsFf3MDmBPvQR98DjXq7LtxPQ==
X-Gm-Gg: AZFdTZc+hdvyRAIiqihhQLjpoHnblEMTKNMRdIiHPZKIyKAvHAqC6arN2qjnFXGd6N5
	yMJSGfnWEOU3QFvzaFIvKIHZ2hoSZIQoAvPrf3xs1+3Tf8DST1q3S89fE6Pc61cYXn1A373fw7U
	f3PTUbbYZpAa59LqknQVsMd6DtMnmT8xZtULzKncUt00yOoaEkxBpPBJTLPg==
X-Received: by 2002:a17:90b:50:b0:3b0:b35e:b373 with SMTP id 98e67ed59e1d1-3b41c7c2378mr21122806a91.4.1795711892229;
        Thu, 26 Nov 2026 08:51:32 -0800 (PST)
X-Received: by 2002:a17:90b:50:b0:3b0:b35e:b373 with SMTP id
 98e67ed59e1d1-3b41c7c2378mr21122785a91.4.1795711891756; Thu, 26 Nov 2026
 08:51:31 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113-fix-resume-reset-v1-1-115b3da5764d@foss.st.com>
In-Reply-To: <20261113-fix-resume-reset-v1-1-115b3da5764d@foss.st.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 17:51:18 +0100
X-Gm-Features: Aa3M54o4VHeMYCpg2TuAN6_-LjxGTu6SJHr08jR0_SBLE_JPiTPSxML96L7j05o
Message-ID: <CAPx+jO_V7f69HU+8r7thJW6xvUc75zsaWamHc9+L1Wsh8vyU6Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: stm32: reset and restore SDMMC state on system resume
To: Christophe Kerello <christophe.kerello@foss.st.com>
Cc: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulfh@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@nabladev.com>, linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA2NiBTYWx0ZWRfX0QPawugRKsyM
 oOZ3qw3VR9KBKruIbxC/IMiZ09GEE8ImXOP9DhCewxf/UEZHXziMq8/uLDi+FcKaT8aBkEEtu+l
 o3liE51VaPgLmsvlzfenb+kQSHXcQqHq5lnzD9t/6e/4DLL+cYbHesGq+xGHPMcFjTHEMqmwIJq
 oIaiT5i1ZuJn9ySwoa5VYbCixAOSWyY3AmWaYRM/E3fO1BvuZR0Iwo9Ln0CfLHOvs4rqPnpr1Zm
 W5+8UCe1femLsEyI/8M0GTrPv1VlWpnH6hN63FnJsuGOC6w66Pqzqq7hYLpnU4INZ6Q/MtUxmc3
 MS6I94hVy/my4fc9q4udaHwDzt/UpCGgpVQYJBiD8jFZmNh57T9o1o6gc9EeWpYMKmHRWjm5Om2
 0eTKrNBe0Wgf/rso839/vx5EJ/CpOvCygiJgPAlbX6qSekSAetnGhz3TqGM6oRqKB/N0Ic6DbGk
 nfgLj7hBPmOG9f+xmwg==
X-Proofpoint-GUID: QfdMM7DF45xcSc4yB9yUKEfGiJ_4gRe6
X-Proofpoint-ORIG-GUID: QfdMM7DF45xcSc4yB9yUKEfGiJ_4gRe6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA2NiBTYWx0ZWRfX5Ti2lXB/YOPz
 qbE9ucITdKJ6uitkGfbx0E7iFzKsYgK1Ng/rxbe3eRIUtQqftyj+6sKT52seO1gKYBD0A/ANKEi
 DW1fsHIvlNWvRm63TkjmHgM6GNDwG9c=
X-Authority-Analysis: v=2.4 cv=FuOQbGrq c=1 sm=1 tr=0 ts=6b086395 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=8b9GpE9nAAAA:8 a=VwQbUJbxAAAA:8
 a=ecHELK-FIlHdQtvxNqoA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_04,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260066

On Fri, Nov 13, 2026 at 5:36=E2=80=AFPM Christophe Kerello
<christophe.kerello@foss.st.com> wrote:
>
> On standby exit, the bootrom may reuse the SDMMC instance used as boot
> device, leaving the IP in a state not known by Linux.
>
> STM32 variants do not set pwrreg_nopower, so MMCICLOCK, MMCIDATACTRL and
> MMCIPOWER are neither saved nor restored by mmci_save()/mmci_restore():
> their content is expected to be retained by the hardware.
>
> Add a reset_on_resume variant flag. When set, and if the card is powered
> off and a reset line is available, reset the IP on system resume and
> restore the cached MMCICLOCK, MMCIDATACTRL and MMCIPOWER values.
>
> This is done from a .resume_noirq callback, so that mmci_irq() cannot run
> on a state left by the bootrom once device interrupts are re-enabled. It
> also runs before pm_runtime_force_resume(), which does not resume the
> device if it was already runtime suspended before system suspend. The
> clock is therefore enabled locally for the duration of the sequence.
> Clock and reset errors are reported to the PM core.
>
> Enable the flag for all STM32 SDMMC variants.
>
> Fixes: 46b723dd867d ("mmc: mmci: add stm32 sdmmc variant")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmci.c | 58 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/mmc/host/mmci.h |  4 ++++
>  2 files changed, 62 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 5ecb4d0bdaa5..f5affe4fe1b2 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -278,6 +278,7 @@ static struct variant_data variant_stm32_sdmmc =3D {
>         .busy_detect            =3D true,
>         .busy_detect_flag       =3D MCI_STM32_BUSYD0,
>         .busy_detect_mask       =3D MCI_STM32_BUSYD0ENDMASK,
> +       .reset_on_resume        =3D true,
>         .init                   =3D sdmmc_variant_init,
>  };
>
> @@ -307,6 +308,7 @@ static struct variant_data variant_stm32_sdmmcv2 =3D =
{
>         .busy_detect            =3D true,
>         .busy_detect_flag       =3D MCI_STM32_BUSYD0,
>         .busy_detect_mask       =3D MCI_STM32_BUSYD0ENDMASK,
> +       .reset_on_resume        =3D true,
>         .init                   =3D sdmmc_variant_init,
>  };
>
> @@ -336,6 +338,7 @@ static struct variant_data variant_stm32_sdmmcv3 =3D =
{
>         .busy_detect            =3D true,
>         .busy_detect_flag       =3D MCI_STM32_BUSYD0,
>         .busy_detect_mask       =3D MCI_STM32_BUSYD0ENDMASK,
> +       .reset_on_resume        =3D true,
>         .init                   =3D sdmmc_variant_init,
>  };
>
> @@ -2586,8 +2589,63 @@ static int mmci_runtime_resume(struct device *dev)
>         return 0;
>  }
>
> +static int mmci_reset_on_resume(struct mmci_host *host)
> +{
> +       struct device *dev =3D mmc_dev(host->mmc);
> +       unsigned long flags;
> +       int ret;
> +
> +       if (!host->variant->reset_on_resume || !host->rst ||
> +           host->mmc->ios.power_mode !=3D MMC_POWER_OFF)
> +               return 0;
> +
> +       ret =3D clk_prepare_enable(host->clk);
> +       if (ret) {
> +               dev_err(dev, "failed to enable clock: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ret =3D reset_control_assert(host->rst);
> +       if (ret) {
> +               dev_err(dev, "failed to assert reset: %d\n", ret);
> +               goto out;
> +       }
> +
> +       udelay(2);
> +
> +       ret =3D reset_control_deassert(host->rst);
> +       if (ret) {
> +               dev_err(dev, "failed to deassert reset: %d\n", ret);
> +               goto out;
> +       }
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +       writel(host->clk_reg, host->base + MMCICLOCK);
> +       writel(host->datactrl_reg, host->base + MMCIDATACTRL);
> +       writel(host->pwr_reg, host->base + MMCIPOWER);
> +       mmci_reg_delay(host);
> +       spin_unlock_irqrestore(&host->lock, flags);
> +
> +out:
> +       clk_disable_unprepare(host->clk);
> +
> +       return ret;
> +}
> +
> +static int mmci_resume_noirq(struct device *dev)
> +{
> +       struct amba_device *adev =3D to_amba_device(dev);
> +       struct mmc_host *mmc =3D amba_get_drvdata(adev);
> +
> +       if (!mmc)
> +               return 0;
> +
> +       return mmci_reset_on_resume(mmc_priv(mmc));
> +}
> +
>  static const struct dev_pm_ops mmci_dev_pm_ops =3D {
>         SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_re=
sume)
> +       NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, mmci_resume_noirq)
>         RUNTIME_PM_OPS(mmci_runtime_suspend, mmci_runtime_resume, NULL)
>  };
>
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 4d3647f9ec06..3a053e40d113 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -334,6 +334,9 @@ enum mmci_busy_state {
>   * @supports_sdio_irq: allow SD I/O card to interrupt the host
>   * @stm32_idmabsize_mask: stm32 sdmmc idma buffer size.
>   * @dma_flow_controller: use peripheral as flow controller for DMA.
> + * @reset_on_resume: on system resume, if the card is powered off, reset=
 the
> + *                  IP and restore MMCICLOCK, MMCIDATACTRL and MMCIPOWER=
, as
> + *                  the IP may have been used by a bootloader or the boo=
trom.
>   */
>  struct variant_data {
>         unsigned int            clkreg;
> @@ -382,6 +385,7 @@ struct variant_data {
>         u32                     stm32_idmabsize_mask;
>         u32                     stm32_idmabsize_align;
>         bool                    dma_flow_controller;
> +       bool                    reset_on_resume;
>         void (*init)(struct mmci_host *host);
>  };
>
>
> ---
> base-commit: d2616724e01132376c78872b8324f38659af9f28
> base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git nex=
t
> change-id: 20261113-fix-resume-reset-9bb5714fd505
>
> Best regards,
> --
> Christophe Kerello <christophe.kerello@foss.st.com>
>
