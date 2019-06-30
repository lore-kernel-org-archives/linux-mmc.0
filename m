From: syzbot <syzbot+38f5d5cf7ae88c46b11a@syzkaller.appspotmail.com>
Subject: Re: WARNING in kernfs_create_dir_ns
Date: Sun, 30 Jun 2019 03:40:00 -0700
Message-ID: <0000000000003326c1058c8822c7@google.com>
References: <0000000000003ec128058c7624ec@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <0000000000003ec128058c7624ec@google.com>
Sender: netdev-owner@vger.kernel.org
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, gregkh@linuxfoundation.org, hongjiefang@asrmicro.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, tj@kernel.org, ulf.hansson@linaro.org
List-Id: linux-mmc@vger.kernel.org

syzbot has bisected this bug to:

commit 7f38abf220e2c800a2c451372e9f07ed5fd0ea49
Author: Hongjie Fang <hongjiefang@asrmicro.com>
Date:   Tue Jul 31 02:55:09 2018 +0000

     mmc: core: improve reasonableness of bus width setting for HS400es

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=129d6755a00000
start commit:   72825454 Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=119d6755a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=169d6755a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31528e58cc12e2
dashboard link: https://syzkaller.appspot.com/bug?extid=38f5d5cf7ae88c46b11a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a6c439a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1353c323a00000

Reported-by: syzbot+38f5d5cf7ae88c46b11a@syzkaller.appspotmail.com
Fixes: 7f38abf220e2 ("mmc: core: improve reasonableness of bus width  
setting for HS400es")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
