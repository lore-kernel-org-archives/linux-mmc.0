Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEADC433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Apr 2022 12:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbiDSMNg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Apr 2022 08:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352489AbiDSMNQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2022 08:13:16 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D96215726;
        Tue, 19 Apr 2022 05:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=29WWmEsiW+qr6W+JbElQ49wIEGnwLLKopx72VfLY35Q=; b=1IPzhB4xfqsyh1vEcbyklEHA7o
        ADZqm6f4RAhHO55cpI7gc2z0zlBqMSntN3pVWQOt1cLhWnOKYEHeZ8WnBpGS99itSM3I+0N7ZN99m
        6oT+E4AUQ0gbZ6+UmT1yyqx255fiYj9hXyUR3hdgvlbDsfefHgJSxqoUmgpUp/+zbqLs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1ngmgU-00GUdt-Ob; Tue, 19 Apr 2022 14:10:18 +0200
Date:   Tue, 19 Apr 2022 14:10:18 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        adrian.hunter@intel.com, nico@fluxnic.net,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/4] dt-bindings: mmc: convert orion-sdio to JSON
 schema
Message-ID: <Yl6mqt8jb2K3GCjz@lunn.ch>
References: <20220419024611.1327525-1-chris.packham@alliedtelesis.co.nz>
 <20220419024611.1327525-4-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419024611.1327525-4-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Apr 19, 2022 at 02:46:10PM +1200, Chris Packham wrote:
> Convert the orion-sdio binding to JSON schema.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
