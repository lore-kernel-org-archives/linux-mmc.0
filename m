Return-Path: <SRS0=qhCx=2D=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79768C43603
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Dec 2019 23:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FA9214D8
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Dec 2019 23:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576278103;
	bh=zDPv/9RxcSm5oTlvIS9ne5tb4tHAmwNZymPZG0Rt3eI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wRM/EiGFElQyoQskqS3LoAex3wrQxX1g3ZDsOGincyGnseWFkPDT7U258geFxywsu
	 C1ZCT7IApotBP+VlJyLJ8Ffz314WnlKdladGh9Jg1M1xPMm8uA25QuA0VVUsU/YVKm
	 H58wPNpLwQU7ILWPotCYBc5vvsW2f7ajzuS+bMNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfLMXBm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:01:42 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35814 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfLMXBk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Dec 2019 18:01:40 -0500
Received: by mail-ot1-f67.google.com with SMTP id o9so1012271ote.2;
        Fri, 13 Dec 2019 15:01:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xm+fbSPSrtSF+VAo9R4McLST/GPCqY57riiToMxZYhk=;
        b=Z6EkM0OMpBqdrkUWxt8yxTu+GO2GHC2q7QZxg0RB2OlmOAm47PADXpHunO+4B+Fe5n
         OkB5yKPBAdAAv3H8ZOqNwCjv3GL8/xHnbH9T90Ov36QA3ex8USbd9FRprwdqA7EKHor0
         pDC/7M4hoOQhA5lK08DSgijmOdhATk2Y6ceCMIB6uLjA9Om6CmHAhqwMN/dy5oJ5iLQW
         BXlD4IMcNWhystddBKPpXNzhuewRncpd2xS6ROjPCM3HyCftfSN9MN1rMbsggvDNDAQP
         cIFc9F+z2yQ8934Rg5HuJMjGcWSAnOUdZbLuNl5ZvuSZXS2J8rlSVL7Vyk5kf30BEpit
         VCrA==
X-Gm-Message-State: APjAAAXi+rpAIxiga1RhHz8iSGI0Ck/7LKjuPk9LwUySJx1MgLB/NIUm
        4x1SujnOm3p6+OkNadkRBA==
X-Google-Smtp-Source: APXvYqzIiqaq+YQWjf3lNmJ6LHP6WcxhXoPUE2+l/x5bazKzbr6i8wjJ+zH26j5rSs1hAKNV6cutNQ==
X-Received: by 2002:a05:6830:605:: with SMTP id w5mr16417678oti.298.1576278099402;
        Fri, 13 Dec 2019 15:01:39 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d136sm3799652oib.32.2019.12.13.15.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 15:01:38 -0800 (PST)
Date:   Fri, 13 Dec 2019 17:01:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jun Nie <jun.nie@linaro.org>
Cc:     ulf.hansson@linaro.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] mmc: sdhci: dt: Add DMA boundary and HS400 properties
Message-ID: <20191213230137.GA15696@bogus>
References: <20191202144104.5069-1-jun.nie@linaro.org>
 <20191202144104.5069-3-jun.nie@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202144104.5069-3-jun.nie@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Dec 02, 2019 at 10:41:02PM +0800, Jun Nie wrote:
> DMA memory cannot cross specific boundary on some controller, such as 128MB
> on SDHCI Designware. Add sdhci-dma-mem-boundary property to split DMA
> operation in such case.
> 
> sdhci-ctrl-hs400 specify the HS400 mode setting for register
> SDHCI_HOST_CONTROL2(offset 0x3E:bit[2:0]). Because this value is not
> defined in SDHC Standard specification.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci.txt b/Documentation/devicetree/bindings/mmc/sdhci.txt
> index 0e9923a64024..e6d7feb9a741 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci.txt
> @@ -11,3 +11,11 @@ Optional properties:
>  - sdhci-caps: The sdhci capabilities register is incorrect. This 64bit
>    property corresponds to the bits in the sdhci capability register. If the
>    bit is on in the property then the bit should be turned on.
> +- sdhci-dma-mem-boundary: The sdhci controller DMA memory space boundary.
> +  If the controller's DMA cannot cross a specific memory space boundary,
> +  such as 128MB, set this value in dt and driver will split the DMA
> +  operation when crossing such boundary.

This should be implied by the compatible string.

> +- sdhci-ctrl-hs400: The HS400 is not defined in SDHC Standard specification
> +  for SDHCI_HOST_CONTROL2(offset 0x3E:bit[2:0]). Different controllers have
> +  have different value for HS400 mode. If 0x5 is not the HS400 mode value
> +  for your controller, you should specify the value with this property.

This too, unless it needs to be tuned per board.

Can you be more specific as to what the possible values are and what 
they do?

Rob
