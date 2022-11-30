Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84162C4321E
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Nov 2022 19:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiK3T4m (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Nov 2022 14:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiK3T4g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2022 14:56:36 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589D156D57
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 11:56:35 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id c15so8516147pfb.13
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 11:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UUm+vtm8VZOTqCG6CNVeGJkk9QAGWw9R/Ze0U55RKww=;
        b=fzDXQ2xltGlp9Vja3M3c3mySQLwGZJydOUU/BRxYhznp9O+5W8wDWBKCsry4llARp/
         ipWStB+7jp0hbMfy0DbVBNcFAuNITWUWd08Ts0in8Igy6wae0cswlMNMACr/3v1mXyUy
         L+WxQzKYPArtoEes6dfWIk0zLkvmuZae8NY2akJnXGPHntbU6l3vWyHr2totaPACVVN7
         4avWfqQB6R2G9wxYlEjJ9U16OkhH6rVkdmGbFjj1lVxQl5WrIPcSOtbCAtM1ZuDOIhYJ
         GRbUCcdoOrby8p+3AGbLFwEClqxpWFqZi1yA/6n2cEOATbVazi/jIjjOipUHkqJcb67J
         7txQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UUm+vtm8VZOTqCG6CNVeGJkk9QAGWw9R/Ze0U55RKww=;
        b=MkjVISAg/s3aEYLJwOObHN+5NJMEFXG2ipfpZ9I5cXk/5+VE5XIciKg3/sFw81XMyw
         f0nehrEyz36KB1+4koVlBcKkPsFkEo6CW9ff0aQgz9Lq4RqeI8o3+TjHRA22WQjpqrcS
         EMBOp11LaOla5xxSivkGS7SNaif3NIGiUppwLqbVmypyfY2w7k8r4TowNBNFrdk80cv4
         4pGAohj1xkAfzmMeBanQS5JGegnhiA9Doj0THfhNJiSxBi5ZhiJURcemezccRJukiU8K
         2RBLhwI91FLZVcuV0LM9dCfK7V99nNV1Z3OTvJ8LAkU44wVqnxMU0Ki9Aj2MuWLiKkt4
         nwBA==
X-Gm-Message-State: ANoB5pktXSj0ez44Cicvdm9hj3ijUPHyK9V7PNq9tiJ+dSk7bHFYVJUy
        ybSfjQzy7me9WQWsukL4w5ic8Mjv27YwM7KukPo=
X-Google-Smtp-Source: AA0mqf64Hu8RkgWojLVaXDu/JARF2Z3roxBg1HafPneAIs017mdO4kxJ6cyqH5EWvrlu1aNTwYMdyH7rkxfzPtZ7LUg=
X-Received: by 2002:a62:5fc1:0:b0:575:fddc:891e with SMTP id
 t184-20020a625fc1000000b00575fddc891emr2278868pfb.40.1669838194849; Wed, 30
 Nov 2022 11:56:34 -0800 (PST)
MIME-Version: 1.0
References: <20221128133259.38305-1-adrian.hunter@intel.com>
 <20221128133259.38305-3-adrian.hunter@intel.com> <b040b2b2-10c2-5414-1c8f-fd02fc3b300e@gmail.com>
 <1acb9b87-088c-06f8-a2de-63b3054c55bc@intel.com> <CAOX2RU54TPBowXdbJMc-x+eO8XhKjREn9R0zwv9thya3kyCP-g@mail.gmail.com>
 <26ad873f-b673-3ea0-3039-f61d69939c6f@intel.com> <CAOX2RU4UQ_xOor3sPBP+fg48EGsCmbw03Dcc0oU5VDDV=7+yzg@mail.gmail.com>
 <962458b5-c891-e552-5469-1dbb650a0f3c@gmail.com>
In-Reply-To: <962458b5-c891-e552-5469-1dbb650a0f3c@gmail.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Wed, 30 Nov 2022 20:56:23 +0100
Message-ID: <CAOX2RU5OBJyWb_K=b7OO9WKVog8e2kMT50F9PndWcQ+gd=OfPQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] mmc: sdhci: Avoid unnecessary re-configuration
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sarthak Garg <quic_sartgarg@quicinc.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Prabu Thangamuthu <prabu.t@synopsys.com>,
        Manjunath M B <manjumb@synopsys.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Brian Norris <briannorris@chromium.org>,
        Wenchao Chen <wenchao.chen@unisoc.com>,
        Chevron Li <chevron.li@bayhubtech.com>,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 30 Nov 2022 at 19:39, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 11/30/22 09:24, Robert Marko wrote:
> > On Wed, 30 Nov 2022 at 15:16, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 30/11/22 15:00, Robert Marko wrote:
> >>> On Wed, 30 Nov 2022 at 13:46, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>>
> >>>> On 30/11/22 13:54, Robert Marko wrote:
> >>>>>
> >>>>> On 28. 11. 2022. 14:32, Adrian Hunter wrote:
> >>>>>> Avoid re-configuring UHS and preset settings when the settings have not
> >>>>>> changed, irrespective of whether the clock is turning on.
> >>>>>>
> >>>>>> Tested-by: Haibo Chen <haibo.chen@nxp.com>
> >>>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >>>>>
> >>>>> Hi, this is breaking sdhci-msm on IPQ8074 in next-20221130 for me
> >>>>> and reverting it makes the eMMC work again.
> >>>>>
> >>>>> I get a lot of:
> >>>>>
> >>>>> [    2.727287] mmc0: tuning execution failed: -5
> >>>>> [    2.727323] mmc0: error -5 whilst initialising MMC card
> >>>>> [    3.846540] mmc0: tuning execution failed: -5
> >>>>> [    3.846564] mmc0: error -5 whilst initialising MMC card
> >>>>> [    4.966517] mmc0: tuning execution failed: -5
> >>>>> [    4.966539] mmc0: error -5 whilst initialising MMC card
> >>>>> [    6.096486] mmc0: tuning execution failed: -5
> >>>>> [    6.096508] mmc0: error -5 whilst initialising MMC card
> >>>>> [    7.206431] mmc0: tuning execution failed: -5
> >>>>> [    7.206454] mmc0: error -5 whilst initialising MMC card
> >>>>
> >>>> Thanks for the report!  Are you able to debug this any more?
> >>>> What transfer mode is it? e.g. HS400?  Can you enable debug
> >>>> messages and get more information?
> >>>
> >>> With some guidance yes, it's in HS200 as there is an issue with HS400
> >>> to HS200 switch on this SoC so I have HS400 disabled.
> >>>
> >>> With CONFIG_MMC_DEBUG and loglevel=8 I dont have any new
> >>> messages.
> >>
> >> You should get a lot more with:
> >>
> >> CONFIG_DYNAMIC_DEBUG=y
> >>
> >> and kernel commandline option:
> >>
> >> dyndbg="file drivers/mmc/core/* +p;file drivers/mmc/host/* +p"
> >
> > Unfortunatelly not:
>
> Are you sure you have debug messages enabled with your current console
> loglevel? Might want to add "debug" at the end of your kernel command
> line and try again.

Ok, so indeed debug was required, here is the huge bootlog now:
https://gist.github.com/robimarko/e370bce66d0d2e7e54a2f5daf9784ee4

Regards,
Robert
> --
> Florian
>
