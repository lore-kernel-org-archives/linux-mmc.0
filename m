Return-Path: <SRS0=yZYV=3L=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549C3C33CB6
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Jan 2020 16:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2681D24673
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Jan 2020 16:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579709112;
	bh=CuhOpIF2duzG21DiXsMj/jDChPb5UGK6X7OQbHHPe3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=07iOJ0oeiyxtIjZBuTEBElUqt2bfh8cJlYSmvpjvaDtueVPwHd2z/pboJXb1txVg4
	 7bPOd16YoaxvqYkbz8YYYW0bk2aXyq9C24qIzMUBqAre+xHGhhsd8elSDdyGnHgEyj
	 UfGbi/smAkD93yCrjo0/5OAF9JGkqDunTx5aWsvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgAVQFL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:05:11 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38462 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVQFL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jan 2020 11:05:11 -0500
Received: by mail-ot1-f67.google.com with SMTP id z9so6737530oth.5;
        Wed, 22 Jan 2020 08:05:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P2nj0uogA4rRFo/vGoXxjKcugggOl6yz11QVdYb92dk=;
        b=lwokpF4JznkK26ipODTjAU7+/O8YsBCwvPebE6+L/MWB9YqjCH/ZG4CQnNZ5JDcJEA
         hvS26MnopWPH81M4O9D3NZSoZJxXLygls1Cc3Tfy9vCamcL4byVCmtBdWq1VCXSCQwqY
         lHVRDcNdJaxsoAf3DNgMxfiJxO/HPUUL4VCoJzF5nw1neho5qxKUaDPd1HlqCOVrje2M
         2kFQ4CcsqvtuYQd3TqcjGRBMuj/9RjTEvmJfi0C8AVD0GiL/cn73yRvedPvDK6HJ5NBE
         guEdJbw+VYxBPPObkYuDK6Fkw0a8iW+VKq86cZEcdK19JbW9JcmvCno3Fk/Upo7wgaVm
         2ulg==
X-Gm-Message-State: APjAAAW0S1SO5wNBoSSU80Qym5l2+YcHdT0ewUcCpCDyvMRyzKFiyICz
        la2i+TdS+0QK1BSBt+MjPQ==
X-Google-Smtp-Source: APXvYqyrhkKZuH0Rsv16TrhCL+xfS8KG9mD/Inml67F3FVNPVpf7HCEz4as/foIuTdlUwhiChYJj8g==
X-Received: by 2002:a9d:60c4:: with SMTP id b4mr8167324otk.166.1579709110222;
        Wed, 22 Jan 2020 08:05:10 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a19sm14764576oto.60.2020.01.22.08.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 08:05:09 -0800 (PST)
Received: (nullmailer pid 9378 invoked by uid 1000);
        Wed, 22 Jan 2020 16:05:08 -0000
Date:   Wed, 22 Jan 2020 10:05:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        heiko@sntech.de, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: convert synopsys dw-mshc
 bindings to yaml
Message-ID: <20200122160508.GA9316@bogus>
References: <20200116152230.29831-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116152230.29831-1-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 16 Jan 2020 16:22:28 +0100, Johan Jonker wrote:
> Current dts files with 'dwmmc' nodes are manually verified.
> In order to automate this process synopsys-dw-mshc.txt
> has to be converted to yaml. In the new setup
> synopsys-dw-mshc.yaml will inherit properties from
> mmc-controller.yaml and synopsys-dw-mshc-common.yaml.
> 'dwmmc' will no longer be a valid name for a node and
> should be changed to 'mmc'.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../bindings/mmc/synopsys-dw-mshc-common.yaml      |  68 ++++++++++
>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   | 141 ---------------------
>  .../devicetree/bindings/mmc/synopsys-dw-mshc.yaml  |  70 ++++++++++
>  3 files changed, 138 insertions(+), 141 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
