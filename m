Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D1D3BE16E
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068809; cv=pass; b=uUMZrMuzi2bwvGZfa4JUld1tVIri11aha7nllPTJjw2HxTuk7BcwMAKP5QcFGeUfZghc9CQuG3dnHIY9LLVsPbtluTtN6tO4y3CdqKP9mDpQPJqu3afhzodb+gsPM+IQ72VLYQSGsHfls8YvMwVO4KoZ+1P5KkUicEyC+Pfs/i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068809; c=relaxed/simple;
	bh=TdW7saCbu9nSse468CtAYx5gWZVbjeYG1sXL2TBCGmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJZTs8yz3FJLARxLXSIIRRnYnAX5li8Ob/DU1R5gVop6kTBDA+jnXd6Q5WKlVBNPdcOeNatdpW+RirhcwA4gYMke8XDULLcpSSSusz8kHMauDtzeWs2xuic+RmMlSYXGnlf5pwS7ZztbmxPMpsKT/Jwuavb5kQT29shuoYJ5f44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jb1J7dXn; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jb1J7dXn"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a1330ac6c3so4560098e87.1
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 08:06:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773068806; cv=none;
        d=google.com; s=arc-20240605;
        b=PQ0Lfa76xViakB/L/OScHu2oWWEPxNgwF/GvH7hahZayNoxYQ8QZb9dfINN89ARmVx
         Q+j10cWb2RP7owa9qmA3Gu3bx4S8aB3CtPdv1zjk7wsp72KntK8SVc11S9b2PPfUQ0Nv
         izEIUL2+5uY2llZ69cBDaAvCBJ+WhlPcbotvbenDp9P24ixVJBI5QBYhg9ZOTOMqRwPb
         o5cfHoYsS9n+R0XhM0qDZkbheCi1aKLxvmjqbWNTOgBRS5u4jrWLCoYgqC+xI247gXPK
         I6+UeodmA8EQYsCBZGoTtVtvU17FnyQ7eKEnw3oz9nrNnTHjAR51uk0Kfl+1ac45uU+M
         JQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6ucGesIfhOfGml+MzHLEUPi7ZmCwSE7hKO5Oy5YMidY=;
        fh=jc7wla2cHh+7OcdSCKxlcNIP79y5adjNIfABFB3JUlo=;
        b=gVZPUv0VBB2L8Y4jxm2zoDIs6mNT0ptFhX8Zg2QWeURXGAr3GX0V8P2NVVosjCyGjC
         DOx0FIWPUt0gg2IEZ57YJlYNuphhzbQQdsUvh69Of8txG5sp8DbYa4l4i7nLRpe5BpQ9
         0sB1ScY0JQBFLx7LWF6lUZb1TWHUXyo7fMUNQd11vt+fovc5NoEGTqMUi+LV2vmguZIM
         tFSSvSyEqfYZ9UGIE3vp2l4f1pmHV6YTx80zmk/f936ogLOPlXlJJd0c2NrhB9Sp/o5b
         U2cWwnbIDvAz0b2bmUBTgK0XNBSnyj4bQLXWqVcLFdr1Vy3HAq2AlzABZx37DY0RJyoX
         4VtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773068806; x=1773673606; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6ucGesIfhOfGml+MzHLEUPi7ZmCwSE7hKO5Oy5YMidY=;
        b=jb1J7dXnYYNaGBwusyTKT7k/MpgU+agGZFjv5gcl8qkzl+Ka2F54jGtS/rTHQ1UAes
         f4piDbVKMHqwu0AJz7XOeka1xQ7gve1SpGM+vlZh9myjlevw3mJA+FIA3J+rzh8U3VwA
         e29BRfYwx5sufoIhWpDB85XWdoY23PgPSsC6kK9ZDj01wY56se9CJ5LIUSMKjK7B7BoR
         PNWgip8EpCSNy5gxAfTl+RUpLo2Wjw7OsVnTJyZyV5GHeyP8ciswvuwaQRsL2RObU1Xf
         Q/D165121VhEhS5p9HSfYkEWhvOcM44pXOTuU4FYZvMJvRWUAVdLx8Hji4DkBOWwpGFK
         z/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773068806; x=1773673606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ucGesIfhOfGml+MzHLEUPi7ZmCwSE7hKO5Oy5YMidY=;
        b=LaWEEcoAxPOB8/GTRz2UX5cX/xEsZAqKT/gEJD0guLaA6ub30dgCRgap2H6BseBMEu
         ukfc4S+4O5ReVObrIM4Qlzo+XfRFLIyw8OIgB26unV89ue1bfmko91BnZi28rM513SD7
         iPnPkH0EaJREdHnisP5ZQl1x+Xd2f4DzV6+kEKFrYHih27sn2/UhlxdrcqLCHsXvXzIZ
         RA5KpPUSpgmbYcfMU76jGYoxCVH2IvT1v/+RDjk+zcrL5FCK68tSATBm4mPWmdcnc4OK
         3hASF4Nzq653QUkTuJd/Vlt1JqcsxEGxRKSPKpBpLqJRDO2GyVfbnoL5QZwQsf6E/S6Y
         +8nA==
X-Forwarded-Encrypted: i=1; AJvYcCW/zKsNACDlkpRZ668YULKWNi+4gQdEw0LYRiJoTzlGn+diY2zvfHhgoz58ghcJ9reLEDWcIPUZTTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Y2YAC8/wiePIOXFTDKhpfVV0zZW5zL7CKdS5ASaBLypvgdNz
	DOIyOC2EB9ykDWVZw6jmSbo5/eOV6XqtTs2e1D3gjP8u5RO6YENziq882PbyrU7HOxEgGM/tOxI
	KIXACQv8MnbCa0gECUOvKmNEG3uMyTrVw+tyijij3lg==
X-Gm-Gg: ATEYQzw3KHWUDn3CdynMWp17FwEk24ksZCWPOTOrnGPjBan2kCba16pyXrcqwPFTxoO
	dikO7WIjWQhUcyFwq+beOjrbvZDYMSufvNHh+f8fWWbnyFcOhvFTC91spDg/G+qNVC3x3tWSMO0
	35ToG0QialkHo8+Q+TYpE97ztE62h3SPDgrevN7wzXeoMRyE7TDS0/qoOxHcfYSHM9GypUKDT/6
	/TdM8HQUIrHQIZAf00ulY1DNt6hfJKmcOoTB38jc6gnyuusY0UIejh1GzBqRHgbPh+BSqi4seal
	u01YbJZo
X-Received: by 2002:a05:6512:39ce:b0:5a1:2a8c:d6dc with SMTP id
 2adb3069b0e04-5a13ccafadbmr3870240e87.13.1773068805450; Mon, 09 Mar 2026
 08:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-bst-v2-1-c7bfbed68d10@gmail.com>
In-Reply-To: <20260302-bst-v2-1-c7bfbed68d10@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Mar 2026 16:06:09 +0100
X-Gm-Features: AaiRm50s_BRGZVzLDZ62jUR4o1sZ0eDPxuow_fMhTFzk1FXD5XNYgYL9ecpU_OI
Message-ID: <CAPDyKFrgq_YBSgSookD_MsidNoKYXQJiFr3pTRmXtek8X38m=w@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-bst: Fix memory leak in sdhci_bst_alloc_bounce_buffer()
To: Felix Gu <ustc.gu@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ge Gordon <gordon.ge@bst.ai>, 
	BST Linux Kernel Upstream Group <bst-upstream@bstai.top>, Albert Yang <yangzh0906@thundersoft.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Mar 2026 at 14:47, Felix Gu <ustc.gu@gmail.com> wrote:
>
> In sdhci_bst_alloc_bounce_buffer(), if dma_alloc_coherent() fails, the
> function immediately returns -ENOMEM without releasing the reserved
> memory, which results in a memory leak.
>
> Add the missing of_reserved_mem_device_release() call before returning
> -ENOMEM to properly clean up the reserved memory.
>
> Fixes: 695824f45629 ("mmc: sdhci: add Black Sesame Technologies BST C1200 controller driver")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v2:
> - Fix Adrian's comment.
> - Link to v1: https://lore.kernel.org/r/20260301-bst-v1-1-ddbc22ec3ed9@gmail.com
> ---
>  drivers/mmc/host/sdhci-of-bst.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-bst.c b/drivers/mmc/host/sdhci-of-bst.c
> index c124990a64f4..f8d3df715e1a 100644
> --- a/drivers/mmc/host/sdhci-of-bst.c
> +++ b/drivers/mmc/host/sdhci-of-bst.c
> @@ -425,8 +425,10 @@ static int sdhci_bst_alloc_bounce_buffer(struct sdhci_host *host)
>
>         host->bounce_buffer = dma_alloc_coherent(mmc_dev(mmc), bounce_size,
>                                                  &host->bounce_addr, GFP_KERNEL);
> -       if (!host->bounce_buffer)
> +       if (!host->bounce_buffer) {
> +               of_reserved_mem_device_release(mmc_dev(mmc));
>                 return -ENOMEM;
> +       }
>
>         host->bounce_buffer_size = bounce_size;
>
>
> ---
> base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
> change-id: 20260301-bst-76bb7c6d7931
>
> Best regards,
> --
> Felix Gu <ustc.gu@gmail.com>
>
