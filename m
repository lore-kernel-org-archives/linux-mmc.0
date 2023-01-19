Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC37C46467
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Jan 2023 14:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjASOkK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Jan 2023 09:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjASOjm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2023 09:39:42 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AAB22DF7
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jan 2023 06:38:28 -0800 (PST)
Received: from [2a02:8108:963f:de38:4bc7:2566:28bd:b73c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pIW3d-0003a4-OO; Thu, 19 Jan 2023 15:38:25 +0100
Message-ID: <de6f366b-cbfd-528a-5ffa-bf33b7cd0eed@leemhuis.info>
Date:   Thu, 19 Jan 2023 15:38:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Regression 5.14.21 vs 5.15.1: mmc blocked: mmc0: cqhci: timeout
 for tag #
Content-Language: en-US, de-DE
To:     sebastian.kloska@snafu.de, adrian.hunter@intel.com,
        riteshh@codeaurora.org, asutoshd@codeaurora.org
Cc:     linux-mmc@vger.kernel.org
References: <c1214ad81df49a314bd4863751de1a45@snafu.de>
From:   "Linux kernel regression tracking (#adding)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <c1214ad81df49a314bd4863751de1a45@snafu.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1674139108;e2acb206;
X-HE-SMSGID: 1pIW3d-0003a4-OO
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 18.01.23 22:24, sebastian.kloska@snafu.de wrote:
> 
> Hardware: Acer Swift-1 SF114-34-P6U1
> SD Host controller: Intel Corporation Device 4dc4 (rev 01) 8086:4dc4
> eMMC: Kingston A29128
> 
> * A couple of seconds after boot access to the eMMC is completely
>   blocked. Can be triggered by extensive I/O (e.g, with badblocks -w)
> 
> * Tested with stable branch linux-5.14.21 vs. linux-5.15.1
>   Latest highest version including the bug is a fedora 6.1.6
> 
> * Spiked the code with a lot of pr_debug messages. As a side effect the
> driver
>   seems to be much more stable, so to me it appears like a timing issue
> where
>   the driver fails to wait for a specific state change which seems to
> appear
>   less often when  slowed down by logging
> 
> * Would love to have a decent reference documentation to the SD Controller
>   especially a detailed description of the behavior of the register map in
>  mmc/host/cqhci.h All intel documents I could find seem to describe
>  similar but not quite identical register maps
> [...]

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced v5.14..v5.15
#regzbot title mmc: eMMC is completely blocked a few seconds after boot
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
