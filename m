Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826FA10A25;
	Wed,  6 Dec 2023 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8tz2A1o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935E3C433CA;
	Wed,  6 Dec 2023 07:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701848245;
	bh=au2qVoU5EGZL30OW66lkI/5jEIUbbaf09JZzLT3iJUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g8tz2A1oQC/+OIygUHzxU9xtNKIx5eyfn2meA3opHbAaDXKIic+FxOJ6vx3/Rl+QZ
	 NMM4HEmvw9oprmXzS+aTJL4zEXmsVA6hp90YJEt5IGgsMi6KlOJeA8UiWpKV4iUeIb
	 /habrDPXEnmzRJ0rs46KOdacSQtqCwJ7Ywjs0HfFrnntLnaYJv9M+sObG5ig62bQ3g
	 jer1OPoO74nevnfLWU/B9iZumUSRWeCCa2DyvBVWy4JmpBz1WEmz3b9YFYCNMXT9A+
	 WbBxcGGIVTe2+hXHiZLHAGaORQIX5CUIZDDnbyJuZ1zOvbXn6+/XozE1+O8tO7n2jz
	 SUQcHquOkWK8Q==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Subject: [PATCH 02/27] tty: mmc: sdio_uart: switch sdio_in() to return u8
Date: Wed,  6 Dec 2023 08:36:47 +0100
Message-ID: <20231206073712.17776-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206073712.17776-1-jirislaby@kernel.org>
References: <20231206073712.17776-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sdio_in() returns a value returned from sdio_readb(). The latter returns
u8. So should the former. Therefore, switch sdio_in() return type to u8
and all its callers too.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
---
 drivers/mmc/core/sdio_uart.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
index ef38dcd3a887..a05322f15771 100644
--- a/drivers/mmc/core/sdio_uart.c
+++ b/drivers/mmc/core/sdio_uart.c
@@ -178,11 +178,9 @@ static inline void sdio_uart_release_func(struct sdio_uart_port *port)
 		sdio_release_host(port->func);
 }
 
-static inline unsigned int sdio_in(struct sdio_uart_port *port, int offset)
+static inline u8 sdio_in(struct sdio_uart_port *port, int offset)
 {
-	unsigned char c;
-	c = sdio_readb(port->func, port->regs_offset + offset, NULL);
-	return c;
+	return sdio_readb(port->func, port->regs_offset + offset, NULL);
 }
 
 static inline void sdio_out(struct sdio_uart_port *port, int offset, int value)
@@ -192,8 +190,8 @@ static inline void sdio_out(struct sdio_uart_port *port, int offset, int value)
 
 static unsigned int sdio_uart_get_mctrl(struct sdio_uart_port *port)
 {
-	unsigned char status;
 	unsigned int ret;
+	u8 status;
 
 	/* FIXME: What stops this losing the delta bits and breaking
 	   sdio_uart_check_modem_status ? */
@@ -354,14 +352,13 @@ static void sdio_uart_stop_rx(struct sdio_uart_port *port)
 	sdio_out(port, UART_IER, port->ier);
 }
 
-static void sdio_uart_receive_chars(struct sdio_uart_port *port,
-				    unsigned int *status)
+static void sdio_uart_receive_chars(struct sdio_uart_port *port, u8 *status)
 {
-	unsigned int ch, flag;
+	unsigned int flag;
 	int max_count = 256;
 
 	do {
-		ch = sdio_in(port, UART_RX);
+		u8 ch = sdio_in(port, UART_RX);
 		flag = TTY_NORMAL;
 		port->icount.rx++;
 
@@ -449,8 +446,8 @@ static void sdio_uart_transmit_chars(struct sdio_uart_port *port)
 
 static void sdio_uart_check_modem_status(struct sdio_uart_port *port)
 {
-	int status;
 	struct tty_struct *tty;
+	u8 status;
 
 	status = sdio_in(port, UART_MSR);
 
@@ -499,7 +496,7 @@ static void sdio_uart_check_modem_status(struct sdio_uart_port *port)
 static void sdio_uart_irq(struct sdio_func *func)
 {
 	struct sdio_uart_port *port = sdio_get_drvdata(func);
-	unsigned int iir, lsr;
+	u8 iir, lsr;
 
 	/*
 	 * In a few places sdio_uart_irq() is called directly instead of
-- 
2.43.0

