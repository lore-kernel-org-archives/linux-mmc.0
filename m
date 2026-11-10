Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794319410;
	b=ERegwjM1hBdhS9QrQncngDHh6bSfzKG30sq9hivVPu8IeqebJ0GgfYMxL+9k0MQSccZd
	 TAUwizoztSRTjWCfnNnwIkSrnJ8MBcLNmOSfITr/GZO571nQdd9vghjCurSokCXJaPWVF
	 qzmVV5FG+4+41tmTOp0c4ZVQl1H5p1RLgI+oRycsPNFYlGpjI80ki8q964YwYBjwF/jLu
	 eePhBtnw0bztdgCrnHwYz4qUzGo7dRmqdVZJblstCb1ds0ECygDqOiBDaIsyiRSlEHZXn
	 8QUNZfe5nZCf+0zSRoRHVPh+7B35JxnzHKlz/nNpbdfscH5AhM+TEm8AzxDDT2OHoaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319410;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=HKLUOKp24Fh9UrEupb2eimvqyQLsemEwdcF5Omu9p+E=;
	b=W2wDcHe7foFPSY3Hs+OFALdnof9aIhmcGCZ2+SRFNuZXoLN6FB7pWbqMBFTbW6IlLlBU
	 cBLHFlkg9vnXbe9bRURM+R/amMqBSUithf8mbIBjO1dFq9fxLdnIZT2q3Oqa8LMSwv/VM
	 aQNQVEhenamHj4Oo4lzD38mgyXpJmzGTBGRUcNSAt9Mj2wZfi4qMCO00xEFjw+Z0cUMiA
	 Wssf0tSuA8thI4d7whUjzhZryhV8psrr/RmShBKfU+/Ka/BBTstdlayoo3Shv2rIusu2E
	 IcGdpMxp543ldvL/2jyrpR/x9du60vPfuLL1C59eOzk274uM5srtdiw/DMi2h+hHpsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E4czr2ng;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=da+NbqeD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A90606A326
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 14:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51A90606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E4czr2ng;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=da+NbqeD
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABAFhf3839642
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 14:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HKLUOKp24Fh9UrEupb2eimvqyQLsemEwdcF5Omu9p+E=; b=E4czr2ngf7h32vEn
	FX/szMZWoKtVpvCmjxPfOLr4ozsCzUZ5hz27Pi+ErJJHsKwBhbFCb+jFB+GQBTe2
	PZs941Oexn6I/MBI3oP9Lb85HE2zYE+4o1KCxSpo59thXbSEvyT1xhtXKBfgcx3V
	KtCmC+zvX43LyCgq9O1VedQ2z+1VLiHhC4QuN+BFc/CKoIcGkoXcweOQUs/FqFkW
	BqbFpgbVMXy0n7MpFDzmy+/5vXvRyThXRnS4iptjM9vbkOdfa42BClbNhkWKbthT
	WgcXUYlIVOAwy9325VbfI6sYIbFGc+5+0z5nCO8Fz8m9tv8gN8ygwcBTVPJf8WYF
	ybfyqg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4humjg3pbn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 14:03:29 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ad704d4760so2422217a91.3
        for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2026 06:03:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794319408; cv=none;
        d=google.com; s=arc-20260327;
        b=adihrGmfscfoxnmonpDi/H3ScsUhS55WbA40+aF5tY7hEvZxKABy2cFlN/Iy3tz4sL
         dB9433sLtn8gea1proOcwlcB4Mgb7N2vBl87q4XI6kf9bT5Opg/Aru5vgg+DTpwEGmT7
         owMgTF5P70qkGOC5TzvS8CvcAiuUZSgHoFneyYO7sQ9DwoqBLbxxSvJqroh1JyKKgjGg
         Yq14yrleVDOdS+RPbBeknpWqOM3znQEI+ZnHd09JOBVRWEMpBfQ5Buv/FVK/yLSmgDsd
         bF70je0t28oOLgv9BM9p21ZX/dZtTEQvQxDfZ8F9mZ3IwBdTv4z+dJQgLrlutntJVwNn
         jiTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HKLUOKp24Fh9UrEupb2eimvqyQLsemEwdcF5Omu9p+E=;
        fh=aPy6R89OzVRtVU5+iCm77M5pWPwt///j+aKz06NkyJ8=;
        b=b4omOnrEk5LNOG8Fp8hG2yfWtx6c9odtcjxG4nqAKUayRPR/30CYObmGDSNaDp15E+
         Y6fn8IBuzMQi1vYIWz9bw0/yrXM3KmGg83Ol/AmV2KZ+XcBSSLVrmYWoI9CHU9sCTzUo
         sLKtdmIjeLF8W+QO6NW5jFfXeka5qoiFfRBCa+DuSGJ0y1nSnRQBfiS5KCQ1S+xvWfa5
         ET21IxP/j/qUpDgd5QGMy8xJGt823pBoELwCShPe3KkIlln0g5GZ8QUSLCfM1ri93GYY
         LBS5Btc/oPKrfrFW6Cegu8uECPInhCPccGZ6bXF2zu8VCTGeJKg+2JWlB4AjRQeyztjY
         Cqig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794319408; x=1794924208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HKLUOKp24Fh9UrEupb2eimvqyQLsemEwdcF5Omu9p+E=;
        b=da+NbqeDLDGcxTGnR4c9JYZIgeOyZuGrREwI6Ashsu1+qRxzXR0yd/g/51xttgUnFf
         s9XpDgGhF/1FIEXMf8iq+4uIOae0jIG3Mcp5WhNlR5ezzZDqwn4F4t3TVmhbahh+muhW
         a+8hPzVcce51j2yo6EwWmSxSbD4CiAf1NZBba/slfXTR0U+yYR34Rrqpx0bgpDgZgLOR
         usZ3hVe+gn1zz9F50V1cP6LsQhXxor+aiejr4CX4gtWJXrH8B+rBzlrS98w/CsruS4Yz
         zBtRkUxRtx9JGwgiYyQMBGOEExoOrfLKraZckZvYwxB+fNyaU0gm9xw4SvaK1E9UPRbV
         sPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794319408; x=1794924208;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HKLUOKp24Fh9UrEupb2eimvqyQLsemEwdcF5Omu9p+E=;
        b=LyPyh5Wl0QRf7wK/7EKIz5442PXJjPAAgc5jwAh54lhGOWpCv07WzbB89ZS0+FlbqG
         E6AcRKqMZ6PTWMCbMevKxsxqycFe6vVbxP0S3tGzeSU2rbv9Em/mWMtV8N2+qmRu6Bt7
         jK+mR1xm4M3L1fZyQFuVupYrwXZ2Gl3/pjhVPS3sJ2LM3IBbsyOiS0isn8IDMmqd5j2b
         60uCb/zZxQ6so0iwlSKNv9R4DzTAqkUHRn/eom4YFbrmUr+NL/WjIg4X2u2Sv0Lqmam3
         bNck2Ms+A25hoDEs30ufkMhp9Ur6FNa31pCLo/5KnCullkxSRWu0383qr7EeOF00iZ+X
         XJAg==
X-Forwarded-Encrypted: i=1; AL+hErHdB+4gjrdoYAv6gt8pXgm06wF2FRc/RmUfEXxzW+Avvx/lBvnDb8kud1DX7fe4plZmC95sCNtfMow=@vger.kernel.org
X-Gm-Message-State: APuU4Z8GimT6n61u8B0tH1/4ayYvwacRJnIfbZVRGi+jx411mmnFKi1V
	7ngsasShpJ0IDWN/Zeb0ABUhr08/3p9E94HlYCw8GjJmjX6Kq8qXj1Nv6/0L3kd/rkdQBv3Qd+z
	r6JgjywucvD6DajsVW4Rb/Virle2r/rz9L+kEZH82HyS+4N+eZdtbnqSHR9I9mN7Ic0z+EbU2du
	auV1aTNXDLofaoW7J4Sb0GgNlPD+O0cz/Flvf53A==
X-Gm-Gg: AYBFou1qkR15djfSHFsaXB0UQrTm50xDE8TAb6+HVqWJxiWWha+XP/rksBQjIR1TQbe
	YkI4wJb7G5eB/prjMcvX9Qn/60C91EWNFMsFHCcEjtMGkyEIaCJvJB+0fUecrmZFQ7UBgOSe3FL
	xzjWYrozT4i3h+aFjfjTBDL9DDmxFbvlVb1i6wBxIBnQ/IgFIKEIqMXj3fNQ==
X-Received: by 2002:a17:90b:55cd:b0:3ac:9925:72ae with SMTP id 98e67ed59e1d1-3b166cddadbmr2321945a91.31.1794319407858;
        Tue, 10 Nov 2026 06:03:27 -0800 (PST)
X-Received: by 2002:a17:90b:55cd:b0:3ac:9925:72ae with SMTP id
 98e67ed59e1d1-3b166cddadbmr2321927a91.31.1794319407353; Tue, 10 Nov 2026
 06:03:27 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030123647.2356647-2-thnkslprpt@gmail.com>
In-Reply-To: <20261030123647.2356647-2-thnkslprpt@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 15:03:15 +0100
X-Gm-Features: AclHuK8KMiLyeH5HgBM9NESXCQaXze4wyF7gWrDjuSUQtT7rBS6jklpCRNO-j7I
Message-ID: <CAPx+jO_NViokUMtgjeEG5_=Z=b9DpwJCpwX2HjLsr-Yitb6G6Q@mail.gmail.com>
Subject: Re: [PATCH] memstick: tifm_ms: use the correct DMA direction on removal
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulfh@kernel.org>,
        Maxim Levitsky <maximlevitsky@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1NSBTYWx0ZWRfX6qxNner0YMaQ
 XzK+H++q6qVPMG70aoaBEpihGEkryC7YhbsZo3dVQbz4W0ryhX0v6lPH0NEVd/7aGW5JjICMrst
 cgYWMez0JtdEJLkEwr438W1MB3jLSeP9Y/T0n86eB283xwfQuJdRO1lDiDZ7M8EGazRz7wHD1If
 sH2XKZBGmI3t/XnBmENtOMT32mP29wq/+BaGO28ctlT+70QeFVZwApWa22iRMM7slzX4VjDUiPX
 i9/zN1SnG+zyWL6d9Jr8cr0Vr3sbs6SoTp7s4p2K8IfRq7etprx7zzELSxp2icn9v5fmuXgebMO
 YpxHf9ZxQkWq/PSAxYlkN014L02ALVHXnRl3ZuZ7M75b4JsQddRZJ10vEy8TMjNivGg2guaHCwv
 q/dXDdp4Pa4ZhS5l+237J45HYsfi9GUSQvHl9P4MhtvXyUNQmuLwSFRIbJsJRtW12ANBxJvE9Nj
 WcjyGxvxw7UH+1LOSgg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1NSBTYWx0ZWRfX6/l8jMQObvYP
 cWz0vC0a5vr4bhAaggQ96NMDKBRKX3YsnCq22Uzo/92sl/YW1zMt0c67mXwCgJaC4azM4C7t6BX
 f/7nYnY+r9qlOmnThpJlmNRsfliLB1E=
X-Proofpoint-GUID: HUGcLko9uWmsE3t6VE3Eto_tJz9yD99N
X-Authority-Analysis: v=2.4 cv=B6gsQ+tM c=1 sm=1 tr=0 ts=6af32431 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8 a=PtCAOrcFS5Iqh549t3gA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: HUGcLko9uWmsE3t6VE3Eto_tJz9yD99N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100055

On Fri, Oct 30, 2026 at 1:36=E2=80=AFPM Avi Weiss <thnkslprpt@gmail.com> wr=
ote:
>
> tifm_ms_issue_cmd() maps READ requests with DMA_FROM_DEVICE and
> WRITE requests with DMA_TO_DEVICE. When a request is active during
> removal, tifm_ms_remove() unmaps it using the opposite direction.
>
> Use the original mapping direction when unmapping an active
> request, matching the normal completion path.
>
> Fixes: baf8532a147d ("memstick: initial commit for Sony MemoryStick suppo=
rt")
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/host/tifm_ms.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/memstick/host/tifm_ms.c b/drivers/memstick/host/tifm=
_ms.c
> index 0a54586aa54e8..171aadd4ec71a 100644
> --- a/drivers/memstick/host/tifm_ms.c
> +++ b/drivers/memstick/host/tifm_ms.c
> @@ -606,8 +606,8 @@ static void tifm_ms_remove(struct tifm_dev *sock)
>                 if (host->use_dma)
>                         tifm_unmap_sg(sock, &host->req->sg, 1,
>                                       host->req->data_dir =3D=3D READ
> -                                     ? DMA_TO_DEVICE
> -                                     : DMA_FROM_DEVICE);
> +                                     ? DMA_FROM_DEVICE
> +                                     : DMA_TO_DEVICE);
>                 host->req->error =3D -ETIME;
>
>                 do {
>
> base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
> --
> 2.43.0
>
