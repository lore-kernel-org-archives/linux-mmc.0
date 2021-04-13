Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDFFC43462
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Apr 2021 10:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8934B613C0
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Apr 2021 10:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344710AbhDMK7o (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Apr 2021 06:59:44 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:54598 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344723AbhDMK7m (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 13 Apr 2021 06:59:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618311561; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=m0BphGKv3ot9eovnDlG46kpvyBSpZUYgaoAjCjQNs8M=;
 b=mQrxWmMxcg0qEjQ4MsSDxRaxrHWpI8F8RtJBnaki/Mbi9IlkfGGu/4Uf6GG873jskcH1Bt41
 U9Te8kSIGpScNI1dfi1RMPnT8UYaaxQh0+EJkTGkMdP32yYI3+gB+QyFkdDP+8JRQJIsIYjp
 EWZuntBGimocM0h6lmRscrqLTqA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6075798574f773a6645a8d76 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 13 Apr 2021 10:59:17
 GMT
Sender: sbhanu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 40986C43462; Tue, 13 Apr 2021 10:59:17 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sbhanu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2D468C433CA;
        Tue, 13 Apr 2021 10:59:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 13 Apr 2021 16:29:16 +0530
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
In-Reply-To: <CAD=FV=Wa4fT5wZgd0==8kLy_tzTLgdZ-HwdfOEAM9pMeMjjFyg@mail.gmail.com>
References: <1616264220-25825-1-git-send-email-sbhanu@codeaurora.org>
 <CAD=FV=WLZCSd6D5VFyD+1KBp5n1qyszER2EVaEMwYjQfPSSDnA@mail.gmail.com>
 <b77f207b-2d90-3c8b-857f-625bd3867ed1@codeaurora.org>
 <6fdf704c4716f5873d413229ca8adc57@codeaurora.org>
 <CAD=FV=Wa4fT5wZgd0==8kLy_tzTLgdZ-HwdfOEAM9pMeMjjFyg@mail.gmail.com>
Message-ID: <8126e130e5c0ea1e7ea867414f0510c0@codeaurora.org>
X-Sender: sbhanu@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2021-03-29 20:26, Doug Anderson wrote:
> Hi,
> 
> On Thu, Mar 25, 2021 at 11:57 PM <sbhanu@codeaurora.org> wrote:
>> 
>> >>> +                       max-frequency = <192000000>;
>> >> Why do you need to specify this?
>> This helps to avoid lower speed modes running in high clock rate,
>> and As Veerabhadrarao Badiganti mentioned
> 
> Just to be clear, both Stephen and I agree that you should remove
> "max-frequency" here (see previous discussion). Bjorn is, of course,
> the file decision maker. However, unless he says "yeah, totally keep
> it in" I'd suggest dropping it from the next version.
> 
sure will drop in next version.
> 
>> >>> +                                       required-opps =
>> >>> <&rpmhpd_opp_low_svs>;
>> >>> +                                       opp-peak-kBps = <1200000
>> >>> 76000>;
>> >>> +                                       opp-avg-kBps = <1200000
>> >>> 50000>;
>> >> Why are the kBps numbers so vastly different than the ones on sc7180
>> >> for the same OPP point. That implies:
>> >>
>> >> a) sc7180 is wrong.
>> >>
>> >> b) This patch is wrong.
>> >>
>> >> c) The numbers are essentially random and don't really matter.
>> >>
>> >> Can you identify which of a), b), or c) is correct, or propose an
>> >> alternate explanation of the difference?
>> >>
>> 
>> We calculated bus votes values for both sc7180 and sc7280 with ICB 
>> tool,
>> above mentioned values we got for sc7280.
> 
> I don't know what an ICB tool is. Please clarify.
> 
> Also: just because a tool spits out numbers that doesn't mean it's
> correct. Presumably the tool could be wrong or incorrectly configured.
> We need to understand why these numbers are different.
> 
we checked with ICB tool team on this they conformed as Rennell & Kodiak 
are different chipsets,
we might see delta in ib/ab values due to delta in scaling factors.

> -Doug
