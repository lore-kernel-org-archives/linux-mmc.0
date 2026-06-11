Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDBA3382C5
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 21:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781214787; cv=pass; b=twaN6NlmV6BLkQ707agJzivigGIsFIsAqfG0BlYLKNXyr0/VChoK6PZgj7MozSlxTtx8F8eVjxIyuF3eLBZyPJ1b39aQAxztbgxuBy4kuCa6UHzsHVJoQaYnSULPSHjKx7/Q9XVmTynaaKkDkrMP6rmmWJGSFHjL8J6gHkhLFho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781214787; c=relaxed/simple;
	bh=LeozoHxeSRQcmJeU9+PzLL4aXMzbi/Kqvda2nAy9COE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUdtP0dGVqP8TIm9+X1K2PB7X0mleZTIZ5sLpM7k93NF32e7Xk+6bXvqOb9qWIsPfOxJkWOyHCar02uAvVTNCeIWftEpsHfU28Tj6Q1k/jX7G25dkVhGi9405CyQs0WVbdBNJpFsTP3vEfltH+OAtw2KakD4Q9IN7DjqCLZW2KM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MAYfZVdC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UpV6ITpr; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MAYfZVdC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UpV6ITpr"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BJ3Xdi1500202
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 21:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LeozoHxeSRQcmJeU9+PzLL4aXMzbi/Kqvda2nAy9COE=; b=MAYfZVdCRHNbmtDU
	gSBeX+vsZ2k5kBZJs63ipQJBn8Lva6ql/NZHIMwmdu38FEBQUQwQSAIqpfozHqw8
	COyANkgr5XNucsGfsyf621EoMdH7iATHhPY0izCkSKmfjojr20wHxUBLFJlFppXM
	26lTKhy7piTQf963i1o72LZiIAwi8Uox4/2FRxyArxFAqcNzxnUXUVkp+Is7b3if
	DNWB5g1Yh6TuaX1e42vZKdLVvWQFFN64G58ZrmtzPh/QDQrUvdLOn3e1DDHnDzPr
	cCw9Tk/DW4TVrz4x2EyrzoOcKw2ugfG+mD+vrdPR2c0XTQu0MwfkVptnb3QTsP65
	/KOp6w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er2r70myf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 21:53:01 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8cea4854fe3so7705036d6.1
        for <linux-mmc@vger.kernel.org>; Thu, 11 Jun 2026 14:53:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781214780; cv=none;
        d=google.com; s=arc-20240605;
        b=WW3dUt65Vf/OKu7n4+MkE24Elm/BV1kV2oW3lzE3mI1AlcfDY2lU7VlZjsquKQObGX
         zikecrpI47qeA+ZnGHdd/9lt1pqRFcYQ/ADQ9OyK8oWwbARjX7re2XFiwEak3gyB3qvn
         v6BMKk6lD7NR3R0EddX2W3ZLxPgaKbZFqsdQywwxZblnRK4U48QyRYKod1JAHIJhZC9C
         LLdfXlj1O/E2d1KwLOf9xUceinmrOrTvs4xdYsYLWfIwC+sEPG4lkbMW6SR5KkOp8kcr
         bRzsHSGVrwj1mKFyJTMtE9vxM0lfkPK/6pNlQZ2yGthXMgcmwDxYB4+v4yHiev62U9vR
         7aPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LeozoHxeSRQcmJeU9+PzLL4aXMzbi/Kqvda2nAy9COE=;
        fh=RMGSEpaS87lsgFwRZ7+5RM9qBB3YIvpnNI741FjOKxM=;
        b=J2LB/GnW7wr9X9Kp0eae+QS+AdXdaOA1/2Co5MIyIa6aCXGjBRly48GtTFWhZSiFFt
         qZEHqDUwtJU5ca2Hz5jbNkmcAU4Fswoehujt+E5eEuf5EJfqCIILwrJFSjO9MqIP38f5
         97wDBruOLIa4NlJux6sRLGclbNe6tv9GdkqJzsaxtqU5t7PO1u+1R6pVXYCsF8rvaEh/
         CVSQtE7JLS+gsGtjqHiShjg3+dViasAZU4dGjJ74mYcaXk4Jb0ta6K6Jgtxi6pJTC3Xt
         U91EX8xYJm2ST1CNOUnvO+HB7huezKsL/sCrrKHFj+I+YMCHLKp+ZLfCM5nNf3gRzhHR
         QQ1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781214780; x=1781819580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeozoHxeSRQcmJeU9+PzLL4aXMzbi/Kqvda2nAy9COE=;
        b=UpV6ITprWEUDPMaQjcynpylWbxjIqsYDQVzK25lZG+sq82NLaXZx0A+4n8Jyiu2/Lw
         kQhE76zbdzZ4dkEzDWhAcapaAwohMoMN5ahKLuEDSgXQq1uWN/IRpG4LhRl2yXMgp/Y9
         DP4ujEsNoyJWrlxYnHk5SAb0pervTHNW0IdPh2fhixMyJAJgfdDeNUPemtYSx718CkST
         VJWTTVHfrFTO13fw8MK5DwoS0W8Je4fADRpwT3436K0cX7iBXX3klsy6lbSyaI6Gpb65
         aU+r9jG4kwLs52nbs3OIKDGLd3ayTvwUA4k9OwJMUKDyK4wa7JCZ+JPIepoDA48BQUED
         cEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781214780; x=1781819580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LeozoHxeSRQcmJeU9+PzLL4aXMzbi/Kqvda2nAy9COE=;
        b=gRUgaZiC9LSn4slmj2Di0XF9i6/6FIRucLJ8iPEwXDLxOxm2mbgmF2V1PSoLTUuCAx
         oolh5Ckkly6e3YzZI8anDvyEl+0oZDZ1P4r2CakAxmoJwURVW1SM/ogH98xcNkGdXjmN
         Viv4ApAwjIz3B9BRSNYOdojGxJOGuR8WUrKSW17I+8xIaJSsk/m8ZTCQUPwUW3pHNqp7
         nf3DC/aICzs3XZaTGDKYxGgLNItG0pJbdlR4cQgUn1z1w9ChGLyNuroKwQszzqRMGNC8
         lNeR6OZnt5sprGmSSRUaqe+Yi86+5F8u4PWpcV8gDkb5bTcBM8U1myXNw1bhE4Gs87z3
         XqCA==
X-Forwarded-Encrypted: i=1; AFNElJ9JgDQvwZjvMEmpj2CqZf+ar0L7lwUCyu1XmOpUX8siBVap2tKAp1st9cijBZ38tRYMPoml4Iqw05w=@vger.kernel.org
X-Gm-Message-State: AOJu0YytGy3Q3jvqg+s5QdLw3W7WALJIVtG1pDfRtw6i+L1t6oiG81qi
	HkCfRZ27bnSDUzVV5Hv6bRW6Bhrd2tr0LF7SvIS2WVJilH62zQa2zARWYwAUoS4L6yhGWxKo8wa
	FHL+cBpB/4byXGjETXHFWWFLGwsxyVrrIMZQcymaDnt6rilsZ/eNKbg4T4CMt2ofuTCJGEG69L4
	X0Ev8J5E5K4aZcW/l9gBoT93+S0IN6jVUQIlZrzQ==
X-Gm-Gg: Acq92OGRalkaTo7MAp/rtPfBFaVK/okeOK9BDglI2NXBUevWjsasdJYoxpzYUX0nbNd
	mK6JMppE4XD7V+DRKLvPPsTXscTzDzV7p+xiswM8Hs7daapWFwwQ9VjofLyIeEndSjt6rtwHFc0
	IP35x7Xx0zS1zpsce1oT+Fupg7i/w9EHaitzyrorT437QiImLCFk7wAtHvTYdt11/OnyolIJtEF
	MYA1KU=
X-Received: by 2002:a05:6214:e6d:b0:8cc:6aa6:704e with SMTP id 6a1803df08f44-8d32c0106c2mr4857786d6.11.1781214780305;
        Thu, 11 Jun 2026 14:53:00 -0700 (PDT)
X-Received: by 2002:a05:6214:e6d:b0:8cc:6aa6:704e with SMTP id
 6a1803df08f44-8d32c0106c2mr4857156d6.11.1781214779791; Thu, 11 Jun 2026
 14:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413180551.3683969-1-florian.fainelli@broadcom.com>
 <CAPDyKFooAH=Z2BEHq08Fu03uidgjuaDbwM-Y3Y3Xa8STV+ODzg@mail.gmail.com>
 <1d583be4-b1cd-4226-bdbe-5ebd275de9c2@broadcom.com> <CAPDyKFopEbm6z2-AVmPQr5csofNew2nWpzGyTdBK24w+5YD-PQ@mail.gmail.com>
 <915473f9-64bc-4630-9c82-41fcf4401042@broadcom.com>
In-Reply-To: <915473f9-64bc-4630-9c82-41fcf4401042@broadcom.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 23:52:48 +0200
X-Gm-Features: AVVi8CdL24Gk4EX5Y_mRYwYSEEVkbCg7O5_4g32qHa9ZTKG6KvtD6_3awfih23s
Message-ID: <CAPx+jO-qQ25-BDnFmCDf+WYpKPHATJjSDMEz=8Wh7pAFdv0v5A@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Kioxia 016G01 does not enter boot mode after SLEEP
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulfh@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Avri Altman <avri.altman@sandisk.com>,
        Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
        Erick Shepherd <erick.shepherd@ni.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: KDENibVeo32aj4GS3UEomGOjdlh47ajw
X-Authority-Analysis: v=2.4 cv=RJGD2Yi+ c=1 sm=1 tr=0 ts=6a2b2e3d cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=Q-fNiiVtAAAA:8 a=sLU28FI1qLTnmVuPegYA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: KDENibVeo32aj4GS3UEomGOjdlh47ajw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIxOSBTYWx0ZWRfXzaRkOiuNeulW
 gkGYHUX//pE+w3N7/cAcat2oR5550zUhuyZJChgPUwrtM2q0Hzps+SezNvoJUEZ/QnhLN8yjar0
 03w4AxdNhIZ2yBt8KTdBawlhoSrpnqSE8ZCUErjP8xNtfCrExWCV6ByOXPtu6FJ+n/zELz+i062
 4YiZwV8doUBYSmiNGq3r62fTwAsmL2soK0bCvfJtFivT25CiEZtOiHBtIjxL0TWrI9nL4zMcvr8
 Hkhhg/9oDQbq+kJHj4y6V9Hl7PDm6tfGesUzh2oxNBpHubxGbJ/bfZN4rTiNMQpOqq0dszFNGyy
 IYCe6VRk3V6CURyds65IWvkJ2C0HRAIRl6mzc0JUzL6gYqIqfRks6UwZDTIPQelpm3HNpFUi1Sj
 D4NA1XO5skwZucle7Scm/WBRX5dj+jjsOahm/yI922E+XVGgcRM9UnKf84rvgDJkb97/b8LvNxH
 7zATV++Zk+PEzDaE5cw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIxOSBTYWx0ZWRfX9juj17uCAngb
 05Ime2fuIP9foCcsz4C6ehH3St126xHb4Mh6c+FhbJXrxdrn0ykbiGad+B1Qi/7T8xYSI1At7iS
 2YckvNyZvhb/SY30u9ZN6BliQI+BUxU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_04,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110219

On Tue, May 19, 2026 at 5:27=E2=80=AFAM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 5/12/26 06:33, Ulf Hansson wrote:
> > On Mon, 11 May 2026 at 18:01, Florian Fainelli
> > <florian.fainelli@broadcom.com> wrote:
> >>
> >> On 5/11/26 07:18, Ulf Hansson wrote:
> >>> On Mon, 13 Apr 2026 at 20:06, Florian Fainelli
> >>> <florian.fainelli@broadcom.com> wrote:
> >>>>
> >>>> The Kioxia 016G01 eMMC device does not exit SLEEP mode when sending =
CMD0
> >>>> which prevents the system from properly resuming from S3 warm boot w=
here
> >>>> the eMMC is necessary to pull in the boot components.
> >>>
> >>> Is the bug confirmed by Kioxia?
> >>
> >> We've been going back and forth with them without much progress as far
> >> as a resolution goes. Since there was no progress and I would like to
> >> get this included in downstream kernels at some point, this was submit=
ted.
> >>
> >>>
> >>> If not, can you explain a bit more what is actually happening during
> >>> system resume?
> >>
> >> Upon entering Suspend-to-DRAM, the eMMC will be put into sleep mode.
> >> When our systems resume, one of our hardware cores driving the eMMC (H=
IF
> >> block) in command mode will send a CMD0 command for the eMMC device to
> >
> > Is the CMD0 sent solely by HW/FW before the mmc core executes
> > _mmc_resume() during system resume?
>
> That is correct. The sequence basically goes like this: HW sends CMD0,
> then FW pulls in boot code, identifies this is a Suspend to DRAM, does
> its steps, and eventually Linux resumes and calls _mmc_resume().

Okay, so it seems like this problem boils down to the fact that the FW
decides to send a CMD0 command for no good reason at system resume.
Unless I am missing a point here?

The problem is that the FW doesn't know what low power state the
kernel decided to put the eMMC device into at system suspend, hence it
should really leave the decision to the kernel to wake up the eMMC at
system resume.

Would it be possible to fix the FW instead?

>
> >
> >> exit SLEEP mode. The Kioxia 016G01 device takes 10ms rather than the
> >> tSLEEP_EXIT value of 1ms which is advertised and so our HIF block does
> >
> > Can you please clarify what tSLEEP_EXIT refers to? Are you referring
> > to the S_A_TIMEOUT in the EXT_CSD register for the eMMC card?
>
> Yes, sorry I am referring to S_A_TIMEOUT in the EXT_CSD register.
>
> >
> > Anyway, waking up an eMMC from sleep state in just 1ms sounds a bit
> > optimistic to me.
>
> Fair enough, but AFAIR we wait up to 30ms before declaring a timeout,
> every other vendor we have seen exits and acknowledges boot within
> 1-10ms at most. Similarly if the device is not in SLEEP, then it
> acknowledges boot within 1ms.

The S_A_TIMEOUT specifies the time the eMMC needs to complete the wake
up from its sleep state.

If the device isn't in sleep state but fully powered-on (as it seems
to be what you have been playing with), the eMMC should just respond
immediately as with any other command when the eMMC is in "TRAN"
state. I assume that's why it works if we don't send the CMD5 (sleep)
command at system suspend.

>
> >
> >> not see the Boot ACK pattern in time and does not service the read
> >> request from the processor that wanted to read from eMMC, we get a res=
et
> >> of the system, rather than continue booting.
> >>
> >> When SLEEP is not enabled, the eMMC device responds within tSLEEP_EXIT
> >> as advertised and we don't have that problem.
> >
> > Okay, I see.
> >
> > In this regard, it's important to understand for me how the mmc host
> > driver (and the HW/FW) manages VCC and VCCQ when the mmc core calls
> > mmc_power_off() from _mmc_suspend()?
> >
> > Does this turn off any of these regulators or what happens to them
> > during system suspend?
>
> We don't have software controlled regulators for VCC and VCCQ and our
> reference boards using that specific eMMC device keep it powered on
> through suspend-to-DRAM. This is the very reason why if it stays in
> sleep mode, powered on, and then we attempt to boot from eMMC we have
> this issue.

Okay, thanks for elaborating.

So you are mixing the system suspend/resume scenarios with boot here.
Is the problem for both?

I understand the timeout problem, but not why the FW needs to send the
CMD0 to wake up the eMMC from system suspend. In regards to boot, that
is an entirely different scenario.

Does the FW need to read something from the eMMC before the system
resumes? Or that is just during boot?

[...]

Kind regards
Uffe
