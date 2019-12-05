Return-Path: <SRS0=6ao/=Z3=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF32C2D0BF
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Dec 2019 17:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1748C24654
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Dec 2019 17:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="x7B43v54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbfLERyG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Dec 2019 12:54:06 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42491 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729711AbfLERyG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Dec 2019 12:54:06 -0500
Received: by mail-lf1-f68.google.com with SMTP id y19so3144046lfl.9
        for <linux-mmc@vger.kernel.org>; Thu, 05 Dec 2019 09:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GnbFNkIxR70lINeEkzf0C3CsMt6KmAk3DjiL3dWVia0=;
        b=x7B43v547TpkGTqUj3h8zeo/B9Bjnb+92D+QLeC+pC6P4dk4g8ebQhtLZ01CcxeBgj
         CUlGwXhLCWx67s6JL4JdBYqG7SWs5LBLlr/XRfxPaIwEu00aFLJ8MX9ZlOfZRgbI5bLi
         LnhQcVheY3UM4QE9d9tzRnMPP92gLFvvglCFQQjvTpji4e2HcE1qPICM8AIFKmfJ4lRM
         OYleq3CZPjm4s9hZNc4GiffE89hAdBqbnDi0437X4Pcx9Wk0tO00c1OA5/R4m1l9xhxx
         ULJss/MOv9k6m945eL6103HVRD3ivr8NoL9+E6HHmlP4ingNq4j7Zi6sFIcR93cBqoVa
         EnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GnbFNkIxR70lINeEkzf0C3CsMt6KmAk3DjiL3dWVia0=;
        b=i4vt4ptUMZ+EoVM1yeZgxkSIxUy9e0UFRvacEdeMCAELqktBYfFh63sukKXZdSYYUE
         4/doOvkUAm0iOiq9kSqtAuz9z0LGjxoz698BL83kObUUrQGzPpBB3xEg43aGbyZskUm3
         Rx9nCfBFOiPjNJwmxqyav37XnIzWzhUlh/O5YEqAvFF9lo/WNeM+NhehIExJUyL+Ep02
         KWq+pWwRB/ua3ZukNf2BxEwG1wy9cVCrZsIxEXtFlFl51aPlH6FgQSWUxTWWcSlEcEPg
         TJemoyPMPK8Tprk6Db7JePU0OSvbB4R65VBUHOZN/rz1j1s9kodZJKn7Hi8hLTkTGS7/
         AuYA==
X-Gm-Message-State: APjAAAVjPnwp6s5+gPdoH2aSPO4HM8JodywGdszRa7hRF2ujruXZ00cP
        2JflPPPMK5yPBi7ctlY0NrlU1Q==
X-Google-Smtp-Source: APXvYqyTE1dL3L8Ty1iYjitUq6l5M5ez66of3MWw+FEAf4W+55UiFfu7DXDVJtdeyEM8EMSiAs+ZqA==
X-Received: by 2002:ac2:43af:: with SMTP id t15mr6008348lfl.154.1575568443854;
        Thu, 05 Dec 2019 09:54:03 -0800 (PST)
Received: from localhost (h-93-159.A463.priv.bahnhof.se. [46.59.93.159])
        by smtp.gmail.com with ESMTPSA id y14sm5395473ljk.46.2019.12.05.09.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 09:54:03 -0800 (PST)
Date:   Thu, 5 Dec 2019 18:54:02 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 0/2] mmc: renesas_sdhi: Add r8a77961 support
Message-ID: <20191205175402.GF28879@bigcity.dyn.berto.se>
References: <20191205134349.6410-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191205134349.6410-1-geert+renesas@glider.be>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Geert,

Thanks for your series.

On 2019-12-05 14:43:47 +0100, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series documents DT bindings for the SDHI controller in the
> Renesas R-Car M3-W+ (R8A77961) SoC, and adds support for it to the
> driver.
> 
> The second patch may be dropped, once "[PATCH] mmc: renesas_sdhi: remove
> whitelist for internal DMAC"[1] has been accepted.
> 
> Thanks!
> 
> [1] https://lore.kernel.org/linux-mmc/20191203194859.917-1-wsa@the-dreams.de/

For the whole series,

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
 
> Geert Uytterhoeven (2):
>   dt-bindings: mmc: renesas_sdhi: Document r8a77961 support
>   mmc: renesas_sdhi_internal_dmac: Add r8a77961 support
> 
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.txt | 3 ++-
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c          | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> -- 
> 2.17.1
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds

-- 
Regards,
Niklas Söderlund
