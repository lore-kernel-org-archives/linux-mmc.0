From: Grant Grundler <grundler@chromium.org>
Subject: Re: [RFC PATCH 1/1 v6 ]mmc: Support-FFU-for-eMMC-v5.0
Date: Fri, 9 May 2014 11:13:35 -0700
Message-ID: <CANEJEGto9zhNbnhpLtW92vLN_wabMFv2TaX5BHP1UhbmhzMoUQ@mail.gmail.com>
References: <FDD07FEB422EF948A392FDC201AEEAE641188997@SACMBXIP01.sdcorp.global.sandisk.com>
	<CANEJEGvPyHhWDSykx_zdEiA7WOYMkFtDwWjhF9kjo-7+Hp_EYQ@mail.gmail.com>
	<CANEJEGu3e9eMB5qxHXAyWGDbECi4P77sv+SZWr8c9WkKFsd4tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:41321 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757176AbaEISNg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 May 2014 14:13:36 -0400
Received: by mail-ob0-f177.google.com with SMTP id gq1so5083553obb.22
        for <linux-mmc@vger.kernel.org>; Fri, 09 May 2014 11:13:35 -0700 (PDT)
In-Reply-To: <CANEJEGu3e9eMB5qxHXAyWGDbECi4P77sv+SZWr8c9WkKFsd4tw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: Avi Shchislowski <Avi.Shchislowski@sandisk.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>

On Fri, May 9, 2014 at 11:06 AM, Grant Grundler <grundler@chromium.org> wrote:
> follow up on "malformed patch" problem:

Sorry...I'm now confident this patch is white space mangled before it
was generated:

+#define CARD_BLOCK_SIZE 512
+
+/*
+ * eMMC5.0 Field Firmware Update (FFU) opcodes */ #define =

+MMC_FFU_DOWNLOAD_OP 302 #define MMC_FFU_INSTALL_OP 303
+
+#define MMC_FFU_MODE_SET 0x1
+#define MMC_FFU_MODE_NORMAL 0x0

Please fix and repost as V7

After the "---" line I mentioned before, you can say:
V7:
- fixed mangled white space

:)

cheers
grant
