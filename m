From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [RFC PATCH v2 0/4] mmc: wii: sdhci controller support
Date: Tue, 15 Dec 2009 01:45:52 +0300
Message-ID: <20091214224552.GA21934@oksana.dev.rtsoft.ru>
References: <1260829459-23518-1-git-send-email-albert_herranz@yahoo.es>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from imap.ru.mvista.com ([213.79.90.228]:4542 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932327AbZLNWp6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Dec 2009 17:45:58 -0500
Content-Disposition: inline
In-Reply-To: <1260829459-23518-1-git-send-email-albert_herranz@yahoo.es>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: linux-mmc@vger.kernel.org, akpm@linux-foundation.org

On Mon, Dec 14, 2009 at 11:24:15PM +0100, Albert Herranz wrote:
> This patch set adds support for the SDHCI controllers found in the
> "Hollywood" chipset of the Nintendo Wii video game console.
> 
> First, the existing sdhci-of driver is splitted into a core part and
> a eSDHC-only part. Then the Nintendo Wii SDHCI support is added as an
> add-on to that, re-using common code.

All four patches

Acked-by: Anton Vorontsov <avorontsov@ru.mvista.com>


Andrew,

The patches appears to

- build fine, modular and built-in;
- sparse clean;
- checkpatch clean;
- actually work on a real hardware (tested with eSDHC);

Would you mind merging them for 2.6.33?

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
