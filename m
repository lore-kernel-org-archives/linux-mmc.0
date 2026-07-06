Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1C8423773
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352817; cv=pass; b=GiERaMdkNha6X9JwgD8X/0iaCItov/r6xya5txvjLs03Quc6/iNDG2XqQfbOZX+h+kG2ccyFZYxTG65TI2qN63vL4+Dv6kzuW+wryBEdrs8K0BMm2Vg8OO7ihB3FWQQfFkszsfczSzvWmPgGjmSGT3X8K83r4vkhyryCf8+Dcjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352817; c=relaxed/simple;
	bh=dGl8KNZPPq4kRdR4aVbEgxvqnLrKBoyf4a9idwrdrEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8GRyoEqYTDzLrVsTHkihyiWpm+aaIbLKLyL2x5tbbQvag5Pf061ocbhGiAQbzs4Tl/Kl9HPfwIYcsWrgHXRdQGdalL3vS9yIYptL0962Gx8nP0oJQ1CLqcIbI295PDNwZI4Ned+OKBAGMkwQG6yIG9MSA44KbY8o/f5Lzo/dkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ieZbRTp8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L6+9y2Id; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ieZbRTp8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L6+9y2Id"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF554825893
	for <linux-mmc@vger.kernel.org>; Mon, 6 Jul 2026 15:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XhmejSh/mnQRXVKtujCghbVf4DcyI5tuN9Z6umvCRnw=; b=ieZbRTp8D1qoIKt1
	QR5v52hSs89F2lW99wjywzho4cgjUl5LWgB/GmopX5n2pPRBhoIz0wCTmtHeDo4G
	5agfDZuyyQCjLn66eMtIyE5qLLBw+wUax+hWi+rJmB227e6rz691RA1MIKh6ltrN
	MeO1JIjskNHEf2WHT+t89xbo6Mq7K83QKfcCwObgS+x169UQVHC/A1S0TQE/Fr6r
	ZYCVQ+MVhErOaldTKxvTwxqyqy5f68nQbBwwzY+h3f+2JzoM4jhdhUPkN8sf8tVU
	vuUuEsAhm7OOs2mKZP0jJSN2lq36wMJiFWjd/gjAyOT8uUe5sd4fXChTZg/PX64c
	R3BVrA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t89y0d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 15:46:52 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-969330d8ba1so923113241.2
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 08:46:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783352811; cv=none;
        d=google.com; s=arc-20260327;
        b=RDmQBIoJVcQl6AjDgSEiQwthxLPd0gPQMLbpPPCFPiEYkDIubwzxzkIH/IhQVIRRTP
         xs6VTKsP8+SMRz8Egg/UCglJe7eximMb6uDOfexszguCRvIz+I0MB3+gG/oZ7z1C8QoY
         4WikoL6gugzxTuvDUwVKdCLvap4Il5Z/SDtScty5nq97bfdGDrUaEVBf4aGMtl4bCQDy
         mkg744xqUq3eDWYh/+RBymiL2UcvVjeSaIwlgVRUnQKUniAOkD0I6Oo1lpWEr9Lpbrua
         Z1DYmS3VkvwIcQU7hQx+XzcEzb7ehF7zHugHclJocI1sE+dbFuMTdd9HGLzlrFAmodD7
         jXqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XhmejSh/mnQRXVKtujCghbVf4DcyI5tuN9Z6umvCRnw=;
        fh=CN1D0ZzaFVxk37yiZjxoRE5wOdecpBluF56c4mTCNN0=;
        b=SRNvsfomsna2W18Ll+LQdR701clAp+rYKZh7PQfIxCAjrP4KtKl1jKXjeaiAIXwYtb
         Ljm3Hx5iBBhOaoghQcVMye0j1x+53TujJV3yATrEnJsstNTJedl7/ZfL/iT2cu2XrgJs
         nZggng7kdbztloSNbwExTJ5G8SrGEv1wx6lNhXIq+erl3mH4aPC8U9I0ZCGew5bXe3SH
         PYywDp8QvL3OcuzYXuioa3YxsCeAIund855VsGrkKKRzQYNl2K2SX13H/g5jV/H9eDCd
         zQilVwDzUJxxPi8di25s9FlKhvS7hr9XZ6mvSQ8s5XHlU/olAyYLCWiAD9HnddS5Tyrq
         7G/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352811; x=1783957611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhmejSh/mnQRXVKtujCghbVf4DcyI5tuN9Z6umvCRnw=;
        b=L6+9y2IdpF22r0dJQmNtEkCftlbZojdO6tzhzPsW0fgdseK5IPD25Qf6ukkddNwT61
         +0UQmpUjusTQ9TrcV1s0WayluVhVYrdOVPAQBFoK/DITBLfy8yVHNO9YNLZlFIdKI2z0
         kxpjvJoiQBKMbghNDa01jT8gw0uRmEgUTF9y8UnRC/gOTMuuRX3g9nLrFQnEtFaB4ozs
         vawp8XewW77TQGhs68DcYeOzvEq01c1YU7VZl+hxt996XPQkVPKX1DeIQ8mzLRXjiIE2
         LpSAlFXBwY1lRBpggva+Q45c62Vgk9qOjdHyQ/Xo0B3mWWnvbCkQHIPKL6AcmRi4KBrP
         rB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352811; x=1783957611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XhmejSh/mnQRXVKtujCghbVf4DcyI5tuN9Z6umvCRnw=;
        b=ged1LHv34ppuKJqZNqajPurKKx6u6bEhgnzwi4Qo44PmOWqBz/QjY/kbhDs43cUNot
         CnpxeV0CExg4rgFtvnpnTWOtayJ7cE3PddiXRb11GB6t4veS4jH6HRZt4Zwee4T/RNtx
         mJvh+dvWdllTKT7Eiq502eIk36iNxmwwl7YEI2nVxETjR+EApe1xJ4Yy02s4NPRQfWwU
         v8RYTPLDbMEu/1C1rnEA+DLl9gDbIkZKuvmA41Csi3SHalr/dZcBVlikojqZG2XnzpVk
         buay9o/SntmPyocyT19l3Ctbbe97MTnk80IDFgwNR71sT/Le3Fx1YUHAsWPBxkxBMs/j
         7EmQ==
X-Forwarded-Encrypted: i=1; AHgh+RqRp+o+es+eFac/3wMJ2+YmnrMVGulAg5QdZMK6lV36EDSQvC3hiqYmoYW53rwqferItgEBTDgFFtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc+uxRl+sUlxo/499nUlFY1/sqodoUQ/wJX71ouXxlU8CxgPdP
	41WONYICC1FoL74lV4JTtBTuJadmxX5AksAAWlx1cyBHIGQbvntYcpJrdKJB/nXu7d1+/in+gqd
	soRhovrS4/j1+vubL5EyP5B0N8tMI7efzy9cSbth2dzPOp5dsYEOMWAtzifm1jOw+kBRoh+j6XJ
	ddRtkXAMeYqBmP6koYi1XA9BKk7KhJvdx5a5hK7g==
X-Gm-Gg: AfdE7cltlpRQW9nDCNfZyCPryFDzul16PzmIFLpilGNzNU5Vucyr2ZoL/pxLnZFZbDC
	9oc/DNuRJsKwYWDJufzUo4SR3PdjKRjyKXqt/dn0zsbQSLzGHzBZQEdvGvW4c98FIbkAtkmzugm
	9mOITlxOjIi2rq7RNM8I1V/H6oFVT3jSbcuENas2QlA5RSFhf1Ie/1x7K3YhtwhlFIUJKi
X-Received: by 2002:a05:6102:f85:b0:737:b586:6386 with SMTP id ada2fe7eead31-744b7da5e19mr593844137.16.1783352811015;
        Mon, 06 Jul 2026 08:46:51 -0700 (PDT)
X-Received: by 2002:a05:6102:f85:b0:737:b586:6386 with SMTP id
 ada2fe7eead31-744b7da5e19mr593787137.16.1783352810522; Mon, 06 Jul 2026
 08:46:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612032756.2910943-1-lgs201920130244@gmail.com>
In-Reply-To: <20260612032756.2910943-1-lgs201920130244@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 17:46:38 +0200
X-Gm-Features: AVVi8Cf8Vno8vJb9h-L6UK-QHt0f0kykFNXamMiaa0004XSRAPwfleBJQdHF3C0
Message-ID: <CAPx+jO8=L-_h9FET+Zp34j9OY24cmfX8jT=PV83_z0VtWssCZQ@mail.gmail.com>
Subject: Re: [PATCH v5] mmc: vub300: fix use-after-free on probe failure
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX8bVj5vnJ3e3g
 50i1Z23tq+Av6vYunyHoi6OeZrEnQFqFoPpLYRqoZW5iaDTjfbw4uoUvGLnq6coRbwr5rzofmJ5
 /NsG4rtWcIledv+RcsyJg7AAVHGA15c=
X-Proofpoint-GUID: E6K3ZFkJHa2QrTbEVXbPRx9TFUVZEy9t
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4bcdec cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=oCbBy-jv9Fm_6z_G5D0A:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: E6K3ZFkJHa2QrTbEVXbPRx9TFUVZEy9t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX+cuqjTyRMuT9
 6ISRPEJCK9SnubvfWV+MfPwk+GvMXYWEdWkMk70HTrhqFcqa9LrcLccl5U+xAUYkTjvAG/VQa5A
 RT6yn0rHSEpy3HmPzPKJ1a8BWgPpvEcqiysyYmJEIfsVZBg+c+ns4gZIAlJSSTjN7Hic5R0oqxE
 UllHDdYofaSarJTk7lYKkaFsRfbwyHzhNzL9agOI16pVIe24kxjgvMXIXlteRBMhvy+IRtQQW3L
 tiahV5t94HG5NhdgFYpD+zwjKezvvREERv1KBVHfT21OV+CfmuveWIu6g6X4t764IxPYnfv03yd
 8B5HtxOzEF0vwmxNgyiqlEybDALKzTyFlvzkR9ilKaGPj5oXsGJPqIpl/hMvyY/OrntPprNHlZC
 lO5jmkO0wolOxhgYCogmfaVgF/P2fsEJ8SeUgpCP+azlEvqDjM6dlfC0TBwqKruHw41W+91SrPh
 pjHad5UGY6aLyquwLcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060160

On Fri, Jun 12, 2026 at 5:28=E2=80=AFAM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:
>
> The vub300 driver lifetime-manages its controller state using
> vub300->kref, with vub300_delete() freeing the mmc host when the last
> reference is dropped. The probe error path after the inactivity timer has
> been armed still bypasses that lifetime rule, however, and falls through
> to mmc_free_host() directly if mmc_add_host() fails.
>
> The race window is between arming the inactivity timer and reaching the
> probe error unwind after mmc_add_host() fails:
>
>         probe thread                     timer/workqueue
>         ------------                     ---------------
>         kref_init(&vub300->kref)         ref =3D 1
>         kref_get(&vub300->kref)          ref =3D 2, timer ref
>         add_timer(inactivity_timer)      fires after one second
>         |
>         |   race window
>         |<---------------------------------------------------->
>         |
>         mmc_add_host(mmc)
>                                          inactivity timer fires
>                                          vub300_queue_dead_work()
>                                            kref_get()          ref =3D 3
>                                            queue_work(deadwork)
>         mmc_add_host() fails
>         timer_delete_sync()
>         mmc_free_host(mmc)
>           frees vub300
>                                          deadwork runs
>                                            use-after-free
>
> The inactivity timeout is one second, so this would require
> mmc_add_host() to both fail and take more than one second to do so. This
> is unlikely to happen in practice, but the error path is still wrong.
>
> timer_delete_sync() only waits for the timer callback itself. It does
> not flush deadwork that the callback may already have queued. As a
> result, queued deadwork can still hold a kref while the probe error path
> directly frees the backing mmc host, including the vub300 storage.
>
> Fix this by using the same lifetime mechanism as disconnect. Clear
> vub300->interface so that the timer callback and any queued deadwork
> return early and drop their references, then drop the initial probe
> reference and return without falling through to err_free_host.
>
> Fixes: 0613ad2401f8 ("mmc: vub300: fix return value check of mmc_add_host=
()")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> Reviewed-by: Johan Hovold <johan@kernel.org>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> v5:
>   - Correct the Fixes tag.
>   - Add Johan's Reviewed-by tag.
>
> v4:
>   - Fix the Fixes tag to point to the commit which added the
>     mmc_add_host() failure unwind.
>   - Add Johan's Reviewed-by tag.
>
> v3:
>   - Use the disconnect-style teardown by clearing vub300->interface.
>   - Drop only the initial probe reference and let timer/deadwork drop the=
ir
>     own references.
>   - Mention the one-second inactivity timeout in the commit message.
>
> v2:
>   - Rebase on current mainline.
>   - Correct the Fixes tag.
>   - Add blank lines around the early return.
>   - Reword the code comment.
>
>  drivers/mmc/host/vub300.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index 6c3cb2f1c9d3..c1c21e95f5bf 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -2336,12 +2336,16 @@ static int vub300_probe(struct usb_interface *int=
erface,
>                          interface_to_InterfaceNumber(interface));
>         retval =3D mmc_add_host(mmc);
>         if (retval)
> -               goto err_delete_timer;
> +               goto err_stop_io;
>
>         return 0;
>
> -err_delete_timer:
> -       timer_delete_sync(&vub300->inactivity_timer);
> +err_stop_io:
> +       vub300->interface =3D NULL;
> +       kref_put(&vub300->kref, vub300_delete);
> +
> +       return retval;
> +
>  err_free_host:
>         mmc_free_host(mmc);
>         /*
> --
> 2.43.0
>
