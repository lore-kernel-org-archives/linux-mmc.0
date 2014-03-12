From: Matt Porter <mporter@linaro.org>
Subject: Re: [PATCH v2 3/4] rename ARCH_BCM to ARCH_BCM_MOBILE (mmc)
Date: Wed, 12 Mar 2014 17:45:24 -0400
Message-ID: <20140312214524.GS25092@beef>
References: <1379956836-5866-1-git-send-email-bcm@fixthebug.org>
 <1379956836-5866-4-git-send-email-bcm@fixthebug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:42221 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079AbaCLVpa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Mar 2014 17:45:30 -0400
Received: by mail-ie0-f169.google.com with SMTP id to1so107813ieb.28
        for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2014 14:45:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1379956836-5866-4-git-send-email-bcm@fixthebug.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Domenico Andreoli <cavokz@gmail.com>, Christian Daudt <csd@broadcom.com>, Hauke Mehrtens <hauke@hauke-m.de>, Alex Elder <alex.elder@linaro.org>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Sep 23, 2013 at 10:20:35AM -0700, Christian Daudt wrote:
> Currently ARCH_BCM has been used for Broadcom
> Mobile V7 based SoCs. In order to allow other Broadcom
> SoCs to also use mach-bcm directory and files, this patch
> renames the original ARCH_BCM to ARCH_BCM_MOBILE, and
> uses ARCH_BCM to define any Broadcom chip residing
> in mach-bcm directory.
> 
> Signed-off-by: Christian Daudt <bcm@fixthebug.org>
> Acked-by: Olof Johansson <olof@lixom.net>

Hi Chris,

Could you please take this patch for 3.15? It was missed for 3.14.

Thanks,
Matt
