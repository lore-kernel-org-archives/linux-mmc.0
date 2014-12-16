From: David =?utf-8?q?Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>
Subject: [PATCH 2/4] mmc: sunxi: Lock fix
Date: Tue, 16 Dec 2014 15:11:04 +0100
Message-ID: <20141216141104.3036.83687.stgit@dizzy-6.o2s.ch>
References: <20141216140921.3036.14668.stgit@dizzy-6.o2s.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141216140921.3036.14668.stgit@dizzy-6.o2s.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, Peter Griffin <peter.griffin@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, David =?utf-8?q?Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, =?utf-8?b?5p2O5oOz?= <lixiang@allwinnertech.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

1)	Adding a comment in order to clarify the choice of the locks within
	sunxi_mmc_handle_manual_stop

2)	As =E6=9D=8E=E6=83=B3 has pointed out the wait_dma variable was not =
accessed within the spin lock
	block in sunxi_mmc_request and so (even if it should never happend) it=
 would have
	theoretically been possible that some other function would access the =
variable
	at the same time as the function.
	This has been changed now and the function is using local variables ou=
tside the lock
	and copys the value over during the lock phase.

Signed-off-by: David Lanzend=C3=B6rfer <david.lanzendoerfer@o2s.ch>
Reported-by: =E6=9D=8E=E6=83=B3 <lixiang@allwinnertech.com>
---
 drivers/mmc/host/sunxi-mmc.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.=
c
index 1fe54a8..67e680c 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -572,6 +572,15 @@ static irqreturn_t sunxi_mmc_handle_manual_stop(in=
t irq, void *dev_id)
 	}
=20
 	dev_err(mmc_dev(host->mmc), "data error, sending stop command\n");
+
+	/*
+	 * We will never have more than one outstanding request,
+	 * and we do not complete the request until after
+	 * we've cleared host->manual_stop_mrq so we do not need to
+	 * spin lock this function.
+	 * Additionally we have wait states within this function
+	 * so having it in a lock is a very bad idea.
+	 */
 	sunxi_mmc_send_manual_stop(host, mrq);
=20
 	spin_lock_irqsave(&host->lock, iflags);
@@ -768,6 +777,7 @@ static void sunxi_mmc_request(struct mmc_host *mmc,=
 struct mmc_request *mrq)
 	unsigned long iflags;
 	u32 imask =3D SDXC_INTERRUPT_ERROR_BIT;
 	u32 cmd_val =3D SDXC_START | (cmd->opcode & 0x3f);
+	bool wait_dma =3D host->wait_dma;
 	int ret;
=20
 	/* Check for set_ios errors (should never happen) */
@@ -818,7 +828,7 @@ static void sunxi_mmc_request(struct mmc_host *mmc,=
 struct mmc_request *mrq)
 			if (cmd->data->flags & MMC_DATA_WRITE)
 				cmd_val |=3D SDXC_WRITE;
 			else
-				host->wait_dma =3D true;
+				wait_dma =3D true;
 		} else {
 			imask |=3D SDXC_COMMAND_DONE;
 		}
@@ -852,6 +862,7 @@ static void sunxi_mmc_request(struct mmc_host *mmc,=
 struct mmc_request *mrq)
 	}
=20
 	host->mrq =3D mrq;
+	host->wait_dma =3D wait_dma;
 	mmc_writel(host, REG_IMASK, host->sdio_imask | imask);
 	mmc_writel(host, REG_CARG, cmd->arg);
 	mmc_writel(host, REG_CMDR, cmd_val);
