From: Greg KH <gregkh@suse.de>
Subject: [107/143] mmc: build fix: mmc_pm_notify is only available
	with CONFIG_PM=y
Date: Thu, 05 May 2011 17:21:32 -0700
Message-ID: <20110506002215.733039547@clark.kroah.org>
References: <20110506002311.GA15354@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3927682475785293215=="
Return-path: <stable-bounces@linux.kernel.org>
In-Reply-To: <20110506002311.GA15354@kroah.com>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/stable>,
	<mailto:stable-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/mailman/private/stable/>
List-Post: <mailto:stable@linux.kernel.org>
List-Help: <mailto:stable-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/stable>,
	<mailto:stable-request@linux.kernel.org?subject=subscribe>
Sender: stable-bounces@linux.kernel.org
Errors-To: stable-bounces@linux.kernel.org
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Kukjin Kim <kgene.kim@samsung.com>, Maxim Levitsky <maximlevitsky@gmail.com>, linux-mmc@vger.kernel.org, David Brownell <david-b@pacbell.net>, Alan Stern <stern@rowland.harvard.edu>, =?ISO-8859-15?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, akpm@linux-foundation.org, torvalds@linux-foundation.org, stable-review@kernel.org, alan@lxorguk.ukuu.org.uk
List-Id: linux-mmc@vger.kernel.org

--===============3927682475785293215==
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by hera.kernel.org id p460UiBr007427

2.6.32-longterm review patch.  If anyone has any objections, please let u=
s know.

------------------

From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

commit 81ca03a0e2ea0207b2df80e0edcf4c775c07a505 upstream.

This fixes a build breakage introduced by commit 4c2ef25fe0b8 ("mmc: fix
all hangs related to mmc/sd card insert/removal during suspend/resume")

Cc: David Brownell <david-b@pacbell.net>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-mmc@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Acked-by: Kukjin Kim <kgene.kim@samsung.com>
Acked-by: Maxim Levitsky <maximlevitsky@gmail.com>
Acked-by: Randy Dunlap <randy.dunlap@oracle.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/mmc/core/host.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -85,7 +85,9 @@ struct mmc_host *mmc_alloc_host(int extr
 	init_waitqueue_head(&host->wq);
 	INIT_DELAYED_WORK(&host->detect, mmc_rescan);
 	INIT_DELAYED_WORK_DEFERRABLE(&host->disable, mmc_host_deeper_disable);
+#ifdef CONFIG_PM
 	host->pm_notify.notifier_call =3D mmc_pm_notify;
+#endif
=20
 	/*
 	 * By default, hosts do not support SGIO or large requests.



--===============3927682475785293215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
stable mailing list
stable@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/stable

--===============3927682475785293215==--
