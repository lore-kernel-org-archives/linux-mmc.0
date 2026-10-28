Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793202404;
	b=YEHpkwSM6aszrMEKwpdKT5uZ5A3/DJEPMEmoH8XxunYh8D7IG4Kudi+CEPcNC5MQiLBf
	 W33boCrrGeYSymJdRDjCdrQRW+qFMmdvAnZJG7BX/EnKlPMjVNRJazbvs9m+9E9Y+m9ff
	 bjHjVpMv0u/6n/dJshMp10EkRkh6H7/C6x4EyHtAc3MhmjQ/WOeFw99+IqoVUQKMz3iFO
	 khhkJoHe1SOoq2e0ReoCg598Btfo5I6zvIzmYVP8GsWliE59D2pYVy1eYruvfIvvwz6n1
	 lpL1viOzM3c3+SUo/6ZbAmsYwDPaW3ep+Ezt6+XH/DhoQRPUQtceSg484pQc5ljK9iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202404;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fwiuAlOdFTGp/YuVBPPn/7K+Qfc1vHtLmay4GmxRG0s=;
	b=oxKdm8i/+IEKnOLhI1wgnNkphMQLsISieIU68y2y/wOUQRpvrsbHJNbenrBvhk53yN+/
	 0lvesITcjw31m2xraCZMSIdcMDHn8XSBHLXQfVXi4WhU+puIOZPBhOIQjdYTCIRmEGB7c
	 RoKmkezKmagG9ER2fKhhP4IXpWXlRUT1+jHYaQ2TyxMrotpxyFdhOPDzGlAAjqjqfRQef
	 vcpqFdZCQX9GSyQ3jVArJj4bOIWqwYlkLF4kE6KzxhIr9S5s52WdqwCjCPxskHL4HpyNb
	 mT9IYu81EGMSa2RiChaUw/0gfx5Eu6H0sAsA2sqT6BGGUc53roymY+kZj2R0s5jwClQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="CzHN/9NY";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CutEjGEq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EE9606A326
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 15:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71EE9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CzHN/9NY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CutEjGEq
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFA4EA966546
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 15:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fwiuAlOdFTGp/YuVBPPn/7K+Qfc1vHtLmay4GmxRG0s=; b=CzHN/9NYubbu4SRm
	sg12XjF91bR3Kypm5P/Xx4aA7eiqYE/n1TgN3/1+WTVYOzRs6TfyD+UApV+p4oWk
	ZXIcziOnfTEyoTUSdHcNkDL951Z3rl8yfPRLeKmLfVI2Kb5KmCXSlKBJibXegdR2
	F3SKi/GNJUO+3G+A8Lr3hFgpIbAASRmTx7mR7XU9FB+UypZJmY5vgsPRLN3tDXI+
	jdqY54Fnlz35kcg+brkp6BMB3xG+Qqp9B6IbR+S0w5ejCFO9JzheTYt5wpnLYjrY
	CfQl+KE4kZiciMnPpvQyUzwkjFzUfO1E/Ak6WGcjCoKQGP+M1GptySatT8MGqPfa
	/rElhg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkhtjgp9f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 15:46:43 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a08e315b5cso511862b3a.2
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2026 08:46:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793202403; cv=none;
        d=google.com; s=arc-20260327;
        b=Hx2aI292TQThwoHpCTRgxHSLLh8D2wa17WnYuGUfQY/cyMp4ErNkzcimbWAgVTv+gT
         9rqQHmiH9H1BOhq0RlgkH0eia5hOlKiy8vuEC7Ik+KOYI8y553NLvyatP74InF6VQYZ9
         s8zdIjpSY4vO4KzDpV1+gCh3dPkGxgyJKhJLQ/6YitR3cSyOL6ZXe/JnMX+KnT4+hhJS
         Pdhe5cMllWzjLSXd/uiThXxjCJldzsNo+Xrowc7bT0lZyx1t9o0t0/4zyRAet3PBZGrF
         6shUWeiBb00FBlud0WJLlm7zivlfvG54kMyDJgPdzY74mRrHdUJfHDxGWvoVNz0u9YVu
         MpWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fwiuAlOdFTGp/YuVBPPn/7K+Qfc1vHtLmay4GmxRG0s=;
        fh=CRslS0a15ofOrrxq/HGM97F/v75PYPBPa0Zr2ZRphno=;
        b=duvJVR3byOCqPJSffA54kaBZWKcVDtnyQJVfkY3sUzQZTmZpV94HpqNTOJKqlRbzqK
         j0U7SEdaKOCyTtY8roXM9rWaeRsWXO1X1Z+kuaYieFYi+lVackKtamSddLw0mC61JPyk
         CIVjDT2aPFs93C99444wq2RPENjakMcoOESqZYmperfWUVv6NOAQEtX8ULt/4gM973a7
         ptBTTy7l0cJThRJQlKc1pRZ7G1q5pvnudvu37bANrg8EjWydlClfonaLDW5z9rjRcxxb
         yus/rr2B8ClO2FW9qWz4VHYOtejSiOV+PiRNHWUvSrSOv6BFEb5wwYHqhcaDs7nMkMLb
         iIww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793202403; x=1793807203; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fwiuAlOdFTGp/YuVBPPn/7K+Qfc1vHtLmay4GmxRG0s=;
        b=CutEjGEqdC0k96wPLTxqNCK/UrVb7RRy0E9O9NRcD88WvtDMYLej7qRvcFFa7EtQf0
         +v6bPzZdwxYPbsZuzA+4PsuDiUp9QdWccH2z9oHPlbJtR2ixUHMYJ+1QOfam25rgcWRm
         hWgY3UHunGRfuWUxknOiiOkyfYFRxujq6Y/Ukl1W1NTaiCOFIbafD7p5Lcp8SGL515Bd
         8LyoAxmRkFUPSEmDGUoXVUW6zhuWunOvriZEjx+yiK6MQT5wbde0VMgNNAAoXbOieM+S
         95X3OQwQUsYcvGrhlrSEhb4LNRNFB3zbKlKeV3PAftJ6IFUC/TghhgBk8ad5LBFETDW9
         qm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793202403; x=1793807203;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fwiuAlOdFTGp/YuVBPPn/7K+Qfc1vHtLmay4GmxRG0s=;
        b=qM9GDj6MylVUIwJgpumUKAc7+pn0Yo5fILNR4ZTOpvg3otKI5IaNFxRoin7i9uPQiv
         CCTL2iVOOeoD/ikAMK8dj/RFHqSCwnvgMCh40sqUGL9//UHmvbFIcZSxAkAgZIkjnzPX
         vJ8Cz00wukiJY+1EFEttR2GWtZBrSZiyeZDausjRdqQEXfz3E9uPYJi1P300UfJvHEbA
         z1FWWvCQLaHG0N1I2Y3K5Yog0ZeL0+QNJD7y+uaQfoURalk7sPLvtUTLY8gsSsJpp3m5
         9KRewdZsOouTE2Vi2de4Tn36OYt4yiaHI2SiLDEsRUeC89Odf1qVoLslCXSizKwcYoOT
         Q5DA==
X-Forwarded-Encrypted: i=1; AKwUvBz4eVa8xcpxvpObP/7zVM75kREgmCCt44TQ2GdCakCAZkIqSSTroTxe112FZMO64IskhsIDWbrUMWY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9MG0M5KgmzE1F20hKJlDwjAfF9IZqDieKPXiUWWwwnWv7EAIl
	QJq9eKVj9EVmzzQt7GCsEZIm60p8eWl5cp7bDMA5MezSWvvRyREABsd6MBb3HRRj/gE4fZkfbca
	nD3L/S9T74r6qsfMHMAKHRDDtfbwRS9kXJPv6gKRhhRv+76QxPV6r5PQB9BYhvWz6cy33vlMD8i
	a8DzZOOORjIvLAm18sIx8u5/hJC6f1NZw/v+x8TA==
X-Gm-Gg: AYBFou0VjGW/Qb76jdxCdQOBDQmXbxAcJ9HfnGdEX1DsdWJ2+NRqAmIeTR/TWGZvmcz
	gu9yy+nOjNOJaKigkoGYktP3gTJLeScz2CaG6G7x9kaoHR4ElT2meETXgIihCJWIh8Faltwt6qd
	PQkMgzQNpDpOT3ukOqySPJCedL109+MV4kb+ZNPhq3jjuT3OKzAvVE0q4pnA==
X-Received: by 2002:a05:6300:68c3:20b0:3e2:ae03:b296 with SMTP id adf61e73a8af0-3e902356ac4mr1512114637.37.1793202402963;
        Wed, 28 Oct 2026 08:46:42 -0700 (PDT)
X-Received: by 2002:a05:6300:68c3:20b0:3e2:ae03:b296 with SMTP id
 adf61e73a8af0-3e902356ac4mr1512102637.37.1793202402494; Wed, 28 Oct 2026
 08:46:42 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027144051.249211-1-ulf.hansson@oss.qualcomm.com>
 <20261027144051.249211-2-ulf.hansson@oss.qualcomm.com> <00b63b4f-053c-40cf-82db-21a86fc485c6@kernel.org>
 <CAPx+jO821-wULVT_KbZB4oaPSYAHi3PEpM0VzvSL_7NBns1t_g@mail.gmail.com> <CAKekbesRt5qDOf76MBG_8hROMa6Z=UCNdXHKoE=5u3xFcznhhw@mail.gmail.com>
In-Reply-To: <CAKekbesRt5qDOf76MBG_8hROMa6Z=UCNdXHKoE=5u3xFcznhhw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 16:46:30 +0100
X-Gm-Features: AclHuK-2LlWhfF6mpZVFoUdjCSzptmHG7wqFx-5auuefVL0ilircgV-PNrHI89U
Message-ID: <CAPx+jO8F8fxPGgCX-HVQT0D1irZprUgcfVtm_ABS1M+7s3LE6g@mail.gmail.com>
Subject: Re: [PATCH v10 1/6] dt-bindings: mmc: Extend keep-power-in-suspend
 beyond SDIO
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulfh@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2MiBTYWx0ZWRfX5ic9zOj2wzQR
 0Yv0N3/3pc84Git9ODuu6frGqpzICGjmIB5U6EMuu8SPVzzVVQoIWKoFr0sRL3Ey2B+bnnOglRW
 0aUELzSs3vletdO/X8ONX5IH4FnGGFpS8bVcXq0FFvZp5O2IIcvjpH+mCKigywrM9aj7US05EMG
 YlyuMRBXgSiGc8KyuZlxrXnhXiPmBQW8dxWfiiNixXOTH6MtSXcA1BuWJGW2l53yr9KPYZhZ+l5
 vDBQ1NaAZTyPX2mejj5pq5zL++yGkdLQqU0OcwS0l6owpgC368ro0TF9A+VnclzUaNAbzV9+BDc
 20vxRfyYOprJl1uPjJuG9vUjYQm33UDbuDVV0WrXyJE6pqsI9pTGKOsH75ps6omb6n+NqRaYVfK
 lZmv8zdHl5MynlaHaoXfvNhqv+fBydcF0MgA4oWRiict/pWan/ZEKDVqqrA1YqjS4jRZSkU8izF
 qTz1tRgtdi/naLkr8WA==
X-Proofpoint-GUID: dRC9wWnFZMJX8kp63DOnP45sDtQkeVkU
X-Proofpoint-ORIG-GUID: dRC9wWnFZMJX8kp63DOnP45sDtQkeVkU
X-Authority-Analysis: v=2.4 cv=LdipeTfi c=1 sm=1 tr=0 ts=6ae218e3 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=Q-fNiiVtAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=VJCnStefonsj0tF54p0A:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2MiBTYWx0ZWRfX7eLNVZ4D2wzA
 z1ywPPRrubYbwAqu6GnrlIKp+oUA+I/7QJryYFRUSmieSMNwTQULNZjDAslRwLTq451i5HWG8dv
 4R5k/A8KcHdzaYU9zASo3MhgVSqpY4s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280062

On Tue, Oct 27, 2026 at 9:31=E2=80=AFPM Kamal Dasu <kamal.dasu@broadcom.com=
> wrote:
>
> On Tue, Oct 27, 2026 at 3:48=E2=80=AFPM Ulf Hansson
> <ulf.hansson@oss.qualcomm.com> wrote:
> >
> > On Tue, Oct 27, 2026 at 4:33=E2=80=AFPM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> > >
> > > On 27/10/2026 15:40, Ulf Hansson wrote:
> > > > From: Kamal Dasu <kamal.dasu@broadcom.com>
> > > >
> > > > keep-power-in-suspend is currently documented as SDIO-only, but the
> > > > requirement it describes -- preserving card power across a
> > > > suspend/resume cycle -- applies just as well to any card type. Drop
> > > > the SDIO-only restriction so eMMC and SD platforms can use it too.
> > > >
> > > > Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> > > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.=
com>
> > >
> > > Incomplete DCO.
> >
> > Sorry, I should have explicitly stated that I will leave that to Kamal
> > to contribute on top.
> >
> > Kind regards
> > Uffe
>
> Hi Uffe,
>
> No problem. I'll resend the two dt-bindings patches myself with the DCO
> fixed and the DT list on Cc. Do you want them as a separate two-patch
> series on top of your patches 3-6, or should I post the whole series
> as v11?

Okay, I leave this to be managed by you. Please re-spin the whole
series, to address the minor comments/fixes so we can get this queued
for v7.5.

>
> On the SD wording, since you plan to add SD support too, I'll keep the
> description as it is, unless Shawn or Krzysztof object.
>
> > That said, I was also thinking that maybe it would make sense to add a
> > sysfs node to allow the behavior to be controlled by userspace.
> > Thoughts?
>
> For this board the requirement is fixed hardware behaviour. Firmware
> reads the card at every S3 resume, so the card has to stay powered and
> be reset each time. Without both DT properties the board enters suspend
> and then resets at resume, so I think the DT properties are the right
> way to describe it.
>
> A sysfs knob could make sense where it is a policy choice, for example
> on SD. If it is added, I think it should not be possible to turn it off
> when reset-card-at-resume is set in DT, since that would bring the
> board back to the failing case. I would prefer to keep it out of this
> series and add it separately when SD support is added.

Ack, let's have a look at the changes for SD later on, on top.

Kind regards
Uffe
