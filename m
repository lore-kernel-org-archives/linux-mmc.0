Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66629C43217
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Nov 2022 15:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiKAPeY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Nov 2022 11:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiKAPeX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Nov 2022 11:34:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA62DDEE4;
        Tue,  1 Nov 2022 08:34:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80F8461637;
        Tue,  1 Nov 2022 15:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB08AC433D6;
        Tue,  1 Nov 2022 15:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667316861;
        bh=qMkIVqVEWFZuwE65ZHG+MFl13mOX2Gs29/6OxtDWz3Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Eo2HJy/JTbLE5XD1A3dfBYlXniEQRt5waC7T/yvL9NBisyJE5yzaC7fPLncTz43X1
         xRuQyGmlmO3++24VXm0Ia+4MWMvQElWMcvLijmh3uFQw8fq7dVZk/NPe9Jl2jspeoY
         k6vqDNPkBUQfjjnS/dgafA4QqsfgDxwVUvgzVpPyXDv7lbJrdYb19kAUgCwpchZaGC
         nozTuUHA6vLbAkg1V6YLZGpIMPPUN1rnowZnH4fRPGGYNn4ZJVMwzSpJl77Qfll0RS
         5RRzYWYKS/7Y8303wFm8rawdMcsf/uhWxwX/ixXkiR5VbMMd0qcMrk640XOnkzj/P9
         rtprl7kMkragA==
Message-ID: <9d13da28-e7d5-f8d4-0e99-c89560d37833@kernel.org>
Date:   Tue, 1 Nov 2022 10:34:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCHv6 5/6] clk: socfpga: remove the setting of clk-phase for
 sdmmc_clk
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, jh80.chung@samsung.com
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20221026141631.696863-1-dinguyen@kernel.org>
 <20221026141631.696863-5-dinguyen@kernel.org>
 <20221027213934.E9219C433C1@smtp.kernel.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20221027213934.E9219C433C1@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 10/27/22 16:39, Stephen Boyd wrote:
> Quoting Dinh Nguyen (2022-10-26 07:16:30)
>> Now that the SDMMC driver supports setting the clk-phase, we can remove
>> the need to do it in the clock driver.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>> ---
> 
> Do you want to take this through mmc tree?

Yes, I'll do that.

> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>

Thanks!

Dinh
