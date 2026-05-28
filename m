Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE2F2FD7C3
	for <linux-mmc@vger.kernel.org>; Thu, 28 May 2026 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998748; cv=pass; b=SPYsoKwTyZNTUED8hvHlpxU6A3vx1bVeHUTvSKiilTpgNigc0swrQdjMl6trAFodVQOdtejxvNbtIvzx0AUtCaawd9xO4Vn0jhBKjrVq3NHrjud54AE4sGq3j9z0qAuxh1Ln3sYj7S0c9Uzi/onfiBJHmkAtwnS9jj8o/6e323Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998748; c=relaxed/simple;
	bh=oJMFUuOMeu1xZfzqvjs5oqmOqseq1GS9vAeMohZOYg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EXe6WENvGLv8p/hhiBixaeMNvE4YNbbL7Y8BwRzgqhGi4clP8d+KrwXB6wk6zpnkJ0OxyiMyIBs4enBYqBHtCuvvv/U/Dwi75nZbX/oCE7BJYgEC3Yt3+5p0dvRLKKdimHRTz3m3ssZpJqo9ZewQEJX3X6mAl9DomW2RrAweOTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hqJ1Ech7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kFv0h2Xi; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hqJ1Ech7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kFv0h2Xi"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SHaQtx124976
	for <linux-mmc@vger.kernel.org>; Thu, 28 May 2026 20:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oJMFUuOMeu1xZfzqvjs5oqmOqseq1GS9vAeMohZOYg8=; b=hqJ1Ech7uOkQzSHW
	E9LM83uT+C2QKejzaDbG9lnETlJ1TwN3FsC3YCrKmFs9ql5hP2VYzmUDKe/lxm5Z
	TlMIDFq4SPlU4Ilat2+mlauvDzcGc4rMTjCj0Ckq/TA2MyVjfpir2ULKp0CvCabi
	1nM2G/ks+6kLVkB9T01ZyQtxlKXkGBuvU6eX40ybC91VTz7rQD9HnoGu/6BL1Cr/
	vtezTX+aATVum2e33WyKDy5YnZVuh+piX9ByIV18F8XRi/Co5cc40+DyNfYyelau
	g2qyqertlPiiUczu/uTNk2BR+8j++URVYj7dwA3wsEet8lamqDKoR70IAHfXD7/m
	3Zhgjg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ycch0t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 28 May 2026 20:05:45 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8b7105dfb5eso100775366d6.2
        for <linux-mmc@vger.kernel.org>; Thu, 28 May 2026 13:05:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779998745; cv=none;
        d=google.com; s=arc-20240605;
        b=Pu179WMJl+mx5KQXMF7M5Lg9fH7GYBSYeGQ5WbGZlAT6XsSSC4ElYlGTtJsqqhDsd/
         JMuhP0m9+mLeROgLwf+l5EreM1PWd6MIFAJmqO4Ex45czWtgXJffM7EuJhK84edQz8bn
         yPmA2iKvgqTK5JUwtpj918sLpcbxTrGa0mQuy/NteNqSaMCGwrhJqh/Una/gl9OzoyNP
         rOT2Yc8IczU9+yZEZpE8GhRNdfyP4bpNrdNSCqqqtD5+/onGXCYoDCa2or0KSlLZf4lD
         /UnOvs7NaiGoR/5OR5V5Uh4TLkp3IoMKUpz6ft+4GXRMh4i4kPcLR1Ea+f3ux8+7xvCg
         PgXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oJMFUuOMeu1xZfzqvjs5oqmOqseq1GS9vAeMohZOYg8=;
        fh=aiQ2C5cZjCYgzmcJ/w36zzcojT+lndpzpt622cyWpdE=;
        b=cGQlKIClYr02XMkNi2mA5hBdjHPOXbarbAofsx3XzBgyFeoawiQZ4ibaTVV2lU9bk/
         zIeK9j3S+Kn8DyJ7Ferwi+cQcUzHg35g1jv8elXReUwzGujlVBT7eWQ97tD5ahQz2s2z
         GIllDlRgJPj2miWCopQfmDOZZknmwd7mT63X9qY6j0P6K/SdaxgKuaIrG7xjga28XoGO
         2ofkjraD9FXsFqAmOcspjIo3WamTHM/VZEBEgW0z6gUGmzoejGxPlmH6ggNz9c/Xm+sG
         13oB9InjbTfEr+ud+8lXjAMtQjza5QuqGorSgPPgnwD0Q6o+yr9sJLFXShpJqezcrYXh
         RNNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779998745; x=1780603545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJMFUuOMeu1xZfzqvjs5oqmOqseq1GS9vAeMohZOYg8=;
        b=kFv0h2XiBB/1nW80LtsgKs7BMsEwA2xJjUIOnJeEL7DXhM2XRStodM9jDLfWbxn0Dr
         e+Pu8uEJaDl0HWh+MAGvw3RTjPunKomgsFT/YoEJhUdo3EpaPYHXPKT5bW4NvHRvHoNI
         zNtOuQAG13lgKS6SX3s+WRSJWQ49JjiQCPIk43kqzDozY9/M3DtLIpmgHYKvnosCHVCT
         DzUvZjRja9YWU4SlfPTQQvSIfvwp6MiddEnDeJY8Ssa7orAOFkrsRcrGweoyNiN9/H0i
         xDyWbf9CAkV3LIm82syjT5APXyb0wWrmce0FzdrqMv2DRZ+yWF4ghfIk8r7q3AQ+3hRQ
         m6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779998745; x=1780603545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oJMFUuOMeu1xZfzqvjs5oqmOqseq1GS9vAeMohZOYg8=;
        b=V69QnKTjSXSc2p9cz1g1wzbt1K6AOFOUwS4HqbjZjtGbRdrkrDF2SoudpflkXmil7I
         UpTcWJvmG7s4TVqqLUynrq1AOB6PomDZctztFpHL0sggxDJayg3VJQgmFcsTS3WXV8RY
         2mb2aWDdzsRpM39UBwg3oLxTfbEGAoxQZnZ0Y3gSMb4GevNC732SWZ/pwfuzepL8/MKs
         NEYjCt4F1zkwUVom5m8LnXq4bf0w0kgiYIUpB0TyjZB5j58L/R4WwJ6P3kCbwaNgSqeX
         czZ8Ml9jDcSjyvRkbqaw5E6IUAvD+FdaZ69ER5uK9QAlln3XsX1fuGktA8UXYKbeP7q3
         vuuw==
X-Forwarded-Encrypted: i=1; AFNElJ+ar+BXfCm8wmsjmk1Oaizy54Ol0OHsLlHkigz7BLRTEfSAk+CeFi5Okfm5N4WwUkA7dpn20JC1hso=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLdMLh7QLti5NAISDkVRAur0lbfExGLJuRf3jk2PqaRfbMH8In
	FO1bCYTup5u0UJLLmrJ5wDUmNuER2PVq+Smfsq/ngGtKkhXvPgEYcfM59MuteutJPkM2PBApjHf
	oW8iBwwyLeFSFjuV9ZuV51+zH7ys9GlRbPX31lrlW5C/Q88uq8TzkeUxG4YKCsJsTXlYH4igxu0
	AbEaozEECWmdIQvWml4e3KSX/oaxqRzBMbvi04zQ==
X-Gm-Gg: Acq92OGfz2QIMH0N4GjgodaXnthB/9LR1dZQjg/bckRPW/ZwKFDrEg1W0iX8hw/tTdP
	Mu8hvtEb5qq9lI4broh47nhzLzDXHxOpryfh6tY9zvNNmegRHac9dlYJBIql7e/8a5WqYhWAxzC
	j69aj+FUoA3H7OJqPgETxuwCXCfpgPh/ofGt7l2UOs/MaWDD7LpzNIbxUkkTY/Z1AWpWLIKPVlq
	BbkrNKbj9jFoCzEgw==
X-Received: by 2002:a0c:f409:0:b0:8c6:4d63:570c with SMTP id 6a1803df08f44-8cce20bb098mr11822146d6.12.1779998745356;
        Thu, 28 May 2026 13:05:45 -0700 (PDT)
X-Received: by 2002:a0c:f409:0:b0:8c6:4d63:570c with SMTP id
 6a1803df08f44-8cce20bb098mr11821436d6.12.1779998744922; Thu, 28 May 2026
 13:05:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413180551.3683969-1-florian.fainelli@broadcom.com>
 <CAPDyKFooAH=Z2BEHq08Fu03uidgjuaDbwM-Y3Y3Xa8STV+ODzg@mail.gmail.com>
 <1d583be4-b1cd-4226-bdbe-5ebd275de9c2@broadcom.com> <CAPDyKFopEbm6z2-AVmPQr5csofNew2nWpzGyTdBK24w+5YD-PQ@mail.gmail.com>
 <915473f9-64bc-4630-9c82-41fcf4401042@broadcom.com> <fff11e26-9c50-4a99-bd63-47b10687fd38@broadcom.com>
In-Reply-To: <fff11e26-9c50-4a99-bd63-47b10687fd38@broadcom.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 28 May 2026 22:05:33 +0200
X-Gm-Features: AVHnY4ITUEDpslGZfGnQecO1oGnMkxOrstVatU4RwYgxEgzs6ruA_9ZulC1NX3A
Message-ID: <CAPx+jO9X2Znft9TCeqh9O5L4-Gv0mD+iUWE2A1ix7MT6VAKyqQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Kioxia 016G01 does not enter boot mode after SLEEP
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Avri Altman <avri.altman@sandisk.com>,
        Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
        Erick Shepherd <erick.shepherd@ni.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=VOntWdPX c=1 sm=1 tr=0 ts=6a18a019 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=Q-fNiiVtAAAA:8 a=2sBtJDeoeePfJcM3CLQA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: 4oYAmiL8UsXGVPISXOZq6ZZqUk8LRG78
X-Proofpoint-ORIG-GUID: 4oYAmiL8UsXGVPISXOZq6ZZqUk8LRG78
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDIwMiBTYWx0ZWRfX49Y+dwhcWF6v
 eAgnv50IrWZFkU5YR116SIvl8V4UyaGhsjRBi2+wdQqDsJ1r5FyPP/9T4Qp1GlSZchMFUZorKoK
 5DPwszkbpXqK4wOXAj9tWYBnUycQe9neWKnlSL6zZdKPeexG5hb9Mr/Zn9STZvfcpLjeK5qdJZY
 mmGg8tqrIiqfZ/IXdcwWsbOiKa3du/eXY2iuoTcDom2eNczCgXVqWqG9Ko36FcqOg/QXXVKHbFO
 Bx+C1dDR/sfzNGqwDkjyc3P0CN2DTmv2M8+bWzyr+AQzhW30ihQR7OZY9KQ/dPTdFjKFFqMBEpE
 ola2scs8N5wLxD6DrHSUT0OQzAwIYIoRKyVBsZzCg8M1toBUs/4aHTEx++MrivuCyw4oOFol6Jk
 xrxJSig6x1BIBG+XtF2PocDJGisIa+BH04mo8zZKxo0ynyUEJ7tNcllCk8Oo8C0L4MlSFWfGL98
 OtahvemFlc3nHE83EVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280202

On Thu, May 28, 2026 at 1:41=E2=80=AFAM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 5/18/26 20:27, Florian Fainelli wrote:
> > On 5/12/26 06:33, Ulf Hansson wrote:
> >> On Mon, 11 May 2026 at 18:01, Florian Fainelli
> >> <florian.fainelli@broadcom.com> wrote:
> >>>
> >>> On 5/11/26 07:18, Ulf Hansson wrote:
> >>>> On Mon, 13 Apr 2026 at 20:06, Florian Fainelli
> >>>> <florian.fainelli@broadcom.com> wrote:
> >>>>>
> >>>>> The Kioxia 016G01 eMMC device does not exit SLEEP mode when sending
> >>>>> CMD0
> >>>>> which prevents the system from properly resuming from S3 warm boot
> >>>>> where
> >>>>> the eMMC is necessary to pull in the boot components.
> >>>>
> >>>> Is the bug confirmed by Kioxia?
> >>>
> >>> We've been going back and forth with them without much progress as fa=
r
> >>> as a resolution goes. Since there was no progress and I would like to
> >>> get this included in downstream kernels at some point, this was
> >>> submitted.
> >>>
> >>>>
> >>>> If not, can you explain a bit more what is actually happening during
> >>>> system resume?
> >>>
> >>> Upon entering Suspend-to-DRAM, the eMMC will be put into sleep mode.
> >>> When our systems resume, one of our hardware cores driving the eMMC (=
HIF
> >>> block) in command mode will send a CMD0 command for the eMMC device t=
o
> >>
> >> Is the CMD0 sent solely by HW/FW before the mmc core executes
> >> _mmc_resume() during system resume?
> >
> > That is correct. The sequence basically goes like this: HW sends CMD0,
> > then FW pulls in boot code, identifies this is a Suspend to DRAM, does
> > its steps, and eventually Linux resumes and calls _mmc_resume().
> >
> >>
> >>> exit SLEEP mode. The Kioxia 016G01 device takes 10ms rather than the
> >>> tSLEEP_EXIT value of 1ms which is advertised and so our HIF block doe=
s
> >>
> >> Can you please clarify what tSLEEP_EXIT refers to? Are you referring
> >> to the S_A_TIMEOUT in the EXT_CSD register for the eMMC card?
> >
> > Yes, sorry I am referring to S_A_TIMEOUT in the EXT_CSD register.
> >
> >>
> >> Anyway, waking up an eMMC from sleep state in just 1ms sounds a bit
> >> optimistic to me.
> >
> > Fair enough, but AFAIR we wait up to 30ms before declaring a timeout,
> > every other vendor we have seen exits and acknowledges boot within
> > 1-10ms at most. Similarly if the device is not in SLEEP, then it
> > acknowledges boot within 1ms.
> >
> >>
> >>> not see the Boot ACK pattern in time and does not service the read
> >>> request from the processor that wanted to read from eMMC, we get a re=
set
> >>> of the system, rather than continue booting.
> >>>
> >>> When SLEEP is not enabled, the eMMC device responds within tSLEEP_EXI=
T
> >>> as advertised and we don't have that problem.
> >>
> >> Okay, I see.
> >>
> >> In this regard, it's important to understand for me how the mmc host
> >> driver (and the HW/FW) manages VCC and VCCQ when the mmc core calls
> >> mmc_power_off() from _mmc_suspend()?
> >>
> >> Does this turn off any of these regulators or what happens to them
> >> during system suspend?
> >
> > We don't have software controlled regulators for VCC and VCCQ and our
> > reference boards using that specific eMMC device keep it powered on
> > through suspend-to-DRAM. This is the very reason why if it stays in
> > sleep mode, powered on, and then we attempt to boot from eMMC we have
> > this issue.
> >
> >>
> >>>
> >>> So I suppose I could reformulate the commit message and give some mor=
e
> >>> details here if you would like?
> >>
> >> Yes, but let's discuss a bit more first.
>
> Ulf, did you want me to re-submit with that kind of detail added to the
> commit message? Also since this is a bit specific to our devices, did
> you need me to scope the fixup to the ARCH_BRCMSTB platforms somehow?

Apologize for the delay, I have been a bit busy with administrative
kind of work when changing employment.

I will respond as soon as I can to your previous email to help figure
out the way forward.

Kind regards
Uffe
