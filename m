Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6DC4EA38E
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612012; cv=pass; b=Qawy5X/dzMtmr4gQdFjjc5HPjVBBx1NQ7Z+6VJ3+zdd/dNw3OGPruzAmUXkjLANsI0GHr3VxqVSLb04xjz5ecqIOuYbWyIssHGrCTTtUQjOcH5IZP3dWJvKEZacjANy/sLg1wE2f1BvPfnWbS4uLe1eTVaKfmpiQF7XuMU4iigQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612012; c=relaxed/simple;
	bh=QPETLdbCrl3h1O+VwfJJEjyhW34Bht3gyiJe8xZehKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThDkRhLFwIvviQQ6CWQu9t0hjzyYC1+qfFhQ6lMAZcFc7EJT5cGp7xpUjiT2TgdXZ/qRV4Sch9hlynJTXHTIGRGoKIMMl8aJSjyd3OuK+qS5bA6qMU73SjjcpQjJYnsLBK/b4/rLEgmMrXMhKH54WaeMKN+rhVnHlbARm5PUUcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=keXaKdig; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XD49Ff/i; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="keXaKdig";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XD49Ff/i"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SEdriA1908468
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 16:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IZl7fl9vC43HoFXuRfxhax8c0echx+kxviVprOtNlhs=; b=keXaKdigOgfFZf+M
	GHW1mJShGW56EgQN5rLWHIkx+OGqQWKrHhf7wPBvOSmrGhME618Q+805FNgwbWvp
	iVAti+d4NJO340odNGieKmnT+hu3eM2w+dfSr7N75HsbwJly+zjzVkUP17sav3oC
	tQHaqamaPiZtPy+stjVqLxokIEOIUOrY0mdXnm9K6+arQPHqHCiVBvNRM/141XsB
	q7Z1/X4TbcdlgCVTf8paPcUhPu4N7gWDHdvzsxAzFJ4PWQRU06roWVaB4IWmRlz0
	8j/9FmE30bQhRJ4LApIFmq8ZSOJRMDtH9+NynoEj08Qiqf2VPEkzszeBUqwGMDgZ
	MVJ37A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyjkxjce3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 16:13:29 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d94f086fedso31393095ad.1
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 09:13:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790612008; cv=none;
        d=google.com; s=arc-20260327;
        b=qoNU+zGzHODRTQjWVzssE+7JieH4HkSIwBIaSMyt1VCOEmljh+vM441CRruYgxoIl3
         GVnroueOZYdpWBQ7kHsGDmcDggezeiig8d/mdrvT1ht5MX+MT2WcRq/qnhvFuMDANjMT
         YgX5Ij7TJhYlcZpYShuHZsqpyFeHebfZqscAJnNB6bCLtjRi6DGTpsy4Z9YJFqx/50mJ
         6vTTqCy2E4FOvVonS91j85RuAWDUeWkStmpS4dhCl6eYKqAy1f8gyAUgmjte/3R3qxmE
         azaBRmigBwatAOaSsLiKrJR96wqhXHEkS0FUjU5DTP0jI2qkcxFd2aGieaALnlpkZas5
         FZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IZl7fl9vC43HoFXuRfxhax8c0echx+kxviVprOtNlhs=;
        fh=rTrFoWhQv+QCDmsmK+OeuI+wJRp/JWoSi2sSgrKGF4U=;
        b=Z2lP1T8zJZpzB4hr/TD9pECRlMiK2TtSnRSnuKkSJkf5gC8i5OY7wcKu3IO7mfQ4lK
         Ndgk3zUEkJvVVp/JFAhMpTTEpkQnB0atV0DjjZ+x6h+2bL+KtKtMgXIdtUpI2XgeNzmp
         RNnIbqfp/LLep3JTKyOg7n6oIigDcp3R5MdOw/Ebf2oSQhKNh/Vv8yU+R+oiz9qbku6V
         Ig1AvaWLOyNwFqdW5SllTTnTwFQhC1e4PE+UJwH+HgQZr6onPbRBRIIAb4cauVW/JOwN
         1EhN6dxVaMi7Mo5/53JLRUmDhKikxKBaFGEgOaMzwH2V35LegX0Ow04bYIF5ECGtyi4D
         4i/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790612008; x=1791216808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IZl7fl9vC43HoFXuRfxhax8c0echx+kxviVprOtNlhs=;
        b=XD49Ff/iKlX++AbFVeHvR3pHfv7iS1Ek4q0A18KsYdDp5yI8wdR8gyviPeHqqwTBK0
         n8SiJLhGwWwnfyQ1tGFqQApJMsiYWdsxA4opLeWC4oDObrCYxkDUTHpFnIJIyYSYTonu
         cBDcMBZsY5hGPURRg9Q9V/vttwvqilxNrdEuYJSRhVVRZ+duZEbSfktlCHQ2beodhnTS
         pqHNgLNYyG5V2Elruh4HnjAtE3jWOucDNUtGL6TLMDwjxeO84yFT5RRC72R9vdAEjSuD
         09f4Yx/+/REelSa9sLAXwn+DXUu6vtt/4gfswMq6crPEKS9Yb74S2YHN2UhJ1i1s1xNN
         /BrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612008; x=1791216808;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IZl7fl9vC43HoFXuRfxhax8c0echx+kxviVprOtNlhs=;
        b=B8jrH+qwXByLHsnP6KtfpkzKEol7TZ7ahweXf8eHBJjPkoB1omIIA9tcgBB1Wd5KA+
         GEqmvrMIr6CZup1otl3OGYPS3bi/9yabyyjqMMDh2njKFa/MI2ZUOGoGv1eRczc1ImHq
         DYODwvDSqyNrgKmdeSuhC8E/+DGYL/uQSam/juqMGpXKxqR5FwAw/5CDJaNGbvT5wB84
         h0i/8RKQpILjSRRULPusS3bjS6Atedwjcd7auvBRsKgWy63FXSd1Ac1AofAo/jaincYJ
         p+E5rjh0uyADw2dDcIpoKriiDQpPN8n3As7J+v63gqKWnGUl2n3VbTUa9BYJDsaVJaan
         RQiw==
X-Forwarded-Encrypted: i=1; AKwUvBwzyFmZ/YoJ+PuIxpDu9t6HyrOmb50FngVH28LNBrw0u/TPs06S54XfY5QdVN/Sa2w6ARu+tt77uxk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtOO6JsBtAeLmZ0LaGBjt7PKtyUifpDGT8VGNeLSd/+RvMurCF
	fT789pIHQA8WNGuuUd0s08C0taGlbdIZ11YS9TgvMR0hXkwwYNWuPWPKDbC/elOIwG6m5U00rA8
	3y7mPt/U9G+ouTOy5593pVrZVkDUswgEME0Z1VaZ/gDgAazzKXySOinpJoZhGT9LqrFPL91u6Mz
	g4AjS9DBlsNdmw1er/EO3cNA1AzwWCuXJ+B/zqlw==
X-Gm-Gg: AYBFou2+cTgyFTsbfBiA1knSWrY6Py5RYV0zW9SDH36el6BSYoWatLYGN4rtJxOSsX6
	C0OUq7bWxtcvEm5Y2eWiDtphDeZfsXjU4GsyKfEcHkMjOEwxp6vLjLs2MGA1BkdzScYpcv9NzK5
	CEI8U6485dKgREMyrz9PsgPljCbUBpIoZU0CYvC7ryzZz9lUKfhC6kNEsqWw==
X-Received: by 2002:a17:903:2f50:b0:2dd:c053:ec75 with SMTP id d9443c01a7336-2df7e11acf9mr102165515ad.40.1790612007974;
        Mon, 28 Sep 2026 09:13:27 -0700 (PDT)
X-Received: by 2002:a17:903:2f50:b0:2dd:c053:ec75 with SMTP id
 d9443c01a7336-2df7e11acf9mr102165345ad.40.1790612007511; Mon, 28 Sep 2026
 09:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915144457.3463325-1-lhfff@tju.edu.cn>
In-Reply-To: <20260915144457.3463325-1-lhfff@tju.edu.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:13:15 +0200
X-Gm-Features: AclHuK9WzP7c_-qm5LpEcfgT6OqFJRgRH9WwCFERWptgUVAizTg-xTRVM_DTSCI
Message-ID: <CAPx+jO9q0x=mvwZhr=orFO+n==2g3rx97GcCNgGCM-BbJJ-LEA@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: mtk-sd: Cancel request timeout work on remove
To: Yibo Tan <lhfff@tju.edu.cn>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson <ulfh@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: PKnFtQC3DOZ1OUh0PxjJgdLLkkCAGxqj
X-Proofpoint-ORIG-GUID: PKnFtQC3DOZ1OUh0PxjJgdLLkkCAGxqj
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX24KTUjuRBEuN
 l2V4je44+Cq9h8Zf6ckAZYmvyZhBh/HtTQ1ZIbJZ5LjL6JbD1h0tu66zSDPkTt7W7Wnb8tXlm+q
 RJbvEkRUwW6oVN7/q1gOwJVx8ErMcBY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX+bEYY3uBShBF
 eYikFTInIgPq8ywx0H81r2NVO4eD80KD0PqFDbHPOJqMQg/PAFlawBnkGK/dy3EyvzrN0qy4gpI
 9/B8fJMnNUOA0oZc3eNyYiFEGdW+qGAT66U/ZjH5ZcuqbLJx76/lyJFAuFIHkW58Mp0VFsorvX+
 wFRzegXLvlWhZSOJttxx0FmUf4wvdFJRSIfYMP9aEMRjMdC9uuBXQJoO/thYHeDNaijNPgDgTMq
 32pv1KVaTOSTm+BzjoAhpPr0ZpRG8Yj4dXl+R0TlGH/QarIlsOxbrcL/gYTu8Ji5hBx1gmKXuNv
 Dt52sbCvxlBaW+ic8ZXwoy3/sjneG0FUX+Wvx+faFpcbYHENRXprRoN1bCfr8uJVNphktsJGKAq
 pFtFd21VtPWSzZjxdv7vFx1lYtGjLt9X+X6j/91KIGcQ6vamN7ySJerroFIr10oUPYBvnlPUZKV
 c6hRgcrgANNaThJ/lRg==
X-Authority-Analysis: v=2.4 cv=QZfzLcbv c=1 sm=1 tr=0 ts=6aba9229 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=mIaQsNjA2lESkmv-XRIA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280064

On Tue, Sep 15, 2026 at 4:45=E2=80=AFPM Yibo Tan <lhfff@tju.edu.cn> wrote:
>
> The driver queues req_timeout while a request is active.
> msdc_request_done() uses cancel_delayed_work(), which does not wait for
> a timeout callback that has already started.
>
> The timeout callback calls mmc_request_done(), which wakes the request
> waiter, and then continues to use host->dev_comp and check the SDIO IRQ.
> During unbind, msdc_drv_remove() can return and the managed mmc_host can
> be freed before the callback finishes.
>
> KASAN reported use-after-free accesses in msdc_request_done() and
> msdc_recheck_sdio_irq() in each of three unbind tests.  The same tests
> completed without a kernel diagnostic after this change.
>
> Call cancel_delayed_work_sync() after mmc_remove_host() has stopped new
> requests and before the driver releases the host resources.
>
> Fixes: 208489032bdd ("mmc: mediatek: Add Mediatek MMC driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5
> Signed-off-by: Yibo Tan <lhfff@tju.edu.cn>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 01ea3adbdf3b..5b160fdad3f0 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -3216,6 +3216,7 @@ static void msdc_drv_remove(struct platform_device =
*pdev)
>
>         platform_set_drvdata(pdev, NULL);
>         mmc_remove_host(mmc);
> +       cancel_delayed_work_sync(&host->req_timeout);
>         msdc_deinit_hw(host);
>         msdc_gate_clock(host);
>
> --
> 2.39.5
>
