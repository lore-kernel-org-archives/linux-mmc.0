From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv4 6/6] mmc: dw_mmc: Add support DW SD/MMC driver on SOCFPGA
Date: Fri, 24 May 2013 19:12:53 +0200
Message-ID: <201305241912.53751.arnd@arndb.de>
References: <1369410080-436-1-git-send-email-dinguyen@altera.com> <1369410080-436-6-git-send-email-dinguyen@altera.com> <201305241910.37975.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:56104 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755337Ab3EXRNe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 May 2013 13:13:34 -0400
In-Reply-To: <201305241910.37975.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: linux-arm-kernel@lists.infradead.org, dinh.linux@gmail.com, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Olof Johansson <olof@lixom.net>, Pavel Machek <pavel@denx.de>, linux-mmc@vger.kernel.org

On Friday 24 May 2013, Arnd Bergmann wrote:

> It also seems odd to have this in the series for the ethernet driver.

After I sent it I realized that your patches are actually for different
parts of the system, they were just all replies to the same first patch.

It's usually helpful to add a [PATCH 0/6] message that explains the
overall intention and who you expect to pick up the patches, to avoid
the confusion I had.

	Arnd
