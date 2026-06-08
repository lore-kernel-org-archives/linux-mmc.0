Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B663B7756;
	Mon,  8 Jun 2026 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912542; cv=none; b=S4QLUFVkz3cVriu+JMEtV7HsxkS9DWP0n6nnMapk+wb9lv+uVziiJXQRCWHCbZiAjr/9zoRESbbZWQKML5geaRLWP+GBPnwaUOpGifbp+rDf7LiFspZryohWjdQXO3kWRljNwIstIUfu4byWqt3yIF8JvmM1WnImdBexpmwEk7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912542; c=relaxed/simple;
	bh=kHDT9UI/MF/PwKXV9AKQCSxPRwS2SKEIu/TTba++JWY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K1jKx72MPylm1iKWR6St0SaNmumxCWvXX0572LnaTK5284kLNbPmgr3dWAtzAzUZkPzcLh6UMKIsEaUIG3NpdSvCH5w+nF6oVFKXffoZZUdwsOgsEkgZhg7/+2zj4X5NkDV8xbnz6JkRwNdnlNqwVIvEpTMRvPaiA1mYmHoWpgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=jHw1UAwv; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="jHw1UAwv"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhm-00BRvh-08; Mon, 08 Jun 2026 11:55:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=uydt15weqMjJvnlFN3Qml4jh7dvovhqQDGex0eQL2BE=; b=jHw1UA
	wvUf7pGeAJnnaua/NLV/VMu7pwzeufhjNUfZU0YL90nDj8mk0u4b8FmGofkpDhoCDcCFps17GHS+g
	M4RFcE21Vhi/pEosyrV9h8jJgbvjvhRXW6hFPrc0mvgFRWfWzhg6hQruUelVIg9OgbLFeRkMm86wt
	GPurUjQnVg9c8UE56fkJ6gkMDmYHQdtYVlmWQWXd9tGn6CwsSfRuIw2KRQ3ACTVqBqqbHuWqfJjsO
	0I/ZzQeV3hJ1cHLkZW3GRjpFv8JgUYN0mjP9NaIhm6PitaT+4bFKahK3Fpls1TLIPrV5nY9Qn2Bmd
	uMAao2uCP1vZ2volTae1SEWJDlMQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhl-0003bE-8L; Mon, 08 Jun 2026 11:55:37 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhh-00Ag6G-7M;
	Mon, 08 Jun 2026 11:55:33 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/mmc/core/sdio_cis: Replace strcpy() in loop with memcpy() outside
Date: Mon,  8 Jun 2026 10:55:03 +0100
Message-Id: <20260608095523.2606-19-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

When copying the info strings and generating a char ** list copy all the
strings into the kmalloced buffer outside the loop and use strchr(str, 0)
to find the next string inside the loop.

Removes some strcpy() that static tools might think are unbounded.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 drivers/mmc/core/sdio_cis.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
index afaa6cab1adc..0b818cb478ce 100644
--- a/drivers/mmc/core/sdio_cis.c
+++ b/drivers/mmc/core/sdio_cis.c
@@ -57,12 +57,11 @@ static int cistpl_vers_1(struct mmc_card *card, struct sdio_func *func,
 		return -ENOMEM;
 
 	string = (char*)(buffer + nr_strings);
+	memcpy(string, buf, size);
 
 	for (i = 0; i < nr_strings; i++) {
 		buffer[i] = string;
-		strcpy(string, buf);
-		string += strlen(string) + 1;
-		buf += strlen(buf) + 1;
+		string = strchr(string, 0) + 1;
 	}
 
 	if (func) {
-- 
2.39.5

