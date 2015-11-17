From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] [media] move media platform data to linux/platform_data/media
Date: Tue, 17 Nov 2015 10:23:37 +0100
Message-ID: <7319142.Cp8MurgLWk@wuerfel>
References: <4d99e49726942dc4d6a6ee1debf6665b2b47908b.1447751746.git.mchehab@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <4d99e49726942dc4d6a6ee1debf6665b2b47908b.1447751746.git.mchehab@osg.samsung.com>
Sender: linux-media-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sergey Lapin <slapin@ossfans.org>, Timur Tabi <timur@tabi.org>, Jaroslav Kysela <perex@perex.cz>, Tomas Cech <sleep_walker@suse.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Markus Elfring <elfring@users.sourceforge.net>, Harald Welte <laforge@openezx.org>, openezx-devel@lists.openezx.org, Russell King <linux@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Daniel Ribeiro <drwyrm@gmail.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>
List-Id: linux-mmc@vger.kernel.org

On Tuesday 17 November 2015 07:15:59 Mauro Carvalho Chehab wrote:
> Now that media has its own subdirectory inside platform_data,
> let's move the headers that are already there to such subdir.
> 
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
