From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: atmel-mci causes kernel panic when CONFIG_DEBUG_VM is set
Date: Thu, 19 May 2011 20:25:15 +0200
Message-ID: <20110519182515.GC21172@pengutronix.de>
References: <4DD4CC68.80408@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <4DD4CC68.80408@atmel.com>
Sender: owner-linux-mm@kvack.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>, linux-mm@kvack.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, "Ferre, Nicolas" <Nicolas.FERRE@atmel.com>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hello,

On Thu, May 19, 2011 at 09:53:12AM +0200, Ludovic Desroches wrote:
> There is a bug with the atmel-mci driver when the debug feature
> CONFIG_DEBUG_VM is set.
for the new audience: the driver does the following:

	flush_dcache_page(sg_page(sg));

with sg being a struct scatterlist * provided by the caller of the
struct mmc_host_ops.request callback.

> Into the atmci_read_data_pio function we use flush_dcache_page (do
> we really need it?) which call the page_mapping function where we
> can find VM_BUG_ON(PageSlab(Page)). Then a kernel panic happens.
>=20
> I don't understand the purpose of the VM_BUG_ON(PageSlab(Page)) (the
> page comes from a scatter list). How could I correct this problem?
I discussed this problem with Steven and Peter on irc and Steven found
two functions in the mmc code (mmc_send_cxd_data and mmc_send_bus_test)
that use the following idiom:

	struct scatterlist sg;
	void *data_buf;

	data_buf =3D kmalloc(len, GFP_KERNEL);

	sg_init_one(&sg, data_buf, len);

Is that allowed (i.e. pass  kmalloc'd memory to sg_init_one)? That might
be the source of the slub page in the scatterlist, no?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter=
.ca/
Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
