Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8905389115
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783334056; cv=pass; b=AalJK7R9zG5S9x0Xht9vpUgOhP91DGHslIq6f/7ga0otvK1O9VXaYkf8dylPmTBl9DXsF64CJ/WodVezdSuwFX7e0Dp9wWMssG8vR0MtWHtlEyc00hmGqCDwYVs4luoQCgb0fUQSCigRdk4/ih6D/5NgAFd2zHfOrBTQFSh8pmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783334056; c=relaxed/simple;
	bh=TR+p2pu/5lqO+xEbTIdzYZMxl4O0CKWbah5V0sWjxfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q46lCf8Yc2ITfdpb03oJUX0TfX56B5JgPjDje96udmCeKDDS1F087nGb0nCf12PTLvzqKmwFx9paDr0Eg1BkX5ccSGlOTicEgQL24QaAG7oJRWo4k+uyipCHFnG+AH4bX3ii/up4sGaDXz811aPTCn2YCOuF9nFYBHlHHiNHHsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V9lZ4d4F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cM3iGq6H; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V9lZ4d4F";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cM3iGq6H"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6669GsIm159973
	for <linux-mmc@vger.kernel.org>; Mon, 6 Jul 2026 10:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	THfVk3JLzARMALsypSV1vHAeURIRyLWQ1tdXmwWL/Xc=; b=V9lZ4d4F0Bhw4koL
	RnMhQHgR1Tt0mGHNSQN+Ct/Q8xaRj3e6D9pP2vwIEfwCVIhmZ1/jE5l7iQTSjv/j
	muLdtH1rg8HTRw+dyCGWt2lt/IllUWCN9rhbF6cNis4dJBsj2esvZ2SPxUyeokJB
	QUX/iXBHDvJ/B0xTPF4Bcsvnj64lhVDQvPGg0xMw8swIZao//ypHrwMIbPUL58Rc
	TC1zJhubzRSaG3uXOAgO7QExFv7avUZkd6oSLYxkLYCjANnXa+oiN36gmU14o9vq
	vOf4orwZE0yZQsfh9HBUFTEfY+DXyiIFFraPWmZ8zQUxe7EGfw06wgde4eBS2sNL
	msQhtw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgr9w4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 10:34:13 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1d7886cdso60689591cf.1
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2026 03:34:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783334053; cv=none;
        d=google.com; s=arc-20260327;
        b=DPq2Zsq9raDm3yjxEbR8yfEn4gRsZ+FNeyH/1VxonK8TZd/CX6Ytk3VNQuLiLLp4lW
         Y1tXjAfaQ4+TL/T3N4Uv8/4r3HMx2jSCu6UfhP4PJmUbZncPTVHvwQjT0EWOj4O0N+LK
         0ggF/1jRKzYNJEfDQIzOHcj/Fr+nNTX0GpA6w4k7PgCVssA3TCKhAg5gx6KmzefstBk5
         7CNg+/rgqRVTcufUqNnEX/FPw7pRLav3sdBq2cM6Dov6/GbeFBntASBLyOTgP9Po3s5/
         Kg9Oxy/lpTfMZTCI4PYhNcalu8RJizYjC02TrpV/uGoE4f1LSlZ7agGdhUO4O99GpFAa
         gP3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=THfVk3JLzARMALsypSV1vHAeURIRyLWQ1tdXmwWL/Xc=;
        fh=MQ5MDnDIoVVdyeFNk54Zg2wwWB67WffvmeLxq/qV4SE=;
        b=kKvlCpXqMUrhqdDtHtMUYAckcoNVy5+sSVguhHEBjJBoWuTN4KJ4mRsPw38GwZ+ozp
         yH/YSIZ3zvrcwhnkrM62a3cw2zujo0XKE7iNVxgyXNi/50ltp7suIuvVB3uhMtdnVLTk
         KzEGoYo7ZH56KYLHUFrMgyvid6Lg62EWjr386JQZvG9trqaP9Vp+wSyfc2VpRC0C7/S8
         Bta8s1kwIW3gFfABVV9+VGB/Jb10d51IFzxGcqnkFeXpjWGc+HOi9IUsO+ZMuZGEc+Sl
         wTkEqFi8ijjwkw9RfAPyrVyUMHn6AnxoUf6pos3d/riSp4HD9ckeboO4WBxkrIMpFcwy
         Ovvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783334053; x=1783938853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THfVk3JLzARMALsypSV1vHAeURIRyLWQ1tdXmwWL/Xc=;
        b=cM3iGq6Hf7x+2X1wrSlvTPjdgVDjiBw5RyjnOSZzC7u/asP2VWQzO3Ly0Ue5tctGAU
         YCWuD9ChrfUgNbehUD+H9fuYoRh1Ek529TTNLTGKPzR60lllPtIGHtGLydc16uGFmviP
         Gvo76o5ls1K040euAzgn2qzyrJVrRkhGdlbb7ETy/BwbfCENoTeQpy+HBRwSYS5TESHg
         7f6PPY18XyGbnLZtZeA5t209/MX2oUWUU1jOKjabHVWU0OHxRLaeLScp+N+NaWoQ13FP
         BbE8kuChFpBiewoWtQ27enK+qMc+xY6eKugh++r7Y0waQW2KJUspPJ2ddT1prudhg1yx
         Fidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783334053; x=1783938853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=THfVk3JLzARMALsypSV1vHAeURIRyLWQ1tdXmwWL/Xc=;
        b=mgq1xnX78+kRq7riYWgTPvzysa0Zf9Eo2Wl4oOTlajfCiAgKZm8VCRa9xvz02V+wXe
         L1/vT8Wbh9nN9XpOEhtrmucc6QCJABss3UjgMfLsd1hyhtwVkrGZiEPvQTWoRzYphmU9
         QrjIF2W3xTDkc6mBi4dzcLxc5O05Ni+W+DlDHB6R0/KGsGuVn2XMKelgPvQz/AmAkNAu
         JHBn1Z3NQ6ufn9IUbrmjU2RAWPQ+XEqOS2jpVrP0YfX8JwAFz0+U801sXOztYGxbsabF
         zKt1r2f25E3PjjH2KF5IaHm87nN3uHJw6f/rmHGp6MjPK5pMozzF1zeXvUAkCKhhl8HJ
         qLKw==
X-Forwarded-Encrypted: i=1; AHgh+RqvTCTiSoyDkVsj+vo8l1W/0ySMhlY5l+AYB9UWILf0MTxN5OAtRZdJkFTWQD/e5DaOVXAxu/TmiwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4rWEZHUYs8Crfe483nXTiomyjIGH3mHOCH76bXKTX5wTfgDT9
	GUj+U1SClJUmlFf41o/MR/HxcyLboa2v5ljQmLnhBZluZsr7vOwnfh4D7AT1wcG3uz32/mDCHga
	vQ8SiFObRRjRTCv4II4pvjN1mxD7+CND/eFAsyzuXRWfwKQRr9TdKCp6PVDUw21gCcHhw/+jkcn
	dHUHEeZNjRWLHngayAOngf6fdTebuGZpgNRdlsfw5kBxhQNw==
X-Gm-Gg: AfdE7cnwd5VfU63uW2HnmhI09cH++oc20aa4CSbFqrvg+qVRf9XOuxgBEkLTPZuv5P4
	b048U96822D3TpH1WzGXOpEUC6MQUhaZ3ZWt60RBuxMncyeJ8mZRGi3nfsmacL+U7jvGFxVqdD2
	FLXo6KcQMIyf87CF8uAMj3rxRMJqjryZZzjzcoZHzcgtWPjW/3Qfn4z/6wzqXlKKk8ZBTs
X-Received: by 2002:a05:622a:3cc:b0:51c:12bf:d4a8 with SMTP id d75a77b69052e-51c4c2d12dfmr146289461cf.41.1783334052860;
        Mon, 06 Jul 2026 03:34:12 -0700 (PDT)
X-Received: by 2002:a05:622a:3cc:b0:51c:12bf:d4a8 with SMTP id
 d75a77b69052e-51c4c2d12dfmr146289161cf.41.1783334052402; Mon, 06 Jul 2026
 03:34:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <964d54a3-90ce-475e-952f-342bb383f878@gmail.com>
 <CAPDyKFoPjwBeaQKMDf7zrW8hQDZjD89=ChJ_TPf51BG4yonz6w@mail.gmail.com> <9e52c51d-c358-47ad-a2b1-763a348f6c7d@gmail.com>
In-Reply-To: <9e52c51d-c358-47ad-a2b1-763a348f6c7d@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 12:33:59 +0200
X-Gm-Features: AVVi8Cc5GbO7tz7JBffB0_5KrgZwJoZsV7bW7_W4UU-NRO5zMratZUF-NEMFR80
Message-ID: <CAPx+jO_5gH3378yPrWPiF_sDJMxW2Eg23JEgpKRiPiXhajMaOA@mail.gmail.com>
Subject: Re: [PATCH v2] misc: rtsx_usb: reset chip on resume to re-detect card
 after S3
To: Greg S <grigoryya@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rogerable@realtek.com,
        Ricky Wu <ricky_wu@realtek.com>, Sean Rhodes <sean@starlabs.systems>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: ptB5FVku59bz-8OANTvBomsuKa0QcUzk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEwNiBTYWx0ZWRfX0o/3I5ERT0E7
 KZJPkFFg3WeWBqIf4mNpBPWckGHdopVrB+a16rlPtm0cAQfPb9KoWtDWFxbX0dr9tQ6+/hraCOh
 nzqwBuQAI/ZL99Dw68YANRUgCM9Xrk7NRKuDYZkCclTMyUVsh9byoTn5Yvf5zzjGGUeqDhw2nDk
 /ZohC3ESrALR9uMLCVBzZrZo6khHepqLwjZH0OzLwhabaVvJz6bz0kZxfnveIla9sDqEroMMMs5
 JqpZ5pKQn6JA6B1cxjpdSi+gD7ievyCd3AKeJMJaucwUGhvRwF5olmqfgPJjfis+KcFLbA+Rwaw
 RxI9aaPYeobe+bH4ArTt+ylzSCb7PYfOxtZCPW0Fg87y09kJxAEKKJFsIZug64CuHYzG3q+ZtBO
 ESddzqIco27YInscCmIKr/3JoP2kk+o9wmjCc562Bx4HcjtXTjQ+HLXoYhIGOTOYh3xLRVb1zvn
 O1yMyOYE83tFoYL+Wag==
X-Proofpoint-ORIG-GUID: ptB5FVku59bz-8OANTvBomsuKa0QcUzk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEwNiBTYWx0ZWRfX3ku9zchQ1m9r
 puYdIWNqbdlCLyJ2ZG8LpzNJnGcMFd4ROqJaontwMN+eoJwQ9qdTIABcjtOsHGmA8qelUX8Sdv9
 ig1rCTR9j/YmCt7/jZzyR+Bctbyvt6I=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4b84a5 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8
 a=kN_0Kk2H-iRQjDHmQMAA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060106

On Thu, Apr 9, 2026 at 9:41=E2=80=AFPM Greg S <grigoryya@gmail.com> wrote:
>
> On Tue, 7 Apr 2026 at XX:XX, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>  > The patch looks reasonable to me, but perhaps we also need a fixes tag=
?
>
> Good point, thanks. Here is v2 with the Fixes tag added.
>
> ---
>
> [PATCH v2] misc: rtsx_usb: reset chip on resume to re-detect card after S=
3
>
> After S3 suspend the Realtek RTS5129 USB card reader loses its internal
> state, but rtsx_usb_resume() does not reinitialize it =E2=80=94 it only w=
akes up
> child devices.  As a result, the first command sent to the chip after
> resume times out with -ETIMEDOUT and the mmc subsystem never re-detects
> the card.  The SD card (mmcblk0) disappears and does not come back until
> the next full reboot.
>
> rtsx_usb_reset_resume() already handles this correctly by calling
> rtsx_usb_reset_chip() before waking children.  Apply the same logic to
> the regular resume path.
>
> Tested on a laptop with an RTS5129 (0x0bda:0x0129) built-in card reader
> and a 128 GB SDXC card.  Before the patch, mmcblk0 was lost after every
> S3 cycle; after the patch, the card is reliably re-detected on resume.
>
> Fixes: 730876be2566 ("mfd: Add realtek USB card reader driver")
> Signed-off-by: Greg S <grigoryya@gmail.com>

Please re-send this to include Greg/Arnd, who is responsible for drivers/mi=
sc.

Kind regards
Uffe

> ---
> Changes in v2:
>   - Added Fixes tag (Ulf Hansson)
>
>   drivers/misc/cardreader/rtsx_usb.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
>
> diff --git a/drivers/misc/cardreader/rtsx_usb.c
> b/drivers/misc/cardreader/rtsx_usb.c
> index 2b3ae2914ec8..f1a3b5c7e912 100644
> --- a/drivers/misc/cardreader/rtsx_usb.c
> +++ b/drivers/misc/cardreader/rtsx_usb.c
> @@ -732,6 +732,18 @@ static int rtsx_usb_resume_child(struct device
> *dev, void *data)
>
>   static int rtsx_usb_resume(struct usb_interface *intf)
>   {
> +    struct rtsx_ucr *ucr =3D
> +        (struct rtsx_ucr *)usb_get_intfdata(intf);
> +
> +    /* After S3 suspend the chip loses its internal state and needs a fu=
ll
> +     * reset, identical to what reset_resume already does. Without this
> +     * the first command sent to the chip after resume times out
> +     * (-ETIMEDOUT) and the mmc subsystem never re-detects the card
> +     * (mmcblk0 disappears until the next reboot).
> +     *
> +     * Affected: at least RTS5129 on several laptop models.
> +     */
> +    rtsx_usb_reset_chip(ucr);
>       device_for_each_child(&intf->dev, NULL, rtsx_usb_resume_child);
>       return 0;
>   }
> --
> 2.43.0
