From: Pavel Machek <pavel@denx.de>
Subject: Re: [PATCHv3] ARM: socfpga: dts: Add support for SD/MMC
Date: Fri, 28 Jun 2013 13:28:33 +0200
Message-ID: <20130628112833.GC22234@amd.pavel.ucw.cz>
References: <1372397738-8093-1-git-send-email-dinguyen@altera.com>
 <1372397738-8093-2-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46622 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755716Ab3F1L2f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Jun 2013 07:28:35 -0400
Content-Disposition: inline
In-Reply-To: <1372397738-8093-2-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com
Cc: Dinh Nguyen <dinguyen@altera.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Chris Ball <cjb@laptop.org>, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux@arm.linux.org.uk, wd@denx.de

Hi!

Just some nit-picking... (not worth blocking apply for this, can
easily go through trivial tree later.)

>  create mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> new file mode 100644
> index 0000000..f36b7ee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> @@ -0,0 +1,60 @@
> +* Altera SOCFPGA specific extensions to the Synopsis Designware Mobile
> +  Storage Host Controller
> +
> +Required Properties:
> +
> +* compatible: should be
> +	- "altr,socfpga-dw-mshc": for controllers with Altera SOCFPGA
> +	  specific extensions.
> +
> +* altr,dw-mshc-ciu-div: Specifies the divider value for the card interface
> +  unit (ciu) clock. The value should be (n+1). For Altera's SOCFPGA, the divider
> +  value is fixed at 3, which mean parent_clock/4.

"which means".

> +* altr,dw-mshc-sdr-timing: Specifies the value of CIU clock phase shift value
> +  in transmit mode and CIU clock phase shift value in receive mode for single
> +  data rate mode operation. Refer notes below for the order of the cells and the

"refer to".

> +Example:
> +
> +  The MSHC controller node can be split into two portions, SoC specific and
> +  board specific portions as listed below.

", as listed".

Thanks,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
