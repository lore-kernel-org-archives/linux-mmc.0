Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CE510A25;
	Wed,  6 Dec 2023 07:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AII4ZFvk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA96C43391;
	Wed,  6 Dec 2023 07:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701848273;
	bh=sL9jADnOH5s9rXM78Nf+CIz2brDSijTdhq+NDPBkjUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AII4ZFvk5eHb0lgbdW0f+lYVXKurtgSL/1tSJ7gtopSCrC7Fpkwiq1yWfg7XHLh45
	 L32NfbbtWCZpdml4zrjxwLKv8CXgBEZ4R6/gpCTVoa4Mn8dryRO8hTvnCenEh1zhR/
	 PwL+BUlb3LyiMs1+x9/LoSPDfgayqvnJ3lruwsSpnG+R94MBSZqFLqjhgYKdUUh+7d
	 FfvpodAenm6UEjzS8awFwPCeXTcBgsCw7IOUAlh2pL1iJ/eSQa1/N/iBnWEdDfRyhL
	 646oO2lSNqMllxML3quTiZ0Jd6NSOU4roAa+o4ytL8CeFM+VsSp2cThv8zboKLDOHN
	 DIZmZu1AzsQgA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Subject: [PATCH 16/27] tty: mmc: sdio: use u8 for flag
Date: Wed,  6 Dec 2023 08:37:01 +0100
Message-ID: <20231206073712.17776-17-jirislaby@kernel.org>
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

Switch character types to u8. To conform to characters in the rest of
the tty layer.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
---
 drivers/mmc/core/sdio_uart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
index 370fadf1d6d1..575ebbce378e 100644
--- a/drivers/mmc/core/sdio_uart.c
+++ b/drivers/mmc/core/sdio_uart.c
@@ -354,12 +354,11 @@ static void sdio_uart_stop_rx(struct sdio_uart_port *port)
 
 static void sdio_uart_receive_chars(struct sdio_uart_port *port, u8 *status)
 {
-	unsigned int flag;
 	int max_count = 256;
 
 	do {
 		u8 ch = sdio_in(port, UART_RX);
-		flag = TTY_NORMAL;
+		u8 flag = TTY_NORMAL;
 		port->icount.rx++;
 
 		if (unlikely(*status & (UART_LSR_BI | UART_LSR_PE |
-- 
2.43.0

