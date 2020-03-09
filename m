Return-Path: <SRS0=Ofta=42=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA87C10F27
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Mar 2020 18:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40EB3208C3
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Mar 2020 18:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EQLSmaWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgCISaw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:30:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46308 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbgCISaw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Mar 2020 14:30:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id c19so2910141pfo.13
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2020 11:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CgKKPr0xwtPbP32XtsKM4Pg2CezZujX8rIh5aLwqY9k=;
        b=EQLSmaWU2q/bTK6Rz1P45GyBkBUFS3bk+2CbcMCpLyAq43eVc2WPreKL5a+i6z50IO
         BR/zXDncKdn8muBymm9WU8GSDEM56XkkyORl7tIgBvKivwmAbhAmAHHB3ovqIRKKOshO
         EtoXWfLN/L5BEe5k5H+RUPFvglpuGtZ1vk6/J0cJEcAdXRO6vZaJ+QrMbU10kyjDdDW+
         ZuflQ1anPI1URnPeiwClBJyJKSLi8SWY4D4iX00Qp+5PLH7NZfgZtE7NdrBgxzhmmPr6
         OLpFA3LMf/Q66PZmU+NuBJAXMbCJ40awnoImK4en1CTK0jPuUL/XqKcm0TVxut5RraVS
         G69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CgKKPr0xwtPbP32XtsKM4Pg2CezZujX8rIh5aLwqY9k=;
        b=paABwBmbv5wEKPuj0iT0fW1hdLnuViK4YhdwpVIf7WtTpvdRwXAV6/xuEMxK+L6zJ7
         E1yoKtAvQg4pB/GINtsw6RDxup+Bo1I8Gnfrf+R8vysoCWOxA7Pj0Uph05ZJmzssYWCk
         /3l7a4YvFSq7dcijaDOi+pc7rLRsT5Ixm5BP8AwEM/bcNazLDnWEegjUdyGRKg82QHDP
         IL4iX+bHmSOigSv5hnFsrvBgPZ595eevII7+eAKB4C/o0nqwsngDLwYNE2KmvVHvq+BL
         /C0pou9/kQaYdkPwLWtNifJZQBT58DZ6y3W/zLnYong+FuEczrb++2A4NnEDg52awHkG
         PC0w==
X-Gm-Message-State: ANhLgQ1hKV/4oK+KWKD27v8tPYic6jQ8toYiPzr21SbGPCd2hjcqASEx
        NEonKpZRu3+HWcTiYx1AEDQXLA==
X-Google-Smtp-Source: ADFU+vtOyOd1fQy9lpTnW6EA7iLOMrbyb2Fi2EGCNHqKSXzU/O1QZSHNMGuRlAmRob7bmFMt7xi8cg==
X-Received: by 2002:a63:7783:: with SMTP id s125mr17195558pgc.214.1583778651239;
        Mon, 09 Mar 2020 11:30:51 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d22sm249134pja.14.2020.03.09.11.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 11:30:50 -0700 (PDT)
Date:   Mon, 9 Mar 2020 11:30:48 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dianders@google.com,
        mka@chromium.org, Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>
Subject: Re: [PATCH V2] mmc: cqhci: Update cqhci memory ioresource name
Message-ID: <20200309183048.GB1098305@builder>
References: <1583323250-23596-1-git-send-email-vbadigan@codeaurora.org>
 <1583328320-9981-1-git-send-email-vbadigan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583328320-9981-1-git-send-email-vbadigan@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed 04 Mar 05:25 PST 2020, Veerabhadrarao Badiganti wrote:

> Update cqhci memory ioresource name from cqhci_mem to cqhci since
> suffix _mem is redundant.
> 
> Only sdhci-msm driver is making use of this resource as of now.
> No other vendor's driver is using it. So this update shouldn't affect
> any other vendor's cqhci functionality.
> 
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>

I do favor using names without the "_mem" suffix and it seems like the
existing code only acquire the first two regions by index. So this
should be fine.

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>


But I do expect to see some patches fixing up the 8 dts files that now
has invalid reg-names.

Regards,
Bjorn

> ---
> Corresponding binding change:
> https://lore.kernel.org/linux-arm-msm/1582545470-11530-1-git-send-email-vbadigan@codeaurora.org/
> 
> Changes sicne V1:
> 	- Updated commit text expalining this change affects *only*
> 	  qcom cqhci functionality.
> 
> ---
>  drivers/mmc/host/cqhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> index e2ea2c4..e24b8ff 100644
> --- a/drivers/mmc/host/cqhci.c
> +++ b/drivers/mmc/host/cqhci.c
> @@ -1077,7 +1077,7 @@ struct cqhci_host *cqhci_pltfm_init(struct platform_device *pdev)
>  
>  	/* check and setup CMDQ interface */
>  	cqhci_memres = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> -						   "cqhci_mem");
> +						   "cqhci");
>  	if (!cqhci_memres) {
>  		dev_dbg(&pdev->dev, "CMDQ not supported\n");
>  		return ERR_PTR(-EINVAL);
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
