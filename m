Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D3247ECEC
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789399205; cv=pass; b=kN5y2pUX4s0MeaGWM9gwPCTX2sF1xCNnQ9koyA4s0DEO47Xi9/XXSznRS9S2rxn3h4eRIYWyxY63CW6Wq9PyGkJCq44GO2H3bkesWtyUJ4r4SbPqbSUUNDhtMW0ZuSm79p0BZ0u8nlnvWcp8OPNabhgMi/VQVhyTNxyafWJlRPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789399205; c=relaxed/simple;
	bh=+5VTaMWLjqXlIi1YIqovBiY4bjSRngf/DS/v7Ak9tb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nn5c+y2noALLSN6XCBVkvcjEBD7Biqll28NL0RKt1yTD8/Zsxs//DqMDBva429aq7XLe4k/iJoykurV6+8sGFtns9vLfa9fucTglUKuFk9nugxV37QHbUWwrWTXxIpbT27z9+altA98jTk1P6gxZv0FxtXwKo7pawtryCLDxoQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hr9GYHZs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c48AIIrz; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hr9GYHZs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c48AIIrz"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED0VLD3588164
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 15:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EvWNxVuN8Vp90PBdaLvbyZcSDFXZr4EHf8QgZYgvK7k=; b=Hr9GYHZsPjfqqbdE
	yRtC2M+BmgtCDMci/gUxstAyQaIrozfMIeTMHjKKKlJLFIEiFxUemtIdMHyBE/o9
	RgnqAAlmEh/OyqIgYjaXBGg0LS99DKeWkh9EKTlYEBdTMTpeKov4mBNg4nChA+W0
	L9Q56XOJPT/rRo5+0yBxIaxv+K66Us69tONnUy27Tpl33JyA8ZlPCD5LoVNLmWGe
	Hi8XRgGw09b/5kNsrsdLOZkuYcmZN/4hRYd1pK7vHaASKmp5H5CVQIfeE6w7n4wn
	Eo6NpZl/cUa8kmUyDANtYztW8ifbMHg0aMV3oTAX8ziPsP54f5Q/B9i5NoM4XROs
	wmL5bQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gperg9aac-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 15:20:03 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso4644970a12.1
        for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2026 08:20:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789399202; cv=none;
        d=google.com; s=arc-20260327;
        b=RS1WMJs/OUQgh7g8V+l0afpdXIfDhiJlMpEyp22N5KvTLEF9EPK/ekzx+kiBNrdgQR
         2h4Q2PfdTcLcqvtsvBEgVzyhsIap0nR52JdKi3iFldCxDzqnYMEtLvptgFikUlXHo3nW
         sL3VY4oyuYjN8GaYtHxj9CAbI64Vwr+o9PhziPzxcQNsXkPRa+iuFUR1vBBRt+A8MgG8
         3Sb2S/Qr5FKh7/Xr1tf3zkTMjV7wWquTH4xLNOFAegG72JBLbM+xnDEtwGDlVAYUUuSx
         8RNRwXpPDGMxBieazmaUKHWt9KiFMEkuM3AXr+KIfKgay6av1PIbwqxz27+AOWA1RdqE
         8+lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EvWNxVuN8Vp90PBdaLvbyZcSDFXZr4EHf8QgZYgvK7k=;
        fh=I/a4ui5OVcx39OzX66yLoaZfd3l18NQv5mTFMxYa8Kc=;
        b=e3OXV+Sff1mKGufj3v1v+8iKjJcXs7li6HU+g7keFZOwvlnf5B6b8Bu0mVNVFYQF4G
         RPlOybrX3KilQU4G7f46xIeM0wIUdb+jMqshw5DLhhes/az3mYidjbddud8QvvI+O2UI
         iWqb/69j92Gc8VKku2goBpU32uUiGvbJxLIfv62gF1MvzdTPxzGn7JbhjK/Iq1GJowfP
         QTgDpWMx2dWe//AB+eqRtXe9BjileztoiTsaI7Cd75OKJCOADQPhISKyxOPH6v/zBJft
         EKmj9vRxXNghn1K4xs+jD9wi8CbaFM5a9sOv178idGUJyai5PdKDAKsWr+WAB2yy3NeZ
         jmWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789399202; x=1790004002; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EvWNxVuN8Vp90PBdaLvbyZcSDFXZr4EHf8QgZYgvK7k=;
        b=c48AIIrz3UsRlJ5kH9PgmXxx7Fyy4sixXlWjGMDLB5WaVIE9NVUYt5X7IkJ8rJjMUn
         Ebs4rFq5bVOxcx9CrMy+UAMv+eoiCvn3hzijPvQGXrhsppeMyVU7u7RdDFvm88zJHT3J
         AqZaDZtlYLzj9CBwsd4f9n/kD41pyPDv7UNh/gIKlSxwFqAZrRHRT0/MyEzvKlljCxCE
         tWKEacVNE0aEJeE7vChHdBYfgShBHbAuH0i1/0d6tLlzu2X/8ODL1N5ioCKYdWSje4fE
         ElQC1ULnhtsqqZVQLgX6hnzsvCNoCOpGU0YbGOeU3LmsLJLSM25F0Eoq0x9HraqQGw9K
         15Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789399202; x=1790004002;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EvWNxVuN8Vp90PBdaLvbyZcSDFXZr4EHf8QgZYgvK7k=;
        b=ErBlanbswawwd5oCufWqVpuAKDc09SVt36dJw8X365gUADl8fxUhwFAa7HCOWf24Td
         whokxsf1O8wzTF/pk6XJVIq+/UYLax0obtHs94lN9AZGZ75g6sTFJEQq5MJX/lCULy6k
         6FT/UwLF0GWmdVPA7gDq0Nm/QOfCaURv5lOj0tXdzncfVWF7HR5f12pidRFaKCJo0fAC
         oLbSUlGlTKDen5S96srtLBvBdG7lyzaNiQzCnKv8XGSJTN4ogU6gnm2AzHKalsLuP/Nu
         R9fdBqHUhhFQcb9vlkgHhCV5Wz9tW3vV7+Hn+BOJ7mP2iOKdlinylqSFxAx6r1TmFCw3
         x0RA==
X-Gm-Message-State: AFuF++lgWwQg/4LHh/9hVvm0vm7GdxWlN3Qx2sELl0qN2/ULnbGzuWRy
	LvyMR9a59iFxxFTlorTeZQYsPNb4yFtmRil/1olNmfv6FN6OIdCrcO35vQSKxzQrWoDHLv9lsSt
	Kv7qpV+rL2NvR0wqSe1i/nnIhzKyk+FpFDfdtI/q4jItfT1hqChnsXuyfW8s3yHQVMnoYGcFu87
	d+Ba2QbJG4qnQsiqvXnO9GiP8qt0XHGNinVleIHQ==
X-Gm-Gg: AYBFou19M63CZIu2IjN6rbhC7OHu3zyWHy4MO8n2sp24JvZMQnWaHjXLmnFXOscEwVp
	POxBbNvM814CiCBBoDiR5mbFgYi+zdZRc7yfFsm+ycD4lK9EEs9QhdX6yKFpP2hJGAope720zq0
	xbphYNwXls64cYsljvq/P+dVQBNkHBBzCt4IVLNRepvg/0uEjcW4tkCUOddw==
X-Received: by 2002:a05:6a20:43ac:b0:3d3:b02a:7252 with SMTP id adf61e73a8af0-3db4076d90emr6912324637.28.1789399202265;
        Mon, 14 Sep 2026 08:20:02 -0700 (PDT)
X-Received: by 2002:a05:6a20:43ac:b0:3d3:b02a:7252 with SMTP id
 adf61e73a8af0-3db4076d90emr6912264637.28.1789399201887; Mon, 14 Sep 2026
 08:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914111642.169707-1-ulf.hansson@oss.qualcomm.com> <94445074-7cac-45ea-a051-8f521e4f6b07@app.fastmail.com>
In-Reply-To: <94445074-7cac-45ea-a051-8f521e4f6b07@app.fastmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 17:19:50 +0200
X-Gm-Features: AcwNN1VRqERvG6R7p5qKeRX-V7ae1CReXW6lsYdfoZlGnjZHdfryRk19d5OIuX8
Message-ID: <CAPx+jO920KXdEbbZKKLSSr-L4cNopj77EN+oyKFY6FfL7tX8aA@mail.gmail.com>
Subject: Re: [PATCH] mmc: vub300: Remove the driver for the obsolete HW
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulfh@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=QK/91QLL c=1 sm=1 tr=0 ts=6aa810a3 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
 a=0glPbglwHS9rkVpOk-MA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: y5D_nWilGTxnKm7xP8IIN40Gkek5AZCQ
X-Proofpoint-ORIG-GUID: y5D_nWilGTxnKm7xP8IIN40Gkek5AZCQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIyMCBTYWx0ZWRfX3HR6QNzZphIW
 hp7cqTtq4tXWqvw4NUvAZMPcXX0XFtr4C8zQVi/fQnCQeRX+KDVqRi6FeHI/E+4hxMLHN1jSMmA
 FS2watVckAyWTWjh2tAnBB0mbGpUXvN2dglnCS6pZ32k1f/DbGQmAO+iCtJd4KcozaOhTIU4KvR
 3VTLZ3qUGxyTeZKNZjoTQryqgNbJCD97rY8A2DkmXvAfyVsDgykeGaq12HjIbia7hzhK9OYpPEj
 DEXC7WddisY4RX6aX+UckVdZa3DUqA7Jc4f8Qu0hgKDBj06+6iZcZ0ORSASfUGJ6fGkp4QnnN1O
 1IvOpt74faB2uBNl0tmB92t6j9KUf8kS0qnRT6eNbpORv1a9XvnhLr2pQoIDQl6K9Xl9SE3352x
 KtiBwUg7DA0+X6vuJaEXOrcufNTUxbK6HVqYIZzIhO/78QBYk8xiQorNVl1k8cLAxLPFxAUOYiD
 BYWtf3t8RHP/vlWV9og==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIyMCBTYWx0ZWRfX+Svxeg9OM9TI
 tgzuOrT6QPcCYOzqSQ3Nr3YBG0s7Z1yndomlOSHWg4zqUxcbLkbfchZKiwTIePGr/ydFylNs7zX
 E8Mz0r2oGlHoNvggNBOWJh8vFH+AH1k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140220

On Mon, Sep 14, 2026 at 2:31=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Mon, Sep 14, 2026, at 13:16, Ulf Hansson wrote:
> > From: Ulf Hansson <ulfh@kernel.org>
> >
> > The Hw is obsolete since many years and its corresponding driver has no=
t
> > been actively maintained for a very long time.
> >
> > In this regards we are lately receiving a lot of AI generated bug fixes=
 as
> > the driver is a real mess. Rather than continue this path, with small f=
ixes
> > instead of making a proper rework of the driver, let's just remove the
> > driver altogether.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Johan Hovold <johan@kernel.org>
> > Signed-off-by: Ulf Hansson <ulfh@kernel.org>
>
> I have no objections to removing the driver, but I think its worth
> pointing out the actual year it was written (2010) to put into
> perspective how young or old it is. Since this is a USB device,
> there are likely still many of these in use on newer machines,
> but they are also trivially replaceable.

Thanks for confirming, I will add a line about this when applying! I
guess I can take your response as an ack, if not please let me know.

I have obviously done some research myself and the short story is that
the elandigitalsystem went out just a couple of years after this.

The driver itself has been dead from a maintenance point of view,
which in principle happened just after the first initial commit in
2011.

>
> I checked my series of driver removals to see if there are any
> other mmc drivers that I already have patches for, but there are
> none right now. There are two drivers that are used on relatively
> old PC laptop: wbsd.c relies on ISA/LPC DMA, which become
> unavailabl  on PCIe chipsets 20 years ago, while sdricoh_cs.c
> relied on a PCMCIA or Cardbus slot that was phased out around
> the same time when laptops started using Expresscard instead.

Arnd, thanks for the update!

Kind regards
Uffe
