From: Ralph Droms <rdroms@gmail.com>
Subject: Re: [PATCH v2] mmc: mvsdio: fix non-DT probing of GPIOs
Date: Thu, 21 Mar 2013 09:59:22 -0400
Message-ID: <FBE8EA3F-2335-42F3-8203-016E4D41D835@gmail.com>
References: <1363792148-26405-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f176.google.com ([209.85.128.176]:62603 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755858Ab3CUN73 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Mar 2013 09:59:29 -0400
Received: by mail-ve0-f176.google.com with SMTP id cz10so2401695veb.21
        for <linux-mmc@vger.kernel.org>; Thu, 21 Mar 2013 06:59:28 -0700 (PDT)
In-Reply-To: <1363792148-26405-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maen Suleiman <maen@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

I've tested the patch and it's OK.

- Ralph Droms

On Mar 20, 2013, at 11:09 AM 3/20/13, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

Ralph Droms <rdroms.ietf@gmail.com> reported that 3.9-rc was breaking
the SDIO interface on his Sheevaplug platform, and that the recent
changes to the mvsdio driver are responsible for this breakage.

After investigation, is turns out that the Sheevaplug does not have
any "card detect" GPIO, and the Sheevaplug has not been converted to
the Device Tree. Therefore, the Sheevaplug board code does not define
a value for the .gpio_card_detect field of the mvsdio_platform_data
structure, which means that its value is 0. Unfortunately,
gpio_is_valid() considers 0 as a valid GPIO, and therefore calls
mmc_gpio_request_cd(), which fails and makes the entire probing of the
driver fail.

In fact, in the previous mvsdio code, before the Device Tree binding
was introduced, 0 was not considered as a valid GPIO. Therefore, this
fix revert back to this behavior in the non-DT case, by setting the
gpio_card_detect and gpio_write_protect local variables to -EINVAL
when the corresponding fields of the mvsdio_platform_data structure
are set to zero (i.e, left undefined). Of course, it prevents to use
GPIO 0 as a card detect or write protect GPIO, but it was a defiency
of the previous non-DT code, and the fix moving forward is to convert
platforms to the Device Tree.

The problem has been reproduced successfully on the Kirkwood-based
Marvell DB-88F6281-BP Development Board (that doesn't use the Device
Tree) and the fix has proven to work properly, after of course
removing the gpio_card_detect field of the mvsdio_platform_data
instance for this board.

Reported-by: Ralph Droms <rdroms.ietf@gmail.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Tested-by: Ralph Droms <rdroms@gmail.com>
---
This patch should be applied on 3.9-rcX.

Changes between v1 and v2:
* Send the patch to the MMC maintainer instead of the Marvell
  maintainers.
---
drivers/mmc/host/mvsdio.c |    4 ++--
1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 145cdaf..1e4d567 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -741,8 +741,8 @@ static int __init mvsd_probe(struct platform_device *pdev)
			goto out;
		}
		host->base_clock = mvsd_data->clock / 2;
-		gpio_card_detect = mvsd_data->gpio_card_detect;
-		gpio_write_protect = mvsd_data->gpio_write_protect;
+		gpio_card_detect = mvsd_data->gpio_card_detect ? : -EINVAL;
+		gpio_write_protect = mvsd_data->gpio_write_protect ? : -EINVAL;
	}

	mmc->ops = &mvsd_ops;
-- 
1.7.9.5


