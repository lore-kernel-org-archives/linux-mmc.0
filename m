From: Daniel Drake <dsd@laptop.org>
Subject: Re: -ENOSYS suspend-powerdown regression
Date: Sat, 4 Jun 2011 10:50:54 +0100
Message-ID: <BANLkTi=xd=ygHDZDO2XuGR6hMMaXHfdefg@mail.gmail.com>
References: <BANLkTimdp2n1qhLQmTk+k_M5_WowhJqPyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58711 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334Ab1FDJuy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Jun 2011 05:50:54 -0400
Received: by pzk9 with SMTP id 9so1148504pzk.19
        for <linux-mmc@vger.kernel.org>; Sat, 04 Jun 2011 02:50:54 -0700 (PDT)
In-Reply-To: <BANLkTimdp2n1qhLQmTk+k_M5_WowhJqPyQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

On 30 May 2011 15:26, Daniel Drake <dsd@laptop.org> wrote:
> Hi,
>
> The libertas_sdio driver has a suspend routine which returns -ENOSYS
> when the card should effectively be removed and powered during
> suspend, to be re-probed during resume.
>
> This is broken in linus master. Everything appears somewhat normal
> going down into suspend:

Never mind - this still works in linus master. It just fails when I
enable runtime power management, another thing I'm working on. I'll
look closer.

Daniel
