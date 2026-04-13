Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8C43C1987
	for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776080561; cv=none; b=MSEKx8Dv2iQ026GeKRprS94h9/OnSOx5XZIQixzV1AyS5hQM04WgGZ9YZygMfCBzleBTxqBdd5+AWxx3ia06Tou1Iwp99++wDY9xVfAuWXsfz2WNeWrEmRxTQ0ACgx1CakacHFQl/6d4Qv2UsseCpe2ZiaJI0HFysMiPx66E6lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776080561; c=relaxed/simple;
	bh=0qrQDtg/iO+GuWnNTcreS6tqsL6qXGvlukyNO4uPxvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDkAQa4mBngYIzCc5VB2h72XClGI+sdfSWifc953HK9ifOas8ccwtZQvI2YWs1qlsYGkWRCX0yoRxRY0mwrNCg4bpO0biP0/NXVuenTHcRVCRl67ZDHBwEp/UvD6AAtC+WsOvXwV75S+dVws1l57pwhiOycny7u2hvxNvu6p+Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=uOv7hYX5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="uOv7hYX5"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso73283075e9.0
        for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 04:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1776080557; x=1776685357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IjMTVS/gOBqHrtAqQ1Hrz/YK4AU6mgf/uKtZN6EAfE=;
        b=uOv7hYX5WVZZ4gLwONF1vdUv6S0Es36G1mL7mQzcs5Hu3i4smBGJ31+mwgyxfgIa+x
         xOD9sPbojAS/U3DgMG05UwdhBr9XpN2W66UvM/a9NpQ9ZdUG/AVTAcFSFH9C/anTpleY
         QIB0pU3dJlHCBgvR9t9wfcvNvkh5CWXQz5s1WagvafV/WrNrsEcaLE4ZVkV7TRiE/HLZ
         uBmJ6ngzFmkvOBEXjhHIz09NIraOppJ5Tinki44S2zZqLhiNEcD6TnLM6Yzi5g9vDXZ8
         fzI8+qqOC7K8WZR0qvimEteIKd/u3A0CNqfOtrTvGg5OFHy2zRnVKsibXDxjCEOMg4Wo
         txFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776080557; x=1776685357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+IjMTVS/gOBqHrtAqQ1Hrz/YK4AU6mgf/uKtZN6EAfE=;
        b=CSNzosIA0bYT4k5/OTEYDoWJ5ACell9TNDlXPb76FBOvetcpkMQ5sRAundcD/ofjlE
         aRG+4KQvxcGwDlXFLKCs21cB8pveKIDWD3c5uchU1M3ds2Q3FZxZF0864I4CdzzqU19G
         kVvnIAdOQSJKgBQBR0YL2Z44S637XHKzr7Zc5fcthVSaf2SSPeFb7AXOF2CCpHgzapAV
         wY/w9ZrDfKZtPUjA/JuM+lwB1d5BfTle24t1unxanQFiaP7JMsHq5sIn37qJOwBr3GT1
         sUbbAMD2rlQSgVuTrwxg2vP90yugOTJgxsPJuXHpyBbtuYpcjjnUq8B0Rx6LPnP7KirC
         vmkQ==
X-Forwarded-Encrypted: i=1; AFNElJ9MMGgfP9PtCHszcgIO+fWGzljTeE3uE9dNnf+OKirKmFP7kKsvmkUVgsG6K6M/BK4Ybqollc6TK8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbtXSqjkSZAR4O7khynCznZRVeAEPgKHI5mi5e+Kc2Q8xpnAKW
	23uIcwnE5Lm/V0vCiOtjewkw+eGHTuRbx1qG5b+el4MkMGYB5G2eUVjHFRKQKwJJc972VVzxKEy
	SysRo4g==
X-Gm-Gg: AeBDies1hIiJBfz2qZqvyrcU4RPGgQvoErQvUmbxYYbxr9LEGHuBdMq+83afzLs69Mh
	n1IQssLH9Tjq7pySvcd7EcgU8+nLvO0Zs+WIUCaDVZDIqeTRjcRQ3k0mZ+Ah24ARSSq7ADsAG0G
	P6BXRXoOnLRvo5Z5cAIobfmj5A6qRl7vtv0wOPKYokJ29kbzhDYeXonkolg1qtvt4BOWCnrqd+2
	HTsVnupH+k0KUl4vWwdhL03b2yX+2zh6dN3r819Gl0BoOneudQF65Wq+1qJKQvcfM3umrQMjQcz
	gF/f5Y5Azh+QY+zBwNPZu2PVKVUZUG1Q62WRj307sCHNhbj78euLXg6GPFmUVQEMQdsW1J/Io/O
	hiGE6qpDHTCl25SF7H37eLCHIVuNGs2xjwArZBb/9H9iJRl5ljOqdkSgPWizJNK7Lj/x9BBU2YV
	jEwqoxQzLmDaba+HmppQC/P3pGTamZjayrNbUBjf/2pdddWq/sMYqIXdRSfBlbCaU5HwlX
X-Received: by 2002:a05:600c:a306:b0:480:20f1:7aa6 with SMTP id 5b1f17b1804b1-488d68607e8mr124377275e9.21.1776080556957;
        Mon, 13 Apr 2026 04:42:36 -0700 (PDT)
Received: from horizon.localdomain ([212.105.128.254])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67b46ffsm126301165e9.6.2026.04.13.04.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 04:42:36 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Rhodes <sean@starlabs.systems>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Ricky Wu <ricky_wu@realtek.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-usb@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: [RFC PATCH 2/2] rtsx_usb: avoid USB I/O in runtime autosuspend
Date: Mon, 13 Apr 2026 12:42:31 +0100
Message-ID: <00a2cae4c8243a39d254edb329b5a76c24d38373.1776080528.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776080528.git.sean@starlabs.systems>
References: <cover.1776080528.git.sean@starlabs.systems>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The runtime autosuspend callback currently queries card status and clears
OCP via USB register accesses.

On some systems this can deadlock runtime PM and leave the USB device
stuck in the "suspending" state.

Avoid issuing USB commands from the runtime autosuspend callback.
Instead, use the last cached card status (updated on successful status
reads) and conservatively assume a card may be present until status is
known.

Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/misc/cardreader/rtsx_usb.c | 11 +++++++----
 include/linux/rtsx_usb.h           |  3 +++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
index c8badd0db87b..727205e84640 100644
--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -336,6 +336,9 @@ int rtsx_usb_get_card_status(struct rtsx_ucr *ucr, u16 *status)
 	if (ret < 0)
 		return ret;
 
+	ucr->card_status_cache = *status;
+	ucr->card_status_valid = true;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(rtsx_usb_get_card_status);
@@ -753,16 +756,16 @@ static int rtsx_usb_suspend(struct usb_interface *intf, pm_message_t message)
 
 	if (PMSG_IS_AUTO(message)) {
 		if (mutex_trylock(&ucr->dev_mutex)) {
-			rtsx_usb_get_card_status(ucr, &val);
+			if (ucr->card_status_valid)
+				val = ucr->card_status_cache;
+			else
+				val = SD_CD | MS_CD;
 			mutex_unlock(&ucr->dev_mutex);
 
 			/* Defer the autosuspend if card exists */
 			if (val & (SD_CD | MS_CD)) {
 				device_for_each_child(&intf->dev, NULL, rtsx_usb_resume_child);
 				return -EAGAIN;
-			} else {
-				/* if the card does not exists, clear OCP status */
-				rtsx_usb_write_register(ucr, OCPCTL, MS_OCP_CLEAR, MS_OCP_CLEAR);
 			}
 		} else {
 			/* There is an ongoing operation*/
diff --git a/include/linux/rtsx_usb.h b/include/linux/rtsx_usb.h
index 54c6ea82bf43..fed695760691 100644
--- a/include/linux/rtsx_usb.h
+++ b/include/linux/rtsx_usb.h
@@ -62,6 +62,9 @@ struct rtsx_ucr {
 	struct usb_interface	*pusb_intf;
 	struct usb_sg_request	current_sg;
 
+	u16			card_status_cache;
+	bool			card_status_valid;
+
 	struct timer_list	sg_timer;
 	struct mutex		dev_mutex;
 };
