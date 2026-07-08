Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE11217D6
	for <linux-mmc@vger.kernel.org>; Wed,  8 Jul 2026 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506380; cv=pass; b=bPKdfTbOgT9sLZSYqPv8edGEZW2k+z4c5THlLJ4YADuWmsODsHTjVYlR/PeE7qjocRzk8wVYC7Dm7ogbM11GqUvK7x56e1oN56jBa3zsRW2WicsmfIl+ruSdOO9DvV07ESt8TuBhyIxPSDivdFpZsIclMe9JgmAdp46snRvvd70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506380; c=relaxed/simple;
	bh=3ev/+YfIXppAEAwzATVAqk20z1FdhQinR7SKJgPgtTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+as+cbpvFxb4GW4wuXkqDWwg5LCWybq7L1+fVzWYSnibnSkaTOK5GZ722SOc7NAtsv2EVviOMPVZBJAnCehXxRyM0Pisou3hPLad/3W2yQ1SMgUbpcIrgi1S6Dm6LyoiJdzU51YKKVRS6+L8eOS+dU5vxmQYgn7AscW6vJjPyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n6WmwXH4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BJNQI68Y; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n6WmwXH4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BJNQI68Y"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66888uGK2083213
	for <linux-mmc@vger.kernel.org>; Wed, 8 Jul 2026 10:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YdDu6SoFqZPOHIS2ZnXgu4+C/Jl5uEH8GvXTdMzz8xg=; b=n6WmwXH4D1BM8Vxc
	fUgIULFPZ+4iqc0lV7IkhquRncaEqoDH706EoPJigwoSWjP7Ahuxq213vBM/LoCq
	kh4DhEhx3TmCkzSP5uohZx3GqOz8UrRRIZO0b/L3H/zWjH+f14Rw0KMnqCMpMVOo
	CxGXob/F8bsOOW9+yJ/eUMrHJCB0Plr6Wa3/OQ/i+D9RXRuaBwsf9C/m1aXFUYGB
	qRBxsb+1O1AkzBYyrdUXLiI9xJRhUI6ghoCHrZg13FW7qyH8OuYaQWNTf0N8/F0X
	786bb1MJmTLFVcS2urnnBw8mvq1nYbAOnRNckv3Md+XbJeIDYWp9vIgg8Bq9ZkfN
	BRHIbw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9gqw93fu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 08 Jul 2026 10:26:18 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1d7886cdso10592301cf.1
        for <linux-mmc@vger.kernel.org>; Wed, 08 Jul 2026 03:26:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783506378; cv=none;
        d=google.com; s=arc-20260327;
        b=sk77GAScxybrCIjLLmypiTr3U0oNm0svfp41W9s7muQoDdXtx2E9CjIruUip1BA445
         cA7ef45XNE/sZH/qUH/h++NoW0pfG/dNs7bAwNQ2mL/N1NssmvUG1L0OcdvPvFYdpcbm
         PmXA4vBdCz7/O2edxPpqD18x9m5vZO0aQIws6iOp6oyYn0zrPE4jHxNR6jjmF8dzVbkl
         bw+VCxzbcO/MxMSHpAJo6gYHccFV2L/y3UJN8wLrT42fv6RyS7UJnAWQ488nYWzXXGWh
         2sDi+qPxshrniB2lOMVSPwKl7PXLYULxyta3AA1V41ROntcExruChi4S9j9cVOo27I7o
         2gTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YdDu6SoFqZPOHIS2ZnXgu4+C/Jl5uEH8GvXTdMzz8xg=;
        fh=Th3WDu8WIDeioYwD79PaJ39Uyn2cx8LtU9nVpFFncV0=;
        b=YiRrpYyXEfxtKX90SB/KVjq58V7XyI+Z8XjRAb7nByENd6RugUcvot9R8VkP1snIZu
         PjruSo2+7Ws6YAxabNLxMBViTjKBS1pquYrpHUEZUeTqqmZWj5KKLtaoCEvZXiw5z+/6
         M2H+pGja1xMx0QTX0OuR3rlYnlIt2+zXKwY19awXFRf8Koh9tI//+zDpkgIgPtMz/Y2y
         A9l+cK/mtfrzTp5gQNXknkC1IPX1hPFJqyP3l/uBoB+H5TqIoNY5pQfs9VDNN9xdTKKu
         hY/0tJBP+SgNQkOi2LE3KF3vNO1XNtPDdQqcmVKhH/ZoXS6P8ddxiDznyytR1drJ6iks
         IjRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783506378; x=1784111178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YdDu6SoFqZPOHIS2ZnXgu4+C/Jl5uEH8GvXTdMzz8xg=;
        b=BJNQI68YfeYBmi1gzRhwqPu2cb7AHvMYVg3ohonYxZwNtAo4ljt/uTqnAKHRwYBh3L
         PLF7Aq7tvEvDkJd3rO2yeCIULNQnsWR5/1gXhN6yEWBMsHN+3ERQMjn9Pwk8422UNRMI
         HPgm6UvejlD0Xap20ZKQVBEgbqgOPeKGkAPjGPflOckff0zKCzKMG5qluKTxIcn9HTz3
         At9jPlkN5dr98lbYvwmRIPJUWyLiMHFm0fddTTMfGm8vkTSXE/sYG6x3cGQywtlGGRyr
         xwAexfmoEezIszeASsp2Cbd7X8hR8Ws4Bc2VoK8zZlF8Cv8Kcq3MpZj2FXSyder8p6Dc
         Su1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783506378; x=1784111178;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YdDu6SoFqZPOHIS2ZnXgu4+C/Jl5uEH8GvXTdMzz8xg=;
        b=LQ9oOGbtwxI+eEH2A0ay6JUotre3lOZUsKsuh9FPIJSzTWVkcJ2SdrzuCr1qIJ+M6G
         wSG+WMbxFEGI8tH3Cwy8f5dUcANrdKAKUTJSwINb8i/8Ht0IkgK8RLFZKLaTw0TOD8Um
         IPjsYS8GagIQPgqCl+Oc3gRvM4ibtd28DuD14xWceHzjZyA1/LdXF8CoPga6w6BnYUbw
         XM5bBKpDN1YVuffGuQuey8bc/ORpYmzSFHdvxKCoXXZpfT1Ytkw3MAXHgdUs5z+U5NV9
         mHvu6gX/rx4t5teOjTR1La7Ute7MKb+Shi+pzHRDVbQ/uiSaU+w8LHDup3UN2eR7yZh2
         ZJxA==
X-Gm-Message-State: AOJu0YxEANN53cMO2w8G2P60tqnbf+a3DPEhoVjGwO1reTBZeSDzOmd/
	TA0Mzo6TFYE6ter9ccVMGJwdryzaHFw1tq4oyTG0+nRMfm/tgCdj+f9BLp5MPpI/jEOHTMIKyrf
	x7dfuZZhjQLXXO/z6PIUplw9xj5ILGTxoG9jNaMAHDlSfLuxmsydYhsOJqZYDgy6LhbSt+YE4RL
	QteF6GISbjfvUx4SyZ+L4BWCtDsn0JatVLvxGpNuvcyOMFPQ==
X-Gm-Gg: AfdE7clVGILZPjl5siONSWIvMXOr0pb3vjUDPljYg0c2IPhbTWLW+pcp5o1vO4XyRmU
	+Pk4hx/9/mr4UMNy0x+df9y9tB08W3sDp0NxeJEbxer+W0w1zBp+maEDZ6lCuORYpJ/WeAClF4f
	7G26gpn/SfSE6/bbefqMUjfsTPECt8p+yeQkb3Phcka4M/8vuTB9iC+BseT4SdYCX6Qv/T
X-Received: by 2002:a05:622a:28b:b0:51c:100f:f91e with SMTP id d75a77b69052e-51c8b409e16mr20584581cf.72.1783506377744;
        Wed, 08 Jul 2026 03:26:17 -0700 (PDT)
X-Received: by 2002:a05:622a:28b:b0:51c:100f:f91e with SMTP id
 d75a77b69052e-51c8b409e16mr20584381cf.72.1783506377375; Wed, 08 Jul 2026
 03:26:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706154253.125106-1-ulf.hansson@oss.qualcomm.com> <DS1PR16MB6753D48AC460C82A309E5E80E5F02@DS1PR16MB6753.namprd16.prod.outlook.com>
In-Reply-To: <DS1PR16MB6753D48AC460C82A309E5E80E5F02@DS1PR16MB6753.namprd16.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 12:26:05 +0200
X-Gm-Features: AVVi8CcEzUbSRSvzb1ft3E2TP22HExPqrD68of6dV7F_ola-nbh4z8x4JisA8Gw
Message-ID: <CAPx+jO8bV3HoLQYV1GV8+0EfbVNeDBZANrkjSypySEYT+oEx3w@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: Update maintainers email
To: Avri Altman <Avri.Altman@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulfh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEwMCBTYWx0ZWRfX8I2PxN0Y94cr
 wze8ToT7EMqcS2r9Z8/KUaTsHZMuTjGfZDGOZkMV6JAdNFzLJj6q60mdxRzaYvpV+WOqo3pMT/c
 Fpw0clMDl/Eeyz/Ab9geK507FIdIoUXL+WUrAKu6/o/+mMZToVe2AgaoOjz3nn0tFDvKYMi/C3r
 4fSRvuSCD8bSZNvIgUKiJXtSkY90rKM56rkyz9xbLRvT2PNZhatTpWwJzJ6LlX6ZBEB7kKwbtVp
 9qlQPzlaqyCs7Jm9pEFMa9HP3idFahgCA1XnTiru4dcR5jgnWC0qk6SiOQkKzKPeK4dudLrumQi
 /tE5/AIgrf+GarEGq41+v6+G0x31iB2XRYKezgKmLNA5MLKLRumv4aPHe3nOv1Zvv03FoPtkMI2
 ox6agR53Cz9GdrhNLtYX0i/gaGBK8V6CMg17BpFQ9n4DUjLejgxVuMaIX+N4UMxTdPs2nGEXjpj
 B3m5mqRfidFBguJOyqA==
X-Proofpoint-GUID: mZj-s4v93waemKnXb0P_w-2vz1vcPz4x
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEwMCBTYWx0ZWRfX6qkfTv/EN6/e
 ZYnEUGEP1JVmTKMzoDNraKKK004pW9+Buc57mfZkC/T14SgaMU7clD5nufTIzJwW5zWatP+pV9S
 zysF2yMHvNaojLc0Nv3V8VZiItdWizw=
X-Proofpoint-ORIG-GUID: mZj-s4v93waemKnXb0P_w-2vz1vcPz4x
X-Authority-Analysis: v=2.4 cv=Wf88rUhX c=1 sm=1 tr=0 ts=6a4e25ca cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=InJrZTXqAAAA:8 a=VwQbUJbxAAAA:8 a=JF9118EUAAAA:8
 a=oUnndiIZR4O9LTqUX7QA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=WwJ7OKCui7YMbFU4sWpb:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080100

On Tue, Jul 7, 2026 at 8:38=E2=80=AFAM Avri Altman <Avri.Altman@sandisk.com=
> wrote:
>
> > From: Ulf Hansson <ulfh@kernel.org>
> >
> > I am no longer working for Linaro but have moved to Qualcomm. That said=
, I will
> > continue to help maintaining mmc-utils. Update my email to my kernel.or=
g alias
> > to reflect this.
> >
> > Signed-off-by: Ulf Hansson <ulfh@kernel.org>
> Reviewed-by: Avri Altman <avri.altman@sandisk.com>
>
> > ---
> >  README          | 2 +-
> >  docs/README.rst | 2 +-
> >  mmc.1           | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/README b/README
> > index f18fcde..0c22710 100644
> > --- a/README
> > +++ b/README
> > @@ -27,7 +27,7 @@ Maintainers
> >  -----------
> >
> While at it:
> >  Avri Altman <avri.altman@wdc.com>
> Avri Altman <avri.altman@sandisk.com>

I amended the patch to update your email too.

Applied for mmc-utils master, thanks!

[...]

Kind regards
Uffe
