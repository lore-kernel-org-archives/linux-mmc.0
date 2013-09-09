From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/3] arm: dts: socfpga: Add support for SD/MMC
Date: Mon, 09 Sep 2013 15:11:43 -0600
Message-ID: <522E398F.3080100@wwwdotorg.org>
References: <1378740833-4883-1-git-send-email-dinguyen@altera.com> <1378740833-4883-4-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:50625 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755275Ab3IIVLs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Sep 2013 17:11:48 -0400
In-Reply-To: <1378740833-4883-4-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: dinh.linux@gmail.com, Pavel Machek <pavel@denx.de>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 09/09/2013 09:33 AM, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add bindings for SD/MMC for SOCFPGA.

> diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt

> +* Altera SOCFPGA specific extensions to the Synopsis Designware Mobile
> +  Storage Host Controller
> +
> +The Synopsis designware mobile storage host controller is used to interface
> +a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
> +differences between the core Synopsis dw mshc controller properties described
> +by synopsis-dw-mshc.txt and the properties used by the SOCFPGA specific
> +extensions to the Synopsis Designware Mobile Storage Host Controller.
> +
> +Required Properties:
> +
> +* compatible: should be
> +        - "altr,socfpga-dw-mshc": for controllers with Altera SOCFPGA
> +          specific extensions.
> +
> +* samsung,dw-mshc-sdr-timing: See exynos-dw-mshc.txt for more information about
> +	this binding.

s/binding/property/

It's odd that this isn't "synopsis," rather than "samsung," if the
property is generic across all/some uses of the Synopsis core. But, I
guess this is fine.
