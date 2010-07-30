From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: MMC: [PATCH 0/2] Two fixes for mmc system
Date: Fri, 30 Jul 2010 16:57:27 +0300
Message-ID: <1280498249-6845-1-git-send-email-maximlevitsky@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42007 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758555Ab0G3N5k (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Jul 2010 09:57:40 -0400
Received: by fxm14 with SMTP id 14so862762fxm.19
        for <linux-mmc@vger.kernel.org>; Fri, 30 Jul 2010 06:57:39 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Lee Jones <lee.jones@canonical.com>, Adrian Hunter <adrian.hunter@nokia.com>

Hi,

Here is updated version of fixes I created for mmc subsystem.

First patch is unchanged, and I can say is very well tested.
The second patch that fixes nasty hang that happens if you have MMC card in reader
during suspend.
I updated it to address corner issues that I was told about.

Consider patch #1 for 2.6.36, and patch #2 for 2.6.36 and stable trees

Best regards,
	Maxim Levitsky


