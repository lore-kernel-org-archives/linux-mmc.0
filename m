Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6446946C837
	for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476978; cv=pass; b=aEsTWj5+xXKpc5HZ1HRqNiB9Y9n2zKyek8YW30+PesS6G8So/j6pgq03fm6sKkCAH77Pmy+uMyUD+CzMtwVYh/uUH6Kbe58ouYQP3shj1BL5W8p3vvS3UivvGQ4BG10HdoeV8rT0yeSrsTNaIxeUfBInixsKvoseEO0VW1gFh8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476978; c=relaxed/simple;
	bh=G45gz4HRO+6KZSIAMCGtDzDMNxIckAouWMxsxFyRhbk=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=YftYz7lYQkfwV9icEElPxB/x4NYKQOBap7BX+3VoArLHol/ScZe87COHTLpkH8wn9yAf7nHfA0jajyxPvG0hLZSEil+lBHS1+oOdKkNaiYlyJLBuCTtdD5Od65iJxeruAXAeTBxn2dHzvlwO42JGqqxpbi1EejYBHMkYRuDYaS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPPDu9YA; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPPDu9YA"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c2790ccso1890148f8f.1
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 05:56:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789476974; cv=none;
        d=google.com; s=arc-20260327;
        b=pzIJ+4YYhek51K3lbBgBdVX/R1WZL+B6iS+XrfK4YofJuNEjeqKODXQR207Zgj1W6K
         PwnEb4j1O5o16PXbytfoM+50djRnEXf9aX6ZCfyuVnTAOCHR486l8BcP0Acq5+gdjkUr
         DQvG1AwztN3QLKCWliTuQa+0z3BynGOdCKLHGU/KL7n0fLR+V1iC0JeSxz4YaSt+YACi
         w3S6cRbnb/AYHYWqhgC7DGQSmnKIdy1bzgMdPW0uQlNso2JvJvE82J8VmkgsHBuYDV4W
         F3uwVPWc4gzLyH6/gb4C2woLXNGlbRuw/5HIbcYgruJH9QJDXUQ3bOYPTNH4poNe1/65
         8Mrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=7cxQ1augVVXJ2Uncvf7ebrnaOaWNgpk9a/bP9vGDjRI=;
        fh=pOTmylNT7lu/OVWbsBAf68hUXsCKZBm6nImmg0hETSY=;
        b=ELHYWnDwjfgKYH2E+enuRsLRiIpyucZBopv97QFfgZ5IGUBH4pOSBvPStTd4/DDbFS
         bWTB/57/XVxmIbgiUCPkL7C2hssALEKw1TT/CqW3NjK8aUqGsZfHeQQBl9bbDl1XbUIO
         Vl2/FDCbX8K7VqwaJkAVXBtS8s47QeMuKtFjg2lFEUWeVMWLCWgFslX4/Mldy2csOGGN
         fg5U7xYG22Ftqw93EMGpsEvJSeYAtIhRDUKa81l3v6rvtEMK1hSuZgRGH1+/RkBI2Jdg
         xltbDsEdF8pQo3c876HMVXpRhDqyFbUU7xSDjS4HEhjOkqoi+pf0dC0/1URzoVz1eKVq
         e9LQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789476974; x=1790081774; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7cxQ1augVVXJ2Uncvf7ebrnaOaWNgpk9a/bP9vGDjRI=;
        b=cPPDu9YA1jkrh/qB0znkegqlQ5wGzsuELJQMiFwbjaDS2C7QmxU/qNUm9XRV8Ru7Rj
         wHnHX0JS+fRWbYd41OftAmGacz8QV6ZslnoutntVSA7uveDEJrOCS4gpRvHqK9HW3kBW
         LaUfYjjHE4M/JGYbW3xX55SvXm7isLrMa5CJLMs1opOKuNq8wcYHFZtloMsW6oQo3gSP
         2QzmQrjub/mprXcAm6foh/YlZ7314o3xXWnfgpZiOL6tXpBkKBSmdItugMWiGI57ylmQ
         yx8SdM5+LLaKWErxWemujTLl8DAt5UbrrxmM3coFyhT6t87Q1lVKLmE9o7RgNHbpka/i
         cmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789476974; x=1790081774;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7cxQ1augVVXJ2Uncvf7ebrnaOaWNgpk9a/bP9vGDjRI=;
        b=jEOJVhrAAQEuScg1NwopsC9pADN4rN4y17f4vTuPUMXmFo8bTggcSC4o20AvNDRiep
         pKYFLmvzubyNjDVo3vvA96Jlp4zShKQ6LsmNxeLZFNJOv5pc/pq4SOb5fr9UasEciipz
         t0cO52NQ8U7NpHU+95bR/SKmWKNpYxfe27r8yB4uM49ss2eKIux1JZRwK/OO5N+qsU24
         aE0w1KBko0p2k408H4TE8qGnOK81jt89+QwMKD6KSmY8IR5mSWS5g0u009TycFrHmh0l
         j/mnBSjY43qrtYT/dHHmQp+s4xhfq+73fIyQF+dQHNjazT0pMHOQ3jlhw1k2SORHYJGo
         wTsQ==
X-Gm-Message-State: AFuF++mY2tiYXzPMNtS5sv3riQuzG0P0rt/BdD2AbcUtxhpgtgQZJSqc
	qkTgxpAHTKk36NoEsrW6pBXGI3cbZXgs+3vNyojwr1gTQvkTysvuDJjFB44M2uSRrBCvNIWCWwV
	UZP45oNgYTcPcZHAbxFwFAklHEzhslNcnenK+q8Qg87kA
X-Gm-Gg: AYBFou3/9UxRXEsY6KzQacPopWbu5nH5G8lKTJv/+XHH4we+GA5Ym/sPhxeieqUml6V
	RSaa67XKFz1iHJyqqRAda2OfJe2Z5lmt2Nl3EWNrZfnBjLTE1NcPrXrWoSmVX04j8mariWJ2y1Y
	8Lkc09KbgCQOopvOezXTtbYOgM0omdU6DPq2/13bKnjr/7BAMtpbeNFP2MVYE4IBfp4J4b/5VVA
	SbPt7VI3CKSVgS1QurV7Cx4xpwpEuTz33+8wRIU/0iOxNSrrX6fu9wND9MpkJ5H+M9MaPYtC1On
	STnMbR+jqtIqgN51KTewUcWFJ3S28UKiRzqH5FJyRP0XhSaaaL2+GA==
X-Received: by 2002:a05:6000:4283:b0:487:931:946c with SMTP id
 ffacd0b85a97d-48709319585mr4936546f8f.1.1789476974175; Tue, 15 Sep 2026
 05:56:14 -0700 (PDT)
Received: from 830778650420 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 05:56:12 -0700
Received: from 830778650420 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 05:56:12 -0700
From: Ruslan Vagner <rusya92266@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Sep 2026 05:56:12 -0700
X-Gm-Features: AcwNN1X4X4ISWTGG-AECQh8RQIOlKoL9uWtwoE2Gxtc5DIvASRDHh2XMVhF3wAE
Message-ID: <CAF9RqJ4USGg6G9=X=YQ3Rtg11YS5aPBE+RrejdYfcJB8Td4-wg@mail.gmail.com>
Subject: [PATCH] memstick: ms_block: rename misspelled sucessfuly_* parameters
To: linux-mmc@vger.kernel.org
Cc: maximlevitsky@gmail.com, oakad@yahoo.com, ulfh@kernel.org, 
	Ruslan Vagner <rusya92266@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Rename sucessfuly_written/sucessfuly_read to
successfully_written/successfully_read in msb_do_write_request()
and msb_do_read_request(). Both functions are static and callers
pass the arguments positionally, so the rename is local to this file.

Signed-off-by: Ruslan Vagner <rusya92266@gmail.com>
---
 drivers/memstick/core/ms_block.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index ce33907bfc24..133282c2744c 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -1812,11 +1812,11 @@ static int msb_init_card(struct memstick_dev *card)
 }

 static int msb_do_write_request(struct msb_data *msb, int lba,
-	int page, struct scatterlist *sg, size_t len, int *sucessfuly_written)
+	int page, struct scatterlist *sg, size_t len, int *successfully_written)
 {
 	int error = 0;
 	off_t offset = 0;
-	*sucessfuly_written = 0;
+	*successfully_written = 0;

 	while (offset < len) {
 		if (page == 0 && len - offset >= msb->block_size) {
@@ -1830,7 +1830,7 @@ static int msb_do_write_request(struct msb_data
*msb, int lba,
 				return error;

 			offset += msb->block_size;
-			*sucessfuly_written += msb->block_size;
+			*successfully_written += msb->block_size;
 			lba++;
 			continue;
 		}
@@ -1840,7 +1840,7 @@ static int msb_do_write_request(struct msb_data
*msb, int lba,
 			return error;

 		offset += msb->page_size;
-		*sucessfuly_written += msb->page_size;
+		*successfully_written += msb->page_size;

 		page++;
 		if (page == msb->pages_in_block) {
@@ -1852,11 +1852,11 @@ static int msb_do_write_request(struct
msb_data *msb, int lba,
 }

 static int msb_do_read_request(struct msb_data *msb, int lba,
-		int page, struct scatterlist *sg, int len, int *sucessfuly_read)
+		int page, struct scatterlist *sg, int len, int *successfully_read)
 {
 	int error = 0;
 	int offset = 0;
-	*sucessfuly_read = 0;
+	*successfully_read = 0;

 	while (offset < len) {

@@ -1865,7 +1865,7 @@ static int msb_do_read_request(struct msb_data
*msb, int lba,
 			return error;

 		offset += msb->page_size;
-		*sucessfuly_read += msb->page_size;
+		*successfully_read += msb->page_size;

 		page++;
 		if (page == msb->pages_in_block) {
-- 
2.54.0.windows.1
