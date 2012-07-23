From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 12/25] mmc/omap_hsmmc: add a const qualifier
Date: Mon, 23 Jul 2012 21:11:40 +0530
Message-ID: <CANfBPZ-5Jqy3CmUg7Oqt58ZQNa1LwwfSO6BAXk7Zxi0gpSKe+w@mail.gmail.com>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de> <1343034810-3386-13-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1343034810-3386-13-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Jul 23, 2012 at 2:43 PM, Uwe Kleine-K=F6nig
<u.kleine-koenig@pengutronix.de> wrote:
> This prepares *of_device_id.data becoming const. Without this change
> the following warning would occur:
>
>         drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_probe'=
:
>         drivers/mmc/host/omap_hsmmc.c:1808: warning: initialization d=
iscards qualifiers from pointer target type
>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Venkatraman S <svenkatr@ti.com>


> ---
>  drivers/mmc/host/omap_hsmmc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
