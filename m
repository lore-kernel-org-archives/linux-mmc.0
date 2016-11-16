From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCHv2 09/10] mmc: dw_mmc: The "clock-freq-min-max" property
 was deprecated
Date: Wed, 16 Nov 2016 07:45:51 -0600
Message-ID: <20161116134551.3f7jgdyjhh766kfn@rob-hp-laptop>
References: <20161115101232.3854-1-jh80.chung@samsung.com>
 <20161115101232.3854-10-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34364 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbcKPNpx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2016 08:45:53 -0500
Content-Disposition: inline
In-Reply-To: <20161115101232.3854-10-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, ulf.hansson@linaro.org, heiko@sntech.de, shawn.lin@rock-chips.com

On Tue, Nov 15, 2016 at 07:12:31PM +0900, Jaehoon Chung wrote:
> The "clock-freq-min-max" property was deprecated.
> There is "max-frequency" property in drivers/mmc/core/host.c
> "max-frequency" can be replaced with "clock-freq-min-max".
> Minimum clock value might be set to 100K by default.
> Then MMC core should try to find the correct value from 400K to 100K.
> So it just needs to set Maximum clock value.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 3 ++-
>  drivers/mmc/host/dw_mmc.c                                  | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
