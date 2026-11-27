Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795790652;
	b=EDeYWtQz0bXpYvpUfP27GPZcc4U9SSG+quJhlaW7K064IRt0S5EaZKUPy3sIau0yTkWE
	 QqVXhQ85sNnyJGCjMI3bB/xTNhUMDU3ZPnUuASPtPSWgakwkPEWQPbqK3nDsTDaQJRjvE
	 yMBVrPycLsBqdrauE65zg15dxnnPGm5y84la4tPin2uxyDBTON+vKMphIjB2VRhbmfXeh
	 IqdfNgYvch0ny2k5RtAqvmBkX132DfZnWLqFktS9rQyu6XOuYFrJxbsFK+T5yPMoVS66X
	 ViAhgQo6Jo9tlRv0MT1csnK8BASTDaxHAY2rHUACT0KDdt8HvgTKSjafO6p10OAKAVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790652;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=pmXq4cx53aUwMhwc/UEGREZga34tC+gW3KcyCWNtHZQ=;
	b=pOf53eIDaG+hwdhbSkhYMKKBXmg+qQhzssYXzbOt5s84O9DRTDjJcZ1JGQJyZsYaz9fp
	 mve1ukbjF8RaTHI0h8GUxw6O/4AUvfSaiAogsZ2oUCkHvQc8X/nszJDON30sAh7L2jSU7
	 GqWjtLxwtSE/wNo1DhcLeBdy9MoGHh89hUOXsob+XWhm3EJQ/Pl+/Bqn+AQO7/y11KbOV
	 4AvQ203+vyYWLICrksIJzbMO1vqg0nzKblDDDS09VBDFXzCKxGnw4T65fDadZbwobGRN5
	 eLLCOQjLTI7corUJlYP7zEQjmiK795/BlVf77qJ2QTYrwjVr5rNlNtGyOAVTgmDQi3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o1LybMnF;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LYzJqxaz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CB6606A333
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8CB6606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o1LybMnF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LYzJqxaz
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE1KoQ2471797
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pmXq4cx53aUwMhwc/UEGREZga34tC+gW3KcyCWNtHZQ=; b=o1LybMnFRa+q79+V
	ekVA4miAUH6PmcFrPXvFjVQ8gPcGrgdAdQgVYMMohiAs5KTTGLs9wRmBzmFIyGAR
	j7eoITOl0kE42BTLSS9ytyByV8FZv8UAaUCTabK8cAoAHpJMnXsxDtIcZP9SPlI7
	ukRBmMXS6h/cJihq8GfSh3KtNSSGD+IHIBXyjJ0GV2rx7klf6IgWEdQHGRgw1/5v
	Zuc4IzPCS05eQrAflhuVMJ8USxnRc8GvxHS+28zCoooFPIA4RrIZ+q+XfU4dLYNi
	kKnF8cCLHm58FFz3MYF4OIt8LHZl/9Bxcl2oIpx3t78rngF5XPwEaxD5nFplt3Ur
	q/SYDA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74gaswg1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 14:44:10 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cdb86c39250so4391021a12.2
        for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 06:44:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795790650; cv=none;
        d=google.com; s=arc-20260327;
        b=Ie5vehyOd8wZup65rCsLt/stEUyi8jCqcbCp15G9HwNFvsJKxVYcWbZDDdZnqFLEPu
         OE6sxRFR6RNEo5UztbmMYKefKTJpV+yH4RFd0CXeK4fpfpyQkatMxQTWLJxjhXFIwbQl
         QsZjWRdS+aiaSm4FOmD930ceSZhu5uRYcpblNMsiQjn1UUwO9GaYOzrdT/7B0F81MQ32
         swamniw7f3VC512ucvl7NDhhrn4oAMkiriWJ0FsQAIZ6EEKpq19l5KCX1SD9i4XxVLaF
         /M5Qf6Y92dw5B4SSoQhBYXeHyW5twCgVZozXmZ9zJOCTy+udGtojbWnjnIJeX1XBAbFB
         qssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pmXq4cx53aUwMhwc/UEGREZga34tC+gW3KcyCWNtHZQ=;
        fh=P2XN6QEFe3o4IefAtku5KUIdBwEsnnA52jDqC/WLzfQ=;
        b=gvXHk9zI8gwlCjzmdgTgSm/Xw6JQoMuzWFKLo6Lxb17sYzt/4MXgyH4kB2ghXjw7c/
         Vje+mhxmm0qS1/IJD/ZFdSz4YYsRBpnjxpwcokTwaYtOflBg8AlWbqMPV+Tj+MNfgprn
         1VEFZ/zJRmxNcw7ozZokHOG4kxfNXOChU8wtY88WLNie9TrfnvPxiOZ8Iq/fbx4bDvjb
         wK8uGTHdahC/1BRhm/b3LfJtiU1vW0QMWz8+DpdBIkWNjP5gSTqCgb8ZffPx3XcFZI7a
         Y59fpY1CgzVIcGhuyjipEWSRihHjbsoom0RkRfIYbalOAHUpP1t4m2dGD5Lsi0GSag7v
         Bj2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795790650; x=1796395450; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pmXq4cx53aUwMhwc/UEGREZga34tC+gW3KcyCWNtHZQ=;
        b=LYzJqxazovw/e3wTvv0whYtn4VBANGtVVN0VCGLsv1PFK8e6jCrz6Ce4p+4JAwC6Kn
         MJJHLjN18V4Tj6PFBfO1KXqQAO0+ojMUVoVQFML1urZR0KD34YFlBNoXdxy/K43drMJu
         ZMENt3vp9gng3L0azPcEwlNR4trfewe7d5LmdZ/Vp0Se2YZBn9mkCgqxRmaqxIidJB9/
         ebhdrEyE7n0GGZ5tFotuuE/sav++QNgp0AYVZlxJbTXMgImswYvJiu8gEcArXC7sd11B
         UcQXc0DIa+LTKRpwvaKSal0J+vU898SMcgVx+5p4L50TXxsvXHSFuzYhu8CZbhncfbbW
         RQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795790650; x=1796395450;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pmXq4cx53aUwMhwc/UEGREZga34tC+gW3KcyCWNtHZQ=;
        b=w8Terme2keMYxOvs3d3RQrmMYAtAvl25BKc4X4C4Xpp2SOfWPFMKUOTbEJKCTbdpPr
         4xzDu+tBrMAJUVOR2z6TabDDS5pDEray6uQQXkOvJw+GP6EbHKtEqvea2zL2ptZxUfZk
         a8dzuYNLwmyDavsauINH5Zj4zNduyi1AudY738cqKuOUo9d9kPf1ibTL7Su5DtuefPSo
         d8KsqA+9NRVt8meaJVTsOwEQ1R/97qDd/Ru8DIn6eaJeBSOWMHyRcj4MUMgazYgvWcEV
         o13C/Wzk34S5bzyhMgKeAcPscGTRtT2JBtV1QsWxcPqxDyjflAaN4nnXXV3IEFpw+VLT
         hk1g==
X-Gm-Message-State: APuU4Z8uG9T9LzbCkEWrHOPuIi7krCTZ30xpp+Rj5BWdhVfZxvLk7fpM
	v2VMdSpSCnLVeT2NZt78A/f0byQ/0nU8GrJ71rrDtYhyx5zB7+bI2fZCBIZWBv4IHXf/UFZYohy
	SpVX9gYOwDh2XSUXRtB8L4W2PF33W6F7jiwkupXHGCSAOFL8GocFfI4DCkRWYxmmdkzMffjcmz1
	cQ19LVotzhA3qC9dEhlRIdFUCch2Dg/teIj9hM1A==
X-Gm-Gg: AZFdTZd6SOdTAqISP5SpsbvEYK4qfZX8eaNuG/yshAI+DahIl1UgwpAgkUpwo3p4H/g
	CyOUhKIKW2m+cdq3ngHcvV3aKSou6AneeHsoNfuklUIU/2hPJbKoQiY73IFy6qG/0ElM1kvsOoh
	uXzY4OtAShPcJ0bJhmgpoI8LQG4yo45C5wL66hiaX1KFcLdWo1S8JYAyVOSQ==
X-Received: by 2002:a05:6a20:af1f:b0:3fb:3d85:ef56 with SMTP id adf61e73a8af0-40295495278mr14267557637.66.1795790649583;
        Fri, 27 Nov 2026 06:44:09 -0800 (PST)
X-Received: by 2002:a05:6a20:af1f:b0:3fb:3d85:ef56 with SMTP id
 adf61e73a8af0-40295495278mr14267522637.66.1795790649103; Fri, 27 Nov 2026
 06:44:09 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125182053.3915833-1-kamal.dasu@broadcom.com>
In-Reply-To: <20261125182053.3915833-1-kamal.dasu@broadcom.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:43:57 +0100
X-Gm-Features: Aa3M54qM6x7CvrBi3F_w95jH3rk5p3lMNpHZ4R4dB4h4-G4B4KSdfHnhwL7kMsY
Message-ID: <CAPx+jO-iz4bWj32mAQy548YA+RpKN5jVNzAg4y7m1-1PTFwwig@mail.gmail.com>
Subject: Re: [PATCH v14 0/6] mmc: core: Keep the card powered across suspend
 when firmware needs it live
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Shawn Lin <shawn.lin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: _PAz5JI4gLf1CBDDf00DFBkgNUvAaLcE
X-Proofpoint-GUID: _PAz5JI4gLf1CBDDf00DFBkgNUvAaLcE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX/aBr30qvH0zb
 3JuGWkeoTVODWJvC/Mr6wR2gqx2MoDtP8mvakC2nPchAZOd7rSKFDQYUCRq6Aq3fRZ+plWFHoiZ
 ZJNv7nZS6l6+IBrBa3zKsoQDM4a/0CgsAQE9d1IMFc19nd3cgdhM+nBLcdlorACPjItBjcszZpU
 rHzJLcABlrqEpkRLb2OSl93UOoHmlZbNCVKKVC8AOSN4GKyiqvUougGJxwmr3ndIQF/KO/0mW5S
 NEaHezOzAyYq+/hyTt8Z2v3ariJOE+KRKXxLxkIuEjPw88kloh7kzXdMzkYuTHUrTnS+GFLvTwm
 bWp9PqbhEZnncfjtyQ+nn/YY63MlSFaCll4FJgFVrFcV+mhffQ/B3McCvShaELQrJgCWSAE7Xnc
 nMHhUe9RlYg6gYShbgxxSi/OO2ENcC7wBEU8NQMOxOdIhbe0aDj21VF0Jel2Z/CkwgFAddRhZc6
 FUeqF/OLsC37+x7y+sQ==
X-Authority-Analysis: v=2.4 cv=I5bw19gg c=1 sm=1 tr=0 ts=6b09973a cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=Q-fNiiVtAAAA:8
 a=14t6xIGfFiX4SUP_uEsA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX9x88SFcz2zjd
 Aq9YPzOA3LBFPk7RiptCAiQ/FSG70eQ9f1xN18cXSg66mRDanligDPlqppVHQh0b8buYI/Fst2b
 USlUTx/YU1iuxERPqGkmPObSINZOb94=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270058

On Wed, Nov 25, 2026 at 7:21=E2=80=AFPM Kamal Dasu <kamal.dasu@broadcom.com=
> wrote:
>
> Background: on brcmstb boards with a Kioxia 016G01 eMMC, firmware accesse=
s the
> card directly during resume from Suspend-to-DRAM, before the kernel's own
> resume path runs, in order to load boot code using hard wired logic that =
is not
> field updatable. The card needs to stay powered and responsive for that a=
ccess
> to succeed, and since it is never power-cycled, it also needs to be reset
> before the kernel reuses it after resume.
>
> v13: https://lore.kernel.org/linux-mmc/20261113211143.3759154-1-kamal.das=
u@broadcom.com/
>
> Changes in v14:
>         - Patch 6: Clear MMC_PM_KEEP_POWER in mmc_host_class_complete() w=
hen
>         MMC_CAP2_RESET_AT_RESUME is set. The flag is set in
>         mmc_host_class_prepare() but was only cleared in mmc_resume(), so=
 it
>         stayed set if system suspend was aborted after prepare (reported =
by
>         Sashiko).
>         - Patches 1-5: No changes.
>         - Tested with CQE enabled.
>
> Review feedback addressed so far, including Sashiko's AI review comments:
>         - v14, patch 6: MMC_PM_KEEP_POWER is set in mmc_host_class_prepar=
e()
>         and was only cleared in mmc_resume(). It is now also cleared in
>         mmc_host_class_complete(), so it doesn't stay set after an aborte=
d
>         system suspend.
>         - v13, patch 3: CQE is turned off explicitly when the card is kep=
t
>         powered, as the cache flush may not send any command that does so=
.
>         - v12, patch 6: An error from _mmc_hw_reset() in mmc_resume() is
>         propagated instead of being dropped.
>         - v12, patch 6: reset-card-at-resume without keep-power-in-suspen=
d
>         makes the host probe fail in mmc_validate_host_caps(), instead of=
 only
>         warning, as the card would otherwise be powered off and system su=
spend
>         refused (Ulf).
>         - v11, patch 6: The host is claimed around the card reset in
>         mmc_resume(), as it sends commands to the card.
>         - Earlier series, before Ulf's rework: Sashiko noted that the DT =
schema
>         allowed reset-card-at-resume without keep-power-in-suspend. Patch=
 2
>         keeps the "dependencies" entry that enforces the pairing.
>
> Tested on a brcmstb board with a Kioxia 016G01 eMMC, running S3 suspend/r=
esume
> (pml -d) with the DT properties set as below:
>
>   keep-power-in-suspend  reset-card-at-resume  Result
>   no                     no                    board resets on resume
>   yes                    no                    board resets on resume
>   no                     yes                   host probe fails with -EIN=
VAL
>   yes                    yes                   resumes, card re-enumerate=
d
>
> Kamal Dasu (2):
>   dt-bindings: mmc: Extend keep-power-in-suspend beyond SDIO
>   dt-bindings: mmc: Add reset-card-at-resume property
>
> Ulf Hansson (4):
>   mmc: core: Add option to keep an eMMC powered on at system suspend
>   mmc: core: Split sdio_set_host_pm_flags()
>   mmc: core: Move and split reset functions for eMMC
>   mmc: core: Add support for resetting an eMMC at system resume
>
>  .../bindings/mmc/mmc-controller-common.yaml   |  10 +-
>  drivers/mmc/core/core.c                       |  10 ++
>  drivers/mmc/core/core.h                       |   1 +
>  drivers/mmc/core/host.c                       |  26 ++++
>  drivers/mmc/core/mmc.c                        | 111 ++++++++++++------
>  drivers/mmc/core/sdio_io.c                    |   7 +-
>  include/linux/mmc/host.h                      |   1 +
>  7 files changed, 123 insertions(+), 43 deletions(-)
>

The v14 series applied for next, thanks!

Kind regards
Uffe
