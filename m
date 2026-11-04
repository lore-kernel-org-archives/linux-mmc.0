Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793795624;
	b=VEYYwWb84z0b8pw/7+3tN6gGnMGG0cQEkZWKql0F/KzTZl6TYyHMyRRGuFq3brqmoqrk
	 RtZljpbeUvYs4RTMp7L7A6pM9f0kO+le4n2Hk66OsoZ1/5/51BH03VLLhX32sBhKtFvNY
	 wXEceXEzzhNPoARoiZCZKO4kU3pMMhL0xLt74i9MJcK0k0haP6/o8ip9fz+6ENKad/Osj
	 kK14VZXk11D+HjTHcp70lVDtJW3DFD0zqZ9aVtkFGCCdF1sYhUW1PAZk4DYKvlCrdRMgs
	 TeM2OV7vZ1hZLWhk6uJ6kt0VgboKiVWUdfqsj91ty+i+MK7YlezVnjQemRi9qnW0Enw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793795624;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=9AR0FOiJM2KreFj6NgsWrS5suCUEQHylQP6yJIgXQu8=;
	b=HOmPA/3NcSpI3Wcvak23o/ACKWRZhfCd9mGIXLIlavMmEWK23LEaqEiucdkVXGP5xiNa
	 2HcZP/s/o20P3CTRQpYZP/DVdoTdUeSz82xDQjk3Ah3/6+gGoV9AcAPx+vJpfKQJTJ+wi
	 29iG7ZErrkyg4U7QIJd+RqrZG/HQ0Sd9LLkulxx9tHfjDsTXlmWhVgNpRivuxJQeDlWPI
	 y7CXH2x5bX/wPIW8hrZrN1E1YHOwK2j5sBhLh8uhnd+JM2N9rk0HzDnzj2WVJCXvpItM5
	 Ngfpp+NjErHK7shHfzOQToLhmkp98f5XRwgC/+OjD9mbO2VAUUk2D8Jcw47FGXS/kbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDCE606A338
	for <linux-mmc@vger.kernel.org>; Wed,  4 Nov 2026 12:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CDCE606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4e778acdbc6so994359b6e.3
        for <linux-mmc@vger.kernel.org>; Wed, 04 Nov 2026 04:33:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793795623; x=1794400423;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9AR0FOiJM2KreFj6NgsWrS5suCUEQHylQP6yJIgXQu8=;
        b=bxQtDCpzJHwgrvCMT5xae4Wp7kL/pMj7HMgkpW46YdBnAdufriJhjHvtHGmNTQoVMs
         AD+WqU2HfcfxNPV/grxS411mBWkyjLrry9UWtveMaP4vZdBS/uwzwklesj6pLp9u5ZJI
         woQCApRo+JnaXyKHeXds5d7zvXiFG83yyVOtASnpVz9SCWjsnptpdNWjOY3LNbhqnfMR
         GenJ8vAIvwAaTJef3TEdDH70zqsQm/LKh/uSuz0uEhlREq7rsPzw2WLAtwlEKKGjd9/L
         AbUu1Van/6ie4KF1e0QVa01ursdgl1wMU1IAMm07r4TZ8oPm7Qh4V5NmVwUnyOm8kHdn
         ImUA==
X-Forwarded-Encrypted: i=1; AKwUvBxAgQNBNc1Kg1UhPpufpY0szEETBdjY2AZv1jjx1lANKjMyI3uVifwUF7HdrJs1IkSdc2qUkocuvEs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+by/rdJKt3nuUe2s/kO+CAisxQUaegVNsUyAfX50dAJMSUJsNl
	NeA8xCDn8N4QPTqV+7fFle/tEKfgyQYAOCHWMIfG1IhAtsan3j+XB5lOclUUX9UvX+riZaubn/W
	z9As1HkJzmMeW/hz58tblBXuYRSN2ElSUdTMemw/4MW6DV8FRH+DnGBRwMo8=
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2218:b0:53c:2a2e:8650 with SMTP id
 5614622812f47-5640df72f37mr10852091b6e.34.1793795623537; Wed, 04 Nov 2026
 04:33:43 -0800 (PST)
Date: Wed, 04 Nov 2026 04:33:43 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aeb2627.92bb9006.66ae5.0001.GAE@google.com>
Subject: [syzbot] Monthly mmc report (Nov 2026)
From: syzbot <syzbot+listf70463e198a0b7fdf0d0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, ulfh@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello mmc maintainers/developers,

This is a 31-day syzbot report for the mmc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/mmc

During the period, 1 new issues were detected and 0 were fixed.
In total, 16 issues are still open and 1 has already been fixed.
There is also 1 low-priority issue.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1156    No    INFO: task hung in mmc_stop_host
                   https://syzkaller.appspot.com/bug?extid=d0688023306aea3aefdc
<2>  675     Yes   KASAN: slab-use-after-free Read in rtsx_usb_ms_handle_req
                   https://syzkaller.appspot.com/bug?extid=3ee5da0319ca17ef1f4e
<3>  515     No    INFO: task hung in sdio_reset
                   https://syzkaller.appspot.com/bug?extid=e8678cd3d8b65d1f2c74
<4>  496     No    WARNING: suspicious RCU usage in cancel_delayed_work_sync
                   https://syzkaller.appspot.com/bug?extid=9c1988bc953fca2086a3
<5>  252     No    INFO: task hung in mmc_go_idle
                   https://syzkaller.appspot.com/bug?extid=bb55e8118af00556efa2
<6>  110     Yes   WARNING: ODEBUG bug in vub300_disconnect
                   https://syzkaller.appspot.com/bug?extid=f4a0159ce6802a0a4774
<7>  109     No    INFO: task hung in mmc_send_if_cond_pcie
                   https://syzkaller.appspot.com/bug?extid=30341f17551668478919
<8>  99      No    INFO: task hung in mmc_send_io_op_cond
                   https://syzkaller.appspot.com/bug?extid=15adedb55f72fa957b00
<9>  96      No    INFO: task hung in mmc_io_rw_direct_host
                   https://syzkaller.appspot.com/bug?extid=fd993974345f022e97f2
<10> 50      No    INFO: task hung in mmc_app_cmd
                   https://syzkaller.appspot.com/bug?extid=c6d8091b47243f2023b8

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
