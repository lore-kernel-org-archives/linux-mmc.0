From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/1] mmc: Standardise capability type
Date: Wed, 24 Oct 2012 13:21:26 +0000
Message-ID: <201210241321.26878.arnd@arndb.de>
References: <1351084664-30526-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:62699 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932343Ab2JXNVh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Oct 2012 09:21:37 -0400
In-Reply-To: <1351084664-30526-1-git-send-email-lee.jones@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linus.walleij@stericsson.com, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Wednesday 24 October 2012, Lee Jones wrote:
> 
> There are discrepancies with regards to how MMC capabilities
> are carried throughout the subsystem. Let's standardise them
> to elevate any confusion.
> 
> Cc: Chris Ball <cjb@laptop.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Why make it "unsigned long" then? I think that adds to the
confusion because it's sometimes 32 bits and sometimes 64 bits,
depending on the CPU. Since it's a bitmask, I would suggest
using u32 to make the size explicit.

	Arnd
