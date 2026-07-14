Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431FD46AECD
	for <linux-mmc@vger.kernel.org>; Tue, 14 Jul 2026 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035959; cv=pass; b=QKV9EedaXObZPSaflqnY5iG4kk5zhuDHWTaWK7Zj8xA3QdRZXDSA0CkBxRHPjedtNPNLXHCfHnWmnGA5pDFTUqlrk431RDm/VW5D14OgKdJ2mWjNyJsWSyLXzae+xVPC5VQt0mFMMPmHMWSz2mxN1Ti2fPs8Dy62neCTnq+sR1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035959; c=relaxed/simple;
	bh=YA+5EsPUoLqPeNYJZLCKA/VvdOZbROh/4Mj2wOXxniw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUD+eZq8af5rjNqZOYzbMVARg+CUISIFoea7RS3kgCrg/n0aAsUvaEW++DBMZwsVhxDnu15Fb2yt+CO39Fw48jaCBYvpFhS4YkyYqh8LuIA3pBZGUCmQnh0jzaxcF/atlU/lJmKLSRBKIN2SoyjGlrFQxzqF1cXcw6xSP23zCjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OsoOfVXf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d0M820qz; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OsoOfVXf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d0M820qz"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBNrht377281
	for <linux-mmc@vger.kernel.org>; Tue, 14 Jul 2026 13:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YA+5EsPUoLqPeNYJZLCKA/VvdOZbROh/4Mj2wOXxniw=; b=OsoOfVXfd8MgaJYV
	hsB0bp4GUR9CbAaDW43r2A7E2jdiVYFQsaDDtAXPHj5sk9byWh41Eppk+j3iMor9
	kIFSbhxGeWxORlHjPRBiV+E5VQAEBdSqPkHYa/VHoFKkBg1p554N1l/OcxUCUh4Q
	3JHizGL7/O6OedKqWsyfzqx8i8k5yejGgjRy3CS6o8csaIG9LTYJqaJpIAL8NV3y
	hCqIuKGCspW+lPFFWuMotbdzPNA35gMlKOvkVZhbypvQ4DJ7qDIt8IMMxxkf32xP
	GiNqvjhHnFyHrgIAD7s/A16kCyXlGPVKlkwyhLO7eOQRFPQ44C1Xa57iTmYBDwJN
	5CQnTA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdbr4agyd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 14 Jul 2026 13:32:37 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c2af04aeeso12994161cf.0
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jul 2026 06:32:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784035956; cv=none;
        d=google.com; s=arc-20260327;
        b=Hu9/NkA0jnrOlUPzhx6LAXtffkn7ZmqIfGv7ym2QoxtuScEPGNWGT+VwYBGqp1+Vfr
         jCJYF2qbnU7d722PuedMTs3H+VxMyIs0mUJ3dEWbIfP+LEDUgTb+uLIAkSvkudF8J9IW
         0xJbxOB4v3SgNMur12hRrKG5764+GkdsTVG+WBP9H2c2q/I5JrJFZaXfr85fMCPrDinW
         KXIHBq5xgOnF42F76CqKHqdWvsWCszLzmd3J9nV3o4/1/R/huut6jmoCPsNcGX5QyPIM
         XGEaObuwcrR0G9riGEDrcYiXLLywH6Fa+qDoaKEjaSjMgjxtrhn8SULHmj6IGoUeE9JV
         dG8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YA+5EsPUoLqPeNYJZLCKA/VvdOZbROh/4Mj2wOXxniw=;
        fh=XbN9KhyeWzP4S0Sxx8O+nQvO2WTy9AZHXA82BkmnXHU=;
        b=RTY0Fe8WeAHCZbkFbsbwvTLIyBxchdW7glVNRGfali/yDZ6OruxXJ3tCrEeCf/bGI0
         V1ynqrU4qdQVf7QIlWzXNB3ypN4gTZxnxqn8VprGYwp22O5cCtZURgzmQ1Bi7jPF4Bo2
         A0wdrOMCePsy3lYw4SvYRBYJxLVgfmyxd0oa/f9NIFv0oXbYyXyAnbJautPvkKdexv/k
         vNpUUoBwzRPKHZmt9/ByrruAPHYQ767HG9OQx6gl4BFo7imVwa1SnNgCN1XtGJooetne
         tiC37osWUN/odd4rKWDw+OP/uHyHOT8ISZUiS9jINzwr3XRO5jXV/nSRrDoCTEvdRfQU
         Dppg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784035956; x=1784640756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YA+5EsPUoLqPeNYJZLCKA/VvdOZbROh/4Mj2wOXxniw=;
        b=d0M820qzC1XhZ7L31ZKirU58axiyNSHzk/60WQMh/1yKgdEFo2xiNRw/Vos3M6LRbt
         /e151cRPKO9Tjbl7RxBhY2BJidgPOs0XBLiREiNOT+53y7m4r9iwoM0hrqD4PqnFu862
         /eWgxnLJZRq9yUZpovEwbwuuwPyh4QKXAxy+6QRDlSBREN7f/N8/0E8hVHM72mF3VQ5H
         kuBbBArT4y9ieko9p2XarDPFssg5TFi6COWj1uduG1QLVjz3/3HMs8jk3PJEv/nnQQJE
         ygMxuYXLH6ezBZ2Fd3AqBExeQYbtsRxVYjoNSI7hGfxiZ+Fl6ulpR8PCmAIeLvHbM3mR
         tbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035956; x=1784640756;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YA+5EsPUoLqPeNYJZLCKA/VvdOZbROh/4Mj2wOXxniw=;
        b=r45rbJmPDZyehYQx8+U5it49EJFGd38B5raY2ZyVXsDcqZ61YYcnofXIHjN35puxi1
         DeG6BdHxPq8sYzV0oA7DMiQ0clThV+hJ16RwBMDq0EV/l9oyenkLBEnV/5zOdDG1QRbk
         tCckaWoDVKEQAI1/gYB7vWca/YA7+5f4ImGxDO8f/gRhsB1TM4KRPJnQJZDNNBUjQ7cv
         0N9fMd5iaNxFlL7AcQGCt7LLCU99waOp+V0P14Q9HsLuxZzNcIq9wuS5hSfXiU2BtP/c
         pTc+iRrJCkbZlDVgKLCEuvabue4rgrBVMXTYTiwrMgFsUeqKjZHuqqiFU/JyU0v2KOwS
         23wA==
X-Forwarded-Encrypted: i=1; AHgh+RrgVRqjHV/hbgmeCnfoEcCphnj+38vnoYTtIZjmWDbXWKwyQuQoQj/u3MzQGhB/g+cZM04N/sicFpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHcX3dy18/d152mffBnaXlI2qLNi3/010bD4BGcqxkqLrD4QBU
	p4enP+GwLj912Iezp3Wl9nLj0d8jthQds+nT3wg/iDZk+oXLR3g+/Whz8ip9cGBIrBKO13QL9uH
	X4cP67OU7RftP8/8ocHhmoNzfnJuXphj4KERSt5JSoqZMdjhraJjLJOWynbMMnzRQSXsBY+SEfe
	gE28MKh6+6wPH2sojP0OIKsj5Pgx0aVTaDiQbI2A==
X-Gm-Gg: AfdE7cnXDvoIwn0e6HG16cIInt5SQnVpd45SNAlpOjCY1lsQtxfq5Xq/nLFcZBk1Wcj
	WX+I6r3cSPv3M/AqwblGc0uBnrUOxjTqIhLEdkyjn2NU2AIMiZ6ObBEe1m4rCsQgNyQhLCHJDv3
	aHaH2jVac4ti1U9njR8jtziXcuYSZl81NIbPun7yewYF36roO9xV0NB6//fmdVZRVsDvpm
X-Received: by 2002:ac8:7f92:0:b0:51b:feb2:3827 with SMTP id d75a77b69052e-51caa1702a5mr171845331cf.32.1784035956332;
        Tue, 14 Jul 2026 06:32:36 -0700 (PDT)
X-Received: by 2002:ac8:7f92:0:b0:51b:feb2:3827 with SMTP id
 d75a77b69052e-51caa1702a5mr171844951cf.32.1784035955793; Tue, 14 Jul 2026
 06:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_D7DC335840B22B81B4E99D8745DC7E46E205@qq.com>
 <tencent_B87ADA0AC8756D910EBF93B2F0D92348280A@qq.com> <LV8PR16MB6757B239DFE2F2CD13D78F69E5F92@LV8PR16MB6757.namprd16.prod.outlook.com>
In-Reply-To: <LV8PR16MB6757B239DFE2F2CD13D78F69E5F92@LV8PR16MB6757.namprd16.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 15:32:25 +0200
X-Gm-Features: AUfX_mzLdljIejiA0y_fuciZCHvzX1H8Yf4koX8uwK8RDSRx_3-vNFS-fDngM9w
Message-ID: <CAPx+jO9SN8pMYgomOSN7eWt2KyeZbbm4d1H28ZBaTtAnNeXrVw@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: lsmmc.c: Add ATP to SD Card Manufacturer ID database
To: Avri Altman <Avri.Altman@sandisk.com>
Cc: Wei Cheng <wei.cheng.kernel@qq.com>, "ulfh@kernel.org" <ulfh@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 7fJcQuVsLSIcyDWcorRQofe-HIAdJo2K
X-Proofpoint-ORIG-GUID: 7fJcQuVsLSIcyDWcorRQofe-HIAdJo2K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEzOSBTYWx0ZWRfX+mxLJsmc7Xas
 jWuKIxsXsJ8v6JdRgvyBI5JhGSf/ulzGx4Vv7Nn85PdqwP7kk01MyyGGZNCYxOgmCbTQ9lu7pb+
 OrquJo7d38sYaIj3kJWaHmOG0uQfnSuhVVGDpD/i6nIunml4cjasC6P8WmNDEd9xKL5rV42d1+u
 kApRC8EIjntxE6J2+1M6IVZO1bfCx3S4fzqbkbYDIPb6x8+GMzebrDMeJGIF0dKGHf56FPwvKxh
 7M3dWm+TrZH2/S3DV0AS+P/xzkBpr54qU8Pf9FfwnP69tx84U67N4COh3eEDF9zbFoaCRmMui+O
 52QR96c7Ecvx4q0awveIGaAd+TZHHcm3PR8Rmlw7PoG5hXFIg8AKK0cJjMFMi6DJ/1lFBWarcL5
 W4xs2Z1SrHT1L/WdwjqaBJKXd5qlxVhI5KaQYbas7zMv0Lb/oHnnxoSk1bl2EP6App1YRq0MMFB
 buB0dZOPrkjI9KM8OFA==
X-Authority-Analysis: v=2.4 cv=F5hnsKhN c=1 sm=1 tr=0 ts=6a563a75 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=InJrZTXqAAAA:8 a=dZbOZ2KzAAAA:8
 a=cHikrBIX8_bq55q98tAA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=WwJ7OKCui7YMbFU4sWpb:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEzOSBTYWx0ZWRfX6T9Cdz1sRfvp
 y5pTIFMTWs0TlsBu58Yw0uG3ffEKXo88wIfFdr/6qkplu9N9nmribjAwmJfDfHePmWtLcedf4wq
 QuaPe5VnmZN5GwMOMJ1eorpy7RE+VNo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140139

On Tue, Jul 14, 2026 at 7:01=E2=80=AFAM Avri Altman <Avri.Altman@sandisk.co=
m> wrote:
>
> > On 2026-06-13 23:04, Wei Cheng wrote:
> > >The current sd_database does not contain an entry for ATP (Manufacture=
r ID
> > 0x09).
> > >Add it so that lsmmc can correctly identify ATP SD cards.
> > >
> > >Verified on ATP AF4GUDI-OEM microSD.
> > >
> > >Signed-off-by: Wei Cheng <wei.cheng.kernel@qq.com>
> >
> > Hi Maintainers,
> >
> > Friendly ping. Could you please share any feedback or concerns regardin=
g this
> > patch?
> I acked this patch a month ago.
>
> Thanks,
> Avri
>
> >
> > Best regards,
> > Wei Cheng
>

My apologies, I didn't notify you when applying. This has been on the
master branch for mmc-utils since 6th of July.

Kind regards
Uffe
