From: Daniel Drake <dsd@laptop.org>
Subject: "Prevent too long response times for suspend" breaks libertas_sdio
Date: Mon, 16 Apr 2012 14:25:02 -0600
Message-ID: <CAMLZHHTTD-jbSrwW9JA_KGxfXj4_WwwC=0KV4PCDHGr25VQ+yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:35917 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755413Ab2DPUZC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Apr 2012 16:25:02 -0400
Received: by dake40 with SMTP id e40so7372191dak.11
        for <linux-mmc@vger.kernel.org>; Mon, 16 Apr 2012 13:25:02 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@stericsson.com

Hi,

This commit breaks libertas_sdio suspend:

commit b6ad726e3fe69e1ff3c3b2ad272ba3e4c376cd6a
Author: Ulf Hansson <ulf.hansson@stericsson.com>
Date:   Thu Oct 13 16:03:58 2011 +0200

    mmc: core: Prevent too long response times for suspend

    While trying to suspend the mmc host there could still be
    ongoing requests that we need to wait for. At the same time
    a device driver must respond to a suspend request rather quickly.

This patch causes the device to be claimed while the driver's suspend
method is called. This seems questionable to me. It should be up to
the driver to deal with or cancel any pending requests in the
interests of suspend performance. Even if they take a while to
complete, it might be best to let them complete rather than discard
the user's data.

In this case in the suspend handler we have to communicate with the
card. In libertas_sdio we do the communication in a workqueue
(because, outside of the suspend routine, sometime we need to initiate
communication from atomic context), but that seems like an
implementation detail that shouldn't be trampled upon by the higher
layers.

This method of punishing "badly-behaved" drivers (for some definition
of the phrase) is also quite harsh. Maybe its just my incompetence but
it took me a couple of hours to track down why my driver was suddenly
hanging with no warning message during its suspend routine.

Can we revisit this?

Thanks,
Daniel
