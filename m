Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793180159;
	b=JxvwUIkSU2nvAHeOfCbqXhhWbkk2yVPbWorgelx4U7yjBWDCRqOeU4l5/YnCIe8C9zJY
	 wrX1dYeJrGiSbB7HPNQTcR0JtMn//9NJqHZOobriyzsbUZEp//+AQpCzyy+dM+xgwbO0n
	 OTgUGdQ4zmam9MinnXlcVGH3PGJAvRIkFVGfe07IxKZMK1t8+nIkYTGl6qG5Pnv0MeEdy
	 NRTfRIGWUSHR7x7v6Zc9lmVA0+47sVq7Hfh8BFBAn1t7DoelwhHWVkI7vAf7abXGi2KPP
	 93cT5XUueQiQzNaa/4Ypnq6zsect+lGm8WxrNK2l4WZH7iPymTHlC3n2/LF5iqbDAcg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180159;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=MHhXmWSjTP17S95cJvWqHO6uKt5FNXxDrOyDLF0HSW4=;
	b=dhS4Fs55hLvA0bhXuCXWZqLbHXEDLCY2JcahWAlWKlg9zj8cvrXvuHTybTKkbF+RMPZ/
	 huM06ICQfP89mEKyristNzanC8PuTjQ57Bxch3534ig6vj5Z29zbQxTqcrtxjG39o/wlL
	 Ue4IjIpeIZAvRMvrvJPURWN+L0+lrsFwYDc7NN9WCViBKVVnrOHPDhpHcra7U1eWL8IiH
	 vwTeH02HNyM04TFZkyB/QuTI7oTpIifebTZOHSPJodcLb0gw3tDDSS221IJX90KLbhfxn
	 wQusjzz0aumSvoPUJLrys6UlqGnI8+QYF7Uq1a1u/PbDczQU/RDwjrAoPxy9M1oE0tw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j372L94+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=csNdMFr7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48307606A31C
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 09:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48307606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j372L94+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=csNdMFr7
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8KLjY3264807
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 09:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MHhXmWSjTP17S95cJvWqHO6uKt5FNXxDrOyDLF0HSW4=; b=j372L94+34Ti0E6Q
	K0EnBgBNjfw5Fv58vunGttUQzhdEiPVTYArZSlITBAoOpN1JRkYdXUISAp+OIKNd
	81ArpJr+6ktPfKrNCaP3rOCl2sq05BHNF+Aolvtd9sFxwCQlIT6KGsfOSm01O19F
	aa7UuokufC5jHlueJiEKSo8dBQAzlM7D1QcHiNAV1oDLHeyeRTJSFgeHHteMQJ8D
	KIyrU7yvVu6Ny20Wm+BazlEJ2esMhhqRmbk8CbXN2kusicu0vEp7HgcUSe5SVP+f
	KdAV5HJ4eOOuYeIp0K6tJ8ulxGRTajUye6hvNw1tUlk4uN9T9pT9Im0JCrj2AlhX
	V5vfXQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy713ha5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 09:35:58 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cd5ca3840c5so997848a12.2
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 02:35:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793180157; cv=none;
        d=google.com; s=arc-20260327;
        b=jp4dbNJsK5P5WOqffSc+QiPETH0xrlvco7UOd7v6gs/I8xyO+dd3woI9tQiJbfMrBX
         xMWykArZ5Z44RQ+ReAi6bilTUThX6T9UiOcAtdHjJfgsJVmlN6X0wIL2bGM30KVsS+bJ
         IorHF30LEJpGU7VZtrwvjvVm9uhOsb+BxzKAkJck8KrwAUlFhDoZYHgt4o4TS2rIwgHd
         0d7CdLXh3adijrF1k51rJe8MhdJxppYdF8X3raVr7wB5nUdVVULcD+y/lZbDdZEEAjIY
         slBZ+Q30XrDuWS017jdn4uqjMNGXXVVgkA7QkMIOFRl6RPGOLJT6w0p6rDuKLfpbAP6l
         RMKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MHhXmWSjTP17S95cJvWqHO6uKt5FNXxDrOyDLF0HSW4=;
        fh=ludT6EO+neNDDKDxtczF+X+jOOMk4ZjKML4B1kMgnDA=;
        b=oY68s1252+NYBFJ8WilgwHN/3gX7TMNiT0dGlN/VyncvD94kJ7pxX4CBAzSdRM0K21
         M/ISj3LzK01Uv9M+ddEuURNBCc7a7uBgmhn+tshK4o4K45ux+zRkq8SfpphzKjOOspWx
         TCWUhF8U381iI301h8XC7Zo+J8F97ggAdwe9fea+ztaCmEj8KXAqomEbMl+ldSKQ0IvE
         oIYByWrfHvIao+spsSgwtjAGDjm9O+b1D//Yl5GTmPp0JwxMHJVlxtDX0qnvjP2cTjG/
         9eblgp/Px6XDCXBk5qFHhmXuqoKqt0aXSEnQDgsH8Mv7yWn/U8qd0crATNmGCrWivE1K
         kdbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793180157; x=1793784957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MHhXmWSjTP17S95cJvWqHO6uKt5FNXxDrOyDLF0HSW4=;
        b=csNdMFr7NR7gjhcyTU16occJemTapNIeSdKhhCooYHyS7Jn8VUv0oxlW4U/txTYYZE
         alScDRM2WuFjBG9VPQcWu0VN42TMMJAsIQ9aWbAgbpokrn0siCdeeVKxH1zDwZVV2MYC
         doL26s+CRA1T7bPfXk6RZTCOULqonmpJYTWfbozTNP4q6KhspJ1UuTH7eR9Qc9ugpHTi
         3qElyhuK5Klbela1yJ0Y9gpGsxQPvDesYJhV7AN2fctyMbsG3ju6P0S9d+Yus/yOrF9c
         EIVVbs6fV4/g31+nRDcwiD6OXeRUSYit+6A8uuQ4pomwMZnBYoZiu344ofHEZjPriz4j
         7mjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180157; x=1793784957;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MHhXmWSjTP17S95cJvWqHO6uKt5FNXxDrOyDLF0HSW4=;
        b=c2TwzEishXQSHe7JvlwFtyUH5BiWGdwY2A8+NgEaa+h9tCZQJ4xmlfWa9hqHJy1hsJ
         Ub/6qd7PPQ0hOIhlRb6lNaT435Gqx0uBnCGomgE9us1Tr/eY8bu/t3VqbfryDVja/iM3
         JlrH+3K5TMlRoCH1Iu5E6S1OyhnyCRHQIFBkEH7qm28/+I1suTYQKsk7bfnzDbtg9euc
         Ry6fJwCtkv8RxHJ8TOZFd+csH0SVdSSbZ8OPQbde79PFPnR6jCp/v13xWqg800kNl3Fp
         /MM+VfSMnOckCEJS5qCOoC5PfyZU4ySzzbDPNg1vq3prH5aSw2XPNklJHt4vl6MLudIk
         wJ8w==
X-Gm-Message-State: AFq9FYKdfQcIyNhAqzWJkEeiZFAYVaYWBKpMBb06H7HZlkhULbOBuIUN
	pIl3ZmQrxWAQRqnLgzOjAZ+PETLq6EM6drSXF525EkkyrRD0W0p6+QZWS/yUQKXQjrq8ez1Hfyy
	Ke8OnWjYpnxGGFCfJw/qoiV5ESoeFUVLJznCda4opst+thPajIedHOvtSAp0IgadM2Rdic/DGND
	qRWv7hycpiIGQgfHXMf34lEiv/meW3G853NcduGA==
X-Gm-Gg: AYBFou3jMYS9iCMNedjEZwv9uK4U2Rgdiy77TlJUYvd9biUWeP8DnI4zezqsHezoyNz
	Vwe08HGAEcE++GM/zjQ+dhknlHdZQeoeHOwgkGgmhgb2e3dm9ch4JuJ96xAPEew1ujr97Vo3sTw
	JPPwlvjDTMFYG1FzWzauAta2bhDPfx2aNxrh113dv+WJ8NZ2h/N4u3NrPtfg==
X-Received: by 2002:a05:6a21:6e86:b0:3e8:b7fd:6288 with SMTP id adf61e73a8af0-3e9023eca31mr1324557637.41.1793180157475;
        Wed, 28 Oct 2026 02:35:57 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e86:b0:3e8:b7fd:6288 with SMTP id
 adf61e73a8af0-3e9023eca31mr1324549637.41.1793180157009; Wed, 28 Oct 2026
 02:35:57 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027144051.249211-1-ulf.hansson@oss.qualcomm.com> <CAKekbet7B=EvD+3Q9PFJAOJZvpz_hCn_dU__e+3=qhsFet=FVQ@mail.gmail.com>
In-Reply-To: <CAKekbet7B=EvD+3Q9PFJAOJZvpz_hCn_dU__e+3=qhsFet=FVQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 10:35:45 +0100
X-Gm-Features: AclHuK9QRLe35In0U3gtxLoFryGbGO3wdrYHhHW1QKxnqJjElusxrdPoYE0LnvY
Message-ID: <CAPx+jO_HUTrMnzNw-Ev0FWfJdgUQ1nU16knY=qC6oCTQh-=Yfw@mail.gmail.com>
Subject: Re: [PATCH v10 0/6] mmc: core: Keep the card powered across suspend
 when firmware needs it live
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAzOCBTYWx0ZWRfXxu8EYjbbgHdq
 VmwlR8r/l1tJFZ8M07425316W+nQOaPnXkGr3vRExMUbSG12f1NC0GNRZVZaRNdSkZkvOI9xdyL
 xKOi728Al4nSuinVlm9wlbgU93H+7vnq4s+E1cUQa8qBEPEISNHjO0EWWozrZiUKxW0hBRfvXXv
 AQsV6rJ5rBQg3AY4thlcu+BPvlqE4iZfzr5YA6jcSdyzDyHQu0+DvMz+OiX3WPAfvv0aahxkCFV
 MYvhdHciP8Zurmsp7oNGHsQhsqQbsqD0SGfkZX1sUkiMLiUrQ4qaBupfGfGl30DwAAWabuPOPk2
 V5pO9P2zhQp6AxJ3/UORJ35iDpkqUoPaPDRtp62n4a3RHqMP1bFNwhTx2vpzfIJ2jVebrlnG5fb
 eXU9r6l2AoMeAIWaWVTpoBsI443ENe+o9sA/k9HhskCG4b6rgkQulznoybc+jE8jszn43DYaIlh
 EEVjF1WB3IRhj4MOjjg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAzOCBTYWx0ZWRfX3ew5qM0HvLg/
 xv13MrYs0kgVXPltk0cW/995bzKDOoywTxEzIbgvn8UhIxscCnzEFbESrkxby0HrtFslqva7V5B
 8VJsbRdLIVAOaGvm6Cz8/VdQ/pZazPQ=
X-Authority-Analysis: v=2.4 cv=JspkP84C c=1 sm=1 tr=0 ts=6ae1c1fe cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=Q-fNiiVtAAAA:8 a=EUspDBNiAAAA:8
 a=auGEOW3Oc7kVmTz6KmgA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: tp9iUt_65EDBJpY32IsXfxUN8lTNzvHz
X-Proofpoint-ORIG-GUID: tp9iUt_65EDBJpY32IsXfxUN8lTNzvHz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280038

On Tue, Oct 27, 2026 at 8:53=E2=80=AFPM Kamal Dasu <kamal.dasu@broadcom.com=
> wrote:
>
> On Tue, Oct 27, 2026 at 10:41=E2=80=AFAM Ulf Hansson
> <ulf.hansson@oss.qualcomm.com> wrote:
> >
> > Background: on brcmstb boards with a Kioxia 016G01 eMMC, firmware acces=
ses the
> > card directly during resume from Suspend-to-DRAM, before the kernel's o=
wn
> > resume path runs, in order to load boot code using hard wired logic tha=
t is not
> > field updatable. The card needs to stay powered and responsive for that=
 access
> > to succeed, and since it is never power-cycled, it also needs to be res=
et
> > before the kernel reuses it after resume.
> >
> > Changes in v10:
> >         - To help out with the implementation I offered my help to try =
to move
> >         this forward.
> >         - The DT patches are good to go so I included them from the pre=
vious
> >         versions.
> >         - Patch 3 to 6 are new, but based on the work done by Kamal Das=
u.
> >         - This is completely untested from my side, please help to test=
 it.
> >
> > Kind regards
> > Ulf Hansson
> >
> >
> > Kamal Dasu (2):
> >   dt-bindings: mmc: Extend keep-power-in-suspend beyond SDIO
> >   dt-bindings: mmc: Add reset-card-at-resume property
> >
> > Ulf Hansson (4):
> >   mmc: core: Add option to keep an eMMC powered on at system suspend
> >   mmc: core: Split sdio_set_host_pm_flags()
> >   mmc: core: Move reset functions for eMMC
> >   mmc: core: Add support for resetting an eMMC at system resume
> >
> >  .../bindings/mmc/mmc-controller-common.yaml   | 10 +-
> >  drivers/mmc/core/core.c                       |  9 ++
> >  drivers/mmc/core/core.h                       |  1 +
> >  drivers/mmc/core/host.c                       | 10 ++
> >  drivers/mmc/core/mmc.c                        | 95 ++++++++++++-------
> >  drivers/mmc/core/sdio_io.c                    |  7 +-
> >  include/linux/mmc/host.h                      |  1 +
> >  7 files changed, 92 insertions(+), 41 deletions(-)
> >
> > --
> > 2.43.0
> >
>
> Hi Ulf,
>
> Test results for this series on a Broadcom STB board with the Kioxia
> 016G01 eMMC,
> which reproduces the problem during S3 suspend/resume with two DT variabl=
es:
>
>   keep-power-in-suspend  reset-card-at-resume  Result
>                             no                     no
>   enters suspend, board resets
>
>       at resume
>                             yes                    no
>   enters suspend, board resets
>
>        at resume
>                             no                     yes
>   suspend aborts, -EINVAL
>                             yes                    yes
>   s3 suspend/resume works
>
> Changes applied to Kernel: v7.3 + 7.4 merge window (linus/master
> d135ab453a74) with this
> series, plus the one-line fix I'm sending in reply to patch 6/6
> (details in my reply to that patch):
> mmc_resume() calls _mmc_hw_reset() without claiming the host, which
> triggers WARN_ON(!host->claimed) for every command sent during the
> reset. Claiming the host around the reset removes the warnings..
>
> The -EINVAL in the third row comes from mmc_host_class_prepare(), since
> MMC_PM_KEEP_POWER is not in pm_caps without keep-power-in-suspend.

Yes, that was actually intentional as we can't allow the system to
suspend in this configuration, as we may not wake up correctly, right?

Although, perhaps we should also log a warning earlier during the
probe of the host, when we are parsing the DT properties for it. To
upfront say something isn't correct.

>
> In the working case I also checked the md5sum of the first 5 MiB of
> /dev/mmcblk1 before and after suspend, and it is unchanged.
>
> With the fix applied:
> Tested-by: Kamal Dasu <kamal.dasu@broadcom.com>

Thanks and thanks for the fix on top!

>
> Regards
>
> Kamal

I will send a new version shortly to address the comments and needed fixes.

Kind regards
Uffe
