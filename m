From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: MMC: [PATCH 0/2 v2] Two fixes for mmc system
Date: Sat, 31 Jul 2010 15:37:03 +0300
Message-ID: <1280579825-6174-1-git-send-email-maximlevitsky@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59927 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198Ab0GaMhP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 31 Jul 2010 08:37:15 -0400
Received: by bwz1 with SMTP id 1so840291bwz.19
        for <linux-mmc@vger.kernel.org>; Sat, 31 Jul 2010 05:37:14 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Lee Jones <lee.jones@canonical.com>, Adrian Hunter <adrian.hunter@nokia.com>

Hi,

This is resend of these patches.
Tell me if I don't need to resent the first patch, it doesn't much matter to me.

The second patch is slightly updated to plug last oportunety for a race.
Also fixed accident move of EXPORT_SYMBOL.

Best regards,
	Maxim Levitsky

