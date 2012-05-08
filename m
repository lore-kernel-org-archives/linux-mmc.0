From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 08/10] mmc: mxs-mmc: add device tree support
Date: Tue, 8 May 2012 22:43:17 +0800
Message-ID: <20120508144315.GH2199@S2101-09.ap.freescale.net>
References: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
 <1336401793-13753-9-git-send-email-shawn.guo@linaro.org>
 <201205080158.07259.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44765 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115Ab2EHOnc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 May 2012 10:43:32 -0400
Received: by pbbrp8 with SMTP id rp8so8121552pbb.19
        for <linux-mmc@vger.kernel.org>; Tue, 08 May 2012 07:43:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201205080158.07259.marex@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Dong Aisheng <dong.aisheng@linaro.org>

On Tue, May 08, 2012 at 01:58:07AM +0200, Marek Vasut wrote:
> > +Optional properties:
> > +- wp-gpios: Specify GPIOs for write protection
> 
> You can have multiple wp-gpio per port? :-)
> 
This is a naming idiom documented in
Documentation/devicetree/bindings/gpio/gpio.txt

-- 
Regards,
Shawn
