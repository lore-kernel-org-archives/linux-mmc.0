Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BDB24BBEE
	for <linux-mmc@vger.kernel.org>; Sun, 16 Aug 2026 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786894763; cv=none; b=EhlYtU7vAWq3r5Jw5Mgk+LjWudytQQZK24ufBN1QZjgF0X5FWzwcf5jg0pNmDH/onX2zwIQagXUWiWcclP7OXFzy40SPMGTGeinCWy2gsPPeUM4M++yX4a6pryDssvmajKF68oDVScqdODb0elckSjDDN4d21z6dllP2TgKZ8CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786894763; c=relaxed/simple;
	bh=zPX8KBkMZJrT+ze6Vk4oOsowxMMXWy+Jz5rlbiUqD6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rzfSIgtS6DPBwXdkPdZiCUFXqLPwRseW+ihyV24xUl+g3X3q3M3XWgKwRVbQgUKeukgeADOHqGwbtHN5DN5Rlf0M7sRjtbmtl1biFrWL/BOOfBeIG0OeoVi+DC1RQeBwKWYR0z6Fm9W96At47wXu4t0UzjjrdOv5S4AVvZPVQIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRYIKvPA; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRYIKvPA"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f96c5b722so1614536f8f.0
        for <linux-mmc@vger.kernel.org>; Sun, 16 Aug 2026 08:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786894757; x=1787499557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n+AD3yvYtELlzfMYB79Dik4mUEZ2MSC2FzjAo/30HpA=;
        b=CRYIKvPAxhR+4ZpXRB4jrnPB/OQ1Nijvm3/OYOynfQk3Y3+bD/PYRqjM5rfXSaj2QN
         5/SNbK42HmfiVqEf8xI3ZhjR8rEtk4hh0pkZ9pd/9Y4cosXDGM41cxJHxkLRHz1xI+iD
         fj7Z2UEJlGNZZo4+BQUMuOAyjR1W8UJ1bK7Eita+x1d/RTU9DFkB0nEl58bZb5GKA048
         F+2RzouwM4F0nUH+o+OePVOmR2zbwi3c7dIZ02Bhe3PI1TmtqxzSFtirJJzfKdnib1/z
         CIRW9TBlF9rcOvzUBrHSB1dlXAd1tdZuHfTYBFu5VOXii5xFMpdOyZblAimHFnraAdeu
         Hq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786894757; x=1787499557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n+AD3yvYtELlzfMYB79Dik4mUEZ2MSC2FzjAo/30HpA=;
        b=h3pJxaHZuGxcjziey3ZzvWRkhNYoyeJ3QGAsBBMUz7oYuk3LKeP3p3G9J6AihiW4tI
         CLW3ouWkpaouOvVf2tq0DoSoiaeV6iKQU5CTE3iC9NgxcJ9Gtr6DyLrtfLm7U6j9+Qmx
         6DgdfGUC5bX989Ok3+8GqniE2o3kalggjT5SVYb4jKaIXakEiJPQt4BxiplmvPBNdFAA
         aT1SJCNwJSyOqXpi0m5EL01fRzrJ6wssj/6Ee3kKBkYKHgciCuj+wJDmCsUdWg3cToiY
         Ou1wIQRckbdpiUbIGL+lf4YLY8xvHGs6pd/If5j9sh+ZEcziz4R7cTcVdf7TZLXOyY/P
         Xg2g==
X-Gm-Message-State: AOJu0YwowMdXZgqxUATC1brZsBOnQWjrJf0X2uEi6rGDaKlm/yG6VSeh
	IyRKFekE7Ex/bXgIFqm61WK3sBipcxirPT4kSIAHxc0cDp3nHyoR0gW7DHHxGBE=
X-Gm-Gg: AR+sD13wcKOvNdZ2ImFd1hWjEK9CBCNPtlNFPej0FvrAOx+UDC49ZW2i7kiJM3c/Wl9
	JRs9ijWoMMrknwcrhiYqU0ryNdsGoaIGEeBqH0PSVHkx94ddGxr74a99wlgKrhjreiEiYUl6nM9
	61lSgxvq1ROB1/IWwYAg1cZbnR27AnxihKZFdj9GbNJGTtqrpA0P15RG0B15qXZ/qT+PwVGhI+4
	68UNB4z8N9fpErzIRc8MVWe9G+rd0S/gikcLVlJ1XjzYM9Zr5zHEWh4Ai5wpdqQ2bRulMyZTncS
	gKwaDzrlOFlv8nAayxi9ciWWIklmpakyBA1L/py24jE+4fOBJ8FCgouMdRCIpzfKIKhT53PCrDp
	7QJ6RNBDZ8xeiLbKo+6rMzNs0a7SQCJ9DHX0Ikp8jGa5RcO88RwT5LF8TazZS/NHKKfDY5vEJ/2
	9eS47n8RVCKvICU1Se1C7H3ebOU1kN3ducuCCsD6IhaHeG6b1/RbmN8d3tsuRUJS99Wo4iF7tZL
	5lWJw1FjAYRxweGS63UipNkhKgqnV2+dgkHu8qCP0/n6GMh75QJOAktio2QOQ1o3PIbrNlynkmD
	KiwTybt1QIwieks=
X-Received: by 2002:a05:600c:37cd:b0:499:8596:3ba9 with SMTP id 5b1f17b1804b1-499879c279cmr331256545e9.18.1786894757402;
        Sun, 16 Aug 2026 08:39:17 -0700 (PDT)
Received: from archtop.localdomain (92-242-249-15.broadband.mtnet.hr. [92.242.249.15])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999610ddaesm75681475e9.7.2026.08.16.08.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 08:39:17 -0700 (PDT)
From: Jakov Novak <jakovnovak30@gmail.com>
To: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Ulf Hansson <ulfh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jakov Novak <jakovnovak30@gmail.com>,
	syzbot+1ee4f3b9228e35f14677@syzkaller.appspotmail.com
Subject: [PATCH] mmc: vub300: fix sleeping function call from invalid context in vub300_inactivity_timer_expired
Date: Sun, 16 Aug 2026 17:38:09 +0200
Message-ID: <20260816153809.7067-1-jakovnovak30@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 Currently, the function vub300_inactivity_timer_expired, which gets
 called in a softirq context, calls a sleeping function in the following
 call chain:

 vub300_inactivity_timer_expired -> kref_put -> vub300_delete ->
 mmc_free_host -> cancel_delayed_work_sync -> __cancel_work_sync ->
 might_sleep -> BUG

 Fix this by replacing kref_put(&vub300->kref, vub300_delete) with
 vub300_queue_dead_work(vub300), which does the same thing, but in a
 workqueue context.

Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
Reported-and-tested-by: syzbot+1ee4f3b9228e35f14677@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1ee4f3b9228e35f14677
Signed-off-by: Jakov Novak <jakovnovak30@gmail.com>
---
 drivers/mmc/host/vub300.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 2dae474dcd06..df0096bc53db 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -744,7 +744,7 @@ static void vub300_inactivity_timer_expired(struct timer_list *t)
 	struct vub300_mmc_host *vub300 = timer_container_of(vub300, t,
 							    inactivity_timer);
 	if (!vub300->interface) {
-		kref_put(&vub300->kref, vub300_delete);
+		vub300_queue_dead_work(vub300);
 	} else if (vub300->cmd) {
 		mod_timer(&vub300->inactivity_timer, jiffies + HZ);
 	} else {
-- 
2.55.0

