From: Praveen Krishnan <praveen.gk@gmail.com>
Subject: DDR eMMC write failures
Date: Wed, 2 Nov 2011 16:51:03 -0700
Message-ID: <CAHzg1A-7RNthipDredO4KSrC+bM0nqLuhWaw1cveFzzfXd2k3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54221 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419Ab1KBXvF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Nov 2011 19:51:05 -0400
Received: by faao14 with SMTP id o14so942602faa.19
        for <linux-mmc@vger.kernel.org>; Wed, 02 Nov 2011 16:51:03 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello all,

I am working on getting the DDR50 mode up and running for the eMMC
cards.  I am running into some weird CRC error cases.  Initially, I
thought that everything works fine, but when I stress test it with
large amounts of data (more than 100MB of writes), I notice that my
console is spewed with venomous error messages.  I get a CRC error and
every now and then, I also see this message "Got data interrupt even
though no data operation was in progress" and "Buffer I/O error" and
so on.

Can anybody give any pointers as to what could be causing this?

Thanks a lot,
Praveen
