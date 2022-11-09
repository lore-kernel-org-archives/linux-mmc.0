Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C35C4332F
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Nov 2022 17:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiKIRRQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Nov 2022 12:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiKIRRO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Nov 2022 12:17:14 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C5D1D678;
        Wed,  9 Nov 2022 09:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=PjHhXUV/PZ9yy09Sz+BF0S4uf1JBmEQL7t9jaV7HgUk=; b=o4qkgU4nwbO4ysJ4AE7k1LCDTc
        hQs1C5o9l5OeCGr3L51AZyNrAOCAmGyO+QXrIQSRo4P9trpzNQb8pPs2J8Bcv147RDZFmHkL5y97E
        zMyTXzlIDIioN/r8hw0zoQfXoUwlWWeTZjOaDAdKiIEcm7RzslsXH+ByUjyCoV/+0ZOA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1osoh4-001vyJ-7e; Wed, 09 Nov 2022 18:16:54 +0100
Date:   Wed, 9 Nov 2022 18:16:54 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
Cc:     ludovic.desroches@microchip.com, ulf.hansson@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        3chas3@gmail.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [PATCH] mmc: atmel-mci: Convert to gpio descriptors
Message-ID: <Y2vghlEEmE+Bdm0v@lunn.ch>
References: <20221109043845.16617-1-balamanikandan.gunasundar@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109043845.16617-1-balamanikandan.gunasundar@microchip.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Nov 09, 2022 at 10:08:45AM +0530, Balamanikandan Gunasundar wrote:
> Replace the legacy GPIO APIs with gpio descriptor consumer interface.

I was wondering why you Cc: netdev and ATM. This clearly has nothing
to do with those lists.

You well foul of

M:	Chas Williams <3chas3@gmail.com>
L:	linux-atm-general@lists.sourceforge.net (moderated for non-subscribers)
L:	netdev@vger.kernel.org
S:	Maintained
W:	http://linux-atm.sourceforge.net
F:	drivers/atm/
F:	include/linux/atm*
F:	include/uapi/linux/atm*

Maybe these atm* should be more specific so they don't match atmel :-)

      Andrew
