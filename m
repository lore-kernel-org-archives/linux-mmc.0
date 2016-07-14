From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [bug report] mmc: pxamci: fix card detect with slot-gpio API
Date: Thu, 14 Jul 2016 15:30:51 +0200
Message-ID: <87eg6w2vp0.fsf@belgarion.home>
References: <20160713201407.GA19098@mwanda>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:45228 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbcGNNaz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jul 2016 09:30:55 -0400
In-Reply-To: <20160713201407.GA19098@mwanda> (Dan Carpenter's message of "Wed,
	13 Jul 2016 23:14:07 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-mmc@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> writes:

> Hello Robert Jarzmik,
>
> The patch fd546ee6a7dc: "mmc: pxamci: fix card detect with slot-gpio
> API" from Sep 26, 2015, leads to the following static checker warning:

Hi Dan,

I'm taking that fix, thanks for the report.

By the way, if your mails are "auto-generated", could you amend the generator to
use the format "commit <12+ chars of sha1> ("<title line>")" instead of "patch
xxx", so that we(I) can quote you directly in the commit message ?

Cheers.

--
Robert
