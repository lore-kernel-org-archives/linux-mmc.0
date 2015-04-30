From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Disable and/or RPMB partitions
Date: Thu, 30 Apr 2015 18:34:21 +0200
Message-ID: <CAH9NwWfow0d5Kk=Shj=CQhy0GRVkjvzQEYYVAYEubP2c6xM_ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:35668 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbbD3Qen (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Apr 2015 12:34:43 -0400
Received: by wgyo15 with SMTP id o15so68591368wgy.2
        for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2015 09:34:41 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi all.

Is there a way to disable such partitions via e.g. device tree binding? I had
a quick look at a custom kernel based on 3.14 and support for those
partitions got patched away. How should this functionality be done that
a possible patch hits mainline?

greets
--
Christian Gmeiner, MSc

https://soundcloud.com/christian-gmeiner
