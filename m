Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46B446985C
	for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2026 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850999; cv=pass; b=F8y1hhF3ev0GGQeEeNIJYBpvUr1DaBG00fKa2a+8c9sEUtCsms5l8pf3anejXG95SYUJaOgXMSMXkZefdoRPLVYMxStDwE3ZLNtQZl0wivcY+d3Btv1J//DNbhZYbP5W7n0+76lxTQjKgQXadEu7ktHH+5a2EEKjZgKSe4CxBrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850999; c=relaxed/simple;
	bh=k03uKWY2NdYGoKzimrBEuryVOPxiBdE17qMfIGPRuUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IylOlrAHkoKUf3fS1CuOXW6h/M4Mwpnqz/jne7q/MCa7EUwf6Ud0akOt33Vq4Bf1Z9VlsYBobDv8h2yBilo/kNLwN1Z6b5fRDxvQQ/cnR+6ZpK8kvUO+qS6oDNMbwiXHm5HV7zUSl9KnSN/2fXxYSLJE4W6H83Sli/9KPLhvNlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IqQf2b4F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S2ruobMw; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IqQf2b4F";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S2ruobMw"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674CXS3e3617837
	for <linux-mmc@vger.kernel.org>; Tue, 4 Aug 2026 13:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HP0PounhvTOT7QM3qBV2FFDGxTR319Vd78MIDrgPsRY=; b=IqQf2b4FGejs2nR+
	xCaO89bszLEgViAVstdoyjObZOHo9Q6KAuJMds07EbDiagts1JLhGNO3ehpkKDfs
	txvP/OubxAvxsmP1lpDNO4GXLvE3v6mg3Hpctrjx9iDdLFCxBgr8AFlv9e3Q2NKy
	MaI4IkZ0l4HInpJdJz9CbvzVFCal7cZITELDDWVnhrSTskzEo34xMiF9whvoNzZh
	h8g+3U86nTxHYbIEQ2lIgJEYTZdvbCUy3LlilKLWGjP3w7WJDbmi0ltwKaGdkvaq
	zDRzsMpkylts17Gi5H+/I60QhJPE4BCk3EpZikjX439PSdsI7LGk6OSztcRGqn0e
	R1+kRw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fu7272nde-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 13:43:16 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1d30035dso31660551cf.2
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 06:43:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785850996; cv=none;
        d=google.com; s=arc-20260327;
        b=sGBq2GaJPbsvta7/xlzWMuWkqm29rKxariVtqqn9BFBlzIr2lVYalFy5ZNT9SJRJ67
         xxK0Jdu4zEGpSC/ElGx6s560lq/z5BGl4eR8Gn+1JnZO2sjhKQ4Gz3oPf8sl/bKeMP2T
         TZAj42mP8YySet++hhBrVTtTW+BzJ1NeXGACqceB9+JJD6aoVEx2xqkT/owehmi8yV58
         ZVsh5r4IBR4xKaI8WNsvhNqFJ7FP+IbCE1w1pbL9RW2HdyepMDGx9a+xTxToH5VwseEd
         i+ifngGaFgDGIs+VXWwEwHLQROTgCwEd/QfiToMs66zQZkHshgTDuv9ULxdsoeLCRU0I
         GE5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HP0PounhvTOT7QM3qBV2FFDGxTR319Vd78MIDrgPsRY=;
        fh=I22DNrKOcYGGF9ZeQ4qISEJN2q2Ba/Vs5w9b2GeeXAU=;
        b=boGGDw+mx053kHJ245omquXhKRRbkwzVxOjaoSHUktBvj6tJ25MKg/6gsqYN/KsPUk
         Ceuoqcbft6LOwnbEHk17awTuLPv0vRifXZubGNmz1VT4FTop0HKYB5Rj8POIA2+Zfzlt
         50K8hwCXXvmX7T7HHr+JCw91DEO1SOo5s3Ks/aE4rBnXZ6KLOkh/fOcRPXG6TECkND7Y
         BLPYejkkutKn6MFHec3wJY4aRy7tyIBPaYeywfNkAu7VO0Pv2+nyu98/XUrrcV1UOSuX
         RV1c2Tp5Qfl6jSgrMdIiD4aj4dQu4XCl6YyONLjdvio1C6+SX+wBvTPlOADDXOsM1KyR
         mD8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785850996; x=1786455796; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HP0PounhvTOT7QM3qBV2FFDGxTR319Vd78MIDrgPsRY=;
        b=S2ruobMwOh/CjeL4iEre4dtPOSoAwTUi9Gi9Cd0RCeO9KN4i4T+4ESsystk+MlQYFG
         y8tAkajAUoM0UvEM8Je79MqfbGSpTtn5OqnYfZuY3qGCpxa39KkPQ9gbFH+Bj5fFNCY5
         BZklQkmxrlLVw9m9REVPc+ifjBDFczQXuJrjDlEalNsDF9YAtNshmod2xD16bI3sQe16
         SuQexprGApyp8ShTEBYSI+N2eu7sTXKPuLUOmR5PGy7zixNR/MeNZCq8R/HytfEOFlbi
         mk6tIk5bRscejQipc8fjl/Inxt0jbrXXc9QfftInvvP4zVGkp3SUk0OxHQ1D36jDQSew
         35sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785850996; x=1786455796;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HP0PounhvTOT7QM3qBV2FFDGxTR319Vd78MIDrgPsRY=;
        b=AM5Z+2ojBkA/1Oa2B34yVczs0EM148N9PWi5a+KdJ+eJa91FVM7+AXym/j0Dt1c8Qk
         /JnrpFQXQ6mnSH+NsIWpr7gp9zcd8phx6cYoPNA2FD+zmorMWzyEKz0L0gAZV29MzgOn
         diiEC8yqaF+IuGgD+2AoXOrvXViij0zmKPqBoT6fnaHqRJHarv+blbbT0Bn65uJQV22e
         t8pXFxrZgQkmoANmyaRajbODlP+iqCQtwpAF+4ooziUJXr3Renv2YwqkLJbsXQ+DA9xx
         ZyTAz/UphV+xnlj3nlRDLTKXAPXFbyJaHsZwsSOMgmTzS5kopupeg5Z5qwdEVJbp0HWE
         ECPA==
X-Forwarded-Encrypted: i=1; AHgh+RqOeJFqrwB/SKQ9lcHmIaeZSdPTotzJlwkZPNLsZn6jbQk4aHAMTGLiuQ51x7krnxekTrq200SwnYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI5grbPKJ98LeWHfnPu3p2YCN/JfzhyqHC9zgNLpsJobZVGHpB
	NiP1I9sLjqsyX8OL2jDh+kro2j6XYgQvcJJSa3aNIz2lwn9JK9/hnNfJJVZWaN5kRjdEjuiqCn9
	/67bV7fwS2WVw/zKIgUQo08eYU+p1JqCekHuxHYhyk6SU46AopW7MMX3fwbEnc+u1Lyu+m4/r7j
	6fN2yUgSXorNVJHrtFWevs7I+VQgcqQ9rgDUEN0A==
X-Gm-Gg: AR+sD12IgQNT4IOzt7jjKDeUwnCd0M3X50Ry9mVc10ZxG2136eV2K6XewCozzyqQotF
	8+pqNsutT07cBZPFiadpJVp+V5rKkUOiVsZJc7RPuAjdcqZTNU04Cp9Wk6iEvVcGMefldqLibfZ
	y5VjC5UdVOT+vHS1BH3NIlyGmhHHDMSoZetyXdw3T8Wh69w3KefAtuTNCtTw==
X-Received: by 2002:a05:622a:1214:b0:516:e0eb:d7d with SMTP id d75a77b69052e-52b56777af4mr253152821cf.27.1785850996101;
        Tue, 04 Aug 2026 06:43:16 -0700 (PDT)
X-Received: by 2002:a05:622a:1214:b0:516:e0eb:d7d with SMTP id
 d75a77b69052e-52b56777af4mr253152271cf.27.1785850995665; Tue, 04 Aug 2026
 06:43:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4389d5deff90b2b860bd07f17668270fda36bd26.1785750407.git.xiaopei01@kylinos.cn>
In-Reply-To: <4389d5deff90b2b860bd07f17668270fda36bd26.1785750407.git.xiaopei01@kylinos.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 15:43:04 +0200
X-Gm-Features: AUfX_mxpZumxWFxMAuKE7eioaXJu4G1kpmXiqDCFMMd_83LH_LCczGYOGtylrhs
Message-ID: <CAPx+jO8s+ANURyMRTbCa+EA54-q3wMS_hZtOJdxOucg5eRBk6Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: atmel-mci: Fix use-after-free in atmci_remove due to
 race condition
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: aubin.constans@microchip.com, ulfh@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfX6+1rGMa8TYSi
 Ca4xJ8SxBBx1vd/L9JnlV/Sj/ZebLmpROQJ+43Bkd0ZKoPfJ9wrzIiBzCJPGX6cbwAGduDyAzjR
 0crYdunePx3bBVFuZ1wZtzdyl/+i1do=
X-Authority-Analysis: v=2.4 cv=Z6Lc2nRA c=1 sm=1 tr=0 ts=6a71ec74 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=BBGR4qOFYMu73H6LvdUA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: ckpusLJuZJ_8YmhD4NBHkjn7VsnqeCoo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfX3ZQOkbkvf+Yz
 11jSDntNh0tiEwyVFyoduYQmx4nYCqJjHEhSVu5lK49VwTbKenmxHrusBVOFg4mFwIlIVD/JCpe
 g+LBzz7/DaNntrs7umYKi7oufl2EhjWT6OylImqaNu4oV4DPoyTC4H0mYEvr6CXDWfriDORzBI6
 AVHx5CDqcQGfY+P6gIuXbE2cERhOk3CrFMKQ6uJI0zDQKZYD8uqJhyemqnBoyX/o4lc102Kc/v4
 0pnfdRSEgGic9jFqV1TIiFXBom8ZoO5M/BsfQGuHWpQ4Z7NX26FrtzTdCdUwcuXMnGmO+H19QdL
 2OxyRYyBuRCtlPeTqcuBiY1TSrEPI640dkWfcOPn+Bdt25f8aITEEPhYuBnRtwOxbDC7rkSDe1K
 yBG9olNy94zaOCeKpBG4hRiCm8d+LIlXlaoVkXsFe4M2Y6QaokBOuZ3E333seAf7HOboi6oBQ8y
 GptqLI3q7sn+79nzzIg==
X-Proofpoint-ORIG-GUID: ckpusLJuZJ_8YmhD4NBHkjn7VsnqeCoo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040110

On Mon, Aug 3, 2026 at 11:48=E2=80=AFAM Pei Xiao <xiaopei01@kylinos.cn> wro=
te:
>
> In atmci_probe, &host->bh_work is bound with atmci_work_func, and
> atmci_interrupt, atmci_timeout_timer and atmci_dma_complete can all
> queue this work on system_bh_wq.
>
> If we remove the module, atmci_remove makes cleanup and the memory
> allocated for host with devm_kzalloc() is released after the remove
> callback returns, while the work mentioned above may still be pending
> or running. The sequence of operations that may lead to a UAF bug is
> as follows:
>
> CPU0                                      CPU1
>
>                                           | atmci_interrupt
>                                           | queue_work(system_bh_wq,
>                                           |            &host->bh_work)
> atmci_remove                              |
> atmci_cleanup_slot(...)                   |
> atmci_writel(host, ATMCI_IDR, ~0UL)       |
> timer_delete_sync(&host->timer)           |
> dma_release_channel(host->dma.chan)       |
> free_irq(platform_get_irq(pdev, 0), host) |
>                                           | atmci_work_func
>                                           | // use host
> // devm resources released after          |
> // remove returns, host is freed          |
>                                           | // use host (use-after-free)
>
> Fix it by canceling the work after all the sources that can schedule
> it (IRQ handler, timeout timer and DMA completion callback) have been
> stopped, and before proceeding with the remaining cleanup in
> atmci_remove.
>
> Fixes: 7d2be0749a59 ("atmel-mci: Driver for Atmel on-chip MMC controllers=
")
> Assisted-by: Codex:deepseek-v4-flash
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/atmel-mci.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 3b4928f5b9b2..8f4df250a77a 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2610,6 +2610,8 @@ static void atmci_remove(struct platform_device *pd=
ev)
>
>         free_irq(platform_get_irq(pdev, 0), host);
>
> +       cancel_work_sync(&host->bh_work);
> +
>         clk_disable_unprepare(host->mck);
>
>         pm_runtime_disable(dev);
> --
> 2.25.1
>
