Return-Path: <SRS0=WBH1=6A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C07FC2BA19
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 00:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C8412076D
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 00:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391381AbgDPALK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 20:11:10 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:42347 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391360AbgDPALG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Apr 2020 20:11:06 -0400
Received: by mail-il1-f199.google.com with SMTP id l16so7311033ilf.9
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 17:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fpoqVPhszf0NVg05C+Ce87uumBc0cG0RasYX5KRrK/A=;
        b=sYp9XGddRrJMDS/UxOWAzdXCCSN0Kxk+WO6u4C2r/O1ROUDIYZoTgXMMmSlN9uLLs0
         abpInjjnD3s9BAVm7B2R6WTqpkeHobL5UfSboznFPdjod68nFtfZ391DPqcB9wTPVgV1
         uHTRCfY0fju47aAq88dchLqQgUCv7uu64XwFB66kk2hJ/w66hWNCuTAlFGcWp1+qnNTp
         Tx1x6TX4PbLQhW4yR6PYcCDk2WyqZoQHIiySRWtxh9Hrw/rQmMYJa0uwrfecVUI7XtVw
         11i/bnAGs+84P9UQMObcwPszBuLeJv1Pnnf8l/KCIcxA7NTjJb90532pBG+RHfo8K+NU
         sWqg==
X-Gm-Message-State: AGi0PuY0Isp7IN8DLFI/MHrZEpDO3BONyfCIlCCRJ3vouUfRqlAbN2Jk
        UdnNPyS7/b2dVX3PpVpE4DwhdkoYmkDvTLAMv2RX7jnksxyw
X-Google-Smtp-Source: APiQypKcCgI3/2owP+Ax+avsl/BzFIkiA31xvFAOZDOMymkWaDm+4dJSPNPqeM8Ut+RNphNBCe4mDPpNDLKfGAmGhhXHK5QOcm+K
MIME-Version: 1.0
X-Received: by 2002:a02:7b05:: with SMTP id q5mr28919026jac.105.1586995863913;
 Wed, 15 Apr 2020 17:11:03 -0700 (PDT)
Date:   Wed, 15 Apr 2020 17:11:03 -0700
In-Reply-To: <0000000000003ec128058c7624ec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba8e5605a35d4465@google.com>
Subject: Re: WARNING in kernfs_create_dir_ns
From:   syzbot <syzbot+38f5d5cf7ae88c46b11a@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, gregkh@linuxfoundation.org, hdanton@sina.com,
        hongjiefang@asrmicro.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, longman@redhat.com,
        mareklindner@neomailbox.ch, mingo@kernel.org,
        netdev@vger.kernel.org, peterz@infradead.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com,
        tj@kernel.org, ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 810507fe6fd5ff3de429121adff49523fabb643a
Author: Waiman Long <longman@redhat.com>
Date:   Thu Feb 6 15:24:08 2020 +0000

    locking/lockdep: Reuse freed chain_hlocks entries

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1008138be00000
start commit:   72825454 Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31528e58cc12e2
dashboard link: https://syzkaller.appspot.com/bug?extid=38f5d5cf7ae88c46b11a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a6c439a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1353c323a00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: locking/lockdep: Reuse freed chain_hlocks entries

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
