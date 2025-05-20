Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D748B126BFA
	for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747732597; cv=none; b=bVJiLdL4Am19Sy3dDctmuhqbJCJEE87XnRe3OyN5lbuLF0DNcqNiZlVZZD91NHPHTJySmQ8e0x7W58NkSwPDV6FD4eHbZwlYbGr6oSpKtOLW6ZWGmB0ZcYiRu9PUi9Zb+z34a4Z9YDC1WZmu9z2vzoyBKq1eRu8C0KY2M/zOHe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747732597; c=relaxed/simple;
	bh=DeX7wLvXQ62fy3Ty6alTXE03sXWD+dywuzc51HCa3nM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AEN+HAz9aFCWdiPkiggUNaUtfSpTs9D4HX167KhC2vSdLlW9q4SzmjRghjICC4jJlfLnFu4bLQ/m6vxqHwu/5Es4I9zWpRhfb6tBCSQWcMfWOY3TboByTCiRGfSPi5FiQXu7BiwiVwd0NeRZlyqfzbwWXXtgY4znJTtMlHYTq4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nnFEqODo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nnFEqODo"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K4Vesf023337
	for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 09:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LHIKeeyRiwuJPRAF5kDA8ET8445+AZFvYVJHBWlPckc=; b=nnFEqODoHmRoTtPW
	JYI7A/SFgOgKwJN2Z2UJekMdfMDI1Ce7klJw3KenlDGJmDj3SDcATIhAdfcxnFTw
	CpdahgQ+m3GPgAwNN1h6FwLAF3Hov89m42bwb67SYiCrAhI0eZ+PuwZb/4/FQ1da
	Z/hYoLz7sqSY2PriNt3eCtD+vfSVw11tEiY9Iv7yQGrRGuSQh9jM0GDJVzi0GyAY
	t8bKRzWYTQirVaWCIVR+cLqgEPLHXH06O8B4n1o/F8Q++3vf8JzfbH03/WOub0+G
	Amccp/ejNsXQq+afoXh4rJhyadFvntnIS7G4da/kNF8C7eJVNVLRngkOZVYGwHsD
	PGDl3A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46r041ut8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 09:16:34 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4767e6b4596so93432981cf.2
        for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 02:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747732593; x=1748337393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHIKeeyRiwuJPRAF5kDA8ET8445+AZFvYVJHBWlPckc=;
        b=k+IHPIxaUqQRxMp5fenR74DwA/Inc9abbb+0+mudBtB0b66WAYCtHIyA8ki4rOXorP
         RPm0bLsUHdcwm1HxRmfDoFhYzPSZAcihwa4h7fe83LkfIaVazRK6z0Qx6PlU4y8s4iSL
         xzLVxYkOz35JtIRF290t7SIJDEgKq8v+gOZfOi3oAsNhcKrFUMSEitjkwy5SEJrNyjAD
         9gENhcr2wy4UdlRox7mWvyIwW7y178nmh379bREzAYF2xecl/GIN7R9ZFbsFoIw5CUhW
         JSDKlIn9bfztBkUOF4fAgwjULvKisKg75IXdgeDB0caSESi0A6Np5ryKWi29q7p/nyQd
         +zUw==
X-Forwarded-Encrypted: i=1; AJvYcCXJCIqgBakLhdUFRLFV5eAwMWmZTcq9gVpugvgd1unSt+FP9fhEEt5R7qnF+PbsIuicdr9oLFXCSqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOLmKtkM+AxS6JCiztazsXyKwaKnnKXz/gBGgAOpPkNgc/PyUD
	DJugrZXSSxJuAMkHqopwcpEe+6TlZN2Az0OIzKcTvK+gV0ztZgPXYdm8FzgznFfJ/pRQOp4GK4i
	bDgaka1qAQxzuYHZ4texMIPAHeOv2fKhcy2UL+Z1qeBZ4EOPhZYyLgN6UHKZpCCNfOcP/uILoI3
	pzwhUVbZ7ZmXImLD6dB2xPv/f7AiE5fIrJBokb4TfLnvl2Aw==
X-Gm-Gg: ASbGncv3q18D0m/AtieYgDFnoTi+9WNzR64U204OmInofEefaSCKuK4IdoB7BQ9nq+B
	k78NmcYGVuHkhPlON+UiqItiiyKQE/3xlVzkNzvA/7Fkd/kssJUK1xLh1anTxGbG3XvYi/A==
X-Received: by 2002:a05:622a:1b29:b0:477:1f2f:1717 with SMTP id d75a77b69052e-494ae3ba064mr244025341cf.20.1747732593445;
        Tue, 20 May 2025 02:16:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfipv/F8VAB+nPMXH9W3KTZibrLVddwVc+EJ0ucDp4/cLOwlHGpgRd5GCanb4XOTkrqkWUvPDRyQOy5rjSyiM=
X-Received: by 2002:a05:622a:1b29:b0:477:1f2f:1717 with SMTP id
 d75a77b69052e-494ae3ba064mr244025131cf.20.1747732593065; Tue, 20 May 2025
 02:16:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507134538.575912-1-loic.poulain@oss.qualcomm.com> <PH7PR16MB61963BD3A3CDEB4F9D982BDEE59FA@PH7PR16MB6196.namprd16.prod.outlook.com>
In-Reply-To: <PH7PR16MB61963BD3A3CDEB4F9D982BDEE59FA@PH7PR16MB6196.namprd16.prod.outlook.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 20 May 2025 11:16:21 +0200
X-Gm-Features: AX0GCFsdEMUfrNRgX502KEYQu2qKQ96zu8Ia5W2CCXQrOqcf48vC_LHGTlQi0t4
Message-ID: <CAFEp6-1VkG4JpsTFS1w6X=7vXwoQabSbb4DeG1PUTCb+vm8XPQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: card: Scan the eMMC boot areas for partition table
To: Avri Altman <Avri.Altman@sandisk.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA3NSBTYWx0ZWRfXxKVYQlvd8yM3
 myKbHRqFjuC4Eo2bZ+R3PPpoG5NxWbCYljSxW5NzxmBxzFr8vvo6Q751J/6fe8PJ4p5AikQk7zf
 n8ewWXKoYcwfMmtrpPbsuw5bFL+P+O9KMLScf+NGxVb6d50+ZJPCfVX+zVmz1DIWFzmoTzlr1aW
 BhzsZhcscrJnCc3omZIrXqlMvoxEFpsJrj40tJCW5ke80Bpg3ePBceSBD6JBqZjXnUP3fgEspUe
 EK6zyWu62qOF+if7sHU/L9QKc5zY8B3uDbqte6tLUK/CI4n8mVdz9jFXEmuXm8mm2t5CivEVB2u
 Y3o7/lzhmuo/GWT3UwHlVepzYW1w1GauyB2dBwKe5JQls4EyMrGCktYOTklgyzNa+6wt7poHpzD
 +O2thocOck/UcFpplBFz6buAzn3IK6dFFa5VmKpHo6TNpTTb5fjh6m/hp/0SwFOIhjYy9bVX
X-Proofpoint-ORIG-GUID: wSFdUV75giLbp4BnqWHixVXTzA2Ylgty
X-Proofpoint-GUID: wSFdUV75giLbp4BnqWHixVXTzA2Ylgty
X-Authority-Analysis: v=2.4 cv=HIjDFptv c=1 sm=1 tr=0 ts=682c4872 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=InJrZTXqAAAA:8 a=EUspDBNiAAAA:8 a=Z-KoOJIlDxAInEDke3kA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=WwJ7OKCui7YMbFU4sWpb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505200075

On Tue, May 20, 2025 at 10:36=E2=80=AFAM Avri Altman <Avri.Altman@sandisk.c=
om> wrote:
>
> > It appears that some vendors provision the boot areas with valid part
> > tables (GPT) in order to have identifiable partitions for device and
> > firmware specific data, such has the qualcomm CDT (Qualcomm Config
> > Data Table). Additionally, these boot areas can be utilized to host
> > device-specific IDs, calibration data, and other critical information.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  drivers/mmc/core/block.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index 4830628510e6..c81925194509 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -2655,7 +2655,7 @@ static struct mmc_blk_data
> > *mmc_blk_alloc_req(struct mmc_card *card,
> >       md->disk->private_data =3D md;
> >       md->parent =3D parent;
> >       set_disk_ro(md->disk, md->read_only || default_ro);
> > -     if (area_type & (MMC_BLK_DATA_AREA_RPMB |
> > MMC_BLK_DATA_AREA_BOOT))
> > +     if (area_type & MMC_BLK_DATA_AREA_RPMB)
> >               md->disk->flags |=3D GENHD_FL_NO_PART;
> Given that the boot area is now exposed to accidental overwrites,
> Maybe add here a proper comment. Also even advise on boot wp options.

AFAIK, it's not more exposed than before, we may indeed register
additional mmcblk0boot0pX block devices, but the underlying hw boot
partition is still (software) write protected by default.

Regards,
Loic
