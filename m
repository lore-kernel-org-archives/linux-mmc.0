From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH 0/3] mmc: omap: driver registration cleanups
Date: Thu, 10 May 2012 20:24:37 +0530
Message-ID: <CANrkHUaajRTd3D3QU7pfTRN5cv9QaqYcryOs4YNSYHq-kBkYVw@mail.gmail.com>
References: <1336476935-16564-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:40921 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757139Ab2EJOyk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 May 2012 10:54:40 -0400
Received: by lahi5 with SMTP id i5so1736268lah.14
        for <linux-mmc@vger.kernel.org>; Thu, 10 May 2012 07:54:37 -0700 (PDT)
In-Reply-To: <1336476935-16564-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

On Tue, May 8, 2012 at 5:05 PM, Venkatraman S <svenkatr@ti.com> wrote:
> Cleanups for the legacy omap mmc driver to remove clutter and
> make it well behaved as module.
>
> Venkatraman S (3):
> =A0mmc: omap: convert to per instance workqueue
> =A0mmc: omap: make it behave well as module
> =A0mmc: omap: convert to module_platform_driver

Looks good to me, So
Acked-by: Balaji T K <balajitk@ti.com>

>
> =A0drivers/mmc/host/omap.c | =A0 48 +++++++++++++++------------------=
-------------
> =A01 files changed, 16 insertions(+), 32 deletions(-)
>
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
