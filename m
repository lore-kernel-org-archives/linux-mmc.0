Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE611184
	for <linux-mmc@vger.kernel.org>; Sat, 13 Jun 2026 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781363071; cv=none; b=G7eBh7f7F1SrWXit+NtW6qxsZeYVqcqf3NwKqmdgXMVZx83ylu4+CAk7KAwVypvrA3EJn27R6rXu4tUfuuyAq2YcOJW6wGHs8xAaHOyD0lGD8dS1jzOVT62B7EorpH5goInMFYsDUCuMA+J8Fimk0whjmnJLf1HzKPNLE0mspyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781363071; c=relaxed/simple;
	bh=FZWIC/ANNlk3pJa5/232rPQi9hJuqOerIuY/W2QjpMQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=B9kEgEohYjyy3MR7Z/NppHYP8cGGeDPecnLPtujbNonorU4+ucZhGoOYkMaWWOL4MDT9IEnZABpjY6j9AoIApVMB2J6KJxTlbuk7T6k+S42NXMJRWJyeVrR3euyRIEX9SaLVedAzTmMwk90meynWr+gLYnN4P8mZ2RcL4UPRwZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=c44xqi10; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="c44xqi10"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781363057; bh=fOTP3bjmRt12MV8VmHXfHfHgtPI7ClWlpApAFcwVaTA=;
	h=From:To:Cc:Subject:Date;
	b=c44xqi10lWEUpdDMW2eXCEieJJeA6za5mlzqgG9Qr3wmTJk5eRnTsTot1JcAiLNIT
	 OKnekvVHL2LnwONjpgAfHwpDcCl8lG+hsEj99ZcvtUfKtSwmgHtpGViUj/8Yw7DvMs
	 nwtk57v+cDX+9//rJmkm//PZUsg769XyIXsrRfEc=
Received: from DESKTOP-5G1V1FU.localdomain ([114.216.61.236])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 10F13CAA; Sat, 13 Jun 2026 23:04:15 +0800
X-QQ-mid: xmsmtpt1781363055td3jkjoa4
Message-ID: <tencent_D7DC335840B22B81B4E99D8745DC7E46E205@qq.com>
X-QQ-XMAILINFO: OVXYuPHFASzZTfXaSD8gGPk8txKIe5ZQOUVqnjhZYV/pafVsRNohowd6Bdluci
	 qA/emFehM/dU5HmUyA7vg7erKWbiNYM5WN871B9A3viRT7osqznikDkvkg+JOmUKf47rYMWLcUyw
	 zgnJylppn2k4dYpnRHQGcmBkPa9jPdvoieDfaCsONLuFJDNRoQWxHgCmzqic1dTufRVS9WRt5nyY
	 +nGRBntj91MQ8k2Be2nlUYN4x044IwP1an7uGeCh0NNNtBIOXqQoiRDEc+jrGfrJ/xCzuNujm6s9
	 0T8A0SZGdaxklNIdybqqA7neDgSybgdVtaDdUdrscAdBZ/Y/XPn4bCWsKF8pEk9Dq/x/eZWdU0Xf
	 CzvIdPCMvkWTAXPpasZsZZI6kQ5zmCZ2hRenFwGGXtunVaq8m4OmrVYwbVVoKXK5EGpixuDD5UN5
	 K6PDO/Zkr+MvDz//LxRr0ZJj2g2augIZ+9PUWGufwsIKawye4S/BgLfk5emFP4SBRGMd3dXgDmDN
	 v089FupZidYMSMyVm84fN/F+bL6V75fRsHgH/07j/mAFzZJIGmvJSFuvPcLBkqmHLWickNrz+L+L
	 8CzareY8ryXcIHhsjvirM02e/Coxg6fK6mXTg5Thiw81cSMbEfPmHIuHSmMbRDu/sdVCunXB6p/P
	 TRKxOhUiUjI4E1NVFJIk0Vo0iC0UX0ZEWGAAq6+i6OGUVi3zZ5jDJ8n7E7u+iBWmFeL5rTsVxoLl
	 zsM8tFmLD1EJcnQl3zj5ruvoafn20X3ozMMUzAqjP5s2s4CYUn6EfdqB9ixz+/gZs2foxJP3Jg/V
	 yBPVDYU2LA44kW+cMnGTqSaLxNQ1nSo6BDyGjxlBJ4apiHQR6tpG37QTSUn/n8ATz/DTpxaKIrnI
	 jWmD8p05+44H38kLcdXExnY3fRvrRUkSnsuMAiZV8tmE37KkgbL6h7kmdLdib+tXFv2mG6mOD6J8
	 Z40xWFFnb6dEs6zQVBiBpu9IeiD5MTKFQi6r5T3j7LY7EBT/StVeTN1ZNPEdo3wySklBuUBMjZUC
	 CowCOx/6cQSXTncbgZWdZO4RGTMjWaBdqivjg/Hec0xrWcFys+Sz3CE2lNfr2g9NSRUXyow0SHBq
	 GkNHVdvJ/BHqeGwvfqluGHiDLy48AM/FS3SLRNCIywsEVbTxsezCdluqDNDed08H4cBjfDDXqKLS
	 4WQXn/ObVrvTMn8TDU/GWrfdDMpe0Mg3VNIYByb7J9ISLbyw==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Wei Cheng <wei.cheng.kernel@qq.com>
To: avri.altman@wdc.com,
	ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	Wei Cheng <wei.cheng.kernel@qq.com>
Subject: [PATCH] mmc-utils: lsmmc.c: Add ATP to SD Card Manufacturer ID database
Date: Sat, 13 Jun 2026 23:04:11 +0800
X-OQ-MSGID: <20260613150411.357569-1-wei.cheng.kernel@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current sd_database does not contain an entry for ATP (Manufacturer ID 0x09).
Add it so that lsmmc can correctly identify ATP SD cards.

Verified on ATP AF4GUDI-OEM microSD.

Signed-off-by: Wei Cheng <wei.cheng.kernel@qq.com>
---
 lsmmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lsmmc.c b/lsmmc.c
index e9df5e1..51b50de 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -99,6 +99,10 @@ static struct ids_database sd_database[] = {
 		.id = 0x08,
 		.manufacturer = "Silicon Power",
 	},
+	{
+		.id = 0x09,
+		.manufacturer = "ATP",
+	},
 	{
 		.id = 0x18,
 		.manufacturer = "Infineon",
-- 
2.43.0

