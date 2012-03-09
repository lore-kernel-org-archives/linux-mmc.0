From: Alan Cooper <alcooperx@gmail.com>
Subject: UHS card problem
Date: Fri, 9 Mar 2012 16:53:23 -0500
Message-ID: <CAOGqxeXOiVAbMBoPdd2tQ29UrszgPbjpUtJBDK0ZnmwCgceQeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55473 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755544Ab2CIVxY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Mar 2012 16:53:24 -0500
Received: by vcqp1 with SMTP id p1so1808283vcq.19
        for <linux-mmc@vger.kernel.org>; Fri, 09 Mar 2012 13:53:23 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

I have a 3.0 host controller on a board that only does 3.3V. The
capabilities registers don't specify support for any UHS modes and
also don't show support for 1.8V. When I insert a UHS card the driver
tries to switch to 1.8V and fails to init the card. I was hoping I
could set the CAP registers so that the UHS card would just be run at
HS/3.3V but I don't see a good way to do this in the current driver.
Is this a driver issue or is there a capabilities setting that I'm
missing?

Thanks
Al Cooper
