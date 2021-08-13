Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997BAC432BE
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Aug 2021 20:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AA3560EE4
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Aug 2021 20:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhHMUY1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Aug 2021 16:24:27 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:35375 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbhHMUYZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Aug 2021 16:24:25 -0400
Received: by mail-ot1-f54.google.com with SMTP id r19-20020a0568301353b029050aa53c3801so13469852otq.2;
        Fri, 13 Aug 2021 13:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G5GJqobectD9I3QiKt1pYv/rhZ007RjyGQ0PhxTSAes=;
        b=UblapYUZ4fDNPE6XELWDmfBowqmUcA9yyK4G+ZAn08fkQK52zYO9wqZYjPcNRquFzx
         9fP0dqOLH794dijsW6kJySxnPh12tOD9fnlhJ9EHRufVhi5RWXFn70WYR3zwLK8RCMTT
         bffsOM3MipOhSGa8Z/MtPfYPdMZpS6lRvDuoYOUb50nZL2cPJ7EEgECDHWAwa7fUyuu6
         gLOJsnj7fXFLDe2Y/BnqcyNCPruPpQBdRE5jBHKhPAUuKzsjEwNoRRjkvwHcRfwJT1bm
         GAR1NRredg+AiPDsOZTSCVcmpFtQChHi+aF1YH43M0kAPV6oAtoSukSK4n2ReoTCl91V
         /auw==
X-Gm-Message-State: AOAM530fELK3uXMOMz27oAobZjv8nsbiCo5Wxd2Y/wD3HhdeIGerZTyp
        dgYhnkxEWCdVqueF4Q5HAw==
X-Google-Smtp-Source: ABdhPJxHmdkVN3w0pkbBAvep1kmZBeHOY5DJblDrmCZZrwhtBv5GIJPUw3iaHTaXyu/42R+C/ffNbg==
X-Received: by 2002:a9d:66d1:: with SMTP id t17mr3510683otm.152.1628886237846;
        Fri, 13 Aug 2021 13:23:57 -0700 (PDT)
Received: from robh.at.kernel.org (2603-8080-2a06-ed00-7254-0b80-dd3c-00c6.res6.spectrum.com. [2603:8080:2a06:ed00:7254:b80:dd3c:c6])
        by smtp.gmail.com with ESMTPSA id 17sm551246oiy.50.2021.08.13.13.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 13:23:57 -0700 (PDT)
Received: (nullmailer pid 3963897 invoked by uid 1000);
        Fri, 13 Aug 2021 20:23:56 -0000
Date:   Fri, 13 Aug 2021 15:23:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     ulf.hansson@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] mmc: pwrseq: sd8787: add support for selectable
Message-ID: <YRbU3NtbYamh7UGH@robh.at.kernel.org>
References: <20210806113001.821660-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806113001.821660-1-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Aug 06, 2021 at 02:29:57PM +0300, Claudiu Beznea wrote:
> Hi,
> 
> This series adds support for selecting the delay b/w reset and power
> lines on pwrseq-sd8787. With this the driver could also be used by
> other devices (e.g. WILC1000/WILC3000 which needs a delay of 5ms). Along
> with this added the DT bindings for WILC3000 device present on
> SAMA5D27 WLSOM1 board.

A 300ms delay doesn't work? Is powering on the device so timing 
critical?

Add a new compatible for your device and imply the timing from that. 
That way we're not extending the binding a property at a time in a 
poorly designed way for each new timing quirk.

Rob
