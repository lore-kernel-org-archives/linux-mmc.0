Return-Path: <SRS0=Gh8q=EM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBA6C4742C
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 03:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB465206DB
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 03:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="q827mlB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgKFDZt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 22:25:49 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:56684 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKFDZs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 22:25:48 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201106032543epoutp0481ca5b0da2900db40efe32e200a9e6e6~EzVeRiO5V3220632206epoutp04a
        for <linux-mmc@vger.kernel.org>; Fri,  6 Nov 2020 03:25:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201106032543epoutp0481ca5b0da2900db40efe32e200a9e6e6~EzVeRiO5V3220632206epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604633143;
        bh=oYJZ1byBP0HsPhl5XHQlUp6p7zDlyIlOAgoP1oZkrwY=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=q827mlB9Sid4iX3Ggxg9oG8jNdR+OK7LwZ2Y8y5w4gL2ParGtEa5sedQStdhvREsG
         a+b+rHPXu7oUzi+v7+ntJE+TQPxEExRclHvwnCuDGvCHTn9ZJjGz2elGpEyW4ZuHgJ
         +2G8iZ7OMvcJRdqaDI8S6OKeC0y7GV0zIT7PTcyw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201106032542epcas1p1adf3ee1780b9a7928afda4e1c816441c~EzVd1ol1z2550525505epcas1p1V;
        Fri,  6 Nov 2020 03:25:42 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.156]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4CS5Pc1zBxzMqYkh; Fri,  6 Nov
        2020 03:25:40 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.3D.63458.432C4AF5; Fri,  6 Nov 2020 12:25:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201106032539epcas1p11d27b089073568c330042ae3d0df71b6~EzVa_Envw1497314973epcas1p1r;
        Fri,  6 Nov 2020 03:25:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201106032539epsmtrp1ee35f3d9cdac267429206f737332091d~EzVa9bHrS0303703037epsmtrp1h;
        Fri,  6 Nov 2020 03:25:39 +0000 (GMT)
X-AuditID: b6c32a36-6c9ff7000000f7e2-3d-5fa4c234acf7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        79.98.13470.332C4AF5; Fri,  6 Nov 2020 12:25:39 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201106032539epsmtip14485729d07d59eabf6d73f42a7183176~EzVatBNmw1937619376epsmtip1Y;
        Fri,  6 Nov 2020 03:25:39 +0000 (GMT)
Subject: Re: [PATCH] mmc: dw_mmc: replace spin_lock_irqsave by spin_lock in
 hard IRQ
To:     Tian Tao <tiantao6@hisilicon.com>, ulf.hansson@linaro.org,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <f40de7cc-83da-9147-fb84-f3ab474a16f7@samsung.com>
Date:   Fri, 6 Nov 2020 12:26:00 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1604627813-59785-1-git-send-email-tiantao6@hisilicon.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdlhTT9fk0JJ4g0+neCwu75rDZnHkfz+j
        xd17J1gsVr/ex25xfG24A6vH47kb2T3uXNvD5tH/18Dj8ya5AJaobJuM1MSU1CKF1Lzk/JTM
        vHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoK1KCmWJOaVAoYDE4mIlfTubovzS
        klSFjPziElul1IKUnALLAr3ixNzi0rx0veT8XCtDAwMjU6DChOyMWX1zWAt2S1R8u/qTrYFx
        l3AXIyeHhICJxNPF/SxdjFwcQgI7GCXeL+1lh3A+MUp0nd7JCOF8Y5Q4f+wEG0zLj2OtUFV7
        GSXe7roG1f+eUeLckresIFXCAmESE3Z+A6sSEZjEKDF153UWkASbgI7E9m/HmUBsXgE7icdX
        JjN3MXJwsAioSKx4aQgSFhWIlNj59CU7RImgxMmZT1hASjgF3CV291mBhJkFxCVuPZnPBGHL
        S2x/O4cZZJWEwEt2iYNdfcwQl7pIdPz/BnW1sMSr41vYIWwpiZf9bVB2tcSu5jNQzR2MEre2
        NTFBJIwl9i+dzASymFlAU2L9Ln2IsKLEzt9zGSEW80m8+9rDClIiIcAr0dEmBFGiInHp9Usm
        mFV3n/xnhbA9JNZ9f88KCatZjBKd7x6zTWBUmIXkzVlIfpuF5LdZCFcsYGRZxSiWWlCcm55a
        bFhghBzdmxjBSVLLbAfjpLcf9A4xMnEwHmKU4GBWEuG94LcoXog3JbGyKrUoP76oNCe1+BCj
        KTDcJzJLiSbnA9N0Xkm8oamRsbGxhYmhmamhoZI47x/tjnghgfTEktTs1NSC1CKYPiYOTqkG
        JruG4NR6h61nH19KkMs5vHbx1saZGzMEHz1ROmK1Pu2Hhb1rpOCq86knXCXXMokoz55lqifr
        eGZiXdDXZxNFVJuOz/S1bS0Ouyu8XWD6qXfhcebvo/cvnbd31iF3x7hDE7LKNR5/Yfx6dL7a
        4X0iPL/k823rutw7ekw/Cd7xLPlrJjdz16l1h3iDkqz6l/0UlbWaNOFg02Mx7eeL/k4zv2i8
        7niAkNcS309Ptd+3hugcTVJ5+UuvY9nG9a7Pj5xvOLVb/J/3hLQva/TM353u8xNaysiT+VF2
        3tSwaKdHv3p1aqcyeD//8rL4+7aQBye3BD6Mkl2+qTEhttni9bOLL27JrLhyqe9J1i0Vph1S
        WtuVWIozEg21mIuKEwErZjP8GwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWy7bCSnK7xoSXxBo9aFS0u75rDZnHkfz+j
        xd17J1gsVr/ex25xfG24A6vH47kb2T3uXNvD5tH/18Dj8ya5AJYoLpuU1JzMstQifbsEroxZ
        fXNYC3ZLVHy7+pOtgXGXcBcjJ4eEgInEj2Ot7F2MXBxCArsZJSbf2c0CkZCS+Px0KlsXIweQ
        LSxx+HAxRM1bRoneiX/ZQWqEBcIkJuz8BmaLCExilGi+WgtRNItRYuaRZ2wgCTYBHYnt344z
        gdi8AnYSj69MZgYZyiKgIrHipSGIKSoQKbFzhyVEhaDEyZlPWEDCnALuErv7rEDCzALqEn/m
        XWKGsMUlbj2ZzwRhy0tsfzuHeQKj4Cwk3bOQtMxC0jILScsCRpZVjJKpBcW56bnFhgWGeanl
        esWJucWleel6yfm5mxjBYa+luYNx+6oPeocYmTgYDzFKcDArifBe8FsUL8SbklhZlVqUH19U
        mpNafIhRmoNFSZz3RuHCOCGB9MSS1OzU1ILUIpgsEwenVANTc2NIQOJ847ZDXkIFjuVWpwS5
        brKe5l7gZnlzXs29lG+Wk3+4y4YvUdl9pF+2f3Kev3dGi7bnHffjq3/vmrHq3Jo+O77j6c/U
        NrpoGU7P3X53NdsrNSPvfQx9fdP537xokkxQ1zOWPJi35K5BY+NzA+eb+WtuKHTV7bhp9N9a
        4uuTI01e+85E+N+7zGhSHjZVzP3nrmNVfguOHX6XV7962b72mDguB5XOu9q2Uzfp/vT7ahbx
        fvMUeZlej1ehxWIfD5S/+aXFH833MoM9sGjLO9snuWfuPeRN3bK6K7Z4hor1pGUuHR2XY902
        Rc1fUcGq8OeQ3dS0S3J/u9R5J7y7vI6v7nbYWaVdGcyro6yVWIozEg21mIuKEwFB9Yh/6gIA
        AA==
X-CMS-MailID: 20201106032539epcas1p11d27b089073568c330042ae3d0df71b6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201106015629epcas1p1e017132d77d8b20e7aa6706a6d471adf
References: <CGME20201106015629epcas1p1e017132d77d8b20e7aa6706a6d471adf@epcas1p1.samsung.com>
        <1604627813-59785-1-git-send-email-tiantao6@hisilicon.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Dear Tian,

On 11/6/20 10:56 AM, Tian Tao wrote:
> The code has been in a irq-disabled context since it is hard IRQ. There
> is no necessity to do it 
Even though I don't remember, there is a reason to use spin_lock_irqsave()..
I will check it. If there is no reason, i will reply.

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 43c5795..a524443 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2617,7 +2617,6 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>  	struct dw_mci *host = dev_id;
>  	u32 pending;
>  	struct dw_mci_slot *slot = host->slot;
> -	unsigned long irqflags;
>  
>  	pending = mci_readl(host, MINTSTS); /* read-only mask reg */
>  
> @@ -2632,15 +2631,15 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>  			 * Hold the lock; we know cmd11_timer can't be kicked
>  			 * off after the lock is released, so safe to delete.
>  			 */
> -			spin_lock_irqsave(&host->irq_lock, irqflags);
> +			spin_lock(&host->irq_lock);
>  			dw_mci_cmd_interrupt(host, pending);
> -			spin_unlock_irqrestore(&host->irq_lock, irqflags);
> +			spin_unlock(&host->irq_lock);
>  
>  			del_timer(&host->cmd11_timer);
>  		}
>  
>  		if (pending & DW_MCI_CMD_ERROR_FLAGS) {
> -			spin_lock_irqsave(&host->irq_lock, irqflags);
> +			spin_lock(&host->irq_lock);
>  
>  			del_timer(&host->cto_timer);
>  			mci_writel(host, RINTSTS, DW_MCI_CMD_ERROR_FLAGS);
> @@ -2648,7 +2647,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>  			smp_wmb(); /* drain writebuffer */
>  			set_bit(EVENT_CMD_COMPLETE, &host->pending_events);
>  
> -			spin_unlock_irqrestore(&host->irq_lock, irqflags);
> +			spin_unlock(&host->irq_lock);
>  		}
>  
>  		if (pending & DW_MCI_DATA_ERROR_FLAGS) {
> @@ -2661,7 +2660,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>  		}
>  
>  		if (pending & SDMMC_INT_DATA_OVER) {
> -			spin_lock_irqsave(&host->irq_lock, irqflags);
> +			spin_lock(&host->irq_lock);
>  
>  			del_timer(&host->dto_timer);
>  
> @@ -2676,7 +2675,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>  			set_bit(EVENT_DATA_COMPLETE, &host->pending_events);
>  			tasklet_schedule(&host->tasklet);
>  
> -			spin_unlock_irqrestore(&host->irq_lock, irqflags);
> +			spin_unlock(&host->irq_lock);
>  		}
>  
>  		if (pending & SDMMC_INT_RXDR) {
> @@ -2692,12 +2691,12 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>  		}
>  
>  		if (pending & SDMMC_INT_CMD_DONE) {
> -			spin_lock_irqsave(&host->irq_lock, irqflags);
> +			spin_lock(&host->irq_lock);
>  
>  			mci_writel(host, RINTSTS, SDMMC_INT_CMD_DONE);
>  			dw_mci_cmd_interrupt(host, pending);
>  
> -			spin_unlock_irqrestore(&host->irq_lock, irqflags);
> +			spin_unlock(&host->irq_lock);
>  		}
>  
>  		if (pending & SDMMC_INT_CD) {
> 

