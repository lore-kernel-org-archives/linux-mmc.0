Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619BEC433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Nov 2021 14:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349803AbhKXOVG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Nov 2021 09:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353236AbhKXOSo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Nov 2021 09:18:44 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C25CC098770;
        Wed, 24 Nov 2021 04:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=9+IhnhZkeGeP3d3+paaerLIadQ5w4iduEImB/rgB1WA=; b=3a7MW
        mWmTgpFBgZT86bDzr5fnZd/OMYxslaVS+9JWm3M/wHb3PUyH2IM59c+QY7S5vtgUn5ij1k16gNk19
        vbTNmxU8OeTpbUr2zaKyfoH+LNFs1LJldMLziMejnvGPmiP4zPa3YlxkEZ49W4SNuyjn7Cp7xJ/FU
        pJCFi9umswPkuHxMQHWOYTO8/RznXlzuJST3Y7rCCxJoI77t1foOVL7CqtplAxKZ48wUj1lWMGbwx
        lHYFbM7O7XZKD77NRV/TSODrmOdOz77FZAsQREgQmiWtgoEHpHIzJgeDy3Bs3DcZnguQYWvWocfDr
        gME50F0neKQFoCt+WnjSRb4GUCZQQ==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mprPO-0003p9-3u; Wed, 24 Nov 2021 12:29:54 +0000
Date:   Wed, 24 Nov 2021 12:29:52 +0000
From:   John Keeping <john@metanate.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mmc: dw_mmc: use standard "mmc" alias stem
Message-ID: <YZ4wQOcHEDHdCGlY@donbot>
References: <20211116190244.1417591-1-john@metanate.com>
 <20211116190244.1417591-3-john@metanate.com>
 <CGME20211123193506epcas1p49d0d0a2d66c6e560ee26077da9c0202b@epcas1p4.samsung.com>
 <CAPDyKFp1zMBUfK7LteW0yEfTpqtU+P+EybLsJBFx_r54HwFdMg@mail.gmail.com>
 <315972c2-2253-ad10-b712-2d2c96b3da26@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <315972c2-2253-ad10-b712-2d2c96b3da26@samsung.com>
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Nov 24, 2021 at 06:54:12PM +0900, Jaehoon Chung wrote:
> On 11/24/21 4:34 AM, Ulf Hansson wrote:
> > On Tue, 16 Nov 2021 at 20:02, John Keeping <john@metanate.com> wrote:
> >>
> >> The standard stem for MMC aliases is "mmc" and this is used by the MMC
> >> core to set the slot index.
> > 
> > This isn't the correct description of the mmc aliases. The below text
> > is copied from the DT doc:
> > 
> > "It is possible to assign a fixed index mmcN to an MMC host controller
> > (and the corresponding mmcblkN devices) by defining an alias in the
> > /aliases device tree node."
> > 
> >>
> >> Use this in preference to the non-standard "mshc" stem when setting the
> >> controller ID to avoid needing two aliases for each MMC device in order
> >> to cover both the core and dw_mmc-specific functionality.
> >>
> >> The old "mshc" lookup is kept for backwards compatibility.
> > 
> > The mshc alias is really weird!
> > 
> > It looks like some leftover from when the dw_mmc controller supported
> > multiple slots. This support was dropped a long time ago, simply
> > because it never really worked - and it was not worth trying to. Only
> > one slot per controller is supported.
> 
> As Ulf mentioned, dw_mmc controller can be supported multiple slot.
> But I didn't see its case to use multiple slot. And I had been done to drop a long time ago.
> 
> mshc was used because of Mobile Storage Host Controller.
> 
> > 
> > Rather than re-using the mmc alias in the same weird way as the mshc
> > alias, I suggest we try to remove parsing of the mshc aliases
> > completely. By looking at the corresponding code and in combination
> > with the DTS files, it certainly looks doable to me. Do you want to
> > have a look at it?
> 
> If possible to remove mshc, it's best.
> I will check that removing mshc parsing in dw_mmc.c.

Unfortunately it doesn't look like it's easy to remove as there is some
behaviour depending on this via dw_mci_drv_data::caps, as well as
different timing setup in dw_mmc-k3.c which uses
dw_mci_of_alias_get_id() to identify SD and SDIO hosts.

Looking across the dw_mmc-*.c files that use dw_mci_drv_data::caps to
set capabilities per host controller:

- dw_mmc-exynos.c sets additional capabilities for mshc0, although both
  MMC_CAP_1_8V_DDR and MMC_CAP_8_BIT_DATA should be set via DT (in fact
  in some cases it looks like device trees are setting bus-width = <4>
  so MMC_CAP_8_BIT_DATA seems wrong!); I can't see any device trees
  setting mmc-ddr-1_8v for these devices at the moment though, so
  removing that is a change in behaviour

- dw_mmc-k3.c sets different capabilities for mshc2 and, as mentioned
  above, uses the alias index to select timing parameters and change
  voltage switching behaviour

- dw_mmc-hi3798cv200.c and dw_mmc-rockchip.c set the same caps for all
  slots, so can easily remove the dependency on the alias


I'm mostly interested in Rockchip myself, which is one of the easy ones,
so I'm not that familiar with Exynos or K3 - I'd guess the Exynos
version can remove its dependency on the mshc alias pretty easily, but
the use in dw_mmc-k3.c looks much more difficult given that I can't see
any other way to derive the necessary info from the current device
trees.


Regards,
John
