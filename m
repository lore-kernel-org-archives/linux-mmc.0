From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/5] SPI S3C64XX: Header for passing platform data
Date: Wed, 9 Dec 2009 12:16:43 +0000
Message-ID: <20091209121643.GD9018@sirena.org.uk>
References: <1259218097-9845-1-git-send-email-jassi.brar@samsung.com> <20091203220637.GR4808@trinity.fluff.org> <1b68c6790912040306m3098cba9wf67bfe5bfefb7e23@mail.gmail.com> <20091207144145.GT4808@trinity.fluff.org> <1b68c6790912081750r7a68f019w39a5170c9796e7b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:44824 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbZLIMQl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Dec 2009 07:16:41 -0500
Content-Disposition: inline
In-Reply-To: <1b68c6790912081750r7a68f019w39a5170c9796e7b9@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>, dbrownell@users.sourceforge.net, linux-mmc@vger.kernel.org, Jassi Brar <jassi.brar@samsung.com>, linux-arm-kernel@lists.infradead.org

On Wed, Dec 09, 2009 at 10:50:16AM +0900, jassi brar wrote:

>   Second - SPI source clocks specific, which SoCs differ by name and number.
>           Maybe this could go into plat-<soc>/include with the name
>           <soc>-spi.h

With device based lookup (which Ben mentioned he was working on) this
mapping should get handled entirely within the CPU clock tree
definition and be invisible to the driver.
