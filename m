Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792765378;
	b=dSuNwMUM8j51qqysGgkJbuO4XnhlWX/uKuK0GdEtuVj32rSk379c9f9sDV/2exg5e3PY
	 ADyL1zNE3QH+Vp/HfWaxlHAfrrvrwzpuQueLIvadL+e4CquArZ6zrImNyF6kcAGHtpJgW
	 UNFlLllqRT61EQLujlFY9uTGamHFpoYKoNGgxxFo/bU2u05oXdDsyjliON5ptt3WQAvig
	 lAFrFwTNmCsFjVsPwAQmARqGQUCm/kgc7eSr1OIn8em81x5VuX9U51xA7vMyWX43mo/Gv
	 sO91Nl8Ub78r9bPTytN4IraOTjqfOEiyhKB/fXBW/uv3G2KkvOKO6OQTZtG3vkgTgzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792765378;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=XMliHmgEXCZhW3mzsOe5HViyYnbxOGGgocWUZ+YLweI=;
	b=1NKHQ1Bg2DNv6Tc38G/mut97BCBKBRPGh9mSLEna/zD7HyhDNkkScZOShAaj1PaPwusl
	 82pHgOE8VhogJhwCCiIEXmyRmdV3E0SBuwMHCtI5XJPdHwYsEcZ8U30hpfkS9ir65q2xy
	 c9BL69pc76XN54rqrff4OYQcTD2J328+1UO9gcpwM2R751et3gj8AKhyrjpRCn5w1QOd2
	 XBLdMDJ3wuhb9hHhozYH4HcczEysqGOKtw1BHZIi26zqnS8tru+c9ixV/CF3Axx0Z3dGX
	 AGRjv0/0FkEpxzwoTB8o0fOoPy39VmiCWlf3G4aOZayTp/gI8aNTlPJUu0CSnJA29pQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iQCgsjTC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Uq5huPee;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EEE606A31A
	for <linux-mmc@vger.kernel.org>; Fri, 23 Oct 2026 14:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52EEE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iQCgsjTC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Uq5huPee
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE6CKf2462547
	for <linux-mmc@vger.kernel.org>; Fri, 23 Oct 2026 14:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XMliHmgEXCZhW3mzsOe5HViyYnbxOGGgocWUZ+YLweI=; b=iQCgsjTCSCdCePtt
	Yo4yTJRQr8K6CmQQhJfDpo2B1N1ZNbMWV3r2SboHfJBM3G52DLXpkD8vIDZuIjEW
	ReEGTVs0pE55+MRkJve3dzYadv16iArGZAo/VZ/o2M+NDnofubAsA4zBOPj5SKpm
	4rSVBk0auEOxlJU4g8g9CowbpKUeYCz0Jq90Puxhx95bwQNh0SjdNeCiO1c39pDJ
	ci6suX4lt1eY5wt3O4eN1DTeal9CDFZImds/CEb0uhcK7dOjF1Gg5YYPAsEWdzdX
	+DzKYOUtHb6IQkfNEIMQuPUnINlUPpvL7ZAJi7aRUQ++UQleQs6C51wbEoYlgz1N
	UeMlzA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmtv3pe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 23 Oct 2026 14:22:57 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7bf634a101fso919818137.3
        for <linux-mmc@vger.kernel.org>; Fri, 23 Oct 2026 07:22:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792765376; cv=none;
        d=google.com; s=arc-20260327;
        b=VZJatIOlp7WU2i6zMKnh9Z4NX3/MJy8TrCQ9ad1c2x3/MoGNljulyjX8yzzuwwzdE6
         +bC9bvUIzVshOd6XkNUcALIPbhHbfgLPjCpdHwJqY2v355JycjMda5PXvWwptlws7Diw
         z0Q8ydeI685uTd0HbH+IvrW1QU29QzadMTdx1t37iWyXdFZ2k92k+cc+q0Bs4Z2zLt5N
         vy441rx2TTlpcZtpDyYJ2oNSBq0rz5f0ZQYXLQZ4fLM8RI5PMlo8Bkd0TkfRz70JaTMp
         wypymoEt65u6KZcDJCC6G2Hr2xQ1pj5p34fZLqWqmv0mKDA71Fci0DUXnih+0Q0I7Cvp
         YeJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XMliHmgEXCZhW3mzsOe5HViyYnbxOGGgocWUZ+YLweI=;
        fh=NQmeoTxH4nKtqpOkgyLVrTBvhxj5ve5+FWEIhnhhlAE=;
        b=DYZKQ6JbhGMIQXMX97n5LqOsSNd7xAZ8MVYNHx9lEgQ8osnqQyfOqHgCIJYhbtVaZt
         eZs34xwRnydOC6YRXdYKpFr2031GtATTj4/F9VICKgR5bYAWGXNd9soKGzZHCOEB/ipP
         pogzGl8+cVuPkElLtq+FWlClALtcCvEu+kM2VIbUkJ/fO18IqmGhlBc6QiG2QUKYRTx/
         o53HkD2s4y5mb03tjGTomUqvoHZX1BXOtHbCXbBSjIT3sAiu1l6KEKnE3yu4lvFSROSp
         kRzJUAC6C4VpNDO4DSl6P53X5lrQLlL8x0+O7dCDog+qwzXsdGXm5yJCQTylF76zJWIY
         yB6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792765376; x=1793370176; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XMliHmgEXCZhW3mzsOe5HViyYnbxOGGgocWUZ+YLweI=;
        b=Uq5huPeehGm6CMEky5WOq8Gv9xZ9GEepsCnPGtz1lqRm5yRLUmn9j53KVtjG3NzdX3
         1aQCxyi/bloco5+8Pc+yfmAwaLC2k1GCY/9HS/WZicU9g3pVEm4ar3AFtw4EBEmSYsQQ
         k/C6Dfg5cEEWXpgoXG0M0MdHe0Ui4rPy2N0rbiOO4cGPRkn6d/xBQ2vYRtYrJJvvz9xB
         GC5O9eYXy7+7WRI0EWdf4EAQcaGcG6AY6BXSRARp90q63s8lkCTfn0clYICnbGBfAX0F
         4ft55XErnVC08A6FABi+MCQxxbxxfJB8kBHQ45z+ytCIxFwpAce1LcxUA+df0n28WOBX
         PV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792765376; x=1793370176;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XMliHmgEXCZhW3mzsOe5HViyYnbxOGGgocWUZ+YLweI=;
        b=fHdKHxXKFUrA/x3D7Fw0Zx/ZKLwzL8ru9st30Btx8bW7nLddv40sGPGwgM4Vr3jKCJ
         Vv7zhAfwUzsT2uL3Piafk1gTf7Ihv/gSkyjJ74hoemR0DQV9Wsl2MPO0QLAhosb6QttZ
         G6t5W2cfGtzlt0IT/G+2+5H4z71R6u8NanPQVi70+1K+FzZ9gOwk4+zjP5uzSdz+s4Ic
         DkxeaqbgkAuW75Ox6OqX0vJ8Kw3BfaASIHpYGoBDADkUUV5dPSf631Pq64aiq3npYE2P
         +sRPuq0+Qx1jRyRcd22o7uTEpifOHNvQz6LVRkcbbWbzlpcpdmjHHDKyf/bRYPurRK9v
         kntQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXzpCmqY4MKXVx6YTj+trhdgMY1fLuwYgS0whI9UP8bJX5PYrNqrg89u5BpAzAz30Av7sla0KiGFE=@vger.kernel.org
X-Gm-Message-State: AFq9FYID5lNUq4//BYrQS7FGwTIitMiEeI9GRGqEeIdnJ6qEgaALY2T0
	wx/kvzPGUAiWyjYpnlxLxeAlNRbjN39yaQgBfPXEadKLfzHSbwFl3VSPrSFAYrGCKz5jVI7/IjC
	kh0mb1s9qj2s6zsJvEkKA7GRmcWTJ994zwOOxy03V/FewerY9v34NU48guVTxP8y4jtnoXJCGtZ
	aNU758b+cTHFRHSlH4KW4Ek4vDPCHJ8V2Iu9j8VQ==
X-Gm-Gg: AYBFou1yjXoqS5BAZpVhWpG8d/6WZVKK/Av69yjsFJJL/JojWq3j2DKZeq+YDI2lGfr
	uWQv9lFWU8meGeDX+ap5YWWa4tooHjzRSbWyiCUjoSXEBTVHHDcn26GRtHVL+WEy8WrZ4ndIpsr
	xbmi6ESfpkmP14+xWQ3ZRAdxfk6fxK11aeUehCjyjx6aGlS5yayUGwCnW8lA==
X-Received: by 2002:a05:6102:290d:b0:7cc:2f04:a078 with SMTP id ada2fe7eead31-7ccc34dc8a8mr976008137.37.1792765375845;
        Fri, 23 Oct 2026 07:22:55 -0700 (PDT)
X-Received: by 2002:a05:6102:290d:b0:7cc:2f04:a078 with SMTP id
 ada2fe7eead31-7ccc34dc8a8mr975981137.37.1792765375072; Fri, 23 Oct 2026
 07:22:55 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260811163810.1599747-1-kamal.dasu@broadcom.com>
 <20260811163810.1599747-4-kamal.dasu@broadcom.com> <CAPx+jO9Gpjb5b8ZpYypCshxKaaK80b5t2TJQTb-pCzas7z8q_A@mail.gmail.com>
 <CAKekbetFSCXtOAgKYH=sPsv1ykB1CorhhGueYsUvBFowN+CWkQ@mail.gmail.com>
In-Reply-To: <CAKekbetFSCXtOAgKYH=sPsv1ykB1CorhhGueYsUvBFowN+CWkQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 16:22:42 +0200
X-Gm-Features: AclHuK9yxrg978PzlPiKIPqNL1xIrdMwJxN3ibnnC1vm4u0mAskgWm-7SFsHDQI
Message-ID: <CAPx+jO_p-cnecJ+Qy1z9ne2Xk_HXL-pR6eWtZiLkqdZoheSP_g@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] mmc: core: Honor keep-power-in-suspend and
 reset-card-at-resume for (e)MMC
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
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6adb6dc1 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=Q-fNiiVtAAAA:8 a=EUspDBNiAAAA:8
 a=ZoeIAiwIGO8zCctmP9UA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: G1b6poN-Ht3nmmh_AuEsW9mCm5Q-TGjM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1NiBTYWx0ZWRfX1ZlosSe6/Js6
 7dSyN/GDCwtsXSLs4QVFFqgglKn0bJTCflNS2rzTS14jaG9x0Pps6wKxziubcuuq5Fch+BOxE0g
 Xi4vIBNOII9uq4/YxLfQDtYuHP7r2l0ttGz6fm2ZZuWmq83A/Mvv/I5gB9TaeXjoovxW5cST0vr
 csgWteTDiFwy7KxDEpOoyVDCzEJSnL4QScukSM2UNsNO0XHH62gG2my+1TTgVDACyH6YawaZyrd
 yZLvq/08k/CiWGW/BeAt1AFAQbbVyWP013fFMWSxNTyfQ6iTyCI2hu7tZvZ0SaNzW+C5P5Uz+UQ
 zh28diOTpverH1/e1T4KwHmEEKVjLSuqm48BK8MXoKz+bfavyJ/MTh8bt0UKxZChFrvrP4DwZ/f
 SWJLXcqpZ5yo0tThYuy29GdjR3UZlZci2UBNcVg+ZavpNgDg5GRzbuESWT2anIRYEqj4R2bdk3w
 C2C7rt9/Aj/zeSvZx7Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1NiBTYWx0ZWRfX3mX/FIHKYQSu
 YizJ98UCVYR6MFgRLZjp5DA9+IMUaXNPP+oOCCK0KoX2eVh5suWj2dcrc9sinVrlVU/ryGZIYcx
 jYsRoQet2PDdfmUMt24HbG2wvKA8Tok=
X-Proofpoint-ORIG-GUID: G1b6poN-Ht3nmmh_AuEsW9mCm5Q-TGjM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230056

On Thu, Oct 22, 2026 at 11:14=E2=80=AFPM Kamal Dasu <kamal.dasu@broadcom.co=
m> wrote:
>
> On Mon, Sep 7, 2026 at 9:59=E2=80=AFAM Ulf Hansson <ulf.hansson@oss.qualc=
omm.com> wrote:
> >
> > On Tue, Aug 11, 2026 at 6:40=E2=80=AFPM Kamal Dasu <kamal.dasu@broadcom=
.com> wrote:
> > >
> > > On some platforms, firmware accesses the (e)MMC card directly during
> > > resume from Suspend-to-DRAM, before the kernel's own resume path has
> > > run, in order to load boot code. This requires the card to remain
> > > powered and responsive throughout suspend: putting it to sleep,
> > > sending it a power-off notification, or removing its supply is not
> > > safe, since firmware needs to talk to a live card. Since the card is
> > > never power-cycled, nothing else resets it back to a known state
> > > before the kernel reuses it after resume.
> > >
> > > keep-power-in-suspend / MMC_PM_KEEP_POWER already exist for the first
> > > part, but are only consumed in the SDIO suspend/resume path
> > > (mmc_sdio_suspend()/mmc_sdio_resume()), gated on a per-function
> > > runtime request via sdio_set_host_pm_flags(). (e)MMC has no
> > > equivalent function-driver layer to make that request, and the
> > > requirement here is a fixed platform characteristic rather than a
> > > per-cycle one, so _mmc_suspend() checks host->pm_caps directly
> > > instead of pm_flags.
> > >
> > > reset-card-at-resume covers the second part: when set, _mmc_resume()
> > > resets the host to its initial bus state the same way _mmc_hw_reset()
> > > does for a non-power-cycle reset, before mmc_power_up() and
> > > mmc_init_card() re-identify the card.
> > >
> > > _mmc_suspend()'s fast path requires both MMC_PM_KEEP_POWER and
> > > MMC_CAP2_RESET_AT_RESUME to be set. Keeping the card powered without
> > > also resetting it at resume is not safe for this driver: skipping
> > > mmc_power_off() leaves power_mode at MMC_POWER_ON, so mmc_power_up()
> > > no-ops in _mmc_resume(), and without an explicit reset first,
> > > mmc_init_card() runs against whatever bus speed/width was active
> > > before suspend instead of the initial state it expects. Conversely,
> > > _mmc_resume()'s reset checks pm_flags rather than the
> > > MMC_CAP2_RESET_AT_RESUME capability directly, since pm_flags is only
> > > set when the fast path actually ran -- the only time power_mode is
> > > guaranteed to still be MMC_POWER_ON, and so the only time resetting
> > > the bus before mmc_power_up() is both necessary and safe. Without
> > > that check, MMC_CAP2_RESET_AT_RESUME set on its own would drive the
> > > clock and bus lines while the card's supply is still off following a
> > > normal mmc_power_off().
> > >
> > > The fast path also leaves the card marked suspended without powering
> > > it off, so _mmc_suspend()'s pre-existing early exit for an
> > > already-suspended card can no longer assume there is nothing left to
> > > do: a shutdown, unbind or undervoltage event can still arrive before
> > > the card's next real access lazily triggers _mmc_resume() via runtime
> > > PM, and those events need the normal power-off sequence regardless.
> > > Reselect the card and continue into that sequence in that case,
> > > instead of returning early and silently skipping mmc_poweroff_notify(=
)
> > > and mmc_power_off(). Reset the host to its initial bus state first,
> > > the same way _mmc_resume() does, since firmware may have left the
> > > card in a state that doesn't decode reliably at whatever clock/timing
> > > was negotiated before suspend -- otherwise mmc_select_card() itself
> > > can fail and abort into that same early exit, before ever reaching
> > > the sequence it was supposed to fall through to. If mmc_select_card()
> > > still fails after that reset -- the card may genuinely be gone -- fal=
l
> > > through to mmc_power_off() directly rather than aborting again:
> > > unlike the other steps here, powering off doesn't need a responsive
> > > card, and shutdown/undervoltage need the supply actually removed
> > > regardless.
> > >
> > > host->pm_flags is set alongside marking the card suspended, and
> > > cleared in _mmc_resume(), so host controller resume handlers can tell
> > > power was preserved if they need to.
> >
> > While I certainly appreciate a descriptive commit message, this is a
> > bit overwhelming. Please consider making commit messages a bit less
> > wordy and more to the point.
> >
> > By reading the above, it becomes clear to me that we should really
> > split this patch. Both for reviewing purposes, but also to use the
> > step-by-step approach.
> >
> > I believe the first the patch should take care of the updated
> > interpretation of MMC_PM_KEEP_POWER for eMMC and a second patch on top
> > should deal with the "reset-card-at-resume" thing.
> >
> > Anyway, I understand the code in the mmc core for power management is
> > somewhat tricky to follow. Rather than continue to provide you with
> > in-depth guidance and review comments, allow me to spend a couple of
> > days trying to make the implementation for the above and send out a
> > few patches that you can test.
> >
>
> Please let me know if you want me to fix the above issues and send a v10.

Apologize for the delay, I am on it - expect a few patches to be
posted beginning of the next week.

Kind regards
Uffe

>
> Kamal
>
> > Kind regards
> > Uffe
> >
> > >
> > > Reported-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > > Closes: https://lore.kernel.org/r/20260413180551.3683969-1-florian.fa=
inelli@broadcom.com/
> > > Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> > > ---
> > > Changes in v9:
> > >   - Sashiko's AI review found two more High severity issues in the
> > >     same shutdown/undervoltage fallback added in v8:
> > >       * Calling mmc_select_card() straight after finding the card
> > >         still marked suspended assumed the card would respond to
> > >         CMD7 as-is, but that's exactly the assumption
> > >         reset-card-at-resume exists to distrust -- firmware may have
> > >         left the card unable to decode commands at whatever
> > >         clock/timing was negotiated before suspend. A CMD7 timeout
> > >         there hit "goto out" and skipped the power-off sequence
> > >         entirely, the same failure mode this fallback was added to
> > >         close in v8. Fixed by resetting the host to its initial bus
> > >         state before mmc_select_card(), the same way _mmc_resume()
> > >         already does before touching the card.
> > >       * Even with that reset, mmc_select_card() can still legitimatel=
y
> > >         fail (card genuinely gone). The code still unconditionally
> > >         "goto out" in that case, skipping mmc_power_off() entirely --
> > >         but mmc_power_off() is host/regulator-side only and doesn't
> > >         need a responsive card, so there's no reason a select failure
> > >         should leave the supply on indefinitely for a shutdown or
> > >         undervoltage event, or leave pm_flags/suspended state stuck
> > >         retrying the same failing select on every later call. Fixed
> > >         by falling through to mmc_power_off() directly on select
> > >         failure instead of aborting.
> > >   - Patches 1/3 and 2/3 are unchanged from v8.
> > >
> > > Changes in v8:
> > >   - Sashiko's AI review of v7 found a High severity issue: the
> > >     keep-power fast path marks the card suspended without powering
> > >     it off, but the pre-existing early exit at the top of
> > >     _mmc_suspend() (for an already-suspended card) doesn't know that
> > >     -- it just returns immediately regardless of pm_type. Since the
> > >     system-resume path only re-enables runtime PM rather than calling
> > >     _mmc_resume() directly (that happens lazily, via runtime PM, on
> > >     the card's next real access), a shutdown, unbind or undervoltage
> > >     event landing before that next access would hit the early exit
> > >     and silently skip mmc_poweroff_notify()/mmc_power_off() entirely.
> > >     Fixed by reselecting the card and continuing into the normal
> > >     power-off sequence whenever the card is suspended via our fast
> > >     path but pm_type isn't a plain suspend, instead of a bare early
> > >     exit. Calling _mmc_resume() itself from here isn't an option, sin=
ce
> > >     _mmc_suspend() already holds the host claim.
> > >
> > > Changes in v7:
> > >   - Sashiko's AI review of v6 found two real, complementary bugs in
> > >     treating MMC_PM_KEEP_POWER and MMC_CAP2_RESET_AT_RESUME as fully
> > >     independent in this driver:
> > >       * keep-power-in-suspend without reset-card-at-resume: confirmed
> > >         on hardware to hang -- _mmc_resume()'s mmc_power_up() no-ops
> > >         since power_mode never left MMC_POWER_ON, so mmc_init_card()
> > >         runs at the pre-suspend bus speed and CMD1 times out.
> > >       * reset-card-at-resume without keep-power-in-suspend: the reset
> > >         block ran mmc_set_clock()/mmc_set_initial_state() ahead of
> > >         mmc_power_up(), while power_mode was still MMC_POWER_OFF from
> > >         a normal suspend-time mmc_power_off() -- driving the clock
> > >         and bus lines before the card's supply is enabled.
> > >     Fixed by requiring both capabilities together for the suspend
> > >     fast path, and checking pm_flags (not the raw capability) for the
> > >     resume-side reset, so it only ever runs when power was actually
> > >     kept this cycle. Verified on hardware: the keep-power-in-suspend-
> > >     without-reset-card-at-resume case now correctly falls through to
> > >     a normal power-off/power-on cycle instead of hanging, and the
> > >     paired-capability case is unaffected (still hardware-verified,
> > >     now with an extra confirmation run after this fix).
> > >
> > > Changes in v6:
> > >   - Reworked around Ulf's two-property split: dropped the
> > >     unconditional mmc_set_clock()/mmc_set_initial_state() reset from
> > >     the suspend-side fast path, and instead perform it in
> > >     _mmc_resume(), gated on the new MMC_CAP2_RESET_AT_RESUME (from
> > >     reset-card-at-resume), matching the property's name and
> > >     description ("before the card can be used, it must be reset").
> > >   - No longer touches MMC_CAP2_NO_POWEROFF_SUSPEND/no-mmc-poweroff-
> > >     suspend at all -- that capability and property are gone, per the
> > >     v4 rework; this patch only adds MMC_CAP2_RESET_AT_RESUME.
> > >
> > > Changes in v5:
> > >   - Only set host->pm_flags |=3D MMC_PM_KEEP_POWER after
> > >     mmc_deselect_cards() succeeds, instead of unconditionally before
> > >     it. Otherwise, if the deselect fails, the card is never marked
> > >     suspended, _mmc_resume() takes its early exit, and the flag never
> > >     gets cleared -- leaking it for the rest of uptime.
> > >
> > > Changes in v4:
> > >   - Gated the fast path on pm_type =3D=3D MMC_POWEROFF_SUSPEND; it wa=
s
> > >     previously unconditional, so it wrongly skipped the required
> > >     power-off/notify handling during shutdown, unbind and
> > >     undervoltage as well.
> > >   - Set/clear host->pm_flags |=3D MMC_PM_KEEP_POWER around the suspen=
d/
> > >     resume, mirroring the SDIO convention, so host controller resume
> > >     handlers can tell power was preserved and perform a soft resume
> > >     sequence instead of assuming power was lost.
> > >   - Dropped MMC_CAP2_NO_POWEROFF_SUSPEND and the no-mmc-poweroff-
> > >     suspend DT property entirely. Reuse keep-power-in-suspend /
> > >     MMC_PM_KEEP_POWER instead, per Krzysztof's point that the new
> > >     property described the same contract as the existing one.
> > >     _mmc_suspend() now checks host->pm_caps directly rather than
> > >     pm_flags, since (e)MMC has no per-function driver to make the
> > >     dynamic sdio_set_host_pm_flags()-style request SDIO uses.
> > >
> > > Changes in v3:
> > >   - Reworked _mmc_suspend() to skip poweroff-notify/sleep/power-off
> > >     entirely, not just SLEEP, per Ulf.
> > >   - Renamed to MMC_CAP2_NO_POWEROFF_SUSPEND/no-mmc-poweroff-suspend.
> > >
> > > Changes in v2:
> > >   - Replaced the card-level MMC_QUIRK_BROKEN_SLEEP quirk with a host
> > >     capability, per Ulf.
> > >   - Added Reported-by/Closes crediting Florian.
> > >
> > >  drivers/mmc/core/host.c  |  2 +
> > >  drivers/mmc/core/mmc.c   | 98 ++++++++++++++++++++++++++++++++++++++=
+-
> > >  include/linux/mmc/host.h |  1 +
> > >  3 files changed, 99 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > > index b7ce3137d452..1622f7846441 100644
> > > --- a/drivers/mmc/core/host.c
> > > +++ b/drivers/mmc/core/host.c
> > > @@ -400,6 +400,8 @@ int mmc_of_parse(struct mmc_host *host)
> > >         if (device_property_read_bool(dev, "no-mmc-hs400"))
> > >                 host->caps2 &=3D ~(MMC_CAP2_HS400_1_8V | MMC_CAP2_HS4=
00_1_2V |
> > >                                  MMC_CAP2_HS400_ES);
> > > +       if (device_property_read_bool(dev, "reset-card-at-resume"))
> > > +               host->caps2 |=3D MMC_CAP2_RESET_AT_RESUME;
> > >
> > >         /* Must be after "non-removable" check */
> > >         if (device_property_read_u32(dev, "fixed-emmc-driver-type", &=
drv_type) =3D=3D 0) {
> > > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > > index 05444ecf3909..3a0855a4ca44 100644
> > > --- a/drivers/mmc/core/mmc.c
> > > +++ b/drivers/mmc/core/mmc.c
> > > @@ -2144,8 +2144,55 @@ static int _mmc_suspend(struct mmc_host *host,=
 enum mmc_poweroff_type pm_type)
> > >
> > >         mmc_claim_host(host);
> > >
> > > -       if (mmc_card_suspended(host->card))
> > > -               goto out;
> > > +       if (mmc_card_suspended(host->card)) {
> > > +               /*
> > > +                * Nothing to do for a redundant suspend call. Otherw=
ise, the
> > > +                * card can only still be marked suspended here becau=
se the
> > > +                * keep-power fast path below left it powered and mer=
ely
> > > +                * deselected -- reselect it and continue into the no=
rmal
> > > +                * power-off sequence below, since shutdown, unbind a=
nd
> > > +                * undervoltage need mmc_power_off() regardless of ho=
w the
> > > +                * card got here.
> > > +                */
> > > +               if (pm_type =3D=3D MMC_POWEROFF_SUSPEND ||
> > > +                   !(host->pm_flags & MMC_PM_KEEP_POWER))
> > > +                       goto out;
> > > +
> > > +               /*
> > > +                * Firmware may have accessed the card while it staye=
d
> > > +                * powered through suspend, leaving it in a state the=
 kernel
> > > +                * can no longer assume it knows. Reset the host to i=
ts
> > > +                * initial bus state first, same as _mmc_resume() doe=
s before
> > > +                * touching the card, so mmc_select_card() below is t=
alking
> > > +                * at a clock/timing every card is guaranteed to deco=
de
> > > +                * rather than whatever mode was negotiated before su=
spend.
> > > +                */
> > > +               mmc_set_clock(host, host->f_init);
> > > +               mmc_set_initial_state(host);
> > > +
> > > +               if (!mmc_host_is_spi(host))
> > > +                       err =3D mmc_select_card(host->card);
> > > +
> > > +               if (err) {
> > > +                       /*
> > > +                        * The card still isn't responding even after=
 the
> > > +                        * reset above -- it may genuinely be gone. N=
othing
> > > +                        * else below needs a responsive card except
> > > +                        * mmc_power_off() itself, which is host/regu=
lator
> > > +                        * side only, so cut power directly instead o=
f
> > > +                        * leaving the card's supply on indefinitely =
(and
> > > +                        * pm_flags/suspended state stuck retrying th=
is same
> > > +                        * failing select on every later call).
> > > +                        */
> > > +                       mmc_power_off(host);
> > > +                       host->pm_flags &=3D ~MMC_PM_KEEP_POWER;
> > > +                       mmc_card_set_suspended(host->card);
> > > +                       goto out;
> > > +               }
> > > +
> > > +               mmc_card_clr_suspended(host->card);
> > > +               host->pm_flags &=3D ~MMC_PM_KEEP_POWER;
> > > +       }
> > >
> > >         /*
> > >          * For the undervoltage case, we care more about device integ=
rity.
> > > @@ -2157,6 +2204,33 @@ static int _mmc_suspend(struct mmc_host *host,=
 enum mmc_poweroff_type pm_type)
> > >                         goto out;
> > >         }
> > >
> > > +       /*
> > > +        * Keep the card powered across an actual suspend; shutdown, =
unbind
> > > +        * and undervoltage still need the normal power-off path belo=
w,
> > > +        * since they aren't guaranteed a subsequent _mmc_resume().
> > > +        *
> > > +        * Check pm_caps, not pm_flags: unlike SDIO, (e)MMC has no
> > > +        * per-function driver to request this via
> > > +        * sdio_set_host_pm_flags(), so it's a fixed platform trait h=
ere.
> > > +        *
> > > +        * Require MMC_CAP2_RESET_AT_RESUME too: without it, _mmc_res=
ume()
> > > +        * has no way to bring the host back to a state mmc_init_card=
() can
> > > +        * use, since mmc_power_up() no-ops when power_mode is alread=
y
> > > +        * MMC_POWER_ON. Keeping power without also resetting at resu=
me is
> > > +        * not a safe combination for this driver.
> > > +        */
> > > +       if (pm_type =3D=3D MMC_POWEROFF_SUSPEND &&
> > > +           (host->pm_caps & MMC_PM_KEEP_POWER) &&
> > > +           (host->caps2 & MMC_CAP2_RESET_AT_RESUME)) {
> > > +               if (!mmc_host_is_spi(host))
> > > +                       err =3D mmc_deselect_cards(host);
> > > +               if (!err) {
> > > +                       host->pm_flags |=3D MMC_PM_KEEP_POWER;
> > > +                       mmc_card_set_suspended(host->card);
> > > +               }
> > > +               goto out;
> > > +       }
> > > +
> > >         if (mmc_card_can_poweroff_notify(host->card) &&
> > >             mmc_host_can_poweroff_notify(host, pm_type))
> > >                 err =3D mmc_poweroff_notify(host->card, notify_type);
> > > @@ -2217,9 +2291,29 @@ static int _mmc_resume(struct mmc_host *host)
> > >         if (!mmc_card_suspended(host->card))
> > >                 goto out;
> > >
> > > +       /*
> > > +        * Firmware or other hardware may have accessed the card whil=
e it
> > > +        * stayed powered through suspend, leaving it in a state the =
kernel
> > > +        * can no longer assume it knows. Reset the host to its initi=
al bus
> > > +        * state like _mmc_hw_reset() does for a non-power-cycle rese=
t,
> > > +        * before mmc_init_card() re-identifies the card.
> > > +        *
> > > +        * Check pm_flags, not the MMC_CAP2_RESET_AT_RESUME capabilit=
y
> > > +        * directly: pm_flags only ends up set here when _mmc_suspend=
()
> > > +        * actually took the keep-power fast path this cycle, which i=
s the
> > > +        * only time power_mode is guaranteed to still be MMC_POWER_O=
N (and
> > > +        * so the only time this reset is both necessary and safe to =
do
> > > +        * before mmc_power_up() touches the bus).
> > > +        */
> > > +       if (host->pm_flags & MMC_PM_KEEP_POWER) {
> > > +               mmc_set_clock(host, host->f_init);
> > > +               mmc_set_initial_state(host);
> > > +       }
> > > +
> > >         mmc_power_up(host, host->card->ocr);
> > >         err =3D mmc_init_card(host, host->card->ocr, host->card);
> > >         mmc_card_clr_suspended(host->card);
> > > +       host->pm_flags &=3D ~MMC_PM_KEEP_POWER;
> > >
> > >  out:
> > >         mmc_release_host(host);
> > > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > > index ba84f02c2a10..14a407a9f9b7 100644
> > > --- a/include/linux/mmc/host.h
> > > +++ b/include/linux/mmc/host.h
> > > @@ -463,6 +463,7 @@ struct mmc_host {
> > >  #define MMC_CAP2_CRYPTO                0
> > >  #endif
> > >  #define MMC_CAP2_ALT_GPT_TEGRA (1 << 28)       /* Host with eMMC tha=
t has GPT entry at a non-standard location */
> > > +#define MMC_CAP2_RESET_AT_RESUME (1 << 29)     /* Card must be reset=
 before use at resume */
> > >
> > >         bool                    uhs2_sd_tran;   /* UHS-II flag for SD=
_TRAN state */
> > >         bool                    uhs2_app_cmd;   /* UHS-II flag for AP=
P command */
> > > --
> > > 2.34.1
> > >
