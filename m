Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C096C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jul 2022 11:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237105AbiGTLfc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 Jul 2022 07:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiGTLf3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jul 2022 07:35:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7B92611F
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jul 2022 04:35:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB2C9B81F28
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jul 2022 11:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACD8C3411E;
        Wed, 20 Jul 2022 11:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658316926;
        bh=AojY8bGPxcZikWt9UfLTgNnQQNtjDo630phmGAfPCVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A+va5Hiep7evw3NRGFGZqlXwhcSGTlgYPfBAAFVAsCbYLZezerfxkOrp8Ma8pU6af
         Xtb0OfpyEaVjakw8PbgDZuORPR17nPqKngbs4EnOqbXASFOdf19KzCmsFUqKQ0fQ8/
         47jHPwGEJfyKP91KKqEPy/QtCcio/5U2Zycbg74ByT9oeJupcrfTb56p2aOZ+FYs6m
         H6jkAYFgeVI2xga2SWIaZ2ucwYrCOu97FJl+LWHKQLGN/5bHQGn1QMkajAXILf+gY/
         TH9x5I2Wp8Alw+EftpSfg9VUQ/vqN9k29qFxPaBUmU3ffEkWeV36GUv0iLEAxOUsQP
         0qXub8Bit2Pyw==
Date:   Wed, 20 Jul 2022 13:35:20 +0200
From:   Robert Richter <rric@kernel.org>
To:     Liang He <windhl@126.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 1/2] mmc: cavium-octeon: Add of_node_put() when breaking
 out of loop
Message-ID: <YtfoePMI7EEVd31S@rric.localdomain>
References: <20220719095216.1241601-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719095216.1241601-1-windhl@126.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 19.07.22 17:52:15, Liang He wrote:
> In octeon_mmc_probe(), we should call of_node_put() when breaking
> out of for_each_child_of_node() which has increased and decreased
> the refcount during each iteration.
> 
> Fixes: 01d95843335c ("mmc: cavium: Add MMC support for Octeon SOCs.")
> Signed-off-by: Liang He <windhl@126.com>

Acked-by: Robert Richter <rric@kernel.org>

> ---
>  drivers/mmc/host/cavium-octeon.c | 1 +
>  1 file changed, 1 insertion(+)
