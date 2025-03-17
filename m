Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C05E22173A;
	Mon, 17 Mar 2025 07:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194878; cv=none; b=o9BsKj4BjjiWgjvPGLAa5SCaeeB3xvHJJ3oATSP2rZMBQd0WVewff/sILonwtN1Bv01O8fXuWu3d+iTyzpPuKyN96ttp91v8d19WOElT7EL/NbYREuEPW4OjUUxweJO4yJacj7Ohq/MgoaGAsiAfxLKK9VHZooYJ3tf3Cq4kxbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194878; c=relaxed/simple;
	bh=pcONCGbc5rkoc1oArPFKfyGj44xsblbpWiNKHU45ZOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0YTNbt732R16cGAOzcSh37Fvn157pxTQWRYAIz+2XnphIASJNfYSox2Gan1LSKbn84iXqfIZCd3i4O8bwQcIFechwN1t7tn3p/V8bZ0S/ji1ZZTwj6oaaupBLHIjaP7r4haiYu1NGt2AqOtEzKKJtQYrOCnJF1kDzYmKoBEcQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKURqg6K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKURqg6K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D4BC4CEEC;
	Mon, 17 Mar 2025 07:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194877;
	bh=pcONCGbc5rkoc1oArPFKfyGj44xsblbpWiNKHU45ZOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oKURqg6KC2TeJLrTfYjlwqYp+BfzNJHYtTvLzjIyoq1pi5bsHqp13s4QIYaybiUVt
	 cKMiKHjzqAH1x4dIY+cYTCHVcmz9yQktgtSrm2Nc5uWBihc0PNQgc8CPu+XGSYXiDu
	 QgPdvIP4MIa10TRbmK5++RD1ep3IWZ+BFkpgOLS8zm1dEsQe2RenbiHWsrZPclxw8P
	 h9EpDFWqf0s51RIuo7ZgkY9o4Kb2pcAMdctZvYrrOAFMq7P+nxGShz012NT87pHQVd
	 bIGQr+RbZHG/XQV5IFM0kWe0D6Iq/fWemdDBjaFvrFNdsnCHf1Xf9nM+e71yBvowt0
	 5l81OrO34t/kA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Subject: [PATCH v2 17/31] tty: mmc: sdio: use bool for cts and remove parentheses
Date: Mon, 17 Mar 2025 08:00:32 +0100
Message-ID: <20250317070046.24386-18-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250317070046.24386-1-jirislaby@kernel.org>
References: <20250317070046.24386-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'cts' in sdio_uart_check_modem_status() is considered a 'bool', but
typed as signed 'int'. Make it 'bool' so it is clear the code does not
care about the masked value, but true/false.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
---
 drivers/mmc/core/sdio_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
index 6b7471dba3bf..7423a601e1e5 100644
--- a/drivers/mmc/core/sdio_uart.c
+++ b/drivers/mmc/core/sdio_uart.c
@@ -471,7 +471,7 @@ static void sdio_uart_check_modem_status(struct sdio_uart_port *port)
 		port->icount.cts++;
 		tty = tty_port_tty_get(&port->port);
 		if (tty && C_CRTSCTS(tty)) {
-			int cts = (status & UART_MSR_CTS);
+			bool cts = status & UART_MSR_CTS;
 			if (tty->hw_stopped) {
 				if (cts) {
 					tty->hw_stopped = false;
-- 
2.49.0

