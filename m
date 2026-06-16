Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com [209.85.222.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3B23CEBBD
	for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2026 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636295; cv=none; b=IvEOBLjLNem60gAGAzmUjBS6QYWZNzajBH3EVKWwlAgWRWL4sqpDjnB1tprta3mk46JnJy8an1H6FjEYVgIuP5KQAkTgOUuPE+vGMJpEWxmJbfCxEFr1u5ClUF/0jYBh5IoxRfOqPpkOAU2GOmcv58akBhirVi9FWp2thQoTfYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636295; c=relaxed/simple;
	bh=2nDuW1OZg/tHG59HNYFKWjcdMlyFLpJ6bjI5BgGBMzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JuJHS0liJq3DQ9rO9UsZdqjTDR5Wqc8p4ECHaRb/9Yu+t+HMN2Q/PnUQC3TFCXZDdzfWHGLv0LKXWupSiAT+YALzr15TYj0+11p2/QRvpPdpT5jzQJJeUS4cBZLRClRHdL4rOMcYadZ2BT8Y+hhlfmMx1V0vqNWXax1WTmeOBeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FkrE+smg; arc=none smtp.client-ip=209.85.222.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FkrE+smg"
Received: by mail-ua1-f98.google.com with SMTP id a1e0cc1a2514c-963a35acfaaso1590259241.2
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2026 11:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781636292; x=1782241092;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRFPRx+K3alssPiP7RWE0GWLnM1LPAfcqoPVrqOBueE=;
        b=f5SIciajwU5xItgtnh3CPKWSq5w2MKse3kbNz6cB26VKHbGnaf45/Dzw6/ZqJ4O1gz
         xrHjjx7eI+U96flGVTwBrNyz/YWkCkNd09X0eJcm1JktHNgL98pWL3Vm7QyC2LhepIK9
         lKR9qvceki3ckOJfHEjA96K+88hItrhKi2LqwUM/qFA9/YbgJGFjfp0LW4ovQVR9RETH
         wcxs0NHs7eMWsAQxyb72z5+99buwphf9YRTf2z3tm2r+fp2g+DqvyTQsfVSgnv3jC86I
         PleulQUUgf607kjFBX4Pk8I2yzjFsm1ihPG59aXN+AHX90QFqsVoywtOyNFktjgOf7uB
         /CtQ==
X-Forwarded-Encrypted: i=1; AFNElJ+iqPJyrs+vHFgMvJG6iiCfrqYCKhYAS5If1pNcNyAj9PdlaNM+DNhMKpmsa1qwR6fLE4DmDQtzg3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoxfeuMQrkG8PcTPjZojpmMuJBZH/nMXDrYCoJgUTzSVrgG8xk
	sEOl5mNSL3tHK9qIuhYCJtAO6VERQT+Cevvh4LiZ58BqCk19qAz5Nmh+8sMkq1sVuJFyA7Zq8lV
	pkbHZbtZbSTaa4BIASL4/cbv1YQ63jw3rOAkTpRGQhPVhJCsOnJCVbmeNG54SsXiEKY3zdzNC4i
	CYqw88OhFzNQoVIbKqnRCaGDyVL7nczCaojnudeCBD8T7x8NueMSHNZusz8OjP2jGzmlzYzaZaq
	YYAmidG4kR3
X-Gm-Gg: Acq92OHZEkCYTcKXgh0l+N/LhRyuwYqV0gnmWcdnBQHvTCbkjxa3hUNBw1I19ZEUUCt
	x548EBPRxbd4GrfrOqsWI1gMt09VP8SjiBFkqErb/jT9jOBtl5o1KGgou3njGpAaX0rb0oSvF/1
	Apvxw581QZvvsypdwdUXBsSSTveB/HaEZZWa4qlcnmuHI8XyYr+AL2cRJNXct3wf9EB6Ld/sB91
	5LFyX8BAO1wxiG8+AUCqHAy/cGVlhD4wSpJR7laz3WuaOWgzMLSjLOJlV7kDLCY7PJWigMVjve7
	dQnV4QiH9QKkyPquzqulS/EBfNVxP7kT9pSG3B7cYN+JXozb5Iq6a/P/f1OBScauej9BXhMs09n
	2mSd3eWUUKPBXcqpvRqNKTCbyToib5+L1iyFpJVfPomVCfKyC4TW+AwC9cwI5Pxwq2dMOKbRnva
	zG5xNSmRfAdDcGHlVxhEVq2oqdE7roNpsHClW7jXtDIGcCJZ+HD0PqaeB8
X-Received: by 2002:a05:6102:c51:b0:71d:3739:76e4 with SMTP id ada2fe7eead31-7245db99fb6mr550783137.9.1781636292275;
        Tue, 16 Jun 2026 11:58:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-72084bd6dafsm549153137.10.2026.06.16.11.58.11
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2026 11:58:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-304b8d0ee63so7549541eec.0
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2026 11:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781636291; x=1782241091; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eRFPRx+K3alssPiP7RWE0GWLnM1LPAfcqoPVrqOBueE=;
        b=FkrE+smghvyZoPCcHbtk1SUrT+o9Ac3Tuznl75V5NY2P9DRQ2vLIjEKHfKmvB2Ex41
         DHQzXcAJ0A+Pii8Gajes6/zKl5RE3fia6/O3dSGbO6957zwPdKg2BlR62XU3SmQSAkeM
         S5qJ+HwDDY9BQMsvPAKBci/PojqOMuN2wV2FM=
X-Forwarded-Encrypted: i=1; AFNElJ853//x1E900H2nkTOt9uU+9fRc7ue8z7Ti5Pqok/ETnCpR6TTbZB01Rk9KZBLs94VGlUF6uxYwKk4=@vger.kernel.org
X-Received: by 2002:a05:7022:fe05:b0:134:df7f:a5cf with SMTP id a92af1059eb24-1398f6d682emr122443c88.29.1781636291139;
        Tue, 16 Jun 2026 11:58:11 -0700 (PDT)
X-Received: by 2002:a05:7022:fe05:b0:134:df7f:a5cf with SMTP id
 a92af1059eb24-1398f6d682emr122427c88.29.1781636290501; Tue, 16 Jun 2026
 11:58:10 -0700 (PDT)
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
In-Reply-To: <CAPx+jO-qQ25-BDnFmCDf+WYpKPHATJjSDMEz=8Wh7pAFdv0v5A@mail.gmail.com>
From: Kamal Dasu <kamal.dasu@broadcom.com>
Date: Tue, 16 Jun 2026 14:57:33 -0400
X-Gm-Features: AVVi8CcxQittFQOwnr3UHurlrpdx7QsJ4DZNApQ-IMPd2ew1G0LYWwH3kfcuzWI
Message-ID: <CAKekbescGNw_HjyAOizDz0ZTBTrOCV6=DC_kyQD2vd917HR=SQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Kioxia 016G01 does not enter boot mode after SLEEP
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-kernel@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Avri Altman <avri.altman@sandisk.com>, Pedro Demarchi Gomes <pedrodemargomes@gmail.com>, 
	Erick Shepherd <erick.shepherd@ni.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000045fc79065463866d"

--00000000000045fc79065463866d
Content-Type: multipart/alternative; boundary="00000000000036f5e70654638605"

--00000000000036f5e70654638605
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 5:53=E2=80=AFPM Ulf Hansson <ulf.hansson@oss.qualco=
mm.com>
wrote:

> On Tue, May 19, 2026 at 5:27=E2=80=AFAM Florian Fainelli
> <florian.fainelli@broadcom.com> wrote:
> >
> > On 5/12/26 06:33, Ulf Hansson wrote:
> > > On Mon, 11 May 2026 at 18:01, Florian Fainelli
> > > <florian.fainelli@broadcom.com> wrote:
> > >>
> > >> On 5/11/26 07:18, Ulf Hansson wrote:
> > >>> On Mon, 13 Apr 2026 at 20:06, Florian Fainelli
> > >>> <florian.fainelli@broadcom.com> wrote:
> > >>>>
> > >>>> The Kioxia 016G01 eMMC device does not exit SLEEP mode when sendin=
g
> CMD0
> > >>>> which prevents the system from properly resuming from S3 warm boot
> where
> > >>>> the eMMC is necessary to pull in the boot components.
> > >>>
> > >>> Is the bug confirmed by Kioxia?
> > >>
> > >> We've been going back and forth with them without much progress as f=
ar
> > >> as a resolution goes. Since there was no progress and I would like t=
o
> > >> get this included in downstream kernels at some point, this was
> submitted.
> > >>
> > >>>
> > >>> If not, can you explain a bit more what is actually happening durin=
g
> > >>> system resume?
> > >>
> > >> Upon entering Suspend-to-DRAM, the eMMC will be put into sleep mode.
> > >> When our systems resume, one of our hardware cores driving the eMMC
> (HIF
> > >> block) in command mode will send a CMD0 command for the eMMC device =
to
> > >
> > > Is the CMD0 sent solely by HW/FW before the mmc core executes
> > > _mmc_resume() during system resume?
> >
> > That is correct. The sequence basically goes like this: HW sends CMD0,
> > then FW pulls in boot code, identifies this is a Suspend to DRAM, does
> > its steps, and eventually Linux resumes and calls _mmc_resume().
>
> Okay, so it seems like this problem boils down to the fact that the FW
> decides to send a CMD0 command for no good reason at system resume.
> Unless I am missing a point here?
>
> The JEDEC JESD84-B51 boot sequence is normative.
The host sends CMD0 (0xF0F0F0F0 / GO_PRE_IDLE_STATE) to enter pre-idle/boot
mode
Broadcom mmc controller does not skip CMD0 and has no knowledge of the
power
State that the kernel left the device; it runs before DRAM is initialized
and before Linux resumes,
before any kernel state is accessible.



> The problem is that the FW doesn't know what low power state the
> kernel decided to put the eMMC device into at system suspend, hence it
> should really leave the decision to the kernel to wake up the eMMC at
> system resume.
>
> Would it be possible to fix the FW instead?
>
> >
> > >
> > >> exit SLEEP mode. The Kioxia 016G01 device takes 10ms rather than the
> > >> tSLEEP_EXIT value of 1ms which is advertised and so our HIF block do=
es
> > >
> > > Can you please clarify what tSLEEP_EXIT refers to? Are you referring
> > > to the S_A_TIMEOUT in the EXT_CSD register for the eMMC card?
> >
> > Yes, sorry I am referring to S_A_TIMEOUT in the EXT_CSD register.
> >
> > >
> > > Anyway, waking up an eMMC from sleep state in just 1ms sounds a bit
> > > optimistic to me.
> >
> > Fair enough, but AFAIR we wait up to 30ms before declaring a timeout,
> > every other vendor we have seen exits and acknowledges boot within
> > 1-10ms at most. Similarly if the device is not in SLEEP, then it
> > acknowledges boot within 1ms.
>
> The S_A_TIMEOUT specifies the time the eMMC needs to complete the wake
> up from its sleep state.
>
> If the device isn't in sleep state but fully powered-on (as it seems
> to be what you have been playing with), the eMMC should just respond
> immediately as with any other command when the eMMC is in "TRAN"
> state. I assume that's why it works if we don't send the CMD5 (sleep)
> command at system suspend.
>
> >
> > >
> > >> not see the Boot ACK pattern in time and does not service the read
> > >> request from the processor that wanted to read from eMMC, we get a
> reset
> > >> of the system, rather than continue booting.
> > >>
> > >> When SLEEP is not enabled, the eMMC device responds within tSLEEP_EX=
IT
> > >> as advertised and we don't have that problem.
> > >
> > > Okay, I see.
> > >
> > > In this regard, it's important to understand for me how the mmc host
> > > driver (and the HW/FW) manages VCC and VCCQ when the mmc core calls
> > > mmc_power_off() from _mmc_suspend()?
> > >
> > > Does this turn off any of these regulators or what happens to them
> > > during system suspend?
> >
> > We don't have software controlled regulators for VCC and VCCQ and our
> > reference boards using that specific eMMC device keep it powered on
> > through suspend-to-DRAM. This is the very reason why if it stays in
> > sleep mode, powered on, and then we attempt to boot from eMMC we have
> > this issue.
>
> Okay, thanks for elaborating.
>
> So you are mixing the system suspend/resume scenarios with boot here.
> Is the problem for both?
>
> No the problem only occurs when we suspend/resume if we put the device in
suspend as per spec,
subsequent resume fails.


> I understand the timeout problem, but not why the FW needs to send the
> CMD0 to wake up the eMMC from system suspend. In regards to boot, that
> is an entirely different scenario.
>
>
Vendor datasheets implementing JESD84-B51 quote from spec :
"In the Sleep state, the power consumption of the memory device is
minimized.
In this state, the memory device reacts only to the commands RESET (CMD0
with
argument of either 0x00000000 or 0xF0F0F0F0 or H/W reset) and SLEEP/AWAKE
(CMD5). All other commands are ignored by the memory device."

Does the FW need to read something from the eMMC before the system
> resumes? Or that is just during boot?


  It's just booting up on resume and reads bootcode.

[...]
>
> Kind regards
> Uffe
>
>
Thanks
Kamal

--00000000000036f5e70654638605
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 11, 2026=
 at 5:53=E2=80=AFPM Ulf Hansson &lt;<a href=3D"mailto:ulf.hansson@oss.qualc=
omm.com" target=3D"_blank">ulf.hansson@oss.qualcomm.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, May 19, 2026=
 at 5:27=E2=80=AFAM Florian Fainelli<br>
&lt;<a href=3D"mailto:florian.fainelli@broadcom.com" target=3D"_blank">flor=
ian.fainelli@broadcom.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On 5/12/26 06:33, Ulf Hansson wrote:<br>
&gt; &gt; On Mon, 11 May 2026 at 18:01, Florian Fainelli<br>
&gt; &gt; &lt;<a href=3D"mailto:florian.fainelli@broadcom.com" target=3D"_b=
lank">florian.fainelli@broadcom.com</a>&gt; wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 5/11/26 07:18, Ulf Hansson wrote:<br>
&gt; &gt;&gt;&gt; On Mon, 13 Apr 2026 at 20:06, Florian Fainelli<br>
&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:florian.fainelli@broadcom.com" targ=
et=3D"_blank">florian.fainelli@broadcom.com</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; The Kioxia 016G01 eMMC device does not exit SLEEP mod=
e when sending CMD0<br>
&gt; &gt;&gt;&gt;&gt; which prevents the system from properly resuming from=
 S3 warm boot where<br>
&gt; &gt;&gt;&gt;&gt; the eMMC is necessary to pull in the boot components.=
<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Is the bug confirmed by Kioxia?<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; We&#39;ve been going back and forth with them without much pr=
ogress as far<br>
&gt; &gt;&gt; as a resolution goes. Since there was no progress and I would=
 like to<br>
&gt; &gt;&gt; get this included in downstream kernels at some point, this w=
as submitted.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; If not, can you explain a bit more what is actually happe=
ning during<br>
&gt; &gt;&gt;&gt; system resume?<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Upon entering Suspend-to-DRAM, the eMMC will be put into slee=
p mode.<br>
&gt; &gt;&gt; When our systems resume, one of our hardware cores driving th=
e eMMC (HIF<br>
&gt; &gt;&gt; block) in command mode will send a CMD0 command for the eMMC =
device to<br>
&gt; &gt;<br>
&gt; &gt; Is the CMD0 sent solely by HW/FW before the mmc core executes<br>
&gt; &gt; _mmc_resume() during system resume?<br>
&gt;<br>
&gt; That is correct. The sequence basically goes like this: HW sends CMD0,=
<br>
&gt; then FW pulls in boot code, identifies this is a Suspend to DRAM, does=
<br>
&gt; its steps, and eventually Linux resumes and calls _mmc_resume().<br>
<br>
Okay, so it seems like this problem boils down to the fact that the FW<br>
decides to send a CMD0 command for no good reason at system resume.<br>
Unless I am missing a point here?<br>
<br></blockquote>The JEDEC JESD84-B51 boot sequence is normative.=C2=A0</di=
v><div class=3D"gmail_quote">The host sends CMD0 (0xF0F0F0F0 / GO_PRE_IDLE_=
STATE) to enter pre-idle/boot mode<div><div class=3D"gmail_quote">Broadcom =
mmc controller does not skip CMD0 and has no knowledge of the power=C2=A0</=
div><div class=3D"gmail_quote">State that the kernel left the device; it ru=
ns before DRAM is initialized and before Linux resumes,=C2=A0</div><div cla=
ss=3D"gmail_quote">before any kernel state is accessible.</div><div class=
=3D"gmail_quote"><div>=C2=A0</div></div></div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
The problem is that the FW doesn&#39;t know what low power state the<br>
kernel decided to put the eMMC device into at system suspend, hence it<br>
should really leave the decision to the kernel to wake up the eMMC at<br>
system resume.<br>
<br>
Would it be possible to fix the FW instead?<br>
<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt;&gt; exit SLEEP mode. The Kioxia 016G01 device takes 10ms rather t=
han the<br>
&gt; &gt;&gt; tSLEEP_EXIT value of 1ms which is advertised and so our HIF b=
lock does<br>
&gt; &gt;<br>
&gt; &gt; Can you please clarify what tSLEEP_EXIT refers to? Are you referr=
ing<br>
&gt; &gt; to the S_A_TIMEOUT in the EXT_CSD register for the eMMC card?<br>
&gt;<br>
&gt; Yes, sorry I am referring to S_A_TIMEOUT in the EXT_CSD register.<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; Anyway, waking up an eMMC from sleep state in just 1ms sounds a b=
it<br>
&gt; &gt; optimistic to me.<br>
&gt;<br>
&gt; Fair enough, but AFAIR we wait up to 30ms before declaring a timeout,<=
br>
&gt; every other vendor we have seen exits and acknowledges boot within<br>
&gt; 1-10ms at most. Similarly if the device is not in SLEEP, then it<br>
&gt; acknowledges boot within 1ms.<br>
<br>
The S_A_TIMEOUT specifies the time the eMMC needs to complete the wake<br>
up from its sleep state.<br>
<br>
If the device isn&#39;t in sleep state but fully powered-on (as it seems<br=
>
to be what you have been playing with), the eMMC should just respond<br>
immediately as with any other command when the eMMC is in &quot;TRAN&quot;<=
br>
state. I assume that&#39;s why it works if we don&#39;t send the CMD5 (slee=
p)<br>
command at system suspend.<br>
<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt;&gt; not see the Boot ACK pattern in time and does not service the=
 read<br>
&gt; &gt;&gt; request from the processor that wanted to read from eMMC, we =
get a reset<br>
&gt; &gt;&gt; of the system, rather than continue booting.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; When SLEEP is not enabled, the eMMC device responds within tS=
LEEP_EXIT<br>
&gt; &gt;&gt; as advertised and we don&#39;t have that problem.<br>
&gt; &gt;<br>
&gt; &gt; Okay, I see.<br>
&gt; &gt;<br>
&gt; &gt; In this regard, it&#39;s important to understand for me how the m=
mc host<br>
&gt; &gt; driver (and the HW/FW) manages VCC and VCCQ when the mmc core cal=
ls<br>
&gt; &gt; mmc_power_off() from _mmc_suspend()?<br>
&gt; &gt;<br>
&gt; &gt; Does this turn off any of these regulators or what happens to the=
m<br>
&gt; &gt; during system suspend?<br>
&gt;<br>
&gt; We don&#39;t have software controlled regulators for VCC and VCCQ and =
our<br>
&gt; reference boards using that specific eMMC device keep it powered on<br=
>
&gt; through suspend-to-DRAM. This is the very reason why if it stays in<br=
>
&gt; sleep mode, powered on, and then we attempt to boot from eMMC we have<=
br>
&gt; this issue.<br>
<br>
Okay, thanks for elaborating.<br>
<br>
So you are mixing the system suspend/resume scenarios with boot here.<br>
Is the problem for both?<br>
<br></blockquote><div>No the problem only occurs when we suspend/resume if =
we put the device in suspend as per spec,</div><div>subsequent resume fails=
.=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
I understand the timeout problem, but not why the FW needs to send the<br>
CMD0 to wake up the eMMC from system suspend. In regards to boot, that<br>
is an entirely different scenario.<br>
<br></blockquote><div class=3D"gmail_quote"><br></div>Vendor datasheets imp=
lementing JESD84-B51 quote from spec :<br>&quot;In the Sleep state, the pow=
er consumption of the memory device is minimized.=C2=A0</div><div class=3D"=
gmail_quote">In this state, the memory device reacts only to the commands R=
ESET (CMD0 with=C2=A0</div><div class=3D"gmail_quote">argument of either 0x=
00000000 or 0xF0F0F0F0 or H/W reset) and SLEEP/AWAKE=C2=A0</div><div class=
=3D"gmail_quote">(CMD5). All other commands are ignored by the memory devic=
e.&quot;</div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quot=
e"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
Does the FW need to read something from the eMMC before the system<br>
resumes? Or that is just during boot?</blockquote><div><br></div><div>=C2=
=A0 It&#39;s just booting up on resume and reads bootcode.</div><div><br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
[...]<br>
<br>
Kind regards<br>
Uffe<br>
<br></blockquote><div><br></div><div>Thanks=C2=A0</div><div>Kamal=C2=A0</di=
v></div></div>
</div>

--00000000000036f5e70654638605--

--00000000000045fc79065463866d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
H0K0rs+X8O45xZIUJlxzf5UZex3BLi1f/H+08rSQULWEtO/ECwkFod2DIzSX7fZdz5RQ1PpziEOp
goo/JZPYIeCmgt3rIyvMuupj8Ymb0J/velhpXfQuYUM52viw2nmqVcxCwBqyM3Iq7eI4xtEOFRmR
wxSizd3MSQMf6GCHA4/B/6ttnxhGAr3utaOU+x/RnzG0gPLTW1XRAQ0+GVc/tGFdI864OG1cyrRl
GvBnHJQSAFOIKwYrUk2oFpgMbafQ6osCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQEAwIFoDAMBgNV
HRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYt
aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFww
CQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRw
czovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwIgYDVR0RBBswGYEX
a2FtYWwuZGFzdUBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAU
ACk2nlx6ug+vLVAt26AjhRiwoJIwHQYDVR0OBBYEFOV9h+N/T9ZsJ40qRxh7NYYD+N6MMA0GCSqG
SIb3DQEBCwUAA4ICAQAKtKh30wv1/30230mCimgUjMWQE/LImRmyfDgrp2IhBVS6mDun+wH8thEB
WhBHQMz3gsGixU4ZBJG72eWi39IzQ7CGnisJwA0+hsGaGg03AVtFtqo1rXYRZ81MEDOb6BPYLigJ
RsHbNmrUGR+LsGeUwOWUeRXqBrYaYFrkgHKvVK1NEewv+vUY08n4tsezO3jq0HKhVDY46bMbf8vL
oQqqhtcQvu2+5FK2jpUayeubpzPwobjEG61RIhBvM0KivY4CB2s9A7qgjL1XBycAybIvG03BbFoT
t282FqXwk9JU6YihLlt+hpzO9UF7E8GZYlQlVIZOLOvytqilhua+2h77Yy8Jz/FJyIXKuaLPtvb2
SC2shL7jF28kQbP3QUKwAig+cxwbpngnUkd9D9cXSHVq9PPwYm0A4eAO0YQ/80Uq20+gXF++g0sy
NKrrV3i0T1dbCd86miGDKvarGzjh7pdsdwNY15liGP6Orib1tnWkJcbtP1rJty4r/mbbxcK8ILO4
IvTGFG6BfjJ+La0aRt69i1fQmjUWHLwzkLNpw9cJH8/MONZcEJeDkq9WELSyy29bagStk5KHu7NO
TH65sZg+i/4qmj3DEeEGTr/Shzp4YWSNn4W7NEelr0VgDlwa7xqlwZjXxG4MIJqy0SsQlAwEXtqd
nH2FpJfzgAetkuyU6DGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2Jh
bFNpZ24gbnYtc2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1FIENBIDIwMjMCDEca
ZUGCu6d0oT1M+zANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg60PvvobWrni5t0nu
LdBgZ/KBNxEOnDtl0FSJplOumk8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjYwNjE2MTg1ODExWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEw
DQYJKoZIhvcNAQEBBQAEggEAU5q3YA9xwDuk+Yy2eutR5nwZCU+lBIlXMLWKfhNLODZ3LojeN2NC
i2sBBLQoRF95x9S48pOY9BhB2ruvR5aZ/r2/cmrQkxzAAIxIGfsAP6XXkFIce2sfIEgVugWjHlX5
YbOL99ErMjwdRSAHbax3xvQcjgdtAKHx+HUXeqMxOeJXYVKjP1t2qOlXp+VFDJq2JYxAsV4PPzwQ
s5OGZSsuPbMH690f8KOeJGp0loGeq2CnpjpMoLMX0L8z5AAMnwmoLk+IaPaisoObb8lZi5bPdXDe
sDwSDH1PqqaNhKY4wlav2YSZ+/EWVgW1obacbkh5at3Ba5ziKYvxN4+6biig+g==
--00000000000045fc79065463866d--
