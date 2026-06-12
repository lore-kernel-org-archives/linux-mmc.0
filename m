Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5724933AD8C
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781258880; cv=pass; b=M72DzE8r51unEXMMz0tYvG5wCF/ZRovVjMcQyhrXMsz5b+0QQoVOlkOm29D4JCgxddxg5FDVuT1uriS9LNRAy+ryOe5+y4QWIR5K04MjKgPyMR80J1WTQJzb8/ibTeBP2gJeLCNe2d5K/69MbdBF22Dx29RHuLGquTMnBBBcozU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781258880; c=relaxed/simple;
	bh=cHw3EhfIxeFggCpzm6CPqEcKG4hAZv5HGwcoAKqnwaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtfNAGOeoIbenBNLeTneOIRgqglMYZNDhVS+rQrnKerTberhikWXfcyRy4iBqYBrgQAwJHYsxbMmax0ATMyGF5bDR/gTkNgV3h5aWNlL49u2VdLajhgiZpoJReKY61H6b1+8T1eTbPjuslK3ft3j0MRJJMuDl9zguF1Bpbb4+7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IgFMujEY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kXPhUdcO; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IgFMujEY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kXPhUdcO"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C39Uwr2496522
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 10:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oInph8sZQ8Ma5X0t6VxxpBWehRn7abdgTsEpHVxvEAw=; b=IgFMujEYL7nMZWpd
	KLt4YyRgH50+k1NpU1LggBs55SiDEHrC2/PN+/ZHCO7nPlyoEzT+W2Q6BK8LBbmR
	yCFP6p6SX0zKBq5OLLfmZp1tpnnRXVuRO1slxq2z4FMsarT+TYAMGo2sUFtuDXpA
	drZVZb4R+8gJtgY6prfUwMyHi47ZNvlK15W3OkA7E9sECp+s0r8FBguCM6giwm7b
	cc3j4TnyGUf3YiDyV6hYMrMW5MolB0YP+vKbEQ05H/yq7f3IzUnkHzadp4N788ug
	Z32fgVOfw+kG9QHI1EZIkUCeJWo5e77pNo7NA0LP7ntclwZLFH32bN4HLE8YiNn+
	b5HnOg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er0x7k29r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 10:07:58 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-915ba226a9bso204932985a.2
        for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2026 03:07:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781258878; cv=none;
        d=google.com; s=arc-20240605;
        b=P+XxSFtReQwZ91R2SbpZPlio3MuAeJrWgroe6ilkrhrpFHQZgOpCO5lK4xriVdP0Ma
         sVjOoUWlqrZMRnd6lo7t6jBqsJ+NgUinZSScK7yWMMoB6tv3lyVmw4BY9fyNxg/5hNTF
         NI14/EU1u+jsB0zYhuEQfXh57JWum+ZlwAIpUFd0PpwIsc4jIDJWVN/JencSnb1I552l
         XlS1RqQ9L1TewvdRcpa1HKFN1jwDhjFxuTgmiUFp69BANEVeHYsWmGPALtn/oKBIHrIz
         dj9B/p0idCly2qsjj1UgmhlYiYd8eU7V28z49/VTFTAQ+mO5KIZU/Ve/cXoPn68lJ4qJ
         wdLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oInph8sZQ8Ma5X0t6VxxpBWehRn7abdgTsEpHVxvEAw=;
        fh=oGw3NPMnzOQ9irnw05aHP9q6sDhHd82yLT1lUJb8yps=;
        b=FG9C4bhmG5oTV/9EPhPr0F5MGYYHBbUJZN4gz3bLlbcSCOh6vjgqxPqsq5hoidAbvm
         h/9n6RfPFugd/3hey9vOnlTMNqe33nC7vA4r+kQGPA0krVBsUskiE3KjYF0ZWYa72FWg
         Q2NQR2lny4/l/p7Oe2F86q4b5btcNLrkJP2/0G2MdSgeftcf+J15JVH+wy6njCrknDgr
         xfHq9Nhbpy5L4lHLS61zh0gkQ2h7kanmrjBZOEmSIVs+Csd+NT07u9CrT/Czl10ifWZ9
         B4lbZHOOafDPa/4F8AtxnaVmL943NWOLidCp/CsJchGYmQsPSYB9O1NvouV6C/da6HWx
         5l4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781258878; x=1781863678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oInph8sZQ8Ma5X0t6VxxpBWehRn7abdgTsEpHVxvEAw=;
        b=kXPhUdcOBWDxWimhjIEAjo5Bb8Aa9SN2R6BHuC85I3hPCVc6WvtZptKsdNNUt0OoO/
         W1G9XG/Jpx84DaMvtqjvEE4Os5OUgsJh2cttpAxJrfCynPyO3Y9aez43Npbq+W13ra7p
         Bn62/llF4+aq/RIUXFY9vfSdry5oBwId/8X5tbqZS+vm3XQIWDi+SC7VmBV1EOLV1CAW
         BnwJM995wKDPUzZ3Etf6zKynUD4+kOzzkoHBgIya3Zmcr9pcHZ23ubXisexJPaVbiJ3L
         Z0b+C0Vg4WtRR+hPYSWhb/2606UTq4se0TvW6dsodQ6LtpxSAgScRTJ+0vRrmBSePe5V
         KKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781258878; x=1781863678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oInph8sZQ8Ma5X0t6VxxpBWehRn7abdgTsEpHVxvEAw=;
        b=Es6FdPBg8hmEZAeo0EntRjNN1z0Lu8M/JEGca1hyOJZW1Cu9nU3YKM3pZgtOPbAxp0
         VCSDwkGMOR37p1HtgZYheJrfEjEjjr9URW26OGuRLuhuelILCXlIAd2t67x87gS4195Q
         R3+M+CRKLClSqYTP/XBBTNSmcMSfk7117ajfoLFVPBPszGCK/zeTsXXOYuqR3qooPExX
         BGWj4d41/KcAj4kkEJzsMUAYRC96BUv0JNqIEadUg0DEFVi/PQAkbfg5visZ1YeWlcwJ
         pxZriRm54uFlQsl4ffzEUDu8UwAoEtB8wPvurMyQ75jUi7U7QAxOG3yE+VCcgXy7rmgP
         85Hw==
X-Forwarded-Encrypted: i=1; AFNElJ/Qelj6Yu+1WnbPbn8RXMbv/8lqx8hfBcK9rZPIdCqZfbWUrCLzZWm9lJpNyIO/lGbgcKZYdRr8vZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylUqMqxQWeg83wX0lE2ebhEkCjLz7s+PrMuJJRu7+EYpPn872A
	RDx2S7iN4WnoHDO/JGKbatWUK3t4pfegsHH0XbeTU7hf2FhcAwiuI0tbJLiPGzkrrUINCH0X+MD
	IVeIhQZX70ae1eLHJ+VB4N/1WlKIWRKmVmdwMk262Txetsv11PCC1dftG3N2KOjEyxf8sZVhCm9
	cFbQMVAvNgizWw1z766KDJxa1wS0p0M+Vw2WQBEUjDxPkMlw==
X-Gm-Gg: Acq92OHWsmb2CtdRkK8vZoFZNWFuE70AFWCUcD5pADOLT2HKZhtXrYToNInbO2FEsEX
	cle1tJ9tOK5NPPFTvvlhZcE3GEVsWuiE+oaqUpHqDCsVzY4+vbmX1eyjqgEkPjSMNgeecbpxwW2
	mcLN1TshkrXYjkh3oJtW5RJnMUqEl5Sb5TZsOs5tthsjtAui8O75SvGeNzjl/JWjfg2WS7w1R1T
	xGFpEHOU2UxNQtLBOdEcoqz7gdD7jdvZKyad9PQaa0L+OgJdkNX+46g6F0B5HACwcrINiL68FMT
	KNQgYuOkotDGyI+I8daJ
X-Received: by 2002:a05:620a:2714:b0:915:abc4:b56f with SMTP id af79cd13be357-9161bf76166mr272189785a.50.1781258877613;
        Fri, 12 Jun 2026 03:07:57 -0700 (PDT)
X-Received: by 2002:a05:620a:2948:b0:915:bac0:fc2d with SMTP id
 af79cd13be357-9161bc13cc7mr245131985a.7.1781258430139; Fri, 12 Jun 2026
 03:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
 <20260609-block-as-nvmem-v4-6-45712e6b22c6@oss.qualcomm.com> <sy2ofvdbcxspxtmfdavjvdz7oes5ieuep4znf4ayknmuwhrlgk@7lp3bkegaeif>
In-Reply-To: <sy2ofvdbcxspxtmfdavjvdz7oes5ieuep4znf4ayknmuwhrlgk@7lp3bkegaeif>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 12:00:19 +0200
X-Gm-Features: AVVi8CcCaLmOad_JBtnFjekoAUWHpnzgbbLT7l_V3SVx5j2zNp67A6Sx6we9iz0
Message-ID: <CAFEp6-3Z92KNVv6hbG_zrzan4+cP-TCkoc693orKwvQyvP_YHA@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] Bluetooth: hci_sync: Add NVMEM-backed BD address retrieval
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
        Saravana Kannan <saravanak@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: wLHp1K7WoXyF-ZRzJckkIA1jA1PJxc1B
X-Authority-Analysis: v=2.4 cv=c4abhx9l c=1 sm=1 tr=0 ts=6a2bda7e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=dtGr58D_ptlPQ1E9saEA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA5MSBTYWx0ZWRfX3EGA8YPvbiVc
 iad9GjMXdVkgwJt0r3NRXJQ1+QckUvl2t3BbE12HikZ0SxXi96O6ENNDS0udRIt5YPIOPhBC+Ok
 B+rbFFMhvkOgRcSQwfKLV3iaE3F72pDV9ABX5sOFr9GOaRVOCF3jpFfIvntyE76iweezRbikySr
 2to5IuXPNW/R7Cdh+yF2h0SHnpGhpVvdJLlAIBu1ZuNhKXgdW7pX/jvn4/AKc4S9OveM8JFaXoN
 CMPRrotrmi3izPoAmfuQh33Zq9yKTwEUuAkQoeQpsItkZ68FR1kWc0FzRS0GtHrmpGIDsn+hStC
 vPYsjdOj9M3uKaFVrssp2kCj4AiU0fkLdT/DJLnUoe6xMd6p/Oyl/K5pKg3YbrXwr/5WKZiVpnx
 P15blYbgjoht6RdvBNlZQE+P1XmHCc2YnEeKUYg3xgpEagmYSQQgnFzCuaChjnCPtiBXBxtYmfS
 ofmPMPO+QoNKUKsoEHw==
X-Proofpoint-ORIG-GUID: wLHp1K7WoXyF-ZRzJckkIA1jA1PJxc1B
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA5MSBTYWx0ZWRfX4+vmIuF51TSM
 Iw2MFuGzDZovRGFq0A9I/0h1dXFUpjwwlUS/sK6FyTPg9DpyVM97516bYgk3OvPXOm43U3i/BhI
 oCY61E6oV8gyIzXkxR8QGgNoYVV/1g0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120091

On Fri, Jun 12, 2026 at 11:11=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Tue, Jun 09, 2026 at 09:52:31AM +0200, Loic Poulain wrote:
> > Some devices store the Bluetooth BD address in non-volatile
> > memory, which can be accessed through the NVMEM framework.
> > Similar to Ethernet or WiFi MAC addresses, add support for
> > reading the BD address from a 'local-bd-address' NVMEM cell.
> >
> > As with the device-tree provided BD address, add a quirk to
> > indicate whether a device or platform should attempt to read
> > the address from NVMEM when no valid in-chip address is present.
> > Also add a quirk to indicate if the address is stored in
> > big-endian byte order.
> >
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  include/net/bluetooth/hci.h | 18 ++++++++++++++++++
> >  net/bluetooth/hci_sync.c    | 39 +++++++++++++++++++++++++++++++++++++=
+-
> >  2 files changed, 56 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 572b1c620c5d653a1fe10b26c1b0ba33e8f4968f..7686466d1109253b0d75ede=
b5f6a99fb98ce4cc6 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -164,6 +164,24 @@ enum {
> >        */
> >       HCI_QUIRK_BDADDR_PROPERTY_BROKEN,
> >
> > +     /* When this quirk is set, the public Bluetooth address
> > +      * initially reported by HCI Read BD Address command
> > +      * is considered invalid. The public BD Address can be
> > +      * retrieved via a 'local-bd-address' NVMEM cell.
>
> Why do we need a quirk here? Can't we always assume that if there is an
> NVMEM cell, it contains a correct address, even if HCI command returned
> a seemingly-sensible one?

The pattern follows HCI_QUIRK_USE_BDADDR_PROPERTY, the quirk indicates
that the address returned by the HCI Read BD Address command is
invalid and should be overridden using a fwnode property. Without this
quirk, even a valid fwnode-provided address is ignored. So here this
is primarily done to align with that established behavior, although
whether that design choice is ideal is a good question.

This also raises the question of why an explicit HCI_QUIRK_USE_* flag
is required to allow reading from NVMEM when the controller-provided
address is known to be invalid, rather than attempting to use any
available backend (fwnode-prop or NVMEM). but this remains
consistent with the behavior established by the fwnode-based quirk.

So, I think these aspects could be revisited in a Bluetooth follow-up
series if there is interest in reworking the overall addr fallback
design.

Regards,
Loic



>
> > +      *
> > +      * This quirk can be set before hci_register_dev is called or
> > +      * during the hdev->setup vendor callback.
> > +      */
> > +     HCI_QUIRK_USE_BDADDR_NVMEM,
> > +
> > +     /* When this quirk is set, the Bluetooth Device Address provided =
by
> > +      * the 'local-bd-address' NVMEM is stored in big-endian order.
> > +      *
> > +      * This quirk can be set before hci_register_dev is called or
> > +      * during the hdev->setup vendor callback.
> > +      */
> > +     HCI_QUIRK_BDADDR_NVMEM_BE,
>
> Also, is this necessary? Are the devices which store the address in the
> wrong format in the NVMEM?
>
> > +
> >       /* When this quirk is set, the duplicate filtering during
> >        * scanning is based on Bluetooth devices addresses. To allow
> >        * RSSI based updates, restart scanning if needed.
>
> --
> With best wishes
> Dmitry
