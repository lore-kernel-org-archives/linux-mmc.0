From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6/6] mmc: sd: Add retries in re-detection
Date: Tue, 26 Apr 2011 15:42:08 +0200
Message-ID: <201104261542.08353.arnd@arndb.de>
References: <1303520502-32171-1-git-send-email-john.stultz@linaro.org> <1303520502-32171-7-git-send-email-john.stultz@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:49255 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755444Ab1DZNmO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2011 09:42:14 -0400
In-Reply-To: <1303520502-32171-7-git-send-email-john.stultz@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: linux-mmc@vger.kernel.org, San Mehat <san@android.com>, Chris Ball <cjb@laptop.org>, Dima Zavin <dima@android.com>

On Saturday 23 April 2011, John Stultz wrote:
> From: San Mehat <san@android.com>
> 
> Signed-off-by: San Mehat <san@android.com>

Same comments apply as in the previous patch. Maybe San Mehat can
comment on the intentions of this patch. Is there a specific hardware
that is causing this trouble.

> mmc: sd: Remove debugging printk

Stray output in changelog?

	Arnd
