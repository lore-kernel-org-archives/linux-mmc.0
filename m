Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF498C38145
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Sep 2022 15:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiIGPyb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Sep 2022 11:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiIGPy3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Sep 2022 11:54:29 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E88B2AC0;
        Wed,  7 Sep 2022 08:54:26 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oVxNh-000422-4b; Wed, 07 Sep 2022 17:54:25 +0200
Message-ID: <b395b2aa-3aa8-8f12-8629-23266fa108d3@leemhuis.info>
Date:   Wed, 7 Sep 2022 17:54:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [Regression] Bug 216420 - Unable to handle kernel NULL pointer
 dereference at virtual address 00000008 #forregzbot
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <29a5c3e3-a590-01dd-1a2b-8415cae4a292@leemhuis.info>
In-Reply-To: <29a5c3e3-a590-01dd-1a2b-8415cae4a292@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1662566066;c36705ec;
X-HE-SMSGID: 1oVxNh-000422-4b
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

TWIMC: this mail is primarily send for documentation purposes and for
regzbot, my Linux kernel regression tracking bot. These mails usually
contain '#forregzbot' in the subject, to make them easy to spot and filter.


On 28.08.22 13:44, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker speaking.
> 
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developer don't keep an eye on it, I decided to forward it (I
> hope I picked the right recipients for this mail):
> 
> [...]
> 
> #regzbot introduced: v5.19..v6.0-rc2
> https://bugzilla.kernel.org/show_bug.cgi?id=216420
> #regzbot ignore-activity

#regzbot fixed-by: 25af7406df591

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
