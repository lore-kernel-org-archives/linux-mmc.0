From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3.10] mmc: sdhci-s3c: Fix operation on non-single image Samsung platforms
Date: Tue, 30 Apr 2013 16:43:43 +0200
Message-ID: <201304301643.43989.arnd@arndb.de>
References: <1367330907-13525-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:54967 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760050Ab3D3Onu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Apr 2013 10:43:50 -0400
In-Reply-To: <1367330907-13525-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 30 April 2013, Mark Brown wrote:
> Commit cc014f3 (mmc: sdhci-s3c: remove platform dependencies) changed
> the platform dependency in Kconfig to depend on SAMSUNG_SINGLE, meaning
> the driver was available only on single zImage Samsung platforms.  This
> breaks platforms that haven't been converted such as S3C64xx.  Revert
> that part of the change to fix.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Actually this part of my patch was just a mistake, and should never
have been in there. I'll apply your patch and amend the changelog.

Thanks a lot!

	Arnd
