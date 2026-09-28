Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF762367B5
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612265; cv=pass; b=I3PEqEGEq4X9UIeqVaCR6b0csPsaGdTX7b2ziVFtwQkE+j/PJezHeJIjcx1bswd0h0ld7SalNm1R9JmpHjshXw2q3ltRe08P/sHb0c1xz+ZmtoCPVSzSsUMLJL+5Fz9dWozOCVJOPHyvULElBmUZ23S9Ign9PE1eXfNhuHx25Qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612265; c=relaxed/simple;
	bh=rzg4EdYDzl86KXke+y/jDjzliVS85GGQGbd/09qMqYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0Cbe4sB74EBL9l2CXtICt9PE3NrofOjXpRKOf9R74/7reD3JxF7RvRcOIu09q9kugn4ZIF97cAu9k6ZErqpok7fVMpHW4P3WpcVKfSseAOb7TFYCkxkKRkbkavLWSfi+8yzXLaItIlqVPQgVCaPLKYXLc0j1R3siy58TRgy7kA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bi20cZ6f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WZ+5fATl; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bi20cZ6f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WZ+5fATl"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SEdvlp1908612
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 16:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZPG9/h412pdnG6FSVrrR7JhkCyfchpuJdtkMOSDic+A=; b=Bi20cZ6fwwUWrbpt
	a+Jf3Joqsq1wPQmmfSoOfR1hMJyArBHC42oglSaXxYtYKBB1i5IiKWNCevloVb9o
	BKqMy5BThScgvlptiEqjd8x5WJLlLtpwfBw5GfLpiCnmeXl5WGVHzcAdxxcX9dyw
	QuV9rhVUh1vCCZHDHSNgXeL0NEKvglbUmwuhrm8FVfsNNAZXIpmgzUl3llyIXe9y
	XXmwN9Vpkj3H4XAMwdNZMZSlAQFrk5e2nIAhNI5UhcYaPFL8EMntToXkAnrQ3ZPI
	NGsc5iVv29WINfCjpU76pOETnKY/cfkMCipVDt0NcjRLJ/RO4oeDh9UcQmaHOA8q
	N/ottA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyjkxjd1s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 16:17:43 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39b77130a7fso3560934a91.2
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 09:17:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790612262; cv=none;
        d=google.com; s=arc-20260327;
        b=s+YBKg4pDHx0sW2cyjtoZEhBBq4P5ZttR9l82uIHOv2iK4gXa8jDw0ZizlOrsPVQPj
         0sk0baTqEP77XYTDixGPvUfZtXM04nZidCrcmnO3INKL8lB9CuOhYKIWj5+0W/YCqAKJ
         DqB8VbYZ8cYCh2hu1DEvnqRKILDSrzfqrIXMk1FB701GUq27hUUjGxU6q4C39Leilm4W
         r3Xhgn93yLMHK/s5+uOGJyKU7dZhD9bJGYWmZm+CSJAtvDdIK3ESTsxJanzwG5CzpW0m
         lvk5i545tlcHWh2dRZX31MejLuGjFP3ArRTziRmu98lQHShf7diU50iUtmVH2ojgcT6f
         GXAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZPG9/h412pdnG6FSVrrR7JhkCyfchpuJdtkMOSDic+A=;
        fh=P8mT5Wk2yDO0VLRLJEMzOMANdY/UlTqkLi66nY1xZpo=;
        b=aL3Wkb75WY0RL4H7nrD25YUiF1jDVqoVRhcqoKuOvDfPbtbQkxfZ/l/m5+ie1IYK4h
         lzUEr8XgpIYA4lViTH4WJKqK8+D8iMmznIQU/NjuOOeZGfiPgJywr4V9o8OVjUT/upzL
         z3AWyfzBeN0HLNdhMrj3X23erejR4zvRMVdvAYeGp4CUeCQBnQSgs8klKE5LB4yeuM/k
         o+fbsoXTW/WoPzw3+pTkTrxDp0zhgBXBC4jkccNHsmZLlYGd1XnM89luAZeqvGEoCeVw
         Yn2zdoKIpPFA4YUCdQblzBo4ZjWrkPEng36+8CBPenXSqtawHuYzlKyQHNMgpEyBJvlQ
         EzcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790612262; x=1791217062; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZPG9/h412pdnG6FSVrrR7JhkCyfchpuJdtkMOSDic+A=;
        b=WZ+5fATlhsrQIOCZnr2TqDhqQpYzaTMoD+omPWSjG95ho0OD73z8E8g6K0LEhLKn92
         yxqzlhKInvg+80eaN2bBJK5trnTc3yEbn3lQG6zeJikNamvkam6r6EaNjlIaqtMadUWe
         cVj2++Sb4UQppqYFGsind3ldwtxZzwLea6wos28VJVf2WgpWfhzm2hr+T87WFQ/HxqtQ
         YZtv9MPb6kI6/Kp3LMmYGU5h75D1O1YaKzbmw1Guswv5ZPcfmVerOh4URrDA4KW8gnzZ
         VYxstUL4zfUqWkz2urh7LIm0ND4pUBIFgC7DTJER1DnmKwV1T0uTTGz5dFNII1VHObK1
         Rrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612262; x=1791217062;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZPG9/h412pdnG6FSVrrR7JhkCyfchpuJdtkMOSDic+A=;
        b=xWNNZ3pCXRyXuY+kEklVlEMemKiAC1X2tVeOd8TFf045kOapKiHWcDV3aJkb8GlvYp
         95eSW7gRxjuGz4mNMd02IFubyEQx4gGA0V39sISSlRejVPxaS8pzOL7rvIrNZzUAOKpX
         dO71ImcnSdQ1rMSqFxBWG7+QoUetXh4gUET52oWKwG+5NGSz2y9SyauqSzr3PxRamzpI
         yKAP/7DlDALKl+H+SFpzlzO7GC0lawOw2zfBwmQ7vIT6VK8U99Yq4VNQiCPFgO9crf6g
         g0i4VxyQgUJihfn/GswtUKGxOXQNuxdujS6Cw3Dq1jDmgBzxaNEsgg2zDjAV0qiODif5
         WXlA==
X-Forwarded-Encrypted: i=1; AKwUvBzJg0WC3zgMo7w7T8b7igcCIiPrynFPtzr/jVFEoyg+EpG/lG01XFCLKjMcQuYCF4z8KwlzIJmHLAs=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8oMFk2DaBHYTa2dXRkue7BUggLeorrBgYRzNfpWRvZi44+I6/
	mIkt3tO7oRaIT0z8b5Rj4Kb8zfJC5gnnCqY0JbZSIpbZcD7v8366IqsrMQdoxut9j+xVktpL+2W
	eBPMXfU8NBDFKrWA675BtcxiWptgxh/DHRjb3exrNk7L1lvIb5JLfMyjp6DvCB8ux0TjvJ0p4Aj
	9rPj66VOzPrB0JT3DsU7VMGWTi8B/8VZOCJ2VwqQ==
X-Gm-Gg: AYBFou0bsEZz3zwuJ6XO6y/wJtitK+TkpDx7/4PmPKFnyqOGbXjePhEq7aInU6sc1Ub
	OvyqUC9Ni6T7jn5fbqTCmQhRN334USpEpoF/NUVG6v/32Byi+L2U3SNor7vXURtjqpMk2MTteyY
	pv2+XlBKQKoO+6MDonzOJDNyUiVUiWErNReq0KT0ls5QDEIAT7uiGCWJQ6NQ==
X-Received: by 2002:a17:90b:3c45:b0:3a4:77fe:d478 with SMTP id 98e67ed59e1d1-3a477fed600mr2010788a91.25.1790612262263;
        Mon, 28 Sep 2026 09:17:42 -0700 (PDT)
X-Received: by 2002:a17:90b:3c45:b0:3a4:77fe:d478 with SMTP id
 98e67ed59e1d1-3a477fed600mr2010764a91.25.1790612261755; Mon, 28 Sep 2026
 09:17:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921191326.2146363-1-sanderson@brivo.com>
In-Reply-To: <20260921191326.2146363-1-sanderson@brivo.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:17:27 +0200
X-Gm-Features: AclHuK_h-ClRM0tgPWKnM-eRAvfXYVsbs7ZT5xtGlCXk84AjgUs2ZbGoR93rbsU
Message-ID: <CAPx+jO8g-y+uc4YXUeZ3yOH6s44WFpytNu3-f6iLSjtHAVPd+A@mail.gmail.com>
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
X-Proofpoint-GUID: nS6hnRS7AD2VPFpuPU-ldvTlj5nvFPeW
X-Proofpoint-ORIG-GUID: nS6hnRS7AD2VPFpuPU-ldvTlj5nvFPeW
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX+y7QEU1WUDY9
 U7bgbDyTGpgtUs/X/G2QI5/y5UwrwO8ZBq640EstsJKvXH/PLtJRNLMtEnky+SbRSfg8y0pE6sN
 pw2Djcl7KitjtJGckSr6rIHojUAWDZs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX9jkp+kT56I3G
 0J4kv2g72SNv+kLN8st72rc2ALFTEPKWLFAUINresfkfq3Ctn07O0UvQNR+8tKZN7tR9nwrveBG
 rlxdYWl4vXXB5G3FXj+tFW7Zj5wiDN95iGcop/K9WBwpzaNW3ZYdAXs3ddDrQOKrfsvkR8y1rJt
 HZfnpdoWYIKsDrtHoBA4XSf5Uh57ASb81zSL4jP4zefOeZdi6SuMNumRAshPE6qJAAd+XzZc9Ws
 bLz/KuMssg80lhPMkKY6hgpJjXUvQfDvdm4H89Tc6J0Zotj86SZvL6lqQ11O2IGsjGErgvrvCsB
 FqZmsOwzhuLcmiqYmV96m8NSDyXQaRuxdAsofcmxoicfr6bGojfwYLONzGzilwFY3P5SwFEJCzf
 dxuJTZNMVzBFdSz8dxSga8LadcoO+Hd7HJOFupX1ac7vvzITi1sCMfEr7Fslhqu+utWEOggJDj1
 OJ/wA42jPuFe64HfBXA==
X-Authority-Analysis: v=2.4 cv=QZfzLcbv c=1 sm=1 tr=0 ts=6aba9327 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=GX7wjADfAAAA:8 a=PBpPEWVgUkDHuXiRGYoA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280064

On Mon, Sep 21, 2026 at 9:14=E2=80=AFPM Sean Anderson <sanderson@brivo.com>=
 wrote:
>
> The primary handler for IRQF_ONESHOT interrupts is always run without
> threading, even on PREEMPT_RT. Therefore, we must use a raw spinlock,
> which will never sleep (even on PREEMPT_RT).

Sorry, but I don't quite understand the above. Are you saying that
IRQF_ONESHOT only works with raw spinlocks?

Kind regards
Uffe

>
> Fixes: 066ecde6d826 ("mmc: meson-gx: add SDIO interrupt support")
> Signed-off-by: Sean Anderson <sanderson@brivo.com>
> ---
>
>  drivers/mmc/host/meson-gx-mmc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-=
mmc.c
> index 694bb443d5f3f..d5365c0404cb9 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -176,7 +176,7 @@ struct meson_host {
>
>         bool needs_pre_post_req;
>
> -       spinlock_t lock;
> +       raw_spinlock_t lock;
>  };
>
>  #define CMD_CFG_LENGTH_MASK GENMASK(8, 0)
> @@ -953,10 +953,10 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev=
_id)
>         cmd =3D host->cmd;
>
>         if (status & IRQ_SDIO) {
> -               spin_lock(&host->lock);
> +               raw_spin_lock(&host->lock);
>                 __meson_mmc_enable_sdio_irq(host->mmc, 0);
>                 sdio_signal_irq(host->mmc);
> -               spin_unlock(&host->lock);
> +               raw_spin_unlock(&host->lock);
>                 status &=3D ~IRQ_SDIO;
>                 if (!status)
>                         return IRQ_HANDLED;
> @@ -1112,9 +1112,9 @@ static void meson_mmc_enable_sdio_irq(struct mmc_ho=
st *mmc, int enable)
>         struct meson_host *host =3D mmc_priv(mmc);
>         unsigned long flags;
>
> -       spin_lock_irqsave(&host->lock, flags);
> +       raw_spin_lock_irqsave(&host->lock, flags);
>         __meson_mmc_enable_sdio_irq(mmc, enable);
> -       spin_unlock_irqrestore(&host->lock, flags);
> +       raw_spin_unlock_irqrestore(&host->lock, flags);
>  }
>
>  static void meson_mmc_ack_sdio_irq(struct mmc_host *mmc)
> @@ -1225,7 +1225,7 @@ static int meson_mmc_probe(struct platform_device *=
pdev)
>         if (ret)
>                 goto err_init_clk;
>
> -       spin_lock_init(&host->lock);
> +       raw_spin_lock_init(&host->lock);
>
>         if (host->dram_access_quirk) {
>                 /* Limit segments to 1 due to low available sram memory *=
/
> ---
> base-commit: 587858367581b9c55c3690f4e63382ad622719d4
> branch: meson_mmc_raw
>
> --
> 2.53.0
>
