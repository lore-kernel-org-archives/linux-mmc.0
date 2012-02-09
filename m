From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Reason for Cmd 9 giving a timeout Error
Date: Thu, 9 Feb 2012 18:51:53 +0530
Message-ID: <CANYdXnqjzkCQPYZXR2DgQOvm5g_x3BTp7VgWhwVvuAXqQxVTPQ@mail.gmail.com>
References: <CANYdXnpypBuAbTM6XdzESvZNfsgoQsqJaQ2NgHHsm7BGZv7fSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58916 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030Ab2BINVy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Feb 2012 08:21:54 -0500
Received: by yhoo21 with SMTP id o21so797352yho.19
        for <linux-mmc@vger.kernel.org>; Thu, 09 Feb 2012 05:21:53 -0800 (PST)
In-Reply-To: <CANYdXnpypBuAbTM6XdzESvZNfsgoQsqJaQ2NgHHsm7BGZv7fSQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Uma Bali <uma.bali@freehostcell.com>

Hi ,
=C2=A0 I was testing the davinci mmc driver. For some reason, during th=
e
enumeration sequence, I keep getting the TIMEOUT interrupt while
sending CMD 9. Any idea on what could be the reason ?


--
regards,
Shashidhar Hiremath
