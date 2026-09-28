Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6724EB878
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612049; cv=pass; b=GaTvKu2QQHTPgoYnHW0fOtwQQ2UnZyKpnf1f9EpR0tmWXVLoQIUq2bhtn4hXMxb8L3d68pY+ySB5OWV8G6lOyVjZCSdf5mbIigOw5Wq3cQX3vsG67ayaKqGXXXtEhg9TprWfLxoN2Zg3aSyc9VzsGQhBf/KczSAe7N5Oft0e3mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612049; c=relaxed/simple;
	bh=laB01Nm6g2O5qjF28Y4NhRz2GOkRSZ1m6qBJQS5vSWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C41zFy8GCLWL50kBwBST5ukt/xPnkUi3fhhYi6PJw2Q9F0hYGw+WsqFT/kOlRVR0Pq8G4FQGvRB7GEXT4+uFavfSJn1hbjyNUaHdFGKI8t5U9Z+SUlPSlFPkdneahGZmbIU9zaquI8DaydgDRmogGBY8NCDj5Y4vnhJSVTEXlQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dvOlzfBb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c5K4LTJn; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dvOlzfBb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c5K4LTJn"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SEdsmF1895242
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 16:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TLY8cueBZQsQi8RKd3F4kvLNmBHf3Rx9A20BdfszSZs=; b=dvOlzfBbD1FOz3as
	MMRh5DzcwN35T1zsbfVo8Znr1wueSLn+HGG4LPCIZbBV2UeqT1fejqDA8W9QNzqu
	g4w7BcVNNBsx6R+S6gvIN+z86hfueICiSJbM5LlBhWwW4MWQj8bM3BrfMczUpfrT
	iEFSIrt1DHDV+W7N5dnKkT7UP6oy5X7Coru9m8gnnm5i/F8cXMq5HltKwuUfFQ24
	s/YfNunJcghDb4UCWqBQl/0Q7+Z3DByg6iou7etk9Ei9qgyb5G6E8ewIFYQeAZ11
	8LmtGEO7DUa/M46UtblTzCYJxAiSrgJk8SpLTDAEVTKoYB9rHK3flOhornNOcpPT
	TEbLFQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj2s2ejr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 16:13:59 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so2448684a91.3
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 09:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790612039; cv=none;
        d=google.com; s=arc-20260327;
        b=X/WwG684B1WH3CbuUzpx1RnsnXvBqiV0A9sQ1y/dJXeEMBoju6JojvArTKKXtcazu6
         AawJqflpT2X6SdqVGlzwKmECa40cCFKVsyxYQGWHWCmN7crFTBPmO14M2S5JGM6RUEEJ
         MO8XtaM+io5WIcQaDVm3RK2w9bTr7FHZm2CoW6I5p0Am9Uv6++fuR8GwLSZquruLzV5R
         A4Oqceh4j5NIRBev66VdV4oWvpfLGszck0oE3O7jTMwLXV1a1yDVuJxUsERtPYqY+Lfl
         bKca9ddhGhJ6yhy4MzDjV7EYUhFVIiLfGmVL+NugJxxPffXSq8C8f2pu26Ux7Xh52GAW
         Y7VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TLY8cueBZQsQi8RKd3F4kvLNmBHf3Rx9A20BdfszSZs=;
        fh=bVogBR3Gn9lsLL0Wp0rZrNsyh+AzAFra7we1U++qY+0=;
        b=cutfLCzmxZhMDpI1fui2vHrZyJeohLIMqlQ5Zqi1S3Yh4herFUFaaWKGt2kjMHm1OS
         c+TIbzhfnL41vVMFmv8hP0cFzbB0KvMAeFHlby3oec6Gqq8ba5kf6thfomPNZP3qPAM2
         7BplNJ2vXgtS7xgsByy9EzIIJHr355+fW1qcACMJlQuqqmbZRQUVk+0U/5ba8HXYikg3
         9/9AcBYQZz5pO3du2SXb4s6kCssATdeHLmJtAeukQztSn0RZQjzsLF1zo3AxPW6JfWrB
         xG4UJ57554cEX1/CxeMV6ODuyZJWOSHA3sJJax1cczKJuvOkcWLxRkg0tfbq9v0gnxRd
         40DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790612039; x=1791216839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TLY8cueBZQsQi8RKd3F4kvLNmBHf3Rx9A20BdfszSZs=;
        b=c5K4LTJnGD1DGPg0wwr11HGIM/9492ms21RHTQQFMFtggQBpOS3hNPnUKRWXgQ5x7G
         Qg8o3Di3SOKeMrjTnBUAh/qNmRFe3ZL+TFH51l8iP5864zzOQKLeQRoFEnpfjv8/4YHZ
         FLGA7+QO0uZOenh5sKUjLWe78h+jTcnjv/as7oJ36XnRtXHC5b0X3yxU1yG7N8Ts3KLa
         0nkNYXntU/1m6nRqK2rp8dZnzbN4NUvf7uZNE/pspb64j4K8sZBr+MzFmiPvjM2jLgts
         hoyLdDIsC6GXdxjm+lzmAeyXzns5dT6HRf3x18fHGuGl9mSQAnDCqCvkUWcEvoxj/o+X
         PlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612039; x=1791216839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TLY8cueBZQsQi8RKd3F4kvLNmBHf3Rx9A20BdfszSZs=;
        b=aUSoHRrsESz2T5f7qOhmNnbO0x+ohaK6NuPgMdXTPHhs2aYE6qH2n2wNspkQ4cR8or
         uRjuzYqCSXYTicUFD6rb1LWlzFjnPVlLk43ciH9z9FCUy83zhqe8auuAJ75ApGoqeFBS
         u5Yv1ioR4Ynr/ebbxsZXwp3Cz94YP5//nDl3reK74U/acqLeCXhtUHJdzpsRCO9lsPhA
         wvVyDyOa3BTW1q/EhiWAtIW7xLw+/8sL5CwBYebVqazhOwOZRQslHOA/Bb7me+nz2p6u
         29gKrPqPsykTpufj20DRPx8RDFAc+VNw+tebtgeCTLypBQ27hc66D106ck0nRn6Fe5Fc
         tvyQ==
X-Forwarded-Encrypted: i=1; AKwUvBxw/dX5Hw74QgvcK9YVXZb4vw2gdwsomOOyNSqhPKnY8uqDfl+9xbyPkohOOoQijUk1g0p7CAzxkq8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIomDqgikw/81a4ZeZOa/BQa1ZDzTK49T8VwYWzKtp2QwpCQq7g
	dSBXzJsWXjv5gQ9fOWQZOzsob34MY16bQ8P0GcSSL3XrVe73f0VebP57Otp0ypZFhQy0WtCNKgi
	nMQrYxlUTquYWUuiLRrrZUpqVXsKQ1vwrIpXJj+hWw7QZ7B7U0MkylEUMzDMw6cNXbakKobG83A
	maxy4V0f/PVB88QYNW6rDodWzwxd4dLs9YR40RFg==
X-Gm-Gg: AYBFou2bEyavf4hY6LbUBfEyK9zfKCt0rPUVZAm/d8vW/RFBLJQmdVAGVHh3a2PKBE9
	SWA8/6MGZePSU+gnn12mBTG5Og/PfE9dnPC8p6j8D1DVg61sgBwJ8sHpgVypStHRSmVShxiS51O
	Cio0OzYShanZyQSnJECwkgKO1knXq1zflcNWs0EyeErQcR05f28t5XwPgTTA==
X-Received: by 2002:a17:90b:2807:b0:3a0:c621:74a with SMTP id 98e67ed59e1d1-3a0c62112dfmr7217609a91.35.1790612038765;
        Mon, 28 Sep 2026 09:13:58 -0700 (PDT)
X-Received: by 2002:a17:90b:2807:b0:3a0:c621:74a with SMTP id
 98e67ed59e1d1-3a0c62112dfmr7217589a91.35.1790612038206; Mon, 28 Sep 2026
 09:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915155724.2468892-1-lgs201920130244@gmail.com>
In-Reply-To: <20260915155724.2468892-1-lgs201920130244@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:13:45 +0200
X-Gm-Features: AclHuK8NijbscYmEbRRTTVsCxytg6cYy0JdOJL7tcaZsXJf3cMG4wS2s8SQ8LSk
Message-ID: <CAPx+jO9duanFSkuQJ9ZrhWAAPzG2zhaYUtXaXhTVyOKDVKrS8Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: cavium: destroy slot platform devices on remove
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Robert Richter <rric@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Pan Chuang <panchuang@vivo.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        David Daney <david.daney@cavium.com>,
        "Steven J. Hill" <Steven.Hill@cavium.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX50QvlITzN3fn
 fz0JjHknoXOLMs6uTrTgnaP5+4x02HUcVppkGj7W1dhxP1EzsuVKA2PvZXy83WyoQVPtDa94jTs
 OyUOY9bkejQ6GltdU8m16DuWxFvMmPleDvcFoSNMc63/tQFkl5J1UHuqWK4hhY+ITPMb1PWriIm
 vLRNXbJn+g4e4NstO9rhiO8hQkEAWILVW6EIGpMOivU2al66/PlOnimtKBPHbEXuCbKHfl823vH
 IPxEsE3kMrT1uAH+OMBEpoekLukhRwG4adUrXqGeUaLWUPjwmCVXAcFIFSNUk5BHVAUWaM+OErq
 jOkZFc1FqeX0rNj3sn7ChQfSqmwdbJEbINe0Tx0i+O6nE4t6GAPcVjlJY2UnhMGoeXTHEmSO6wY
 lVXLNebQtTE0h/0awfjxlp/vG4TFhWPXF5cb2xQm2U6cu4/SfEuPW2UV0Pun3GPCLtc9EM1GRjA
 jYTgvJhcrhLGpBG/rFQ==
X-Proofpoint-ORIG-GUID: -g1qoSzxtr5ubwUAD3lnOGZaUUm9YmAc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfXw8QFqVcXMvkz
 I1BZnEQ7s6vnX6xLMcDeOxS4Jxx+VmKhjILIjX+vTLZ4gavIHghCIsYdlZAEMNA9JPkfX/kqT0s
 w725fYj5gH5IHRIuszVQDkIm0bKnPuQ=
X-Proofpoint-GUID: -g1qoSzxtr5ubwUAD3lnOGZaUUm9YmAc
X-Authority-Analysis: v=2.4 cv=TptzFzXh c=1 sm=1 tr=0 ts=6aba9247 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=2raNofmJN35FeuP7pWwA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280064

On Tue, Sep 15, 2026 at 5:57=E2=80=AFPM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:
>
> octeon_mmc_probe() creates host->slot_pdev[i] with
> of_platform_device_create(), while octeon_mmc_remove() does not destroy
> the child platform devices.
>
> The probe failure path removes each MMC slot and destroys its associated
> platform device, but the normal remove path only removes the MMC slot.
> As a result, the child platform devices remain registered after the
> Octeon MMC controller is removed.
>
> Destroy each slot platform device during removal after cleaning up the
> corresponding MMC slot, matching the probe failure cleanup path.
>
> This issue was found by manual code inspection.
>
> Fixes: 01d95843335c ("mmc: cavium: Add MMC support for Octeon SOCs.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe



> ---
>  drivers/mmc/host/cavium-octeon.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-o=
cteon.c
> index 1bfc1a4f9fe9..671dd1a36a74 100644
> --- a/drivers/mmc/host/cavium-octeon.c
> +++ b/drivers/mmc/host/cavium-octeon.c
> @@ -295,9 +295,12 @@ static void octeon_mmc_remove(struct platform_device=
 *pdev)
>         u64 dma_cfg;
>         int i;
>
> -       for (i =3D 0; i < CAVIUM_MAX_MMC; i++)
> +       for (i =3D 0; i < CAVIUM_MAX_MMC; i++) {
>                 if (host->slot[i])
>                         cvm_mmc_of_slot_remove(host->slot[i]);
> +               if (host->slot_pdev[i])
> +                       of_platform_device_destroy(&host->slot_pdev[i]->d=
ev, NULL);
> +       }
>
>         dma_cfg =3D readq(host->dma_base + MIO_EMM_DMA_CFG(host));
>         dma_cfg &=3D ~MIO_EMM_DMA_CFG_EN;
> --
> 2.43.0
>
