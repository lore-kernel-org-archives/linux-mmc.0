From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] MMC: Extends card quicks with MMC/SD quirks matching the CID.
Date: Sun, 13 Mar 2011 15:55:40 +0100
Message-ID: <201103131555.40813.arnd@arndb.de>
References: <1299017344-25361-1-git-send-email-andreiw@motorola.com> <1300024118-23771-2-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:53474 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab1CMOzs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Mar 2011 10:55:48 -0400
In-Reply-To: <1300024118-23771-2-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org, tardyp@gmail.com, linus.walleij@linaro.org

On Sunday 13 March 2011 14:48:37 Andrei Warkentin wrote:
> The current mechanism is SDIO-only. This allows us to create
> function-specific quirks, without creating messy Kconfig dependencies,
> or polluting core/ with function-specific code.
> 
> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>

Looks good to me.

Acked-by: Arnd Bergmann <arnd@arndb.de>
