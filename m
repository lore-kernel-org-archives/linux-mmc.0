Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461518;
	b=kin4hunJFNlcl/tgNiWAsLVG17Z3j/c7tZw5DC0l9GJRAxeq8rzN9oYKNaB2weZpGLav
	 99O6vSkduSCG5qNUocn2XijV7LkVJgW2sL/ymMUNXfWH1S+haKxBk7dWPyGsLLLbuQHYM
	 9FzwZ5t+PUXGK59aGAbgQluD+Zr5J+T/wiZbWorTx9z/Sk9Ijs/vuN+4EX8vNJhQnh6dx
	 4KEdzGtwlDn6XckQJ8KNwU0pGAStizVR6l/59CRNyN2eU/Um5eW7jmuwhnp1YjnilI1Xs
	 adRTXN+LQ8CeZB1EzXTrnvuJB4CHsKN/Deui6v7UEU2MK3NdLR7Gsq/sg70pvwuKrvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461518;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=aQjlvqRep44Ttr211pWzlgA8ZTFpi9k6/k/c/EcXx1Y=;
	b=GaGzMrqu739rGCiYUNkIhkr9A1bMyOqZE31P+636casMkGK9QXv4rDIkBoMSZTgzqQJB
	 FP8HggWJj2S1q16I/1DXBw+araVa8vqeaodvTP50sE1XwnbauRf4PBzPxdJGGses1qvDm
	 72eXd5f74cP4whEbZhuLJCtPB1eY8fIJO0woa4lgB69lfL5aabgqdxp0Inv7MWP7X+zKE
	 caP0LJf+D5sg4qmGidCWooLw2f4bQuhsGacLSlArkQCBROkfeFhpb+N/nC6osQUanayYn
	 UzGhatwrJ6BjyLwzexi02F22TYMuEtR0r581NXiUGu0Pv49Y93XTdv+E5dnFO0hrbZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d1cc42vD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47432606A332;
	Mon, 23 Nov 2026 19:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d1cc42vD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC341F000C0;
	Mon, 23 Nov 2026 19:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461517;
	bh=aQjlvqRep44Ttr211pWzlgA8ZTFpi9k6/k/c/EcXx1Y=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=d1cc42vDqR0hwuOyHRkb5DCYPT/5sZ+mJg2EZOn5cYqFwLED5ZZmLW/AiL0PDom/c
	 564EiqnX9WoAmXJnmWmTSgOZemaTkvqw4X++nCfmiCiad/PduDet84KklclQO3sPMv
	 hZ9KYDDGp7KDPj7AmEFXI0TIS7EhWWI7kRsAgL1qRwetm8XGoIjIrppKGiFnUOL78r
	 7BVeiYYIq9u1BnCeDXpWtYGa3jaPNygBF7hFOf4c7VzjB9vMWFhwARhWhExPggUA5k
	 JfB0dOBsPhUiZ4hcRIYo/SybQ1hl+bW9NtUpHr2NeoUuVodIhNhUsQI74xoPgobHnI
	 EvVJG2NX5UWnw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] mmc: dw_mmc: Disarm central watchdog when ending a request
Date: Mon, 23 Nov 2026 19:15:55 +0000
Message-ID: <20261123191703.179283-12-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123191703.179283-1-lee@kernel.org>
References: <20261123191703.179283-1-lee@kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When EVENT_DATA_ERROR (such as SDMMC_INT_DCRC or SDMMC_INT_SBE) is
handled in STATE_SENDING_DATA, send_stop_abort() starts a stop command
and arms host->wd_timer for DW_MCI_WD_CMD_EVENTS.  In STATE_DATA_BUSY,
dw_mci_data_complete() resets the controller on data error, aborting the
in-flight stop command, and dw_mci_work_func() ends the request via
dw_mci_request_end() if EVENT_CMD_COMPLETE is not already pending.

Because dw_mci_request_end() does not disarm host->wd_timer, the stale
command watch remains armed after mmc_request_done() and later injects a
spurious SDMMC_INT_RTO and EVENT_CMD_COMPLETE while idle or during a
subsequent recovery command (for example MMC_GO_IDLE_STATE, which does
not re-arm the command watchdog).

Disarm the central watchdog under host->irq_lock when transitioning to
STATE_IDLE in dw_mci_request_end(), and clear wd_states and
wd_deadline_ns alongside wd_events when disarming in
dw_mci_wd_deliver().

Fixes: ce0043b9a302 ("mmc: dw_mmc: add central watchdog and convert CTO onto it")
Closes: https://sashiko.dev/#/bug/linux-d7e53c20-ef39-494b-bb97-b00b62186c2f
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mmc/host/dw_mmc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index ff0b25d287a9..6865cffad51a 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -79,8 +79,11 @@
 static void dw_mci_wd_deliver(struct dw_mci *host, unsigned long events)
 {
 	host->wd_events &= ~events;
-	if (!host->wd_events)
+	if (!host->wd_events) {
+		host->wd_states = 0;
+		host->wd_deadline_ns = 0;
 		hrtimer_try_to_cancel(&host->wd_timer);
+	}
 }
 
 /*
@@ -1887,15 +1890,20 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
 	__acquires(&host->lock)
 {
 	struct mmc_host	*prev_mmc = host->mmc;
+	unsigned long irqflags;
 
 	WARN_ON(host->cmd || host->data);
 
 	host->mrq = NULL;
 
-	if (host->state == STATE_SENDING_CMD11)
+	if (host->state == STATE_SENDING_CMD11) {
 		host->state = STATE_WAITING_CMD11_DONE;
-	else
+	} else {
+		spin_lock_irqsave(&host->irq_lock, irqflags);
+		dw_mci_wd_deliver(host, ~0UL);
+		spin_unlock_irqrestore(&host->irq_lock, irqflags);
 		host->state = STATE_IDLE;
+	}
 
 	spin_unlock(&host->lock);
 	mmc_request_done(prev_mmc, mrq);
-- 
2.56.1.750.gf70dc682cf-goog

