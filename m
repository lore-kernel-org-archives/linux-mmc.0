Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F14EC433F5
	for <linux-mmc@archiver.kernel.org>; Sat,  4 Sep 2021 14:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5097360EB7
	for <linux-mmc@archiver.kernel.org>; Sat,  4 Sep 2021 14:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbhIDOxX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 4 Sep 2021 10:53:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230039AbhIDOxW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 4 Sep 2021 10:53:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F609600D0;
        Sat,  4 Sep 2021 14:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630767140;
        bh=gNVXwjBcbMPIJqanRhaHWrpGftDA5eeYCHnA7J6Q4fY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cOtPk3Z/Zae1f4V5qBCd4R/J7LbYnWNU87WuI60/0tz0DHiN8yH9Szwew77Oz+rDm
         B+teqKkXvEkVTJj8Pib+IPSvTlt5VoAjToRa1/0sLWTjKLZwAd893qPfpHeH5EX+5G
         bTGQHCxL9MRvw6zOUe0X3017Z/Uii7SIsbubCzgvyexBYem03Rq6he4ceJo3Kfhh+o
         jpQ4oW0AxFhbb9YTM2HvkeGGkmzdGw5qP87pjNKzhLAQ0ffj//A2cxv84zoh1JJcjT
         KwVoDX0CgS0eABawteoc6YTEPiHoGvQwS20vJmM5qocRgacNS6Y3PQaMB2hhhMZofn
         3CLIEYdwJGZ0Q==
Message-ID: <ff89b24994cc5ba40c80e04a9090f467d487f51f.camel@kernel.org>
Subject: Re: [PATCH V2 09/10] ARM: dts: Add Raspberry Pi Compute Module 4 IO
 Board
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, iivanov@suse.de,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Sat, 04 Sep 2021 16:52:15 +0200
In-Reply-To: <1628334401-6577-10-git-send-email-stefan.wahren@i2se.com>
References: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
         <1628334401-6577-10-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 2021-08-07 at 13:06 +0200, Stefan Wahren wrote:
> This adds the matching carrier for Raspberry Pi Compute Module 4.
> Instead of xHCI USB host controller there is just a USB 2.0 interface
> connected to the DWC2 controller from the BCM2711. As a result
> there is a free PCIe Gen 2 socket. Also there are 2 full-size HDMI 2.0
> connectors.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---

A general note: the CM4 carrier board contains an RTC and a simple fan
controller, which will need to be enabled further down the road.

Regards,
Nicolas

