Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52313A9619
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352800; cv=pass; b=SW1sJnHNZdGzzqilvqfejYpUmZpQ971xV0YAsHLupHbM+2L78+Hljwa5229QeG8wz3gyhXtwxbPZW+nMjeVure6THoDor+RgJH5Ysx3oKpf1VL5VKzGilB8ypXU419GW1GmhinQDlYAZGYi35Zj2i8c70AbgmzQVYIqQtb6iFzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352800; c=relaxed/simple;
	bh=HHDHrD9npaabV/VhjSkLWZejZpE5aSOX46OnTYhCwP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovJwRyjosgRSIDkv/9NFVk6QGMLMbqo78rXzD1KsmpErHKWuFc0/VSid1rlw6ai8dx7ee6BF85hgMU+hDTvTO3dlUtjFacYifm1p5SiphC+Od3TEqq1iAYlioU+RmEA/etvvgySJfIj5nH/J29/ZvkbRbskCaWoRhlPB3NMKJqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n6LNx+Rz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NMGjiZmm; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n6LNx+Rz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NMGjiZmm"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF5NP956860
	for <linux-mmc@vger.kernel.org>; Mon, 6 Jul 2026 15:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5BsTIZAx5natIEWewyifBKbCaxJSzKUYtpPIxXtNaJw=; b=n6LNx+Rz4W0oWRWM
	xTNb9nJsHe3bTV7zvAU0DU0Ds6BWBMmBYp2KygG0CsMDICfBcifa96PZH+SEfgMG
	4mI8Yp28jPketsYHbhQQW7u7FPqgg27eAlV6FJzh4UQG4mD+G+ddlVEc9PEiF76/
	ZxwNqawvGpNeMx4eOhAb1u4CKvNOhGwqYGtW/z15xKKjBnpJvHOy3vx93t9ZVnuJ
	KJrxqEmMJrntbvzmanDub5eNL51tXtcaGa6dnQyBLM7q3vee5rQyJvkjlr57uC1F
	9sY8f8zzb3IbOAQaNDPivmxeg8dS6z405AWDUWV/GjWctTxe52xJ6rJPy8StoSx1
	lVRnFg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f891usvq4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 15:46:37 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ef8249f73fso71020696d6.0
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 08:46:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783352797; cv=none;
        d=google.com; s=arc-20260327;
        b=e7LuM74YYApZt1ZdW1DvtZYbgMvXbLnB8y6DPJXQumOIJDb0lf7xvpiQ3rsMZ2a1FR
         0wqS+ycixfxXyTLHrFpq6kVq0Hrgqo9sB13jqEd/wn6Napv47N73OYAvCuz+1wS4Do18
         EoaP9OG7HQzh4Ljole4RaMzHcQ4BPrvBozW+qZmk7vQvpjv3o+0nv4NT4meREMsmaabC
         jEWRlgTb4E50x7jrcJRXQUoOWpkZItA56ijh+GSE3KoJz6uSG2KJqkDiL6M9bbUdomIH
         l6v2rSWyqMtbvS7v4XVH5ZwAknDqs1Pok71BI4/9Zt06uKKjRc4t8qpoCSZLnYYJmz/2
         ttmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5BsTIZAx5natIEWewyifBKbCaxJSzKUYtpPIxXtNaJw=;
        fh=2UTW1ll0aubZk/oxTpdlu81p0KeyhQp2RKETZVXNv9Q=;
        b=EKcbFy0d4gUyCiKjLJ3sG7fA7tNgBUuE9yjOaErEnRcNtU6EZIMzmbJyytXrSpZWkL
         tuwVtdY40dwcHO2AUYRHuBZ9+wNusgfZ6g0dAxOmv/Q71Stk44q7JQ1VKrqcWiZWgiuj
         80XfRkWbqLxT+l9G3lA7eTRamtP9An1tPd1BcVpAGfoGR3kudNMVAb5UDmaMbK8C9MLo
         V9hYOIojbqPgLckGzmP+54y1RinxH7ypQKxRgojtsHemzqmZ1cNr6l9O3lA/AuNxS9tV
         PXA35InM5ov5Mgq7BDvOdamth1dDeT3Eb27RQUL3KrQ3J0kp0Dvaxg96nXeA+O+3eKu7
         VJJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352797; x=1783957597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BsTIZAx5natIEWewyifBKbCaxJSzKUYtpPIxXtNaJw=;
        b=NMGjiZmmRKkTRuvtfeuIIiEljaah9MNGIV+a6rJqtTf7DNFZLpClNG8N1xogOfb7Gj
         SScwoTpGZTJ9fXFs38fhl3gReKG/D+XNZh8Iy3dcO/HluLYme5/7gVhBRdTluPh/xPt4
         SPT1rE3Ca+aW+yhu3etdBdHJx1eIqX/kw80tn6e8ub3evE/pQ8jTdXpisT07vQwkWJY6
         j9by3ch+KBU+zPh7mOTcb/M6gWWEvEKoEtCR+13WrxQGEBFRvG6uKRTksIMYvoiNDb7P
         gHM394w9VmeQyPD6RSShc46cz/tYdf88EnWv2xHtoas2RMp/4+kJqY3NiFxeMrBUZCmv
         oEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352797; x=1783957597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5BsTIZAx5natIEWewyifBKbCaxJSzKUYtpPIxXtNaJw=;
        b=mh7Wm8es/F0mpcXITj7WSxiJLodRCzbPS5ot8Uy1OMsq84AcxOJF2w8+ekph2Melgx
         mqU4/i2vu7XRRJ8u1NCpOhoHodY652b1miaWXMIo2Plg9540czX2na9ObVGEpTZIFlCf
         3hwvexxrXRVkFy7qr+WYobcDkRv22MwcXWofdhcvuQOrkBy3wQmJU1lLk8ct6dolvEZP
         Ousczic+dHhI5A7aeEV0VvDf7bapkVYWEpsxuGNZ2IuLO2mjuZh7/YK6YRmtpQIWtkfN
         AP5AfhXfNgHrt0WcOy7kk4rjVLuzSyNxCianDSavYCs+bbFZCQNUGJBGCGdCObPGZb5g
         1B/w==
X-Gm-Message-State: AOJu0YxZvN925mIW1Tci0KBuF9IQ2RmC/b7eoZeoXlEq6nYLaUz6XCcE
	ejnnhUkufgweHAlucRFaK3/H7K2yERh8WuyUp/joUWLhwyRqdfI9rlLOHtqXdVXWoeeFegOLR3f
	Glsx7E66QMdw/BJlA/+W1czR+EPNCagWNIXdyZa404TzC/Ih7pi9Rf/d9wwJg9DI9VxS73su7Hb
	EaCTde286ZhAKK4m/GO/Bo14C6RFINkoQJb0SqCg==
X-Gm-Gg: AfdE7cljMLHwYPfBRmagFu7weMb/NfBQ1ux+/Ch91GMEm5Hd+c4+qC7dr07WdERRH+w
	aki1Rwrj0aePsaTgG0ZN2pUU2RAr4csZadNZU50QMZgeQAhqPUF8CocYnrUxUUB42l0GqnaWy89
	3d1tiNQ7EDIWHn0hU34qF1LwX3NQfjO8rKq42PFIQh1AX5OFgC7dB5hb0xFzuZLAodPKZf
X-Received: by 2002:a05:6214:2122:b0:8ee:6442:833 with SMTP id 6a1803df08f44-8fcb5cb1f4dmr13806626d6.43.1783352796973;
        Mon, 06 Jul 2026 08:46:36 -0700 (PDT)
X-Received: by 2002:a05:6214:2122:b0:8ee:6442:833 with SMTP id
 6a1803df08f44-8fcb5cb1f4dmr13806026d6.43.1783352796439; Mon, 06 Jul 2026
 08:46:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20260603083946eucas1p278014c7fb89fb7764abc7b0904d15e71@eucas1p2.samsung.com>
 <20260603083935.3201411-1-m.szyprowski@samsung.com>
In-Reply-To: <20260603083935.3201411-1-m.szyprowski@samsung.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 17:46:25 +0200
X-Gm-Features: AVVi8Cc0ze6T-lEiliM9CCFiCkDStcZEzLXttqHu_Uj44RGjPoOanKr29D5gqn4
Message-ID: <CAPx+jO9XhvuRLsq-92FB8uV+rwYUEXH-=4D=K36uMgjiFKYeRw@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: stop and complete DMA also in
 STATE_DATA_BUSY state
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: t4q7H2laouxqXaVAA8JAtapSr8fO2oOT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX8urAdt41gQV8
 zE4J4Hv3nRj+JMGvwf+LvIGn29/Zc1yx5FLbk3VKbra+T9WVmprd97wGOciqatsK33ni+6H/OuN
 2S6CahQAn1ZsFkP3ESkqEjnw8lOX9RY=
X-Authority-Analysis: v=2.4 cv=Mo1iLWae c=1 sm=1 tr=0 ts=6a4bcddd cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=hD80L64hAAAA:8 a=J_f9Mw0rytlLGQ4cK4gA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX87FMyNzRkprY
 EaaUow0au+YIdBNkFeeCFTUZwdTJlDZbIXTzCjpTzU1Va079EnMMinHrypIbKAO/OAmaiIRK/Zx
 ZV/bsKa6fUjLVhGHN4fY+V8wr0apcppGqmG2HvnDNTnLV3n75R24SR35aZhoq0pRXIYw/KJ7h3Q
 9jd10t1qm6lYUlKrr/l5QTJIyzikYbY4aurTAMd0C6RC+lU1DEpQZCksG3X59tvEemubzg4r5J7
 zHOPZEtcoTaWQO84yEODQ/hT0TGfqnEbX4Uh3+YlmF67l4S161c+bTlAGIxGydGhbe7J+bAgOaM
 PUmYlKAHY5vy6LeM3Wqv4LEoGNVIurQrIMGlhHa570J2UJwvhSbfZ0QtLqx/qr+ZMglMLH2K3Lt
 cJ6nz2PtyZlLvaxf42It52YnT1FhfbMvatJW3FuWZtVYE+JvnpSKv1UNNkYN1xJ43tF6WFp9Tsr
 bAb7N+lAeY/+Q44kj5g==
X-Proofpoint-ORIG-GUID: t4q7H2laouxqXaVAA8JAtapSr8fO2oOT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060160

On Wed, Jun 3, 2026 at 10:39=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> When transfer was stopped in STATE_DATA_BUSY state, there was no call to
> dma_ops->cleanup function, so the DMA mapped buffer was never properly
> unmapped. Fix this by calling dw_mci_stop_dma() function also in that
> state to ensure proper cleanup call when DMA transfer was used.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Applied for next, thanks!

Please, let me know if you think there is reason to tag this for
stable kernels too.

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index d734d010444d..cf5cecc5491d 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2057,6 +2057,7 @@ static void dw_mci_work_func(struct work_struct *t)
>                         }
>
>                         dw_mci_stop_fault_timer(host);
> +                       dw_mci_stop_dma(host);
>                         host->data =3D NULL;
>                         set_bit(EVENT_DATA_COMPLETE, &host->completed_eve=
nts);
>                         err =3D dw_mci_data_complete(host, data);
> --
> 2.34.1
>
