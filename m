Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336EBC433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Nov 2022 16:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237943AbiKWQX1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Nov 2022 11:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbiKWQX0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Nov 2022 11:23:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B8C88F83;
        Wed, 23 Nov 2022 08:23:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09E0861DC9;
        Wed, 23 Nov 2022 16:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37FCC433D6;
        Wed, 23 Nov 2022 16:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669220604;
        bh=RhLtqnmMaCbDvylZulq2NNvZV6guUhXmHED0yPmvTDc=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=CDkx4u4ciq3BJQ+mm7Hg+RJrOfVOZ8mLnMe5UDgBT5umauYr4s1ocwrbskk3oLPT1
         CI8ApNBAJxPXL//r+MD6Y/MLDgNTMu36IYbsGYHWOAqsTdguLYCaRANygKr3Lf7v52
         J/N4oD2PcxgzOOG62Z6W3avfWHf0frB7YHrdqOuj3jFxbBC0B6ur3HUWFPh/TVEv0G
         x7yNLKcmMlwyhoGsW/307+ZzYMvB9yhJMBXpXE1v9zD3pSyVTfasndAiJ2UpwsLHaI
         ZSfggbRftdwoflaotCdXjmOcXdeT4oW1cLAHxRm8GvNwp+r/nGxqMHMfDBEkYzqr73
         aegCrILbzu1Bg==
Message-ID: <a7ee14ae-3bbb-bc8a-a118-9721336d72ff@kernel.org>
Date:   Wed, 23 Nov 2022 17:23:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 4/4] arm64: dts: docs: Update mmc meson-gx documentation
 for new config option amlogic,mmc-phase
Content-Language: en-US
To:     Vyacheslav Bocharov <adeep@lexina.in>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221110150035.2824580-1-adeep@lexina.in>
 <20221110150035.2824580-5-adeep@lexina.in>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20221110150035.2824580-5-adeep@lexina.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/11/2022 16:00, Vyacheslav Bocharov wrote:
> - amlogic,mmc-phases: 3-element array of clock phases for core, tx, rx

Use subject prefixes matching the subsystem (git log --oneline -- ...).

> clock with values:
> 	0: CLK_PHASE_0 - 0 phase
> 	1: CLK_PHASE_90 - 90 phase
> 	2: CLK_PHASE_180 - 180 phase
> 	3: CLK_PHASE_270 - 270 phase
> By default driver use <CLK_PHASE_180 CLK_PHASE_0 CLK_PHASE_0> value.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You missed several people.

> 
> Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
> 
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> index ccc5358db131..98c89c5b3455 100644
> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> @@ -25,6 +25,12 @@ Required properties:
>  Optional properties:
>  - amlogic,dram-access-quirk: set when controller's internal DMA engine cannot access the
>    DRAM memory, like on the G12A dedicated SDIO controller.
> +- amlogic,mmc-phases: 3-element array of clock phases for core, tx, rx clock with values:
> +	0: CLK_PHASE_0 - 0 phase
> +	1: CLK_PHASE_90 - 90 phase
> +	2: CLK_PHASE_180 - 180 phase
> +	3: CLK_PHASE_270 - 270 phase
> +  By default driver use <CLK_PHASE_180 CLK_PHASE_0 CLK_PHASE_0> value.

No, this has to be converted to DT schema first.

Best regards,
Krzysztof

