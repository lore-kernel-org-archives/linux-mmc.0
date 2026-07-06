Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB69B430CE5
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352852; cv=pass; b=fKPqAvmPk6Z3wTbQNisRRXN7QGaYEj762cF+c86urD/+pEI4tpMmdyJqXbjv5188GGJEmozF5uaVs0+WqU6NCsYQxpIrc4daEOxrv+jsgEwQovw8+K3zilfVzZoi/+rDTQjFJc4KCik+e0rQniiRak3IKBxcIfIVWdeBiB0vSSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352852; c=relaxed/simple;
	bh=5SL2md4OQZGbm49ZCj64WSxrlT0r0tOUOoqq11+bAlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSIR3VT6aXHt2juoaRRQKqQ7qCh/ysN3xpAjz6qw+6PN4f64d+zx/4Mf59nPB0qSiq1QkJNS/YZAJ7M2Qxujrr+TqKhLE3+uUmA0rSS2GlzXuvYivwNREDNy3mDT9QCjPg1AsHeHCo0gMHMXYrj0gNNn0sUm5E/nVFsSs+uWq+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BujUWBQX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UG7W5I05; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BujUWBQX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UG7W5I05"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FFCEx990326
	for <linux-mmc@vger.kernel.org>; Mon, 6 Jul 2026 15:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RjLMSt4c0aZ0zeZBlfMyW7PNRrgd10wR6yVN+A5/CDk=; b=BujUWBQXfhgepLEM
	W//PtSewGtM4jt7670bBH0xiNKk+A2cLFIV4n3HQl517nIY90lduhCgZrP3yfQES
	PgIgSu5ESfPWfyDaAutlySueiS8SKTvaqYErN1VpZv2fZj8p+YzqFEad7LRMUs+B
	nQV5tDStS9+rTiG9liIqF7blX6Tk5peIJMyf/3Zzol5bYWMw//pfdSsDXqpSQghe
	5aTfzG++3lV8kY7S/RasVT6WXhL5LhEdRmiGDgZxki4VmZkPq/NunVulzOnBU8De
	GCUCHqH98vW6XatSFxEFSp7lD7lvlfyjDMTA6ozkSKq1JUqq/lg8pvd0AsATlRwQ
	7MpbRw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gskct-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 15:47:30 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8fc92c5373bso5162306d6.1
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 08:47:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783352849; cv=none;
        d=google.com; s=arc-20260327;
        b=deRXLx+Lbwf+NPT4Eu9FPehrJ24mWOXzBR6AeLqLhX5zUolwRhCafuHYtoSufUpNz7
         jyo5auo6YNd1HA57P4XclCsDStrItM8uzJUgBVDSZZDmrRtZsJfyjLsjNkdGcuVEFU1c
         oAJ+2kaVsoUzN1ZvWx66H1mXPoM1BPnNv0sY6l3nALihklIfABv5WiS3SD4h858jOC58
         5NRTP0QYaprbUak9CW/jC5BG0Cy7/4UIDtlqkZ9fwEfnOETFuhv7quIsF6jvEbduNmVP
         6mXcNOLWHFCZJiuZTld0hYpTUkIjpklI17psY5meEy/K17g89w57A3jtkZ3rmyyUCdkU
         Xdgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RjLMSt4c0aZ0zeZBlfMyW7PNRrgd10wR6yVN+A5/CDk=;
        fh=zXwGTKkFGhy30nJClj2TUy1kJm9UVUgzRAtAVZ8yP28=;
        b=oprF29e+9AqIrhC6IMCT0emKYjrUoGpe3KPeBel35mLgGnWu+tz12osvKHRvywuSP/
         Ji+oMcRpn9e2xKcVFjeLUkhwSNnnoveP9W/1yBzwbwnh9vxh7Nxci0bgggACYP1tFcX8
         Xa3HX11RomI8dcYCfB1AnCyzQvYJ8xmAmIRNeJQTr7D6Kek1URjuNmMqJril/6gQUMCs
         hEiOCu+t0jhTJGV7g33McUlDpuM76be4bDXp2sCNrEFnMhFNTGjHfsWJtstPsO/QflV4
         6jbfju1BFLMa0XgBqbrqSwEQN8xvXbizPLTsbwSGlfK/xK3jRQz6YIoGc/MAp+76InwH
         SKYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352849; x=1783957649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjLMSt4c0aZ0zeZBlfMyW7PNRrgd10wR6yVN+A5/CDk=;
        b=UG7W5I05F09ZC2aQJRbe0HcZx3GCIW7cuaBfA7GDzmChi96G9Auq+h70bd5K196LUD
         NTNPr/K4oCnmJ+IkT2EhTBSryuhUWhj4l/5psPI0FePKkehaeCnQgQbceUvW12SeNa8P
         LWdy2+BjKEIu4bkPcxY2uvvLjuTaTHKCfl46mDuumsln+5bmLpKuOUlt+JjNmMaDK3Ly
         xclK/nkxfQ9UKwI+cfZ69l3jRDtdkCo/pouBgfgeuDsZPqILWfYKszvO4jAggA161Mg3
         GdR+GG6NO1UJus7DebjkIVcDX4dYW/c+8piJ2HuYgDpCP6a8em805otGrSO0Wf/H6NtK
         8TdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352849; x=1783957649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RjLMSt4c0aZ0zeZBlfMyW7PNRrgd10wR6yVN+A5/CDk=;
        b=niy85s7/+dGQwzGB5g6H73kgIb3n/ZXpx6W3yhhSg5WBrV3RxXJE3JVCRCofmlzRk+
         RUMyCE1GnsM5skOoFxu/sB0tO+fsArvNfzTH/OLzDNTFvuW3QyXe6K7g+pulJ2ukhu3Y
         sd3gMIc5pGVlICQZutXj9nRhph0NIvH2VZeDFdrP0RM4fPIYwKVPa6LI8hjl4QsuS9Rg
         QK9ky3vwvYrLPO6wFxd8TCaorH081o/sPa40ZebSO9lXiGlP4D0Opeb8xZmjtB6FVu6m
         eY2Pg6Qi1t2/v1ZJ5LgMNLju2VN9RnqGwxNcalfmReSKGK2WX9dzx3z+LGx9wLETevKi
         I6rA==
X-Forwarded-Encrypted: i=1; AHgh+Rpk+ZZHvlS75VwJ15c9oZ3psrWSpA9O1kxBvVKWax5MrhxF7x7EHkuG6ID6AgbdoyWY1We8+/1Jx+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys6XDVhrrZAyboO+scqXyTY3EBRoCprwqQA2Tmx6WHaYnupVbz
	CgqmP2JL8yl6t4oyerta2ZczfpjYOtr6mSDzYfzPhUNLJdNubaDXHmZTgUToYtVOpqUFFeIoTxO
	gnC6GLfojfiX77u/SU2gw3esEIvY6HJT3jlNUhFzS/hPIx4Q74m5UFGPSX7OGW++dFCNWY9ux0+
	MzirQ/t1QOrLtyMJ7Z0k0o2rw3l0MTbzj2taMESA==
X-Gm-Gg: AfdE7ck6vGEVQjITYKSC528KR3BbDIja56Vs2B1txK+Ysadfp45nFh8b6Su3yt56XoS
	T6kcl5RAkhlVHJ8W0iv3Vltym7gpahdv0fLiJtOAdBWJeYb3xicN4vxOM/0hTO5GxZSYjlAEjXn
	LgDCXvAZRjDYpo5YqV3qI8B3OxWbDAYhEHBkZZFV7ZRatf45efGX0nBBGz2Sok5iHoPkux
X-Received: by 2002:a05:6214:5701:b0:8f0:11df:c80d with SMTP id 6a1803df08f44-8fcb56c8c27mr14492966d6.42.1783352848890;
        Mon, 06 Jul 2026 08:47:28 -0700 (PDT)
X-Received: by 2002:a05:6214:5701:b0:8f0:11df:c80d with SMTP id
 6a1803df08f44-8fcb56c8c27mr14492176d6.42.1783352848267; Mon, 06 Jul 2026
 08:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629072510.1451480-1-inochiama@gmail.com>
In-Reply-To: <20260629072510.1451480-1-inochiama@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 17:47:17 +0200
X-Gm-Features: AVVi8Cc2o5wmqqwP6WAa4eERJ39Vng2LTKJ3DlSxXYh2z-FN2OTV4FaTwD6BR70
Message-ID: <CAPx+jO8p78hiqUzn0gVW5Anhf50+uxv+mF-=0oxZ0JH17MiczA@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: litex_mmc: Respect the bus width request from
 the core.
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: lC0YBxxzUc2fAIxa2SZzm44EE_92HAN0
X-Proofpoint-ORIG-GUID: lC0YBxxzUc2fAIxa2SZzm44EE_92HAN0
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4bce12 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=AA9L0ANR4eDklP77:21 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=pGLkceISAAAA:8
 a=BUNTHcs_R81oLitWRZ8A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX0UQkHzdJpWPQ
 IyGsvU796ITxKowtP6Ltntywo3PbRic7rxh0HcVgIbjwhkogUlPV6lhXyvY+NXh0lQjxp505oGZ
 tiP0ORXgRM36itP9gqYzSrgSNZsK3ilJtnd7OuCNpmTVzkKvYLi/Ks0AEhTNhKOZjtIgNLMM0vf
 xCdTj74/R5AQkqjqYZq0ubsyLgF2U9+DiuWZnmsYDRnNm5B+fJvtWcoZ7m5cvUTM66ckvWuYekQ
 RB069qzp+JlBG4Wd4+4XpGshkSfYV9LzBXVbP89EGs8tD2ClcNv+TbCx6KkAD5AhFEhBq0dBqrs
 X1eI7H/zSb/QuSATkh0hN+XehOKnhNIR0xCuQRhEvWD1eOD1CX8VOWKltAFK+xeZrwg15KRaZQp
 HFFk/LPpsorIrj1X+6e78S1IParg2wASXlzuc1OjFOldahFdV9XGa39PQkFzSiFLx0MYtP9mDAO
 EKYSc3fMuKwZ3XKU1Xg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX1KKP7nQENTOH
 mlJMI0PjGgEfysVPEqwM2ld0d5uGla2pSknm+AdEznzJVhjC52rZWj/3Zpt4/lPk0FZGzyvAXwA
 IW9Fyh4+uA9qHSwq53MRHAHPUXNtKHc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060160

On Mon, Jun 29, 2026 at 9:25=E2=80=AFAM Inochi Amaoto <inochiama@gmail.com>=
 wrote:
>
> The litex_mmc only forces to use a 4-bits bus width for data transfer,
> however, it does support setting bus width. Use this interface to simplif=
y
> the litex_mmc driver.
>
> Inochi Amaoto (2):
>   mmc: litex_mmc: Set width from linux request
>   mmc: litex_mmc: Remove unused logic for the fixed bus width
>
>  drivers/mmc/host/litex_mmc.c | 131 +++++++++--------------------------
>  1 file changed, 32 insertions(+), 99 deletions(-)
>

The series applied for next, thanks!

Kind regards
Uffe
