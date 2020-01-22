Return-Path: <SRS0=yZYV=3L=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7015C2D0DB
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Jan 2020 16:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD27124125
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Jan 2020 16:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579709150;
	bh=liTBeyBN+5snIlCvPH4ZinIcQWwSawPqLwrjOX0CEFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w04KZDeT9VphSC5gEKMkajpg9ikl6Yy5SRFMupaSK+1Z0NVD9IXDSBW7O/yob5Ozb
	 W4Tk06K4UaR1tOFtptIDMKL2KiEKUHyOHO/neTDSmRa6Je1WZJlixl1XciQgqdqxd1
	 ki2/RZIte1PfngRo221A87+Vv6CaZK8Ry73gylnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgAVQFq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:05:46 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43052 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVQFq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jan 2020 11:05:46 -0500
Received: by mail-oi1-f194.google.com with SMTP id p125so6509313oif.10;
        Wed, 22 Jan 2020 08:05:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OOZfg0AFYGJWh0pCwLs+lbCJjankCvcKcEp7OWZe5xk=;
        b=tT7Wh5W4BzN/KI9aPxWbDunabn25jHwub2OLPWRkxd4mYHQBJRz4vknMyzjTr8g17A
         j/hoeFDKhjHJJioMHQ4qxsiLDk/HLoUH9d/AncVXDejE/2+PocyFut2iS0YyL9h1q6hh
         Ybg6yPtzjzhqnvptwLnMBHVjONQIdni4li2gny/bg2tovXtEbR04nMNZvFr+f4DD4Vih
         XC6hWMjBKhccoKXq3AuUlyLLGdoXaKN5MV066DL/NQh0ePtdcdxzaoiEpmn+uusFB7DP
         luQl+EU9yhXrx3BGz9KsANAs7l7Y9bFkenjuP7VxxL8Agp8lzv52L4rPmySGDuNsBg89
         OABg==
X-Gm-Message-State: APjAAAXpY/TXmRbhTXOW0c6irc5yaCWyyojvrIVuSJUS//VWcqUrQilP
        a58Q8dExt2sdbNgQ0nald7e7qzE=
X-Google-Smtp-Source: APXvYqzwaLmXI7rjVv06eVcOu9xvGZYDWVtvuuyQhzjMxlcVTBftNmxWpRN/xuSrOfQOYU/l0SEFMw==
X-Received: by 2002:aca:5490:: with SMTP id i138mr7450180oib.69.1579709145237;
        Wed, 22 Jan 2020 08:05:45 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n22sm15062248otj.36.2020.01.22.08.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 08:05:44 -0800 (PST)
Received: (nullmailer pid 10486 invoked by uid 1000);
        Wed, 22 Jan 2020 16:05:43 -0000
Date:   Wed, 22 Jan 2020 10:05:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        heiko@sntech.de, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 2/3] dt-bindings: mmc: convert rockchip dw-mshc
 bindings to yaml
Message-ID: <20200122160543.GA10427@bogus>
References: <20200116152230.29831-1-jbx6244@gmail.com>
 <20200116152230.29831-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116152230.29831-2-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 16 Jan 2020 16:22:29 +0100, Johan Jonker wrote:
> Current dts files with 'dwmmc' nodes are manually verified.
> In order to automate this process rockchip-dw-mshc.txt
> has to be converted to yaml. In the new setup
> rockchip-dw-mshc.yaml will inherit properties from
> mmc-controller.yaml and synopsys-dw-mshc-common.yaml.
> 'dwmmc' will no longer be a valid name for a node and
> should be changed to 'mmc'.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |  49 --------
>  .../devicetree/bindings/mmc/rockchip-dw-mshc.yaml  | 123 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  3 files changed, 124 insertions(+), 49 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
