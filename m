Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4822A3CEBA7
	for <linux-mmc@vger.kernel.org>; Wed, 17 Jun 2026 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689772; cv=pass; b=Zw2cj+reMliAH3N1DClnbOTWOZ7VYEbXNcBn1N37VGZ0Gxwe2Gi8MNnXEGwiIReYGWT5vHklqvOt+DacXWvMaj2vuieEPEmGGlXqY8ReRYtBw6VvCaUn/4ZjPfKnqfhjdcpO7z+9R1Ht3ftDWYaGYsnSMWshmQZoPHFLtUDoiTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689772; c=relaxed/simple;
	bh=uAnPdzkjZ4iumnpONvZzrNlpHBgo6gaqYUzVQTbn66A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6IrAnuhf6SNQKzYfal/TI+9o/bEkQkPdwa/ERZtj/dISM+qxk+ILi7bRUUaGJpzzSuGjB9nMdCwct2rElG+Ds3WhEO9/2Ibzvvgqp8R7UXRxk+e0Ema7DpgnaT6oik4+1iNenVD6JoAGMMTdpc6exnb4gmOOQ5YymLCkYill68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kYlUsNEc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DURmk1sl; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kYlUsNEc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DURmk1sl"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8UENt1735037
	for <linux-mmc@vger.kernel.org>; Wed, 17 Jun 2026 09:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wPdvCTrXvhHrYsCAVh+aK+JFyF7ELw+3WC09TRmiDMs=; b=kYlUsNEc4KeiEWQy
	ircLqIcxWiAT5MxNVZdqKT5oorF7c/u8rZ4o5gPHabkiW3iL3sG4gdla5Qo+1NSw
	662yPBy3RJTJJWsLdOVH2fqWu4ajf9Mt49pvYTNsHN0hAqX9taZQ//vtFFSgaH1k
	MpJFwkukEh62BUCFskxvUyhvew4euSq3d2Q7Q5FNpiilfcpM3EQvfOtLT/o3BrgK
	3FpyfM3+GS8YFFfvR+4pNo4/ybW01Brzxt7gq50yh2oMhd95ejbYu7tQUug6KhzP
	zmrPXikFWyKj8PKhiIMghWMaraBbzjSUzxVdWIaTnGknJTliRTYALSnii9+cBTJG
	wXwNIg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueemjh4v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 17 Jun 2026 09:49:30 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8cce1cc8cb2so111275586d6.1
        for <linux-mmc@vger.kernel.org>; Wed, 17 Jun 2026 02:49:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781689769; cv=none;
        d=google.com; s=arc-20240605;
        b=FCjE042pZc+kqfyCp5XuAAY5Z+GXDbLEIilKZtgaktOpBHb0gGVr3mKv8ttmv2wXvQ
         dBmA6pgu+4ukFWJgNmhtrdfQpkQmM7KzxdCNI9hWJcg0IykIsj9bjQvadE63hnGp4r+/
         pO2h2tYx0Iq7dAPt5tVpQ2xoGPh7dVb4EsAbEgTpcI8/2+VMT2Un3Vxx8PtFpfbAAl/f
         ETl3w1IUyk3FjRBkg0z0NSyQy4/sd7omNpCBKT3Om7+yMvU3tvu8UKHKAzlQ5MsDO9zI
         xF3TNsgZ6IV9v56P3gLRcqL1wvXiay9UVrKgXR+ke2oeQ6fy9r4OyiH+Tl53dsT/mD6e
         Nvrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wPdvCTrXvhHrYsCAVh+aK+JFyF7ELw+3WC09TRmiDMs=;
        fh=YEerehDiPpHsgMjZsMQRdIcy1vr6Fi0xridlQtEdqTc=;
        b=URCef7G8wzONtKMcNqOvQYKYJNAOBF3cgExoX5VK0uPKYQLxDI+Xu6KWPA6Lwlfrqc
         PHOnIR0yLbpzltxBZeJe2jnm+K1UzIx07HGgR6wB/xbu9wnHb83Cf0kSRGzSvBrEuA6B
         hTiXEjTZ7WhdVZtrF0Xhi4TeKzOvruUkq4e3S2pkEy3XEON+BhM7033hd9HsfnQGtzXc
         noYu+RgOc3lBQZAIhDAPdciw/5WoOiap4AgG3YDXQ59/XneH0/R4t1l3E8NNybP0q3p1
         oXXt+IkjbxAshnJdLOUU1bw+D9/VIV0JFue6oCk0tT0BmUaU0GojjblIX6W9CRkh2jiL
         qU5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781689769; x=1782294569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPdvCTrXvhHrYsCAVh+aK+JFyF7ELw+3WC09TRmiDMs=;
        b=DURmk1slVXSzD/CasJ/mgQCR1NBzX1zhTF+X7EvPUQ2BjzaGfUbsOZ2R8vArM4J31R
         6qHn5gI4AwtTYQsUhiYoeNxHWaiqxUE8dYfWjswr2t9S1DN5lz/LRRuScqSEHAkeVujm
         5GtKL4VluqIXS20doINuG63JWbmWdaN6zCMOkgr/VUbHXchQKEWNYNgk/780QpP8AW7b
         M5ky5BNahlzW9OFVqKPjFMGAOdoWJ6Mjojk0VY8a2kW+svADcKZ4oCfVxiI9nmcw/ihj
         pdRBwttYO1Na/RCSH+8MOhqLoM0k3+BPbv+GgRi/q21GSWZ8sxeWCITSX9LKhuxZUBDt
         y8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781689769; x=1782294569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wPdvCTrXvhHrYsCAVh+aK+JFyF7ELw+3WC09TRmiDMs=;
        b=RJh+FhEALB6vzDV8e96CmWO1Lyc9r106pW49wXCGM3OYGSHcjKzEL+dkmk3KcEtItS
         Ycey1Ykyk3w7yZCH4R15hu2Us00i9nxF1S/tWQs7XrkDEPXv2T8t18l39FOQhhUgQ4w3
         eYwa2jldEopSSvg95gnqwDnjo+TOzX8BWliV/03UixVACujtNEkFtO8uv51XfWLyVJ5e
         sQbCfhVljuQAqfcCFwU2WMVbIioNIvz7VyarHhQ2IfMWYThvyGaWmvcwnMOnabqOl+le
         YrMGf4Vdk0JFcDZqAxkNa+nasmFBwvgoYPSR9W4vjU0sDjou6Yy7yilBeK8pDLFjPzAl
         j4SQ==
X-Forwarded-Encrypted: i=1; AFNElJ9x+onFKAPbQrPlRFEbI4coY94l30rYlSB+KCtcSjFq7YPsKc7/JMr+eKoBkaqpRL9GNVF0NbmmMu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmwsK4s3aTaajV1fFdCwEVwH/XiKv/qhI1cVPC1SeU/Bc1L6+z
	QoxGvWSBMtbUXMFaqSwgkc65CX0hliip/WAhsCpyVDljTpQmhz1LZwyPI40KdHx9LKUxeZkj5fe
	mHtYpPrB1y6yaZjhoKd5pvcVV/HsukBW+Xzb6ZNl9n5N0b6nJktd1TAGCC5bgfBWFQd3uXgkAso
	Hwrwlf9aBHpTAbs7hh4kintVMLYUw27JHJ4Sadw0Z/jgl/URh3
X-Gm-Gg: AfdE7cmhf8xTUC3NuZQzMIwkQTddM+cJoiT1iep1EhEm0x/S0dyvc3DoKoF+/rH09qR
	rYWU9EZ1S0zxK8rr0dYMtwxPSQB0SsbXld0wFmdK+50lKWqsIgDs/nYnpXs2eJ6htZ/ZJe2VwMl
	3IkI219tnLWMhAxn5A36cQdhk1HbkUJ0g1kftF7Ka984KYwXxCjY7PNhwyqJ9/wnHw6+sq
X-Received: by 2002:a05:6214:4282:b0:8db:c6e4:b6cf with SMTP id 6a1803df08f44-8dbc6e4bb62mr30578466d6.37.1781689769302;
        Wed, 17 Jun 2026 02:49:29 -0700 (PDT)
X-Received: by 2002:a05:6214:4282:b0:8db:c6e4:b6cf with SMTP id
 6a1803df08f44-8dbc6e4bb62mr30578146d6.37.1781689768866; Wed, 17 Jun 2026
 02:49:28 -0700 (PDT)
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
In-Reply-To: <CAKekbescGNw_HjyAOizDz0ZTBTrOCV6=DC_kyQD2vd917HR=SQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 11:49:18 +0200
X-Gm-Features: AVVi8CfvmbCKONv5-_FpV-olZIgBMsQWbkgohbmph9z0-6R91Jz76JCSKeHJddc
Message-ID: <CAPx+jO9-WOUib2Px9e7UZ8urKEhi=OXPurvMZ-fZjYsJSoRw-g@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Kioxia 016G01 does not enter boot mode after SLEEP
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org,
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfXzWHl+hftFGZ+
 VwZyrQemSOdUhzpFjGf3FQ9LiMUmkAk4z2TzC2cEo8zYwoWJE8hsapyvGhZUwPJKkortWCGDlup
 QxG7HGkneGD+oS3nD1ecuPoQQAhD+VA=
X-Authority-Analysis: v=2.4 cv=D4d37PRj c=1 sm=1 tr=0 ts=6a326daa cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=Q-fNiiVtAAAA:8 a=EUspDBNiAAAA:8
 a=rf7OXFoTR_OTfoa8UqAA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: BpoHI60Ad-_XQdcsZIZ48FpFCTVomSBb
X-Proofpoint-ORIG-GUID: BpoHI60Ad-_XQdcsZIZ48FpFCTVomSBb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5MiBTYWx0ZWRfX9LFhvLOLdUgB
 fn6PBPwmSCJLJMKkfuuBUl7mWNbduuwA6egjslMPknCRMQu5UABAowxhAvpDM8igaT39cYeZWgH
 VEz3xUl08DG0GDLGdPHXx5J8k7IFvUUr4JbJw3o9OHiXmn4d5OZ5NO0w19Jdv3F5CdyWs135mZF
 ouZ0jf3pflbOF44jY6PZON6+7JBJrf6VqU/iKq3tdb2j4brKNo3hCh6X0WwWrTahOURDIEISYNk
 OPlh4O4ADaJEqBS1cOhSwz8d2NY6J2E6lBIyRqjw5fDdcfIzCmWPYHPqACIikaj3O0k8Exgpm09
 5BNWSLJfTYo35L5IFRCjJVaODc/86NNND4iRw5nEYWvcy0dTfjUy+IsWDdVhJm1QN8psrqDWcU1
 aPPYVRl7+yryGh7MYExLV+rEYQL0ukeXjq/rZYjBP64dTO0c6REeu/dHmd0Cr3Sh+F4jO1tCh+p
 AQ+S3L22muAbi6sDYOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170092

On Tue, Jun 16, 2026 at 8:58=E2=80=AFPM Kamal Dasu <kamal.dasu@broadcom.com=
> wrote:
>
>
>
> On Thu, Jun 11, 2026 at 5:53=E2=80=AFPM Ulf Hansson <ulf.hansson@oss.qual=
comm.com> wrote:
>>
>> On Tue, May 19, 2026 at 5:27=E2=80=AFAM Florian Fainelli
>> <florian.fainelli@broadcom.com> wrote:
>> >
>> > On 5/12/26 06:33, Ulf Hansson wrote:
>> > > On Mon, 11 May 2026 at 18:01, Florian Fainelli
>> > > <florian.fainelli@broadcom.com> wrote:
>> > >>
>> > >> On 5/11/26 07:18, Ulf Hansson wrote:
>> > >>> On Mon, 13 Apr 2026 at 20:06, Florian Fainelli
>> > >>> <florian.fainelli@broadcom.com> wrote:
>> > >>>>
>> > >>>> The Kioxia 016G01 eMMC device does not exit SLEEP mode when sendi=
ng CMD0
>> > >>>> which prevents the system from properly resuming from S3 warm boo=
t where
>> > >>>> the eMMC is necessary to pull in the boot components.
>> > >>>
>> > >>> Is the bug confirmed by Kioxia?
>> > >>
>> > >> We've been going back and forth with them without much progress as =
far
>> > >> as a resolution goes. Since there was no progress and I would like =
to
>> > >> get this included in downstream kernels at some point, this was sub=
mitted.
>> > >>
>> > >>>
>> > >>> If not, can you explain a bit more what is actually happening duri=
ng
>> > >>> system resume?
>> > >>
>> > >> Upon entering Suspend-to-DRAM, the eMMC will be put into sleep mode=
.
>> > >> When our systems resume, one of our hardware cores driving the eMMC=
 (HIF
>> > >> block) in command mode will send a CMD0 command for the eMMC device=
 to
>> > >
>> > > Is the CMD0 sent solely by HW/FW before the mmc core executes
>> > > _mmc_resume() during system resume?
>> >
>> > That is correct. The sequence basically goes like this: HW sends CMD0,
>> > then FW pulls in boot code, identifies this is a Suspend to DRAM, does
>> > its steps, and eventually Linux resumes and calls _mmc_resume().
>>
>> Okay, so it seems like this problem boils down to the fact that the FW
>> decides to send a CMD0 command for no good reason at system resume.
>> Unless I am missing a point here?
>>
> The JEDEC JESD84-B51 boot sequence is normative.
> The host sends CMD0 (0xF0F0F0F0 / GO_PRE_IDLE_STATE) to enter pre-idle/bo=
ot mode
> Broadcom mmc controller does not skip CMD0 and has no knowledge of the po=
wer
> State that the kernel left the device; it runs before DRAM is initialized=
 and before Linux resumes,
> before any kernel state is accessible.

I understand the CMD0 generally works to wakeup/initialize the eMMC,
but that isn't really sufficient.

Please, consider these scenarios:
1) If the kernel decides to turn off clocks/regulators (VCC/VCCQ) at
suspend for the eMMC, then how does the FW know that it needs to
restore these before sending CMD0?
2) At resume the kernel wants to wake up the eMMC by sending a CMD5
(awake) instead of CMD0 (not implemented, but since it is faster we
may decide to add this at some point). If the FW already sent CMD0, a
CMD5 path would fail.

>
>
>>
>> The problem is that the FW doesn't know what low power state the
>> kernel decided to put the eMMC device into at system suspend, hence it
>> should really leave the decision to the kernel to wake up the eMMC at
>> system resume.
>>
>> Would it be possible to fix the FW instead?
>>
>> >
>> > >
>> > >> exit SLEEP mode. The Kioxia 016G01 device takes 10ms rather than th=
e
>> > >> tSLEEP_EXIT value of 1ms which is advertised and so our HIF block d=
oes
>> > >
>> > > Can you please clarify what tSLEEP_EXIT refers to? Are you referring
>> > > to the S_A_TIMEOUT in the EXT_CSD register for the eMMC card?
>> >
>> > Yes, sorry I am referring to S_A_TIMEOUT in the EXT_CSD register.
>> >
>> > >
>> > > Anyway, waking up an eMMC from sleep state in just 1ms sounds a bit
>> > > optimistic to me.
>> >
>> > Fair enough, but AFAIR we wait up to 30ms before declaring a timeout,
>> > every other vendor we have seen exits and acknowledges boot within
>> > 1-10ms at most. Similarly if the device is not in SLEEP, then it
>> > acknowledges boot within 1ms.
>>
>> The S_A_TIMEOUT specifies the time the eMMC needs to complete the wake
>> up from its sleep state.
>>
>> If the device isn't in sleep state but fully powered-on (as it seems
>> to be what you have been playing with), the eMMC should just respond
>> immediately as with any other command when the eMMC is in "TRAN"
>> state. I assume that's why it works if we don't send the CMD5 (sleep)
>> command at system suspend.
>>
>> >
>> > >
>> > >> not see the Boot ACK pattern in time and does not service the read
>> > >> request from the processor that wanted to read from eMMC, we get a =
reset
>> > >> of the system, rather than continue booting.
>> > >>
>> > >> When SLEEP is not enabled, the eMMC device responds within tSLEEP_E=
XIT
>> > >> as advertised and we don't have that problem.
>> > >
>> > > Okay, I see.
>> > >
>> > > In this regard, it's important to understand for me how the mmc host
>> > > driver (and the HW/FW) manages VCC and VCCQ when the mmc core calls
>> > > mmc_power_off() from _mmc_suspend()?
>> > >
>> > > Does this turn off any of these regulators or what happens to them
>> > > during system suspend?
>> >
>> > We don't have software controlled regulators for VCC and VCCQ and our
>> > reference boards using that specific eMMC device keep it powered on
>> > through suspend-to-DRAM. This is the very reason why if it stays in
>> > sleep mode, powered on, and then we attempt to boot from eMMC we have
>> > this issue.
>>
>> Okay, thanks for elaborating.
>>
>> So you are mixing the system suspend/resume scenarios with boot here.
>> Is the problem for both?
>>
> No the problem only occurs when we suspend/resume if we put the device in=
 suspend as per spec,
> subsequent resume fails.

Okay, thanks for clarifying!

>
>>
>> I understand the timeout problem, but not why the FW needs to send the
>> CMD0 to wake up the eMMC from system suspend. In regards to boot, that
>> is an entirely different scenario.
>>
>
> Vendor datasheets implementing JESD84-B51 quote from spec :
> "In the Sleep state, the power consumption of the memory device is minimi=
zed.
> In this state, the memory device reacts only to the commands RESET (CMD0 =
with
> argument of either 0x00000000 or 0xF0F0F0F0 or H/W reset) and SLEEP/AWAKE
> (CMD5). All other commands are ignored by the memory device."

Yes, that's correct but doesn't explain why the FW needs to send CMD0,
rather than relying on the kernel to do it.

>
>> Does the FW need to read something from the eMMC before the system
>> resumes? Or that is just during boot?
>
>
>   It's just booting up on resume and reads bootcode.

Would you mind elaborating what "reads bootcode" really means here? Is
it reading data from the eMMC?

To me, it looks like we may have two ways forward to fix this problem:
1) Fix the FW so it doesn't need to send the CMD0 at resume. If that
is possible, this would be the best option.
2) Instruct the kernel to keep the eMMC powered on at suspend, while
still doing a regular re-initialization of it at resume.

Kind regards
Uffe
