Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1831747A874
	for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2026 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760464; cv=pass; b=V71uHT7E+lxe38UOswFGD6iO7vaH79VYoLvkfbocnQC0X+G037KKQUvNSgVpqcTeZz9y0ONihANHf9bC9sWBKD9dP7ngx3a72iOxXV4Il/8dCpcxd4eyVrhhgwmk6g9J1eX2uJZWV4gHT0XdN1+/clHPerG/YPSrMl693GjmD+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760464; c=relaxed/simple;
	bh=xvB8CtGkLAMcNbtsL8XIugW8QxxO9PWbIr6GZS0uzbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKxBexBtt1E4NYkGTnj1zSLHacywZ2RevxMUMs420CGcJsCTBjLOQBs06wyNulFrlcBy/yn/ZcrYefDEr8qft/01R8ERrtY5wxsfDznucspMRTQJZlMuDBmpSotXygQ+j1zqNBhst+g1XfppX6P2llP2yXfL4/PDYz3FzWGMKIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hxZcIdBn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cLOVDXnF; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hxZcIdBn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cLOVDXnF"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U7dVgN2119208
	for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2026 09:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aas5dFpRUJyHYCp7dUKEi7p5PXcPa3N+KVeAt5vuJzo=; b=hxZcIdBnBZT671Aa
	Tn1fS6wYB5ZiDEO49xdsMfjoZpM+E7lzUVYEZtMxuFbKxuKgdNP6O8Qn5QIKjBsm
	wJCgzaG2/lFpvx9XDJrCtUe+qxbguo1S2b4CbRIKQDtVt79e0JShciJJwepw/1LY
	SzHPFthHkJIf/fOcCV8JEOcZW9y2+2RlTk5Ks1JmcQeEN2JQQA8yNbCIyEKWOQv1
	UUo/RsGo7TAejIXnwANrQ2EkUY+4nJ3YOhQP+mOfBj1wzMQT5pBXr3sQDDHresQd
	K/0Qy2c8Uf8vQBu3FOdkrtBniQeWTx12E63t7VTq2LOLXsypmtxyGBe+6P+MPfgB
	Ht21bw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0rhej0x4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2026 09:27:41 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3a0be20102fso4910941a91.0
        for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2026 02:27:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790760461; cv=none;
        d=google.com; s=arc-20260327;
        b=HtuQ6FRfKhN08tptd6FdoXyeQzAqJxc3p3gef2o+XRZPgHLqkcjy4swoR9nOeLYslH
         MidOj1xCVpdDuIgW2sa8c8VJtAWwG8ARU8Z6auA8vAgqRZzTykNgDSOVoZRDV1SaXgQ8
         SQeUqnpvfPa7l4gqVChclbjjdJTkLyCF38kk6uD9taP/e49kk2WkqExjyOdfxbu7LXXo
         NalohN9msYtVKxSV6uCSZoUomRbHpidKMi6K6DTh547kAh6XozyQHlmH55e4Bb4fAnwW
         7Nr1Y4rkkfUHUKmWWgNHtGz54Rb5q/TSKIIqWy7kRnukrcDesVmPf9tREi2CAwbCSmwG
         Y5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aas5dFpRUJyHYCp7dUKEi7p5PXcPa3N+KVeAt5vuJzo=;
        fh=YdAKoMZyEt84tU1G8/acZxzLIGHPduDMKhLCYIVEC6o=;
        b=CEA62bd9dt9uwFe2H/m6iks+/OL551mN6AXteTH4b/GJWVjaHANDOYci1AA7Rmeecy
         U3QV2XTmnEyuelTx996wQr1AwBCqINwMPujaCGPDaambB5ZvqwCu1lucln0YbRTAhH+S
         oUWaLh/6b01Z5UPRLQuDVaGDllG0P2VrarF0ChY70cHoQJLAtGGGDVlGfz5lWamDrk6v
         aZ1th903SU9Q4MyfZ3P7ZTV3XEFS78ukIb63Ln3IhZ7EGr2x7N7BiA2YJAcadvHsyde0
         vhPquXu8LU/Bs3OuZevRVr7c299B7O9tfIh30HatIMVWaAcMvcDtkjCyyIVu1FyrSdKG
         vjGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790760461; x=1791365261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aas5dFpRUJyHYCp7dUKEi7p5PXcPa3N+KVeAt5vuJzo=;
        b=cLOVDXnF4vBCpF/muOy1Kdd06Jfe66DmlT7ZYHSf81U47O0br5oikzHVret/qvgh1v
         fo4LlOU+2rayWRmVbI3Me47/yf6BAwxaUeMBLpKIVyG0G61yiamOjjuGT+7RymkkZb4r
         2cTzTFTvjqnOCl088Q4bOUno4cdAs6kjLuVZqoNTeONfOdWa4/I7gTLj04p6Gyx3rdVS
         fuTP6MmCqmGMVCr+NCyyxsY0loCvz8BZ3dF1CysRDxpZUCsxplGYYhaSmga1btpJVSA/
         a4DedbubQk8v4WkdieQUVLTOQlJz+8LePCIE7YvAUQT86Y5pKeLC3YTCioweGIjSrcY9
         jiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790760461; x=1791365261;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aas5dFpRUJyHYCp7dUKEi7p5PXcPa3N+KVeAt5vuJzo=;
        b=OPTHCQyptCp7hEqu04WbTKOaLOQhIHTsoeX37YMkeCbJU1azr8URoqSJZzcCA6CPa1
         PbcXU5isosBrSuci8bsAz0W4D4fnsZA4ywB0UmdLEi8vRmEKCGZXok8g4fsLb5jBB1Ft
         j+1GilQijh5lw0gneEzWn1yoKgysMujAbpnQziJwSCFHXryFliPe+X4e8yFd7fX9OUlC
         PzRzX1NyPgJf3hSpo2uuX5xBNWSqiSlihWvoNLqZGK93goBE+vwG0jYYEgkBIDnEBnoX
         RbmfdXp2goQEbNlwGmrK/32cXACP/bXbJ7VNdkM+Zl8YsiscDgQ2azkX/RGbzFGGVdP5
         RRVw==
X-Forwarded-Encrypted: i=1; AKwUvBx6JP9O4oI+Pp21Yxqahu8xj5M1z/JfhgypRdA1h1NlMgmLHlLnNQWdT/d72o8r94VHDb24MaqYzQI=@vger.kernel.org
X-Gm-Message-State: AFq9FYILweKrWsnLdvBTfLfDkvN+OhwigR/e8rEMRS/WF//eqQzLmHI0
	zHtNNidKrKmKdsDGRwdMkHfLMcjIebKAj/cfaAOuqg/eD4locIvH1ATJyaRlSLGcNF1+nvt8X32
	O4uylv5C51b45HRNuRE75ntkVYcHpK8wWHTiY12Ru+/kwXdQQ0qF2tuQvnoYYj4oRucWQaJBevW
	1ZIdKkHURxqzdaCRRmfbnPvSDRiEY06US4vapm6g==
X-Gm-Gg: AYBFou29QME9jl4p5FHZxx1Z8RfsjbazSRBOKRjfCXOj3oePkiDvyGZBEx1YI0bibY9
	LMIvsWFvqXcNZpAkOwayL5NwoQqZUw6V8t/49Flm9Klemfv2rFd4LpKc8lID+oGsP5ckVmhN/AF
	1/vECoOI31eJgjeNmMlp0ATxwEHPGmQPrWRbOvmnIH0CY8E7kUnvQLxaDj+w==
X-Received: by 2002:a17:90b:4e87:b0:3a4:b2f5:d01f with SMTP id 98e67ed59e1d1-3a4d1787217mr660525a91.40.1790760460706;
        Wed, 30 Sep 2026 02:27:40 -0700 (PDT)
X-Received: by 2002:a17:90b:4e87:b0:3a4:b2f5:d01f with SMTP id
 98e67ed59e1d1-3a4d1787217mr660485a91.40.1790760459446; Wed, 30 Sep 2026
 02:27:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921191326.2146363-1-sanderson@brivo.com> <CAPx+jO8g-y+uc4YXUeZ3yOH6s44WFpytNu3-f6iLSjtHAVPd+A@mail.gmail.com>
 <e5a5dccc-46c4-497c-ab8b-b3f7fe5e316d@brivo.com>
In-Reply-To: <e5a5dccc-46c4-497c-ab8b-b3f7fe5e316d@brivo.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 11:27:27 +0200
X-Gm-Features: AclHuK-S1WmRfbn9a5BeauI3-UXbHdXkwq45V-fosa7Wt5Ing9N0Y4xLuBNhtzM
Message-ID: <CAPx+jO8QfkO42HnzU5BEQsGzqb6_pUFeT38E4EBpSA1kEpTexg@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: Convert host->lock to raw spinlock
To: Sean Anderson <sanderson@brivo.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: hM3nNgECIex75TDKzbPIPd3QSM1wIX91
X-Proofpoint-ORIG-GUID: hM3nNgECIex75TDKzbPIPd3QSM1wIX91
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAzNyBTYWx0ZWRfX6vF2glrh1xSU
 ZLSj/Z0oXcxANshiwXfJP+ok7IRBwQ7bUHplZK+9fXIZYKREzU3l67y9mjDbX1mBonDNzCtQ0RV
 JqLus2qhKLBTL7QwXnAn6GFw8XawuUzOKoC7j8Se8Dg5TWEq8NjjC6eNjcjfl9L6xChAu65QdJC
 5bZNAWV+YN3Mrr6qV1z6YeHBj+SoV036TiGsfcQ5rDU5qXHlbUF0vFqKeSgkrLcsclgeTHFSED2
 eviUUFdNif9GHDo4wrC3qxTuWbefU225wFV787W4TxtPg6kzakuF801d8WGH6Q+GFRLbHIjhSM2
 Mk3hTyEWzcYQrELduglQXLCdLcN2bwRA1BRySM/eZAPLVihaKAe4Igh8cCNbHjpwuJPNRGxJ/kJ
 gMErj9Za3u/EvFEppONS3qnPz91FDUquEj23P/CQ73hWoMrR7cgtkxV7jxeTnx0E84ZDOFGT0WQ
 M+MTmM0P5V1jOKKLAhg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAzNyBTYWx0ZWRfXxqeXQKD4oxyk
 aN1ZyFdOHHAuRUBpN9A012dmR6FCBwQuLmW4kS5dMyc7qBSlTcPOJxTBDtvWgNty8/SSfHlBVKv
 s+/79lZf1K/wf/sAJpKT8fr0yUZY6w4=
X-Authority-Analysis: v=2.4 cv=Tu1zFzXh c=1 sm=1 tr=0 ts=6abcd60d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=GX7wjADfAAAA:8
 a=LhH22EzeW9Yl2Fhwn_IA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300037

On Mon, Sep 28, 2026 at 6:22=E2=80=AFPM Sean Anderson <sanderson@brivo.com>=
 wrote:
>
>
>
> On 9/28/26 12:17 PM, Ulf Hansson wrote:
> > On Mon, Sep 21, 2026 at 9:14=E2=80=AFPM Sean Anderson <sanderson@brivo.=
com> wrote:
> >>
> >> The primary handler for IRQF_ONESHOT interrupts is always run without
> >> threading, even on PREEMPT_RT. Therefore, we must use a raw spinlock,
> >> which will never sleep (even on PREEMPT_RT).
> >
> > Sorry, but I don't quite understand the above. Are you saying that
> > IRQF_ONESHOT only works with raw spinlocks?
>
> The primary handler of an IRQF_ONESHOT handler must use raw spinlocks.
>
> https://www.kernel.org/doc/html/latest/core-api/real-time/differences.htm=
l#interrupt-handling

Right, thanks for sharing!

Rather than moving to use a raw spinlock, I think a better option
would be to convert the driver into using only a threaded irq handler,
unless there are specific reasons why this can't work.

>
> >
> >>
> >> Fixes: 066ecde6d826 ("mmc: meson-gx: add SDIO interrupt support")
> >> Signed-off-by: Sean Anderson <sanderson@brivo.com>

Kind regards
Uffe


> >> ---
> >>
> >>   drivers/mmc/host/meson-gx-mmc.c | 12 ++++++------
> >>   1 file changed, 6 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-=
gx-mmc.c
> >> index 694bb443d5f3f..d5365c0404cb9 100644
> >> --- a/drivers/mmc/host/meson-gx-mmc.c
> >> +++ b/drivers/mmc/host/meson-gx-mmc.c
> >> @@ -176,7 +176,7 @@ struct meson_host {
> >>
> >>          bool needs_pre_post_req;
> >>
> >> -       spinlock_t lock;
> >> +       raw_spinlock_t lock;
> >>   };
> >>
> >>   #define CMD_CFG_LENGTH_MASK GENMASK(8, 0)
> >> @@ -953,10 +953,10 @@ static irqreturn_t meson_mmc_irq(int irq, void *=
dev_id)
> >>          cmd =3D host->cmd;
> >>
> >>          if (status & IRQ_SDIO) {
> >> -               spin_lock(&host->lock);
> >> +               raw_spin_lock(&host->lock);
> >>                  __meson_mmc_enable_sdio_irq(host->mmc, 0);
> >>                  sdio_signal_irq(host->mmc);
> >> -               spin_unlock(&host->lock);
> >> +               raw_spin_unlock(&host->lock);
> >>                  status &=3D ~IRQ_SDIO;
> >>                  if (!status)
> >>                          return IRQ_HANDLED;
> >> @@ -1112,9 +1112,9 @@ static void meson_mmc_enable_sdio_irq(struct mmc=
_host *mmc, int enable)
> >>          struct meson_host *host =3D mmc_priv(mmc);
> >>          unsigned long flags;
> >>
> >> -       spin_lock_irqsave(&host->lock, flags);
> >> +       raw_spin_lock_irqsave(&host->lock, flags);
> >>          __meson_mmc_enable_sdio_irq(mmc, enable);
> >> -       spin_unlock_irqrestore(&host->lock, flags);
> >> +       raw_spin_unlock_irqrestore(&host->lock, flags);
> >>   }
> >>
> >>   static void meson_mmc_ack_sdio_irq(struct mmc_host *mmc)
> >> @@ -1225,7 +1225,7 @@ static int meson_mmc_probe(struct platform_devic=
e *pdev)
> >>          if (ret)
> >>                  goto err_init_clk;
> >>
> >> -       spin_lock_init(&host->lock);
> >> +       raw_spin_lock_init(&host->lock);
> >>
> >>          if (host->dram_access_quirk) {
> >>                  /* Limit segments to 1 due to low available sram memo=
ry */
> >> ---
> >> base-commit: 587858367581b9c55c3690f4e63382ad622719d4
> >> branch: meson_mmc_raw
> >>
> >> --
> >> 2.53.0
> >>
>
