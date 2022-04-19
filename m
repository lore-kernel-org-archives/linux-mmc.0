Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0BDC43217
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Apr 2022 12:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352034AbiDSMO2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Apr 2022 08:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352435AbiDSMNL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2022 08:13:11 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050401025;
        Tue, 19 Apr 2022 05:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=p1qe2cc9fGQ4Cq/TIt8sYh6UO6XH4bt91ZJ+fYPid2I=; b=xTFxj9ItrBXoR9UauJlfU24V50
        sC/t7rVLFKj05mTK2Pz+TlpuOMffirrHAnl2wWTtGcg6mOd11bt+33zEmM7xdJHA2AQbTl0he3CJx
        dz6H3kZYOzYhBNykq4jwoUn5v6K6fc0bVYiVYLEURCZcBc5ZklD1CZPlMW1fSVrNsaB0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1ngmfC-00GUbO-54; Tue, 19 Apr 2022 14:08:58 +0200
Date:   Tue, 19 Apr 2022 14:08:58 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        adrian.hunter@intel.com, nico@fluxnic.net,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] ARM: dts: mvebu: Update mvsdio node names to
 match schema
Message-ID: <Yl6mWsiGJVYh6m4l@lunn.ch>
References: <20220419024611.1327525-1-chris.packham@alliedtelesis.co.nz>
 <20220419024611.1327525-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419024611.1327525-2-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Apr 19, 2022 at 02:46:08PM +1200, Chris Packham wrote:
> Update the node names of the mvsdio@ interfaces to be mmc@ to match the
> node name enforced by the mmc-controller.yaml schema.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
