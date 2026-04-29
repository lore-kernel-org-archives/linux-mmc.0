Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B3B22370A
	for <linux-mmc@vger.kernel.org>; Wed, 29 Apr 2026 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777479757; cv=pass; b=R2oqfOFg1jQVFbH4c+MLbTwn7Vbi6SzklxOGi1Rnyr1vnJC9JXIfuaihlDFCPUG9LD+lAe35v47T20kzL1Y0giyhhlBpwHRwC7rcw5QUICyxXZuduLiTWdCKHmzUKpO4HNV9Wd/PpQOECvsmxayZvlXKWvwUbJhh8Ugsq64L3G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777479757; c=relaxed/simple;
	bh=zeHlRNAL/iq8k8oB+OXu5Y2acD+IRikshmtnJE9EZ2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gV3129qFrlEYZJhmPOeLVAQaHDX4cDuGW1Mz6P8ffjOTWeIQ/c+gxy9Wep9u3lFcPU4B17Jc2As/OwL/JRAdE5omhjbdCWC+hWIS8GcWTfu7TgIJsn9JHRD1JzO+nETK9uKIn9STC0xK7ogVNYa34YfLZGe1nQT3GZyDvCNcV7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jzRi40++; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GkK2GDLC; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jzRi40++";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GkK2GDLC"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TF5QV01641530
	for <linux-mmc@vger.kernel.org>; Wed, 29 Apr 2026 16:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zeHlRNAL/iq8k8oB+OXu5Y2acD+IRikshmtnJE9EZ2k=; b=jzRi40++qm9IKV3W
	DFhl2OnAx5ljK0yTl5sdGb4NA1HEADBLS++TGqlMn+WPdwX2/6sEnm3lmv9ZYp99
	LlEcReCx/bYzwF9NLAtO7bcrJFlciMJRn4aPd4eD+Stm98eR/lZ9R/efJuSpDVl6
	p4AC2qFIxVW4C9vjed4kHsoulcpLPjlt7B+SFd8FKtUQRBzBx/9/HZp7wa0xKWjF
	8rM2KO4apJFk/+YVNR4yaMCdO560y5Z1GaPSB3DeLIl+du/7wdBMFdHNxChQbTN3
	j6zhYqIDgiwDKkVDo/UJGD/sin4FGYQlmLRq69LZ29Ly82bOVP73uBopj5ec+ouI
	5qGwVQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ducj82eeu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 29 Apr 2026 16:22:29 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7dcd603855aso1696008a34.0
        for <linux-mmc@vger.kernel.org>; Wed, 29 Apr 2026 09:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777479749; cv=none;
        d=google.com; s=arc-20240605;
        b=JMxPyzXrUpsa3H/d0sYkZPSNeipZRnt8NEdSbkQwJkmKt5I8PmugZXeuFd/xvZh4kZ
         V5ndbwoCWDGtoTuQAhL0fNGj3fkZfvcVNk2xQBfCprPa0eyrjOcF2TT7AcfyhsC4aRun
         PNczLmIn5jnNzSdglIRyqW3hX1uMBOcC3RHXsZt2F7wz3viMCxApa/JmifTR+51xr1iH
         w0JFLCwJUnf/SDFYLJPI1Hs/2JsDCLo/+M36oKNiOSp5VfFxSgikV9eZaXFgQE/SLlRQ
         ySq1fKvL5fMYjW1xEnU/V0qw3nmT056ZubhPN1xHlPwZMD24AzbXfQadjEBjEdfRqKsn
         IBog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zeHlRNAL/iq8k8oB+OXu5Y2acD+IRikshmtnJE9EZ2k=;
        fh=4Q8LW/OKvdaIsse/RqrLdU8bVLbl9/VoB8iXgvbSjNo=;
        b=NBBmOabnyLikh5K5YBRjWLvBNJIfoIYouxEsgHWFQs+F06ov3c1ANi8Q7KYiJGMXDu
         Ukyh23i0i43m0U1SSee2JulM/UAvI4yOAiQk0hlr6X1Af0uFGg906cUQxbAe+fRyHF1s
         4oQbgFQE0WUn3d1LOq5qYXvbU4aMhXFl8set3tP91uyt7Zodz+O4XXIkNYX653jvjsHD
         oMD5hP3T46yJSn1sW9Us0NALrz12OIynUle1BWCqC/79VnTf6h3ccM6cuorhvT7LwPWL
         tlheTgYUiMST5OA36vrx4DPUUvLImjLppSoZvugx1wxPpRfTy2ZehRQ+9mOozwMY6Lrh
         0NDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777479749; x=1778084549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeHlRNAL/iq8k8oB+OXu5Y2acD+IRikshmtnJE9EZ2k=;
        b=GkK2GDLCkQqfYx6JvKVq9FxU+hMrvsfGpUfPRavqDCLTUpLBKUdKe5rLsqys6FDmtP
         hIOvvEfK9Q6faBvDu4cyfg+UhizleVr7xWuPGM+/O/Smc7rzLbfFpORp6rQ6R9u9TB42
         YPliTBBJ/jTM060xEkWFeIHanPsz3QjsND1QRwNRc75XReEhwvQYDq/sOJ5sAZqqa09m
         mGS5XsOIV6arpJMMcEf7lnuj1cFn5E1nVJlL9a//ZJIk7eITAA7hTvndy26W2QBSoky3
         Dia8pdzWoCz5Ns+Xld2S5VTzXxMwdwCZB56H5G8oStRP0rifd4r3PNpyuomi6/FBTwRr
         emew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777479749; x=1778084549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zeHlRNAL/iq8k8oB+OXu5Y2acD+IRikshmtnJE9EZ2k=;
        b=N9sIlOthVIw6MYy6skOSfNkdCwGBIUkpzbiss8mT2arMYbzIptF2UUXWC5yoi6SV0r
         nExTn0BqBeqxuMzVyybMy7yNjZvlFuUiG+lldC0lCF3K9hNSt2WnIjZ1MM+VglKXJ1NA
         cQoQem3tiqa2keE0rdFL9zbr06ZywJGQxcPZklD99p8nYHt5eqY4qu/Aiwm1XJvSs6KO
         68ydCt5Rp00ZeyQqygEA+3lGMTsFRAgEvE5Mv8K2sHfcCMmMcgq/oB012P7YtHr0pc61
         RNenvkvujwHGwOR6Pf3vaz6qQeMTuMaTal+FKjIHXnPFUA4ux/IagUZ8jinEV9tyD6i2
         Ie4g==
X-Forwarded-Encrypted: i=1; AFNElJ84p7CoYlrsNue3yfKfhkg6EsUGek1+vXlxP8gwwFbsXSm0ddyBWxCiJF5DBHOmVpm/MjoOl4faqeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwdUUdatPy9XDRJgxFGs0850yNkNWTTWfFR/mjDMhPJ4SPNoC1
	PN/yH3vQQveVTCi6j4TZJffz0/yOh8c2jHdFuuW6ye1I7iYWzM7Ea2q45c2Uves1boIGDU3jD3U
	jZhjqG+WyVVCzMu60qZd7clSpIZraPZ1bgOUKYPNPocg2ka21MbByQqc2ggxgS0cwL2RaL2GC/f
	u4atelx2jcJj80XqNFGYhwWzYbRogP1ZYuVckh5w==
X-Gm-Gg: AeBDievdPYDeNpuwVoK/cqPcWaEPUqVhKRVtYTPC42axGUXFONa44Pn1yuuIuryodco
	kHctBH52Ul5zGhLRi61IYf2S801T79Jey24Zcmtm6P44KvmsjuXs0SaEGxp64dJUm+eHnDuWOQ1
	QGmIuH0TfjbZUzoKxfWYtUZGFnmRMGrjQcmAYuxniit0YEWk9QNyoicTEcIUsHhVcSd7TcRrmsQ
	4IlzYREe3GIzNbRCgSjsjK5NINeM6E/7tb922vnn5hfCmq93w==
X-Received: by 2002:a05:6820:1014:b0:696:6e28:8c19 with SMTP id 006d021491bc7-6966e288f89mr732622eaf.20.1777479748819;
        Wed, 29 Apr 2026 09:22:28 -0700 (PDT)
X-Received: by 2002:a05:6820:1014:b0:696:6e28:8c19 with SMTP id
 006d021491bc7-6966e288f89mr732600eaf.20.1777479748427; Wed, 29 Apr 2026
 09:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
 <20260428-block-as-nvmem-v1-7-6ad23e75190a@oss.qualcomm.com>
 <CAMRc=Me9G9vd06a39vi_UrXCTkUtJQRogm2MqgnwLS_r3Thyzg@mail.gmail.com> <e0adaf64-10d7-4e28-8403-769e3070ec30@lunn.ch>
In-Reply-To: <e0adaf64-10d7-4e28-8403-769e3070ec30@lunn.ch>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 18:22:16 +0200
X-Gm-Features: AVHnY4IKbhM_HKhU56A0ru1z2waWryyeh9i-sfRAmlk4QJVuWsNhvXilz3QVxic
Message-ID: <CAFEp6-26sVj21JVECREORdq+UeFTB22MoqAm6Pd2fTosCQau9Q@mail.gmail.com>
Subject: Re: [PATCH 7/9] Bluetooth: hci_sync: Add NVMEM-backed BD address retrieval
To: Andrew Lunn <andrew@lunn.ch>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: tsGNdHpa6NVnARoqGsywiaUqBs3c9xAQ
X-Authority-Analysis: v=2.4 cv=RI6D2Yi+ c=1 sm=1 tr=0 ts=69f23045 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=J1Chn9sQg74BwZjCRdUA:9
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-GUID: tsGNdHpa6NVnARoqGsywiaUqBs3c9xAQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE2NSBTYWx0ZWRfX0AYUIl1CvCLz
 fwRI6TmFQo/C1/hV1jnCX2OP0SKBL169qZ1ivGDdsbzhryp6d/Ty7Q6lRT4lHXQJz8i+FthexF/
 Gdnz/lgzr5tCaQa3f+yOJJsYLhdzIcCl0aREkbON5zFy4CoyIhy14dBVrK2g5i6d5iZpqzTPdOy
 n8mlykV4CTqKQPkkIc0neYmei4QzemapcDF6RocM1VOCi/1FGUfEv7D+UINWEhz4FnU3ezlS0js
 zig9hlJdwW+iupKheTMC2pdaMNsQ490nyKNyo2gTCBs4lrhd/dtQVS328JP1HRDtYWKqRz/hmHC
 NoWkh8uoSpM0g1fGkGZAW4S0uYxiayWnzD8y+GE2KKZbQMYuDg87ozixtJd33O8fBsKBRHyflzo
 vlPuS2sH3LCST/mJkCFJz5UVX041haatTSHT/ZlNli6O2zagDuzIh50GYWPMvAh0Vql7KNjLXSp
 heUanyDeUCo8m4WQ9jg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290165

Hi Bartosz, Andrew,

On Wed, Apr 29, 2026 at 3:15=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Apr 29, 2026 at 10:53:13AM +0200, Bartosz Golaszewski wrote:
> > On Tue, Apr 28, 2026 at 4:23=E2=80=AFPM Loic Poulain
> > <loic.poulain@oss.qualcomm.com> wrote:
> > >
> > > Some devices store the Bluetooth BD address in non-volatile
> > > memory, which can be accessed through the NVMEM framework.
> > > Similar to Ethernet or WiFi MAC addresses, add support for
> > > reading the BD address from a 'local-bd-address' NVMEM cell.
> > >
> > > As with the device-tree provided BD address, add a quirk to
> > > indicate whether a device or platform should attempt to read
> > > the address from NVMEM when no valid in-chip address is present.
> > > Also add a quirk to indicate if the address is stored in
> > > big-endian byte order.
> > >
> > > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > ---
> >
> > Is there any reason why we can't extend the existing
> > of_get_mac_address() with another property name and use it here? It
> > already has support for mac addresses from nvmem.
>
> Does it even need to be a different property name? Is a bluetooth MAC
> address somehow different to an Ethernet MAC address? Isn't it just a
> EUI-48, independent of it being Ethernet, Bluetooth, wifi, fddi, token
> ring, homing pigeon?

In terms of naming, I followed the pattern of the existing DT
properties: for Ethernet/WiFi there is mac-address property, and for
Bluetooth a local-bd-address property. So it seems reasonable to reuse
the same naming for the NVMEM labelling. Also One thing to keep in
mind is that Bluetooth has historically handled addresses in
little-endian format, while Ethernet MAC addresses are typically
stored in big-endian format (as far as I know).

That said, a more generic EUI-48 identifier could also make sense if
we want to go in that direction, with expected property/nvmem-cell
name(s) as parameters?

Regards,
Loic
