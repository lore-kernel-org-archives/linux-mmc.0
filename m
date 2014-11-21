From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [PATCH 4/4] mmc: core: hold SD Clock before CMD11 during Signal
Date: Fri, 21 Nov 2014 08:23:09 +0100
Message-ID: <CA+20K0ArDkdVypRGNeMce8rCOUwGP9x_bOrpSkL8Jh7WV=t4mQ@mail.gmail.com>
References: <1416531100-26707-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
	<1416531100-26707-5-git-send-email-Vincent.Yang@tw.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:64595 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbaKUHXJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Nov 2014 02:23:09 -0500
Received: by mail-qg0-f50.google.com with SMTP id i50so110291qgf.23
        for <linux-mmc@vger.kernel.org>; Thu, 20 Nov 2014 23:23:09 -0800 (PST)
In-Reply-To: <1416531100-26707-5-git-send-email-Vincent.Yang@tw.fujitsu.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, andy.green@linaro.org, patches@linaro.org, jaswinder.singh@linaro.org, Vincent Yang <Vincent.Yang@tw.fujitsu.com>

Hi,

2014-11-21 1:51 GMT+01:00 Vincent Yang <vincent.yang.fujitsu@gmail.com>:
> Voltage Switch Procedure
>
> This patch is to fix an issue found on mb86s7x platforms.
>
> [symptom]
> There are some UHS-1 SD memory cards sometimes cannot be detected correctly,
> e.g., Transcend 600x SDXC 64GB UHS-1 memory card.
> During Signal Voltage Switch Procedure, failure to switch is indicated
> by the card holding DAT[3:0] low.
>
> [analysis]
> According to SD Host Controller Simplified Specification Version 3.00
> chapter 3.6.1, the Signal Voltage Switch Procedure should be:
> (1) Check S18A; (2) Issue CMD11; (3) Check CMD 11 response;
> (4) Stop providing SD clock; (5) Check DAT[3:0] should be 0000b;
> (6) Set 1.8V Signal Enable; (7) Wait 5ms; (8) Check 1.8V Signal Enable;
> (9) Provide SD Clock; (10) Wait 1ms; (11) Check DAT[3:0] should be 1111b;
> (12) error handling
>
> With CONFIG_MMC_CLKGATE=y, sometimes there is one more gating/un-gating
> SD clock between (2) and (3). In this case, some UHS-1 SD cards will hold
> DAT[3:0] 0000b at (11) and thus fails Signal Voltage Switch Procedure.
>
> [solution]
> By mmc_host_clk_hold() before CMD11, the additional gating/un-gating
> SD clock between (2) and (3) can be prevented and thus no failure at (11).
> It has been verified with many UHS-1 SD cards on mb86s7x platforms and
> works correctly.
>
> Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>

Reviewed-by: Johan Rudholm <jrudholm@gmail.com>

BR, Johan
