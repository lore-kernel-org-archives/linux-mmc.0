Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DD941B35F
	for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2026 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777554810; cv=pass; b=AU1P/f7DQY6DB4t8oW13gMNuogCFrSfnWY5L49h54e1m5Th3tbh3YWNOYhxhNCOdgkoWfuVQ6G8GhyPEwq28QLBqmEVzvS7dyRIo+zoKUb2TRmON5xeln7nMcM+oxYj3Yzsih3TOKNfPo1BROGDqk7DC5UbdKJ+Xg73if83eCsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777554810; c=relaxed/simple;
	bh=uOBwc+Vl17MdUv77w9tKQsD4/qPdD6T614WQexS4A50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ny5mZHmrFv09t7UlGQVdIDz0m8my2SQrLvCe3SzKZdMMaJNPONM6H4DlvlZ7COjF8AyNsB32awv/2CLL/mL/Q/6jbqfk46MUtMmcqm5C5iVHDZBSNTedWJjeEpsx5PLVZIH7T2G/nOOKP8/sPtOkuWgLlZNeEmLetJ6k1PYzCQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wv4+57bH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FwcyrArf; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wv4+57bH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FwcyrArf"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UAN7311276563
	for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2026 13:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TouSduUFbw2zfEHACuqETKI0j08FgYQyPnYjBVsGXhs=; b=Wv4+57bHKS59t2pn
	l788D+Bh3SNVywmZLGOHfFpV5gix7UmN+Hbdo/rkaV907faoB34D6MoaRtws6I/F
	v30P+s1u0dEaN27jtCCPCVVP+r7L4EEy0FvbN7cRN35CSHU9XxqTb32ZATl5T86t
	UrmjKIcb1J8hNdRzni/k+tZLpRqGXhoJRr92bkpFOWRdgTmqxOYvkyjH1cO6GXnx
	iRe4KV/oP4i6FXY0oe260zuknkGUSwIURJlJbrNK3gxPYKc7iPfxfqQqhZFkUzNG
	0yB8b1v+rCFij5Gpwopcwf+oxHOaJvlbverrXg4+0dPQ0rN+GBwkFpQ3zascOloc
	t7rLFA==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dv2cq1jd5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2026 13:13:27 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7bd5c42192aso4964947b3.0
        for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2026 06:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777554807; cv=none;
        d=google.com; s=arc-20240605;
        b=iTPzIx0Vwrebq4lctLvND4tnHqgl4Hraa9+Dwc/Z9ak2BCHEzTGnMGTAgB/8zGQJnp
         SRXLU2Mxorm+XhBlu2KeXhEhzK2KgRWSBeIJQGNd9/FJBlXPhaXn9qRr1YUPivbd7MhY
         wRpIlsQ/7DS8QAvav7Xoj4SgGpMMALgBxyFPqImwg75ePrkuPdIQQiP1DnSFiXO6M2RS
         wuCnTRiVlbIB9bsiVRctO2vs2h3df7pNEDZ40tH1xOTsq6SaBOAnRXdGt4U+pZWgGLzE
         /zivpwp+MFV2CcjWnDuHfaDgr730mlcQxAXA2rRwQEuuDwr0GcQzf6fXX2FKWaZbjIne
         QRBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TouSduUFbw2zfEHACuqETKI0j08FgYQyPnYjBVsGXhs=;
        fh=1vCm0dW2QvwfqcalPWstSJ20Ka76sjq9ot61Xac84CE=;
        b=H8b2aNufLr/gu3DL+No/dRUdRrRCWdv7aFOh8LqWclFuY9/c7n5dvcrIf9ee4oa+GL
         fcPKrrYF6BxaY/cesqnsoTeFTzeVmY+dPyx5d//bBVdtQwTKOZ5AIwVSxf+aJnysrvDk
         M3QUd8VzBLBd5O9EtcbIA0H77ljko99i6bLU9A4xNUhgJsPpWC4QRHc+8WYGic9cWHKH
         iJ4QQLGHF7SPFjSv/7kLP1zOu/gLJC/Qrz/G2Apr9icMynmoddXDwenN8e9qysKdzY+F
         5mjDXQAFMyh1iIlba4HIwVsvYLcT1P7t8shSCpkd9Ea8o+TNhUm5gnqBTMSEcwvve0LT
         16WQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777554807; x=1778159607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TouSduUFbw2zfEHACuqETKI0j08FgYQyPnYjBVsGXhs=;
        b=FwcyrArfxVUEmUhB3u8Cd1zaLyprWFV/8QsAGr64S3i1OKV1YWT5ge6d65LkrBgQtj
         i7VvtXz4aCnaUNAKiQA9yIRIXzjfEDIZTvDcxoq+VaoSJx7Z0sngsyGGBstj8Zvk3Feh
         kPWTRxJ3uWdlF7uGPCQIIJ9C1SFAWMCMuvsid+MwkkbpU6eefPGaUbvLCRJjnsjgxu0x
         3lLI9mQiZy3HPWt8t6c/kcOEehIRou+EqkUsyxNXO1QEQ+p+8pLFv4Pyjak72Qz8q/d0
         VkOwBvmM06nD8NE6SpVnDntC1KIyiiFErPPHhQmuZfcxGiVvQiTSqraGm/aAFjVkqurK
         oXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777554807; x=1778159607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TouSduUFbw2zfEHACuqETKI0j08FgYQyPnYjBVsGXhs=;
        b=MAO5IJZTnhs0gVreCTRT/5FmI/EmEpMgt7YqU+rNUf2RGd6kQwSvI0f0kOTr6tfmu2
         em2/sETYJAfH8ETPhZVErDaVpFA9xYKyH76gS1GmuJVdocIJIg2dSnqVFGxy97ksx7TJ
         e5ikHQOf8wEtWwTy0jTjtJHrAi37+MVIiKfiHDg9uvB70fv9WROr3hv5NV2diPpPr4y0
         3v8s6/OaDhz/uh9Nud0b1YHaR0BI+kABYRuvnqLm/kqBCSTSpQfVkOBziWd3ORIBIUPj
         V05RWQFC9UfvGPnaWT/6ocIC3fGCwbIZdHDBDNvGQ2ZpOqkZBLyiuXyJbz00cJBdFOyl
         MV9Q==
X-Forwarded-Encrypted: i=1; AFNElJ/hwr7OW+/sQOLPr5eXNfPNpvVOAOjAN1JOzngbdPXm0Koh5GAbSohRV6gTnIH5/dN1xp2UIkPYwxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3jyWRiQvGmOzZ8Eg3myq6kgFfRXWMTs6jPLaJd9RUJQgtyflK
	J3uXN1uaIu3YD0+PTL6KNxxDVRcCYq1MQyAz7qovAmxguIkeWkXp5c7Ytmoz7dbSkIZf8l1REoA
	CEu4W8JaE5cncJFTBIsez0Z0oFIln1o97OjGQTeRfUJF65TnvhUiSG4Kj97KNPXMrajTKiyWIlh
	eq8VnFn7HM5pq20Ztlpze13oB7IciGweBkk6ge5g==
X-Gm-Gg: AeBDiesco2np6g/pK7PErLCbtehKbM+6I5ksdSjb/D4PyFrXK0uWE2ATAzGyLKh3toN
	4E4VJ9NmCmQaYb4V9wPaeTNlfZzXxnt1SXnKFvp1Juam14cQSxipdi5qyMSMZRLgsk93Wtbv1vl
	O5a81xNeO6q02LXBb9hhCnm07lAA5WKcAUq3sJFtuVAB3AgEcykTDzcjwxdg5DeAsg/QUoIl67k
	9M2M/2If1FTiRIm+K05XJccV09hErw1BKPWgNRkP9sqEAhOqjA=
X-Received: by 2002:a05:690e:4299:10b0:650:ece:89fd with SMTP id 956f58d0204a3-65c1b0a4185mr1181533d50.27.1777554806677;
        Thu, 30 Apr 2026 06:13:26 -0700 (PDT)
X-Received: by 2002:a05:690e:4299:10b0:650:ece:89fd with SMTP id
 956f58d0204a3-65c1b0a4185mr1181471d50.27.1777554806063; Thu, 30 Apr 2026
 06:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
 <20260428-block-as-nvmem-v1-1-6ad23e75190a@oss.qualcomm.com> <20260430-bird-of-sheer-ampleness-744e7f@quoll>
In-Reply-To: <20260430-bird-of-sheer-ampleness-744e7f@quoll>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 15:13:15 +0200
X-Gm-Features: AVHnY4I6bR6fdSxJnXBrJdTY4FKOp8Nu9g27U_d0aw_5w0XdML8zMEtBVrvqIXA
Message-ID: <CAFEp6-25Xad_LT8L-HPpOpXf7j1S=Vew=iSgxEmAHd_on+jkcA@mail.gmail.com>
Subject: Re: [PATCH 1/9] dt-bindings: mmc: Document support for nvmem-layout
To: Krzysztof Kozlowski <krzk@kernel.org>
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
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: FfppdP_tdvUt9QeqjRb1gXLSbUs1QQXE
X-Authority-Analysis: v=2.4 cv=aYRRWxot c=1 sm=1 tr=0 ts=69f35577 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=Q8QnmAOcOvJ-T5SqZIoA:9
 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDEzNSBTYWx0ZWRfX3HZMaSWd6Wkk
 GvCxdkqEfP/wREvDkGg7r10uS7O8vGBSb10S7xI1qXdbkFbzkCoaq9005k3ElxOIx+unW84IiE/
 I8fajdA796roFUiw8uUpW7MSU4TsBQ1ARnULkVOaYDnRVZwrZyeeflsvh6b5axscp8BR+J4lUxv
 fBeT26yOGgIO2qLlVjcQepiuaVjWYNTgsaev1Vqs2TCCxOFS9kKsDhcDrCmqZX1BIHmjfq7F0fC
 c+I3HbTb7RkW8uA01UEmaAcwexai4HsWtY7usfBH0h6b4szjD+J9qU2hMzk14KVYzaDGVS6BU3E
 A5lQjoQ1EBDevLGikMwRdMKF344Su5y8zLINZw2QyW09jDZ2Ob+ZktFT3hJIWRSWUILc/evEr75
 yYLb0aiJIiiKKloJExdJjZNhQUe7HCFG8l34++FbMLOC9ud0XZl5b5j3JFZlBuJbyxlZafdCdri
 jA0vtNPymwaMyvcWwGQ==
X-Proofpoint-ORIG-GUID: FfppdP_tdvUt9QeqjRb1gXLSbUs1QQXE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300135

Hi Krzysztof,

On Thu, Apr 30, 2026 at 11:59=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On Tue, Apr 28, 2026 at 04:23:06PM +0200, Loic Poulain wrote:
>
> > +                    compatible =3D "fixed-layout";
> > +
> > +                    #address-cells =3D <1>;
> > +                    #size-cells =3D <1>;
> > +
> > +                    mac-addr@4400 {
> > +                        reg =3D <0x4400 0x6>;
>
> This looks incomplete. Why isn't this mac-base type of entry? And how do
> you address it from NVMEM consumer?

This indeed falls under the fixed-cell/mac-base type, thanks for
pointing that out.
NVMEM consumers reference these entries using the nvmem-cells
property, via the corresponding label/phandle.

>
> > +                    };
> > +
> > +                    bd-addr@5400 {
> > +                        reg =3D <0x5400 0x6>;
> > +                    };
> > +                };
> > +            };
> >          };
> >      };
> >
> >
> > --
> > 2.34.1
> >
