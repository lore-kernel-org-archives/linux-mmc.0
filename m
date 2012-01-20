From: "Giuseppe D'Agostino" <gdagostino79@gmail.com>
Subject: EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
Date: Fri, 20 Jan 2012 16:06:54 +0100
Message-ID: <CALJWcL9aHD0iQ-K4snho=KthB1OGbZ9ujaike7V8knkwZq+qRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:37564 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753532Ab2ATPGy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2012 10:06:54 -0500
Received: by obcva7 with SMTP id va7so810582obc.19
        for <linux-mmc@vger.kernel.org>; Fri, 20 Jan 2012 07:06:54 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

after a series of mmc stress test on my device, based on ARM
architecture, I noted, launching command dmesg, that it's present this
warnings:

EXT3-fs warning: maximal mount count reached, running e2fsck is recommended

Now, it's normal because, probably, I passed "max mount counts", that
is 30 for default, but my question is:

For this memory's type which is a right limit before execute e2fsck on
partition? It's only a formal problem or is necessary, some other
time, execute an fsck on device?

Regards
