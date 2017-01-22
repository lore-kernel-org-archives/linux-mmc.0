From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 00/14] Ingenic JZ4740 / JZ4780 pinctrl driver
Date: Sun, 22 Jan 2017 15:49:33 +0100
Message-ID: <20170122144947.16158-1-paul@crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from outils.crapouillou.net ([89.234.176.41]:40656 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbdAVOu2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Jan 2017 09:50:28 -0500
In-Reply-To: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, james.hogan@imgtec.com

Hi,

This is the v2 of my ingenic pinctrl patch series.
Huge changes in there, the pinctrl driver was completely rewritten, and the
GPIO code was split into a separate driver.

It now uses the generic functions to handle pin groups, as well as generic
devicetree bindings.

Best regards,
- Paul

