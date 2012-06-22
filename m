From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 02/11] mmc: omap: add clk_prepare and clk_unprepare
Date: Fri, 22 Jun 2012 23:53:33 +0530
Message-ID: <CANfBPZ-YpupgvzPcJsqZpG4QOErw6kqBNWjP2GL5teDwU+wbBA@mail.gmail.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com> <1340372890-10091-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:57639 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754275Ab2FVSX4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jun 2012 14:23:56 -0400
Received: by bkty5 with SMTP id y5so1939214bkt.2
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jun 2012 11:23:54 -0700 (PDT)
In-Reply-To: <1340372890-10091-3-git-send-email-rnayak@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: paul@pwsan.com, mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Balaji T K <balajitk@ti.com>, linux-mmc@vger.kernel.org

On Fri, Jun 22, 2012 at 7:18 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
> and clk_unprepare() for the mmc and hsmmc clocks as part of the drivers
> probe() and remove() routines.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Balaji T K <balajitk@ti.com>
> Cc: <linux-mmc@vger.kernel.org>

Rajendra,
  Can this be applied independently, or does this patch have a
dependency on other patches in the series ?
