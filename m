Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794311391;
	b=ZgEvBkVJCoOT7ZT2TGxogByCdkZrGNFJUsRAc2wlekMjH6IDb3V3NSIp26qQ0i3BLy0J
	 RWaQemUDdeF34EWcREI8RV+z667oe0VswyV9MFw2RC5gvyUj7ySYLeE9Wu/nlnVk3xCcY
	 T8NRJs//p56ELcXMz69dmzeua5X8faOEgaSq7W1kgdCEvWE7/kYNcBqsMJhpWDem/HOr/
	 vXGFYO0NFAmHLf9kJXS9UZHafCP54xIb6SNUTcN2BKUqfbpkr2W2l0VfrTlw437u/h9V8
	 XLNixEA+1/LjQH9cnOunvEhcH2sZGUiwcv3Qcx/Km79V0aa4PqrNM3iCygkZciRlKuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311391;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ieBvRnMfyX6acNHGZ0fpmazyXE/Jj6j0kfgwX5F7vhc=;
	b=14T3Dk2S5EKk9mOR30PN/DWKKVND+1kzZH77Nq6koBI8/flsoZML8x6riScwMjIC2xMB
	 rMfLzV36dqwdmS0cWf8RWwvIuUHgX9CPCNK7SNP1hEEvnzasCAf/rjzeiaIhPc+tN1O7a
	 SR5vshbnnCZBBwlOV0LYdf2vOdmXS0NF0VL3e867OELHmw/MHktyvma+KQcT1r4lO+d7H
	 RzC1JJX9MiqN/v8/QoLOfh2bujQki/U6IpmeOH7O4/fU/yw2TLgIih3zvAFzc5mmxwECt
	 ihbhI+Pg3HwoLDVftMKD5/TCtBG6i9ZRlHFrNoDZVUlxvKlXj+9To64Daxwpa2o/gMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=osPyt+7g;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OLL2Uayj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B0C606A330
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 11:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18B0C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=osPyt+7g;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OLL2Uayj
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABAIfZ2688111
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 11:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ieBvRnMfyX6acNHGZ0fpmazyXE/Jj6j0kfgwX5F7vhc=; b=osPyt+7gO87BqXgo
	kNGr/upeu6G4kfXdw2aX0zXqPXCmquPlDq7nH1cAvHfynsrirh3/rsThl/93nwqb
	iukmzL/WJs7n7I7lwidTzPDRmCg5cmNJtyL5G1g3vaqwABcV8Lds5fyuMnC9T0rV
	r6/BOXltqjtxg2woCn6C/SA01smybM/L5NPV5LAQWJh0PTG+/a4vVY37VvDW7M1L
	oK0mps8+EelvvEFw9hKqN2uasifsRwfnnFgTgIzuZtBRJp5nSKUWMd4L0l84Tg6o
	0yEYhHgHuumeCFndoioCnqeRab3Hx0oxWoCqYF/DQ+KePgOUpjwwMGHQM3RZ/wTD
	LrFieg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huucp1t91-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 11:49:50 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b1755b2f26so106717a91.2
        for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 03:49:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794311390; cv=none;
        d=google.com; s=arc-20260327;
        b=g17Y91pAQbpAWZ8iKVKeSdbvfBVJAH3QJhhdPivx6SymoZZVHVYS515yuY+0YHU72j
         YEm7iw6OKgHML0OsCvBDnxMXEwnFX1JavYkKdcn5yjl/pAwBqt4Z/9ydmOz7JAsPx5wQ
         ktsn5hIkolB+GA4UlgFCYf6qA5IdCo8QLAnFl5PT273u9Tvq0fr2qw52lS5wQ/WqCAd+
         miSksyhyGSL6oN8PYfx81jVNpFz0Yv/iD55tJoZc6dc2VjRYRn4YoCNWTannyedOIewg
         xpP9S6yozuFA/AhUJM92KuAzPTP67TKsDfRqjIOAv5SaFYFzr2OIZvQGs8JEUp/u03QU
         gNug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ieBvRnMfyX6acNHGZ0fpmazyXE/Jj6j0kfgwX5F7vhc=;
        fh=CCKN8PIGkmBKiah2r86gwKwrfn6P5s6ThIsC9VcYm14=;
        b=dITcCu+vFuwtoZfEp3NpMx9RhonAxg0gVSJCWFPVNn/GV6Ip1XwQscil/S5Qj9Jyd5
         mOuuZ3SAcXNGJFGUeySvvwmKjLGU+hr9fQSzfdlkmLcf95zvvz5+oqITHGr1APCco93b
         zm0HQkB+8MkNh55M+BNSd7UpFY5AcYOeynVZj1nW0m3XmbOOV723CEeyjcXKwh0U4qTB
         kGMA8V6F2/Rt68r81Ydl9NYwb1kr4c/4GE5PD3snJ1P/IP41HrDcoY/lg+SWyKNDd8Cj
         +PcnBpfWSoqnDLJprJOjkqWX2E/ktBu7HCCtqDgvjCHh7zV9uzFcPCu6Lrk9Jpkz2Zd5
         BiWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794311390; x=1794916190; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ieBvRnMfyX6acNHGZ0fpmazyXE/Jj6j0kfgwX5F7vhc=;
        b=OLL2UayjF3qHpWrSsh5L67U4QRIopN16Hqpfy5Fd8k9MDKgnBGQqs65UeLttv8Dbmg
         C34lINP3bhf6+KPcmsrt8G2/cShuI4dOC2G7guQAgtpaP05+mgD+C0gEBChaJoZ/v88s
         ZSjDGZlOBAKLeVltfobKtW4kw63ZoAy0YEX3akaT4X3DrkD8ZS9VjniepSbXusDhfxJV
         leJMQRha2U6q8AC6uFskLf8Hmlrs14+kdvolYB/wl0Z/GO/2yup8mT9xNSz0Ocf4X3hi
         p8UGtJ/aQCAE418LrLdNXFfwTj3xiSUfZKCRGJ9+fqivf/8PtsdMqgO4utlx9liYd0Tz
         OXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311390; x=1794916190;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ieBvRnMfyX6acNHGZ0fpmazyXE/Jj6j0kfgwX5F7vhc=;
        b=drYiiPFY8WEA49rSpgVihoSSKDrbi7rO9evRtc5tXTPivYXjxCvlKkSw8BOt3PcSl3
         Z8IELb7cOk/0INbLl96xSUtcvr3b8tZ39fyl2mN3PVJbtMnMYxr+p984mBghf0ZBb3r0
         u6JNQR3/WbBJOJCGD6pOLI8cDf+racXG1vH8Orc3EOjmprS5p8GeptTnBWiFoMNshn9b
         9S6ohU49JsofJX8im2ggxRm+TlYI9ICuRDWQRsHSUKwdHtyv94WG2ATdYPocaFS1tFv4
         OEs18FTBYKrop7FDICYyxAaf/KsdyMQSxCFd2+jKNIGrbReLkGLfCqkTY9iSBfOpJ93V
         Iu4A==
X-Forwarded-Encrypted: i=1; AL+hErF+kyQzXPFrFc7o9utrMQZf1c7GU0HpZVdzedC2/HTdxhSV6ivxqK0ASi0cw6dJoVDpiabNKYqvvRU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9EAzkHNyogWobqpYeAOgWQWM032vmSkfRhDYkFxMftCjBuCbeP
	y6M+ZRtLTrkloio8tMjldJmgu/q6ZDAbGYtTO6CLwzLoMmwV+EI1O2LVK2nVQqqnksSDSEUMQ9j
	zHAiRsXsTp4O4Of31rDQuwtjVsqjPQNvcDuz3yuDH5i9n/e8pM0d9nw4EtwNwOXKgx2fJJSQZqO
	MA4YLNa5IIhj6PbtruFWdG+kHKn+bnd2o2pUOdeRyKyAygZg==
X-Gm-Gg: AYBFou1yREypzWHg7YDzzJamPsArjTjQWnoEzSVqB2pE4ORfTZYlYZ6Sk7owvOFDfun
	V7/kXXaTc/Z19x7qZwoN8syWIGgoKgJtTEuEDTPBWQ5WFUP+l7uqemd+hBbdrz0jXsV8gdpjQO4
	q/2vhrCiUVJ8gSDbEEB6Cig8CJ8+nEb1uBXnF1bsHNa4rgTMxJD1gb9RBw1w==
X-Received: by 2002:a17:90b:4405:b0:3a7:9adb:2a0d with SMTP id 98e67ed59e1d1-3b1669f84c5mr2551050a91.0.1794311389504;
        Tue, 10 Nov 2026 03:49:49 -0800 (PST)
X-Received: by 2002:a17:90b:4405:b0:3a7:9adb:2a0d with SMTP id
 98e67ed59e1d1-3b1669f84c5mr2551032a91.0.1794311388919; Tue, 10 Nov 2026
 03:49:48 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179318778660.81375.11263258280496155344@manyhobbies.com>
 <CAPx+jO_VxJctXCZMVdzeq4CX-Ru7ACM6=wQ7GMdG2+4F1pOcBQ@mail.gmail.com> <CCF5CCC2-2C9F-4E5A-8550-B8C64CD7F404@manyhobbies.com>
In-Reply-To: <CCF5CCC2-2C9F-4E5A-8550-B8C64CD7F404@manyhobbies.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:49:37 +0100
X-Gm-Features: AclHuK94rNqkXJQ-LJt7eo296GzqJBUJ5kGEs9mLdz46FPtkzJbBx9mV1nByLpQ
Message-ID: <CAPx+jO996hZ1H+RTYeVc66PCvnYOV=m3PNY4Xjcc=+jdcBVXwg@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sunxi: reset the controller after an update-clock timeout
To: tam.do@manyhobbies.com
Cc: Ulf Hansson <ulfh@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>, linux-mmc@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: tSm3my41bs9EHWFQbF1ZSbz7GJ6laBK7
X-Authority-Analysis: v=2.4 cv=U4oHnuru c=1 sm=1 tr=0 ts=6af304de cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=w2OPf45SAAAA:8 a=EUspDBNiAAAA:8
 a=hraAJGsaz5TtD8VhunUA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=-iXIJKm6ftRzmWoHelNS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0NyBTYWx0ZWRfX40Z9Bj0YLT+k
 4Dg0b6Vt/VbOsVTcdoXeoUp1YOuE4F/d8581fxaq0eI8GBT7UIbegKxy8nFG6sfkuQBBy3vHiIf
 7IqTlhQxMBEWLrFygo9uXs/qjuJ2lDL4NqhF8qoc7ksiUr4Dhpg9g2ntewuaBwJVSuuErANJ14f
 zLqnF+tQNuEbJqMAqIy2MmpUvbB4OCpkC5p1R5Jsid3jk6Fehwiae1C2Y++PZyE870iuzmR83mX
 QxY1jDWWzEXZLiCm83ZDfpWl4V9GidRURpZx3mXVDElyW+NjbYeK3P+gn8ZhLhtFe9/1z53IYrh
 6Wj9ZQUNyjsVmjUDBCYuT7XoibOh8ylD3bk01Zar6jgqLHphsPqf68VTApbKXX4hk6mkCYWz5ez
 /1EgxUJqDSD3+w18tGkXgRFyALj13m3L6GmPb7eddOnZU04t3P+hGji9t8z7dN0SXBfnoyPi4/O
 vmK5/zylAYKmI2ZSKGQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0NyBTYWx0ZWRfX4T8w5VwF0kU4
 YvUvZLhQ5yko8DgBax50ZlKgSFynsm4n6rg1tnDsHbeZ5S+TMB3F2GXrjQINkRAvAmgcsb28Ehp
 Nbsbx1SK+PQSpzuX+iwFxDTqwkqRqqg=
X-Proofpoint-GUID: tSm3my41bs9EHWFQbF1ZSbz7GJ6laBK7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100047

On Fri, Oct 30, 2026 at 11:41=E2=80=AFPM <tam.do@manyhobbies.com> wrote:
>
> > I assume it's sunxi_mmc_oclk_onoff() that is being called and it's the
> > loop in there that times out. The question is then, under what
> > circumstances are sunxi_mmc_oclk_onoff() being called when we are also
> > waiting for the SDIO card to release the busy indication on DAT0?
>
> Yes. It's the first update after probe, from the MMC_POWER_UP set_ios:
>   sunxi_mmc_oclk_onoff+0x17c/0x1a0
>   sunxi_mmc_clk_set_rate+0x1c/0x2c8
>   sunxi_mmc_set_ios+0xe4/0x144
>   mmc_power_up.part.0+0x40/0x150
>   mmc_start_host+0x90/0x9c
>   mmc_add_host+0x6c/0xa0
>   sunxi_mmc_probe+0x35c/0x478
>
> STAS already reads 0x206 there, before anything has been sent to the
> card; on good boots it's 0x106. So the card is holding DAT0 when Linux
> takes over. These are warm boots from the vendor firmware and it
> happens on roughly half of them.

I see. So perhaps check DAT0 during the probe and make a reset already
at that point instead?

>
> The supply explanation in the commit message is wrong, sorry. The rails
> are up ~20 ms later and the command is still pending at the 750 ms
> timeout. From then on every update times out until the controller is
> reset. Rebinding with the card idle never hit it (0/20 tries).
> I'll fix the commit message in v4.

Thanks for the explanation. I will wait for the v4 then.

Kind regards
Uffe

>
> Tam
>
>
> > On Oct 30, 2026, at 8:48=E2=80=AFAM, Ulf Hansson <ulf.hansson@oss.qualc=
omm.com> wrote:
> >
> > On Wed, Oct 28, 2026 at 12:43=E2=80=AFPM Tam Do <tam.do@manyhobbies.com=
> wrote:
> >>
> >> If the clock-update command times out it stays pending in the
> >> controller, and every later clock update times out as well, so the
> >> card cannot be initialised until the next probe.
> >>
> >> This happens on an R16 board whose SDIO Wi-Fi holds DAT0 busy while
> >> its supply comes up during the first clock update.
> >
> > It would be nice if you could elaborate a bit more on what goes on here=
.
> >
> > I assume it's sunxi_mmc_oclk_onoff() that is being called and it's the
> > loop in there that times out. The question is then, under what
> > circumstances are sunxi_mmc_oclk_onoff() being called when we are also
> > waiting for the SDIO card to release the busy indication on DAT0?
> >
> >>
> >> Reset the controller on timeout so the next attempt can succeed. This
> >> runs sunxi_mmc_init_host() with the interrupt enabled for the first
> >> time, so write REG_IMASK from sdio_imask under host->lock, as
> >> sunxi_mmc_enable_sdio_irq() updates both under that lock.
> >>
> >> Fixes: 3cbcb16095f9 ("mmc: sunxi: Add driver for SD/MMC hosts found on=
 Allwinner sunxi SoCs")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Tam Do <tam.do@manyhobbies.com>
> >
> > Kind regards
> > Uffe
> >
> >> ---
> >> v3: take host->lock only around the REG_IMASK write in
> >>    sunxi_mmc_init_host(), not across the reset; v2 polled the reset on
> >>    jiffies with interrupts off. The return value stays unchecked, as i=
n
> >>    sunxi_mmc_runtime_resume(): if the reset itself times out the
> >>    controller is wedged either way.
> >> v2: held host->lock across the reset (not posted)
> >> v1: https://lore.kernel.org/all/179307312104.39863.1237281416347284875=
2@manyhobbies.com/
> >>
> >> drivers/mmc/host/sunxi-mmc.c | 4 ++++
> >> 1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc=
.c
> >> index fe4c0f6d73f3..55313780d06d 100644
> >> --- a/drivers/mmc/host/sunxi-mmc.c
> >> +++ b/drivers/mmc/host/sunxi-mmc.c
> >> @@ -322,6 +322,7 @@ static int sunxi_mmc_reset_host(struct sunxi_mmc_h=
ost *host)
> >>
> >> static int sunxi_mmc_init_host(struct sunxi_mmc_host *host)
> >> {
> >> +       unsigned long flags;
> >>        u32 rval;
> >>
> >>        if (sunxi_mmc_reset_host(host))
> >> @@ -336,7 +337,9 @@ static int sunxi_mmc_init_host(struct sunxi_mmc_ho=
st *host)
> >>        /* Maximum timeout value */
> >>        mmc_writel(host, REG_TMOUT, 0xffffffff);
> >>        /* Unmask SDIO interrupt if needed */
> >> +       spin_lock_irqsave(&host->lock, flags);
> >>        mmc_writel(host, REG_IMASK, host->sdio_imask);
> >> +       spin_unlock_irqrestore(&host->lock, flags);
> >>        /* Clear all pending interrupts */
> >>        mmc_writel(host, REG_RINTR, 0xffffffff);
> >>        /* Debug register? undocumented */
> >> @@ -688,6 +691,7 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_h=
ost *host, u32 oclk_en)
> >>
> >>        if (rval & SDXC_START) {
> >>                dev_err(mmc_dev(host->mmc), "fatal err update clk timeo=
ut\n");
> >> +               sunxi_mmc_init_host(host);
> >>                return -EIO;
> >>        }
> >>
> >> --
> >> 2.39.5
> >>
>
