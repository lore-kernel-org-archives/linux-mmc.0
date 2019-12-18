Return-Path: <SRS0=wLMj=2I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37F9C43603
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 21:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726AA21582
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 21:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576705166;
	bh=5U99pIQGHxWEneXBslwwBchIytDB/yGCxvdrUJzmLO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s0Kxq5ourqPl9hKfdaYErDUGNGZ8mHol/4922pnG/1w1WKVK8ybW4QZ1XHPsBzfwY
	 Y+n39MJp5K3+JedGLDQabaosqYc7NbkTdToDhn8qahunnvWnGAiiWSZWuAKIyhqS0h
	 NiIPwC4qmgS9DtT+BDFQZ+Cu67znaJv2JdHPve68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfLRVj0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:39:26 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45228 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfLRVjZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2019 16:39:25 -0500
Received: by mail-ot1-f66.google.com with SMTP id 59so4214647otp.12;
        Wed, 18 Dec 2019 13:39:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dBFxRKaaedwkP1g5MLnNuhRSUqWUfU6XqL2o6viIQT8=;
        b=BIOxK6iR1YsJFkwFlOyxBKfatH0+Xt2LE4pcwkASXhQMD1ys81ozBnvwhRekaixNqV
         5KV9RHj21rUT7ZST/gtuvURfgMnwYQIxVlMJTWr0+Hx7dLHM3ofK3Q7fKAaJKVxMQ2Id
         Ovh1oUsxwrp7o+MSb9niSmY7lJE5ZzUI58jy8/b6GEQgEh7inURsHd1nCHlCg+oyXbgm
         2J9YAc9LyeaSm9gtJSHhln/8QLPP5JGGzfWTROWBwUPwDnWv5vV7euPG5h8ivgDrwvq6
         zrXcS5N9y4a7WaRzUyddsNdR2gVb5pLPx90vNalkDXGBE+mb4GR+XW5Eu/oD3ZMOH8ct
         QS6A==
X-Gm-Message-State: APjAAAXk0gGTkt7gIfq/xnkk3908DXcSgIKC/X1bIfaHb177IaKjjOcw
        a/UrIkCotUhxkcQfq+jhNIaJm6+hKA==
X-Google-Smtp-Source: APXvYqzDK7aog7i/C+mHwCkZW9atlbt2uwA+8aK1TlTW6VE80Vfah9nRZR9WuFj1CWR1TaUMDGZefg==
X-Received: by 2002:a9d:21f4:: with SMTP id s107mr2532318otb.102.1576705165023;
        Wed, 18 Dec 2019 13:39:25 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c12sm1244305oic.27.2019.12.18.13.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:39:23 -0800 (PST)
Date:   Wed, 18 Dec 2019 15:39:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, kishon@ti.com, adrian.hunter@intel.com,
        mark.rutland@arm.com, robh+dt@kernel.org, ulf.hansson@linaro.org,
        zhang.chunyan@linaro.org, tony@atomide.com
Subject: Re: [PATCH v3 1/7] dt-bindings: sdhci-omap: Add properties for using
 external dma
Message-ID: <20191218213923.GA1879@bogus>
References: <20191210095151.15441-1-faiz_abbas@ti.com>
 <20191210095151.15441-2-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210095151.15441-2-faiz_abbas@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 10 Dec 2019 15:21:45 +0530, Faiz Abbas wrote:
> From: Chunyan Zhang <zhang.chunyan@linaro.org>
> 
> sdhci-omap can support both external dma controller via dmaengine
> framework as well as ADMA which standard SD host controller
> provides. Add binding documentation for these external dma properties.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-omap.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
