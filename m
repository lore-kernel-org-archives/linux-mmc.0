Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD7148C8AE
	for <linux-mmc@vger.kernel.org>; Wed,  1 Jul 2026 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782912985; cv=pass; b=ncHNjVqqdwjk4NnSu09E3LaI8b/wlBJRzEoZ0apH/SFG2P6OXetiYQ7m9/0AWccHbsAwRJqi+onNgleMzimIQiFpAvU7KgDn6v5AjEZjhnOPxckuwIXBrMnhclRNPaRLj3NZC2mZpmrpnJYAKYscYXxBoVn+w+pI4YUeCF1X5ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782912985; c=relaxed/simple;
	bh=N+n/R/mlFs2wkRiMkBtopMW3wGbtfZ47UIAhPinzCC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMx9Vyv0W36hzfjfHgyBH/y5tsJwcBlGvKzy8TA90TlXXKnCAtuqR+SrBXs6n4Fhid83J0AxkALF3oELgMF9qOmvU4cUT9itCWQ/gQpOS/8vDmqcV9yKgzSWOleFiOPm+KD2iugXepmtsvrIAK7dT9LNPqTyRQQVoFaWrsfBo24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D0TYYJLh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HRVwUj6T; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D0TYYJLh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HRVwUj6T"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A8iOJ721749
	for <linux-mmc@vger.kernel.org>; Wed, 1 Jul 2026 13:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ViDlik4RCW62sl/RLk3cKzJ5UtFbYqrOCQjRpG10ly0=; b=D0TYYJLhf1Zwu2jk
	spVTvuXD1DtrAeoeC2o9zHuxnGi5L2oNStqdVlMFzAka42qve3FCqsZ0imRiSjGS
	wY7ttgiTuQozDBsloMvMWMZ7rH/qOR9G1lDsmLiF7+3AQRgTZm29mCqmNwGw2zKN
	vUeqWlghwM2RkTREn3uRhASvg6bSZRMNTxyjChtRcJbcOyj43Bn47PrPRgooNtem
	izYRe/87MwRcAlgJr+M4KcqpvbGLoJprSrbUKhtWlVLLmIPX48qaTHAE596YlbJv
	Qs74Yv6HObEi99FocjmPI1rDGZPAdejjSZRzvLFUsQfNCiXq1CiD5iYcCYaKTrC8
	PAdhXw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jvwcam8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2026 13:36:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-915f6ff639aso126249985a.1
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jul 2026 06:36:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782912980; cv=none;
        d=google.com; s=arc-20260327;
        b=LY5UhSYQf3c5ZEF8mcU8MoBM0BqoeliDgoDSmNvW5a05xYlq3ClPcHcznSBjOEzczR
         xoI0eFZUd4pvkLb70l/u2qiCifc7spEYKETY8/XO9PCtM/AjVwEtpD4tr/cIq2GuGU2y
         kchsUQn7CyJ6QHceqOl+9FLM2tqNLDntTY1LtBlRlZp84CrXsQS+CMwwwf49WcVK/cIg
         u4j3qFVUZj/jaq7lPeqr/VsbKsSrh2dHuk5pXzYILGWIA8L6/1k/RpJX8l4l6D5NrOVT
         Qyc6Oy0yKx4GENMe8R/Qu50yZuSa5du2RLP2e4yO51Mc7CgZ1rlJBJXLEo+IOkELwjYT
         tt3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ViDlik4RCW62sl/RLk3cKzJ5UtFbYqrOCQjRpG10ly0=;
        fh=KY94m1bO227CUj3v229n23Enr/aznEYMUyp51BAJXjQ=;
        b=pBiRNuRlJu4SbE96mu1TviHgWvcsDQvi2WThonjij4Q28HCa4HR2veyXFb1jJK3jRJ
         UoNi7lUmWeoqO57Zujbg4Bxg9yqcEceV4U3oIZ+ojQuasfEREHHprhNfiXgAtKNpmcQE
         oeR38VDO/KsomaZ9rg3wzdGhewA0cFLsnyj66En/+J0Gpk25JOPE7uudJqdO88kLTNZ3
         UXMbGM+DBIa4KGmXTF3QQ3ad5XrECV8o90CjAEhB3e8FjospOJ8CmPP6yACNLq35NGOI
         ZVDA6+MpHNMhWEHYpK1LImsvlzv/jXddr9Jg1S79a6ht9wFXr5ho1yEVU5m97mLqbvHU
         XIew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782912980; x=1783517780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViDlik4RCW62sl/RLk3cKzJ5UtFbYqrOCQjRpG10ly0=;
        b=HRVwUj6T1WFzJgHooPCenbepuTuv74haEPIpemts0maavAE/jfQGfddDr1uo7W6DGh
         eZO0TVkEOlJ4qdgSnxOxgrjvn2LIEM80ctQtYFg3FgZSUteksjeaJszZZpr3Hm+uhe2X
         Ho2Lhbpx9CoYLh39bsXkraMGTKzjfyxPcI4HRAoQekY5WsYRCzzUd0JZ6RToG2p5aAPV
         NSri4rD9n3MlGC/Kb206UAvoXv4W7eOO6hqFO9Bn5/041IIrMop8QXhpZlPMbkgqMI57
         gSIoZ/rDnFVKSPMv5MA1Ugvi2JasMTR/clxSCdpuAoOF10eHQR/1H/15zr9xLsOTrMXQ
         K8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782912980; x=1783517780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ViDlik4RCW62sl/RLk3cKzJ5UtFbYqrOCQjRpG10ly0=;
        b=kLaouohTygq4aDpCYoDiU679gsTneoYLVTQxv971EGa7caHEoWTWAnEbbzeKg5jIj2
         dChut7jVGH8WTe9ocyJQsDYh4Gej00wHyFJGYRDXmu+L33HRrAm/0ZtY64ZZBHx4DyjO
         fjWL9BVxvk7Lx1ShNCMXuRlL7sRam4881VZGvoZGUyHZO0FVsdSVxVYSzKSF5Iu6uuE/
         ob4oi5IJFccjrZ6gGEQ6icyT0uaOjUh0NJQ1Ij8Qn+XNFHMoXnVSUkUMs+xOPpBLU2LJ
         rrdQpkBvHPglRGfPINF5sFVj+1rD1DOtLQV3ey0kQWLeNjOooyga5bpP+vNnl1vE+rj8
         qE4Q==
X-Forwarded-Encrypted: i=1; AFNElJ9R5pWoYAV+SqRJEOOS5IxQg/LjNnmlmn7blPndVDCUhAUig7CBLv+iIqcxsPp7wEIJVaQThhC9Wng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBsxmAVKPjelpwggEn/EDFbozizo8Gc1QfXbhJ7NCEoafk4DO/
	e8O7VkwyrTPUU+s2urN2XYDcJc6BFrxQg+fQb1KRDI9UKVlxVSc3wzZhrFD8KC9PTsh/UiMHYbU
	qc9cBUx6sMASOrmmmC+pnDrk+GnbLyPVD9oVUp5o5QCATu41eQMgWrhna1sYGogs9NsJSfrgZX3
	0GJNZtFX2AWK8lMsq7wJ82HXuchaWNTlcIDmjcYg==
X-Gm-Gg: AfdE7clPVEDkTw6tp2tibpKsajApx3IgHy9vKFIGLVaTEGgU3ocpMEkjEbHf3HQY7ln
	/uTq2nIMc0tqlUJM0zj8bfM/qzi01IwVehOJ42GxIRvUsxCKlih/PuHxKVnoJGM5QxSJaHRbrxb
	T+W0aSMlwXPmJEXvji3vRiTZAG+BOyvkTLxNdQryLPenqGaKk74fBaB69+hN8YFLoeqxKXDEzjC
	rIbLjzwCCEKDFAzfwK7DUByJppqWfD/p/tvnzSA5hDxcMLLJeDK7qfKl2DWb16iA2IFOBbKJj76
	3T0YM01QjQ==
X-Received: by 2002:a05:620a:28d3:b0:92b:6805:91be with SMTP id af79cd13be357-92e7853d109mr199454485a.70.1782912946580;
        Wed, 01 Jul 2026 06:35:46 -0700 (PDT)
X-Received: by 2002:a05:620a:28d3:b0:92b:6805:91be with SMTP id
 af79cd13be357-92e7853d109mr199161785a.70.1782912918609; Wed, 01 Jul 2026
 06:35:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
 <20260629-block-as-nvmem-v6-1-f02513dcd46d@oss.qualcomm.com>
 <20260630180219.GA4139943-robh@kernel.org> <CAFEp6-163adAq8-H_pCzGnq+Fo4jpyKGs6Jv25j3fSpZg3COjQ@mail.gmail.com>
 <CAL_JsqKFjk-mdaAAOzNB6rFiJbw5gd4eDpRBLQL-4q+uJKnp3g@mail.gmail.com>
In-Reply-To: <CAL_JsqKFjk-mdaAAOzNB6rFiJbw5gd4eDpRBLQL-4q+uJKnp3g@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 15:35:07 +0200
X-Gm-Features: AVVi8CfNT2AJJTgPBXfFVJQmZjW_-a9Isbc3rycVEtJcwbZkpqGBU1gJZohgDaU
Message-ID: <CAFEp6-20FXTOKQ6EPuR8OUDkqE4JXcUbXaFy7kRFt4fzszPQCA@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] block: partitions: of: Skip child nodes without
 reg property
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: jJnGtyYPdB4woSLohcB3ME2Nrk25HICo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE0MiBTYWx0ZWRfXzKRFrVTbnqDI
 DtFxfB6+HcXEZ3B6kZBMEn3am0RwJQdvZnGm/dmeQ98YhH0XHO3duhnp+2vf482G5IyunAtIk6i
 wN9epHBUx0H58Cs/eZ5aa6VNaxLgvJk=
X-Authority-Analysis: v=2.4 cv=JKgLdcKb c=1 sm=1 tr=0 ts=6a4517d4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=bM2Xkg4KEcMkddnjsM8A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: jJnGtyYPdB4woSLohcB3ME2Nrk25HICo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE0MiBTYWx0ZWRfX+7mvBFoRIHMD
 1JjEj/l84Y3YGNuhZQm/6CN/r/zZMeY8pdxw0IKwOQvnuuZstkR03mYXAcoDZBDYLQ4zOgw7SXz
 eCd3c7iMq7aB+RrbLY+Aj9sROH12u8gor86IghRVlc/jUDOgbmXGmCK3OIEckeDbb6NXWEzESp3
 1JuiDP5R2kqDXY5OL6S4JTHa9ow3A4yNgIFw/UI1BLgiB5udl01ROey+kfHm8rGtxLJJMfwZ4mx
 XUWucj6n0lz6xtVTbdMvhh8zFQH+MTyxhBnzcVle27tsR2pX9WcIbOwx6TVsWX70Su7SlidiHR0
 WnvG9BukIrq4cyvBcRvRWnmQVH6loEGxfOzbd7glzxVgHiPPOp+Y14lY79a5u2zz4hxoDwXn1DM
 eMDpVyxdVOO6c/0vaoz/zjWtlVFx1MBoWYKfFx+mMaNaTGFSzUyUKDEB4Mg6M2yzFna6XpaRZoN
 x4Z41mrlh4TZGiH+IDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010142

On Tue, Jun 30, 2026 at 11:46=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Tue, Jun 30, 2026 at 2:59=E2=80=AFPM Loic Poulain
> <loic.poulain@oss.qualcomm.com> wrote:
> >
> > Hi Rob,
> >
> > On Tue, Jun 30, 2026 at 8:02=E2=80=AFPM Rob Herring <robh@kernel.org> w=
rote:
> > >
> > > On Mon, Jun 29, 2026 at 10:55:20AM +0200, Loic Poulain wrote:
> > > > Child nodes of a fixed-partitions node are not necessarily partitio=
n
> > > > entries, for example an nvmem-layout node has no reg property. The
> > > > current code passes a NULL reg pointer and uninitialized len to the
> > > > length check, which can result in a kernel panic or silent failure =
to
> > > > register any partitions.
> > >
> > > That does not sound right to me. A fixed-partitions node should only =
be
> > > defining partitions with address ranges. I would expect a partition n=
ode
> > > could be nvmem-layout, but not the whole address range. If you wanted
> > > the latter, then just do:
> > >
> > > partitions {
> > >   ...
> > > };
> > >
> > > nvmem-layout {
> > >   ...
> > > };
> >
> > In our case, the nvmem-layout needs to be associated with a specific
> > eMMC hardware partition, nvmem cells can be a simple sub-range within
> > the global eMMC, each hardware partition (boot0, boot1, user...)
> > having its own address spaces.
> >
> > That said, your point about not abusing fixed-partitions is valid. I
> > initially dropped the compatible =3D "fixed-partitions" from the
> > partitions-boot1 node when it only carries an nvmem-layout and no
> > actual partition entries, making it a plain named container node. But
> > it's a bit fragile if we want to support both nvmem-layout and
> > fixed-partitions.
> >
> > Regarding your expectation of a partition node being a nvmem-layout,
> > do you mean that the nvmem-layout should live under a fixed-partitions
> > node? Something along these lines:
> >
> > partitions-boot1 {
> >       compatible =3D "fixed-partitions";
> >       #address-cells =3D <1>;
> >       #size-cells =3D <1>;
> >
> >       nvmem@4400 {
>
> partition@4400
>
> >           reg =3D <0x4400 0x1000>;
> >
> >           nvmem-layout {
> >               compatible =3D "fixed-layout";
> >               #address-cells =3D <1>;
> >               #size-cells =3D <1>;
> >
> >               wifi_mac_addr: mac-addr@0 {
> >                   compatible =3D "mac-base";
> >                   reg =3D <0x0 0x6>;
> >                   #nvmem-cell-cells =3D <1>;
> >               };
> >       [...]
>
> Either this or replacing "fixed-partitions" with "fixed-layout" if you
> want to make the whole boot1 partition nvmem-layout looks like the
> right way to me.

Well, now I think both approaches make sense. We should support a
fixed-layout on the entire hw-part/block, while also allowing it
within individual logical partitions.
Support for the former would only require a small rework/addition in
this series (to have the hw boot partition a fixed-layout) . The
latter could come in a follow-up series, as it would require some
additional fwnode logic.

>
> > That makes some sense, this would require extra work for the
> > emmc/block layer to also associate fwnodes with logical partitions,
> > not just the whole disk/hw (hw part), Is that the direction you'd like
> > us to go?
>
> Yes.
>
> > Also, Note that regardless of which approach we settle on, this
> > specific fix/patch remains necessary to validate the partition node
> > and prevent NULL-deref.
>
> Fair enough, though the reasoning for it would be different and
> perhaps should give a warning.

Sure.

Thanks,
Loic
