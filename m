Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41BCC433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jul 2022 11:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239508AbiGTLfw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 Jul 2022 07:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiGTLfu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jul 2022 07:35:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B8426571
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jul 2022 04:35:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EED160A0F
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jul 2022 11:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB607C3411E;
        Wed, 20 Jul 2022 11:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658316948;
        bh=rbsoX2oLrwKyY6TeHqQgN9aks1Y/LJzQ7h3KTL33P/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uOgO/89cg79Str5+73mR+zcCd3W9e5wF7jcRCFYRsQa3Xz2CfBTE+tv/l69FuD4ii
         hyRP6VkZalL6H0bTGFSw/U1dSwGlhfuWIWD0V9peIG6mG3HyTRm2dV604kZe1oPBCG
         yAgzP+wMHpF8aXOMDjvdDLqXJXpER/yH3hZQl9d3do2SXVWgP/bcHvZGsqbD49g0wm
         SUe2oqGanTObtlm4mIUqc+O8rS8Zx/VIKSzwKBNG2/oef7EC4nygwABd5m78O4Bwdt
         iYZcq3tzrHfDZYrCmABjdWL3/fsELqp9eGphXykKN+9R+UsVaJX/HJkWLz9AgbBoTe
         R3xwtiiLqJGoA==
Date:   Wed, 20 Jul 2022 13:35:42 +0200
From:   Robert Richter <rric@kernel.org>
To:     Liang He <windhl@126.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 2/2] mmc: cavium-thunderx: Add of_node_put() when
 breaking out of loop
Message-ID: <YtfojhhMt3dI5s1S@rric.localdomain>
References: <20220719095216.1241601-1-windhl@126.com>
 <20220719095216.1241601-2-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719095216.1241601-2-windhl@126.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 19.07.22 17:52:16, Liang He wrote:
> In thunder_mmc_probe(), we should call of_node_put() when breaking
> out of for_each_child_of_node() which has increased and decreased
> the refcount during each iteration.
> 
> Fixes: 166bac38c3c5 ("mmc: cavium: Add MMC PCI driver for ThunderX SOCs")
> Signed-off-by: Liang He <windhl@126.com>

Acked-by: Robert Richter <rric@kernel.org>

> ---
>  drivers/mmc/host/cavium-thunderx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
