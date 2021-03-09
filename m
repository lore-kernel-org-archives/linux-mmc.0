Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039A4C433DB
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 07:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C9565295
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 07:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhCIHfb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Mar 2021 02:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhCIHfQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Mar 2021 02:35:16 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7416CC06174A
        for <linux-mmc@vger.kernel.org>; Mon,  8 Mar 2021 23:35:16 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso5276595wma.4
        for <linux-mmc@vger.kernel.org>; Mon, 08 Mar 2021 23:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U5dowiwok/5Kv0iszCk9Q8m3rsHy7K8vI/jZ90onFFc=;
        b=FZOKYkBDcM4UCta1ULa65m2yWcJMH4zmgeab3S8VpJvwddX2qk4FXTTsUs+uudiHWY
         X0zwAkc0tKC4LRZC28tD3QOIZwR2zdR8vb+3TyJCu96S57Dto9Gyt7zPKRH0VbtVe5dN
         5h57U+wXrlGs4GAeY1sAz/lrK+YDB1tGCaJwNdqOmM6P4UAOzveY/+5sU0gv5d544V0O
         XlZZE5PVNwqrm/5EWC7NhTJ6DB3GhmQJ1Qk+6UhuN9vFUBOnW7glHUPMfvnRRJxJwK/e
         ZIOExg2BfGxUk+cMOJfGoeHu1N1yR8zXA6iwweed5oOCXQEmzh2Unf0A/2hXNu+ZQrsJ
         1ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U5dowiwok/5Kv0iszCk9Q8m3rsHy7K8vI/jZ90onFFc=;
        b=mU6t2dASEQp1ovqMhVsx8Q6mUELgyUNlIKt/JhUfblm2yYEhq2rNjStrnyhFynVy+J
         pvSlRSu1CiuaAzBF/6jQ1FkHRPZFEPWi28aHku7hQviUvsXVhVIlW/T80g0b9sHaRUW2
         ksZkShgjdHBceLdrXWJ3eSGfz/jCJQmsqd12g9yep+oTeSH4Lj4AIX0siJ7lsqIqWie1
         k8R7N7iksMN7b/rTEfcNqk/8nxMrn2UVJNlwYVnh1Es+C/hPkvP/kG3EPd9hMb2FbORf
         WyKLTKywwQ+Sh9D61+ugmeQ/O0l2E4x+x4OMJZzG1S4WhsbmN7lrzBOcbeZPziL+1Ggl
         cONw==
X-Gm-Message-State: AOAM533AYWoRAcCLUe1vU/DgPfxDZOC/Q6+vKcEmw66oT3laRHBoApYK
        nlD1oHwOCVsXGo0FU0xzmNE=
X-Google-Smtp-Source: ABdhPJw2jjcvbBLcAaxpzi37Bh323s/cIrlttvDTJl4HWHfKea+pXWQZbQItj0/7FJE8tK6A6z5d9g==
X-Received: by 2002:a05:600c:2106:: with SMTP id u6mr2524123wml.55.1615275315059;
        Mon, 08 Mar 2021 23:35:15 -0800 (PST)
Received: from hthiery.fritz.box (ip1f1322f8.dynamic.kabel-deutschland.de. [31.19.34.248])
        by smtp.gmail.com with ESMTPSA id i8sm24772968wry.90.2021.03.08.23.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 23:35:14 -0800 (PST)
From:   Heiko Thiery <heiko.thiery@gmail.com>
To:     l.stach@pengutronix.de
Cc:     abel.vesa@nxp.com, adrian.hunter@intel.com, agx@sigxcpu.org,
        angus@akkea.ca, festevam@gmail.com, haibo.chen@nxp.com,
        kernel@pengutronix.de, leonard.crestez@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, mturquette@baylibre.com,
        peng.fan@nxp.com, ping.bai@nxp.com, sboyd@kernel.org,
        ulf.hansson@linaro.org
Subject: Re: sdhci timeout on imx8mq
Date:   Tue,  9 Mar 2021 08:35:12 +0100
Message-Id: <20210309073512.8247-1-heiko.thiery@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <f7e3cdd37d425d2df96112258dcaf0bc6565f3cf.camel@pengutronix.de>
References: <f7e3cdd37d425d2df96112258dcaf0bc6565f3cf.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi all,

> Hi Jacky,
> 
> Am Donnerstag, dem 07.01.2021 um 01:30 +0000 schrieb Jacky Bai:
> > > -----Original Message-----
> > > From: Fabio Estevam [mailto:festevam@gmail.com]
> > > Sent: Thursday, January 7, 2021 2:57 AM
> > > To: Lucas Stach <l.stach@pengutronix.de>
> > > Cc: Bough Chen <haibo.chen@nxp.com>; Angus Ainslie
> > > <angus@akkea.ca>;
> > > Leonard Crestez <leonard.crestez@nxp.com>; Peng Fan
> > > <peng.fan@nxp.com>; Abel Vesa <abel.vesa@nxp.com>; Stephen Boyd
> > > <sboyd@kernel.org>; Michael Turquette <mturquette@baylibre.com>;
> > > Ulf
> > > Hansson <ulf.hansson@linaro.org>; Guido Günther <agx@sigxcpu.org>;
> > > linux-mmc <linux-mmc@vger.kernel.org>; Adrian Hunter
> > > <adrian.hunter@intel.com>; dl-linux-imx <linux-imx@nxp.com>; Sascha
> > > Hauer <kernel@pengutronix.de>; moderated list:ARM/FREESCALE IMX /
> > > MXC
> > > ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>
> > > Subject: Re: sdhci timeout on imx8mq
> > > 
> > > Hi Lucas,
> > > 
> > > On Tue, Jan 5, 2021 at 12:06 PM Lucas Stach
> > > <l.stach@pengutronix.de>
> > > wrote:
> > > 
> > > > The reference manual states about this situation: "For any clock,
> > > > its
> > > > source must be left on when it is kept on. Behavior is undefined
> > > > if
> > > > this rule is violated."
> > > > And it seems this is exactly what's happening here: some kind of
> > > > glitch is introduced in the nand_usdhc_bus clock, which prevents
> > > > the
> > > > SDHCI controller from working, even though the clock branch is
> > > > properly enabled later on. On my system the SDHCI timeout and
> > > > following runtime suspend/resume cycle on the nand_usdhc_bus
> > > > clock
> > > > seem to get it back into a working state.
> > > 
> > > I think your analysis is correct and I recall helping a customer
> > > with a similar
> > > issue:
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fcomm
> > > unity.nxp.com%2Ft5%2Fi-MX-Processors%2FExternal-clock-that-provide-
> > > root
> > > -clock-for-SAI3-and-SPDIF%2Fm-p%2F1019834&amp;data=04%7C01%7Cping
> > > .bai%40nxp.com%7C8d250a158cce469c378308d8b274d6d1%7C686ea1d3bc
> > > 2b4c6fa92cd99c5c301635%7C0%7C0%7C637455562183497049%7CUnknow
> > > n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> > > WwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=VkxuhmhDifzOxxfIgFz9PR5gKC1
> > > SyQhGeSHYysX1Co4%3D&amp;reserved=0
> > > 
> > 
> > For the customer case, it seem not the same issue. the customer issue
> > is caused by clock source change while parent has no clock output.
> > This is inherit limitation for the CCM clock slice when using the
> > smart interface to change the clock parent.
> > 
> > For current mmc timeout issue, I think we can have a try with
> > nand_usdhc_bus clock gated at the beginning of kernel boot, directly
> > modify the nand_usdhc_bus
> > Clock's HW register gate bit in clock-imx8mq.c.
> 
> While this might be an option to fix this specific issue, I would hope
> we can come up with something more generic, as the current clock
> framework behavior allows to violate the system specification
> constraint that parent clocks must not be disabled when any of the
> children are active. This seems like a fundamental issue and might hurt
> us also with other clocks than this specific nand_usdhc_bus clock.

I am not sure if an error in the fec driver has the same or similar cause as this. But I noticed that the SOC hangs when accessing the timecounter register while the FEC is down. The CCGR10 seems to gate the ENET_REF_CLK_ROOT and the ENET_TIMER_CLK_ROOT. The clocks are disabled as soon as the interface is down.

[1] https://lore.kernel.org/lkml/20210220065654.25598-1-heiko.thiery@gmail.com/

> 
> Can you tell us if there were other issues found with the PLL1/2 gating
> patch? The fact that, according to Bough, it's reverted in your tree
> seems to suggest this.
> 
> Regards,
> Lucas

Thank you

-- 
Heiko
