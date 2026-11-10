Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794319428;
	b=cFXOD2xwxVqzQ+0EXAUY3OZ0d4454V/QmK6/URo2KSw/MBj5Ga4SigEgb0Z6UuPmB7W0
	 vhH9rIB5Ol7YTjFnKvod4QT9d5OPRVX5sMxnGcSqJ8YMylw+5qDmlKvZTQoujUtbbBD2A
	 oGPDyOhLwl6bCL7qEwLecSGDl1HtuMp3in8ZltrM+mvi0Ol3gvKjsAYbZBasAiuRJzcP5
	 3Na9Nqs9Uo+74xPN/mNlNmUZcZqoD+K1UWZJtGcURCe4WsEl4VBVspXwPt3+yPtYHJBCX
	 MbmHDqOHC5kG/VImmH62RRJSgax92bfQmSIlEnwDK8aYnHathbmK7yTgKUXTqPUPNWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319428;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=eW9QgbtxpFenb2Xuio+Mho8kGDi784dpzPo+qW0Dkgs=;
	b=VQ8dmFmSPO0eJ4565nMd0MKJr3pthIw7lBgYndEp3MrrcbtMGNZO2i9upjKT35dMtdbk
	 p5pWaR/+lPBMOfr3WakyopwYXyVB+1WqdsJj8/yw7hJ+x6j4pDoswpLCuvmEYhzD6AVHD
	 S+Q1y4taUvMraOBvq0ZgM21fFe4XZd0Mf9t/lKozUpI3i8+7p95uYWsRlplksIf0doE4b
	 p6er5dIZ70EOqQhuqRBMaMhrgZRLwB9/sKE4VXNJrKd3QpRwV+de9rt+IE6vTbZ0RyUyc
	 9sIeovPnvoCWnhuRuSGKl4DSwWpHoBx+BGp9qsCn74fXIFJ9u3OKpohi430w/FVydEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ONv70fdY;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bfNyTjGP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465AE606A32A
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 14:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 465AE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ONv70fdY;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bfNyTjGP
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABAIwj2688111
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 14:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eW9QgbtxpFenb2Xuio+Mho8kGDi784dpzPo+qW0Dkgs=; b=ONv70fdYmuwC7gLe
	hNGvG3biTSsv6ZNCz5FeNbhrYsOPClHdBTFNxoA4dvjBhlu3DwkbHje9BXZInOZJ
	FPb/6qAWUlxEY/VkuSGcNdPR6mxc9kCPu0lvPLLIMdSlmBdyGcXuG/8Yh8ORLDET
	86jCatsfz7GbNfu+A81gcXJeeK1FkDBHac6RcW9TRVJTU2ypgcFhPT6tGhA0nLaV
	zyfY4KpETbEJK3kqwo53zlU6PjQcmgTW0d7Qb8yJ7hgr/OGPinle4xRBpRi2J8dk
	VAhXhDbaHrlHkpGlFrRI+krx8yFzUlkAP5s+3M18UUg9KU8Z1KGSDHXCv7+TOiMa
	QX3lIQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huucp27s6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 14:03:46 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a073778890so1645684b3a.1
        for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 06:03:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794319426; cv=none;
        d=google.com; s=arc-20260327;
        b=SW09E4p8oinyCqYNYemDZv59a3L3VhPZQKkR5CAXy74VMsuyMkYVvGD08zSeUYCDTw
         WmHMgsyHhqIiyUQ0D7AISYrpXj9I+rzHERQEffEP6S1o+IWg4331GNZyHh/w7Tcy9J0x
         Wi85mcbOaMdf900mKQnXV9rB9dcL23Zca3JqCGnvHy95c0iOvZyI0slBf1qgea8d8T7r
         Ht+AZby038QrAXmKETDlXZW3ENQ5LFkWYfylk2pJnlWjbgspQN8jvtADiEdqxsaktOfB
         UbZIBzuuM7ZY4o0KY2JZLhKO2/mdj1Cy5+hn9eTwWo3uZFQYuYAidsjj53f6cD9W2yLM
         NcHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eW9QgbtxpFenb2Xuio+Mho8kGDi784dpzPo+qW0Dkgs=;
        fh=XhMOVsRs/Wn+skWpoDUvjAOKa7QSuPpH691F01/gwms=;
        b=qONdKG8iza3XOduG2kn+cBcZa9cIxVpmZxQrfUBD2A+tF2NmSi9tbJUf5/jXCVpr7j
         TEgy1H8Qaz+3f1mo7ZI1IVVHNEdo2RVoBfJXHLmE7QJ34H5Gh+O9ogZYRUg+OwQwi+YI
         nysE1x+6x5xFZScM8Rq/p/8QOfi6D01bNawrpkLEn5RNNOA7lSY/AwmXLgk02DQfgs+Y
         D+rgYjXsFF3xy5w1NZy2c5w1sZd4nf1R5k8doavcpXmNmCVS7bqZH92DvPedyoc3bak8
         rzbXwHtoHHJG5IloN+YOfs5X3RWZccitnAOxOKApPrUZMaSQsKOeLaiXqJvV7fSOF2DV
         1ZTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794319426; x=1794924226; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eW9QgbtxpFenb2Xuio+Mho8kGDi784dpzPo+qW0Dkgs=;
        b=bfNyTjGP7FGkSolDQAJsFftk6oUly4Kj0/gvV976Zs7Gnn+X4Ucgf6kxkgWhKozd6T
         EG5YW2p3MMOXOG97QajQdIBT7o8U/dfzINvWNF9W6HsQHHWsctayadAf6LlHpXw2eAsS
         PbtVE76Ysdg58/T3q+KZ6uoHFnSAnIkWmds+EuevRYP307U9wZuu1wC8D7gos3tchlUU
         LhP1KOkQlHmaLHRshjpZb66oxLYRPBc1ow5QCEjGEff9/BTgzlIpkFPvS69yBHAZJWyY
         eZi2dQx9k83QbJDaJ8Ppwn0gov+JqpRkFtxi9S9ezwzMwFgyX9CSWb0RTg10YnSkENeK
         zZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794319426; x=1794924226;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eW9QgbtxpFenb2Xuio+Mho8kGDi784dpzPo+qW0Dkgs=;
        b=0iPwvKqSVd8dGVmha8zyXhLp7EV+Gem2LfnNT2dLr71gL+rJ+r1W//GBk3XEbyZRFQ
         V/dxW7MMDePDlRBqpo5cOyOGQbsWSJp+Rs2OcqjnwOptP9FexbCAIvpxR4DzKfeZ+zJ7
         kA/h/qtYWCoyfG2aUKEVoW1zkPy4ryCmFXJQjQ5A2OYBZD2K/7pBBGkcHA38wmOgHVNF
         IDcMTelPSPzbsljLL2XYzK25Tll6QUmG1awO1PZ1FpR28aGYSIYZxnwgoYUVVA41gMDW
         iSNoVmSsMlVX/sOCrP1TgskAYjOsionL/PBD3T/KvI6o89Uah54whLW+ZshkELOOpnn7
         wCiw==
X-Forwarded-Encrypted: i=1; AL+hErG//AIi/52NVvneeHfvjJYHFSQtrQ3CmBB7+oB4362Sg2PpQDUPvIBVwBjjj58GOBbUWnT6jxoAylY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ba47llvgAXZWI9JscDybYM0Vdlmnf9Kig2YwEFQOguGxOgAqP
	IxTrmXKoR2X/jRKI+wgFGSLMZ5XC3QyaL7j/y6tL2PTM4J8kHfgOR2Uhd10Hs2ZqD/cI5KMQVbq
	cjm5RM+OLrNkXmcyuxN4Fcz8k2b4RiedBMvl6kWMwkoQFVUIZt0i41o6sll/XzUP13tXQoqARHR
	DrLzye7Bkiy7maTofHvMdxE7sLUC8dsASAgx/Q6A==
X-Gm-Gg: AYBFou0l0jzYArsG4cxkS8yCbrJOzrXaSWIkBITtpgj8yhvrKcydI8d+aOJkRgExRDY
	PXKLwn44YlV+vTKf6J49I5fXrJr6GOkHIa4ZQpfk2mKGRRH9DtAwxtexJVGeBUnbUVX+2q3+Eq7
	1MxdicSzHIINYAUgXY+wOEbXsEuCbkoOu6IuCL5QOpweS9Uv/Z13y8uPBf4A==
X-Received: by 2002:a05:6a00:6ca1:b0:8b6:d2f:72ae with SMTP id d2e1a72fcca58-8ba85beb73cmr3272958b3a.18.1794319425524;
        Tue, 10 Nov 2026 06:03:45 -0800 (PST)
X-Received: by 2002:a05:6a00:6ca1:b0:8b6:d2f:72ae with SMTP id
 d2e1a72fcca58-8ba85beb73cmr3272926b3a.18.1794319425035; Tue, 10 Nov 2026
 06:03:45 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101063719.88570-1-0xbeac@gmail.com> <20261102022924.51343-1-0xbeac@gmail.com>
 <20261102022924.51343-3-0xbeac@gmail.com>
In-Reply-To: <20261102022924.51343-3-0xbeac@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 15:03:34 +0100
X-Gm-Features: AclHuK-5L0KYD9ovBXGAlqHD1kaxFR6Mtt13RCglbut20l15QL3duMatRWXB27c
Message-ID: <CAPx+jO-PqVt4+16K+djf6G90g3WCg0apXMFUWRMHq3o5xxqvfw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] mmc: dw_mmc: cancel the watchdog timer on remove
To: BeaCox <0xbeac@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: qdjtF3ajozN6trihBM_s8LSlbtMHdh5b
X-Authority-Analysis: v=2.4 cv=U4oHnuru c=1 sm=1 tr=0 ts=6af32442 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=pGLkceISAAAA:8 a=ECCTn69UPDZ9SOPRO4wA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1NSBTYWx0ZWRfX3ooE2BJ9jiUd
 VXnQIVprZneMuP2DcpaLZ47avPOof9wOUDmOw+s/AWH6IFWZjkAHqRNVRxiDy4x1gbM2fp0/zR0
 ZC2l2xSN+NJgLZVirV9Raee1XGyNdKB7E16LnTSs0zVsCUHZakjRY2PGzS9bsIWldVttTYYTAZf
 kvn1Ndcp0f3mPPXuIGYiIJWiS/WqhNnxJ1/QJXbYZ29gktfWXWenqeJQQJmXUvtvszTZK4dGn3h
 HUv8C48MhdNFxyl0MbjyeyK9OYaCIck3wX/rURKI0+O4/GVV/HluoNqFioJZ7AJZ0iDCbygw3Hf
 YQkmbngZ+G5GFZFoPLHwxqvPaCPbzuEmh4ABLrQTJr3m0/rXdnGnomKRFXbXAba5l/XrHOrEdxl
 /TAMt5AnwpNW43lrGFgKdxc6uezUKaq/UVPDPGyqm3VWC0cXQKw+2DcbGV/1i3iCR5UvgLrBNvt
 vq9/EBekfXMEhxXQ2zg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1NSBTYWx0ZWRfX/oK8kMdsG38r
 rrEtGcM0WAs4i+CQfpK1M1omTRlhYSB0zyYa8CcNCkXaIlX9rKLAlEOMFQYrBKxBMR66Uz4sz17
 iRb3yJEgggVn4ifl9hAL3Oa9OCMAIOQ=
X-Proofpoint-GUID: qdjtF3ajozN6trihBM_s8LSlbtMHdh5b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100055

On Mon, Nov 2, 2026 at 3:29=E2=80=AFAM BeaCox <0xbeac@gmail.com> wrote:
>
> The central watchdog added for command and data timeout handling is
> armed while a request is in flight and is only stopped when the
> completion is delivered.  If the host is removed with a request still
> in flight, the timer can expire after the controller has been disabled
> and its callback reads the controller registers and the host state.
>
> Cancel the timer after bh_work has been disabled, so that a work item
> that is still running cannot rearm it after the cancellation.
>
> Fixes: ce0043b9a302 ("mmc: dw_mmc: add central watchdog and convert CTO o=
nto it")
> Signed-off-by: BeaCox <0xbeac@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 5b47643..dc3beab 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3410,6 +3410,7 @@ void dw_mci_remove(struct dw_mci *host)
>         /* Stop the work before the timer that it can rearm. */
>         disable_work_sync(&host->bh_work);
>         dw_mci_stop_fault_timer(host);
> +       hrtimer_cancel(&host->wd_timer);
>
>         /* disable clock to CIU */
>         mci_writel(host, CLKENA, 0);
> --
> 2.43.0
>
