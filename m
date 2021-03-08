Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB44C433E0
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Mar 2021 23:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A27D86529C
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Mar 2021 23:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhCHXCm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Mar 2021 18:02:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231408AbhCHXCV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 8 Mar 2021 18:02:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CF5E6529E;
        Mon,  8 Mar 2021 23:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615244541;
        bh=baOfkGpu04qh/09ctPJ2h4EovLtbYGc6HVKRrEA1EC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IsjfBJEeCqmzkLIIjbMDZ6tar87u3mo3hAujfL4D6TBwUl4LpoMf+eKOdTqk8yVP5
         h1dlnSx4opy/Bt5ebV5y14X2gG9nGZ5dbGA6Ceyc6od5tACUzvYmz8iKMVWEu5CpWr
         mUeoaJRki8SKo7Rp14vp+9vhTS7GJJmZdQ5bds7sfZaVgquv3/qvaj+JUFJmo/Rvk6
         rmYEIKs5xflov9S7o05TA5mJtZJbCyEuE8dtd95O9boclphVtjMdXBJLOkk3qJ96dU
         rumSibJ+l6kxlQ6aELYmkvUfgGqjEp6/tJWJyQdXTpR7rsPz/ZdOXwIbKPno5+yLjX
         o8NyOLq4D6W5A==
Date:   Mon, 8 Mar 2021 15:02:19 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Peng Zhou <peng.zhou@mediatek.com>
Cc:     linux-mmc@vger.kernel.org,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Satya Tangirala <satyat@google.com>,
        devicetree@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wulin Li <wulin.li@mediatek.com>,
        Mason Zhang <mason.zhang@mediatek.com>
Subject: Re: [PATCH v2 0/4] MediaTek eMMC inline encryption support
Message-ID: <YEas+9mY5zdJh6mX@gmail.com>
References: <20210308080855.30459-1-peng.zhou@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308080855.30459-1-peng.zhou@mediatek.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Mar 08, 2021 at 04:08:56PM +0800, Peng Zhou wrote:
> Hello,
> 
> Mediatek eMMC hardware IP has Inline Crypto Engine (ICE),
> we support inline encryption now.
> 
> For Inline Crypto Engine (ICE), see:
> - https://lore.kernel.org/linux-arm-msm/20210126001456.382989-2-ebiggers@kernel.org/T/
> 
> Changed in v2:
> - fix email format
> - change some description
> 
> Peng Zhou (4):
>   mmc: Mediatek: add Inline Crypto Engine support
>   mmc: Mediatek: enable crypto hardware engine
>   arm64: dts: Mediatek: MT6779: add mmc node with ICE setting
>   dt-bingdings: mmc: Mediatek: add ICE clock
> 
>  .../devicetree/bindings/mmc/mtk-sd.yaml       |  6 ++-
>  arch/arm64/boot/dts/mediatek/mt6779.dtsi      | 14 +++++++
>  drivers/mmc/host/mtk-sd.c                     | 42 ++++++++++++++++++-
>  3 files changed, 59 insertions(+), 3 deletions(-)

Now I received this cover letter 5 more times, but none of the other patches.
How are you sending this out?

- Eric
