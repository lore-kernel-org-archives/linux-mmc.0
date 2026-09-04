Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944DE382299
	for <linux-mmc@vger.kernel.org>; Fri,  4 Sep 2026 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788513776; cv=pass; b=PzAre53Ntzud0d7N3xf7mgWLMLC3Q6AFYXJzw78KR7TCEsxhDg1YVkG+lCL+oVLjwbRPVcOl8rK857SJ7lDVCYDXWazMdy1GkuyYdAlk3yVvISjHv4Qg7FgDQ5oRjQUbUeIULRWQg8lA4ufNBcUQ+kBp97wbPAaNPNiViqWGiig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788513776; c=relaxed/simple;
	bh=MaCyfCv+TwiVUuzMSGnP+Dn6DRg+dBPkSjGxowUnxU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1gih1kkX+iTiGh4WkOuDJt0ouQXdBZJyzmvmxtMQJEoDLHKW0pssIm9IA56lenMiA4CDnoi3oaRhpUFufayCnT1gyBvnBjNvu6mkVPv+43z/NKlNNdoH5y33C0KpRGuNimY2QBOn1zO/6OMZExGtPhvtHspZfCQfHvZNv6FuBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e/dnvYyI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jAz+r9Pu; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e/dnvYyI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jAz+r9Pu"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847n4Ux2976861
	for <linux-mmc@vger.kernel.org>; Fri, 4 Sep 2026 09:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QCdqFTh7+jBR0H9xZjvVZ/K2jxBC+2DutLqXoi0PoGs=; b=e/dnvYyIhry6fmiS
	FtXVagYmz5K8J23HgnohOh21bdLg0iLGoxttEwkqu6WmxMLg4m25puxRZPMEvIXd
	054Tem5buCkPSweENUXwDhmRWZRtjZ2nF1YdE1sGNPKW8TZag1e4zSgQmFlOunNa
	xFKjvYxyXS+5aFk3rIbEyfAb69Alk6D+q/j9hwmvIvcjBw9xzM3kwmiRrYjQhJEG
	3Bx/vz84+wLqbVhzPc4tWYvskfnTX9NuTd4v6qVCthfZGnrk+rf8dM4hO1THs8QI
	ESoL0HADFmLLzPEUBE7cn9GqnqA8xM3DK6swizZ8BASGrzg8fAWX3c3elP6dv2Po
	evfyoQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfdyxjvw5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Fri, 04 Sep 2026 09:22:43 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38ec0f510a9so1661053a91.2
        for <linux-mmc@vger.kernel.org>; Fri, 04 Sep 2026 02:22:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788513762; cv=none;
        d=google.com; s=arc-20260327;
        b=rLf6YEsB7qbDfxoEgnoxLCn69Ty/NTpDJH+RgckyaoWKCSOLJvGsNyWXy81hUDl2dS
         +NOJXrHcKFgi9/2TZ1IMVMcdi+9R+WC8lm5nJL9JvsjrW9FhbyuPtISEph7c+qyqV6tZ
         74lYm0McLXCb8DEMhj20EOragRI3wxORVGmGL+j6UbeuBdr933mR8wBf9skd2eAJbwnh
         JW3FMjjGBI0LprMCTwaDhEnqHAlLoHRlZysJzqG7HLxCOhZLDdwpUPck++SGoj7aZTbn
         D9drH2rs8tIZZPr0LwbglKvIH11iNofH9XkWKoFv9F8iu8DS+Ifr8NF/I1PCssYS2hbG
         3uiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QCdqFTh7+jBR0H9xZjvVZ/K2jxBC+2DutLqXoi0PoGs=;
        fh=+t815E31V5yjeXmAUcD3bcAXbkpB6VxFE5NCszo4U/I=;
        b=B+qxBTgm/PJUbjTOaaJVkq00sLpTFIBt/AmDczLkT0Nzn5rxeEpDL1thOnl7nV7GM1
         QSpn9kqhZbUTokx0giuxDuj4R1farJX7QM+DRLlKeU0eLzT2gBCnSWs0Zx6+7iNe2cDn
         S0w8sCrNTQREY/bqGsDbBaGPzltelq45+g8l0t8iudQZ388YFxSOJT4nuvRKbRTXcxij
         g8CpahTGSPBut08hIg9XpOYxZw9jHQWk0cCl0cGGfxC/XZQXKGL4oyCE0stG81B0DqC1
         hGuu7c1j+CEW+Uc1TNEfmVQkSWFdzkRRho1QXr2eY2DOYXrwQTIz+iIQRZTSurNzz9MG
         UScQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788513762; x=1789118562; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QCdqFTh7+jBR0H9xZjvVZ/K2jxBC+2DutLqXoi0PoGs=;
        b=jAz+r9PuVib2wRpMEi63DVPLE+freklducXT2gtSt1liRfI9/aYSRdLIumh+u6ntA7
         s8FStRwIdwpe45LBsmet/FA+oC4T9L9TdG2JbpG/3v1gk2pfIlRRuw7PnVukj78d93q2
         MBEbBleV0H1SBset3nqh7IEOmm8Fvra9w9nwUNWQW4ZVJ0QXkD0+Lx/TEiNUKOO1GRUh
         jRftYA2Q8U1R2Ot9baykT50/BsEV3XuMWv3GmNqIGV3i5oAbvnNDa+iYuRhXN1SHCy2X
         QRaGlf/rq9xMUT5OICV3I4D9SnlFC2ftup4npt0dJz4ZxmI2uEvSGIT7y3ndDXw5Bgug
         efcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788513762; x=1789118562;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QCdqFTh7+jBR0H9xZjvVZ/K2jxBC+2DutLqXoi0PoGs=;
        b=R32AU8XS2LtNS73tWfliZES2eq8Nb1wB0WqsBRpKRlGTdo8AGBjgUR64rzapRn+Hxz
         8d55IzTbCEb1b1xI3C7Ft3kNfG9HdHBuH8ddVUrUR0NK8JOISitRWdjtlosY33XdXHjW
         v2z8tlkBH2z9G6Y25lePm3lpgSHA42rSaNPD+FDEUFLU1JW59x6bHun9Emn9wfLtgQDG
         1LF9LQIEAJ2SQ8KNGGPcV3LSyTV11WzWvA0WZSaC1DiBYQ0qwbEUKi/ckTiHrhfqWG+T
         OOHYu4yBjJAa0jmKkw3i8XCpJM0B3EcLGCqqd/a3vfKbtLYtjXpf+cHpwXFyq7AUK1OZ
         McDA==
X-Gm-Message-State: AFuF++mdTxbr9tZvk6kWcYN1bf0KktlVXTzhJL9tkimhG1PQ8Tb+PoGy
	q5biDrO+zq8SAuKZ8jmS8IBGJiTTOW+pOcXIAXWweFWyos3LiUF5YHYXI/pR13riqKidl9XM2e2
	GU3r221Ut1stEW9LwqdI5s8/lRV5KlvwKBXzv1JdRvuI8XKRFmhfgUXP0haYxyXwYb/Moktv7HR
	qcWkg5eKGc9YslicHVgQA5M8qhJ573G7NNyMdkMJ3SsVWxpQ==
X-Gm-Gg: AYBFou02e2zGkc8zMj9F0BRHIJ51sl6bwl2lua946CrA9lQBgsMUcnqSPVO2YYxwNtt
	iDubDFbTUufmnzWgOtH0E86B4in4yto0PCuNOApHAjWri0hJ4l3M+y1Cj6KIG3pgXqBP5THA/pL
	j0rRFCH2qhzRD2SQeYeO2eg6mOBIscKjDyUa00y8MiGPoM7VD56W0WeWmjqw==
X-Received: by 2002:a17:90a:d647:b0:38e:70d5:b12d with SMTP id 98e67ed59e1d1-39b261074camr7306894a91.6.1788513762546;
        Fri, 04 Sep 2026 02:22:42 -0700 (PDT)
X-Received: by 2002:a17:90a:d647:b0:38e:70d5:b12d with SMTP id
 98e67ed59e1d1-39b261074camr7306871a91.6.1788513762172; Fri, 04 Sep 2026
 02:22:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808131227.23319-1-matt@mattbrocklehurst.co.uk>
In-Reply-To: <20260808131227.23319-1-matt@mattbrocklehurst.co.uk>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 11:22:30 +0200
X-Gm-Features: AcwNN1XCcUAKI4nA5ypOmubH4IwHkPLSTUxynWf58lKdRZ6FB80XxUo95qhYYjU
Message-ID: <CAPx+jO81yfLb8jAdeoK=r7TBysLC=D1=+01P-sQ2LTdiUWrZcA@mail.gmail.com>
Subject: Re: [PATCH] mmc: bcm2835: guard against host->data being NULL in bcm2835_finish_data()
To: Matt Brocklehurst <matt@mattbrocklehurst.co.uk>
Cc: linux-mmc@vger.kernel.org, ulfh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: iX36pLHzZKZNDBLXQUjPF4JQ1yVYPf3N
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4NSBTYWx0ZWRfX4E+ug9CJTq+W
 ApK+L/Rz3YMr/cvYQhS9y15R6aM4sLGvb/D/AgJvhx87RCekQW0IxY+IDEDUjNcrjjmpUNUzMXV
 U6PZe/srgH62yp1DL6WW0oovgZrCGjU=
X-Proofpoint-GUID: iX36pLHzZKZNDBLXQUjPF4JQ1yVYPf3N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4NSBTYWx0ZWRfX/vym/nGJyXF4
 Y2tB6wEsG4vq6RQPscAv0GUCZTvMRpQyLCCmY5SGIP8Ht9cV0GMOVgolP4Jpr73f0ggbXtnO9Jh
 3zjFKgQVa4dDNYVNtVKtF2r3PtVIPHQGrnoAEo6X6SikeQ6ti/dMsd12FfhdrbobhtwjvcRVER5
 k6+7ydxzrJ/u9i6P+JNY+FG75IN3k4+w4X8XYjzTPPyYyvD2+utDAvpDGj7vH6QiSrlwbes2QIs
 gHGlWFG+d1wOR0bSgjzWaY5Lffazmj3IWaHVoG8gldWGmPpimS0hPQnt7XEWwjadkq149Ok/Fj2
 LA94HYkZrva0CTY5Ih0Lh+5fHzU6fKEVRSrV8DmFqG+bN35i/NOBTF7l/fioIwgsHlTKS6rvb/2
 efr2nXf05GCfVOyOvLCcxLcw9OFMZAmAFv0JkBR+pFVo4R9XTSw3yZ972WaeZNiLBWZGSVDBp35
 gjMkZ3Gc5yeyhOFHltQ==
X-Authority-Analysis: v=2.4 cv=X9Zi7mTe c=1 sm=1 tr=0 ts=6a9a8de3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=bthdtukkAAAA:8 a=CDZsqdpO8dA0sIgnNqQA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=HSo7FmG8fZO9Wf3kydLG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040085

On Sat, Aug 8, 2026 at 3:12=E2=80=AFPM Matt Brocklehurst
<matt@mattbrocklehurst.co.uk> wrote:
>
> bcm2835_dma_complete_work() calls bcm2835_finish_data() unconditionally
> from a workqueue once the DMA engine signals completion. But the same
> transfer can also complete via the interrupt/status-poll path first
> (bcm2835_finish_data() -> bcm2835_transfer_complete(), which sets
> host->data =3D NULL) before that deferred DMA-completion callback gets
> to run. When the DMA-completion path loses that race, host->data is
> already NULL and the next line dereferences it unconditionally.
>
> Hit this as a real NULL pointer dereference while bringing up BCM2836/
> BCM2837 support in a downstream build system, confirmed live via a
> kernel panic on the serial console:
>
>   Unable to handle kernel NULL pointer dereference at virtual address 000=
00014
>   PC is at bcm2835_finish_data+0x28/0x60
>   ...
>   bcm2835_finish_data from bcm2835_dma_complete_work+0xf8/0x124
>
> This code path is only reachable once a DMA transfer actually
> completes successfully, which is presumably why it hasn't surfaced
> before on setups where DMA transfers complete quickly and reliably --
> the race window is narrow. It is not specific to any particular SoC
> or devicetree configuration; both bcm2835_finish_data() and
> bcm2835_dma_complete_work() are unchanged from mainline, so any board
> using this driver can hit it.
>
> Signed-off-by: Matt Brocklehurst <matt@mattbrocklehurst.co.uk>

The patch looks good to me, but please resend to include the Broadcom
guys that help to maintain this driver.

Kind regards
Uffe

> ---
>  drivers/mmc/host/bcm2835.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index ee63835..fbcdfac 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -717,6 +717,17 @@ static void bcm2835_finish_data(struct bcm2835_host =
*host)
>
>         data =3D host->data;
>
> +       /*
> +        * host->data can already be NULL here: bcm2835_dma_complete_work=
()
> +        * calls this unconditionally from a workqueue, but the same
> +        * transfer may already have completed via the interrupt/status-p=
oll
> +        * path (bcm2835_finish_data() -> bcm2835_transfer_complete(), wh=
ich
> +        * sets host->data =3D NULL) before the deferred DMA-completion
> +        * callback runs.
> +        */
> +       if (!data)
> +               return;
> +
>         host->hcfg &=3D ~(SDHCFG_DATA_IRPT_EN | SDHCFG_BLOCK_IRPT_EN);
>         writel(host->hcfg, host->ioaddr + SDHCFG);
>
> --
> 2.39.5 (Apple Git-154)
>
