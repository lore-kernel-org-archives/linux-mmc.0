Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF262C433B4
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Apr 2021 09:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A230610CA
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Apr 2021 09:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhDAJ6j (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Apr 2021 05:58:39 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:50847 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbhDAJ6i (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Apr 2021 05:58:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617271118; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=tFmstVtXPVYqNFWWbxbVKSBdw6kQ2Lz6kvSeUXzu4cs=;
 b=bDGgoJ5N4yv08sI2G1uTBIR6xa/KTc5INkGQti3Wv0VY25s7GC1v3Wo7NYt739fICarbqQZS
 I4rSCU7RicWjZ+9ewkxanh/XhwUKf+vNb3FaawkmlaieioN+LEIZcc0OaFhFnbpXuYwDFxEv
 ynl9H98yYlffFG6syN+IXohXG/U=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6065994b0a4a07ffdadb379b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 01 Apr 2021 09:58:35
 GMT
Sender: sbhanu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2A048C433C6; Thu,  1 Apr 2021 09:58:35 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sbhanu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6DE13C433CA;
        Thu,  1 Apr 2021 09:58:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 01 Apr 2021 15:28:34 +0530
From:   sbhanu@codeaurora.org
To:     Doug Anderson <dianders@google.com>
Cc:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        sartgarg@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>, cang@codeaurora.org,
        pragalla@codeaurora.org, nitirawa@codeaurora.org,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH V2] arm64: dts: qcom: sc7280: Add nodes for eMMC and SD
 card
In-Reply-To: <CAD=FV=ULXU46C4jbx4nJEOuK4+wZmknoD=mZ_3=c0drfa32N=w@mail.gmail.com>
References: <1616264220-25825-1-git-send-email-sbhanu@codeaurora.org>
 <CAD=FV=WLZCSd6D5VFyD+1KBp5n1qyszER2EVaEMwYjQfPSSDnA@mail.gmail.com>
 <b77f207b-2d90-3c8b-857f-625bd3867ed1@codeaurora.org>
 <CAD=FV=ULXU46C4jbx4nJEOuK4+wZmknoD=mZ_3=c0drfa32N=w@mail.gmail.com>
Message-ID: <f163ff1bcb870630ddcb963aa564a89e@codeaurora.org>
X-Sender: sbhanu@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2021-03-25 21:47, Doug Anderson wrote:
> Hi,
> 
> On Wed, Mar 24, 2021 at 8:59 PM Veerabhadrarao Badiganti
> <vbadigan@codeaurora.org> wrote:
>> 
>> >> +                       clocks = <&gcc GCC_SDCC1_APPS_CLK>,
>> >> +                                       <&gcc GCC_SDCC1_AHB_CLK>,
>> >> +                                       <&rpmhcc RPMH_CXO_CLK>;
>> >> +                       clock-names = "core", "iface", "xo";
>> > I'm curious: why is the "xo" clock needed here but not for sc7180?
>> Actually its needed even for sc7180. We are making use of this clock 
>> in
>> msm_init_cm_dll()
>> The default PoR value is also same as calculated value for
>> HS200/HS400/SDR104 modes.
>> But just not to rely on default register values we need this entry.
> 
> Can you post a patch for sc7180?
sure will post a patch for sc7180.
> 
> 
>> >> +                       bus-width = <4>;
>> >> +
>> >> +                       no-mmc;
>> >> +                       no-sdio;
>> > Similar question to above: why exactly would mmc not work? Are you
>> > saying that if someone hooked this up to a full sized SD card slot and
>> > placed an MMC card into the slot that it wouldn't work? Similar
>> > question about SDIO. If someone placed an external SDIO card into your
>> > slot, would it not work?
>> >
>> As mentioned above, its just to optimize SDcard scan time a little.
> 
> OK. ...but while the eMMC one can make sense since the eMMC is
> soldered down (but in the board dts file, not in the SoC dtsi file) I
> think you should just remove these for SD card because:
> 
> 1. Even if only a uSD slot is exposed it's still _possible_ for
> someone to insert a card that uses MMC or SDIO signaling. If nothing
> else I have a (probably non-compliant) adapter that plugs into a uSD
> slot and provides a full sided SD slot. I could plug an MMC card or
> SDIO card in.
> 
> 2. Presumably the SD card scan time optimization is tiny.
> 
sure will remove these for SD card and will move eMMC flags(no-sd and 
no-sdio) to board dts file.
> 
> -Doug
