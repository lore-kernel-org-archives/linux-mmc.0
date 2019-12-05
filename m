Return-Path: <SRS0=6ao/=Z3=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEB0C2D0C0
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Dec 2019 21:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFEB24676
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Dec 2019 21:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575580522;
	bh=65qof+2pKIiDkdnbH27diEYSYggjj2e6fRn+s00UYrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yFeP/IMN1g4HutSxYMdLOpR5Mg7er8rhyNLJ1JYiEk0nr+QAXtWN6lXtBLNhr33JM
	 CcfSylKojOO05fi2Mh6SYZgIQZGQxotQVdYUKVXn/F9X7XZ4gkX0j/1rBLKiSddxyR
	 ZsYekv3RibiQbb3gFjlqxNJi1xbl79Cmctzw1ty8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbfLEVPW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Dec 2019 16:15:22 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42314 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729450AbfLEVPW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Dec 2019 16:15:22 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so3911410otd.9;
        Thu, 05 Dec 2019 13:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YJ9zindtieuDhe+7MeY3HR+ZIrhEnTYORFnF43Fjuuo=;
        b=H8FjBmCGpKJ12wybDVkmrbxMQtMFXJnBNXpQu+uP8Bz+UET1zkLgd0Q4DSYX+K4lqs
         R+xgMm3YJptsTUZMSWQsR5M4heft+hOXqhNLpUIQJaP0VXUjTxkju2wgpjUXR5U/lcwP
         xatmqD6UYO+CDHy7qPT44ntLXzsu9FHi/fT625rP2MWeBUxaTTuJuEzIIcOw/YMHVbeh
         Nap/78Zfq7KqNjbk/IuBi54arNETu7ZdQVTTLJWPLrx+Ay+Hv9Yka5irqYUiQ3tY78nX
         gR/+3iGYyIveGWAdpKKnvZYka/N4nqg76aDUMcLua+q4cUK1uErDLG6mWXob2rrUwBgu
         XH8Q==
X-Gm-Message-State: APjAAAUm4GCX9FzepGahoB43GDh77p2X0lTPes0nv1xj7bnzVm8fdF7z
        xA4jPz7euZzcG6PhEmgzsA==
X-Google-Smtp-Source: APXvYqxZcyLjEEXrywjejvo3Fovq/Vj1ZK2rPKMOypHYm8vTPRNz4P37AyKMhs/HcKqGxOLJBudH/Q==
X-Received: by 2002:a9d:58c9:: with SMTP id s9mr8001069oth.121.1575580520010;
        Thu, 05 Dec 2019 13:15:20 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f62sm3800001otf.23.2019.12.05.13.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 13:15:19 -0800 (PST)
Date:   Thu, 5 Dec 2019 15:15:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, asutoshd@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        cang@codeaurora.org, rampraka@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH V1 1/2] dt-bindings: mmc: sdhci-msm: Add compatible
 string for sc7180
Message-ID: <20191205211518.GA30447@bogus>
References: <0101016eacb255af-3985262d-9b7e-4813-88c2-61838406e12c-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0101016eacb255af-3985262d-9b7e-4813-88c2-61838406e12c-000000@us-west-2.amazonses.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 27 Nov 2019 11:49:59 +0000, Veerabhadrarao Badiganti wrote:
> Add sc7180 SoC specific compatible strings for qcom-sdhci controller.
> 
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
