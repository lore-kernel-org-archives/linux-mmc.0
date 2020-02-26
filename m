Return-Path: <SRS0=M0wQ=4O=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F590C4BA21
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Feb 2020 22:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EB124680
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Feb 2020 22:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582755794;
	bh=RGqRItNR/79xWgXJ8+QEHMDbc8trDfsvxoI+hP/v2K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kgcXpz6miVXRksAgBRYzbb15TTeabmaXDcjKc94qIQc2851xiqqlZP6tUritxJID+
	 WXlU/xxRGyVXlBHHw7qnNUNUuU5vCSP+N530F0SBDsaJux8NBhKEWnRBEzcgTt3JVI
	 tcqpLtJUbinBFG+6PWHUuH/3PPDfv0YDgJXxslFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgBZWXN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:23:13 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34905 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbgBZWXN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Feb 2020 17:23:13 -0500
Received: by mail-oi1-f193.google.com with SMTP id b18so1253562oie.2;
        Wed, 26 Feb 2020 14:23:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=79Q7F+M1QhHEaX8TOaJVGRIrvFOi5X8o2Ic3nB/hgx0=;
        b=Cq5oLBZ7rL1ImHRBxBie5X3osBk3/F5TGV94fh93Jts/5G/PjIJOrhj9kHcbuImE4W
         qpjsvfzFwrPmFTdJwgWrlDXao02h2d0L0IcBTR6dTz7Ur7uGEDK9GjeOLBdOC4X0Ok7Y
         YO17O64m/1xmHLsocaWDZPdGweQN98EytGxD+4UqWehLNNB41DOt2oCcBke3Mgi1dLym
         V/19y2uRhBcAZJE4tdd74M/Ik3hyNZ1lh6aJ7Yy98Ngb08jlD1a3qj8k2Yke36uBrc4m
         5vkF1vKJnOpAU1Uld4N26etPxXvLV3uWIeiU3DoTS4Tv5iejLYMIHmWpNsEGsQdetnwI
         zjzQ==
X-Gm-Message-State: APjAAAWHnUunbaZZNCcyj/zK06p00bIXA27U80Yqc8SKmG+ht9XuOGWj
        0gqPRwclCCQMkACMJHOrkg==
X-Google-Smtp-Source: APXvYqwzctjk82S+BvTrg2YLIbwFm5te1XWlztFHfaJJst8QWR0QO1scOwboQI7ioiRGkD0rrRVwJg==
X-Received: by 2002:aca:889:: with SMTP id 131mr957026oii.3.1582755792959;
        Wed, 26 Feb 2020 14:23:12 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w72sm1259158oie.49.2020.02.26.14.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 14:23:12 -0800 (PST)
Received: (nullmailer pid 8890 invoked by uid 1000);
        Wed, 26 Feb 2020 22:23:11 -0000
Date:   Wed, 26 Feb 2020 16:23:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        masahiroy@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: mmc: Convert Cadence SD/SDIO/eMMC
 controller to json-schema
Message-ID: <20200226222311.GA8834@bogus>
References: <20200222143444.5135-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222143444.5135-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 22 Feb 2020 23:34:44 +0900, Masahiro Yamada wrote:
> Convert the Cadence SD/SDIO/eMMC host controller IP (a.k.a. SD4HC)
> binding to DT schema format.
> 
> Socionext UniPhier ARM 64-bit SoCs are integrated with this IP.
> 
> Cc: Piotr Sroka <piotrs@cadence.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> I wanted to keep some precious comments, which apply to multiple
> properties.
> 
> I do not think 'description:' is a good fit for this.
> 
> I was searching for a way to insert a comment line that does not
> affect the schema.
> 
> The $comment did not work. I just use '#', which is YAML comment.
> If there is a better way, please let me know.
> 
> 
> Changes in v2:
>   - fix schema warning in example
> 
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 143 ++++++++++++++++++
>  .../devicetree/bindings/mmc/sdhci-cadence.txt |  80 ----------
>  2 files changed, 143 insertions(+), 80 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
> 

Applied, thanks.

Rob
