Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793586576;
	b=s6frurn4hoIuIiNpzLrSYIe4PUexTSpAJKt5qqxWwqMdYdodJ02QQNuXlnwXgPL0pkBR
	 2Cw78VvK1P4vbdgxAtoVwQz2I9grNK6k/QkdsxrGnqcto6v97rFkdtiLcZ5NP5eu92hsC
	 D+e8spumvdH0NuYg2hlzMQyRD4aRQex1NAAan8AUPmSdRL+Fg/ggNjV6WN83G+uk1GMWM
	 eur815ij/m6q9EC1Ew55lE+FtFqRK9d2KGFaogd/+g7opagFZlERj9fxz/beU7IoQ0OXl
	 f82mCKjrNtWZu/lgK0gAO99N2sgC4xH8Qds3D+gnN1gDjdq1AkYWhQHi8w0TBYV8DKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793586576;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZMEpOVsFrqARpvMUvrisLIeuBsTKQUpHcnf8SDZYr04=;
	b=XUoiVH9erJOHTeuL/T4nuW82SE9TmfTRp97r9fuYXa/2o1UVhWIoRZFPQTiC/FVCqTt0
	 QZHdPFYomS8rfB2f3PZ3K5ugZkDgDyfibGxrDYdQFnMsDEYZTZ8j7rj2/id+qnJ6oZ1zM
	 9XFGAzPSZ1XV8EHInPwUSMnydTvgU/G+ebbF5UOTI8xqFgFaXLqylqOR/fy+GDM72mQ2H
	 obfJUM8DvzfaVKLhLK9FrXtIMy2PWjspRYVXfl+yyFxrGjuRVw542QnLKYZ9yzf7OWuc2
	 HV8vDuAmdthdWkS6XxratAY2R/9sKFyAVGO79P/hqHODxuOqZACRfPmHdKtRQWeka6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W3NssMvJ;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B196860A261C
	for <linux-mmc@vger.kernel.org>; Mon,  2 Nov 2026 02:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B196860A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W3NssMvJ
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a07025cce4so1226922b3a.2
        for <linux-mmc@vger.kernel.org>; Sun, 01 Nov 2026 18:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793586575; x=1794191375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZMEpOVsFrqARpvMUvrisLIeuBsTKQUpHcnf8SDZYr04=;
        b=W3NssMvJLHgCvUg4HTHuTW8eZXgZHmOMe7ukKu8BChEm3Ckr0jFjqnzwLbsM6pPczY
         1lUp4OnfXPMm8G8ImzigMSgE5MazRcISXE6CDiRO25wIzVGWUguM+Uz9vu0eGpi3+SAL
         OEmAcJkngrhsKUSZ0YylAiSM8HbWKBe4Dbxv8upb9SfLMwStQan780AS9o4NA/x8wcpV
         4EEH7pK/9Kz8WpOX50xFu/CQ/bl9k2vny/NMQ/otJvF+6dltrNlMDddThyPF7iINnETP
         loVTbzjoWL73pH76W0QOQO68CvCjWZqopxtsS9m6VUlkC/WOKEtIMYXPQFTu+i74sFIj
         /DfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793586575; x=1794191375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZMEpOVsFrqARpvMUvrisLIeuBsTKQUpHcnf8SDZYr04=;
        b=s4q/lZTKvphiV8SrVlCtx0WSDVBYxiyDMLGsE3wjILqUdBxF/fR0fSVSQVOvg7AZvu
         QmuSsh1XuFwZxjEadnKn2ORBuFuOK8Ut3hiicORAvNH41Fef3BzD+zRyX7cKiTgP10SM
         mWKSmwFr4JHYLR/8VD/yMoS12ERaDMKfZlhpD9nA0+2AedSNfeLHsYuJX60/KLYMIiwy
         klWX5a9iZIH9l3UlAcFjhGfFFIysOr0yKo+KmVgDrwGzW39WvKAu9aT0JAEKWYo80PIX
         adKQFzyRQQ2O7QA4ahRcku2DM7xSaJkDXzKo3jRajHu9oeTmhXLUyEkTxOxgAulw/gN9
         x+Aw==
X-Gm-Message-State: AFq9FYJqknlUJEdZF+izG5e+TW0fwVRa0WfP0xbBMx7g935mw4XboAHG
	jmbVReRU8Xq0MkauAUpeYq/2A/P24etqTXcNgEnomYX53MyY00SEi+Bg
X-Gm-Gg: AYBFou3pl7yj92b3Y5klvQtBPju+DjwKUCyAJeNTCWfVwFro6pxAxJGbho5Maxj9Zv6
	WC44Wh6zB9fB64qIMVsVmXuRldJIEHQ2y2eloGcCsnU6GLf7PpuucBzXjrecOMu+Zj5Dhskz2uO
	wXGJj4KWK3vB8kZSz8ZnhMmqZc0y/eXeu6SImyw0cKGRmZB+aq6/lDERjV1xUO6wR1tQZWjey8Z
	si0nzG3k9pnZVr0rtFxe6rS7md9y2ydwHwX4mjblG2nRBSMIQeeU5cnT82NevJ6KnaRaU7+4fnr
	5icbFODnAjj+5C9kdzpURXvVJnPJN0FYm8u8zQGtb8FRVug3XJfX2foXMPXB5Q8MkcRcBScooib
	mIDlYaWbrNEtmvOmYS57qMER9ZWK4wkRApokDZJgY5aSHxF7BDCY+ohmcHgqLhG1OURNGWkcKP0
	qaN19upUNYxZ48Ci56PfXiTGAqWTTTUOHCiuRgAmp/I5Q+nEmP8jJIrnVHSV51s1n6P9f+eL0gh
	ZsmyHyeNmYIPuGgFuuFtu9KXrhLXjUra5aYfhR7jnF0VCIccCbFVy8Lvw/LVJZagIiItpjjENmD
	Zik/TTOoLrZPwr2CEOg+7ATGPeMO5+HQO+g3drnibwSaAPw=
X-Received: by 2002:a05:6a21:7741:b0:3de:48e4:c37d with SMTP id adf61e73a8af0-3e9289765e2mr6558635637.26.1793586575163;
        Sun, 01 Nov 2026 18:29:35 -0800 (PST)
Received: from ubuntu24.vpn.host.chaitin.net ([124.77.157.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb09814cb9sm2441382a12.24.2026.11.01.18.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 18:29:34 -0800 (PST)
From: BeaCox <0xbeac@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	BeaCox <0xbeac@gmail.com>
Subject: [RFC PATCH v2 2/2] mmc: dw_mmc: cancel the watchdog timer on remove
Date: Mon,  2 Nov 2026 10:29:24 +0800
Message-ID: <20261102022924.51343-3-0xbeac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102022924.51343-1-0xbeac@gmail.com>
References: <20261101063719.88570-1-0xbeac@gmail.com>
 <20261102022924.51343-1-0xbeac@gmail.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The central watchdog added for command and data timeout handling is
armed while a request is in flight and is only stopped when the
completion is delivered.  If the host is removed with a request still
in flight, the timer can expire after the controller has been disabled
and its callback reads the controller registers and the host state.

Cancel the timer after bh_work has been disabled, so that a work item
that is still running cannot rearm it after the cancellation.

Fixes: ce0043b9a302 ("mmc: dw_mmc: add central watchdog and convert CTO onto it")
Signed-off-by: BeaCox <0xbeac@gmail.com>
---
 drivers/mmc/host/dw_mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 5b47643..dc3beab 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3410,6 +3410,7 @@ void dw_mci_remove(struct dw_mci *host)
 	/* Stop the work before the timer that it can rearm. */
 	disable_work_sync(&host->bh_work);
 	dw_mci_stop_fault_timer(host);
+	hrtimer_cancel(&host->wd_timer);
 
 	/* disable clock to CIU */
 	mci_writel(host, CLKENA, 0);
-- 
2.43.0

