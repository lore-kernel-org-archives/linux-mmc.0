Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17920C47082
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Jun 2021 13:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9F4261182
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Jun 2021 13:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhFCNij (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Jun 2021 09:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhFCNij (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Jun 2021 09:38:39 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC230C06174A
        for <linux-mmc@vger.kernel.org>; Thu,  3 Jun 2021 06:36:54 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id e2so7190547ljk.4
        for <linux-mmc@vger.kernel.org>; Thu, 03 Jun 2021 06:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NdRtta8a0czifThKtgLdXLZkKE9BNZrMTRFEzXXQo4c=;
        b=BsZKCXOVtcYKsUJ0XggnadbCLiExs5aEmpQOvqjSHntMvACxDDfYAqmUHs0WKzsHMh
         bzIhihahpKRlIvDnQxeGttQ9RIBsAMEgbfoGCnIgJymxUJ560eCzr0JstCu7u6pFQL5N
         xdV2vrCLLjyAcDhjKZACdRXV2dvuZTXd/khb9XL7MyzN6oVZr9otfveFUpUqMBInZQg/
         CRmkKO0/neKBqqMS7UefgFItpVgNcf87PJD8DnCGt6KlM7aXt9Vm4mMvAL77hQDhn4GH
         gQn7d7bP34lx1JANN7WVjsNH2Jjs4vT4BTo1lsCpQS8w6Iz8DWUddZmRAu87a4qERLCy
         FVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NdRtta8a0czifThKtgLdXLZkKE9BNZrMTRFEzXXQo4c=;
        b=uPmTnE+/OLMbSsgtK1+HMBEbTi1fJ1/T2aIUztaJzSZjttw9vbvxQPGoScY6/XrDUl
         MZVN50LJwR4GvsHv3XhpjV0930UZZH+oLLKeTLppNU3r00HhVjB5D6AopnnQByGfl8Df
         3rG0tCr/a+AjWP2i6vGxrz7ETbTOCCtHccGT/Do3sVs7w8zJwqcam08XnGl19gA/ITbA
         68ZVuhOnWrJSw8otqQMvx7jDhLUjLyaOo20mf0puSiF8xTG/CGANdmUjeyHJXvQ96xQk
         acJWQ6duZFsCsF2PcNZOm4ljOwWzDdRuLdhZNcN2OZL47tDB3yLjabzeB4kt3BtTqvKd
         +3aA==
X-Gm-Message-State: AOAM5316NhtZYmfbMzp/zfHrCGh669IOF+NldUU8P2oLnBy9Ud17RgBG
        ltFA3J1tczBQf5Xn/4gI4CkcqA==
X-Google-Smtp-Source: ABdhPJxA6RCf5p7lk3rUd7/Zf0MpSRWaTFsS6jkBivLgNGp2FKyZEVc41k9JBhyM/uyKQWlH5m7j3w==
X-Received: by 2002:a05:651c:49d:: with SMTP id s29mr986100ljc.279.1622727412984;
        Thu, 03 Jun 2021 06:36:52 -0700 (PDT)
Received: from localhost (h-62-63-236-217.A463.priv.bahnhof.se. [62.63.236.217])
        by smtp.gmail.com with ESMTPSA id l26sm370691ljg.87.2021.06.03.06.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 06:36:52 -0700 (PDT)
Date:   Thu, 3 Jun 2021 15:36:51 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: abort tuning when timeout detected
Message-ID: <YLja801wAima1x9E@oden.dyn.berto.se>
References: <20210602073435.5955-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210602073435.5955-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Wolfram,

Thanks for your work.

On 2021-06-02 09:34:35 +0200, Wolfram Sang wrote:
> We have to bring the eMMC from sending-data state back to transfer state
> once we detected a CRC error (timeout) during tuning. So, send a stop
> command via mmc_abort_tuning().
> 
> Fixes: 4f11997773b6 ("mmc: tmio: Add tuning support")
> Reported-by Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> 
> Ulf, I'd think that mmc_abort_tuning() should be named
> mmc_abort_tuning_cmd() instead. Because we don't actually abort the
> tuning as a whole in this function. What do you think? I can prepare a
> patch if you agree.
> 
>  drivers/mmc/host/renesas_sdhi_core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index 635bf31a6735..9029308c4a0f 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -692,14 +692,19 @@ static int renesas_sdhi_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  
>  	/* Issue CMD19 twice for each tap */
>  	for (i = 0; i < 2 * priv->tap_num; i++) {
> +		int cmd_error;
> +
>  		/* Set sampling clock position */
>  		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TAPSET, i % priv->tap_num);
>  
> -		if (mmc_send_tuning(mmc, opcode, NULL) == 0)
> +		if (mmc_send_tuning(mmc, opcode, &cmd_error) == 0)
>  			set_bit(i, priv->taps);
>  
>  		if (sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_SMPCMP) == 0)
>  			set_bit(i, priv->smpcmp);
> +
> +		if (cmd_error)
> +			mmc_abort_tuning(mmc, opcode);
>  	}
>  
>  	ret = renesas_sdhi_select_tuning(host);
> -- 
> 2.30.2
> 

-- 
Regards,
Niklas Söderlund
