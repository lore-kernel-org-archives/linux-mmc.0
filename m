From: =?ISO-8859-1?Q?Marc=2DAndr=E9_H=E9bert?=
	<hebert.marcandre@gmail.com>
Subject: Stopping mmc clock between transfers
Date: Tue, 24 May 2011 14:42:32 -0400
Message-ID: <BANLkTikbm_OjtwB4fhwj1Mc0HAsNPH3CVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35847 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757287Ab1EXSmc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 May 2011 14:42:32 -0400
Received: by ywe9 with SMTP id 9so2528049ywe.19
        for <linux-mmc@vger.kernel.org>; Tue, 24 May 2011 11:42:32 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>

Hello,

We are using a OMAPL108 with 2.6.33 and noticed that the mmc clock
signal stays active when idle. This doesn't seem very power efficient
and we wondered if there was a reason for this. Before trying to fix
this on our side I had a few questions regarding this:
-Is this behavior the same in more recent versions?
-Was this designed to be this way?
-Would stopping the clock be a responsibility of the core (set_ios) or
the host controller (between requests)?

Regards
Marc
