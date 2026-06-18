Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926A03DD854
	for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795716; cv=pass; b=DSc5vEdMW/1GWLCMdXMtK75kNgyPg4YKJ+7c91V9C1NrUlLBsBERP3gSom5P+uGDbqlDhnGxdZ2UBFIb5WHNTA/i0Vy4Gc4RU7d3Ln8EBO5QxOPS3DSkBuveA3kyT522ouaNOgm7zcz4KqMrWJnhU211YjOAEiVlyD3Ik0C2Gks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795716; c=relaxed/simple;
	bh=OfQJjT9mcDuwucAC2FRRfrK4qbXUKj7zz6ijBXA2qd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3p0B97RLTTV1YmJhbZKXEDtCUvd8cgClVwx4sbPL8JOxgy7RafIZrdRE6QDb9BADcBSO4DwvmyFAeEPGAWDbpfUVzvIlzZl+dHJdJJvIZCHmmOOMg7cMULlMUR/j5/AztKcAg1DITuMBzZ1EIlgRTg6CLy9EyX+pg32sK2SECs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oyR10Vud; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mp6xM7vK; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oyR10Vud";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mp6xM7vK"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IFE0nx1559306
	for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 15:15:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S+KNlYIZo/dliTPA4hgLKiv+42uY0+PvGl8oACiJs4g=; b=oyR10VudCcDAEPTy
	p6EzuC0vxqZT625KS2fwi3MVYymn2TRt4jIXRXYg8k717X1nCcI7RNYBMweXRt7m
	JcLAMpNpAEkelVpLjvu/4aIzOAHEgp+nuHx6M+OzsLjH30+1RApJmAqPzkbAvZnr
	UZHqxf1UnPJFmMncMOxmfB3BF6Qu1p2E3LiaAJcf+5rQH0K1uIXclw8wAZlqKjk5
	Ejj6PIRAFrZkCJbdeHA9dTuPNU5RhXsgUP7WWG/2spycyPQ7jq9gUzu4m5mU6m+q
	RaYDoNgO+HQvftXjEneijOqV5PiVQKLC3AYnU0nrV7Y6CTc7mqANBRPcXpVp6z9t
	7IPQPw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evdn41afy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 15:15:13 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-963b2863d62so319635241.0
        for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2026 08:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781795713; cv=none;
        d=google.com; s=arc-20240605;
        b=HiR9tzixGZRezzOfBYuWyE6KW8GjKBU2g0d7bhB6bgTDj0CGdQut9BRy99B5KGz33G
         HmGocjDcGhxxI8EPYmKV/WTrkaSYEgfvusljeXmqppshovFlVrDeOHAXGqlR4HHbtKjj
         EB2nc5doWnSzRoXpCqCp07aknY7+xfWibGuNPz1fb9+yJpDWMWmeQ4gUQq3G8vIuh8U+
         35zV+c4kRndTRiXoeQ1YawC0FsSYHe4MnqbfNFO2KhQeV2WjKSDTB95kr7Avf40TVs+f
         Rnw4iKoCgxoRh3OyF0ByHPySBQEGJjU+ziD8e0EH4Mvx2dVbwhyNFmO6ubaxIGf2+qeS
         j36g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S+KNlYIZo/dliTPA4hgLKiv+42uY0+PvGl8oACiJs4g=;
        fh=dTFhWS+OxFZpofxkUbYeSOFPWMh28+PTtgAxloVYLgc=;
        b=Tshv4Z9BE5biTK7jJ4LMWzBCJ98Qp6vcH63TcFm4ZmUR+ghaoE7jdzoAJyVwGMvCnM
         DvR1ugxq2UR39xbEz7K9ZxhSSeeHgNpnf5LQprnBGnPRTKDOfy0lOS0Od5c7HOh69YTz
         6ZkQfrQBQ5RGI6QV+fzaXRnPTkXU1WdOYsZ2YuOZlEJwjG+0Kz2iouG+JLF3vOw1jW5f
         fAKXJLTb59kgTp3iCZQgndjODeuKQsU3soERW89jpQUhQ3cUsJ3a6NWApyAf9+0swbyx
         tvzuAtKNecSSMCSohak3h/cnUukyxpkpnurro/bXeomzGnZO4zz7SHgwLeYNAaEf/hLq
         ZDhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781795713; x=1782400513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+KNlYIZo/dliTPA4hgLKiv+42uY0+PvGl8oACiJs4g=;
        b=Mp6xM7vK/UaKd9zkV2zcuujWTXak7sM1Qx5AWyDjPDsdFtNAcT9XLaaWlBgm5bKKnS
         /aqm8TiajACFwL2XO90Krx589IFHW9mDj6Agopq77H6oz5+kYx0EudapCsfb0CduE7mr
         48/AjKBjcijKEvqXA1dTW73nx80uq/J9hG52QsT7eLL6wW4ZbuC6XnYcGDD+hElHAN+a
         naHIEp/j1ifXFVLEkkY2pAe/+WiGGiWSHibDivJ4eXTUVhC/URKM6IvFRHFMVeCh90Cx
         rrxrLqj1Rdja0/4M10d/H9UEggj46LSVGUUhjOUWorEveVuo+bNe8ZTQHvuE61uZCYCW
         Phbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781795713; x=1782400513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S+KNlYIZo/dliTPA4hgLKiv+42uY0+PvGl8oACiJs4g=;
        b=OqhorSe/EWzLLhcgbYlQwhxNrPdIQud9UmXrxWWjCRoeaKsi6Ar8CpHuL2JenMFu1h
         O4Mx6jgAsKO2+VdSVid3IHiKYX7Ai70NKbaeHXa49GjsqtlDzJGOHybqZN0B1xah6wjH
         4TQp1qHf70fLxyad8H26RL2txrVqzTqKXRmm/Fncl8dXm3EfCr3HTXmM2qaDCY28ObQa
         Jrrn/yFIC/EnUfOHxY0jIOynOPtH46KkrJs5sgXmY/gRgrDPNoBzpJWjvC9BVx3LGuqX
         aJ5Pj5boHzYf0U5EuydMv8iwqJJYKDsUzC30J4j3TgmHagyAtMgW9twhDZRXCHClGGeh
         GLWA==
X-Forwarded-Encrypted: i=1; AFNElJ9EHKgu9UQXGOLsc+YUtPzdNfX2LsCZgV+fpjgvFze3RL2ZB2JTgDfjTqMdzppqgoHDllHBBongw00=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBTYsZqoZCgIhArqPR9UmO9JHDZk149kIOYEyuBZ7ZTJmz/NfT
	XSCDpVJ6aVUH75zWOS5meQHVSDVf/KQ4Wdx+Xv6Qz+BIY3VC422iJABC+orQrgKDqjTWNV5GYRf
	BcYFOh//CesIJKb8Wy7DwWwFIxwE/dc2iKdwzSBinSjxZWBlg4oSolxLHFcMLatapBpE08KDWEq
	A7rXb5ZsOtoMcFAwRqwuFPf1vkaYNzCkdFPfOKsg==
X-Gm-Gg: AfdE7cn7Pv36LtwAiTnqkcKfqomNZp7IjtNqPrI0v5VEfLASqxbYGRJCfMQPCwPf80j
	nu3WWPQN700F+5ZMaDIOwP7ZRWKUclQJUoK3kfK0cfHME72U6akVZsDUG3FXimZgOoL3KaYzTcW
	PXNAYPofg9WUnMMC2d4qm+2lI1pVA527WwVAqAVspdJQDBlFfIfWJv5mxq4eBJOAZ+Y4B/
X-Received: by 2002:a05:6102:160d:b0:726:ec78:9513 with SMTP id ada2fe7eead31-72a0188306dmr60555137.4.1781795712500;
        Thu, 18 Jun 2026 08:15:12 -0700 (PDT)
X-Received: by 2002:a05:6102:160d:b0:726:ec78:9513 with SMTP id
 ada2fe7eead31-72a0188306dmr60434137.4.1781795711883; Thu, 18 Jun 2026
 08:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413180551.3683969-1-florian.fainelli@broadcom.com>
 <CAPDyKFooAH=Z2BEHq08Fu03uidgjuaDbwM-Y3Y3Xa8STV+ODzg@mail.gmail.com>
 <1d583be4-b1cd-4226-bdbe-5ebd275de9c2@broadcom.com> <CAPDyKFopEbm6z2-AVmPQr5csofNew2nWpzGyTdBK24w+5YD-PQ@mail.gmail.com>
 <915473f9-64bc-4630-9c82-41fcf4401042@broadcom.com> <CAPx+jO-qQ25-BDnFmCDf+WYpKPHATJjSDMEz=8Wh7pAFdv0v5A@mail.gmail.com>
 <CAKekbescGNw_HjyAOizDz0ZTBTrOCV6=DC_kyQD2vd917HR=SQ@mail.gmail.com>
 <CAPx+jO9-WOUib2Px9e7UZ8urKEhi=OXPurvMZ-fZjYsJSoRw-g@mail.gmail.com> <487cf4a4-218c-4a6c-8eed-a4ab170f01c6@broadcom.com>
In-Reply-To: <487cf4a4-218c-4a6c-8eed-a4ab170f01c6@broadcom.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 17:14:57 +0200
X-Gm-Features: AVVi8CePJJLrnOqQUb5vqLPmlkhge41kAdJKCiiFVl5nF7phUp-xC9IcVMl4tGU
Message-ID: <CAPx+jO-RJYCwKLLYCPZw8nR0VLVJ+UXPotXwXXRHGvar04QyDg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Kioxia 016G01 does not enter boot mode after SLEEP
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Kamal Dasu <kamal.dasu@broadcom.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Avri Altman <avri.altman@sandisk.com>,
        Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
        Erick Shepherd <erick.shepherd@ni.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE0MSBTYWx0ZWRfX6HQbF1a6Q81L
 xjIP+ef5zNMs8O++Pa+PUlZIY9XluwjCBhh73ItQPJLi4omsh7GC2QkPhRJ1iWohQ+iZPMc91cO
 1KDrWUUcxnNhCdVXtOGHzMtZjt+GJLIwEOkYcJR/xtEAxJv6jx3JIA9aCZ7I5JQAW1c+UMsviz2
 djcuuhFG2I71d1NUVSNrCsDEiXsV2oFTVsz7CUT98nysTarsIvONpK66MZUqfc1KlyDFnl1qZlf
 O/4c5Y4yQDPvPhUGrn62jtAsi4hg0fvMPMWtOxJAWw3bWCmS4Uf+WmwpJ+TslS5ULFaY1dwFnA1
 p1sIiPfctvKS8OFvi9YiU0j30cRvz31rzYxO6+RQ09pmheRcuJvWME/zKxllnzy+MxkYrgfOwAQ
 mKauaTT8AL5gfV30S0HJOMPdgouze/AFd2PBBEQu5n0/TZiYlq/6BIuwPFaR3Rjja+DQjc0Jgxg
 HQSbDtvPSWAP25Q/gcw==
X-Proofpoint-ORIG-GUID: u8k7yug5SJKJEiCmsdL7nnEnMdftr3b5
X-Authority-Analysis: v=2.4 cv=FN4rAeos c=1 sm=1 tr=0 ts=6a340b81 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=Q-fNiiVtAAAA:8 a=EUspDBNiAAAA:8
 a=nGK9Xfj9c10kWem_e0IA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: u8k7yug5SJKJEiCmsdL7nnEnMdftr3b5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE0MSBTYWx0ZWRfX49UGvnTequhR
 BMRuMyh5XJFVScYCuLkvWAow+3O3pFuFcME92E72RuGpG/Y1JPo/S120XfdbDP86jekKcb9/QtG
 WHjDVUfaPLVrm8nJpwUMYIYv/PKvTUw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180141

On Thu, Jun 18, 2026 at 12:23=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
>
>
> On 6/17/2026 2:49 AM, Ulf Hansson wrote:
> > On Tue, Jun 16, 2026 at 8:58=E2=80=AFPM Kamal Dasu <kamal.dasu@broadcom=
.com> wrote:
> >>
> >>
> >>
> >> On Thu, Jun 11, 2026 at 5:53=E2=80=AFPM Ulf Hansson <ulf.hansson@oss.q=
ualcomm.com> wrote:
> >>>
> >>> On Tue, May 19, 2026 at 5:27=E2=80=AFAM Florian Fainelli
> >>> <florian.fainelli@broadcom.com> wrote:
> >>>>
> >>>> On 5/12/26 06:33, Ulf Hansson wrote:
> >>>>> On Mon, 11 May 2026 at 18:01, Florian Fainelli
> >>>>> <florian.fainelli@broadcom.com> wrote:
> >>>>>>
> >>>>>> On 5/11/26 07:18, Ulf Hansson wrote:
> >>>>>>> On Mon, 13 Apr 2026 at 20:06, Florian Fainelli
> >>>>>>> <florian.fainelli@broadcom.com> wrote:
> >>>>>>>>
> >>>>>>>> The Kioxia 016G01 eMMC device does not exit SLEEP mode when send=
ing CMD0
> >>>>>>>> which prevents the system from properly resuming from S3 warm bo=
ot where
> >>>>>>>> the eMMC is necessary to pull in the boot components.
> >>>>>>>
> >>>>>>> Is the bug confirmed by Kioxia?
> >>>>>>
> >>>>>> We've been going back and forth with them without much progress as=
 far
> >>>>>> as a resolution goes. Since there was no progress and I would like=
 to
> >>>>>> get this included in downstream kernels at some point, this was su=
bmitted.
> >>>>>>
> >>>>>>>
> >>>>>>> If not, can you explain a bit more what is actually happening dur=
ing
> >>>>>>> system resume?
> >>>>>>
> >>>>>> Upon entering Suspend-to-DRAM, the eMMC will be put into sleep mod=
e.
> >>>>>> When our systems resume, one of our hardware cores driving the eMM=
C (HIF
> >>>>>> block) in command mode will send a CMD0 command for the eMMC devic=
e to
> >>>>>
> >>>>> Is the CMD0 sent solely by HW/FW before the mmc core executes
> >>>>> _mmc_resume() during system resume?
> >>>>
> >>>> That is correct. The sequence basically goes like this: HW sends CMD=
0,
> >>>> then FW pulls in boot code, identifies this is a Suspend to DRAM, do=
es
> >>>> its steps, and eventually Linux resumes and calls _mmc_resume().
> >>>
> >>> Okay, so it seems like this problem boils down to the fact that the F=
W
> >>> decides to send a CMD0 command for no good reason at system resume.
> >>> Unless I am missing a point here?
> >>>
> >> The JEDEC JESD84-B51 boot sequence is normative.
> >> The host sends CMD0 (0xF0F0F0F0 / GO_PRE_IDLE_STATE) to enter pre-idle=
/boot mode
> >> Broadcom mmc controller does not skip CMD0 and has no knowledge of the=
 power
> >> State that the kernel left the device; it runs before DRAM is initiali=
zed and before Linux resumes,
> >> before any kernel state is accessible.
> >
> > I understand the CMD0 generally works to wakeup/initialize the eMMC,
> > but that isn't really sufficient.
> >
> > Please, consider these scenarios:
> > 1) If the kernel decides to turn off clocks/regulators (VCC/VCCQ) at
> > suspend for the eMMC, then how does the FW know that it needs to
> > restore these before sending CMD0?
>
> If we had such capability on our board designs, then we would make sure
> that there is adequate power sequencing within the board design to
> guarantee that the eMMC device gets powered back on upon resuming from
> warm boot. We have a variety of signals that can be wired-OR to relevant
> discrete chips, or use an external PMIC to achieve that goal. Your point
> is well understood and valid in general, but not applicable in our case
> here.
>
> > 2) At resume the kernel wants to wake up the eMMC by sending a CMD5
> > (awake) instead of CMD0 (not implemented, but since it is faster we
> > may decide to add this at some point). If the FW already sent CMD0, a
> > CMD5 path would fail.
>
> That assumes the kernel is the first entity involved in interfacing with
> the eMMC device, but that is not the case for us, see below.
>
> >
> >>
> >>
> >>>
> >>> The problem is that the FW doesn't know what low power state the
> >>> kernel decided to put the eMMC device into at system suspend, hence i=
t
> >>> should really leave the decision to the kernel to wake up the eMMC at
> >>> system resume.
> >>>
> >>> Would it be possible to fix the FW instead?
>
> This is not an option for us, see below as to why.
>
> >>>
> >>>>
> >>>>>
> >>>>>> exit SLEEP mode. The Kioxia 016G01 device takes 10ms rather than t=
he
> >>>>>> tSLEEP_EXIT value of 1ms which is advertised and so our HIF block =
does
> >>>>>
> >>>>> Can you please clarify what tSLEEP_EXIT refers to? Are you referrin=
g
> >>>>> to the S_A_TIMEOUT in the EXT_CSD register for the eMMC card?
> >>>>
> >>>> Yes, sorry I am referring to S_A_TIMEOUT in the EXT_CSD register.
> >>>>
> >>>>>
> >>>>> Anyway, waking up an eMMC from sleep state in just 1ms sounds a bit
> >>>>> optimistic to me.
> >>>>
> >>>> Fair enough, but AFAIR we wait up to 30ms before declaring a timeout=
,
> >>>> every other vendor we have seen exits and acknowledges boot within
> >>>> 1-10ms at most. Similarly if the device is not in SLEEP, then it
> >>>> acknowledges boot within 1ms.
> >>>
> >>> The S_A_TIMEOUT specifies the time the eMMC needs to complete the wak=
e
> >>> up from its sleep state.
> >>>
> >>> If the device isn't in sleep state but fully powered-on (as it seems
> >>> to be what you have been playing with), the eMMC should just respond
> >>> immediately as with any other command when the eMMC is in "TRAN"
> >>> state. I assume that's why it works if we don't send the CMD5 (sleep)
> >>> command at system suspend.
> >>>
> >>>>
> >>>>>
> >>>>>> not see the Boot ACK pattern in time and does not service the read
> >>>>>> request from the processor that wanted to read from eMMC, we get a=
 reset
> >>>>>> of the system, rather than continue booting.
> >>>>>>
> >>>>>> When SLEEP is not enabled, the eMMC device responds within tSLEEP_=
EXIT
> >>>>>> as advertised and we don't have that problem.
> >>>>>
> >>>>> Okay, I see.
> >>>>>
> >>>>> In this regard, it's important to understand for me how the mmc hos=
t
> >>>>> driver (and the HW/FW) manages VCC and VCCQ when the mmc core calls
> >>>>> mmc_power_off() from _mmc_suspend()?
> >>>>>
> >>>>> Does this turn off any of these regulators or what happens to them
> >>>>> during system suspend?
> >>>>
> >>>> We don't have software controlled regulators for VCC and VCCQ and ou=
r
> >>>> reference boards using that specific eMMC device keep it powered on
> >>>> through suspend-to-DRAM. This is the very reason why if it stays in
> >>>> sleep mode, powered on, and then we attempt to boot from eMMC we hav=
e
> >>>> this issue.
> >>>
> >>> Okay, thanks for elaborating.
> >>>
> >>> So you are mixing the system suspend/resume scenarios with boot here.
> >>> Is the problem for both?
> >>>
> >> No the problem only occurs when we suspend/resume if we put the device=
 in suspend as per spec,
> >> subsequent resume fails.
> >
> > Okay, thanks for clarifying!
> >
> >>
> >>>
> >>> I understand the timeout problem, but not why the FW needs to send th=
e
> >>> CMD0 to wake up the eMMC from system suspend. In regards to boot, tha=
t
> >>> is an entirely different scenario.
> >>>
> >>
> >> Vendor datasheets implementing JESD84-B51 quote from spec :
> >> "In the Sleep state, the power consumption of the memory device is min=
imized.
> >> In this state, the memory device reacts only to the commands RESET (CM=
D0 with
> >> argument of either 0x00000000 or 0xF0F0F0F0 or H/W reset) and SLEEP/AW=
AKE
> >> (CMD5). All other commands are ignored by the memory device."
> >
> > Yes, that's correct but doesn't explain why the FW needs to send CMD0,
> > rather than relying on the kernel to do it.
>
> See below.
>
> >
> >>
> >>> Does the FW need to read something from the eMMC before the system
> >>> resumes? Or that is just during boot?
> >>
> >>
> >>    It's just booting up on resume and reads bootcode.
> >
> > Would you mind elaborating what "reads bootcode" really means here? Is
> > it reading data from the eMMC?
>
> We have a boot ROM masked within the chip that interfaces with the Host
> Interface (HIF) controller which drives the eMMC in boot mode in order
> to allow the boot ROM code to pull in the subsequent boot components. If
> that first access fails because the eMMC device is still asleep then
> that boot ROM considers it a fatal error and will issue a chip reset.
>  From there on, this is no longer a warm boot, but now a cold boot
> because the reset reason changed. From a system architecture
> perspective, a warm boot is similar to a cold boot except:
>
> - there is a reset controller bit indicating this is a wake-up from what
> we call S3, rather than a cold boot
>
> - DDR contents are guaranteed to be preserved by having kept the
> supplies on, therefore we can restore SW/FW states
>
> - there is additionally an on-chip memory RAM that can store persistent
> information, too
>
> - first stage boot loader identifies the warm boot condition and then
> proceeds with restoring DRAM calibration parameters, and then hands off
> control to the remaining FW/SW running on the system. Eventually Linux
> resumes and can interface with the eMMC controller
>
> >
> > To me, it looks like we may have two ways forward to fix this problem:
> > 1) Fix the FW so it doesn't need to send the CMD0 at resume. If that
> > is possible, this would be the best option.
>
> That is not an option for us because the
>
> > 2) Instruct the kernel to keep the eMMC powered on at suspend, while
> > still doing a regular re-initialization of it at resume.
>
> OK, so your angle is that we should not focus on the kernel sending the
> SLEEP command, but instead have a notion of "keep eMMC device
> always-on", which would also tentatively address a board design where we
> could turn off the eMMC device voltage regulators?

Thanks for all the details!

Yes, keeping the eMMC device always-on seems to do exactly what we
want. Although, since the FW sends a CMD0, we need to re-initialize
the eMMC from the kernel point of view, at system resume.

So, let's move away from the card quirk and invent a new mmc host cap
bit that instucts the mmc core what to do here instead. Not sure if
this a DT based platform, but if so, we may also to want to add a
corresponding dt property, unless the mmc host cap bit can be derived
from a compatible string.

Kind regards
Uffe
