From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V8 1/2] mmc: OCTEON: Add DT bindings for OCTEON MMC
 controller.
Date: Sat, 16 Jul 2016 16:36:03 -0500
Message-ID: <20160716213603.GA11441@rob-hp-laptop>
References: <57853472.2050404@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35619 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbcGPVgH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Jul 2016 17:36:07 -0400
Content-Disposition: inline
In-Reply-To: <57853472.2050404@cavium.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Steven J. Hill" <steven.hill@cavium.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-mips@linux-mips.org, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>

On Tue, Jul 12, 2016 at 01:18:26PM -0500, Steven J. Hill wrote:
> Add Device Tree binding document for Octeon MMC controller. The driver
> is in a following patch. The OCTEON's MMC controller can be connected
> to up to 4 "slots" which may be eMMC, MMC or SD card devices. As there
> is a single controller, each available slot is represented as a child
> node of the controller.
> 
> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> Acked-by: David Daney <david.daney@cavium.com>
> 
> ---
> v8:
> - Properly documented deprecated device tree properties.
> 
> v7:
> - Rewrote a lot of the document for better readability
> 
> v6:
> - Split up patch
> - Moved device tree fixup to platform code
> ---
> 
> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
> ---
>  .../devicetree/bindings/mmc/octeon-mmc.txt         | 72 ++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/octeon-mmc.txt

Acked-by: Rob Herring <robh@kernel.org>

